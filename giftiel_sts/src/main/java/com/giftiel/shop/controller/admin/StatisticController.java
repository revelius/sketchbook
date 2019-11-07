package com.giftiel.shop.controller.admin;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.MemberGrade;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.StatisticsConn;
import com.giftiel.shop.dto.StatisticsForm;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberGradeService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.StatisticService;
import com.giftiel.shop.utils.PagingUtil;
import com.google.gson.Gson;

@Controller
@RequestMapping("/admin/statistics")
public class StatisticController {

	private static final Logger log = LoggerFactory.getLogger(AdminController.class);

	@Value("${server.setting}")
	private String serverSetting;

	@Value("${server.contextPath}")
	private String contextPath;

	@Autowired
	private ManageService manageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberGradeService memberGradeService;

	@Autowired
	private GoodsService goodsSercice;

	@Autowired
	private OrderService orderService;

	@Autowired
	private StatisticService statisticService;

	@Autowired
	private CategoryService categoryService;

	private int currentPage = 1;
	private int globalShowListLimit = 15;
	private int showPageLimit = 10;
	//	private String orderFlag = "";
	private StringBuffer pageHtml = null;
	private int showListLimit = 10;

	private String orderBy = "";
	private String orderFlag = "";

	// 검색결과텍스트 가공을 위한 배열
	String[] arrStrDtm, arrEndDtm;

	//부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "statistics";
		// request.setAttirubte("globalMenuFlag", "statistics") 와 같으며
		// 선언된 클래스의 전역으로 실행된다.
	}

	/**
	 * 메인페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/statistics")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/statistics/statistics");
		return mav;
	}

	/**
	 * 전체매출통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/salesGraphStatistics")
	public ModelAndView salesGraphStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\.");

		// 페이지 타입, 검색결과텍스트
		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(statisticService.totalSalesGraphStatistics(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		//결제수단코드
		List<Code> payWayList = codeService.listCd(Constants.PAY_WAY);

		//카테고리 리스트
		List<Category> brandDepth = categoryService.listCategory(Constants.CATE_GUBUN_BRDDEPTH);
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		List<StatisticsForm> salesList = statisticService.salesGraphStatistics(searchForm);
		List<StatisticsForm> sumSalesList = statisticService.sumSalesGraphStatistics(searchForm);

		mav.addObject("siteList", siteList);
		mav.addObject("payWayList", payWayList);

		mav.addObject("brandDepth", brandDepth);
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);

		mav.addObject("salesList", salesList);
		mav.addObject("sumSalesList", sumSalesList);

		mav.addObject("pageHtml", pageHtml);
		mav.addObject("dateText", dateText);
		mav.setViewName("/admin/statistics/salesGraphStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "일자,주문건수,결제건수,취소건수,포인트적립,포인트사용,배송비,결제금액,총매출";
			//엑셀 title, value 맵핑순서
			String colMapping = "getOrdDts,getOrdCnt,getActlCnt,getCancelCnt,getExpPnt,getUsePnt,getActlDlvCst,getActlPayPrc,getSumPrc";
			mav.addObject("totalCls", "Y");
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", salesList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "salesList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 상품별매출통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/salesProductStatistics")
	public ModelAndView salesProductStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\.");

		// 페이지 타입, 검색결과텍스트
		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();
		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(statisticService.totalSalesProductStatistics(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		List<StatisticsForm> salesProductList = statisticService.salesProductStatistics(searchForm);
		List<StatisticsForm> sumSalesProductList = statisticService.sumSalesProductStatistics(searchForm);

		//카테고리 리스트
		List<Category> brandDepth = categoryService.listCategory(Constants.CATE_GUBUN_BRDDEPTH);
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		//상품사이즈 리스트
		List<Goods> goodsSizeList = goodsSercice.listGoodsSize();

		// 사이트 리스트
		mav.addObject("siteList", siteList);

		// 사이즈리스트
		mav.addObject("goodsSizeList", goodsSizeList);

		mav.addObject("brandDepth", brandDepth);
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);

		mav.addObject("salesProductList", salesProductList);
		mav.addObject("sumSalesProductList", sumSalesProductList);

		mav.addObject("pageHtml", pageHtml);
		mav.addObject("dateText", dateText);
		mav.setViewName("/admin/statistics/salesProductStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "브랜드,1차분류,2차분류,3차분류,상품명,색상,사이즈,상품코드,총매출,판매가,판매수,최소수,취소금액,포인트적립,포인트사용";
			//엑셀 title, value 맵핑순서
			String colMapping = "getBrndNm,getSeasonGroupCode,getCategory1Code,getCategory2Code,getUbiGdsNm,getColor,getSize,getUbiGdsNo,getSumPrc,getSlPrc,getOrdCnt,getCancelCnt,getCancelSlPrc,getExpPnt,getUsePnt";
			mav.addObject("totalCls", "Y");
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", salesProductList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "salesProductList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 회원별매출통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/memStatistics")
	public ModelAndView memStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\.");

		// 페이지 타입, 검색결과텍스트
		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		int showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();
		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(statisticService.totalMemStatistics(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		//회원등급 리스트
		List<MemberGrade> memberGradeList = memberGradeService.listGrd(searchForm);

		//회원별매출
		List<StatisticsForm> memStatistics = statisticService.memStatistics(searchForm);

		String memGrdNm = "";
		for (int i = 0; i < memStatistics.size(); i++) {
			String memGrdNo = memStatistics.get(i).getMemGrdNo();
			if (memGrdNo == null) {
				memGrdNm = "GUEST";
			} else if (memGrdNo.equals("1")) {
				memGrdNm = "WHITE";
			} else {
				memGrdNm = "일반";
			}
			memStatistics.get(i).setMemGrdNo(memGrdNm);
		}

		//회원별매출 합계
		List<StatisticsForm> sumMemStatistics = statisticService.sumMemStatistics(searchForm);

		mav.addObject("memStatistics", memStatistics);
		mav.addObject("sumMemStatistics", sumMemStatistics);

		mav.addObject("memberGradeList", memberGradeList);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("dateText", dateText);
		mav.setViewName("/admin/statistics/memStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "구분,회원명,Email 계정,주소,나이,성별,판매수,수량,총매출,환불금액,포인트적립";
			//엑셀 title, value 맵핑순서
			String colMapping = "getMemGrdNo,getNm,getEmail,getOrdrBsAddr,getAge,getSex,getOrdCnt,getSlPrc,getCancelSlPrc,getExpPnt";
			mav.addObject("totalCls", "Y");
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", memStatistics);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "memStatistics");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 남녀비율통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/genderStatistics")
	public ModelAndView genderStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\-");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\-");

		// 페이지 타입, 검색결과텍스트
		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		List<SearchForm> genderVisit = statisticService.genderVisit(searchForm);

		mav.addObject("dateText", dateText);
		mav.addObject("genderVisit", genderVisit);
		mav.setViewName("/admin/statistics/genderStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "구분,회원수,신규가입,탈퇴,비율";
			//엑셀 title, value 맵핑순서
			String colMapping = "getFirstColumn,getSexCnt,getNewSex,getBenSex,getTotAvg";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", genderVisit);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "genderVisit");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 연령대별통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ageStatistics")
	public ModelAndView ageStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\-");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\-");

		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		List<SearchForm> ageVisit = statisticService.ageVisit(searchForm);

		mav.addObject("dateText", dateText);
		mav.addObject("ageVisit", ageVisit);

		mav.setViewName("/admin/statistics/ageStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "구분,회원수,비율";
			//엑셀 title, value 맵핑순서
			String colMapping = "getFirstColumn,getAgeCnt,getTotAvg";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", ageVisit);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "ageStatistics");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 거주지별통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/residenceStatistics")
	public ModelAndView residenceStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {

		ModelAndView mav = new ModelAndView();

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\-");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\-");

		String dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 ";
		dateText += "<span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		List<SearchForm> residenceVisit = statisticService.residenceVisit(searchForm);
		List<SearchForm> residenceTotal = statisticService.residenceTotal(searchForm);

		mav.addObject("dateText", dateText);
		mav.addObject("residenceVisit", residenceVisit);
		mav.addObject("residenceTotal", residenceTotal);
		mav.setViewName("/admin/statistics/residenceStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "시도,시군구,회원수,비율";
			//엑셀 title, value 맵핑순서
			String colMapping = "getFirstColumn,getGuGun,getAreaCnt,getTotAvg";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", residenceVisit);
			mav.addObject("totalCls", "Y");
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "residenceVisit");
			mav.setViewName("excelDownload");
		}
		return mav;
	}

	//	/**
	/*
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/salesStatistics")
	public ModelAndView salesStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/admin/statistics/salesStatistics");
		return mav;
	}

	/**
	 * 방문자접속통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/visitantStatistics", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView visitantStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, @ModelAttribute("statisticsForm") StatisticsForm statisticsForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		String dateType = searchForm.getDateType() == null ? "Day" : searchForm.getDateType();
		String dateText = "";

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		//브랜드 전체 셋팅
		Site siteAdd = new Site();
		siteAdd.setSiteNm("전체");

		//site 리스트
		List<Site> siteList = codeService.getSiteList();
		siteList.add(0, siteAdd);

		//검색 타입별 셋팅
		//		switch (dateType) {
		//
		//			case "Day":
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>의 검색 결과입니다.";
		//				break;
		//
		//			case "Month":
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월</span>의 검색 결과입니다.";
		//				break;
		//
		//			case "Year":
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				arrEndDtm = searchForm.getSearchEndDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 </span>부터 <span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 </span>까지의 검색 결과입니다.";
		//				break;
		//
		//			case "Week":
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				arrEndDtm = searchForm.getSearchEndDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 <span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";
		//				break;
		//			case "Hour":
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				arrEndDtm = searchForm.getSearchEndDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 <span>" + arrEndDtm[0] + "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";
		//				break;
		//
		//			default:
		//				arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		//				dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>의 검색 결과입니다.";
		//				break;
		// 		}

		searchForm.setDateType(dateType);

		List<StatisticsConn> statisticsConnList = statisticService.listVisit(searchForm);
		int tot = statisticService.StatisticsTot(searchForm);

		//ModelAndView에 추가
		mav.addObject("dateText", dateText);
		mav.addObject("siteList", siteList);
		mav.addObject("tot", tot);
		mav.addObject("statisticsConnList", statisticsConnList);
		mav.setViewName("/admin/statistics/visitant" + dateType + "Statistics");

		// 엑셀 파일명지정
		request.setAttribute("fileName", "visitant" + dateType + "Statistics");

		// list타입 문제로 엑셀다운로드를 JSP로 변경
		if (searchForm.isExcel()) {
			mav.addObject("tot", tot);
			mav.addObject("statisticsConnList", statisticsConnList);
			if (dateType.equals("Week") || dateType.equals("Month") || dateType.equals("Year")) {
				mav.addObject("dateType", "Week");
				mav.setViewName("/admin/statistics/excel/visitantStatisticsWeekExcel");
			} else {
				mav.addObject("dateType", "시");
				mav.setViewName("/admin/statistics/excel/visitantStatisticsExcel");
			}
		}

		return mav;
	}

	/**
	 * 접속방향통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/contactStatistics/{dateType}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView contactStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm, @PathVariable("dateType") String dateType,
			@RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo) throws Exception {
		ModelAndView mav = new ModelAndView();

		//브랜드 전체 셋팅
		Site siteAdd = new Site();
		siteAdd.setSiteNm("전체");

		//site 리스트
		List<Site> siteList = codeService.getSiteList();
		siteList.add(0, siteAdd);

		// 방문자타입
		dateType = dateType == "" ? "All" : dateType;
		String dateText = "";

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\-");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\-");

		dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 <span>" + arrEndDtm[0]
				+ "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		String orderBy = searchForm.getOrderBy() == null ? "All" : searchForm.getOrderBy();
		searchForm.setOrderBy(orderBy);
		searchForm.setDateType(dateType);
		searchForm.setPage(pageNo);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(statisticService.totalVisit(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		mav.addObject("pageHtml", pageHtml);
		mav.addObject("searchForm", searchForm);
		mav.addObject("totalVisit", statisticService.totalVisitCnt(searchForm));
		mav.addObject("siteList", siteList);
		mav.addObject("dateText", dateText);
		mav.addObject("pageNo", pageNo);
		mav.setViewName("/admin/statistics/contact" + dateType + "Statistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (dateType.equals("All")) {

			List<SearchForm> selectVisitAll = statisticService.selectVisitAll(searchForm);
			mav.addObject("selectVisitAll", selectVisitAll);

			if (searchForm.isExcel()) {
				//엑셀 title
				String colName = "브랜드,IP,접속경로,브라우저,OS,일시";
				//엑셀 title, value 맵핑순서
				String colMapping = "getBrndNm,getConnIpAddr,getConnDomain,getConnBrws,getConnOs,getConnDtm";
				mav.addObject("colName", colName);
				mav.addObject("colMapping", colMapping);
				mav.addObject("colValue", selectVisitAll);
				//엑셀 명(영문만 가능)
				mav.addObject("excelName", "contactStatistics");
				mav.setViewName("excelDownload");
			}
		} else {

			List<SearchForm> selectVisitEtc = statisticService.selectVisitEtc(searchForm);
			mav.addObject("selectVisitEtc", selectVisitEtc);

			if (searchForm.isExcel()) {
				//엑셀 title
				String colName = "No,접속경로,방문자수";
				String colMapping = "";
				if (dateType.equals("Domain")) {
					//엑셀 title, value 맵핑순서
					colMapping = "getRnum,getConnDomain,getVisitCnt";
				} else if (dateType.equals("Browser")) {
					//엑셀 title, value 맵핑순서
					colMapping = "getRnum,getConnBrws,getVisitCnt";
				} else {
					//엑셀 title, value 맵핑순서
					colMapping = "getRnum,getConnOs,getVisitCnt";
				}
				mav.addObject("colName", colName);
				mav.addObject("colMapping", colMapping);
				mav.addObject("colValue", selectVisitEtc);
				if (!dateType.equals("Domain")) {
					mav.addObject("totalCls", "Y");
				}
				//엑셀 명(영문만 가능)
				mav.addObject("excelName", "contactStatistics");
				mav.setViewName("excelDownload");
			}

		}

		return mav;
	}

	/**
	 * 상품별통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goodsProductStatistics")
	public ModelAndView goodsProductStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		String dateText = "";

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\.");

		dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 <span>" + arrEndDtm[0]
				+ "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? 1 : searchForm.getPage();

		showListLimit = searchForm.getSearchCount() == null ? globalShowListLimit : searchForm.getSearchCount();

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(statisticService.goodsProductStatisticsTotCnt(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);

		//site 리스트
		Site site = new Site();
		site.setSiteNm("전체");
		List<Site> siteList = codeService.getSiteList();
		siteList.add(0, site);

		List<StatisticsConn> goodsProductStatistics = statisticService.goodsProductStatisticsList(searchForm);
		List<StatisticsConn> goodsProductStatisticsTot = statisticService.goodsProductStatisticsTot(searchForm);

		mav.addObject("dateText", dateText);
		mav.addObject("siteList", siteList);
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("goodsProductStatistics", goodsProductStatistics);
		mav.addObject("goodsProductStatisticsTot", goodsProductStatisticsTot);
		mav.setViewName("/admin/statistics/goodsProductStatistics");

		// 엑셀 파일명지정
		request.setAttribute("fileName", "goodsProductStatistics");

		// list타입 문제로 엑셀다운로드를 JSP로 변경
		if (searchForm.isExcel()) {
			mav.addObject("tot", goodsProductStatisticsTot);
			mav.addObject("statisticsConnList", goodsProductStatistics);
			//			if(dateType.equals("Week") || dateType.equals("Month") || dateType.equals("Year")){
			//				mav.addObject("dateType","");
			//				mav.setViewName("/admin/statistics/excel/visitantStatisticsWeekExcel");
			//			}else{
			//				mav.addObject("dateType","시");
			mav.setViewName("/admin/statistics/excel/goodsProductStatisticsExcel");
			//			}
		}

		return mav;
	}

	/**
	 * 적립금사용통계
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savingStatistics")
	public ModelAndView savingStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		String dateText = "";

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
		String nowDate = transFormat.format(from);

		if (searchForm.getSearchStrDtm() == "" || searchForm.getSearchStrDtm() == null) {
			searchForm.setSearchStrDtm(nowDate);
		}

		if (searchForm.getSearchEndDtm() == "" || searchForm.getSearchEndDtm() == null) {
			searchForm.setSearchEndDtm(nowDate);
		}

		arrStrDtm = searchForm.getSearchStrDtm().split("\\.");
		arrEndDtm = searchForm.getSearchEndDtm().split("\\.");

		dateText = "<span class='icon2'></span><span>" + arrStrDtm[0] + "년 " + arrStrDtm[1] + "월 " + arrStrDtm[2] + "일</span>부터 <span>" + arrEndDtm[0]
				+ "년 " + arrEndDtm[1] + "월 " + arrEndDtm[2] + "일</span>까지의 검색 결과입니다.";

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

		List<SearchForm> savingStatisticsList = statisticService.savingStatisticsList(searchForm);
		List<SearchForm> savingStatisticsTotal = statisticService.savingStatisticsTotal(searchForm);

		mav.addObject("dateText", dateText);
		mav.addObject("siteList", siteList);
		mav.addObject("memberGradeList", memberGradeList);
		mav.addObject("savingStatisticsTotal", savingStatisticsTotal);
		mav.addObject("savingStatisticsList", savingStatisticsList);
		mav.setViewName("/admin/statistics/savingStatistics");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "일자,판매금액,회원할인,포인트적립,포인트사용";
			//엑셀 title, value 맵핑순서
			String colMapping = "getFirstColumn,getTotPay,getMemGradeDc,getTotPoint,getUsePoint";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			mav.addObject("colValue", savingStatisticsList);
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "savingStatisticsList");
			mav.setViewName("excelDownload");
		}

		return mav;
	}

	/**
	 * 시군Select박스 Ajax호출
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "residenceStatisticsAjax", method = RequestMethod.POST)
	public @ResponseBody void residenceStatisticsAjax(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();

		List<HashMap<String, String>> result = statisticService.residenceVisitAjax(searchForm);

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(result));
	}

}