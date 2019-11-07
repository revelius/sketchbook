package com.giftiel.shop.controller.common;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dreamsecurity.crypt.MsgCrypto;
import com.giftiel.shop.common.MailSend;
import com.google.gson.Gson;




@Controller
@RequestMapping("/front/auth")
public class AuthController extends FrontController{

//	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MailSend MailSend;
	
	
	@Value("${auth.rtn_url}")
	private String authRtnUrl;
	
	@Value("${auth.certPath}")
	private String authCertPath;
	
	@Value("${auth.keyPath}")
	private String authKeyPath;
	
	
	@Value("${auth.keyPwd}")
	private String authKeyPwd;
	
	
	@Value("${auth.path}")
	private String authPath;
    
    
    /**
     * 인증시작
     * @param urlCode
     * @param locale
     * @param model
     * @param request
     * @param response
     * @throws Exception
     */
	@RequestMapping(value = "/getAuth" , method = RequestMethod.POST)
	public void getAuth(
			@RequestParam(value="urlCode" , required=false , defaultValue="01001") String urlCode,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		
		//날짜 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String reqdate = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }
		//reqNum은 최대 40byte 까지 사용 가능
        String reqNum = reqdate + randomStr;
        
        
        
        
        
        //요청번호 쿠키 생성
        Cookie cookie = new Cookie("reqNum", reqNum); 
        cookie.setMaxAge(60*60*24*15); 
        cookie.setPath("/");           
        response.addCookie(cookie);
        System.out.println("reqNum 쿠키 생성 : " + reqNum); 
        
        
        
        MsgCrypto mscr = new MsgCrypto();

    	String reqInfo    = "";
    	String encReqInfo = "";
    	String rtn_url = "";

    	reqInfo = urlCode + "/" + reqNum + "/" + reqdate;  //암호화 시킬 데이터 '/'로 구분해서 합친다.
    	encReqInfo = mscr.msgEncrypt(reqInfo,authCertPath);
    	//msgEncrypt(암호화 시킬 값, 인증서 경로);

    	rtn_url = request.getScheme()+"://"+request.getServerName() + authRtnUrl;      // 본인인증 결과수신 받을 URL
        
        
        HashMap<String, Object> map = new HashMap<String, Object>();
        
       
        map.put("clntReqNum", reqNum);
        map.put("reqdate", reqdate);
        map.put("reqNum", reqNum);
        
        
        map.put("cpId", "worksout");
        map.put("encReqInfo", encReqInfo);
        map.put("rtn_url", rtn_url);
        map.put("authPath", authPath);
        
        response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(map));
	}
	
	
	
	/**
	 * 인증완료
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/authComplete", method = RequestMethod.GET)
	public void authComplete(
			@RequestParam(value="priinfo" , required=false , defaultValue="") String encPriInfo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String cReqNum = "";
		
		/////////////////////////////////////////////////
		Cookie[] c = request.getCookies();
		for(int i=0; i<c.length; i++){
			if(c[i].getName().equals("reqNum")){
				cReqNum = c[i].getValue();
				System.out.println("reqNum 쿠키 가져오기 : " + c[i].getValue()); 
			}
		}
		
		/////////////////////////////////////////////////
		
		String result = "";
		
		String gender = "";
		String nation = "";
		String name = "";
		String birthDt = "";
		String reqNum = "";
		String cpNo = "";
		
		System.out.println("encPriInfo :: "+encPriInfo);
		
		if(!encPriInfo.equals("")){
				System.out.println("encPriInfo :::: "+encPriInfo);

			MsgCrypto mscr = new MsgCrypto();
			String rstInfo = mscr.msgDecrypt(encPriInfo,authKeyPath,authKeyPwd,"euc-kr");
			
			//	mscr.msgDecrypt(암호화문,인증서 경로,비밀번호(기본 88888888),인코딩); -- 한글이 깨질경우
	        //	mscr.msgDecrypt(암호화문,인증서 경로,비밀번호(기본 88888888));
			
			String[] rstInfoArray = rstInfo.split("\\$");
			System.out.println("rstInfoArray Size ::: " + rstInfoArray.length);
			
			
			
			//쿠키에 저장한 인증요청번호와 비교 
			if(!cReqNum.equals(rstInfoArray[8])){
				result += "<script>";
				result += "alert('인증실패: 인증번호가 일치 하지 않습니다.');";
				result += "window.open('','_self').close();";
				result += "</script>";
				
				response.setContentType("text/html;charset=UTF-8");
			    response.setHeader("Cache-Control", "no-cache");
			    response.getWriter().print(result);
			    return;
			}
			
			
			
			
			
			
			for(int i = 0; i < rstInfoArray.length; i++) {
				System.out.println("rstInfoArray[" + i + "] :: " + rstInfoArray[i]); 
			}
	  		if(rstInfoArray[5].equals("1")||rstInfoArray[5].equals("3")||rstInfoArray[5].equals("5")||rstInfoArray[5].equals("7")){
				// 주민등록번호 뒷자리 중 앞자리 숫자
				gender = "M"; 
			}else{
				gender = "W";
			}
			
			if(rstInfoArray[6].equals("0"))
				nation = "ME00101";
			else
				nation = "ME00102";
			
			
			name = rstInfoArray[7];
			birthDt = rstInfoArray[4];
			reqNum = rstInfoArray[8];
			cpNo = rstInfoArray[2];
			
			if(rstInfoArray[3].equals("SKT") || rstInfoArray[3].equals("SKTMVNO")){
				birthDt = rstInfoArray[4].substring(0, 4) + "." + rstInfoArray[4].substring(4, 6) + "." + rstInfoArray[4].substring(6, 8);
			}else{
				String preFix = "";
				if(rstInfoArray[5].equals("1") || rstInfoArray[5].equals("2") || rstInfoArray[5].equals("5") || rstInfoArray[5].equals("6")){
					preFix = "19";
				}else{
					preFix = "20";
				}
				birthDt = preFix + rstInfoArray[4].substring(0, 2) + "." + rstInfoArray[4].substring(2, 4) + "." + rstInfoArray[4].substring(4, 6);
			}
	  
			if(rstInfoArray.length > 0) {
//				System.out.println("ci : "+rstInfoArray[0]);
//				System.out.println("<p>di : "+rstInfoArray[1]);
//				System.out.println("<p>전화번호 : "+cpNo);
//				System.out.println("<p>통신사 : "+rstInfoArray[3]);
//				System.out.println("<p>생년월일 : "+birthDt);
//				System.out.println("<p>성별 : "+gender);
//				System.out.println("<p>내외국인 : "+nation);
//				System.out.println("<p>이름 : "+name);
//				System.out.println("<p>요청번호 : "+rstInfoArray[8]);
//				System.out.println("<p>요청시간 : "+rstInfoArray[9]);
			}
		}else{
			result += "<script>";
			result += "alert('인증실패');";
			result += "window.open('','_self').close();";
			result += "</script>";
			
			response.setContentType("text/html;charset=UTF-8");
		    response.setHeader("Cache-Control", "no-cache");
		    response.getWriter().print(result);
		}
		
		
		
		result += "<script>";
//		result += "alert('인증성공');";
		result += "opener.nextStep('"+name+"','"+gender+"','"+birthDt+"','"+reqNum+"','"+cpNo+"','"+nation+"');";
		result += "window.open('','_self').close();";
		result += "</script>";
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(result);
	}
	
	
	/**
	 * 인증테스트  팝업
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/testPopUp")
	public ModelAndView testPopUp(
			@RequestParam(value="req_info") String req_info,
			@RequestParam(value="rtn_url") String rtn_url,
			@RequestParam(value="cpid") String cpid,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) 
	throws Exception {
		ModelAndView mav = new ModelAndView();
		
		
		mav.setViewName("/test/testPopUp");
		return mav;
	}
	
	
	@RequestMapping(value = "/testPopUpClose", method = RequestMethod.GET)
	public void testPopUpClose(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response)throws Exception {
			String result = "";
			String result2 = "";
			
			result += "<script>";
//			result += "alert('5');";
			result += "opener.joinErrorTest();";
//			result += "opener.nextStep('"+name+"','"+gender+"','"+birthDt+"','"+reqNum+"','"+cpNo+"','"+nation+"');";
			result += "window.open('','_self').close();";
//			result += "window.close();";
//			result += "alert('2');";
			result += "</script>";
			
//			result2 += "<script>";
//			result2 += "alert('3');";
//			result2 += "opener.nextStep('"+name+"','"+gender+"','"+birthDt+"','"+reqNum+"','"+cpNo+"','"+nation+"');";
//			result2 += "window.open('','_self').close();";
//			result2 += "alert('2');";
//			result2 += "</script>";
			
			response.setContentType("text/html;charset=UTF-8");
		    response.setHeader("Cache-Control", "no-cache");
//		    response.getWriter().print(result2);
		    response.getWriter().print(result);
		}
  
     
}

