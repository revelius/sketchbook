package com.giftiel.shop.controller.admin;

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
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/manage")
public class ManageController extends AdminController {
	private static final Logger log = LoggerFactory.getLogger(AdminController.class);

	@Value("${server.setting}")
	private String serverSetting;

	@Value("${server.contextPath}")
	private String contextPath;

	@Value("${upload.image}")
	private String uploadImage;

	@Autowired
	private ManageService manageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberGradeService memberGradeService;

	@Autowired
	private Seed seed;

//	@Autowired
	private JavaMailSender mailSender;

//	@Autowired
	private MailSend MailSend;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private CategoryService categoryService;

	private int currentPage = 1;
	private int globalShowListLimit = 15;
	private int showPageLimit = 10;
	private String orderBy = "";
	private String orderFlag = "";
	private StringBuffer pageHtml = null;
	private int showListLimit = 10;

	//부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "manage";
		// request.setAttirubte("globalMenuFlag", "manage") 와 같으며
		// 선언된 클래스의 전역으로 실행된다.
	}

	@RequestMapping(value = "/manage", method = RequestMethod.GET)
	public ModelAndView manage(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/manage/manage");

		return mav;
	}

	/**
	 * 1:1 질문 리스트
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/inquiryList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView inquiryList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListInquiry(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Inquiry> inquiry = manageService.inquiryList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("inquiryList", inquiry);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/manage/inquiryList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,제목,첨부파일,이름,이메일,작성일,답변여부";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getTitle,getAtchFile,getMemNm,getEmail,getRegDts,getCnslStat";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", inquiry);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "inquiryList");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * 1:1 질문리스트 상세
	 *
	 * @param cnslNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/inquiryDetail", method = RequestMethod.POST)
	public ModelAndView inquiryDetail(@RequestParam(value = "cnslNo") String cnslNo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		Inquiry inquiry = manageService.inquiryDetail(cnslNo, admin.getUserNo());

		if (inquiry.getCnslTxt() != null) {
			inquiry.setCnslTxt(inquiry.getCnslTxt().replace("\n", "</br>")); // 화면에 줄바꿈요청으로 처리
		}

		List<InquiryRepl> inquiryRepl = manageService.inquiryRepl(cnslNo);

		String inquiryReplTxt = "";

		for (int i = 0; i < inquiryRepl.size(); i++) {
			inquiryReplTxt = inquiryRepl.get(i).getMemoTxt().replaceAll("\n", "</br>"); // 화면에 줄바꿈요청으로 처리
			inquiryRepl.get(i).setMemoTxt(inquiryReplTxt);
		}

		//관리자 이름
		//String adminUserNm = (String)request.getSession().getAttribute("admin_userNm");
		//String adminUserNm = admin.getUserNm();

		//mav.addObject("adminUserNm", adminUserNm);
		mav.addObject("inquiry", inquiry);
		mav.addObject("inquiryReplList", inquiryRepl);
		mav.setViewName("/admin/manage/inquiryDetail");
		return mav;
	}

	/**
	 * 1:1 답변등록
	 *
	 * @param inquiryReplForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regInquiryReplAjax", method = RequestMethod.POST)
	public @ResponseBody int regInquiryReplAjax(@ModelAttribute InquiryRepl inquiryReplForm, SmsMng smsMng, Inquiry inquiry, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		inquiryReplForm.setUpdrNo(admin.getUserNo());
		inquiryReplForm.setRegrNo(admin.getUserNo());
		inquiryReplForm.setWrtrCls("CM01001");
		int result = manageService.regInquiryRepl(inquiryReplForm);

		String iCpNo = inquiry.getTel();
		String iCpNo2 = iCpNo.replaceAll("-", "");
		String iNm = inquiry.getMemNm();
		smsMng.setSmsTxt(iNm + "님 1:1 문의 게시판에 답글이 등록되었습니다.");
		smsMng.setCallTo(iCpNo2);
		smsMng.setCallFrom("025410854");
		manageService.smsInsert(smsMng);

		return result;
	}

	/**
	 * 운영자 목록
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operatorList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView operatorList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListOperator(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Operator> operatorList = manageService.operatorList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("operatorList", operatorList);
		mav.setViewName("/admin/manage/operatorList");

		return mav;
	}

	/**
	 * 운영자 등록화면
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regOperator", method = RequestMethod.POST)
	public ModelAndView regOperator(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String procFlag = "reg";
		List<AuthGrp> authGrpList = manageService.authGrpList();

		List<Site> siteList = codeService.getSiteList();

		User user = new User();
		mav.addObject("user", user);
		mav.addObject("procFlag", procFlag);
		mav.addObject("authGrpList", authGrpList);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/regOperator");

		return mav;
	}

	/**
	 * id중복체크
	 *
	 * @param id
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/idDuplChkAjax", method = RequestMethod.POST)
	public @ResponseBody int idDuplChkAjax(@RequestParam(value = "id") String id, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {

		int result = manageService.idDuplChk(id);
		return result;
	}

	/**
	 * 운영자 등록
	 *
	 * @param user
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/regOptProc", method = RequestMethod.POST)
	public ModelAndView regOptProc(@ModelAttribute User user, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		String procFlag = "reg";

		Integer[] authGrpNo = user.getAuthGrpNo();

		UserAuthGrp userAuthGrp = new UserAuthGrp();
		userAuthGrp.setAuthGrpNo(authGrpNo);
		userAuthGrp.setRegrNo(admin.getUserNo());
		userAuthGrp.setUpdrNo(admin.getUserNo());
		user.setPwd(seed.encrypt(user.getPwd()));
		user.setRegrNo(admin.getUserNo());
		user.setUpdrNo(admin.getUserNo());
		user.setEmail(seed.encrypt(user.getEmail()));

		user.setSiteAuthNo(arrayToString(user.getTempSiteAuthNo(), ","));

		//유저,유저권한등록
		manageService.regUser(user, userAuthGrp);

		//권한그룹list
		List<AuthGrp> authGrpList = manageService.authGrpList();

		List<Site> siteList = codeService.getSiteList();

		user = new User();
		mav.addObject("user", user);
		mav.addObject("procFlag", procFlag);
		mav.addObject("authGrpList", authGrpList);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/regOperator");

		return mav;
	}

	/**
	 * 운영자 정보 수정
	 *
	 * @param user
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateOptProc", method = RequestMethod.POST)
	public ModelAndView updateOptProc(@ModelAttribute User user, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		SearchForm searchForm = new SearchForm();

		Integer[] authGrpNo = user.getAuthGrpNo();

		UserAuthGrp userAuthGrp = new UserAuthGrp();
		userAuthGrp.setAuthGrpNo(authGrpNo);
		userAuthGrp.setUserNo(user.getUserNo());
		userAuthGrp.setRegrNo(user.getUserNo());
		userAuthGrp.setUpdrNo(user.getUserNo());
		user.setPwd(seed.encrypt(user.getPwd()));
		user.setUpdrNo(admin.getUserNo());
		user.setEmail(seed.encrypt(user.getEmail()));

		user.setSiteAuthNo(arrayToString(user.getTempSiteAuthNo(), ","));

		//유저,유저권한수정
		manageService.updateUser(user, userAuthGrp);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListOperator(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Operator> operatorList = manageService.operatorList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("operatorList", operatorList);
		mav.setViewName("/admin/manage/operatorList");
		return mav;
	}

	/**
	 * 운영자 삭제
	 *
	 * @param searchForm
	 * @param user
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delOptProc", method = RequestMethod.POST)
	public ModelAndView delOptProc(@ModelAttribute User user, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		SearchForm searchForm = new SearchForm();

		UserAuthGrp userAuthGrp = new UserAuthGrp();
		userAuthGrp.setUserNo(user.getUserNo());

		//유저,유저권한삭제
		manageService.delUser(user, userAuthGrp);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListOperator(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Operator> operatorList = manageService.operatorList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("operatorList", operatorList);
		mav.setViewName("/admin/manage/operatorList");
		return mav;
	}

	/**
	 * 운영자 수정화면
	 *
	 * @param userNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateOperator", method = RequestMethod.POST)
	public ModelAndView updateOperator(@RequestParam(value = "userNo") int userNo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String procFlag = "update";
		List<AuthGrp> authGrpList = manageService.authGrpList();

		List<Site> siteList = codeService.getSiteList();

		User user = new User();
		user = manageService.getUser(userNo);

		user.setTempSiteAuthNo(user.getSiteAuthNo().split(","));

		user.setEmail(seed.decrypt(user.getEmail()));
		mav.addObject("user", user);
		mav.addObject("procFlag", procFlag);
		mav.addObject("authGrpList", authGrpList);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/regOperator");

		return mav;
	}

	/**
	 * sms 문구관리
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsManage", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView smsManage(@ModelAttribute SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<SmsMng> smsMngList = manageService.SmsMngList(searchForm);

		mav.addObject("smsMngList", smsMngList);
		mav.setViewName("/admin/manage/smsManage");

		return mav;
	}

	/*
		*//**
			 * sms문구관리 수정
			 *
			 * @param mngNo
			 * @param autoCls
			 * @param smsTxt
			 * @param locale
			 * @param model
			 * @param request
			 * @param response
			 * @return
			 * @throws UnsupportedEncodingException
			 */
	@RequestMapping(value = "/smsManageUpdate", method = RequestMethod.POST)
	public @ResponseBody int smsManageUpdate(

			//@ModelAttribute SmsMng smsMng,
			@RequestParam Integer[] mngNo, @RequestParam String[] autoCls, @RequestParam String[] smsTxt, @ModelAttribute SearchForm searchForm,
			Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		List<SmsMng> smsMngList = manageService.SmsMngList(searchForm);

		List<SmsMng> smsMngListCompare = new ArrayList<SmsMng>();

		int length = mngNo.length;

		//내용이 변경된것만 smsMngListCompare로 생성
		for (int i = 0; i < length; i++) {
			if (smsMngList.get(i).getMngNo().equals(mngNo[i])
					&& (!smsMngList.get(i).getAutoCls().equals(autoCls[i]) || !smsMngList.get(i).getSmsTxt().equals(smsTxt[i]))) {
				SmsMng sm = new SmsMng();
				sm.setMngNo(mngNo[i]);
				sm.setAutoCls(autoCls[i]);
				sm.setSmsTxt(smsTxt[i]);
				sm.setUpdrNo(admin.getUserNo());

				smsMngListCompare.add(sm);
			}
		}

		int result = manageService.smsManageUpdate(smsMngListCompare);
		return result;
	}

	/**
	 * SMS발송
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsSend", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView smsSend(@ModelAttribute("searchForm") SearchForm searchForm, @ModelAttribute("smsForm") SmsMng smsForm, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//		SmsMng smsMng=new SmsMng();

		//회원등급 리스트
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setGrdNm("전체");
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);
		memberGradeList.add(0, memberGrade);

		//site 리스트
		Site site = new Site();
		site.setSiteNm("전체");
		List<Site> siteList = codeService.getSiteList();
		siteList.add(0, site);

		List<SmsMng> SmsMngTitleList = manageService.SmsMngTitleList(searchForm);

		mav.addObject("SmsMngTitleList", SmsMngTitleList);
		mav.addObject("siteList", siteList);
		mav.addObject("memberGradeList", memberGradeList);
		mav.setViewName("/admin/manage/smsSend");

		return mav;
	}

	/**
	 * sms 등록
	 *
	 * @param smsForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsInsert", method = RequestMethod.POST)
	public @ResponseBody int smsInsert(@ModelAttribute("smsForm") SmsMng smsForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int result = 0;

		String[] callToArray = smsForm.getCallTo().split("\n");

		if (callToArray.length > 1) {

			for (int i = 0; i < callToArray.length; i++) {

				smsForm.setCallTo(callToArray[i].trim());
				manageService.smsInsert(smsForm);
				result++;
			}

		} else {
			result = manageService.smsInsert(smsForm);
		}
		return result;
	}

	/**
	 * SMS리스트 상세
	 *
	 * @param msgSeq
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsDetail", method = RequestMethod.POST)
	public ModelAndView smsDetail(@RequestParam(value = "msgSeq") int msgSeq, @ModelAttribute("searchForm") SearchForm searchForm, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		//		Admin admin =  (Admin)request.getSession().getAttribute("admin");

		SmsMng smsMng = manageService.smsDetail(msgSeq);
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		//관리자 이름
		String adminUserNm = (String) request.getSession().getAttribute("admin_userNm");

		//		List<SmsMng> smsMngList= manageService.SmsMngList(searchForm);

		mav.addObject("adminUserNm", adminUserNm);
		mav.addObject("smsMng", smsMng);
		mav.setViewName("/admin/manage/smsDetail");
		return mav;
	}

	/**
	 * SMS발송리스트
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsSendList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView smsSendList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		//		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListSmsSend(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<SmsMng> smsSendList = manageService.smsSendList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("smsSendList", smsSendList);
		//mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/smsSendList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,메시지,발송일,발송상태,수신자,발신자";
			//엑셀 title, value 맵핑순서
			String colMapping = "getMsgSeq,getSmsTxt,getSentDate,getCurState,getCallTo,getCallFrom";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", smsSendList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "smsSendList");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * 회원목록
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws InvocationTargetException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	@RequestMapping(value = "/memSearch", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView selectTableList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, @RequestParam(value = "hiddenSendType", required = false) String hiddenSendType)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();
		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		if (searchForm.getEmail() != null) {
			searchForm.setEmail(seed.encrypt(searchForm.getEmail()));
		}

		if (searchForm.getCpNo() != null) {
			searchForm.setCpNo(seed.encrypt(searchForm.getCpNo()));
		}

		searchForm.setTotalCnt(memberService.totalListMemInfo(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		List<Member> memberList = memberService.listMemInfo(searchForm);
		Member temp = new Member();
		List<Member> listMem = new ArrayList<Member>();
		if (memberList != null) {
			for (int i = 0; i < memberList.size(); i++) {
				temp = memberList.get(i);
				//나중에 주석 풀기
				//				temp.setEmail(seed.decrypt(temp.getEmail()));
				listMem.add(temp);
			}
		}

		//셀렉트박스 회원등급 리스트
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);

		Integer wdrwCnt = memberService.totalListWdrwCnt(searchForm);

		//view 전달객체 셋팅
		mav.addObject("hiddenSendType", hiddenSendType);
		mav.addObject("wdrwCnt", wdrwCnt);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("memberList", memberList);
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("searchForm", searchForm);
		mav.addObject("memberGradeList", memberGradeList);
		mav.setViewName("/admin/manage/memSearch");

		return mav;
	}

	/**
	 * 메일발송
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailSend", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mailSend(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//회원등급 리스트
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setGrdNm("전체");
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);
		memberGradeList.add(0, memberGrade);

		//site 리스트
		Site site = new Site();
		site.setSiteNm("전체");
		List<Site> siteList = codeService.getSiteList();
		siteList.add(0, site);

		MailManage mailManage = new MailManage();

		mav.addObject("mailManage", mailManage);
		mav.addObject("siteList", siteList);
		mav.addObject("memberGradeList", memberGradeList);
		mav.setViewName("/admin/manage/mailSend");
		return mav;
	}

	@RequestMapping(value = "/mailSendProc", method = RequestMethod.POST)
	public @ResponseBody int regMailProc(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("mailManage") MailManage mailManage) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		mailManage.setSndrEmail(seed.decrypt(admin.getEmail()));

		mailManage.setRegrNo(admin.getUserNo());
		mailManage.setUpdrNo(admin.getUserNo());
		mailManage.setSndrName(admin.getUserNm());

		mailManage.setTmplUrl(mailManage.getTmplUrl() == null ? "" : mailManage.getTmplUrl());
		mailManage.setAtchFile(mailManage.getAtchFile() == null ? "" : mailManage.getAtchFile());

		String mailSndType = mailManage.getRsvTgGb();
		int result = 0; // Ajax 통신에 의한 리턴 결과 값

		String from = mailManage.getSndrEmail(); // 발신자 메일
		String subject = mailManage.getTitle(); // 제목
		String message = mailManage.getTxtHtml(); // 내용

		if (mailSndType.equals("CM01201")) {
			/*
			 * ******************************************* 개별발송 *******************************************
			 */
			mailManage.setRsvTg("0");

			String to = mailManage.getRcvrEmail(); // 수신자 메일

			String[] arrToMail = to.split("\\r\\n"); // 다중메일발송일 경우를 위해 메일 주소 Enter값으로 구분

			if (arrToMail.length > 1) {
				for (int i = 0; i < arrToMail.length; i++) {
					// 성공 : 1, 실패 : 그외
					result = MailSend.sendMailFile(mailSender, subject, from, arrToMail[i], message, "", admin.getId());
				}
			} else {
				// 성공 : 1, 실패 : 그외
				result = MailSend.sendMailFile(mailSender, subject, from, to, message, "", admin.getId());
			}

			if (result > 0) {
				mailManage.setRcvrEmail(mailManage.getRcvrEmail());
				manageService.insertSndMail(mailManage);
			}

		} else if (mailSndType.equals("CM01202")) {
			/*
			 * ******************************************* 등급별 발송 *******************************************
			 */
			mailManage.setRsvTg(mailManage.getGetMember());

			List<MailManage> memGradeList = manageService.mailMemGradeList(mailManage);

			for (int i = 0; i < memGradeList.size(); i++) {

				result = MailSend.sendMailFile(mailSender, subject, from, memGradeList.get(i).getSndrEmail(), message, "",
						memGradeList.get(i).getRegUserNm());

				if (result > 0) {
					mailManage.setRcvrEmail(memGradeList.get(i).getSndrEmail());
					manageService.insertSndMail(mailManage);
				}

			}

		} else if (mailSndType.equals("CM01203")) {
			/*
			 * ******************************************* 브랜드별 발송 *******************************************
			 */
			mailManage.setRsvTg(mailManage.getGetBrnd());

			List<MailManage> memGradeList = manageService.mailMemGradeList(mailManage);

			for (int i = 0; i < memGradeList.size(); i++) {

				result = MailSend.sendMailFile(mailSender, subject, from, memGradeList.get(i).getSndrEmail(), message, "",
						memGradeList.get(i).getRegUserNm());

				if (result > 0) {
					mailManage.setRcvrEmail(memGradeList.get(i).getSndrEmail());
					manageService.insertSndMail(mailManage);
				}

			}

		} else if (mailSndType.equals("CM01204")) {
			/*
			 * ******************************************* 전체회원 발송 *******************************************
			 */
			mailManage.setRsvTg("999999");

			List<MailManage> memGradeList = manageService.mailMemGradeList(mailManage);

			for (int i = 0; i < memGradeList.size(); i++) {

				result = MailSend.sendMailFile(mailSender, subject, from, memGradeList.get(i).getSndrEmail(), message, "",
						memGradeList.get(i).getRegUserNm());

				if (result > 0) {
					mailManage.setRcvrEmail(memGradeList.get(i).getSndrEmail());
					manageService.insertSndMail(mailManage);
				}

			}

		} else {
			/*
			 * ******************************************* NEWSLETTER회원 발송 *******************************************
			 */

			//광고메일발송시 수신대상 상태값 확인 필요
			//			mailManage.setRsvTg("0");

		}

		return result;
	}

	/**
	 * 메일발송리스트
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mailSendList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mailSendList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListSndMail(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<MailManage> mailManageList = manageService.listSndMail(searchForm);

		mav.addObject("mailManageList", mailManageList);
		mav.addObject("pageHtml", pageHtml);
		mav.setViewName("/admin/manage/mailSendList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,제목,발송일,이메일,작성일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getTitle,getRegDts,getRcvrEmail,getSndDts";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", mailManageList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "mailManageList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	@RequestMapping(value = "/mailSendDetail")
	public ModelAndView mailSendDetail(@RequestParam(value = "siteNo", required = false) int siteNo, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		int sndNo = siteNo;

		MailManage mailManage = manageService.mailSendDetail(sndNo);

		mav.addObject("mailManage", mailManage);
		mav.setViewName("/admin/manage/mailSendDetail");

		return mav;
	}

	/**
	 * 메인관리
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mainManage/{siteNo}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mainManage(@PathVariable("siteNo") int siteNo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String siteNm = manageService.getSiteNm(siteNo);
		//		MainManage mainManage = new MainManage();//manageService.SmsMngList();
		//		mainManage.setSiteNo(10001);
		//		mainManage.setMainNo(1);
		//		mainManage.setLnkUrl("test");
		//		mainManage.setImgUrl("/lookbook/20150520/201505200148470892.jpg");
		//		mainManage.setTxt("테스트 입니다.");
		//		List<MainManage> mainManageList = new ArrayList<MainManage>();

		//		mainManageList.add(mainManage);
		//		mainManageList.add(mainManage);
		//		mainManageList.add(mainManage);
		List<MainManage> mainManageList = manageService.mainManageList(siteNo);

		//		MainManageForm mainManageForm = new MainManageForm();

		mav.addObject("siteNo", siteNo);
		mav.addObject("siteNm", siteNm);
		mav.addObject("mainManage", mainManageList);
		//		mav.addObject("mainManageForm", mainManageForm);
		mav.setViewName("/admin/manage/mainManage");

		return mav;
	}

	/**
	 * main 미리보기
	 *
	 * @param mainManageForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mainPreView", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mainPreView(@ModelAttribute("mainManageForm") MainManageForm mainManageForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("uploadImage", uploadImage);
		mav.addObject("mainManageForm", mainManageForm);
		mav.setViewName("/admin/popup/mainPreView");

		return mav;
	}

	/**
	 * feature 미리보기
	 *
	 * @param mainManageForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/featurePreView", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView featurePreView(@ModelAttribute("featureManageForm") FeatureManageForm featureManageForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("uploadImage", uploadImage);
		mav.addObject("featureManageForm", featureManageForm);
		mav.setViewName("/admin/popup/featurePreView");

		return mav;
	}

	/**
	 * 메인관리 등록
	 *
	 * @param mainManageForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mainManageRegAjax", method = RequestMethod.POST)
	public @ResponseBody int mainManageRegAjax(@ModelAttribute("mainManageForm") MainManageForm mainManageForm, Locale locale,
			@RequestParam(value = "sortNo", required = false) List<Integer> sortNos,
			@RequestParam(value = "mainNo", required = false) List<Integer> mainNos, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		mainManageForm.setUpdrNo(admin.getUserNo());
		mainManageForm.setRegrNo(admin.getUserNo());

		List<MainManage> mainManage = mainManageForm.getMainManage();

		if (mainManage != null) {
			for (int j = 0; j < mainManage.size(); j++) {

				for (int i = 0; i < sortNos.size(); i++) {
					if (mainManage.get(j).getMainNo().equals(mainNos.get(i))) {
						mainManage.get(j).setSortNo(sortNos.get(i));
					}
				}
			}
		}

		mainManageForm.setMainManage(mainManage);

		int result = manageService.mainManageReg(mainManageForm);
		return result;
	}

	@RequestMapping(value = "/featureManageRegAjax", method = RequestMethod.POST)
	public @ResponseBody int featureManageRegAjax(@ModelAttribute("featureManageForm") FeatureManageForm featureManageForm, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		featureManageForm.setUpdrNo(admin.getUserNo());
		featureManageForm.setRegrNo(admin.getUserNo());

		int result = manageService.featureManageReg(featureManageForm);
		return result;
	}

	/**
	 * 메인관리 메인번호 생성
	 *
	 * @param collabo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/createMainNoAjax", method = RequestMethod.POST)
	public @ResponseBody int createMainNoAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		int result = manageService.getMaxMainNo();
		return result;
	}

	/**
	 * 메인관리 메인번호 삭제
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delMainNoAjax", method = RequestMethod.POST)
	public @ResponseBody int delMainNoAjax(@RequestParam(value = "targetMainNo") int targetMainNo, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		int result = manageService.delMainNo(targetMainNo);
		return result;
	}

	/**
	 * FEATURE관리
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/featureManage/{siteNo}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView featureManage(@ModelAttribute("featureManageForm") FeatureManageForm featureManageForm, @PathVariable("siteNo") int siteNo,
			Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String siteNm = manageService.getSiteNm(siteNo);

		String sex = featureManageForm.getSex() == null ? "M" : featureManageForm.getSex();

		List<FeatureManage> featureManageList = manageService.featureManageList(siteNo, sex);

		mav.addObject("siteNo", siteNo);
		mav.addObject("siteNm", siteNm);
		mav.addObject("sex", sex);
		mav.addObject("featureManage", featureManageList);
		mav.setViewName("/admin/manage/featureManage");

		return mav;
	}

	/**
	 * feature값체크
	 *
	 * @param featureManageForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changValueCheckAjax", method = RequestMethod.POST)
	public @ResponseBody boolean changValueCheckAjax(@ModelAttribute("featureManageForm") FeatureManageForm featureManageForm, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//		Admin admin =  (Admin)request.getSession().getAttribute("admin");
		//		collabo.setUpdrNo(admin.getUserNo());

		List<FeatureManage> featureManageFormList = featureManageForm.getFeatureManage();

		String sex = featureManageForm.getSex() == null ? "M" : featureManageForm.getSex();
		List<FeatureManage> featureManageList = manageService.featureManageList(featureManageForm.getSiteNo(), sex);

		for (int i = 0; i < featureManageFormList.size(); i++) {
			FeatureManage formValue = featureManageFormList.get(i);
			FeatureManage serverValue = null;
			try {
				serverValue = featureManageList.get(i);
			} catch (IndexOutOfBoundsException e) {
				FeatureManage temp = new FeatureManage();
				temp.setFeatureNo(i + 1);
				temp.setImgUrl("");
				temp.setLnkUrl("");
				temp.setTxt("");
				featureManageList.add(i, temp);
				serverValue = featureManageList.get(i);
			}

			System.out.println(formValue.getFeatureNo() + "--/////////--" + serverValue.getFeatureNo());
			System.out.println(formValue.getFeatureNo() != serverValue.getFeatureNo());
			if (formValue.getFeatureNo() != serverValue.getFeatureNo())
				return true;

			System.out.println(formValue.getImgUrl() + "--/////////--" + serverValue.getImgUrl());
			System.out.println(!formValue.getImgUrl().equals(serverValue.getImgUrl()));
			if (!formValue.getImgUrl().trim().equals(serverValue.getImgUrl().trim()))
				return true;

			System.out.println(formValue.getLnkUrl() + "--/////////--" + serverValue.getLnkUrl());
			System.out.println(!formValue.getLnkUrl().equals(serverValue.getLnkUrl()));
			if (!formValue.getLnkUrl().trim().equals(serverValue.getLnkUrl().trim()))
				return true;

			System.out.println(formValue.getTxt() + "--/////////--" + serverValue.getTxt());
			System.out.println(!formValue.getTxt().equals(serverValue.getTxt()));
			if (!formValue.getTxt().trim().equals(serverValue.getTxt().trim()))
				return true;
		}

		boolean result = false;//manageService.collaboDelete(collabo);
		return result;
	}

	/**
	 * collaboration리스트
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/collaborationList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView collaborationList(@ModelAttribute("searchForm") SearchForm searchForm,
			@RequestParam(value = "hiddenSiteNo", required = false) String hiddenSiteNo,
			@RequestParam(value = "hiddenStrDtm", required = false) String hiddenStrDtm,
			@RequestParam(value = "hiddenEndDtm", required = false) String hiddenEndDtm,
			@RequestParam(value = "hiddenSearchText", required = false) String hiddenSearchText, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		if (hiddenSiteNo != null)
			searchForm.setSiteNo(hiddenSiteNo);
		if (hiddenStrDtm != null)
			searchForm.setSearchStrDtm(hiddenStrDtm);
		if (hiddenEndDtm != null)
			searchForm.setSearchEndDtm(hiddenEndDtm);
		if (hiddenSearchText != null)
			searchForm.setSearchText(hiddenSearchText);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListCollabo(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<IntgBoard> collaboration = manageService.collaboList(searchForm);

		for (int i = 0; i < collaboration.size(); i++) {
			String upt = collaboration.get(i).getUpdDts().substring(0, 10).replaceAll("-", ".");
			collaboration.get(i).setUpdDts(upt);
		}
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("collaborationList", collaboration);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/collaborationList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,상태,제목,작성자,작성일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getDispYn,getTitle,getRegUserNm,getUpdDts";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", collaboration);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "collaborationList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * COLLABORATION 상세
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/collaboDetail", method = RequestMethod.POST)
	public ModelAndView collaboDetail(@RequestParam int txtNo, @RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm,
			@RequestParam String hiddenEndDtm, @RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard collaboration = manageService.collaboDetail(txtNo);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//시즌 리스트
		List<Category> season = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);

		//콜라보레이션 명 리스트
		List<String> collaboNm = manageService.getCollabo();

		String clbltnNm = "";
		String seasonCd = "";
		if (StringUtils.isNotEmpty(request.getParameter("clbltnNm"))) {
			clbltnNm = request.getParameter("clbltnNm");
			seasonCd = request.getParameter("seasonCd");

			SearchForm searchForm = new SearchForm();
			searchForm.setClbltnNm(clbltnNm);
			searchForm.setSeasonCode(seasonCd);
			searchForm.setBrand("");

			//상품목록
			List<Goods> goodsList = goodsService.listGoodsCategoryDisplay(searchForm);

			mav.addObject("goodsList", goodsList);
			mav.addObject("clbltnNm", clbltnNm);
		}

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("collabo", collaboration);
		mav.addObject("season", season);
		mav.addObject("collaboNm", collaboNm);
		mav.setViewName("/admin/manage/collaboDetail");

		return mav;
	}

	/**
	 * collaboration 삭제
	 *
	 * @param inquiryReplForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/collaboDeleteAjax", method = RequestMethod.POST)
	public @ResponseBody int collaboDeleteAjax(@ModelAttribute IntgBoard collabo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		collabo.setUpdrNo(admin.getUserNo());

		int result = manageService.collaboDelete(collabo);
		return result;
	}

	/**
	 * collaboration 수정
	 *
	 * @param collabo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/collaboUpdateAjax", method = RequestMethod.POST)
	public @ResponseBody int collaboUpdateAjax(@ModelAttribute IntgBoard collabo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		collabo.setUpdrNo(admin.getUserNo());

		int result = manageService.collaboUpdate(collabo);
		return result;
	}

	/**
	 * collaboration 등록화면
	 *
	 * @param txtNo
	 * @param hiddenSiteNo
	 * @param hiddenStrDtm
	 * @param hiddenEndDtm
	 * @param hiddenSearchText
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regCollabo", method = RequestMethod.POST)
	public ModelAndView regCollabo(@RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm, @RequestParam String hiddenEndDtm,
			@RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard collabo = new IntgBoard();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//시즌 리스트
		List<Category> season = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);

		//콜라보레이션 명 리스트
		List<String> collaboNm = manageService.getCollabo();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("collabo", collabo);
		mav.addObject("season", season);
		mav.addObject("collaboNm", collaboNm);
		mav.setViewName("/admin/manage/regCollabo");

		return mav;
	}

	/**
	 * collaboration 등록
	 *
	 * @param collabo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/collaboRegAjax", method = RequestMethod.POST)
	public @ResponseBody int collaboRegAjax(@ModelAttribute IntgBoard collabo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		collabo.setUpdrNo(admin.getUserNo());

		int result = manageService.collaboReg(collabo);
		return result;
	}

	/**
	 * news리스트
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/newsList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView newsList(@ModelAttribute("searchForm") SearchForm searchForm,
			@RequestParam(value = "hiddenSiteNo", required = false) String hiddenSiteNo,
			@RequestParam(value = "hiddenStrDtm", required = false) String hiddenStrDtm,
			@RequestParam(value = "hiddenEndDtm", required = false) String hiddenEndDtm,
			@RequestParam(value = "hiddenNewsType", required = false) String hiddenNewsType,
			@RequestParam(value = "hiddenSearchGb", required = false) String hiddenSearchGb,
			@RequestParam(value = "hiddenSearchText", required = false) String hiddenSearchText, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		if (hiddenSiteNo != null)
			searchForm.setSiteNo(hiddenSiteNo);
		if (hiddenStrDtm != null)
			searchForm.setSearchStrDtm(hiddenStrDtm);
		if (hiddenEndDtm != null)
			searchForm.setSearchEndDtm(hiddenEndDtm);
		if (hiddenNewsType != null)
			searchForm.setNewsType(hiddenNewsType);
		if (hiddenSearchGb != null)
			searchForm.setSearchGb(hiddenSearchGb);
		if (hiddenSearchText != null)
			searchForm.setSearchText(hiddenSearchText);

		//뉴스타입 코드리스트
		Code code = new Code();
		code.setCdNm("전체");
		List<Code> newsTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);
		newsTypeList.add(0, code);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListNews(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<News> news = manageService.newsList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("siteList", siteList);
		mav.addObject("newsList", news);
		mav.addObject("newsTypeList", newsTypeList);
		mav.setViewName("/admin/manage/newsList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,상태,분류,제목,작성자,작성일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getDispYn,getTxtTp,getTitle,getRegUserNm,getUpdDts";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", news);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "newsList");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * news등록화면
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regNews", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView regNews(@RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm, @RequestParam String hiddenEndDtm,
			@RequestParam String hiddenNewsType, @RequestParam String hiddenSearchGb, @RequestParam String hiddenSearchText, Locale locale,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//news분류 리스트
		List<Code> newsTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);

		//news구분 리스트
		List<Code> newsClsList = codeService.listCd(Constants.NEWS_CLS_CODE);

		int index = 0;
		for (Code nt : newsClsList) {
			if (nt.getCdNo().equals("CM00503")) {
				newsClsList.remove(index);
				break;
			}
			index += 1;
		}

		News newsForm = new News();

		mav.addObject("siteList", siteList);
		mav.addObject("newsForm", newsForm);
		mav.addObject("newsTypeList", newsTypeList);
		mav.addObject("newsClsList", newsClsList);
		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenNewsType", hiddenNewsType);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.setViewName("/admin/manage/regNews");

		return mav;
	}

	/**
	 * News 등록
	 *
	 * @param newsForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regNewsProc", method = RequestMethod.POST)
	public @ResponseBody int regNewsProc(@ModelAttribute("newsForm") News newsForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (newsForm.getTxtCls() == null) {
			newsForm.setTxtCls("");
		}

		if (newsForm.getMovUrl() != null) {
			newsForm.setMovUrl(convertGetSrc(newsForm.getMovUrl()));
		}

		if (newsForm.getNewsCont() != null) {
			for (int i = 0; i < newsForm.getNewsCont().size(); i++) {
				if (newsForm.getNewsCont().get(i).getAddContType().equals("CM00502")) {
					String aUrl = newsForm.getNewsCont().get(i).getAddContAddr();

					newsForm.getNewsCont().get(i).setAddContAddr(convertGetSrc(aUrl));
				}
			}
		}

		newsForm.setUpdrNo(admin.getUserNo());
		newsForm.setRegrNo(admin.getUserNo());

		int result = manageService.regNewsProc(newsForm);
		return result;
	}

	/**
	 * news상세화면
	 *
	 * @param txtNo
	 * @param hiddenSiteNo
	 * @param hiddenStrDtm
	 * @param hiddenEndDtm
	 * @param hiddenSearchText
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/newsDetail", method = RequestMethod.POST)
	public ModelAndView newsDetail(@RequestParam int txtNo, @RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm,
			@RequestParam String hiddenEndDtm, @RequestParam String hiddenNewsType, @RequestParam String hiddenSearchGb,
			@RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		News newsForm = manageService.newsDetail(txtNo);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//news분류 리스트
		List<Code> newsTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);

		//news구분 리스트
		List<Code> newsClsList = codeService.listCd(Constants.NEWS_CLS_CODE);

		int index = 0;
		for (Code nt : newsClsList) {
			if (nt.getCdNo().equals("CM00503")) {
				newsClsList.remove(index);
				break;
			}
			index += 1;
		}

		mav.addObject("siteList", siteList);
		mav.addObject("newsForm", newsForm);
		mav.addObject("newsTypeList", newsTypeList);
		mav.addObject("newsClsList", newsClsList);
		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenNewsType", hiddenNewsType);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.setViewName("/admin/manage/newsDetail");

		return mav;
	}

	/**
	 * News 수정
	 *
	 * @param newsForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateNewsProc", method = RequestMethod.POST)
	public @ResponseBody int updateNewsProc(@ModelAttribute("newsForm") News newsForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (newsForm.getTxtCls() == null) {
			newsForm.setTxtCls("");
		}

		if (newsForm.getMovUrl() != null) {
			newsForm.setMovUrl(convertGetSrc(newsForm.getMovUrl()));
		}

		if (newsForm.getNewsCont() != null) {
			for (int i = 0; i < newsForm.getNewsCont().size(); i++) {
				if (newsForm.getNewsCont().get(i).getAddContType().equals("CM00502")) {
					String aUrl = newsForm.getNewsCont().get(i).getAddContAddr();

					newsForm.getNewsCont().get(i).setAddContAddr(convertGetSrc(aUrl));
				}
			}
		}

		newsForm.setUpdrNo(admin.getUserNo());

		int result = manageService.updateNewsProc(newsForm);
		return result;
	}

	/**
	 * news 삭제
	 *
	 * @param newsForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteNewsProc", method = RequestMethod.POST)
	public @ResponseBody int deleteNewsProc(@ModelAttribute("newsForm") News newsForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int result = manageService.deleteNewsProc(newsForm);
		return result;
	}

	/**
	 * lookbook리스트
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbookList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView lookbookList(@ModelAttribute("searchForm") SearchForm searchForm,
			@RequestParam(value = "hiddenSiteNo", required = false) String hiddenSiteNo,
			@RequestParam(value = "hiddenStrDtm", required = false) String hiddenStrDtm,
			@RequestParam(value = "hiddenEndDtm", required = false) String hiddenEndDtm,
			@RequestParam(value = "hiddenSearchGb", required = false) String hiddenSearchGb,
			@RequestParam(value = "hiddenSearchText", required = false) String hiddenSearchText, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		if (hiddenSiteNo != null)
			searchForm.setSiteNo(hiddenSiteNo);
		if (hiddenStrDtm != null)
			searchForm.setSearchStrDtm(hiddenStrDtm);
		if (hiddenEndDtm != null)
			searchForm.setSearchEndDtm(hiddenEndDtm);
		if (hiddenSearchGb != null)
			searchForm.setSearchGb(hiddenSearchGb);
		if (hiddenSearchText != null)
			searchForm.setSearchText(hiddenSearchText);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListLookbook(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<IntgBoard> lookbook = manageService.lookbookList(searchForm);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("siteList", siteList);
		mav.addObject("lookbookList", lookbook);
		mav.setViewName("/admin/manage/lookbookList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,상태,제목,작성자,작성일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getDispYn,getTitle,getRegUserNm,getUpdDts";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", lookbook);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "lookbookList");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * lookbook 상세화면
	 *
	 * @param txtNo
	 * @param hiddenSiteNo
	 * @param hiddenStrDtm
	 * @param hiddenEndDtm
	 * @param hiddenSearchText
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbookDetail", method = RequestMethod.POST)
	public ModelAndView lookbookDetail(@RequestParam int txtNo, @RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm,
			@RequestParam String hiddenEndDtm, @RequestParam String hiddenSearchGb, @RequestParam String hiddenSearchText, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard lookbook = manageService.lookbookDetail(txtNo);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("lookbook", lookbook);
		mav.setViewName("/admin/manage/lookbookDetail");

		return mav;
	}

	/**
	 * Lookbook 등록화면
	 *
	 * @param hiddenSiteNo
	 * @param hiddenStrDtm
	 * @param hiddenEndDtm
	 * @param hiddenSearchGb
	 * @param hiddenSearchText
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regLookbook", method = RequestMethod.POST)
	public ModelAndView regLookbook(@RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm, @RequestParam String hiddenEndDtm,
			@RequestParam String hiddenSearchGb, @RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard lookbook = new IntgBoard();
		//		List<IntgBoardCnts> intgBoardCnts= new ArrayList<IntgBoardCnts>();
		//		IntgBoardCnts test = new IntgBoardCnts();
		//		test.setImgUrl("etstsetset");
		//		intgBoardCnts.add(0,test );
		//		lookbook.setIntgBoardCnts(intgBoardCnts);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("lookbook", lookbook);
		mav.setViewName("/admin/manage/regLookbook");

		return mav;
	}

	/**
	 * lookbook 등록
	 *
	 * @param collabo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbookRegAjax", method = RequestMethod.POST)
	public @ResponseBody int lookbookRegAjax(@ModelAttribute("lookbook") IntgBoard lookbook, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		lookbook.setRegrNo(admin.getUserNo());
		lookbook.setUpdrNo(admin.getUserNo());

		int result = manageService.lookbookReg(lookbook);
		return result;
	}

	/**
	 * lookbook 수정
	 *
	 * @param lookbook
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbookUpdateAjax", method = RequestMethod.POST)
	public @ResponseBody int lookbookUpdateAjax(@ModelAttribute("lookbook") IntgBoard lookbook, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		lookbook.setRegrNo(admin.getUserNo());
		lookbook.setUpdrNo(admin.getUserNo());

		int result = manageService.lookbookUpdate(lookbook);
		return result;
	}

	/**
	 * lookbook 삭제
	 *
	 * @param lookbook
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbookDelAjax", method = RequestMethod.POST)
	public @ResponseBody int lookbookDelAjax(@ModelAttribute("lookbook") IntgBoard lookbook, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		lookbook.setRegrNo(admin.getUserNo());
		lookbook.setUpdrNo(admin.getUserNo());

		int result = manageService.lookbookDel(lookbook);
		return result;
	}

	/**
	 * 채용공고 리스트
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/workWithUsList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView workWithUsList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		// site 리스트
		List<Site> siteList = codeService.getSiteList();

		// 검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListWorkWithus(searchForm));

		// 페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<WorkWithUs> workWithUsList = manageService.listWorkWithus(searchForm);

		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("workWithUsList", workWithUsList);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/manage/workWithUsList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "No,상태,구분,지역,모집분야,시작일,종료일,작성자,작성일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getRnum,getWithusStat,getWithusCls,getWithusArea,getWithusCl,getStrDts,getEndDts,getRegUserNm,getRegDts";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", workWithUsList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "workWithUsList");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * 채용공고 등록
	 *
	 * @param cnslNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	// @RequestMapping(value = "/workWithUsDetail" , method =
	// RequestMethod.POST)
	@RequestMapping(value = "/regWorkWithUs")
	public ModelAndView regWorkWithUs(@RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm, @RequestParam String hiddenEndDtm,
			@RequestParam String hiddenSearchGb, @RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		// site 리스트
		List<Site> siteList = codeService.getSiteList();

		WorkWithUs workWithUsForm = new WorkWithUs();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("workWithUsForm", workWithUsForm);
		mav.setViewName("/admin/manage/regWorkWithUs");
		return mav;
	}

	@RequestMapping(value = "/regWorkWithUsProc", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody int regWorkWithUsProc(@ModelAttribute("workWithUsForm") WorkWithUs workWithUs, @RequestParam String type,
			@RequestParam String withusSeq, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		int result = 0;

		if (type != null) {

			// 관리자 이름
			Admin admin = (Admin) request.getSession().getAttribute("admin");

			if ("Add".equals(type)) {

				workWithUs.setRegrNo(admin.getRegrNo());
				workWithUs.setUpdrNo(admin.getRegrNo());

				result = manageService.insertWorkWithus(workWithUs);

			} else if ("Mod".equals(type)) {

				workWithUs.setRegrNo(admin.getRegrNo());
				workWithUs.setUpdrNo(admin.getRegrNo());

				result = manageService.updateWorkWithUs(workWithUs);

			} else {

				result = manageService.deleteWorkWithUsProc(workWithUs);
			}
		} else {
			result = 0;
		}

		return result;

	}

	/**
	 * 채용공고 상세
	 *
	 * @param cnslNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	// @RequestMapping(value = "/workWithUsDetail" , method =
	// RequestMethod.POST)
	@RequestMapping(value = "/workWithUsDetail", method = RequestMethod.POST)
	public ModelAndView workWithUsDetail(@RequestParam int withusSeq, @RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm,
			@RequestParam String hiddenEndDtm, @RequestParam String hiddenNewsType, @RequestParam String hiddenSearchGb,
			@RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		WorkWithUs workWithUsForm = manageService.workWithUsDetail(withusSeq);

		// site 리스트
		List<Site> siteList = codeService.getSiteList();

		mav.addObject("siteList", siteList);
		mav.addObject("workWithUsForm", workWithUsForm);

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenNewsType", hiddenNewsType);
		mav.addObject("hiddenSearchGb", hiddenSearchGb);
		mav.addObject("hiddenSearchText", hiddenSearchText);

		mav.setViewName("/admin/manage/workWithUsDetail");
		return mav;
	}

	/**
	 * Carhartt 특화 메뉴 CARHARTT RADIO 리스트 화면 @ModelAttribute("saerchForm") SearchForm searchForm
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/carharttRadioList")
	public ModelAndView carharttRadioList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		// 검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListCarharttRadio(searchForm));

		// 페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<CarharttRadioForm> carharttRadioList = manageService.carharttRadioList(searchForm);

		mav.addObject("uploadImage", uploadImage);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("carharttRadioList", carharttRadioList);
		mav.setViewName("/admin/manage/carharttRadioList");
		return mav;
	}

	/**
	 * Carhartt 특화 메뉴 CARHARTT RADIO 수정 화면 @ModelAttribute("carharttRadioForm") CarharttRadioForm carharttRadioForm
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/carharttRadioDetail")
	public ModelAndView carharttRadioDetail(@RequestParam(value = "radioNo", required = false) int radioNo, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		CarharttRadioForm carharttRadioForm = manageService.carharttRadioDetail(radioNo);

		carharttRadioForm.setRadioNo(radioNo);
		mav.addObject("carharttRadioForm", carharttRadioForm);
		mav.setViewName("/admin/manage/carharttRadioDetail");
		return mav;
	}

	/**
	 * Carhartt 특화 메뉴 CARHARTT RADIO 등록 화면 @ModelAttribute("carharttRadioForm") CarharttRadioForm carharttRadioForm
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/carharttRadioReg")
	public ModelAndView carharttRadioReg(@ModelAttribute("carharttRadioForm") CarharttRadioForm carharttRadioForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		String thisDay = sdformat.format(date);

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		mav.addObject("adminNm", admin.getUserNm());
		mav.addObject("adminNo", admin.getRegrNo());
		mav.addObject("thisDay", thisDay);
		mav.setViewName("/admin/manage/carharttRadioReg");
		return mav;
	}

	@RequestMapping(value = "/carharttRadioProc", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody int carharttRadioProc(@ModelAttribute("carharttRadioForm") CarharttRadioForm carharttRadioForm, @RequestParam String type,
			Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		int result = 0;

		if (type != null) {

			if (carharttRadioForm.getRadioLink() != null) {
				String aUrl = carharttRadioForm.getRadioLink();
				carharttRadioForm.setRadioLink(convertGetSrc(aUrl));
			}

			if ("Add".equals(type)) {

				carharttRadioForm.setRegrNo(carharttRadioForm.getUpdrNo());
				carharttRadioForm.setRegDts(carharttRadioForm.getUpdDts());

				result = manageService.insertCarharttRadio(carharttRadioForm);

			} else if ("Mod".equals(type)) {
				result = manageService.carharttRadioUpdate(carharttRadioForm);

			} else {
				result = manageService.carharttRadioDelete(carharttRadioForm);
			}
		} else {
			result = 0;
		}

		return result;

	}

	/**
	 * Obey 특화 메뉴 Awareness 리스트 화면
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessList", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView obeyAwarenessList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListawnes(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Awnes> awnesList = manageService.getAwnesList(searchForm);

		mav.addObject("uploadImage", uploadImage);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("awnesList", awnesList);
		mav.setViewName("/admin/manage/obeyAwarenessList");
		return mav;
	}

	/**
	 * Obey 특화 메뉴 Awareness 등록 화면
	 *
	 * @param awnesForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessReg", method = RequestMethod.POST)
	public ModelAndView obeyAwarenessReg(@ModelAttribute("awnesForm") Awnes awnesForm,
			//			@RequestParam int awnexNo,
			Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		ModelAndView mav = new ModelAndView();
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		String thisDay = sdformat.format(date);

		//awareness분류 리스트
		List<Code> awnesTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);

		//awareness구분 리스트
		List<Code> awnesClsList = codeService.listCd(Constants.NEWS_CLS_CODE);

		mav.addObject("admin", admin);
		mav.addObject("thisDay", thisDay);
		mav.addObject("awnesTypeList", awnesTypeList);
		mav.addObject("awnesClsList", awnesClsList);
		mav.addObject("awnesClsListJson", gson.toJson(awnesClsList));
		mav.setViewName("/admin/manage/obeyAwarenessReg");
		return mav;
	}

	/**
	 * obeyAwareness 상세
	 *
	 * @param awnesForm
	 * @param awnexNo
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessDetail", method = RequestMethod.POST)
	public ModelAndView obeyAwarenessDetail(
			//			@ModelAttribute("awnesForm") Awnes awnesForm,
			@RequestParam int awnesNo, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		ModelAndView mav = new ModelAndView();

		//awareness분류 리스트
		List<Code> awnesTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);

		//awareness구분 리스트
		List<Code> awnesClsList = codeService.listCd(Constants.NEWS_CLS_CODE);

		Awnes awnesForm = manageService.getAwnes(awnesNo);

		mav.addObject("awnesForm", awnesForm);
		mav.addObject("awnesTypeList", awnesTypeList);
		mav.addObject("awnesClsList", awnesClsList);
		mav.addObject("awnesFormJson", gson.toJson(awnesForm));
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/admin/manage/obeyAwarenessDetail");
		return mav;
	}

	/**
	 * Obey 공개 상태 체크
	 *
	 * @param inquiryReplForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chkDspAjax", method = RequestMethod.POST)
	public @ResponseBody int chkDspAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		int result = manageService.chkDsp();

		return result;
	}

	/**
	 * Obey Awareness 등록
	 *
	 * @param inquiryReplForm
	 * @param locale
	 * @param model8
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessRegAjax", method = RequestMethod.POST)
	public @ResponseBody int obeyAwarenessRegAjax(@ModelAttribute("awnesForm") Awnes awnesForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		if (awnesForm.getAwnesCont() != null) {
			for (int i = 0; i < awnesForm.getAwnesCont().size(); i++) {
				if (awnesForm.getAwnesCont().get(i).getContCls().equals("CM00502")) {
					String aUrl = awnesForm.getAwnesCont().get(i).getContUrl();

					awnesForm.getAwnesCont().get(i).setContUrl(convertGetSrc(aUrl));
				}
			}
		}

		awnesForm.setUpdrNo(admin.getUserNo());
		awnesForm.setRegrNo(admin.getUserNo());

		int result = manageService.obeyAwarenessReg(awnesForm);

		return result;
	}

	/**
	 * Obey Awareness 수정
	 *
	 * @param awnesForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessUpdateAjax", method = RequestMethod.POST)
	public @ResponseBody int obeyAwarenessUpdateAjax(@ModelAttribute("awnesForm") Awnes awnesForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		awnesForm.setUpdrNo(admin.getUserNo());
		awnesForm.setRegrNo(admin.getUserNo());

		if (awnesForm.getAwnesCont() != null) {
			for (int i = 0; i < awnesForm.getAwnesCont().size(); i++) {
				if (awnesForm.getAwnesCont().get(i).getContCls().equals("CM00502")) {
					String aUrl = awnesForm.getAwnesCont().get(i).getContUrl();

					awnesForm.getAwnesCont().get(i).setContUrl(convertGetSrc(aUrl));
				}
			}
		}

		int result = manageService.obeyAwarenessUpdate(awnesForm);

		return result;
	}

	/**
	 * Obey Awareness 삭제
	 *
	 * @param awnesForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/obeyAwarenessDelAjax", method = RequestMethod.POST)
	public @ResponseBody int obeyAwarenessDelAjax(@ModelAttribute("awnesForm") Awnes awnesForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		awnesForm.setUpdrNo(admin.getUserNo());
		awnesForm.setRegrNo(admin.getUserNo());

		int result = manageService.obeyAwarenessDel(awnesForm);

		return result;
	}

	public String arrayToString(String[] array, String delimiter) {
		StringBuilder arTostr = new StringBuilder();
		if (array.length > 0) {
			arTostr.append(array[0]);
			for (int i = 1; i < array.length; i++) {
				arTostr.append(delimiter);
				arTostr.append(array[i]);
			}
		}
		return arTostr.toString();
	}

	@RequestMapping(value = "/specialList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView specialList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();
		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		searchForm.setBoardClcd("CM00803"); //스페셜

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalBoardCnt(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<IntgBoard> specialList = manageService.boardList(searchForm);

		for (int i = 0; i < specialList.size(); i++) {
			String upt = specialList.get(i).getUpdDts().substring(0, 10).replaceAll("-", ".");
			specialList.get(i).setUpdDts(upt);
		}
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("specialList", specialList);
		mav.addObject("siteList", siteList);
		mav.setViewName("/admin/manage/specialList");

		//엑셀다운로드 view 전달객체 셋팅
		/*
		 * if(searchForm.isExcel()){ //엑셀 title String colName = "No,상태,제목,작성자,작성일"; //엑셀 title, value 맵핑순서 String colMapping = "getRnum,getDispYn,getTitle,getRegUserNm,getUpdDts"; mav.addObject("colName", colName); mav.addObject("colMapping", colMapping); mav.addObject("colValue", collaboration); //엑셀 명(영문만 가능) mav.addObject("excelName", "collaborationList"); mav.setViewName("excelDownload"); }
		 */

		return mav;
	}

	@RequestMapping(value = "/specialDetail")
	public ModelAndView specialDetail(@RequestParam int txtNo, @RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm,
			@RequestParam String hiddenEndDtm, @RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard collaboration = manageService.collaboDetail(txtNo);

		//상세 상품 리스트
		SearchForm searchForm = new SearchForm();
		searchForm.setImgSeq(collaboration.getImgSeq());
		List<Goods> goodsList = manageService.listSpecialGoods(searchForm);

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("collabo", collaboration);
		mav.addObject("goodsList", goodsList);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin/manage/specialDetail");

		return mav;
	}

	@RequestMapping(value = "/specialReg", method = RequestMethod.POST)
	public ModelAndView specialReg(@RequestParam String hiddenSiteNo, @RequestParam String hiddenStrDtm, @RequestParam String hiddenEndDtm,
			@RequestParam String hiddenSearchText, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		IntgBoard collabo = new IntgBoard();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		//시즌 리스트
		List<Category> season = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);

		//콜라보레이션 명 리스트
		List<String> collaboNm = manageService.getCollabo();

		mav.addObject("hiddenSiteNo", hiddenSiteNo);
		mav.addObject("hiddenStrDtm", hiddenStrDtm);
		mav.addObject("hiddenEndDtm", hiddenEndDtm);
		mav.addObject("hiddenSearchText", hiddenSearchText);
		mav.addObject("siteList", siteList);
		mav.addObject("collabo", collabo);
		mav.addObject("season", season);
		mav.addObject("collaboNm", collaboNm);
		mav.setViewName("/admin/manage/specialReg");

		return mav;
	}

	@RequestMapping(value = "/specialRegAjax", method = RequestMethod.POST)
	public @ResponseBody int specialRegAjax(@ModelAttribute IntgBoard board, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		board.setUpdrNo(admin.getUserNo());
		board.setBoardClcd("CM00803");

		int result = manageService.insertBoard(board);
		return result;
	}

	@RequestMapping(value = "/specialGoodsAddAjax", method = RequestMethod.POST)
	public @ResponseBody int specialGoodsAddAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam String ubiGdsNo, @RequestParam Integer imgSeq) throws Exception {

		int result = 0;
		for (int i = 0; i < StringUtils.split(ubiGdsNo, ",").length; i++) {
			System.out.println("StringUtils====" + ubiGdsNo);
			System.out.println("StringUtils.split(ubiGdsNo)[i]====" + StringUtils.split(ubiGdsNo, ",")[i]);

			BoardGds boardGds = new BoardGds();
			boardGds.setImgSeq(imgSeq);
			boardGds.setUbiGdsNo(StringUtils.split(ubiGdsNo, ",")[i]);
			boardGds.setPrir("0");
			boardGds.setGdsNm(" ");
			boardGds.setSlPrc(0);
			boardGds.setLinkUrl(" ");
			boardGds.setImgUrl(" ");
			result = manageService.regBoardGds(boardGds);
		}
		return result;
	}

	@RequestMapping(value = "/saveGoodsDisplaySpecial", method = RequestMethod.POST)
	public ModelAndView saveGoodsDisplayCollabo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "ubiGdsNo") List<String> ubiGdsNos, @RequestParam(value = "sortNo") List<Integer> sortNo,
			@RequestParam(value = "imgSeq") Integer imgSeq, @RequestParam(value = "txtNo") Integer txtNo) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		BoardGds boardGds = new BoardGds();

		try {
			for (int i = 0; i < ubiGdsNos.size(); i++) {
				boardGds.setUbiGdsNo(ubiGdsNos.get(i));
				boardGds.setPrir(sortNo.get(i).toString());
				boardGds.setImgSeq(imgSeq);
				manageService.updateSpecialSort(boardGds);
			}
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "/admin/manage/specialDetail?txtNo=" + txtNo);
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	@RequestMapping(value = "/updateInquiryReplAjax", method = RequestMethod.POST)
	public @ResponseBody int updateInquiryReplAjax(@RequestParam Integer cnslNo, @RequestParam Integer memoNo, @RequestParam String txt,
			Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		InquiryRepl inquiryRepl = new InquiryRepl();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		inquiryRepl.setCnslNo(cnslNo);
		inquiryRepl.setMemoTxt(txt);
		inquiryRepl.setMemoNo(memoNo);
		inquiryRepl.setUpdrNo(admin.getUserNo());

		int result = manageService.updateInquiryRepl(inquiryRepl);
		return result;
	}

	@RequestMapping(value = "/deleteInquiryReplAjax", method = RequestMethod.POST)
	public @ResponseBody int deleteInquiryReplAjax(@RequestParam Integer cnslNo, @RequestParam Integer memoNo, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		InquiryRepl inquiryRepl = new InquiryRepl();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		inquiryRepl.setCnslNo(cnslNo);
		inquiryRepl.setMemoNo(memoNo);
		inquiryRepl.setUpdrNo(admin.getUserNo());

		int result = manageService.deleteInquiryRepl(inquiryRepl);
		return result;
	}
}