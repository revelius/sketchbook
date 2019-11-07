package com.giftiel.shop.controller.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.common.SMSSend;
import com.giftiel.shop.controller.common.DefaultController;
import com.giftiel.shop.dao.OrderDao;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderAddPay;
import com.giftiel.shop.dto.OrderClm;
import com.giftiel.shop.dto.OrderDlvCmp;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.dto.OrderMemo;
import com.giftiel.shop.dto.OrderPay;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.UbiOrder;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/order")
public class OrderController extends DefaultController {
	// private static final Logger log = LoggerFactory.getLogger(OrderController.class);

	@Value("${server.setting}")
	private String serverSetting;

	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private Seed seed;
	@Autowired
	private SMSSend smsSend;
	@Autowired
	private MailSend mailSend;

	@Value("${upload.image}")
	private String uploadImage;

	private String orderBy = "";
	private String orderFlag = "";

	// 부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "order";
		// request.setAttirubte("globalMenuFlag", "order") 와 같으며
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
	@RequestMapping(value = "/orderMain")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/order/orderMain");
		return mav;
	}

	/**
	 * 전체주문 리스트페이지
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderList")
	public ModelAndView orderList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		if ("addBuy".equals(searchForm.getOrdKnd())) {// 추가결제
			this.searchAddPayList(searchForm, mav);// 추가결제 조회
			mav.setViewName("/admin/order/" + searchForm.getOrdKnd() + "List");
		} else {
			this.searchOrderList(searchForm, mav);// 주문리스트 조회
		}

		return mav;

	}

	/**
	 * 주문 리스트페이지(배송상태변경)
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateDlvStat")
	public String updateDlvStat(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, RedirectAttributes redic) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		Order order = new Order();
		order.setOrdGdsSeq(searchForm.getOrdGdsSeq());// 주문상품일련번호
		order.setChgDlvCmpNo(searchForm.getChgDlvCmpNo());// 택배사번호
		order.setChgInvNo(searchForm.getChgInvNo());// 송장번호
		order.setUpdrNo(admin.getUserNo());// 수정자

		int uptCnt = orderService.updateOrdGoods(order);

		if (uptCnt > 0) {
			redic.addFlashAttribute("alert", "배송상태 변경이 정상적으로 처리되었습니다.");
		} else {
			redic.addFlashAttribute("alert", "배송상태 변경 처리에 실패하였습니다.");
		}

		this.searchOrderList(searchForm, mav);// 주문리스트 조회

		// return mav;
		return "redirect:orderList?ordKnd=" + searchForm.getOrdKnd();

	}

	/**
	 * 주문상품 개별진행상태 upate(주문리스트)
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateOrdStat")
	public ModelAndView updateOrdStat(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		Order order = new Order();
		order.setPerOrdStat(searchForm.getPerOrdStat());// 개별주문상태
		order.setOrdGdsSeqs(searchForm.getOrdGdsSeqs());// 주문상품일련번호
		order.setUpdrNo(admin.getUserNo());// 수정자

		int uptCnt = orderService.updateOrdStat(order);

		if (uptCnt > 0) {
			mav.addObject("alert", "진행상태가 정상적으로 처리되었습니다.");
		} else {
			mav.addObject("alert", "진행상태가 처리에 실패하였습니다.");
		}

		this.searchOrderList(searchForm, mav);// 주문리스트 조회

		mav.setViewName("/admin/order/" + searchForm.getOrdKnd() + "List");

		return mav;

	}

	/**
	 * 주문 팝업 페이지
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/popupOrder")
	public ModelAndView orderDetail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		// 주문상품정보
		Order order = orderService.selectOrder(searchForm);
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 주문자정보 upate
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateOrdr")
	public ModelAndView updateOrdr(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		orderForm.setUpdrNo(admin.getUserNo());// 수정자
		orderForm.setOrdrZipCd(orderForm.getPost_no().replace("-", ""));
		orderForm.setOrdrBsAddr(orderForm.getAddress());

		int uptCnt = orderService.updateOrdr(orderForm);

		if (uptCnt > 0) {
			mav.addObject("alert", "주문자정보가 정상적으로 처리되었습니다.");
		} else {
			mav.addObject("alert", "주문자정보 처리에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());

		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;

	}

	/**
	 * 주문 상품 변경
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateOrdGoods")
	public ModelAndView updateOrdGoods(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		orderForm.setUpdrNo(admin.getUserNo());// 수정자

		int uptCnt = orderService.updateOrdGoods(orderForm);

		// 상품정보 merge
		if (uptCnt > 0) {
			mav.addObject("alert", "정상적으로 처리되었습니다.");
		} else {
			mav.addObject("alert", "처리에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());

		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;

	}

	/**
	 * 개별주문상태 UPDATE(주문상세)
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updatePerOrdStat")
	public ModelAndView updatePerOrdStat(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		orderForm.setUpdrNo(admin.getUserNo());// 수정자

		if (!"".equals(orderForm.getOrdGdsSeq())) {// 개별진행상태 단건일때
			String[] gdsSeq = { orderForm.getOrdGdsSeq() + "" };
			orderForm.setOrdGdsSeqs(gdsSeq);
		}

		int uptCnt = orderService.updateOrdStat(orderForm);

		// 상품정보 merge
		if (uptCnt > 0) {
			mav.addObject("alert", "주문상태 변경이 정상적으로 처리되었습니다.");
		} else {
			mav.addObject("alert", "주문상태 변경 처리에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());

		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;

	}

	/**
	 * 주문 코멘트 저장
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/insertOrderMemo", method = RequestMethod.POST)
	public ModelAndView insertOrderMemo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		OrderMemo orderMemo = new OrderMemo();
		orderMemo.setOrdNo(orderForm.getOrdNo());// 주문번호
		orderMemo.setRegrNo(admin.getUserNo());// 등록자
		orderMemo.setUpdrNo(admin.getUserNo());// 수정자
		orderMemo.setMemoTxt(orderForm.getMemoTxt());// 메모텍스트
		orderMemo.setWrtrCls(admin.getUserCls());// 작성자구분(?사용자구분????)

		try {
			orderService.insertOrdMemo(orderMemo);
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());
		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 주문 코멘트 삭제
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/deleteOrderMemo", method = RequestMethod.POST)
	public ModelAndView deleteOrderMemo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		OrderMemo orderMemo = new OrderMemo();
		orderMemo.setOrdNo(orderForm.getOrdNo());// 주문번호
		orderMemo.setMemoNo(orderForm.getMemoNo());// 메모번호

		try {
			orderService.deleteOrdMemo(orderMemo);
			mav.addObject("alert", "삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "삭제에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());
		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 추가결제 등록
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/insertOrderAddPay", method = RequestMethod.POST)
	public ModelAndView insertOrderAddPay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		OrderAddPay orderAddPay = new OrderAddPay();
		orderAddPay.setOrdNo(orderForm.getOrdNo());// 주문번호
		orderAddPay.setAddPayRsn(orderForm.getAddPayRsn());// 추가결제사유
		orderAddPay.setAddPayAmt(orderForm.getAddPayAmt());// 추가결제금액
		orderAddPay.setMemNo(orderForm.getMemNo());// 회원번호
		orderAddPay.setPayTp("OR00703");// 결제유형:추가결제
		orderAddPay.setPayStat("OR00901");// 결제상태:대기
		orderAddPay.setRegrNo(admin.getUserNo());// 등록자
		try {
			orderService.insertOrdAddPay(orderAddPay);
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());
		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 추가결제 수정
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateOrderAddPay", method = RequestMethod.POST)
	public ModelAndView updateOrdAddPay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		OrderAddPay orderAddPay = new OrderAddPay();
		orderAddPay.setAddPayRsn(orderForm.getUptAddPayRsn());// 수정할 추가결제사유
		orderAddPay.setAddPayAmt(orderForm.getUptAddPayAmt());// 수정할 추가결제금액
		orderAddPay.setAddPayNo(orderForm.getAddPayNo());// 추가결제번호

		orderAddPay.setRegrNo(admin.getUserNo());// 등록자
		orderAddPay.setUpdrNo(admin.getUserNo());// 수정자

		try {
			orderService.updateOrdAddPay(orderAddPay);
			mav.addObject("alert", "수정되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "수정에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());
		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 추가결제 취소
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/cancleOrderAddPay", method = RequestMethod.POST)
	public ModelAndView updateOrdPay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("Order") Order orderForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		OrderPay orderPay = new OrderPay();
		orderPay.setPayNo(orderForm.getPayNo());// 추가결제번호
		orderPay.setPayStat(orderForm.getPayStat());// 결제상태(대기:OR00901, 완료:OR00902, 취소:OR00904)
		orderPay.setRegrNo(admin.getUserNo());// 등록자
		orderPay.setUpdrNo(admin.getUserNo());// 수정자

		try {

			orderService.updateOrdPay(orderPay);// 주문취소

			mav.addObject("alert", "취소되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "취소에 실패하였습니다.");
		}

		// 상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderForm.getOrdNo());
		Order order = orderService.selectOrder(searchForm);// 주문상품정보
		this.addEachClm(order, mav);// 클라임정보 구분 저장

		mav.addObject("order", order);

		mav.setViewName("/admin/popup/popupOrder");
		return mav;
	}

	/**
	 * 주문리스트 조회
	 * 
	 * @param searchForm
	 * @param mav
	 */
	public void searchOrderList(SearchForm searchForm, ModelAndView mav) {

		int currentPage = 1;
		int showListLimit = 10;
		int showPageLimit = 10;
		StringBuffer pageHtml = null;

		// view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage() == null ? 20 : null);

		// 검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		// 조회조건셋팅
		// searchForm.setPayTp("OR00701");//결제유형(결제)
		// searchForm.setPayStat("OR00902");//결제상태(완료)
		// searchForm.setOrdClmCls("OR00601");//주문/클라임구분(주문)

		searchForm.setEgnoreStat("OR00201");
		if ("ship".equals(searchForm.getOrdKnd())) {
			searchForm.setOffLineEgnoreChk("Y");
		}

		searchForm.setTotalCnt(orderService.totalListOrder(searchForm));

		// 페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<Order> orderList = orderService.listOrder(searchForm);

		List<Site> siteList = codeService.getSiteList(); // 매장명 리스트
		List<Code> ordStatList = codeService.listCd(Constants.ORD_STAT);// 주문상태 코드리스트
		List<Code> perOrdStatList = codeService.listCd(Constants.PER_ORD_STAT);// 개별주문상태 코드리스트
		List<Code> payWayList = codeService.listCd(Constants.PAY_WAY);// 결제수단코드
		List<Code> brandList = this.tempBrand(); // 브랜드(#임시)
		List<OrderDlvCmp> orderDlvCmp = orderService.listDlvCmp(); // 택배사조회

		// 카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		/* 코드 셋팅 START */
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);

		mav.addObject("siteList", siteList);// 매장명
		mav.addObject("ordStatList", ordStatList);// 개별주문상택
		mav.addObject("perOrdStatList", perOrdStatList);// 개별주문상택
		mav.addObject("payWayList", payWayList);// 결제수단코드
		mav.addObject("brandList", brandList);// 브랜드
		mav.addObject("orderDlvCmp", orderDlvCmp);// 택배사조회
		/* 코드 셋팅 END */

		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("orderList", orderList);
		mav.addObject("searchForm", searchForm);

		mav.setViewName("/admin/order/" + searchForm.getOrdKnd() + "List");

		// 엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			// 엑셀 title
			String colName = "판매번호,개별주문상태,매장명,주문번호,상품명,상품사이즈,주문일시,판매가,수량,주문자EMAIL,주문자명,택배사번호,송장번호,우편번호,주소,상세주소,전화번호,핸드폰번호,상품바코드,배송 메시지,브랜드,품번,상품컬러,매장존,창고코드,로케이션";
			// 엑셀 title, value 맵핑순서
			String colMapping = "getUbiSaleNo,getPerOrdStatNm,getSiteNm,getOrdNo,getUbiGdsNm,getUbiGdsSize,getOrdDts,getSlPrc,getOrdQty,getOrdrEmail,getOrdrNm,getDlvCmpNo,getInvNo,getOrdrZipCd,getOrdrBsAddr,getOrdrDtlAddr,getOrdrTel,getOrdrCp,getBarcode,getDlvSvcMemo,getBrand,getUbiGdsNo,getUbiGdsColorNm,getmZone,getcCode,getLocation";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", orderList);
			mav.addObject("totalCls", "Y");
			// 엑셀 명(영문만 가능)
			mav.addObject("excelName", "orderList");
			mav.setViewName("excelDownload");
		}
	}

	/**
	 * 추가결제관리 조회
	 * 
	 * @param searchForm
	 * @param mav
	 */
	public void searchAddPayList(SearchForm searchForm, ModelAndView mav) {

		int currentPage = 1;
		int showListLimit = 10;
		int showPageLimit = 10;
		StringBuffer pageHtml = null;

		// view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage() == null ? 20 : null);
		// 검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		// 조회조건셋팅
		// searchForm.setPayTp("OR00703");//결제유형(OR00701:결제, OR00702:부분취소, OR00703:추가결제, OR00704:취소)

		searchForm.setTotalCnt(orderService.totalListAddPay(searchForm));

		// 페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<OrderAddPay> addPayList = orderService.listAddPay(searchForm);

		List<Code> payStatList = codeService.listCd(Constants.PAY_STAT);// 결제상태
		List<Code> payWayList = codeService.listCd(Constants.PAY_WAY);// 결제수단코드

		/* 코드 셋팅 START */
		mav.addObject("payStatList", payStatList);// 결제상태
		mav.addObject("payWayList", payWayList);// 결제수단코드
		/* 코드 셋팅 END */

		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("addPayList", addPayList);
		mav.addObject("searchForm", searchForm);
	}

	/**
	 * 클라임정보 구분 저장
	 * 
	 * @param order
	 * @param mav
	 */
	public void addEachClm(Order order, ModelAndView mav) {

		List<OrderClm> clmList = order.getOrderClm();// 클라임

		if (clmList.size() > 0) {
			ArrayList<OrderClm> cancleClm = new ArrayList<OrderClm>();// 취소내역
			ArrayList<OrderClm> takeBackClm = new ArrayList<OrderClm>();// 반품내역
			ArrayList<OrderClm> exchangeClm = new ArrayList<OrderClm>();// 교환내역

			for (int i = 0; i < clmList.size(); i++) {// 클라임 분리
				OrderClm clm = clmList.get(i);
				if ("OR01601".equals(clm.getClmTp()) || "OR01605".equals(clm.getClmTp())) {// 취소
					cancleClm.add(clm);
				} else if ("OR01602".equals(clm.getClmTp())) {// 반품
					takeBackClm.add(clm);
				} else if ("OR01604".equals(clm.getClmTp())) {// 교환
					exchangeClm.add(clm);
				}
			}

			mav.addObject("cancleClm", cancleClm);
			mav.addObject("exchangeClm", exchangeClm);
			mav.addObject("takeBackClm", takeBackClm);
		}

	}

	/**
	 * 임시사용 브랜드 가져오기
	 * 
	 * @return
	 */
	public List<Code> tempBrand() {
		List<Code> siteList = new ArrayList<Code>(); // 매장명(#임시)

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

	@RequestMapping(value = "/modifyOrderGoodsStat")
	public ModelAndView modifyEscrow(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo, @RequestParam("ordGdsSeq") Integer ordGdsSeq, @RequestParam("modType") String modType,
			@RequestParam("perOrdStat") String perOrdStat, @RequestParam("payWay") String payWay) throws Exception {
		ModelAndView mav = new ModelAndView();

		String dlvCls = "";
		if (request.getParameter("dlvCls") != null) {
			dlvCls = request.getParameter("dlvCls");
			mav.addObject("dlvCls", dlvCls);
		}

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		SearchForm searChOrdForm = new SearchForm();
		searChOrdForm.setOrdNo(ordNo);
		Order orderData = orderService.selectOrder(searChOrdForm);// 주문상품정보

		int orderGdsSeq = 0;
		for (int i = 0; i < orderData.getOrderGoods().size(); i++) {
			if (ordGdsSeq != null) {
				if (ordGdsSeq.equals(orderData.getOrderGoods().get(i).getOrdGdsSeq())) {
					orderGdsSeq = i;
				}
			}
		}

		System.out.println("orderGdsSeq===" + orderGdsSeq);

		mav.addObject("ordNo", ordNo);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("modType", modType);
		mav.addObject("payWay", payWay);
		mav.addObject("perOrdStat", perOrdStat);
		boolean flag = false;

		if (Constants.NOT_PG_MODULES.indexOf(perOrdStat) > -1) { // 주문상태만 변경
			flag = true;
		}

		// 에스크로가 아닐 경우 배송상태는 내부에서만 변경
		if (Constants.PAY_WAY_CARD.equals(payWay)) {
			if (Constants.PER_ORD_STAT_SEND_COMPL.equals(perOrdStat)) {
				flag = true;
			}
		}

		// 배송중 변경시
		if ("STE1".equals(modType)) {
			// 에스크로 통보가 완료된 주문건
			if ("Y".equals(orderData.getEscrowDlvYn())) {
				flag = true;
			}
		}

		if (Constants.PAY_WAY_ONLY_POINT.equals(payWay)) {
			flag = true;
		}

		if (flag) {
			Order order = new Order();
			order.setOrdNo(ordNo);
			order.setPerOrdStat(perOrdStat);// 개별주문상태
			order.setOrdGdsSeq(ordGdsSeq);// 주문상품일련번호
			order.setUpdrNo(admin.getUserNo());// 수정자
			// 교환진행일땐 사이즈를 업데이트함
			if ("OR00509".equals(perOrdStat)) {
				order.setUbiGdsSize(request.getParameter("size"));
			}

			int uptCnt = orderService.updateOrdStat2(order);

			// 배송준비중으로 변경될때 UBI로 주문을 넘겨줌
			// if("OR00503".equals(perOrdStat)){
			// int ubiOrderNo = orderService.ubiOrderSeq();
			//
			//
			// UbiOrder ubiOrder = new UbiOrder();
			// ubiOrder.set매장코드("WE001");
			// ubiOrder.set판매번호(String.format("%04d", ubiOrderNo));
			// ubiOrder.set판매연번(String.format("%04d", orderGdsSeq+1));
			// ubiOrder.set작업구분("0");
			// ubiOrder.set품번(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsNo());
			// ubiOrder.set색상(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsColorCd());
			// ubiOrder.set사이즈(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsSize());
			// ubiOrder.set판매수량(1);
			// ubiOrder.set실판매금액(orderData.getOrderGoods().get(orderGdsSeq).getSlPrc()-orderData.getOrderGoods().get(orderGdsSeq).getUsePnt()-orderData.getOrderGoods().get(orderGdsSeq).getCpnPayAmt());
			// ubiOrder.set적립포인트(orderData.getOrderGoods().get(orderGdsSeq).getExpPnt());
			// ubiOrder.set사용포인트(orderData.getOrderGoods().get(orderGdsSeq).getUsePnt());
			// ubiOrder.set수정여부("N");
			// ubiOrder.set처리여부("N");
			// ubiOrder.set에러사유("");
			// ubiOrder.set주문번호(order.getOrdNo());
			//
			// SearchForm searchForm = new SearchForm();
			// searchForm.setMemNo(orderData.getMemNo().toString());
			// Member member = memberService.selectMemInfo(searchForm);
			//
			// if(member != null) {
			// ubiOrder.set적립율(member.getCurRsvPer());
			// ubiOrder.set온라인고객코드(member.getMemNo().toString());
			// }else {
			// ubiOrder.set적립율(0);
			// ubiOrder.set온라인고객코드("99999999");
			// }
			//
			//
			//
			// orderDao.insertUbiOrder(ubiOrder);
			// }

			if ("OR00509".equals(perOrdStat)) {
				UbiOrder ubiOrder = new UbiOrder();
				ubiOrder.set주문번호(orderData.getOrdNo().toString());
				ubiOrder.set품번(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsNo());
				ubiOrder.set색상(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsColorCd());
				ubiOrder.set사이즈(orderData.getOrderGoods().get(orderGdsSeq).getUbiGdsSize());
				ubiOrder.set변경사이즈(request.getParameter("size"));
				orderService.insertUbiOrderExchange(ubiOrder);
			}

			if (uptCnt > 0) {
				mav.addObject("alert", "저장되었습니다.");
			} else {
				mav.addObject("alert", "저장에 실패 하였습니다.");
			}

			// 메일,SMS발송
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("orderNo", ordNo);
			if ("OR00504".equals(perOrdStat)) { // 배송시작
				// SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
				smsSend.sendSMS(5, orderData.getOrdrCp(), orderData.getSiteNm(), orderData.getRcpnNm(), ordNo, ordGdsSeq);
				mailSend.sendMail(orderData.getOrdrNm(), orderData.getOrdrEmail(), request, hm, "shippComp");
			} else if ("OR00509".equals(perOrdStat)) { // 교환진행
				smsSend.sendSMS(8, orderData.getOrdrCp(), orderData.getSiteNm(), orderData.getRcpnNm(), orderData.getOrdNo(), ordGdsSeq);
				hm.put("ordGdsSeq", ordGdsSeq);
				mailSend.sendMail(orderData.getOrdrNm(), orderData.getOrdrEmail(), request, hm, "ordChange");
			} else if ("OR00513".equals(perOrdStat)) { // 반품진행
				smsSend.sendSMS(9, orderData.getOrdrCp(), orderData.getSiteNm(), orderData.getRcpnNm(), orderData.getOrdNo(), ordGdsSeq);
				hm.put("ordGdsSeq", ordGdsSeq);
				mailSend.sendMail(orderData.getOrdrNm(), orderData.getOrdrEmail(), request, hm, "ordReturn");
			}

			mav.addObject("windowClose", "true");
			mav.addObject("openerReload", "true");
			mav.setViewName("/common/scriptView/script");
		} else {
			mav.setViewName("/common/order/modifyEscrow");
		}

		if (Constants.PAY_WAY_CARD.equals(payWay)) {
			if (Constants.PER_ORD_STAT_ORDER_CANCEL.equals(perOrdStat) || Constants.PER_ORD_STAT_RETURN_COMPL.equals(perOrdStat)) {
				mav.setViewName("/common/order/cancel");
			}
		}

		// 포인트로만 결제된 주문취소
		if (Constants.PAY_WAY_ONLY_POINT.equals(payWay)) {
			if (Constants.PER_ORD_STAT_ORDER_CANCEL.equals(perOrdStat) || Constants.PER_ORD_STAT_RETURN_COMPL.equals(perOrdStat)) {
				try {
					Order order = new Order();
					order.setOrdNo(ordNo);
					order.setPerOrdStat(perOrdStat);// 개별주문상태
					order.setOrdGdsSeq(ordGdsSeq);// 주문상품일련번호
					order.setUpdrNo(admin.getUserNo());// 수정자

					int uptCnt = orderService.updateOrdStat2(order);

					SearchForm searchForm = new SearchForm();
					searchForm.setOrdNo(ordNo);
					order = orderService.selectOrder(searchForm);

					UbiOrder ubiOrder = new UbiOrder();
					ubiOrder.set주문번호(order.getOrdNo().toString());
					orderService.insertUbiOrderCancel(ubiOrder);

					// 적립금 환불
					Point point = new Point();
					point.setRsvRsnCd("MT00206");
					point.setMemNo(order.getMemNo());
					point.setRsvPnt(order.getOrderPay().get(1).getPayAmt());
					point.setRsvYn("Y");
					point.setRegrNo(order.getMemNo());
					point.setRsvCls("CM01002");
					point.setOrdNo(ordNo);
					orderService.insertPoint(point);

					// SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
					smsSend.sendSMS(6, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), order.getOrdNo(), ordGdsSeq);

					// MAIL 발송
					HashMap<String, Object> hm = new HashMap<String, Object>();
					hm.put("orderNo", order.getOrdNo());
					int result = 0;
					// 메일발송 성공 : 1, 실패 : 0
					result = mailSend.sendMail(order.getOrdrNm(), order.getOrdrEmail(), request, hm, "ordCancel");

					if (uptCnt > 0) {
						mav.addObject("alert", "취소 되었습니다.");
					} else {
						mav.addObject("alert", "취소에 실패 하였습니다.");
					}
					mav.addObject("windowClose", "true");
					mav.addObject("openerReload", "true");
					mav.setViewName("/common/scriptView/script");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return mav;
	}

	@RequestMapping(value = "/updateOrderProcess")
	public ModelAndView updateOrderProcess(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo, @RequestParam("ordGdsSeq") Integer ordGdsSeq, @RequestParam("modType") String modType,
			@RequestParam("payWay") String payWay) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		mav.addObject("ordNo", ordNo);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("modType", modType);
		mav.addObject("payWay", payWay);

		mav.setViewName("/common/order/updateOrderProcess");
		return mav;
	}

	/**
	 * 송장번호 대량 저장(Excel)
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param orderForm
	 * @param redirectAttr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveInvNoExcel", method = RequestMethod.POST)
	public ModelAndView saveInvNoExcel(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("orderForm") Order order) throws Exception {
		ModelAndView mav = new ModelAndView();

		int result = 0;

		List<OrderGoods> orderGoods = order.getOrderGoods();

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		for (int i = 0; i < orderGoods.size(); i++) {
			orderGoods.get(i).setRegrNo(admin.getUserNo());
			orderGoods.get(i).setUpdrNo(admin.getUserNo());
		}

		try {
			result = orderService.invoUpdateOrdGoods(orderGoods);
			mav.addObject("alert", "송장번호 등록이 " + result + "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "orderList?ordKnd=invNo");
		mav.addObject("windowClose", "true");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	/**
	 * 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderCancelComp")
	public ModelAndView orderCancelComp(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo) throws Exception {
		ModelAndView mav = new ModelAndView();

		int result = 0;

		Order order = new Order();
		order.setOrdNo(ordNo);
		order.setOrdStat(Constants.ORD_STAT_CANCEL);
		order.setPerOrdStat(Constants.PER_ORD_STAT_ORDER_CANCEL);
		order.setCnclQty(1);

		// admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		order.setUpdrNo(admin.getUpdrNo());

		try {
			orderService.updateOrdStat2(order);
			orderService.updateOrdr(order);

			mav.addObject("alert", "주문이 강제 취소 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("windowClose", "true");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

}
