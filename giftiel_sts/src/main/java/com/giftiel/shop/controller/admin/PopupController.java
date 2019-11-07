package com.giftiel.shop.controller.admin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.GoodsAddInfoGrp;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.ZipCode;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ZipCodeService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/popup")
public class PopupController {
	@Value("${server.setting}")
	private String serverSetting;

	@Value("${upload.image}")
	private String uploadImage;

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ZipCodeService zipCodeService;
	@Autowired
	private Seed seed;

	private int currentPage = 1;
	private int showListLimit = 10;
	private int showPageLimit = 10;
	private StringBuffer pageHtml = null;

	@RequestMapping(value = "/zipCode/selectSido")
	public ModelAndView selectSido(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		if (searchForm.getSidoNm() != null) {
			List<SearchForm> zipCodeList = zipCodeService.selectAddressList(searchForm);
			model.addAttribute("zipCodeList", zipCodeList);
		}

		mav.setViewName("/admin/popup/zipcode");
		return mav;
	}

	@RequestMapping(value = "/zipCode/sigunguList", method = RequestMethod.POST)
	public void sigunguList(Locale locale, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam("sidoNm") String sidoNm) throws Exception {
		Gson gson = new Gson();

		List<ZipCode> list = zipCodeService.selectSiGungu(sidoNm);

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(list));
	}

	@RequestMapping(value = "/goods/popupGoodsAddInfo")
	public ModelAndView goodsAddInfo(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("goodsAddInfoGrp") GoodsAddInfoGrp goodsAddInfoGrp) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/admin/popup/popupGoodsAddInfo");
		return mav;
	}

	@RequestMapping(value = "/goods/popupGoodsUpdInfo")
	public ModelAndView goodsUpdInfo(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("goodsAddInfoGrp") GoodsAddInfoGrp goodsAddInfoGrp, @RequestParam("gdsInfoNo") Integer gdsInfoNo) {
		ModelAndView mav = new ModelAndView();

		SearchForm searchForm = new SearchForm();
		searchForm.setGdsInfoNo(gdsInfoNo);

		goodsAddInfoGrp = goodsService.selectAddInfoGrp(searchForm);
		model.addAttribute("goodsAddInfoGrp", goodsAddInfoGrp);

		mav.setViewName("/admin/popup/popupGoodsAddInfo");
		return mav;
	}

	/**
	 * 상품 추가정보(상품정보고시) 저장
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goods/saveGoodsAddInfo")
	public ModelAndView saveGoodsAddInfo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("goodsAddInfoGrp") GoodsAddInfoGrp goodsAddInfoGrp) throws IOException {
		ModelAndView mav = new ModelAndView();
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		try {
			goodsAddInfoGrp.setRegrNo(admin.getUserNo());
			goodsAddInfoGrp.setUpdrNo(admin.getUserNo());
			goodsService.saveInfoGrp(goodsAddInfoGrp);
			mav.addObject("alert", "저장하였습니다.");
		} catch (Exception e) {
			mav.addObject("alert", "저장에 실패하였습니다.");
		}
		mav.addObject("openerReload", "true");
		mav.addObject("windowClose", "true");
		mav.setViewName("/common/scriptView/script");
		return mav;
	}

	/**
	 * 직접등록 팝업
	 *
	 * @param lookbook
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookbook/popupPersonallyRegister", method = RequestMethod.GET)
	public ModelAndView lookbookRegAjax(@ModelAttribute IntgBoard lookbook, @RequestParam("type") String type, @RequestParam("target") String target,
			@RequestParam("folderNm") String folderNm, @RequestParam("targetTbody") String targetTbody, Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("type", type);
		mav.addObject("target", target);
		mav.addObject("folderNm", folderNm);
		mav.addObject("targetTbody", targetTbody);
		mav.setViewName("/admin/popup/personallyRegister");
		return mav;
	}

	/**
	 * 상품 리스트 팝업
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goods/popupGoodsList")
	public ModelAndView popupGoodsList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage() == null ? 20 : null);

		if (StringUtils.isNotEmpty(searchForm.getOneDepth())) {
			//검색조건 게시물의 총 결과 갯수
			currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
			showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
			searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
			searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
			searchForm.setTotalCnt(goodsService.totalListGoods(searchForm));

			//페이징처리
			PagingUtil pagingUtil = new PagingUtil();
			pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
			List<Goods> goodsList = goodsService.listGoods(searchForm);

			mav.addObject("goodsList", goodsList);
		}

		//상품상태 코드리스트
		List<Code> gdsStatList = codeService.listCd(Constants.GDS_STAT);

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("gdsStatList", gdsStatList);
		mav.addObject("searchForm", searchForm);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin/popup/popupGoodsList");
		return mav;
	}

	/**
	 * 상품 리스트 팝업
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/goods/popupGoodsListForStatistics")
	public ModelAndView popupGoodsListForStatistics(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//view 테이블 자체가 느려서 페이지 첫 호출시 설정함.
		searchForm.setRownum(searchForm.getPage() == null ? 20 : null);

		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage() == null ? currentPage : searchForm.getPage();
		showListLimit = searchForm.getSearchCount() == null ? showListLimit : searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);
		searchForm.setTotalCnt(goodsService.totalListGoods(searchForm));

		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), showListLimit, showPageLimit);
		List<Goods> goodsList = goodsService.listGoods(searchForm);

		//상품상태 코드리스트
		List<Code> gdsStatList = codeService.listCd(Constants.GDS_STAT);

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);
		List<Category> twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		List<Category> threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);

		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);
		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("pageHtml", pageHtml);
		mav.addObject("goodsList", goodsList);
		mav.addObject("gdsStatList", gdsStatList);
		mav.addObject("searchForm", searchForm);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/admin/popup/popupGoodsListForStatistics");
		return mav;
	}
}