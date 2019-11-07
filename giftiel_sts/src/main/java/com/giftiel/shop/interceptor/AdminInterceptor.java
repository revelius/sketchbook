package com.giftiel.shop.interceptor;

import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Menu;
import com.giftiel.shop.dto.User;
import com.giftiel.shop.service.LoginService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.utils.Seed;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Value("${server.contextPath}")
	private String contextPath;
	@Autowired
	private LoginService loginService;
	@Autowired
	private ManageService manageService;
	@Value("${upload.image}")
	private String uploadImage;

	protected Logger log = LoggerFactory.getLogger(AdminInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String reqUrl = request.getRequestURI().toString();

		if (!(contextPath + "/admin/login").equals(reqUrl) && !(contextPath + "/admin/setting/test").equals(reqUrl)) {
			HttpSession session = request.getSession(true);
			Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);

			Admin admin = (Admin) request.getSession().getAttribute("admin");

			User user = new User();

			if (admin == null) {
				response.sendRedirect(contextPath + "/admin/login");
				request.setAttribute("isLogined", false);
				return false;
			} else {
				user = manageService.getUser(admin.getUserNo());

				request.setAttribute("userNm", admin.getUserNm());
				request.setAttribute("admin_id", admin.getId());
				request.setAttribute("admin_userCls", admin.getUserCls());
				request.setAttribute("isLogined", true);
				request.setAttribute("admin_siteAuthNo", user.getSiteAuthNo());
				request.setAttribute("admin_userNo", admin.getUserNo());
			}

			//페이지 권한 체크
			List<Menu> menu = manageService.currentAuthMenu(admin.getUserNo());
			user.setTempSiteAuthNo(user.getSiteAuthNo().split(","));
			boolean authFlag = true;

			for (int i = 0; i < menu.size(); i++) {
				//공통은 제외
				/*
				 * if(reqUrl.equals(menu.get(i).getPageUrl())){ authFlag = true; break; }
				 */
				if (menu.get(i).getPageUrl().indexOf(reqUrl) > -1) {
					authFlag = true;
					break;
				}
			}

			//페이지 접근권한 예외 페이지 처리
			if ("/common/".indexOf(reqUrl) > -1) {
				authFlag = true;
			} else if (StringUtils.indexOf(reqUrl, "popup") > -1) {
				authFlag = true;
			} else if ("POST".equals(request.getMethod())) {
				authFlag = true;
			} else if ("/admin/logout".indexOf(reqUrl) > -1) {
				authFlag = true;
			}

			//	    		System.out.println("reqUrl====" + reqUrl + ", authFlag====" + authFlag + ",  request.getMethod()==" +  request.getMethod());

			//authFlag = true;
			//관리자 페이지 접근권한처리
			if (!authFlag) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('권한이 없습니다.'); history.go(-1);</script>");
				//	                out.println("<script>alert('권한이 없습니다.');</script>");
				//	                out.println("<script>alert('권한이 없습니다.');location.href="+contextPath+"'/admin/login'</script>");
				out.flush();
			} else {

			}

		}

		request.setAttribute("uploadImage", uploadImage);

		//            if(reqUrl.equals(contextPath+"/admin/login") || !(contextPath+"/admin/setting/test").equals(reqUrl)) {
		//            	return super.preHandle(request, response, handler);
		//            }

		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

	}
}