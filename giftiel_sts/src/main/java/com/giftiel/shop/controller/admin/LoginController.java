package com.giftiel.shop.controller.admin;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Locale;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.service.LoginService;
import com.giftiel.shop.utils.Seed;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin")
public class LoginController extends HttpServlet{
	protected Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private Seed seed;
	@Value("${server.contextPath}")
	private String contextPath;	
	/**
	 * 관리자 로그인 페이지
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 **/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView selectTableList(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) throws IllegalAccessException, InvocationTargetException {
		ModelAndView mav = new ModelAndView();
		
		
		log.info("enter login page");
		
//		try {
//			System.out.println("seed.encrypt(pass)====" + seed.encrypt("1"));
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
//		String pType = reqeust.getParameter("p");
//		String pageType = "";
//		
//		if (pType != null) {
//			if (pType.equals("b")) {
//				pageType = "_bootstrap";
//			}			
//		}

		mav.setViewName("/admin"+Constants.MODE_ADMIN+"/login");
//		mav.setViewName("/admin"+pageType+"/login");
		return mav;
	}
	
	/**
	 * 관리자 로그인 성공시 메인으로 이동.
	 **/
	@RequestMapping(value = "/login")
	public void selectLogin(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("AdminID") String adminId,@RequestParam("Pass") String pass) throws IOException {
		
		model.addAttribute("ID", adminId );
	    model.addAttribute("PWD", "");
	    Admin admin = loginService.selectAdmin(model);
	    
	    String result = "";
	    		
		if(admin != null){
			if(seed.encrypt(pass).equals(admin.getPwd())){
				request.getSession().setAttribute("admin", admin);
				request.getSession().setMaxInactiveInterval(43200); // 세션 24시간 임시셋팅
				result = "0";
			}else{
				result = "1";	
			}
		}else{
			result = "1";
		}
		response.getWriter().print(result);
	}
	
	/**
	 * 관리자 로그아웃 
	 * @throws IOException 
	 **/
	@RequestMapping(value = "/logout")
	public void logout(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response
			, SessionStatus sessionStatus) throws IOException {
		request.getSession().removeAttribute("admin");
		response.sendRedirect(contextPath+"/admin/login");
//		response.sendRedirect(contextPath+"/admin/login?p=b");
	}  
}