package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.common.SMSSend;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.utils.Seed;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/join")
public class JoinController  extends FrontController{
	private static final Logger log = LoggerFactory.getLogger(JoinController.class);
	
	@Value("${server.setting}")
	private String serverSetting;
	
	
	@Autowired
	private MemberService memberService;
	
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	private Seed seed;
	
	@Autowired
	private SMSSend smsSend;	
	
	
//	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private MailSend MailSend;
	
	/**
	 * 통합회원가입_홈
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
//	@RequestMapping(value = "/joinHome", method = RequestMethod.GET)
//	public ModelAndView selectTableList(
//			@ModelAttribute("joinForm") MemInfo joinForm,
//			Locale locale, 
//			Model model, 
//			HttpServletRequest request, 
//			HttpServletResponse response) {
//		ModelAndView mav = new ModelAndView();
//		
//		joinForm.setSiteNo(getSiteNo(request));
//		mav.addObject("joinForm", joinForm);
//		mav.setViewName("/worksout/join/joinHome");
//		return mav;
//	}
	/**
	 * 통합회원가입_약관동의및 본인인증
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
//	@RequestMapping(value = "/joinConfirm", method = RequestMethod.POST)
//	public ModelAndView joinConfirm(
//			@ModelAttribute("joinForm") MemInfo joinForm,
//			Locale locale, 
//			Model model, 
//			HttpServletRequest request, 
//			HttpServletResponse response) {
//		
//		String countryCd = joinForm.getCountryCd();
//		String viewName = countryCd.equals("ME00101")?"joinConfirm":"joinConfirm_eng";
//		
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/worksout/join/"+viewName);
//		return mav;
//	}
	
	
	/**
	 * 통합회원가입_정보입력
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
//	@RequestMapping(value = "/joinInfo", method = RequestMethod.POST)
//	public ModelAndView joinInfo(
//			@ModelAttribute("joinForm") MemInfo joinForm,
//			Locale locale, 
//			Model model, 
//			HttpServletRequest request, 
//			HttpServletResponse response) {
//		
//		String countryCd = joinForm.getCountryCd();
//		String viewName = countryCd.equals("ME00101")?"joinInfo":"joinInfo_eng";
//		
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/worksout/join/"+viewName);
//		return mav;
//	} 
	@RequestMapping(value = "/joinInfo", method = RequestMethod.POST)
	public ModelAndView joinInfo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("joinForm") MemInfo joinForm) {
		
		log.info("======================== New joinInfo joinForm");
		
		String countryCd = joinForm.getCountryCd();
		String viewName = countryCd.equals("ME00101")?"joinInfo":"joinInfo_eng";
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/join/" + viewName);
		return mav;
	}
	
	
	/**
	 * id중복체크
	 * @param id
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/idDuplChkAjax" , method = RequestMethod.POST)
	public @ResponseBody int idDuplChkAjax(
			@RequestParam(value="email") String email,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws UnsupportedEncodingException {
		
		int result = memberService.idDuplChk(email);
		return result;
	}
	
	/**
	 * 회원가입
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/joinProc" , method = RequestMethod.POST)
	public ModelAndView joinProc(
			@ModelAttribute("joinForm") MemInfo joinForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		joinForm.setPwd(seed.encrypt(joinForm.getPwd()));
		
		joinForm.setCpNo(joinForm.getCpNo01()+"-"+joinForm.getCpNo02()+"-"+joinForm.getCpNo03());
		joinForm.setBirthDt(joinForm.getBirth01()+joinForm.getBirth02()+joinForm.getBirth03());
		
		int result = memberService.memberJoin(joinForm);
		
		if(result > 0){
			//SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
			smsSend.sendSMS(1, joinForm.getCpNo(), getSiteDesc(request), joinForm.getNm(), "",0);
			
			//MAIL 발송 
			String to      = joinForm.getEmail();
			
			HashMap<String,String> hm = new HashMap<String,String>();
			hm.put("nm", joinForm.getNm());
			hm.put("email", joinForm.getEmail());
			
			//성공 : 1, 실패 : 0
			result = MailSend.sendMail(joinForm.getNm(),to,request,hm,"memRegister");
		}
		
		String countryCd = joinForm.getCountryCd();
		String viewName = countryCd.equals("ME00101")?"joinComplete":"joinComplete_eng";
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/join/"+viewName);
		return mav;
	}
	
	
	
	
	/**
	 * 핸드폰 번호 중복 체크
	 * @param cpNo - 핸드폰 번호
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cpDuplChkAjax" , method = RequestMethod.POST)
	public @ResponseBody int cpDuplChkAjax(
			@RequestParam(value="cpNo") String cpNo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws UnsupportedEncodingException {
		
		int result = memberService.cpDuplChk(cpNo);
		
		return result;
	}
	
	
	/**
	 * 인증 실패시 이동 페이지
	 * @param errorTxt
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/joinError", method = RequestMethod.POST)
	public ModelAndView joinError(
			@RequestParam(value="errorTxt") String errorTxt,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) {
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("errorTxt", errorTxt);
		mav.setViewName("/worksout/join/joinError");
		return mav;
	} 
	
	
	@RequestMapping(value = "/sendCertNo")
	public void idChecking(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("nm") String nm,@RequestParam("cpNo") String cpNo) throws IOException {
		
	    SearchForm searchForm = new SearchForm();
	    searchForm.setNm(nm);
	    searchForm.setCpNo(cpNo);
	    
	    Random oRandom = new Random();
	    String certNumber = oRandom.nextInt(10) +""+ oRandom.nextInt(10) +""+ oRandom.nextInt(10) +""+ oRandom.nextInt(10) +""+ oRandom.nextInt(10) +""+ oRandom.nextInt(10);
	    String result = "";
		smsSend.sendSMS(27, cpNo, getSiteDesc(request), nm, certNumber,0);
		result = "0,"+certNumber + ",,";
		response.getWriter().print(result);
	}
	
	@RequestMapping(value = "/sendBusinessCertNo")
	public void BusinessCertNumChecking(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cbNo") String cbNo) throws IOException {
		
		log.info("===================================== BusinessCertNumChecking {}",cbNo);
		
	    SearchForm searchForm = new SearchForm();
	    searchForm.setCbNo(cbNo);
		    
	    String result = cbNo;
		response.getWriter().print(result);
	}
}