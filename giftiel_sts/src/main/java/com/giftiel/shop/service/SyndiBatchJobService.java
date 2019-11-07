package com.giftiel.shop.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.sql.Clob;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.Namespace;
import org.jdom2.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.SyndiBatchJobDao;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;



@Service
public class SyndiBatchJobService {
	@Autowired
	private SyndiBatchJobDao syndiBatchJobDao;
	
	@Value("${server.setting}")
	private String serverSetting;
	
	
	int threadSleepTime = 15 * 1000; //핑전송 xml 생성 딜레이 타임설정
	
	String resultStr = "SUCCESS";
	
	
	/**
	 * 네이버 신티케이션 핑
	 */
	public String syndiNaverSearch_news(String siteNo){
		
		
		
		StringBuffer sb = new StringBuffer();
		String siteNm = this.getSiteNm(siteNo);
		
		String newsDetatilUrl = "http://www."+siteNm+".co.kr/front/news/newsDetail";
		
		
//		System.out.println("Syndi BatchJob_news Start_"+siteNm);
		
		try {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			
			
			List<HashMap<String,Object>> newsList = syndiBatchJobDao.getNewsList(siteNo);
			String updatedDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'+09:00'").format(new Date());
			
			Document doc = new Document();
			Namespace ns = Namespace.getNamespace("http://webmastertool.naver.com");
			Element rootElement = new Element("feed", ns);

			// ID
			Element idElement = new Element("id", ns);
			idElement.setText(newsDetatilUrl);
			rootElement.addContent(idElement);
			
			// Title
			Element titleElement = new Element("title", ns);
			titleElement.setText("News Detail");
			rootElement.addContent(titleElement);
			
			// Author
			Element authorElement = new Element("author", ns);
			
			Element authorNameElement = new Element("name", ns);
			authorNameElement.setText(siteNm+" Shopping");
			authorElement.addContent(authorNameElement);
			
			Element authorEmailElement = new Element("email", ns);
			authorEmailElement.setText("worksout@worksout.co.kr");
			authorElement.addContent(authorEmailElement);

			rootElement.addContent(authorElement);
			
			// Updated
			Element updatedElement = new Element("updated", ns);
			updatedElement.setText(updatedDate);
			rootElement.addContent(updatedElement);
			
			// Link
			Element linkElement = new Element("link", ns);
			linkElement.setAttribute("rel", "site");
			linkElement.setAttribute("href", "http://www."+siteNm+".co.kr");
			linkElement.setAttribute("title", siteNm);
			rootElement.addContent(linkElement);
			

			
			if ( newsList != null && newsList.size() > 0 ) {
				// Entry
				for(HashMap<String,Object> newsMap : newsList) {
					
					
					
					String tempUrl = newsDetatilUrl.replace("#site#", this.getSiteNm(String.valueOf(newsMap.get("SITE_NO"))));
					
					
					Element entryElement = new Element("entry", ns);
					// Entry ID
					Element entryIdElement = new Element("id", ns);
					entryIdElement.setText(tempUrl + "?txtNo=" + String.valueOf(newsMap.get("TXT_NO")));
					entryElement.addContent(entryIdElement);
					// Entry Title
					Element entryTitleElement = new Element("title", ns);
					entryTitleElement.setText(newsMap.get("TITLE").toString());
					entryElement.addContent(entryTitleElement);
					// Entry Author
					Element entryAuthorElement = new Element("author", ns);
					Element entryAuthorNameElement = new Element("name", ns);
					entryAuthorNameElement.setText("worksout");
					entryAuthorElement.addContent(entryAuthorNameElement);
					entryElement.addContent(entryAuthorElement);
					// Entry Updated
					Element entryUpdatedElement = new Element("updated", ns);
					entryUpdatedElement.setText(updatedDate);
					entryElement.addContent(entryUpdatedElement);
					// Entry Published
					Element entryPublishedElement = new Element("published", ns);
					entryPublishedElement.setText(updatedDate);
					entryElement.addContent(entryPublishedElement);
					// Entry Link
					Element entryLinkViaElement = new Element("link", ns);
					entryLinkViaElement.setAttribute("rel", "via");
					entryLinkViaElement.setAttribute("href", tempUrl + "?txtNo=" + String.valueOf(newsMap.get("TXT_NO")));
					entryLinkViaElement.setAttribute("title", newsMap.get("TITLE").toString());
					entryElement.addContent(entryLinkViaElement);
					
					
//					System.out.println(" txtNo : " + String.valueOf(newsMap.get("TXT_NO")));
//					System.out.println(" title : " + newsMap.get("TITLE"));
					
					
					PostMethod method = new PostMethod(newsDetatilUrl);
					method.addParameter("txtNo", newsMap.get("TXT_NO").toString());
					HttpClient client = new HttpClient();
					int returncode = client.executeMethod(method);
					if( returncode == HttpStatus.SC_OK) {
						BufferedReader br = new BufferedReader(new InputStreamReader(method.getResponseBodyAsStream()));
						String readLine = "";
						String rtnStr = "<![CDATA[";
						
						while(((readLine = br.readLine()) != null)) {
							rtnStr +=readLine;
						}
						rtnStr += "]]>";
						
						Element entryContentElement = new Element("content", ns);
						entryContentElement.setAttribute("type", "html");
						entryContentElement.setText(rtnStr);
						entryElement.addContent(entryContentElement);
					} else {
						System.out.println("실패");
						resultStr = "fail : content 생성실패";
						break;
					}
					
					
//					Element entryContentElement = new Element("content", ns);
//					entryContentElement.setAttribute("type", "html");
//					entryContentElement.setText("<![CDATA["+newsMap.get("TITLE")+ this.clobToString((Clob)newsMap.get("TXT")) +"]]>");
//					entryElement.addContent(entryContentElement);
					
					
					rootElement.addContent(entryElement);
				}
				
//				
				doc.setRootElement(rootElement);
				
				
				String path = "";
				
				if(serverSetting.equals("LOCAL")){
					path = "D:/workData_Zionid/20150319_worksout/workspace/worksout/src/main/webapp/syndi/";
				} else {
					path = "/home/hosting_users/worksout2015/www/syndi/";
				}
				
				
				String file = "syndiItem_" + sdf.format(cal.getTime())+"_"+siteNm + ".xml";
				
//				System.out.println(" path : " + path + file);
				
				XMLOutputter xout = new XMLOutputter();
				xout.output(doc, new FileWriter(path + file));
				//  
//				System.out.println("complete");
				
				Thread.sleep(threadSleepTime);
				
//				System.out.println("ping start");
				
				String strURL = "https://apis.naver.com/crawl/nsyndi/v2";
				String xmlUrl = "http://www."+siteNm+".co.kr/syndi/" + file;
//				System.out.println(" xmlUrl : " + xmlUrl);
				//xmlUrl = URLEncoder.encode(xmlUrl, "UTF-8");
				//xmlUrl = URLEncoder.encode(xmlUrl, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~");
//				System.out.println("xmlUrl : " + xmlUrl);
//				System.out.println("encoding : " + URLEncoder.encode(xmlUrl, "UTF-8"));
//				System.out.println("encoding : " + URLEncoder.encode(xmlUrl, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~"));
				
				PostMethod post = new PostMethod(strURL);
				post.setRequestHeader("User-Agent", "request");
				post.setRequestHeader("Host","apis.naver.com"); 
				post.setRequestHeader("Pragma","no-cache"); 
				post.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
				post.setRequestHeader("Accept","*/*"); 
				post.setRequestHeader("Authorization",this.getSiteKey(siteNo)); 
				NameValuePair[] tmp = new NameValuePair[1];
				
				tmp[0] = new NameValuePair("ping_url", xmlUrl);
				post.setRequestBody(tmp);
				
				HttpClient httpclient = new HttpClient();            
				
				try {
					int result = httpclient.executeMethod(post);
					// Display status code
					System.out.println("Response status code: " + result);
					// Display response
					System.out.println("Response header: "+post.getResponseHeader("Status-Line"));
					System.out.println("Response body: ");
					System.out.println(post.getResponseBodyAsString());
				} finally {
					// Release current connection to the connection pool once you are done
					post.releaseConnection();
				}
				
				sb.append(" SUCCESS ");
				
//				System.out.println("SUCCESS" + post.getResponseBodyAsString());
			} else {
				sb.append(" Empty list ");
				System.out.println("Empty list");
				resultStr = "fail : Empty list";
			}
		} catch(Exception e) {
			sb.append(" FAILURE \n");
			sb.append(e.getMessage());
			resultStr = "fail : "+e.getMessage();
		} finally {
			
		}
//		System.out.println("Syndi BatchJob End_"+siteNm);
		return resultStr;
	}
	
	
	
	
	
	
	
	/**
	 * 네이버 신티케이션 핑(수동등록)
	 */
	public String syndiNaverSearch_manual(String siteNo, String targetUrl, String targetTitle){
		
		
		StringBuffer sb = new StringBuffer();
		String siteNm = this.getSiteNm(siteNo);
		
		String regUrl = targetUrl;
		
		
//		System.out.println("Syndi BatchJob_manual Start_"+siteNm);
		
		try {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			
			
			String updatedDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'+09:00'").format(new Date());
			
			Document doc = new Document();
			Namespace ns = Namespace.getNamespace("http://webmastertool.naver.com");
			Element rootElement = new Element("feed", ns);

			// ID
			Element idElement = new Element("id", ns);
			idElement.setText(regUrl);
			rootElement.addContent(idElement);
			
			// Title
			Element titleElement = new Element("title", ns);
			titleElement.setText("News Detail");
			rootElement.addContent(titleElement);
			
			// Author
			Element authorElement = new Element("author", ns);
			
			Element authorNameElement = new Element("name", ns);
			authorNameElement.setText(siteNm+" Shopping");
			authorElement.addContent(authorNameElement);
			
			Element authorEmailElement = new Element("email", ns);
			authorEmailElement.setText("worksout@worksout.co.kr");
			authorElement.addContent(authorEmailElement);

			rootElement.addContent(authorElement);
			
			// Updated
			Element updatedElement = new Element("updated", ns);
			updatedElement.setText(updatedDate);
			rootElement.addContent(updatedElement);
			
			// Link
			Element linkElement = new Element("link", ns);
			linkElement.setAttribute("rel", "site");
			linkElement.setAttribute("href", "http://www."+siteNm+".co.kr");
			linkElement.setAttribute("title", siteNm);
			rootElement.addContent(linkElement);
			

			
				// Entry
					Element entryElement = new Element("entry", ns);
					// Entry ID
					Element entryIdElement = new Element("id", ns);
					entryIdElement.setText(regUrl);
					entryElement.addContent(entryIdElement);
					// Entry Title
					Element entryTitleElement = new Element("title", ns);
					entryTitleElement.setText(targetTitle);
					entryElement.addContent(entryTitleElement);
					// Entry Author
					Element entryAuthorElement = new Element("author", ns);
					Element entryAuthorNameElement = new Element("name", ns);
					entryAuthorNameElement.setText("worksout");
					entryAuthorElement.addContent(entryAuthorNameElement);
					entryElement.addContent(entryAuthorElement);
					// Entry Updated
					Element entryUpdatedElement = new Element("updated", ns);
					entryUpdatedElement.setText(updatedDate);
					entryElement.addContent(entryUpdatedElement);
					// Entry Published
					Element entryPublishedElement = new Element("published", ns);
					entryPublishedElement.setText(updatedDate);
					entryElement.addContent(entryPublishedElement);
					// Entry Link
					Element entryLinkViaElement = new Element("link", ns);
					entryLinkViaElement.setAttribute("rel", "via");
					entryLinkViaElement.setAttribute("href", regUrl);
					entryLinkViaElement.setAttribute("title", targetTitle);
					entryElement.addContent(entryLinkViaElement);
					
					
					
					
					PostMethod method = new PostMethod(regUrl);
//					method.addParameter("txtNo", newsMap.get("TXT_NO").toString());
					HttpClient client = new HttpClient();
					int returncode = client.executeMethod(method);
					if( returncode == HttpStatus.SC_OK) {
						BufferedReader br = new BufferedReader(new InputStreamReader(method.getResponseBodyAsStream()));
						String readLine = "";
						String rtnStr = "<![CDATA[";
						
						while(((readLine = br.readLine()) != null)) {
							rtnStr +=readLine;
						}
						rtnStr += "]]>";
						
						Element entryContentElement = new Element("content", ns);
						entryContentElement.setAttribute("type", "html");
						entryContentElement.setText(rtnStr);
						entryElement.addContent(entryContentElement);
					} else {
//						System.out.println("실패");
						resultStr = "fail : content 생성실패";
					}
					
					
//					Element entryContentElement = new Element("content", ns);
//					entryContentElement.setAttribute("type", "html");
//					entryContentElement.setText("<![CDATA["+newsMap.get("TITLE")+ this.clobToString((Clob)newsMap.get("TXT")) +"]]>");
//					entryElement.addContent(entryContentElement);
					
					
					rootElement.addContent(entryElement);
				
					
					
					
					
					
					
					
					
					
					
				
//				
				doc.setRootElement(rootElement);
				
				
				String path = "";
				
				if(serverSetting.equals("LOCAL")){
					path = "D:/workData_Zionid/20150319_worksout/workspace/worksout/src/main/webapp/syndi/";
				} else {
					path = "/home/hosting_users/worksout2015/www/syndi/";
				}
				
				
				String file = "syndiItem_manual_" + sdf.format(cal.getTime())+"_"+siteNm + ".xml";
				
				System.out.println(" path : " + path + file);
				
				XMLOutputter xout = new XMLOutputter();
				xout.output(doc, new FileWriter(path + file));
				//  
				System.out.println("complete");
				
				Thread.sleep(threadSleepTime);
				
				System.out.println("ping start");
				
				String strURL = "https://apis.naver.com/crawl/nsyndi/v2";
				String xmlUrl = "http://www."+siteNm+".co.kr/syndi/" + file;
				System.out.println(" xmlUrl : " + xmlUrl);
				//xmlUrl = URLEncoder.encode(xmlUrl, "UTF-8");
				//xmlUrl = URLEncoder.encode(xmlUrl, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~");
				System.out.println("xmlUrl : " + xmlUrl);
				System.out.println("encoding : " + URLEncoder.encode(xmlUrl, "UTF-8"));
				System.out.println("encoding : " + URLEncoder.encode(xmlUrl, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~"));
				
				PostMethod post = new PostMethod(strURL);
				post.setRequestHeader("User-Agent", "request");
				post.setRequestHeader("Host","apis.naver.com"); 
				post.setRequestHeader("Pragma","no-cache"); 
				post.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
				post.setRequestHeader("Accept","*/*"); 
				post.setRequestHeader("Authorization",this.getSiteKey(siteNo)); 
				NameValuePair[] tmp = new NameValuePair[1];
				
				tmp[0] = new NameValuePair("ping_url", xmlUrl);
				post.setRequestBody(tmp);
				
				HttpClient httpclient = new HttpClient();            
				
				try {
					int result = httpclient.executeMethod(post);
					// Display status code
					System.out.println("Response status code: " + result);
					// Display response
					System.out.println("Response header: "+post.getResponseHeader("Status-Line"));
					System.out.println("Response body: ");
					System.out.println(post.getResponseBodyAsString());
				} finally {
					// Release current connection to the connection pool once you are done
					post.releaseConnection();
				}
				
				sb.append(" SUCCESS ");
				
				System.out.println("SUCCESS" + post.getResponseBodyAsString());
			
		} catch(Exception e) {
			sb.append(" FAILURE \n");
			sb.append(e.getMessage());
			resultStr = "fail : "+e.getMessage();
		} finally {
			
		}
		System.out.println("Syndi BatchJob End_manual_"+siteNm);
		return resultStr;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * siteNo 를 site url 분기
	 * @param siteNo
	 * @return
	 */
	public String getSiteNm(String siteNo){
		String siteNm = "";
		if(siteNo.equals("10001")){
			siteNm = "worksout";
		}else if(siteNo.equals("10002")){
			siteNm = "carhartt-wip";
		}else if(siteNo.equals("10003")){
			siteNm = "obeyclothing";
		}else if(siteNo.equals("10004")){
			siteNm = "brixton";
		}else if(siteNo.equals("10006")){
			siteNm = "deuscustoms";
		}
		return siteNm;
	}
	
	/**
	 * siteNo 를 site 인증키 분기
	 * @param siteNo
	 * @return
	 */
	public String getSiteKey(String siteNo){
		String siteKey = "";
		if(siteNo.equals("10001")){
			siteKey = "worksout";
		}else if(siteNo.equals("10002")){
			siteKey = "Bearer AAAAOT7vceVrCn4OGmRT8W00YohU4/WwZkCQSdjVnIbdoOPVeRDyAjcoJowPJCB656Xjoj84InBh0FbtpIdQ1hoU/yE=";
		}else if(siteNo.equals("10003")){
			siteKey = "Bearer AAAANy6KioBTCD1KXjyMdInROY8z/CNnJd99bPRzsFzixX0vOThDeEPohOQ+OVLJRYfiCvj82gBwQgMXdorUepFojpI=";
		}else if(siteNo.equals("10004")){
			siteKey = "Bearer AAAANy6KioBTCD1KXjyMdInROY8z/CNnJd99bPRzsFzixX0vOThDeEPohOQ+OVLJRYfiCvj82gBwQgMXdorUepFojpI=";
		}else if(siteNo.equals("10006")){
			siteKey = "deuscustoms";
		}
		return siteKey;
	}
	
	
	
	
	 /*
	  * Clob 를 String 으로 변경
	  */
	public String clobToString(Clob clob)throws Exception {
		 
		if (clob == null) {
			return "";
		}
		
		StringBuffer strOut = new StringBuffer();
		
		String str = "";
		
		BufferedReader br = new BufferedReader(clob.getCharacterStream());
		
		while ((str = br.readLine()) != null) {
			strOut.append(str);
		}
		return strOut.toString();
	}
	
		
	
}