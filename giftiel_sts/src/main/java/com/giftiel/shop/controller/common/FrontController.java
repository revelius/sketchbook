package com.giftiel.shop.controller.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;

@Controller
public class FrontController {
	/**
	 * 접속한 사이트명 반환
	 *
	 * @param request
	 * @return
	 */
	public String getSiteNm(HttpServletRequest request) {
		return (String) request.getAttribute("siteNm");
	}

	/**
	 * 접속한 사이트설명 반환
	 *
	 * @param request
	 * @return
	 */
	public String getSiteDesc(HttpServletRequest request) {
		return (String) request.getAttribute("siteDesc");
	}

	/**
	 * 접속한 사이트 디렉토리명 반환
	 *
	 * @param request
	 * @return
	 */
	public String getSiteDir(HttpServletRequest request) {
		return StringUtils.lowerCase((String) request.getAttribute("siteDir"));
	}

	/**
	 * 접속한 사이트 코드 반환
	 *
	 * @param request
	 * @return
	 */
	public Integer getSiteNo(HttpServletRequest request) {
		return (Integer) request.getAttribute("siteNo");
	}

	/**
	 * 접속한 사이트 OS 반환
	 *
	 * @param userAgent
	 * @return
	 */

	public String getClientOS(String userAgent) {
		String os = "";
		userAgent = userAgent.toLowerCase();
		if (userAgent.indexOf("windows nt 6.1") > -1) {
			os = "Windows7";
		} else if (userAgent.indexOf("windows nt 6.2") > -1 || userAgent.indexOf("windows nt 6.3") > -1) {
			os = "Windows8";
		} else if (userAgent.indexOf("windows nt 6.0") > -1) {
			os = "WindowsVista";
		} else if (userAgent.indexOf("windows nt 5.1") > -1) {
			os = "WindowsXP";
		} else if (userAgent.indexOf("windows nt 5.0") > -1) {
			os = "Windows2000";
		} else if (userAgent.indexOf("windows nt 4.0") > -1) {
			os = "WindowsNT";
		} else if (userAgent.indexOf("windows 98") > -1) {
			os = "Windows98";
		} else if (userAgent.indexOf("windows 95") > -1) {
			os = "Windows95";
		}
		//window 외
		else if (userAgent.indexOf("iphone") > -1) {
			os = "iPhone";
		} else if (userAgent.indexOf("ipad") > -1) {
			os = "iPad";
		} else if (userAgent.indexOf("android") > -1) {
			os = "android";
		} else if (userAgent.indexOf("mac") > -1) {
			os = "mac";
		} else if (userAgent.indexOf("linux") > -1) {
			os = "Linux";
		} else if (userAgent.indexOf("windows nt 6.4") > -1) {
			os = "Windows10";
		} else {
			os = "Etc";
		}

		return os;
	}

	/**
	 * 접속한 사이트 브러아저 반환
	 *
	 * @param userAgent
	 * @return
	 */
	public String getClientBrowser(String userAgent) {
		String browser = "";

		if (userAgent.indexOf("Trident/7.0") > -1) {
			browser = "ie11";
		} else if (userAgent.indexOf("MSIE 10") > -1) {
			browser = "ie10";
		} else if (userAgent.indexOf("MSIE 9") > -1) {
			browser = "ie9";
		} else if (userAgent.indexOf("MSIE 8") > -1) {
			browser = "ie8";
		} else if (userAgent.indexOf("Chrome/") > -1) {
			browser = "Chrome";
		} else if (userAgent.indexOf("Chrome/") == -1 && userAgent.indexOf("Safari/") >= -1) {
			browser = "Safari";
		} else if (userAgent.indexOf("Firefox/") >= -1) {
			browser = "Firefox";
		} else {
			browser = "Etc";
		}
		return browser;
	}

	/**
	 * 모든 HTML 태그를 제거하고 반환한다.
	 *
	 * @param html
	 * @throws Exception
	 */
	public String removeTag(String html) {
		html = html.replaceAll("<!--EndFragment-->", "");
		html = html.replaceAll("<!--StartFragment-->", "");
		html = html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");

		return html;
	}

	/**
	 * String path의 src추출
	 *
	 * @param path
	 * @return
	 */
	public static String convertGetSrc(String path) {
		Pattern p = Pattern.compile("src=[\"']?([^>\"']+)[\"']");
		Matcher m = p.matcher(path);
		String t = "";
		while (m.find()) {
			//            System.out.println(m.group(1));
			t = m.group(1);
		}
		if (t.equals("")) {
			t = path;
		}
		return t;
	}

	/**
	 * getIp
	 * @param userAgent
	 * @return
	 */
	public String getIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-SIMPLEXI0");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
