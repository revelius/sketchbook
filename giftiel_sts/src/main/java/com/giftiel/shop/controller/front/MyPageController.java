package com.giftiel.shop.controller.front;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Inquiry;
import com.giftiel.shop.dto.InquiryRepl;
import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MydlvAddr;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderAddPay;
import com.giftiel.shop.dto.OrderClm;
import com.giftiel.shop.dto.OrderClmGds;
import com.giftiel.shop.dto.OrderDlvCmp;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.dto.Reserve;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/myPage")
public class MyPageController extends FrontController{
//	private static final Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${server.site.no}")
	private String siteNo;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;	
	
	@Autowired
	private CodeService codeService;	
	
	@Autowired
	private CategoryService categoryService;	
	
	@Autowired
	private Seed seed;
	
	
	private int currentPage = 1;
	private int globalShowListLimit = 10;
	private int showPageLimit = 10;	
	private String orderBy = "";	
	private String orderFlag = "";	
	private StringBuffer pageHtml = null;
	
	
	
	
	
	
	
	
	/**
	 * myPage home
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPageHome" , method = RequestMethod.GET)
	public ModelAndView myPageHome(
			@ModelAttribute("memberForm") MemInfo memInfo,
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		searchForm.setStartListNum(1);
		searchForm.setEndListNum(5);
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		//----회원정보
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		member.setCurPoint(memberService.totalPoint(searchForm));
		//member.setSex(member.getSex().equals("M")?"남":"여");
		
		//----주문 배송 내역
		searchForm.setAllDay(true);
		List<Order> orderList = orderService.listOrder(searchForm);
		
		//----취소 반품 내역
		searchForm.setOrdKnd("cancleAndTakeBack");
		List<Order> cancelList = orderService.listOrder(searchForm);
		
		//----교환 내역
		searchForm.setOrdKnd("exchange");
		List<Order> changeList = orderService.listOrder(searchForm);
		
		//----추가 결제 내역
		List<OrderAddPay> orderAddPayList = orderService.listAddPay(searchForm);
		
		
		
		//----배송지 정보
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
		
		
		//---Qna 
		List<Inquiry> inquiryList = manageService.frontInquiryList(searchForm);
		
		
		
		
		
		
		//mav.addObject("member", member);
		mav.addObject("orderList", orderList);
		mav.addObject("cancelList", cancelList);
		mav.addObject("changeList", changeList);
		mav.addObject("orderAddPayList", orderAddPayList);
		mav.addObject("mydlvAddrList", mydlvAddrList);
		mav.addObject("mydlvAddrListJson", gson.toJson(mydlvAddrList));
		mav.addObject("inquiryList", inquiryList);
		mav.setViewName("/worksout/myPage/myPageHome");
		return mav;
	}
	
	
	/**
	 * 서브페이지
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/snb_mypage" , method = RequestMethod.GET)
	public ModelAndView snb_mypage(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		String loginYn = "";
		if(member != null){
			loginYn = "Y";
		}else{
			loginYn = "N";
		}
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("loginYn", loginYn);
		mav.setViewName("/worksout/myPage/snb_mypage");
		return mav;
	}
	
	
	
	/**
	 * 1:1 문의 하기
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/qna" , method = RequestMethod.GET)
	public ModelAndView qna(
			@ModelAttribute("qnaForm") Inquiry qnaForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		mav.setViewName("/worksout/myPage/qna");
		return mav;
	}
	
	
	
	/**
	 *  1:1 문의 저장
	 * @param qnaForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regInquiryAjax" , method = RequestMethod.POST)
	public @ResponseBody int regInquiry(
			@ModelAttribute("qnaForm") Inquiry qnaForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		qnaForm.setMemNo(member.getMemNo());
		qnaForm.setMemId(member.getEmail());
		qnaForm.setMemNm(member.getNm());
		qnaForm.setSiteNo(siteNo);
		qnaForm.setEmail(member.getEmail());
		qnaForm.setTel(member.getCpNo());
		qnaForm.setRegrNo(member.getMemNo());
		qnaForm.setUpdrNo(member.getMemNo());
		
		
		int result = manageService.regInquiry(qnaForm);
		return result;
	}
	
	
	
	/**
	 * 1:1문의 리스트
	 * @param qnaForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/qnaList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView qnaList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?1:searchForm.getPage();
		
		orderBy   = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		
		int showListLimit = searchForm.getSearchCount()==null?globalShowListLimit:searchForm.getSearchCount();
		
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setTotalCnt(manageService.totalListInquiry(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		List<Inquiry> inquiryList = manageService.frontInquiryList(searchForm);
		
		mav.addObject("inquiryList", inquiryList);
		mav.addObject("pageHtml", pageHtml);
		mav.setViewName("/worksout/myPage/qnaList");
		return mav;
	}
	
	
	
	/**
	 * 1:1 문의 리스트 모바일 ajax용
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/qnaListAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView qnaListAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()+1;
		
		orderBy   = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		
		int showListLimit = searchForm.getSearchCount()==null?globalShowListLimit:searchForm.getSearchCount();
		
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setTotalCnt(manageService.totalListInquiry(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		List<Inquiry> inquiryList = manageService.frontInquiryList(searchForm);
		
		mav.addObject("inquiryList", inquiryList);
//		mav.addObject("pageHtml", pageHtml);
		mav.setViewName("/worksout/myPage/qnaListAjax");
		return mav;
	}
	
	
	
	
	
	
	/**
	 * qna 추가 문의하기
	 * @param cnslNo
	 * @param memoTxt
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regInquiryReplAjax" , method = RequestMethod.POST)
	public @ResponseBody int regInquiryReplAjax(
			@RequestParam int cnslNo,
			@RequestParam String memoTxt,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		InquiryRepl inquiryRepl = new InquiryRepl();
		inquiryRepl.setCnslNo(cnslNo);
		inquiryRepl.setMemoTxt(memoTxt);
		
		
		Member member =  (Member)request.getSession().getAttribute("member");
		inquiryRepl.setUpdrNo(member.getMemNo());
		inquiryRepl.setRegrNo(member.getMemNo());
		inquiryRepl.setWrtrCls("CM01002");
		
		int result = manageService.regInquiryRepl(inquiryRepl);
		return result;
	}
	
	
	/**
	 * 1:1 문의 삭제(문의글 ,reply)
	 * @param cnslNo
	 * @param memoTxt
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delInquiryAjax" , method = RequestMethod.POST)
	public @ResponseBody int delInquiryAjax(
			@RequestParam int cnslNo,
			@RequestParam(value="memoNo",          required=false, defaultValue="0") int memoNo,
			@RequestParam(value="memoTxt",          required=false, defaultValue="") String memoTxt,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		int result = 0;
		
		if(memoNo == 0){//질문 원글 삭제
			Inquiry inquiry = new Inquiry();
			inquiry.setCnslNo(cnslNo);
			result = manageService.delInquiry(inquiry);
		}else{//reply삭제
			InquiryRepl inquiryRepl = new InquiryRepl();
			inquiryRepl.setCnslNo(cnslNo);
			inquiryRepl.setMemoNo(memoNo);
			inquiryRepl.setUpdrNo(member.getMemNo());
			result = manageService.delInquiryReply(inquiryRepl);
		}
		
		
		return result;
	}
	
	
	
	/**
	 * 1:1 문의 수정(문의글 ,reply)
	 * @param cnslNo
	 * @param memoNo
	 * @param memoTxt
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/modInquiryAjax" , method = RequestMethod.POST)
	public @ResponseBody int modInquiryAjax(
			@RequestParam int cnslNo,
			@RequestParam(value="memoNo",          required=false, defaultValue="0") int memoNo,
			@RequestParam(value="memoTxt",          required=false, defaultValue="") String memoTxt,
			@RequestParam(value="cnslTxt",          required=false, defaultValue="") String cnslTxt,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		int result = 0;
		
		if(memoNo == 0){//질문 원글 수정
			Inquiry inquiry = new Inquiry();
			inquiry.setCnslNo(cnslNo);
			inquiry.setCnslTxt(cnslTxt);
			inquiry.setUpdrNo(member.getMemNo());
			result = manageService.modInquiry(inquiry);
		}else{//reply 수정
			InquiryRepl inquiryRepl = new InquiryRepl();
			inquiryRepl.setCnslNo(cnslNo);
			inquiryRepl.setMemoNo(memoNo);
			inquiryRepl.setMemoTxt(memoTxt);
			inquiryRepl.setUpdrNo(member.getMemNo());
			result = manageService.modInquiryReply(inquiryRepl);
		}
		
		
		return result;
	}
	
	
	
	/**
	 * 회원정보 관리
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberInfo" , method = RequestMethod.GET)
	public ModelAndView memberInfo(
			@ModelAttribute("memberForm") MemInfo memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		String birsthDt = "";
		if(member.getBirthDt()!=null){
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
			birsthDt = transFormat.format(member.getBirthDt());
		}
		
		
		
		String sex = member.getSex();//.equals("M")?"남":"여";
		
		memberForm.setEmail(member.getEmail());
		memberForm.setMemNo(member.getMemNo());
		memberForm.setSex(sex);
		memberForm.setBirthDt(birsthDt);
		memberForm.setNm(member.getNm());
		memberForm.setCpNo(member.getCpNo());
		
		mav.setViewName("/worksout/myPage/memberInfo");
		return mav;
	}
	
	/**
	 * 회원정보 변경
	 * @param cnslNo
	 * @param memoTxt
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changeMemberInfoAjax" , method = RequestMethod.POST)
	public @ResponseBody int changeMemberInfoAjax(
			@ModelAttribute("memberForm") MemInfo memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		int result = 0;
		result = memberService.changeMemberInfo(memberForm);
		
		if(result < 1) return result;
		
		SearchForm searchForm = new SearchForm();
	    searchForm.setMemNo(String.valueOf(memberForm.getMemNo()));
	    searchForm.setEmail(memberForm.getEmail());
	    
		Member member = memberService.selectMemInfo(searchForm);
		request.getSession().setAttribute("member", member);
		
		
		return result;
	}
	
	
	
	
	
	
	
	
	/**
	 * 비밀번호 관리
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/managePassword" , method = RequestMethod.GET)
	public ModelAndView managePassword(
			@ModelAttribute("memberForm") MemInfo memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		mav.setViewName("/worksout/myPage/managePassword");
		return mav;
	}
	
	
	/**
	 * 현재 비밀번호 체크
	 * @param existPwd
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value = "/checkExistPwdAjax" , method = RequestMethod.POST)
//	public @ResponseBody int checkExistPwdAjax(
//			@RequestParam String existPwd,
//			Locale locale, 
//			Model model, 
//			HttpServletRequest request, 
//			HttpServletResponse response) throws Exception {
//		Member member =  (Member)request.getSession().getAttribute("member");
//		
//		int result = 0;
//	    
//	    if(member != null){
//			if(seed.encrypt(existPwd).equals(member.getPwd())){
//				result = 1;
//			}else{
//				result = 0;	
//			}
//		}
//		return result;
//	}
	
	/**
	 * 회원 비밀번호 변경
	 * @param existPwd
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changePassAjax" , method = RequestMethod.POST)
	public @ResponseBody int changePassAjax(
			@RequestParam String existPwd,
			@RequestParam String pwd,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		int result = 0;
		existPwd = seed.encrypt(existPwd);
	    if(member != null){
			if(!existPwd.equals(member.getPwd())){
				return -1;
			}
		}
	    
	    MemInfo memInfo = new MemInfo();
	    memInfo.setPwd(seed.encrypt(pwd));
	    memInfo.setMemNo(member.getMemNo());
	    result = memberService.changeMemberInfo(memInfo);
	    
	    
	    
	    SearchForm searchForm = new SearchForm();
	    searchForm.setMemNo(String.valueOf(memInfo.getMemNo()));
	    searchForm.setEmail(memInfo.getEmail());
	    
		member = memberService.selectMemInfo(searchForm);
		request.getSession().setAttribute("member", member);
	    
	    
	    
		return result;
	}
	
	
	
	
	
	
	
	/**
	 * 배송지 관리
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/manageDelivery" , method = RequestMethod.GET)
	public ModelAndView manageDelivery(
			@ModelAttribute("memberForm") MemInfo memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
		
		String view = "";
		if(mydlvAddrList.size() > 0){
			mav.addObject("mydlvAddrList", mydlvAddrList);
			mav.addObject("mydlvAddrListJson", gson.toJson(mydlvAddrList));
			view = "manageDelivery";
		}else{
			MydlvAddr mydlvAddr = new MydlvAddr();
			mydlvAddr.setAddrBynm("주소1");
			mydlvAddr.setBaseValYn("Y");
			mav.addObject("mydlvAddr", mydlvAddr);
			view = "regDelivery";
		}
		
		mav.setViewName("/worksout/myPage/"+view);
		return mav;
	}
	
	
	
	/**
	 * 기본주소지 적용
	 * @param dlvForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/setBaseValYnAjax", method = RequestMethod.POST)
	public void setBaseValYnAjax(
			@ModelAttribute MydlvAddr dlvForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		dlvForm.setMemNo(member.getMemNo());
		
		memberService.setBaseValYn(dlvForm);
		
		
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(mydlvAddrList));
	}
	
	
	
	/**
	 * 배송지 정보 삭제
	 * @param dlvForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delMydlvAddrAjax" , method = RequestMethod.POST)
	public void delMydlvAddrAjax(
			@ModelAttribute MydlvAddr dlvForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		dlvForm.setMemNo(member.getMemNo());
		
		int result = memberService.delMydlvAddr(dlvForm);
		
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
	    
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(mydlvAddrList));
	}
	
	/**
	 * 배송지 수정
	 * @param dlvForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/modMydlvAddrAjax" , method = RequestMethod.POST)
	public void modMydlvAddrAjax(
			@ModelAttribute MydlvAddr dlvForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		dlvForm.setMemNo(member.getMemNo());
		dlvForm.setUpdrNo(member.getMemNo());
		dlvForm.setTel(dlvForm.getTel().replaceAll(",", "-"));
		dlvForm.setCpNo(dlvForm.getCpNo().replaceAll(",", "-"));
		dlvForm.setZipCd(dlvForm.getZipCd().replaceAll(",", ""));
		
		memberService.modMydlvAddr(dlvForm);
		
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
	    
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(mydlvAddrList));
	}
	
	
	
	/**
	 * 배송지 추가 화면
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addMydlvAddr" , method = RequestMethod.GET)
	public ModelAndView addMydlvAddr(
			@ModelAttribute("memberForm") MemInfo memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
//		Member member =  (Member)request.getSession().getAttribute("member");
		
//		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
		
//		int num = mydlvAddrList.size()+1;
		MydlvAddr mydlvAddr = new MydlvAddr();
//		mydlvAddr.setAddrBynm("주소"+num);
//		mydlvAddr.setBaseValYn("N");
		
		mav.addObject("mydlvAddr", mydlvAddr);
		mav.setViewName("/worksout/myPage/regDelivery");
		return mav;
	}
	
	
	/**
	 * 배송지 추가
	 * @param dlvForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/addMydlvAddrAjax" , method = RequestMethod.POST)
	public @ResponseBody int addMydlvAddrAjax(
			@ModelAttribute MydlvAddr dlvForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		dlvForm.setMemNo(member.getMemNo());
		dlvForm.setUpdrNo(member.getMemNo());
		dlvForm.setRegrNo(member.getMemNo());
		
		dlvForm.setTel(dlvForm.getTel().replaceAll(",", "-"));
		dlvForm.setCpNo(dlvForm.getCpNo().replaceAll(",", "-"));
		dlvForm.setZipCd(dlvForm.getZipCd().replaceAll(",", ""));
		
		
		
		int result = memberService.addMydlvAddr(dlvForm);
		
		return result;
	}
	
	
	
	/**
	 * 포인트 현황
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/managePoint" , method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView managePoint(
			@ModelAttribute SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?1:searchForm.getPage();
		
		orderBy   = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		
		int showListLimit = searchForm.getSearchCount()==null?globalShowListLimit:searchForm.getSearchCount();
		
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setTotalCnt(memberService.totalListReserve(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		
		//member.setCurPoint(memberService.totalPoint(searchForm));
		
		List<Reserve> reserveList = memberService.getReserveList(searchForm);
		
		mav.addObject("pageHtml", pageHtml);
		//mav.addObject("member", member);
		mav.addObject("reserveList", reserveList);
		mav.setViewName("/worksout/myPage/managePoint");
		return mav;
	}
	
	
	
	
	
	/**
	 * 회원탈퇴화면
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/withdraw" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView withdraw(
			@ModelAttribute("member") Member memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		memberForm = member;
		mav.addObject("memberForm", memberForm);
		mav.setViewName("/worksout/myPage/withdraw");
		return mav;
	}
	
	/**
	 * 회원탈퇴 처리
	 * @param dlvForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/withdrawAjax" , method = RequestMethod.POST)
	public @ResponseBody int withdrawAjax(
			@ModelAttribute Member memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		memberForm.setMemNo(member.getMemNo());
		
		String existPwd = seed.encrypt(memberForm.getPwd());
	    if(member != null){
			if(!existPwd.equals(member.getPwd())){
				return -1;
			}
		}
		
		int result = memberService.withDrow(memberForm);
		
		if(result == 1){
			request.getSession().invalidate();
		}
		
		
		return result;
	}
	
	/**
	 * 회원탈퇴 완료화면
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/withdrawComplete" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView withdrawComplete(
			@ModelAttribute("member") Member memberForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		//TODO service로 재구현 필요
		//SmsMng smsMng=new SmsMng();
		//String dCpNo = memberForm.getCpNo();
		//String dCpNo2 = dCpNo.replaceAll("-","");
		//String dNm = memberForm.getNm();
		//smsMng.setSmsTxt(dNm + "님 회원탈퇴 처리되었습니다. ");
		//smsMng.setCallTo(dCpNo2);
		//smsMng.setCallFrom("025410854");
		//manageService.smsInsert(smsMng);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/myPage/withdrawComplete");
		
	
		return mav;
	}
	
	
	
	
	
	
	
	/**
	 * 주문발송내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//주문/배송내역
		
		
		
		mav.setViewName("/worksout/myPage/orderList");
		return mav;
	}
	
	
	
	
	
	
	/**
	 * 주문내역 조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderListAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void orderListAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 주문 상세 화면
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderDetail(
			@RequestParam(value="orderNo", required=false) String orderNo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/worksout/myPage/orderDetail");
		return mav;
	}
	
	
	
	
	/**
	 * 취소/반품내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderCancelList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderCancelList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setOrdKnd("cancleAndTakeBack");
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//취소/반품리스트 조회	
		
		
		
		mav.setViewName("/worksout/myPage/orderCancelList");
		return mav;
	}
	
	/**
	 * 취소, 반품리스트  조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderCancelListAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void orderCancelListAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setOrdKnd("cancleAndTakeBack");
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	/**
	 * 주문취소 상세화면
	 * @param orderNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderCancelDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderCancelDetail(
			@RequestParam(value="hiddenOrderNo", required=false) String orderNo,
			@RequestParam(value="hiddenOrdGdsSeq", required=false) int ordGdsSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		
		Order order = orderService.selectOrder(searchForm);
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
		
		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
		mav.addObject("order", order);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		mav.setViewName("/worksout/myPage/orderCancelDetail");
		return mav;
	}
	
	
	
	
	/**
	 * 교환내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderChangeList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderChangeList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setOrdKnd("exchange");
		searchForm.setMemNo(String.valueOf(member.getMemNo()));

		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//교환리스트 조회	
		
		mav.setViewName("/worksout/myPage/orderChangeList");
		return mav;
	}
	
	
	
	/**
	 * 교환내역  조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderChangeAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void orderChangeAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		searchForm.setOrdKnd("exchange");
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	
	
	/**
	 * 교환내역 상세화면
	 * @param orderNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderChangeDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderChangeDetail(
			@RequestParam(value="hiddenOrderNo", required=false) String orderNo,
			@RequestParam(value="hiddenOrdGdsSeq", required=false) int ordGdsSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("exchange");
		
		Order order = orderService.selectOrder(searchForm);
		
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
		
		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
		mav.addObject("order", order);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		mav.setViewName("/worksout/myPage/orderChangeDetail");
		return mav;
	}
	
	
	
	
	/**
	 * 추가 결제 리스트 화면-[작업중]
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderAddPayList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderAddPayList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		searchForm.setMemNo(String.valueOf (member.getMemNo()));
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?1:searchForm.getPage();
		
		orderBy   = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		
		int showListLimit = searchForm.getSearchCount()==null?globalShowListLimit:searchForm.getSearchCount();
		
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setTotalCnt(orderService.totalListAddPay(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		
		
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		
		List<OrderAddPay> orderAddPayList = orderService.listAddPay(searchForm);
		
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("orderAddPayList", orderAddPayList);
		mav.setViewName("/worksout/myPage/orderAddPayList");
		return mav;
	}
	
	
	
	/**
	 * 추가결제 상세-[작업중]
	 * @param orderNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderAddPayDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView orderAddPayDetail(
			@RequestParam(value="hiddenOrderNo", required=false) String orderNo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		List<OrderGoods> tempOrderGoodsList = order.getOrderGoods();
		OrderGoods orderGoods = new OrderGoods();
		
		for(OrderGoods og:tempOrderGoodsList){
			if(og.getOrdNo().equals(order.getOrdNo())){
				orderGoods = og;
			}
		}
		
		mav.addObject("order", order);
		mav.addObject("orderGoods", orderGoods);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/worksout/myPage/orderAddPayDetail");
		return mav;
	}
	
	
	
	
	/**
	 * 주문서 출력 팝업
	 * @param orderNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/popUpOrderPrint" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView popUpOrderPrint(
			@RequestParam(value="orderNo", required=false) String orderNo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		if(member == null){
			member =  new Member();
			member.setMemNo(99999999);
		}
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.setViewName("/worksout/myPage/popUpOrderPrint");
		return mav;
	}
	
	
	
	
	/**
	 * 주문리스트 조회
	 * @param searchForm
	 * @param mav
	 */
	public void searchOrderList(SearchForm searchForm, ModelAndView mav) {
		
		int currentPage = 1;
		int showListLimit = 10;
		int showPageLimit = 10;	
		StringBuffer pageHtml = null;
		
		//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage()==null?20:null);
				
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		//조회조건셋팅
		searchForm.setPayTp("OR00701");//결제유형(결제)
		//searchForm.setPayStat("OR00902");//결제상태(완료)
		//searchForm.setOrdClmCls("OR00601");//주문/클라임구분(주문)
		
		searchForm.setTotalCnt(orderService.totalListOrder(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		List<Order> orderList = orderService.listOrder(searchForm);
		
		List<Site> siteList = codeService.getSiteList(); //매장명 리스트
		List<Code> ordStatList = codeService.listCd(Constants.ORD_STAT);//주문상태 코드리스트
		List<Code> perOrdStatList = codeService.listCd(Constants.PER_ORD_STAT);//개별주문상태 코드리스트
		List<Code> payWayList = codeService.listCd(Constants.PAY_WAY);//결제수단코드
		List<Code> brandList = this.tempBrand(); //브랜드(#임시)
		
		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);
		
		/*코드 셋팅 START*/
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		
		mav.addObject("siteList", siteList);//매장명
		mav.addObject("ordStatList", ordStatList);//개별주문상택
		mav.addObject("perOrdStatList", perOrdStatList);//개별주문상택
		mav.addObject("payWayList", payWayList);//결제수단코드
		mav.addObject("brandList", brandList);//브랜드
		/*코드 셋팅 END*/
		
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("orderList", orderList);
		mav.addObject("searchForm", searchForm);
	}
	
	
	
	/**
	 * 주문리스트 조회Ajax용
	 * @param searchForm
	 * @param mav
	 * @throws Exception 
	 */
	public void searchOrderListAjax(SearchForm searchForm, HttpServletResponse response) throws Exception {
		
		int currentPage = 1;
		int showListLimit = 10;
		int showPageLimit = 10;	
		
		Gson gson = new Gson();
		
		//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage()==null?20:null);
				
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		//조회조건셋팅
		searchForm.setPayTp("OR00701");//결제유형(결제)
		//searchForm.setPayStat("OR00902");//결제상태(완료)
		//searchForm.setOrdClmCls("OR00601");//주문/클라임구분(주문)
		
		searchForm.setTotalCnt(orderService.totalListOrder(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtmlFront(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		
		List<Order> orderList = orderService.listOrder(searchForm);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(orderList));
		
		
	}
	
	
	/**
	 * 임시사용 브랜드 가져오기
	 * @return
	 */
	public List<Code> tempBrand(){
		List<Code> siteList = new ArrayList<Code>(); //매장명(#임시)
		
		
		Code siteCode1 = new Code();
		siteCode1.setCdNo("00");
		siteCode1.setCdNm("NO BRAND	");
		siteList.add(siteCode1);
		
		Code siteCode2 = new Code();
		siteCode2.setCdNo("BR");
		siteCode2.setCdNm("BRIXTON");
		siteList.add(siteCode2);
		
		Code siteCode3 = new Code();
		siteCode3.setCdNo("OU");
		siteCode3.setCdNm("OUTSTANDING");
		siteList.add(siteCode3);
		
		Code siteCode4 = new Code();
		siteCode4.setCdNo("OB");
		siteCode4.setCdNm("OBEY");
		siteList.add(siteCode4);
		
		return siteList;
	}
	
	
	
	
	/**
	 * 비회원 주문조회전 인증
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/confirmAjax" , method = RequestMethod.POST)
	public @ResponseBody int confirmAjax(
			@RequestParam(value="nMemNm") String nMemNm,
			@RequestParam(value="nMemPhone") String nMemPhone,
			@RequestParam(value="nMemOrderNo") String nMemOrderNo,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		HashMap<String,String> hashMap = new HashMap<String,String>();
		hashMap.put("nMemNm", nMemNm);
		hashMap.put("nMemPhone", nMemPhone);
		hashMap.put("nMemOrderNo", nMemOrderNo);
		
		int result = memberService.nMemConfirm(hashMap);
		
		System.out.println("result=====" + result);
		
 		if(result > 0){
			request.getSession().invalidate();
			request.getSession().setAttribute("nMemOrdNo", nMemOrderNo);
			request.getSession().setMaxInactiveInterval(600);
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	/**
	 * 비회원 myPage home
	 * @param joinForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemMyPageHome" , method = RequestMethod.GET)
	public ModelAndView nMemMyPageHome(
			@ModelAttribute("memberForm") MemInfo memInfo,
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		searchForm.setStartListNum(1);
		searchForm.setEndListNum(5);
		
		Member member = new Member();
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		
		
		//----회원정보
		searchForm.setMemNo("99999999");
		
		//----주문 배송 내역
		searchForm.setAllDay(true);
		List<Order> orderList = orderService.listOrder(searchForm);
		
		//----취소 반품 내역
		searchForm.setOrdKnd("cancleAndTakeBack");
		List<Order> cancelList = orderService.listOrder(searchForm);
		
		//----교환 내역
		searchForm.setOrdKnd("exchange");
		List<Order> changeList = orderService.listOrder(searchForm);
		
		//----추가 결제 내역
		//List<OrderAddPay> orderAddPayList = orderService.listAddPay(searchForm);
		
		
		
		mav.addObject("member", member);
		mav.addObject("orderList", orderList);
		mav.addObject("cancelList", cancelList);
		mav.addObject("changeList", changeList);
		mav.setViewName("/worksout/myPage/nMemMyPageHome");
		return mav;
	}
	
	
	
	/**
	 * 비회원 주문발송내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		
		
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//주문/배송내역
		
		
		
		mav.setViewName("/worksout/myPage/nMemOrderList");
		return mav;
	}
	
	
	
	
	
	
	/**
	 * 비회원 주문내역 조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderListAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void nMemOrderListAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	
	
	
	
	
	/**
	 * 비회원  취소/반품내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderCancelList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderCancelList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//취소/반품리스트 조회	
		
		
		
		mav.setViewName("/worksout/myPage/nMemOrderCancelList");
		return mav;
	}
	
	
	
	
	/**
	 * 비회원 취소, 반품리스트  조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderCancelListAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void nMemOrderCancelListAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	
	
	
	
	/**
	 * 비회원 교환내역
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderChangeList" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderChangeList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		searchForm.setOrdKnd("exchange");

		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
		
		this.searchOrderList(searchForm, mav);//교환리스트 조회	
		
		mav.setViewName("/worksout/myPage/nMemOrderChangeList");
		return mav;
	}
	
	
	
	
	
	/**
	 * 비회원 교환내역  조회 모바일용 ajax
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderChangeAjax" , method = {RequestMethod.GET,RequestMethod.POST})
	public void nMemOrderChangeAjax(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setMemNo("99999999");
		
		searchForm.setOrdKnd("exchange");
		
		if(searchForm.getInqStrDtm() == null|| searchForm.getInqEndDtm()==null){
			Calendar cal = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			cal.add(cal.MONTH,-3);

			String  thisDayMiner = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String  thisDay = now.get(now.YEAR)+"-"+(now.get(now.MONTH)+1)+"-"+now.get(now.DATE);

			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = sdfmt.parse(thisDayMiner);
			Date nowDate = sdfmt.parse(thisDay);
			thisDayMiner = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(date);  
			thisDay = new java.text.SimpleDateFormat ("yyyy-MM-dd").format(nowDate);    
			searchForm.setInqEndDtm(thisDay);
			searchForm.setInqStrDtm(thisDayMiner);
		}
		
	    
	    this.searchOrderListAjax(searchForm,response);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 비회원 주문조회 디테일 화면
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderDetail(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		
		
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo("99999999");
		searchForm.setOrdNo(nMemOrdNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("nMemberFlag", true);
		mav.setViewName("/worksout/myPage/nMemOrderDetail");
		return mav;
	}
	
	
	/**
	 * 비회원 취소/반품 조회 디테일 화면
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderCancelDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderCancelDetail(
			@RequestParam(value="hiddenOrderNo", required=false) String orderNo,
			@RequestParam(value="hiddenOrdGdsSeq", required=false) int ordGdsSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		
		
		
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo("99999999");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		
		Order order = orderService.selectOrder(searchForm);
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
		
		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
		mav.addObject("order", order);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		mav.addObject("nMemberFlag", true);
		mav.setViewName("/worksout/myPage/nMemOrderCancelDetail");
		return mav;
	}
	
	
	
	/**
	 * 비회원 교환내역조회 디테일 화면
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/nMemOrderChangeDetail" , method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView nMemOrderChangeDetail(
			@RequestParam(value="hiddenOrderNo", required=false) String orderNo,
			@RequestParam(value="hiddenOrdGdsSeq", required=false) int ordGdsSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String nMemOrdNo = (String)request.getSession().getAttribute("nMemOrdNo");
		
		
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo("99999999");
		searchForm.setOrdNo(nMemOrdNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		
		Order order = orderService.selectOrder(searchForm);
		
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);

		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
		mav.addObject("order", order);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		mav.addObject("nMemberFlag", true);
		mav.setViewName("/worksout/myPage/nMemOrderChangeDetail");
		return mav;
	}
	
	
	
	/**
	 * 반품신청01
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderReturnApply01","/nMemOrderReturnApply01"}, method = RequestMethod.POST)
	public ModelAndView orderReturnApply01(
			@RequestParam(value="orderNo") String orderNo,
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		boolean nMemberFlag = false;
		String nextPage = "orderReturnApply02";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			orderNo = (String)request.getSession().getAttribute("nMemOrdNo");
			nMemberFlag = true;
			nextPage = "nMemOrderReturnApply02";
		}
		
		List<Code> clmRsnCdList = codeService.listCd(Constants.CLM_RSN_CD); //반품사유코드
		List<OrderDlvCmp> dlvCmpList = orderService.listDlvCmp();//택배사 코드
		
		clmForm.setOrdNo(orderNo);
		clmForm.setClmTp(Constants.CLM_TP_RETURN);//클래임유형: 반품 
		clmForm.setClmStat(Constants.CLM_STAT_APPLY);//클래임상태: 접수
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmForm", clmForm);
		mav.addObject("dlvCmpList", dlvCmpList);
		mav.addObject("clmRsnCdList", clmRsnCdList);
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.setViewName("/worksout/myPage/orderReturnApply01");
		return mav;
	}
	
	

	/**
	 * 반품신청02
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderReturnApply02","/nMemOrderReturnApply02"} , method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView orderReturnApply02(
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		boolean nMemberFlag = false;
		String nextPage = "orderReturnApply03";
		String procPage = "orderReturnApplyAjax";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			nMemberFlag = true;
			nextPage = "nMemOrderReturnApply03";
			procPage = "nMemOrderReturnApplyAjax";
		}
		
		ModelAndView mav = new ModelAndView();
		
		List<OrderClmGds> orderClmGds = clmForm.getOrderClmGds();
		List<OrderClmGds> tempList = new ArrayList<OrderClmGds>();
		
		for(OrderClmGds ocds:orderClmGds){
			if(ocds.getOrdGdsSeq() != null){
				tempList.add(ocds);
			}
		}
		clmForm.setOrderClmGds(tempList);
		
		
		List<Code> bankList = codeService.listCd(Constants.BANK_CODE); //은행 코드
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(clmForm.getOrdNo());
		
		
		Order order = orderService.selectOrder(searchForm);
		
		
		
		mav.addObject("order", order);
		mav.addObject("bankList", bankList);
		mav.addObject("clmForm", clmForm);
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.addObject("procPage", procPage);
		mav.setViewName("/worksout/myPage/orderReturnApply02");
		return mav;
	}
	
	
	/**
	 * 반품신청03
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderReturnApply03","/nMemOrderReturnApply03"} , method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView orderReturnApply03(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		boolean nMemberFlag = false;
		String nextPage = "orderCancelList";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			nMemberFlag = true;
			nextPage = "nMemOrderCancelList";
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.setViewName("/worksout/myPage/orderReturnApply03");
		return mav;
	}
	
	
	/**
	 * 반품 신청 process
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderReturnApplyAjax","/nMemOrderReturnApplyAjax"} , method = RequestMethod.POST)
	public @ResponseBody int orderReturnApplyAjax(
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
		}
		
		clmForm.setUpdrNo(member.getMemNo());
		clmForm.setRegrNo(member.getMemNo());
		
		int result = orderService.claimApply(clmForm,Constants.PER_ORD_STAT_RETURN_APPLY );
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 교환신청01
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderChangeApply01","/nMemOrderChangeApply01"} , method = RequestMethod.POST)
	public ModelAndView orderChangeApply01(
			@RequestParam(value="orderNo") String orderNo,
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		boolean nMemberFlag = false;
		String nextPage = "orderChangeApply02";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			orderNo = (String)request.getSession().getAttribute("nMemOrdNo");
			nMemberFlag = true;
			nextPage = "nMemOrderChangeApply02";
		}
		
		
		List<Code> clmRsnCdList = codeService.listCd(Constants.CLM_RSN_CD); //교환사유코드
		List<OrderDlvCmp> dlvCmpList = orderService.listDlvCmp();//택배사 코드
		
		clmForm.setOrdNo(orderNo);
		clmForm.setClmTp(Constants.CLM_TP_CHANGE);//클래임유형: 교환
		clmForm.setClmStat(Constants.CLM_STAT_APPLY);//클래임상태: 접수
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("clmForm", clmForm);
		mav.addObject("dlvCmpList", dlvCmpList);
		mav.addObject("clmRsnCdList", clmRsnCdList);
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.setViewName("/worksout/myPage/orderChangeApply01");
		return mav;
	}
	
	

	/**
	 * 교환신청02
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderChangeApply02","/nMemOrderChangeApply02"} , method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView orderChangeApply02(
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		Gson gson = new Gson();
		ModelAndView mav = new ModelAndView();
		
		boolean nMemberFlag = false;
		String nextPage = "orderChangeApply03";
		String procPage = "orderChangeApplyAjax";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			nMemberFlag = true;
			nextPage = "nMemOrderChangeApply03";
			procPage = "nMemOrderChangeApplyAjax";
		}
		
		
		//최근배송지
		MydlvAddr recentAddr = new MydlvAddr();
		recentAddr = memberService.getRecentAddr(member.getMemNo());
		mav.addObject("recentAddrJson", gson.toJson(recentAddr));
		mav.addObject("recentAddr", recentAddr);
		
		
		//회원주소록
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
		mav.addObject("mydlvAddrListJson", gson.toJson(mydlvAddrList));
		mav.addObject("mydlvAddrList", mydlvAddrList);
		
		
		
		List<OrderClmGds> orderClmGds = clmForm.getOrderClmGds();
		List<OrderClmGds> tempList = new ArrayList<OrderClmGds>();
		
		for(OrderClmGds ocds:orderClmGds){
			if(ocds.getOrdGdsSeq() != null){
				tempList.add(ocds);
			}
		}
		clmForm.setOrderClmGds(tempList);
		
		
		
		SearchForm searchForm = new SearchForm();
		searchForm.setMemNo(String.valueOf(member.getMemNo()));
		searchForm.setOrdNo(clmForm.getOrdNo());
		
		
		Order order = orderService.selectOrder(searchForm);
		
		
		
		mav.addObject("order", order);
		mav.addObject("clmForm", clmForm);
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.addObject("procPage", procPage);
		mav.setViewName("/worksout/myPage/orderChangeApply02");
		return mav;
	}
	
	
	/**
	 * 교환신청03
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderChangeApply03","/nMemOrderChangeApply03"} , method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView orderChangeApply03(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		boolean nMemberFlag = false;
		String nextPage = "orderChangeList";
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
			nMemberFlag = true;
			nextPage = "nMemOrderChangeList";
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("nMemberFlag", nMemberFlag);
		mav.addObject("nextPage", nextPage);
		mav.setViewName("/worksout/myPage/orderChangeApply03");
		return mav;
	}
	
	
	/**
	 * 교환 신청 process
	 * @param memberForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/orderChangeApplyAjax","/nMemOrderChangeApplyAjax"} , method = RequestMethod.POST)
	public @ResponseBody int orderChangeApplyAjax(
			@ModelAttribute("clmForm") OrderClm clmForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
		}
		
		
		
		clmForm.setUpdrNo(member.getMemNo());
		clmForm.setRegrNo(member.getMemNo());
		
		int result = orderService.claimApply(clmForm,Constants.PER_ORD_STAT_CHANGE_APPLY );
		
		return result;
	}
	
	
	/**
	 * 교환,반품취소 process
	 * @param clmForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/claimCancelAjax","/nMemClaimCancelAjax"} , method = RequestMethod.POST)
	public @ResponseBody int claimCancelAjax(
			@RequestParam("hiddenOrderNo") String orderNo,
			@RequestParam("hiddenOrdGdsSeq") int ordGdsSeq,
			@RequestParam("hiddenClmNo") int clmNo,
			@RequestParam("hiddenClmGdsSeq") int clmGdsSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		Member member =  (Member)request.getSession().getAttribute("member");
		
		
		if(member==null && request.getSession().getAttribute("nMemOrdNo") != null){
			Member nMember = new Member();
			nMember.setMemNo(999999);
			member = nMember;
		}
		
		
		Order order = new Order();
		order.setUpdrNo(member.getMemNo());
		order.setRegrNo(member.getMemNo());
		
		OrderClmGds orderClmGds = new OrderClmGds();
		List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
		orderClmGds.setClmGdsSeq(clmGdsSeq);
		orderClmGds.setClmNo(clmNo);
		orderClmGds.setClmGdsStat(Constants.CLM_GDS_STAT_CANCEL);
		orderClmGds.setUpdrNo(member.getMemNo());
		orderClmGdsList.add(orderClmGds);
		
		OrderClm orderClm = new OrderClm();
		List<OrderClm> orderClmList = new ArrayList<OrderClm>();
		orderClm.setOrderClmGds(orderClmGdsList);
		orderClm.setClmNo(clmNo);
		orderClm.setClmStat(Constants.CLM_STAT_CANCEL);
		orderClm.setUpdrNo(member.getMemNo());
		orderClmList.add(orderClm);
		
		order.setOrderClm(orderClmList);
		order.setOrdNo(orderNo);
		order.setOrdGdsSeq(ordGdsSeq);
		order.setPerOrdStat(Constants.PER_ORD_STAT_SHIPP_COMPL);
		
		int result = orderService.claimCancel(order);
		
		return result;
	}

	@RequestMapping(value = "/faq" , method = RequestMethod.GET)
	public ModelAndView faq(Locale locale, 	Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/worksout/myPage/faq");
		return mav;
	}
	
}