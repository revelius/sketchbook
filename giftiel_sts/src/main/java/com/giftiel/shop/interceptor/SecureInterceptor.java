package com.giftiel.shop.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SecureInterceptor extends HandlerInterceptorAdapter {
	@Value("${server.contextPath}")
	private String contextPath;

	protected Logger log = LoggerFactory.getLogger(SecureInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		String url = new StringBuffer().append(request.getRequestURI())
				.append((request.getQueryString() == null) ? "" : "?" + request.getQueryString()).toString();

		Enumeration<?> eNames = request.getParameterNames();
		/*
		 * if (eNames.hasMoreElements()) { while (eNames.hasMoreElements()) { String name = (String) eNames.nextElement(); String[] values = request.getParameterValues(name); if (values.length > 0) { String value = values[0]; for (int i = 1; i < values.length; i++) { value += "," + values[i]; } if(!SecureInterceptor.checkingInjection(value)){ log.error(name+" : "+value); log.error("XSS 공격이 감지되었습니다.===[" + value + "]" + "IP_ADDR=====" + request.getRemoteAddr()); response.sendRedirect("/jsp/common/error.jsp"); return false; } } } }
		 */
		return true;
	}

	private static boolean checkingInjection(String value) {
		boolean result = true;
		if (value.toUpperCase().contains("SELECT"))
			result = false;
		if (value.toUpperCase().contains("UPDATE"))
			result = false;
		if (value.toUpperCase().contains("DELETE"))
			result = false;
		if (value.toUpperCase().contains("INSERT"))
			result = false;
		//if(value.toUpperCase().contains("AND")) result=false;
		if (value.toUpperCase().contains("TRIM"))
			result = false;
		//if(value.toUpperCase().contains("FALSE")) result=false;
		//if(value.toUpperCase().contains("TRUE")) result=false;
		//if(value.toUpperCase().contains("OR")) result=false;
		if (value.toUpperCase().contains("<SCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</SCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("<JAVASCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</JAVASCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</VBSCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("<VBSCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("\\/*"))
			result = false;
		if (value.toUpperCase().contains("*\\/"))
			result = false;
		if (value.toUpperCase().contains("--"))
			result = false;
		if (value.toUpperCase().contains("!--"))
			result = false;
		if (value.toUpperCase().contains("--!"))
			result = false;
		if (value.toUpperCase().contains("\\("))
			result = false;
		if (value.toUpperCase().contains("\\)"))
			result = false;
		if (value.toUpperCase().contains("%"))
			result = false;
		//if(value.toUpperCase().contains("=")) result=false;
		if (value.toUpperCase().contains("--!"))
			result = false;
		if (value.toUpperCase().contains("+"))
			result = false;
		if (value.toUpperCase().contains("ALERT"))
			result = false;
		//if(value.toUpperCase().contains("SCRIPT")) result=false;
		//if(value.toUpperCase().contains("\'")) result=false;
		if (value.toUpperCase().contains("||"))
			result = false;
		//if(value.toUpperCase().contains("\"")) result=false;
		if (value.toUpperCase().contains("JAVASCRIPT"))
			result = false;
		if (value.toUpperCase().contains("--BEGIN_MARK_TAG--"))
			result = false;
		//if(value.toUpperCase().contains("1234")) result=false;
		if (value.toUpperCase().contains("../"))
			result = false;
		if (value.toUpperCase().contains("WFXSSPROBE"))
			result = false;
		if (value.toUpperCase().contains("PROBEPHISHING"))
			result = false;
		if (value.toUpperCase().contains("/USR/"))
			result = false;
		if (value.toUpperCase().contains("/BIN/"))
			result = false;
		if (value.toUpperCase().contains("$("))
			result = false;
		if (value.toUpperCase().contains("AVAK"))
			result = false;
		if (value.toUpperCase().contains("PROBE"))
			result = false;
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		//contextPath 셋팅
		//request.setAttribute("contextPath", contextPath);    	
	}
}