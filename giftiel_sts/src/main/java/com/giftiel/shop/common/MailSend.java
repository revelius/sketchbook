package com.giftiel.shop.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.giftiel.shop.dto.MailManage;
import com.giftiel.shop.service.ManageService;
@Component
public class MailSend{
	
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${local.upload.path}")
	private String localPath;
	@Value("${dev.upload.path}")
	private String devPath;
	@Value("${real.upload.path}")
	private String realPath;
	
	@Value("${upload.image.path}")
	private String imagePath;
	@Value("${upload.excel.path}")
	private String excelPath;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	
//	@Autowired
	private JavaMailSender mailSender;
	
	
	@Autowired
	private ManageService manageService;
	
	/**
	 * 메일폼 전송용
	 * @param
	 * toNm -메일 전송 대상이름
	 * to -메일 전송 대상
	 * mapParam - 이메일폼 전송 파라미터 hashMap형태로 key,value 저장하면 폼에 파라미터로 전달
	 * formKind - 이메일 폼 종류(memRegister:회원가입,ordComp:주문완료,payComp:결제확인,shippComp:배송완료,ordCancel:취소,ordReturn:반품,ordChange:교환)
	 * @return
	 * int
	 **/
	
	public int sendMail(String toNm,String to,HttpServletRequest request,HashMap<?,?> mapParam, String formKind) throws Exception {
		MimeMessage message = mailSender.createMimeMessage();
		int result = 1;

		to = StringUtils.strip(to);
		
		if("GUEST".equals(to)){
			return result;
		}
		
		StringBuffer uri = new StringBuffer("/mail/"+formKind);
		String subject ="";
		String from ="customer@worksout.co.kr";
		
		
		if(formKind.equals("memRegister")){ //회원가입
			subject = "[웍스아웃]반갑습니다. 회원가입이 완료되었습니다.";
		}else if(formKind.equals("ordComp")){ //주문완료
			subject = "[웍스아웃]감사합니다. 주문이 완료되었습니다.";
		}else if(formKind.equals("payComp")){ //결제확인
			subject = "[웍스아웃]"+toNm+"님, 웍스아웃에서 주문한 내역을 확인하였습니다.";
		}else if(formKind.equals("shippComp")){ //배송완료
			subject = "[웍스아웃]"+toNm+"님, 주문한 내역을 배송처리 중입니다.";
		}else if(formKind.equals("ordCancel")){ //취소
			subject = "[웍스아웃]"+toNm+"님, 주문한 내역을 취소처리 하였습니다.";
		}else if(formKind.equals("ordReturn")){ //반품
			subject = "[웍스아웃]"+toNm+"님, 주문한 내역을 반품처리 하였습니다.";
		}else if(formKind.equals("ordChange")){ //교환
			subject = "[웍스아웃]"+toNm+"님, 주문한 내역을 교환처리 하였습니다.";
		}
		
		
//		uri.append(".do?");
		uri.append("?");
		
		String contextPath = request.getScheme() + "://" +  request.getServerName();
		
		
		StringBuilder parameter = new StringBuilder();

		Set<?> set = mapParam.keySet();
		Iterator<?> it = set.iterator();
		
		while(it.hasNext()){
			String key = (String)it.next();
			if(key != null){
				parameter.append("&"+key+"="+mapParam.get(key));
				//sb.append("&"+key+"="+(new String(((String)hm.get(key)).getBytes("8859_1"), "UTF-8")));
			}
		}	
		
		String htmlContent = "";
		try {
            message.setSubject(subject, "UTF-8");
//            String htmlContent = getHTML("http://www.naver.com");
            htmlContent = getHTML(contextPath+uri+parameter);
            //String htmlContent = "테스트메일 발송";
            message.setText(htmlContent, "UTF-8", "html");
            message.setFrom(new InternetAddress(from));
            
            message.addRecipient(RecipientType.TO, new InternetAddress(to));
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            result = 0;
        } catch (MailException e) {
            e.printStackTrace();
            result = 0;
        } finally{
        	MailManage mailManage = new MailManage();
        	mailManage.setSndrEmail(from);
        	mailManage.setRcvrEmail(to);
        	mailManage.setTitle(subject);
        	mailManage.setTxtHtml(htmlContent);
        	mailManage.setSndrName(toNm);
        	mailManage.setTmplUrl("");			// 템플릿URL
			mailManage.setUpdrNo(100001);		// 작성자
			mailManage.setRegrNo(100001);		// 작성자
			mailManage.setRsvTgGb("CM01201");	// 개별발송
			mailManage.setRsvTg("0");			// 수신대상
			
			manageService.insertSndMail(mailManage);
        }
		
		return result;
	}
	
	/**
	 * 
	 * @param
	 * mailSender
	 * subject
	 * from
	 * to
	 * filePath
	 * fileName
	 * @return
	 **/
	 
	public int sendMailFile(JavaMailSender mailSender,String subject,String from,String to,String txt,String filePath,String userName) throws Exception {
		
		MimeMessage message = mailSender.createMimeMessage();
	
		int result = 1;

		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setSubject(subject);
			messageHelper.setText(txt,true);
            messageHelper.setFrom(from, "");
            messageHelper.setTo(new InternetAddress(to, userName, "UTF-8"));
            
            DataSource dataSource = null;
            String svrPath = null;
            
        	if("LOCAL".equals(serverSetting)){
        		svrPath = localPath;
        	}else if("DEV".equals(serverSetting)){
        		svrPath = devPath;
        	}else if("REAL".equals(serverSetting)){
        		svrPath = realPath;
        	}

        	if (!filePath.equals("") && !filePath.equals(null)) {					
	            String[] splitFilepath = filePath.split(",");
	        	
	            for (int i=0; i < splitFilepath.length; i++) {
	            	dataSource = new FileDataSource(svrPath + imagePath + splitFilepath[i]);
	            	String fileName = splitFilepath[i].substring( splitFilepath[i].lastIndexOf('/')+1, splitFilepath[i].length());
	            	
	                messageHelper.addAttachment(MimeUtility.encodeText(fileName, "UTF-8", "B"), dataSource);
				}
	            mailSender.send(message);
			}else{
				mailSender.send(message);
			}
            
        } catch (MessagingException e) {
            e.printStackTrace();
            result = 0;
        } catch (MailException e) {
            e.printStackTrace();
            result = 0;
        }
		
		return result;
	}
	
 
 
	public String getHTML(String urlToRead) {
		
		
        URL url; // The URL to read
        HttpURLConnection conn; // The actual connection to the web page
        BufferedReader rd; // Used to read results from the web page
        String line; // An individual line of the web page HTML
        String result = ""; // A long string containing all the HTML
        try {
           url = new URL(urlToRead);
           conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("GET");
           rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
           while ((line = rd.readLine()) != null) {
              result += line;
           }
           rd.close();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return result;
     }
}


