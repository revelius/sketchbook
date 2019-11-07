package com.giftiel.shop.controller.admin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Comment;
import com.giftiel.shop.dto.Inquiry;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MemberGrade;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.service.CartService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.CommentService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberGradeService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.PointService;
import com.giftiel.shop.service.SettingService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/member")
public class MemberController {
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	@Value("${server.setting}")
	private String serverSetting;

	@Value("${upload.image}")
	private String uploadImage;

	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberGradeService memberGradeService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private Seed seed;
	@Autowired
	private CartService cartService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private ManageService manageService;
	@Autowired
	private PointService pointService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private SettingService settingService;

	private int currentPage = 1;
	private int showListLimit = 10;
	private int showPageLimit = 10;
	private StringBuffer pageHtml = null;
	private String orderBy = "";
	private String orderFlag = "";

	//부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "member";
		// request.setAttirubte("globalMenuFlag", "member") 와 같으며
		// 선언된 클래스의 전역으로 실행된다.
	}

	/**
	 * 주문매출관리 메인페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/memberMain")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/member/memberMain");
		return mav;
	}

	/**
	 * 백오피스 회원목록
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
	@RequestMapping(value = "/memberList")
	public ModelAndView selectTableList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, @ModelAttribute("regForm") SearchForm regForm)
			throws UnsupportedEncodingException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		showListLimit = searchForm.getSearchCount() == null ? 15 : searchForm.getSearchCount();
		searchForm.setSearchCount(showListLimit);

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

		if (Constants.MODE_ADMIN.equals("_bootstrap")) {
			pageHtml = pagingUtil.getBootPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		} else {
			pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		}

		//멤버리스트
		List<Member> memberList = memberService.listMemInfo(searchForm);

		//		Member temp = new Member();
		//
		//		List<Member> listMem = new ArrayList<Member>();
		//
		//		if(memberList != null){
		//			for(int i=0; i<memberList.size(); i++){
		//				temp = (Member)memberList.get(i);
		//				//나중에 주석 풀기
		////				temp.setEmail(seed.decrypt(temp.getEmail()));
		//				listMem.add(temp);
		//			}
		//		}

		//셀렉트박스 회원등급 리스트
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);

		if (searchForm.getEmail() != null) {
			searchForm.setEmail(seed.decrypt(searchForm.getEmail()));
		}

		if (searchForm.getCpNo() != null) {
			searchForm.setCpNo(seed.decrypt(searchForm.getCpNo()));
		}

		//탈퇴회원수
		Integer wdrwCnt = memberService.totalListWdrwCnt(searchForm);

		//포인트 내용 코드 리스트
		List<Code> rsvRsnList = codeService.listCd(Constants.RSV_RSN_CODE);

		//view 전달객체 셋팅
		mav.addObject("rsvRsnList", rsvRsnList);
		mav.addObject("wdrwCnt", wdrwCnt);
		mav.addObject("pageHtml", pageHtml);
		//		mav.addObject("memberList", listMem);
		mav.addObject("memberList", memberList);
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("searchForm", searchForm);
		mav.addObject("memberGradeList", memberGradeList);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/member/memberList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "회원번호,회원등급번호,이름,이메일,성별,나이,포인트,접속수,총구매금액,총구매건수,회원코멘트,휴대폰번호,가입사이트,메일수신동의 유/무,SMS수신동의 유/무";
			//엑셀 title, value 맵핑순서
			String colMapping = "getMemNo,getMemGrdNo,getNm,getEmail,getSex,getAge,getCurPoint"
					+ ",getLoginCnt,getOrderAmt,getOrderCnt,getCmtCnt,getCpNo,getSiteDesc,getMailSndYn,getSmsSndYn";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			//			mav.addObject("colValue", listMem);
			mav.addObject("colValue", memberList);
			mav.addObject("totalCls", "Y");
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "memberList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 백오피스 회원목록
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/membershipInfo")
	public ModelAndView selectMemberInfo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//셀렉트박스 회원등급 리스트
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);

		//회원 상세 정보
		searchForm.setAllMember(true);
		Member memberList = memberService.selectMemInfo(searchForm);
		if (memberList.getCpNo() != null) {
			//memberList.setCpNo(seed.decrypt(memberList.getCpNo()).trim().equals("")?memberList.getCpNo():seed.decrypt(memberList.getCpNo()));
			memberList.setCpNo(memberList.getCpNo());
		}
		if (memberList.getEmail() != null) {
			//String email = seed.decrypt(memberList.getEmail()).trim().equals("")?memberList.getEmail():seed.decrypt(memberList.getEmail());
			String email = memberList.getEmail();
			memberList.setEmail(email);
			searchForm.setEmail(email);
		}
		if (memberList.getNm() != null) {
			searchForm.setNm(memberList.getNm());
		}
		if (memberList.getMemNo() != null) {
			searchForm.setMemNo(Integer.toString(memberList.getMemNo()));
		}

		//회원 구매 정보
		Member ordInfo = memberService.selectOrdInfo(searchForm);

		//회원 코멘트
		List<Comment> memberCmtList = commentService.memberCmtList(searchForm);

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		String adminNm = admin.getUserNm();
		String userCls = admin.getUserCls();

		searchForm.setMemGrdNo(memberList.getMemGrdNo());
		mav.addObject("memberGradeList", memberGradeList);
		mav.addObject("memberList", memberList);
		mav.addObject("ordInfo", ordInfo);
		mav.addObject("memberCmtList", memberCmtList);
		mav.addObject("searchForm", searchForm);
		mav.addObject("userCls", userCls);
		mav.addObject("adminNm", adminNm);

		mav.setViewName("/admin/member/membershipInfo");
		return mav;
	}

	/**
	 * 백오피스 회원 정보 - 1:1문의
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/inquire")
	public ModelAndView inquire(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy() == null ? "UPD_DTS" : searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag() == null ? "DESC" : searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		searchForm.setAllDay(true);

		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();

		//searchForm.setSearchCount(showListLimit);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(manageService.totalListInquiry(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Inquiry> inquiry = manageService.inquiryList(searchForm);

		Member logingHist = memberService.selectloginHist(searchForm);

		model.addAttribute("pageHtml", pageHtml);
		model.addAttribute("searchForm", searchForm);
		model.addAttribute("inquiryList", inquiry);
		model.addAttribute("logingHist", logingHist);
		mav.setViewName("/admin/member/inquire");
		return mav;
	}

	/**
	 * 회원 상세정보 회원 등급 수정
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateMemGrd")
	public void updateMemGrd(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("memNo") String memNo, @RequestParam("memGrdNo") String memGrdNo) throws IOException {
		int checkGrd = 0;

		Member member = new Member();
		member.setMemNo(Integer.parseInt(memNo));
		member.setMemGrdNo(Integer.parseInt(memGrdNo));

		checkGrd = memberService.updateMemGrd(member);

		response.getWriter().print(checkGrd);
	}

	/**
	 * 회원 상세정보 회원 코멘트 등록
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/insertMemComment")
	public void insertMemComment(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("memNo") String memNo, @RequestParam("comment") String comment) throws IOException {
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		int checkGrd = 0;

		Comment cmt = new Comment();
		cmt.setMemNo(Integer.parseInt(memNo));
		cmt.setComment(comment);
		cmt.setRegrNo(admin.getUserNo());
		checkGrd = commentService.insertMemComment(cmt);

		response.getWriter().print(checkGrd);
	}

	/**
	 * 회원 상세정보 회원 코멘트 삭제
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/deleteMemComment")
	public void deleteMemComment(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cmntNo") String cmntNo) throws IOException {

		int checkGrd = 0;

		Comment comment = new Comment();
		comment.setCmntNo(Integer.parseInt(cmntNo));
		checkGrd = commentService.deleteMemComment(comment);

		response.getWriter().print(checkGrd);
	}

	/**
	 * 백오피스 회원 정보 - cart
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/cartList")
	public ModelAndView selectCartList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		String adminNm = admin.getUserNm();
		Setting setting = settingService.pointSettingList();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		orderBy = searchForm.getOrderBy() == null ? "UPD_DTS" : searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag() == null ? "DESC" : searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();

		//searchForm.setSearchCount(showListLimit);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		//cart 테이블에 email 정보 들어 올때 까지 임시 셋팅
		searchForm.setEmail("");

		searchForm.setTotalCnt(cartService.totalListCart(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Cart> cart = cartService.selectCartList(searchForm);

		Member member = memberService.selectMemInfo(searchForm);

		int curRsvPer = 0;
		int curDcPer = 0;

		curRsvPer = member.getCurRsvPer();
		curDcPer = member.getCurDcPer();

		int totalSlAmt = 0;
		int deliveryCost = (int) setting.dlv_cst; //TODO배송비
		for (int i = 0; i < cart.size(); i++) {
			//회원등급 할인
			cart.get(i)
					.setUbiSlPrc(Integer.parseInt(cart.get(i).getUbiSlPrc()) - ((Integer.parseInt(cart.get(i).getUbiSlPrc()) / 100) * curDcPer) + "");
			cart.get(i).setUbiSlPrc((int) (Math.floor(Integer.parseInt(cart.get(i).getUbiSlPrc())) / 100) * 100 + "");
			totalSlAmt += Integer.parseInt(cart.get(i).getUbiSlPrc());
		}
		if (totalSlAmt > (int) setting.getCnd_free_dlv_amt()) {
			deliveryCost = 0;
		} else {
		}

		for (int j = 0; j < cart.size(); j++) {
			//회원 포인트 지급 정책 시작
			if (Constants.PNT_RSV_CLS_NONE.equals(setting.getPnt_rsv_cls())) {
				cart.get(j).setExpPnt(0);
			} else if (Constants.PNT_RSV_CLS_MEMLV.equals(setting.getPnt_rsv_cls())) {
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc()) / 100) * curRsvPer);
			} else if (Constants.PNT_RSV_CLS_SLPRC.equals(setting.getPnt_rsv_cls())) {
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc()) / 100) * (int) setting.getPnt_rsv_rt());
			} else if (Constants.PNT_RSV_CLS_PAYAMT.equals(setting.getPnt_rsv_cls())) {
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc()) / 100) * (int) setting.getPnt_rsv_rt());
			}
		}

		Member logingHist = memberService.selectloginHist(searchForm);

		model.addAttribute("pageHtml", pageHtml);
		model.addAttribute("searchForm", searchForm);
		model.addAttribute("cartList", cart);
		model.addAttribute("adminNm", adminNm);
		model.addAttribute("logingHist", logingHist);
		model.addAttribute("uploadImage", uploadImage);
		mav.setViewName("/admin/member/cartList");
		return mav;
	}

	/**
	 * 카트에 담을 상품 검색
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/selectGdsNo")
	public void selectGdsNo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("gdsNo") String gdsNo)
			throws IOException {

		String checkGrd = "";

		Cart cart = new Cart();
		cart.setGdsNo(gdsNo);

		List<Cart> list = cartService.selectGdsNo(cart);

		if (list != null && list.size() > 0) {
			checkGrd = "1";
		} else {
			checkGrd = "2";
		}
		response.getWriter().print(checkGrd);
	}

	/**
	 * 장바구니에 상품 담기
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/insertGdsCart")
	public void insertGdsCart(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("gdsNo") String gdsNo, @RequestParam("memNo") String memNo, @RequestParam("gdsSize") String gdsSize) throws IOException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		int checkGrd = 0;

		Cart cart = new Cart();
		cart.setGdsNo(gdsNo);
		cart.setUbiGdsNo(gdsNo);
		cart.setMemNo(Integer.parseInt(memNo));
		cart.setGdsSize(gdsSize);
		cart.setRegrNo(admin.getUserNo());

		//장바구니 추가는 같은 상품일경우 수량 증가 로직부분 --> 무조건 건수 추가로 인해 주석
		/*
		 * List<Cart> list = cartService.selectGdsCart(cart); if(list != null && list.size() > 0 ){ checkGrd = cartService.updateGdsCart(cart); }else{ checkGrd = cartService.insertGdsCart(cart); }
		 */
		checkGrd = cartService.insertGdsCart(cart);

		response.getWriter().print(checkGrd);
	}

	/**
	 * 장바구니에 상품 삭제하기
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/deleteGdsCart")
	public void deleteGdsCart(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cartNo") Integer cartNo) throws IOException {

		int checkGrd = 0;
		checkGrd = cartService.deleteGdsCart(cartNo);

		response.getWriter().print(checkGrd);
	}

	/**
	 * 백오피스 회원 정보 - 포인트 관리
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/pointList")
	public ModelAndView pointList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, @ModelAttribute("regForm") SearchForm regForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		//		orderBy   = searchForm.getOrderBy() == null?"REG_DTS":searchForm.getOrderBy();
		//		orderFlag = searchForm.getOrderFlag() == null?"DESC":searchForm.getOrderFlag();
		//		orderBy   = searchForm.getOrderBy();
		//		orderFlag = searchForm.getOrderFlag();
		//		searchForm.setOrderBy(orderBy);
		//		searchForm.setOrderFlag(orderFlag);

		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();

		searchForm.setSearchCount(showListLimit);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		//email searchForm 관련 주석 나중에 풀것.
		if (searchForm.getEmail() != null) {
			//searchForm.setEmail(seed.encrypt(searchForm.getEmail()));
		}

		if (searchForm.getCpNo() != null) {
			searchForm.setCpNo(seed.encrypt(searchForm.getCpNo()));
		}

		searchForm.setTotalCnt(pointService.totalListPoint(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();

		if (Constants.MODE_ADMIN.equals("_bootstrap")) {
			pageHtml = pagingUtil.getBootPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		} else {
			pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		}

		//		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		//		pageHtml = pagingUtil.getBootPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Point> pointList = pointService.selectPointList(searchForm);
		//		Point temp = new Point();
		//		List<Point> listPoint = new ArrayList<Point>();
		//
		//		if(pointList != null){
		//			for(int i=0; i<pointList.size(); i++){
		//				temp = (Point)pointList.get(i);
		//				//나중에 주석 풀기
		//				//temp.setEmail(seed.decrypt(temp.getEmail()));
		//				temp.setCpNo(seed.decrypt(temp.getCpNo()));
		//
		//				listPoint.add(temp);
		//			}
		//		}

		//		속도 때문에 임시 주석처리리
		//		Integer sumPoint = pointService.totalSumPoint(searchForm);

		if (searchForm.getEmail() != null) {
			//나중에 주석 풀기
			//searchForm.setEmail(seed.decrypt(searchForm.getEmail()));
		}

		if (searchForm.getCpNo() != null) {
			searchForm.setCpNo(seed.decrypt(searchForm.getCpNo()));
		}

		//포인트 내용 코드 리스트
		List<Code> rsvRsnList = codeService.listCd(Constants.RSV_RSN_CODE);

		model.addAttribute("rsvRsnList", rsvRsnList);
		//		model.addAttribute("sumPoint", sumPoint);
		model.addAttribute("pageHtml", pageHtml);
		model.addAttribute("searchForm", searchForm);
		//		model.addAttribute("pointList", listPoint);
		model.addAttribute("pointList", pointList);
		//		mav.setViewName("/admin/member/pointList");
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/member/pointList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "E-mail계정,이름,회원등급,일시,포인트 내용,사용포인트,적립포인트,발행인,포인트 합";
			//엑셀 title, value 맵핑순서
			String colMapping = "getEmail,getNm,getGrdNm,getRegDts,getRsvRsnCd,getUsePoint,getCurPoint,getRsvCls,getTotPoint";

			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			//			mav.addObject("colValue", listMem);
			mav.addObject("colValue", pointList);
			mav.addObject("totalCls", "Y");
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "pointList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 회원 적립포인트 등록하기
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/insertPoint")
	public void insertPoint(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("rsvRsnCd") String rsvRsnCd, @RequestParam("memNo") String memNo, @RequestParam("useYn") String useYn,
			@RequestParam("rsvCls") String rsvCls, @RequestParam("rsvPnt") int rsvPnt) throws IOException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		Integer regNo = admin.getUserNo();

		int checkPoint = 0;

		Point point = new Point();

		point.setRsvRsnCd(rsvRsnCd); //적립금사유코드
		point.setMemNo(Integer.parseInt(memNo)); //회원번호
		point.setRsvPnt(rsvPnt); //적립포인트
		point.setRegrNo(regNo); // 등록자
		point.setRsvCls(rsvCls); //적립주체
		point.setRsvYn(useYn); //사용여부

		checkPoint = pointService.insertPoint(point);

		response.getWriter().print(checkPoint);
	}

	/**
	 * 회원 장바구니 상품 사이즈 변경하기
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateGdsSize")
	public void updateGdsSize(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cartNo") Integer cartNo, @RequestParam("gdsSize") String gdsSize) throws IOException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		int checkCart = 0;

		Cart cart = new Cart();
		cart.setCartNo(cartNo);
		cart.setGdsSize(gdsSize);
		cart.setRegrNo(admin.getUserNo());

		checkCart = cartService.updateGdsSize(cart);

		response.getWriter().print(checkCart);
	}

	/**
	 * 백오피스 회원 주문리스트
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/memberOrderList")
	public ModelAndView memberOrderList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		int currentPage = 1;
		int showListLimit = 10;
		int showPageLimit = 10;
		StringBuffer pageHtml = null;

		searchForm.setOrderFlag("");//초기화
		searchForm.setOrderBy("");//초기화
		searchForm.setAllDay(true);//날짜 전체조회

		//검색조건 게시물의 총 결과 갯수
		searchForm.setRownum(searchForm.getPage() == null ? 20 : null);//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		searchForm.setTotalCnt(orderService.totalListOrder(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Order> orderList = orderService.listOrder(searchForm);

		/* 코드 셋팅 START */
		List<Code> ordStatList = codeService.listCd(Constants.ORD_STAT);//주문상태 코드리스트
		List<Code> perOrdStatList = codeService.listCd(Constants.PER_ORD_STAT);//개별주문상태 코드리스트
		List<Code> payWayList = codeService.listCd(Constants.PAY_WAY);//결제수단코드

		mav.addObject("ordStatList", ordStatList);//개별주문상택
		mav.addObject("perOrdStatList", perOrdStatList);//개별주문상택
		mav.addObject("payWayList", payWayList);//결제수단코드
		/* 코드 셋팅 END */

		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("orderList", orderList);
		mav.addObject("searchForm", searchForm);

		mav.setViewName("/admin/member/memberOrderList");
		return mav;
	}

	/**
	 * 백오피스 회원목록
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
	@RequestMapping(value = "/memberListXlsx")
	public ModelAndView memberListXlsx(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		ModelAndView mav = new ModelAndView();

		//멤버리스트
		List<Member> memberList = memberService.memberListXlsx();

		//엑셀다운로드 view 전달객체 셋팅
		//엑셀 title
		String colName = "회원이름,이메일,휴대폰번호,가입사이트,메일수신동의 유/무,SMS수신동의 유/무";
		//엑셀 title, value 맵핑순서
		String colMapping = "getNm,getEmail,getCpNo,getSiteDesc,getMailSndYn,getSmsSndYn";
		mav.addObject("colName", colName);
		mav.addObject("colMapping", colMapping);
		mav.addObject("colValue", memberList);
		mav.addObject("totalCls", "N");
		//엑셀 명(영문만 가능)
		mav.addObject("excelName", "memberList");
		mav.setViewName("excelDownload");

		return mav;
	}

}