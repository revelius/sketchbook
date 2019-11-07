package com.giftiel.shop.controller.common;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.AuthGrp;
import com.giftiel.shop.dto.Awnes;
import com.giftiel.shop.dto.BoardGds;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.FeatureManage;
import com.giftiel.shop.dto.FeatureManageForm;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.Inquiry;
import com.giftiel.shop.dto.InquiryRepl;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.MailManage;
import com.giftiel.shop.dto.MainManage;
import com.giftiel.shop.dto.MainManageForm;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MemberGrade;
import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.Operator;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.SmsMng;
import com.giftiel.shop.dto.User;
import com.giftiel.shop.dto.UserAuthGrp;
import com.giftiel.shop.dto.WorkWithUs;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberGradeService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.SyndiBatchJobService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;


  

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/naverSearch")
public class NaverSearchController{
	
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${server.contextPath}")
	private String contextPath;	
	
	@Value("${upload.image}")
	private String uploadImage;
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	SyndiBatchJobService syndiBatchJobService;
	

	
	
	
	@RequestMapping(value = "/manual" , method = RequestMethod.GET)
	public void naversearchManual(
			@RequestParam(value="siteNo") String siteNo,
			@RequestParam(value="targetUrl") String targetUrl,
			@RequestParam(value="targetTitle") String targetTitle,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String resultStr = syndiBatchJobService.syndiNaverSearch_manual(siteNo,targetUrl,targetTitle);
//		syndiBatchJobService.syndiNaverSearch_manual("10004","http://www.brixton.co.kr/front/storeInfo/Ab","brixton store info");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('"+resultStr+"');</script>");
        out.println("<script>alert('핑전송 완료 하였습니다.');</script>");
		
	}
	
	
	@RequestMapping(value = "/news" , method = RequestMethod.GET)
	public void naversearchNews(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String resultStr1 = syndiBatchJobService.syndiNaverSearch_news("10002");//carhartt-wip
		String resultStr2 = syndiBatchJobService.syndiNaverSearch_news("10003");//obeyclothing
		String resultStr3 = syndiBatchJobService.syndiNaverSearch_news("10004");//brixton
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('carhartt-wip : "+resultStr1+"\\n obeyclothing : "+resultStr2+"\\n brixton : "+resultStr3+"');</script>");
//		out.println("<script>alert('obeyclothing : "+resultStr2+"');</script>");
//		out.println("<script>alert('brixton : "+resultStr3+"');</script>");
        out.println("<script>alert('NEWS 핑전송 완료 하였습니다.');</script>");
		
	}
	
	
	
	
}