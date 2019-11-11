package com.giftiel.shop.controller.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.giftiel.shop.controller.common.DefaultController;
import com.giftiel.shop.dao.GiftielViewDao;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.CategoryForm;
import com.giftiel.shop.dto.CategoryNew;
import com.giftiel.shop.dto.CategoryNewGoods;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.GiftielViewInput;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.GoodsAddInfo;
import com.giftiel.shop.dto.GoodsAddInfoGrp;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.SeasonForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.UbiCode;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/goods")
public class GoodsController extends DefaultController {
	@Value("${upload.image}")
	private String uploadImage;

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private Seed seed;
	/*테스트 API 용*/
	@Autowired
	private GiftielViewDao gvd;

	private String orderBy = "";
	private String orderFlag = "";

	private int currentPage = 1;
	private int showListLimit = 10;
	private int showPageLimit = 10;
	private StringBuffer pageHtml = null;

	//부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "goods";
		// request.setAttirubte("globalMenuFlag", "manage") 와 같으며
		// 선언된 클래스의 전역으로 실행된다.
	}

	/**
	 * 상품관리 메인페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/main")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/main");
		return mav;
	}

	/**
	 * 상품 리스트 페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsList")
	public ModelAndView goodsList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		//searchForm.setRownum(searchForm.getPage()==null?20:null);

		orderBy = searchForm.getOrderBy();
		orderFlag = searchForm.getOrderFlag();
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(goodsService.totalListGoods(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		//		pageHtml = pagingUtil.getBootPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		List<Goods> goodsList = goodsService.listGoods(searchForm);

		//상품상태 코드리스트
		List<Code> gdsStatList = codeService.listCd(Constants.GDS_STAT);

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		//사이트, 브랜드 리스트
		List<Site> siteList = codeService.getSiteList();

		mav.addObject("siteList", siteList);
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("goodsList", goodsList);
		mav.addObject("gdsStatList", gdsStatList);
		mav.addObject("searchForm", searchForm);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/goodsList");

		//엑셀다운로드 view 전달객체 셋팅
		if (searchForm.isExcel()) {
			//엑셀 title
			String colName = "회원번호,회원등급번호,이름,이메일";
			//엑셀 title, value 맵핑순서
			String colMapping = "getMemNo,getMemGrdNo,getNm,getEmail";
			mav.addObject("colName", colName);
			mav.addObject("colMapping", colMapping);
			//mav.addObject("colValue", goodsList.get(0).getUbiGoods());
			//엑셀 명(영문만 가능)
			mav.addObject("excelName", "goodsList");
			//mav.setViewName("excelDownload");
		}
		return mav;
	}

	/**
	 * 상품 상세 페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsDetail")
	public ModelAndView goodsDetail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ubiGdsNo") String ubiGdsNo, @RequestParam("ubiGdsSize") String ubiGdsSize, @ModelAttribute("goodsForm") Goods goods)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setUbiGdsNo(ubiGdsNo);
		searchForm.setUbiGdsSize(ubiGdsSize);

		//상품정보
		goods = goodsService.selectGoods(searchForm);

		//기본폼 셋팅
		goods.setDispYn(goods.getDispYn() == null ? "Y" : goods.getDispYn());
		goods.setSlTermCls(goods.getSlTermCls() == null ? "GD00501" : goods.getSlTermCls());
		goods.setGdsStat(goods.getGdsStat() == null ? "GD00401" : goods.getGdsStat());

		//상품정보고시
		//List<GoodsAddInfoGrp> addInfoList = goodsService.listAddInfoGrp(searchForm);

		//코드정보
		List<Code> gdsStatList = codeService.listCd(Constants.GDS_STAT); //상품상태
		List<Code> slTermClsList = codeService.listCd(Constants.SL_TERM_CLS); //판매기간구분

		mav.addObject("goodsForm", goods);
		//mav.addObject("addInfoList", addInfoList);
		mav.addObject("gdsStatList", gdsStatList);
		mav.addObject("slTermClsList", slTermClsList);
		mav.addObject("uploadImage", uploadImage);
		//		mav.setViewName("/admin/goods/goodsDetail");
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/goodsDetail");
		return mav;
	}

	/**
	 * 상품정보 저장(merge)
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param goods
	 * @param redirectAttr
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/saveGoods", method = RequestMethod.POST)
	public ModelAndView saveGoods(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("goodsForm") Goods goods) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		goods.setRegrNo(admin.getUserNo());
		goods.setUpdrNo(admin.getUserNo());

		//상품정보 merge

		try {
			goodsService.mergeGoods(goods);
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect",
				"goodsDetail?ubiGdsNo=" + goods.getUbiGoods().getUbiGdsNo() + "&ubiGdsSize=" + goods.getUbiGoods().getUbiGdsSize());
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	/**
	 * 상품 추가정보(상품정보고시)
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsAddInfoGrpList")
	public ModelAndView goodsAddInfoGrpList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		List<GoodsAddInfoGrp> addInfoList = goodsService.listAddInfoGrp(searchForm);

		mav.addObject("addInfoList", addInfoList);

		mav.setViewName("/admin/goods/goodsAddInfoGrpList");
		return mav;
	}

	/**
	 * 상품 추가정보 상세내용(AJAX)
	 *
	 * @param locale
	 * @param request
	 * @param response
	 * @param model
	 * @param sidoNm
	 * @throws Exception
	 */
	@RequestMapping(value = "/goodsAddInfoAjax", method = RequestMethod.POST)
	public void goodsAddInfoAjax(Locale locale, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam("gdsInfoNo") Integer gdsInfoNo) throws Exception {
		Gson gson = new Gson();

		SearchForm searchForm = new SearchForm();
		searchForm.setGdsInfoNo(gdsInfoNo);

		GoodsAddInfoGrp addInfoList = goodsService.selectAddInfoGrp(searchForm);

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(addInfoList));
	}

	/**
	 * 상품 추가정보(상품정보고시)
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsAddInfoGrpExcel")
	public ModelAndView goodsAddInfoGrpExcelList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("goodsAddInfoGrp") GoodsAddInfoGrp goodsAddInfoGrp) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/admin/goods/goodsAddInfoGrpExcel");
		return mav;
	}

	/**
	 * 상품 추가정보(상품정보고시)
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsAddInfoGrpExcelSave", method = RequestMethod.POST)
	public ModelAndView goodsAddInfoGrpExcelSave(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("goodsAddInfoGrp") GoodsAddInfoGrp goodsAddInfoGrp) throws Exception {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		goodsAddInfoGrp.setRegrNo(admin.getUserNo());
		goodsAddInfoGrp.setUpdrNo(admin.getUserNo());

		List<GoodsAddInfo> goodsAddInfo = goodsAddInfoGrp.getGoodsAddInfos();

		System.out.println("goodsAddInfo===" + goodsAddInfo);

		for (int i = 0; i < goodsAddInfo.size(); i++) {
			goodsAddInfo.get(i).setRegrNo(admin.getUserNo());
			goodsAddInfo.get(i).setUpdrNo(admin.getUserNo());
		}
		goodsAddInfoGrp.setGoodsAddInfos(goodsAddInfo);

		//상품정보 merge
		try {
			goodsService.saveInfoGrpExcel(goodsAddInfoGrp);
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "goodsAddInfoGrpList");
		mav.setViewName("/common/scriptView/script");

		return mav;
	}

	/**
	 * 상품 진열순서 페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goodsDisplay")
	public ModelAndView goodsDisplay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//페이징처리
		if (StringUtils.isNotEmpty(searchForm.getOneDepth()) && StringUtils.isNotEmpty(searchForm.getTwoDepth())
				|| searchForm.isNewArrival() == true) {
			List<Goods> goodsList = goodsService.listGoodsCategoryDisplay(searchForm);
			List<Goods> brandList = goodsService.listGoodsCategoryDisplayBrand(searchForm);
			List<Goods> threeDepth = goodsService.listGoodsCategoryDisplayThreeDepth(searchForm);

			mav.addObject("goodsList", goodsList);
			mav.addObject("brandList", brandList);
			mav.addObject("threeDepth", threeDepth);
		}

		//사이트, 브랜드 리스트
		List<Site> siteList = codeService.getSiteList();

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		mav.addObject("siteList", siteList);
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		mav.addObject("searchForm", searchForm);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/goodsDisplay");

		return mav;
	}

	@RequestMapping(value = "/goodsDisplayNew")
	public ModelAndView goodsDisplayNew(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//페이징처리
		if (StringUtils.isNotEmpty(searchForm.getOneDepth()) && StringUtils.isNotEmpty(searchForm.getTwoDepth())
				|| searchForm.isNewArrival() == true) {
			List<Goods> goodsList = goodsService.listGoodsCategoryDisplayNew(searchForm);

			if (goodsList.size() == 0) {
				goodsList = goodsService.listGoodsCategoryDisplay(searchForm);
			}

			List<Goods> brandList = goodsService.listGoodsCategoryDisplayBrand(searchForm);
			List<Goods> threeDepth = goodsService.listGoodsCategoryDisplayThreeDepth(searchForm);

			mav.addObject("goodsList", goodsList);
			mav.addObject("brandList", brandList);
			mav.addObject("threeDepth", threeDepth);
		}

		//사이트, 브랜드 리스트
		List<Site> siteList = codeService.getSiteList();

		SearchForm searchForm2 = new SearchForm();
		searchForm2.setBrand(Constants.BRAND);
		List<Code> brandCode = categoryService.listCdAll(searchForm2);

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		mav.addObject("siteList", siteList);
		mav.addObject("brandCode", brandCode);
		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		mav.addObject("searchForm", searchForm);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/goodsDisplayNew");

		return mav;
	}

	/**
	 * 상품정보 정렬순서 저장
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param goods
	 * @param redirectAttr
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/saveGoodsDisplay", method = RequestMethod.POST)
	public ModelAndView saveGoodsDisplay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "ubiGdsNo") List<String> ubiGdsNos, @RequestParam(value = "sortNo") List<Integer> sortNos,
			@RequestParam(value = "newArrivalChk") String newArrivalChk, @RequestParam(value = "siteNo") Integer siteNo)
			throws UnsupportedEncodingException {

		ModelAndView mav = new ModelAndView();
		Goods goods = new Goods();

		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		try {
			for (int i = 0; i < ubiGdsNos.size(); i++) {

				System.out.println(ubiGdsNos.get(i) + "===" + sortNos.get(i));

				goods.setUbiGdsNo(ubiGdsNos.get(i));
				goods.setSortNo(sortNos.get(i));
				goods.setUpdrNo(admin.getUserNo());
				goods.setSiteNo(siteNo);
				if (StringUtils.isNotEmpty(newArrivalChk)) {
					goods.setNewArrivalChk(true);
				} else {
					goods.setNewArrivalChk(false);
				}
				goodsService.updateGoodsDisplay(goods);
			}
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "goodsDisplay");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	@RequestMapping(value = "/saveGoodsDisplayNew", method = RequestMethod.POST)
	public ModelAndView saveGoodsDisplayNew(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "ubiGdsNo") List<String> ubiGdsNos, @RequestParam(value = "sortNo") List<Integer> sortNos,

			@RequestParam(value = "newArvl") String newArvl, @RequestParam(value = "siteNo") Integer siteNo,
			@RequestParam(value = "oneDepth") String oneDepth, @RequestParam(value = "twoDepth") String twoDepth,
			@RequestParam(value = "threeDepth") String threeDepth, @RequestParam(value = "sex") String sex,
			@RequestParam(value = "brand") String brand) throws UnsupportedEncodingException {

		ModelAndView mav = new ModelAndView();
		Goods goods = new Goods();

		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		try {

			CategoryNew categoryNew = new CategoryNew();
			categoryNew.setBrand(brand);
			categoryNew.setNewArvl(newArvl);
			categoryNew.setOneDepth(oneDepth);
			categoryNew.setTwoDepth(twoDepth);
			categoryNew.setThreeDepth(threeDepth);
			categoryNew.setSex(sex);
			categoryNew.setSiteNo(siteNo);
			categoryNew.setBrand(brand);

			List<CategoryNewGoods> categoryNewGoodss = new ArrayList<CategoryNewGoods>();

			for (int i = 0; i < ubiGdsNos.size(); i++) {
				CategoryNewGoods categoryNewGoods = new CategoryNewGoods();
				categoryNewGoods.setGdsNo(ubiGdsNos.get(i));
				categoryNewGoods.setPrir(sortNos.get(i));
				categoryNewGoodss.add(categoryNewGoods);
			}

			categoryNew.setCategoryNewGoods(categoryNewGoodss);

			categoryService.insertCategoryNew(categoryNew);

			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "goodsDisplayNew");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	@RequestMapping(value = "/saveGoodsExcel")
	public ModelAndView saveGoodsExcel(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/admin/goods/saveGoodsExcel");

		return mav;
	}

	/**
	 * 상품정보 대량 저장(Excel)
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param goods
	 * @param redirectAttr
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/saveGoodsExcel", method = RequestMethod.POST)
	public ModelAndView saveGoodsExcel(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("goodsForm") Goods goods) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		int result = 0;

		List<Goods> goodss = goods.getGoodss();

		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		for (int i = 0; i < goodss.size(); i++) {
			goodss.get(i).setRegrNo(admin.getUserNo());
			goodss.get(i).setUpdrNo(admin.getUserNo());
		}

		//상품정보 merge
		try {
			result = goodsService.mergeGoodsExcel(goodss);
			mav.addObject("alert", "상품 " + result + "건이 저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "saveGoodsExcel");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	/**
	 * 상품정보 정렬순서 저장
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param goods
	 * @param redirectAttr
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/saveGoodsDisplayCollabo", method = RequestMethod.POST)
	public ModelAndView saveGoodsDisplayCollabo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "ubiGdsNo") List<String> ubiGdsNos, @RequestParam(value = "cllbSortNo") List<Integer> cllbSortNo)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		Goods goods = new Goods();

		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		try {
			for (int i = 0; i < ubiGdsNos.size(); i++) {

				//				System.out.println(ubiGdsNos.get(i) + "===" + cllbSortNo.get(i));

				goods.setUbiGdsNo(ubiGdsNos.get(i));
				goods.setCllbSortNo(cllbSortNo.get(i));
				goods.setUpdrNo(admin.getUserNo());

				goodsService.updateGoodsSortCollabo(goods);
			}
			mav.addObject("alert", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("alert", "저장에 실패하였습니다.");
		}

		mav.addObject("redirect", "/admin/manage/collaboDetail");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	@RequestMapping(value = "/newArrivalCheck", method = RequestMethod.POST)
	public void newArrivalCheck(Locale locale, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam("ubiGdsNo") String ubiGdsNo, @RequestParam("newArvlChk") String newArvlChk, @RequestParam("siteNo") Integer siteNo)
			throws Exception {
		//admin 접속정보
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		Gson gson = new Gson();

		Goods goods = new Goods();
		goods.setUbiGdsNo(ubiGdsNo);
		goods.setNewArvl(newArvlChk);
		goods.setSiteNo(siteNo);
		goods.setUpdrNo(admin.getUserNo());

		if ("Y".equals(newArvlChk)) {
			goods.setSortNo2("0");
		}

		int result = 0;

		try {
			if (StringUtils.isNotEmpty(ubiGdsNo)) {
				goodsService.updateGoodsArrvSort(goods);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = 1;
		}

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(result));
	}

	/**
	 * 시즌 설정 관리
	 *
	 * @param goods
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/seasonConfig", method = RequestMethod.GET)
	public ModelAndView seasonConfig(@ModelAttribute("categoryForm") CategoryForm categoryForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//사이트, 브랜드 리스트
		List<Site> siteList = codeService.getSiteList();

		//UBI 시즌 정보 리스트
		List<Category> seasonList = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);

		//시즌설정정보 리스트
		List<SeasonForm> seasonFormList = categoryService.getSeasonCategory(siteList);

		categoryForm.setSeasonFormList(seasonFormList);

		//		mav.addObject("seasonFormList", seasonFormList);
		mav.addObject("seasonList", seasonList);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/seasonConfig");
		return mav;
	}

	/**
	 * 시즌정보 저장proc
	 *
	 * @param categoryForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveSeason", method = RequestMethod.POST)
	public @ResponseBody int saveSeason(

			@ModelAttribute("categoryForm") CategoryForm categoryForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		//		categoryForm.getSeasonFormList().g
		//		goods.setRegrNo(admin.getUserNo());

		int result = categoryService.saveSeason(categoryForm, admin.getUserNo());
		return result;
	}

	/**
	 * 카테고리 설정 관리
	 *
	 * @param goods
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/categoryConfig", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView categoryConfig(@ModelAttribute("categoryForm") CategoryForm categoryForm, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		categoryForm.setUserNo(admin.getUserNo());

		//사이트, 브랜드 리스트
		List<Site> siteList = codeService.getSiteList();

		//시즌설정정보 리스트
		List<SeasonForm> seasonFormList = categoryService.getSeasonCategory(siteList);

		categoryForm.setSeasonFormList(seasonFormList);

		//카테고리 리스트
		//		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		//		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		//		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);
		//		List<Code> brandCode = codeService.listCd(Constants.BRAND);

		categoryForm.setSearch("all");
		List<UbiCode> ubiCodeList = categoryService.getUbiCategory(categoryForm);

		//카테고리 설정값 초기화
		categoryForm.setCateMenDepth2("");
		categoryForm.setCateMenDepth3("");
		categoryForm.setMenNaDispYn("");
		categoryForm.setCateWomenDepth2("");
		categoryForm.setCateWomenDepth3("");
		categoryForm.setWomenNaDispYn("");

		//카테고리 설정값 가져오기
		HashMap<String, String> cateHm = categoryService.getCateDepth(categoryForm);

		categoryForm.setCateMenDepth2(cateHm.get("MEN2"));
		categoryForm.setCateMenDepth3(cateHm.get("MEN3"));
		categoryForm.setMenNaDispYn(cateHm.get("MEN_NA_DISP_YN"));
		categoryForm.setMenNaDispNm(cateHm.get("MEN_NA_DISP_NM"));
		categoryForm.setCateWomenDepth2(cateHm.get("WOMEN2"));
		categoryForm.setCateWomenDepth3(cateHm.get("WOMEN3"));
		categoryForm.setWomenNaDispYn(cateHm.get("WOMEN_NA_DISP_YN"));
		categoryForm.setWomenNaDispNm(cateHm.get("WOMEN_NA_DISP_NM"));

		//brand 설정값 가져오기
		categoryForm.setDepthCode("CM01503");
		String brandCd = categoryService.getBrand(categoryForm);
		categoryForm.setBrandCd(brandCd);

		categoryForm.setDepthCode("CM01504");
		String brandCd2 = categoryService.getBrand2(categoryForm);
		categoryForm.setBrandCd2(brandCd2);

		//등록시즌 정보 리스트
		List<HashMap<String, String>> seasonList = categoryService.getSeasonList(categoryForm);

		//brand 리스트
		List<Code> brandList = codeService.listUbiBrand();

		mav.addObject("brandList", brandList);
		mav.addObject("ubiCodeList", ubiCodeList);
		mav.addObject("seasonList", seasonList);
		mav.addObject("siteList", siteList);
		//		mav.setViewName("/admin/goods/categoryConfig");
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/categoryConfig");
		return mav;
	}

	/**
	 * 카테고리 저장proc
	 *
	 * @param categoryForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveCateAjax", method = RequestMethod.POST)
	public @ResponseBody int saveCateAjax(

			@ModelAttribute("categoryForm") CategoryForm categoryForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		categoryForm.setUserNo(admin.getUserNo());
		int result = categoryService.saveCate(categoryForm);

		//worksout만 브랜드 저장
		if (categoryForm.getSiteNo() == 10001) {
			if (categoryForm.getBrandCd() == null) {
				categoryForm.setBrandCd("");
			}
			result = categoryService.saveBrand(categoryForm);
		}

		return result;
	}

	/**
	 * 쿠폰 리스트
	 *
	 * @param searchForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/couponConfig", method = RequestMethod.GET)
	public ModelAndView couponConfig(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<Coupon> couponList = goodsService.getCouponList(searchForm);//new ArrayList<Coupon>();

		mav.addObject("couponList", couponList);
		mav.addObject("searchForm", searchForm);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/couponList");
		return mav;
	}

	/**
	 * 쿠폰 생성
	 *
	 * @param couponForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/couponReg", method = RequestMethod.POST)
	public ModelAndView couponReg(@ModelAttribute("couponForm") Coupon couponForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		//쿠폰종류
		List<Code> cpnKndList = codeService.listCd(Constants.CPN_KND);
		//발급방식
		List<Code> issWayList = codeService.listCd(Constants.ISS_WAY);
		//할인방식
		List<Code> dcWayList = new ArrayList<Code>();
		List<Code> dcWayListTemp = codeService.listCd(Constants.DC_WAY);

		for (Code dw : dcWayListTemp) {
			if (!dw.getCdNo().equals("CM00203")) {
				dcWayList.add(dw);
			}
		}

		//유효기간구분
		List<Code> vldTermClsList = codeService.listCd(Constants.VLD_TERM_CLS);
		//쿠폰상태
		List<Code> cpnStatList = codeService.listCd(Constants.CPN_STAT);

		mav.addObject("cpnKndList", cpnKndList);
		mav.addObject("issWayList", issWayList);
		mav.addObject("dcWayList", dcWayList);
		mav.addObject("vldTermClsList", vldTermClsList);
		mav.addObject("cpnStatList", cpnStatList);
		mav.addObject("couponForm", couponForm);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/couponReg");
		return mav;
	}

	/**
	 * 쿠폰생성 process
	 *
	 * @param couponForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/couponRegProc", method = RequestMethod.POST)
	public ModelAndView couponRegProc(@ModelAttribute("couponForm") Coupon couponForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		couponForm.setRegrNo(admin.getUserNo());
		couponForm.setUpdrNo(admin.getUserNo());

		goodsService.couponReg(couponForm);

		return new ModelAndView("redirect:/admin/goods/couponConfig");
	}

	/**
	 * 쿠폰 수정 process
	 *
	 * @param couponForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/couponModifyProc", method = RequestMethod.POST)
	public ModelAndView couponModifyProc(@ModelAttribute("couponForm") Coupon couponForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		couponForm.setRegrNo(admin.getUserNo());
		couponForm.setUpdrNo(admin.getUserNo());

		goodsService.couponModify(couponForm);

		return new ModelAndView("redirect:/admin/goods/couponConfig");
	}

	/**
	 * 쿠폰 수정페이지
	 *
	 * @param couponForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/couponModify", method = RequestMethod.POST)
	public ModelAndView couponModify(@RequestParam("cpnNo") int cpnNo, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Coupon couponForm = goodsService.getCoupon(cpnNo);

		//쿠폰종류
		List<Code> cpnKndList = codeService.listCd(Constants.CPN_KND);
		//발급방식
		List<Code> issWayList = codeService.listCd(Constants.ISS_WAY);
		//할인방식
		List<Code> dcWayList = new ArrayList<Code>();
		List<Code> dcWayListTemp = codeService.listCd(Constants.DC_WAY);

		for (Code dw : dcWayListTemp) {
			if (!dw.getCdNo().equals("CM00203")) {
				dcWayList.add(dw);
			}
		}

		//유효기간구분
		List<Code> vldTermClsList = codeService.listCd(Constants.VLD_TERM_CLS);
		//쿠폰상태
		List<Code> cpnStatList = codeService.listCd(Constants.CPN_STAT);

		mav.addObject("cpnKndList", cpnKndList);
		mav.addObject("issWayList", issWayList);
		mav.addObject("dcWayList", dcWayList);
		mav.addObject("vldTermClsList", vldTermClsList);
		mav.addObject("cpnStatList", cpnStatList);
		mav.addObject("couponForm", couponForm);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/couponModify");
		return mav;
	}

	/**
	 * NEW ARRIVAL명 수정
	 *
	 * @param categoryForm
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateNaAjax", method = RequestMethod.POST)
	public @ResponseBody int updateNaAjax(

			@ModelAttribute("categoryForm") CategoryForm categoryForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Admin admin = (Admin) request.getSession().getAttribute("admin");
		categoryForm.setUserNo(admin.getUserNo());
		int result = categoryService.updateNa(categoryForm);

		return result;
	}
	
	/*
	 * gvd.getReplyData(gvi, String type); type에 따라 다음과 같은 API를 사용합니다.
		"GetCouponViewData" 				=>	 giftielGetCouponViewDataUrl;break;
		"GetCouponCondition"				=> 	 giftielGetCouponConditionUrl;break;
		"GetCouponConditionEx" 				=>	 giftielGetCouponConditionExUrl;break;
		"GetEachCouponAuthInformation" 		=>	 giftielGetEachCouponAuthInformationUrl;break;
		"GetSendCouponData" 				=>	 giftielGetSendCouponDataUrl;break;
	 */
	@RequestMapping(value="/test")
	public ModelAndView test(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
			ModelAndView mav = new ModelAndView();
			
			GiftielViewInput gvi=new GiftielViewInput();
			
			gvi.setCiCode("1111");
			gvi.setCiPwd("1111");
			gvi.setCouponNum("1111");
			gvi.setCouponCode("1111");
			
			String str=gvd.getReplyData(gvi, "GetCouponViewData");
		
			mav.addObject("result", str);
			
			mav.setViewName("/admin" + Constants.MODE_ADMIN + "/goods/GoodsTest");
			return mav;
	}

}
