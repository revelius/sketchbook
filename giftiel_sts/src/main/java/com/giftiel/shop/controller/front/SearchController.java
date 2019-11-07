package com.giftiel.shop.controller.front;

import java.io.UnsupportedEncodingException;
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
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ManageService;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/search")
public class SearchController extends FrontController{
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ManageService manageService;
	
	private int currentPage = 1;
	private int showListLimit = 60;
	private int showPageLimit = 10;	
	private StringBuffer pageHtml = null;	
	
	@RequestMapping(value = "/search", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView onlineShopSearch(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = 1;
//		currentPage = searchForm.getPage()==null?1:searchForm.getPage();
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		
		//worksout 접속
		if(!"10001".equals(getSiteNo(request).toString())){
			searchForm.setSiteNo(getSiteNo(request).toString());
		}

		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setGdsStat(Constants.GDS_STAT_SALE);
		searchForm.setTotalCnt(goodsService.totalListGoodsFrontAjax(searchForm));
		
//		searchForm.setPage(currentPage);

		List<Goods> goodsList = goodsService.listGoodsFrontAjax(searchForm);
		
		Integer totalCnt = searchForm.getTotalCnt();
		String searchText = searchForm.getSearchText();
		
		mav.addObject("goodsList", goodsList);
		mav.addObject("totalCnt", totalCnt);
		mav.addObject("searchText", searchText);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/worksout/search/searchResult");
		return mav;
	}
	
	@RequestMapping(value = "/onlineShopAjax", method = RequestMethod.POST)
	public void onlineShopAjax(Locale locale , HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws Exception {
		
		Gson gson = new Gson();
		
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();

		int nextPage = currentPage + 1;
		
		//검색조건 게시물의 총 결과 갯수
//		searchForm.setSiteNo(getSiteNo(request).toString());
		//worksout 접속
		if(!"10001".equals(getSiteNo(request).toString())){
			searchForm.setSiteNo(getSiteNo(request).toString());
		}
//		searchForm.setGdsStat(Constants.GDS_STAT_SALE);
		searchForm.setStartListNum((nextPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		searchForm.setTotalCnt(goodsService.totalListGoodsFrontAjax(searchForm));
		List<Goods> goodsList = goodsService.listGoodsFrontAjax(searchForm);
		
//		List<Goods> goodsList = goodsService.listGoodsFront(searchForm);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(goodsList));
	}
	
}

























