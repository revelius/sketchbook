package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.CurrentGoodsColors;
import com.giftiel.shop.dto.FeatureManage;
import com.giftiel.shop.dto.FeatureManageForm;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.GoodsAddInfoGrp;
import com.giftiel.shop.dto.GoodsView;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.utils.PagingUtil;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/onlineShop")
public class OnlineShopController extends FrontController{
	@Value("${server.setting}")
	private String serverSetting;
	
	
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ManageService manageService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;	
	@Autowired
	private Seed seed;	
	
	private int currentPage = 1;
	private int showListLimit = 60;
	private int showPageLimit = 60;
	private StringBuffer pageHtml = null;
	
	@RequestMapping(value = "/goodsList")
	public ModelAndView goodsList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) 
	throws UnsupportedEncodingException {
		String sex = request.getParameter("sex");
		String oneDepth = request.getParameter("oneDepth");
		String twoDepth = request.getParameter("twoDepth")==null?"":request.getParameter("twoDepth");
		String threeDepth = request.getParameter("threeDepth");
		String brand = request.getParameter("brand")==null?"":request.getParameter("brand");
		String ubiGdsSize = request.getParameter("ubiGdsSize");
		String orderBy = request.getParameter("orderBy");
		String orderFlag = request.getParameter("orderFlag");
		String clbltnNm = request.getParameter("clbltnNm");
		String viewType = request.getParameter("viewType");
		String nowSeq = request.getParameter("nowSeq");
		
		HttpSession session = request.getSession();
		if(nowSeq!=null){
			session.setAttribute("nowSeq", Integer.valueOf(nowSeq));
		}else{
			int siteNo = getSiteNo(request);
			HashMap<String,Object> hm = new HashMap<String,Object>();
			hm.put("siteNo", siteNo);
			hm.put("seasonCd", oneDepth);
			if(oneDepth != null) {
				session.setAttribute("nowSeq", Integer.valueOf(categoryService.getSeasonSeq(hm)));
			}
		}
		
		
		
		String newArvl = request.getParameter("newArvl");
		
		ModelAndView mav = new ModelAndView();
		SearchForm searchForm = new SearchForm();
		
		//현재 설정된 시즌 셋팅
		searchForm.setPreSeason(request.getAttribute("preDispYn").equals("Y")?request.getAttribute("preSeason").toString():"");//지난시즌(season1)
		searchForm.setCurSeason(request.getAttribute("currentDispYn").equals("Y")?request.getAttribute("currentSeason").toString():"");//현시즌(season2)
		searchForm.setNowSeq(Integer.parseInt(session.getAttribute("nowSeq").toString()));
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?1:searchForm.getPage();
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setGdsStat(Constants.GDS_STAT_SALE);
		searchForm.setBrand(brand);
		searchForm.setSex(sex);
		searchForm.setOneDepth(oneDepth);
		searchForm.setTwoDepth(twoDepth);
		searchForm.setThreeDepth(threeDepth);
		searchForm.setUbiGdsSize(ubiGdsSize);
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);
		searchForm.setClbltnNm(clbltnNm);
		searchForm.setBrands(brand.split(","));
		
		if("Y".equals(newArvl)){
			searchForm.setNewArrival(true);
		}
		
		//worksout 접속
		if(!"10001".equals(getSiteNo(request).toString())){
			searchForm.setSiteNo(getSiteNo(request).toString());
		}

/*		int totalCnt = goodsService.totalListGoodsFrontNew(searchForm);
		searchForm.setTotalCnt(totalCnt);

		if(totalCnt == 0) {
			totalCnt = goodsService.totalListGoodsFront(searchForm);
			searchForm.setTotalCnt(totalCnt);
			
			//페이징처리
			PagingUtil pagingUtil = new PagingUtil();
			pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), 60, 60);
			List<Goods> goodsList = goodsService.listGoodsFront(searchForm);
			mav.addObject("goodsList", goodsList);
		}else {
			//페이징처리
			PagingUtil pagingUtil = new PagingUtil();
			pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), 60, 60);
			List<Goods> goodsList = goodsService.listGoodsFrontNew(searchForm);
			mav.addObject("goodsList", goodsList);
		}
		
		List<Goods> goodsSizeList = goodsService.listGoodsSizeFront(searchForm);
		mav.addObject("goodsSizeList", goodsSizeList);
		int totalPage = (int) Math.ceil((double)searchForm.getTotalCnt()/showPageLimit);
		if(totalPage == 0){
			totalPage = 1;
		}
		
		*/
		
		
		searchForm.setTotalCnt(goodsService.totalListGoodsFront(searchForm));
		
		//페이징처리
		PagingUtil pagingUtil = new PagingUtil();
		pageHtml = pagingUtil.getPageHtml(currentPage, searchForm.getTotalCnt(), 60, 60);
		List<Goods> goodsList = goodsService.listGoodsFront(searchForm);
		List<Goods> goodsSizeList = goodsService.listGoodsSizeFront(searchForm);
		
		
		mav.addObject("goodsList", goodsList);
		mav.addObject("goodsSizeList", goodsSizeList);
		int totalPage = (int) Math.ceil((double)searchForm.getTotalCnt()/showPageLimit);
		if(totalPage == 0){
			totalPage = 1;
		}
		
				
		
		

		mav.addObject("totalCnt", searchForm.getTotalCnt());
		mav.addObject("totalPage", totalPage);
		//mav.addObject("uploadImage", uploadImage);
		mav.addObject("uploadImage", "http://googledrive.com/host/0B6HfeD747YiJZFNiZTNKdGphN2M/");
		mav.setViewName("/worksout/goods/goodsList");
		return mav;
	}
	
	@RequestMapping(value = "/goodsListAjax", method = RequestMethod.POST)
	public void goodsListAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		
		HttpSession session = request.getSession();
		
		String sex = request.getParameter("sex");
		String oneDepth = request.getParameter("oneDepth");
		String twoDepth = request.getParameter("twoDepth")==null?"":request.getParameter("twoDepth");
		String threeDepth = request.getParameter("threeDepth");
		String brand = request.getParameter("brand")==null?"":request.getParameter("brand");
		String ubiGdsSize = request.getParameter("ubiGdsSize");
		String orderBy = request.getParameter("orderBy");
		String orderFlag = request.getParameter("orderFlag");
		String clbltnNm = request.getParameter("clbltnNm");
		
		String newArvl = request.getParameter("newArvl");
		
		Gson gson = new Gson();
		SearchForm searchForm = new SearchForm();
		
		//현재 설정된 시즌 셋팅
		searchForm.setCurSeason(request.getAttribute("currentSeason").toString());
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = request.getParameter("currentPage")==null?1:Integer.parseInt(request.getParameter("currentPage"));
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setGdsStat(Constants.GDS_STAT_SALE);
		searchForm.setBrand(brand);
		searchForm.setSex(sex);
		searchForm.setOneDepth(oneDepth);
		searchForm.setTwoDepth(twoDepth);
		searchForm.setThreeDepth(threeDepth);
		searchForm.setUbiGdsSize(ubiGdsSize);
		searchForm.setOrderBy(orderBy);
		searchForm.setOrderFlag(orderFlag);		
		searchForm.setClbltnNm(clbltnNm);
		searchForm.setNowSeq(Integer.parseInt(session.getAttribute("nowSeq").toString()));
		searchForm.setBrands(brand.split(","));
		
		if("Y".equals(newArvl)){
			searchForm.setNewArrival(true);
		}		
		
		//worksout 접속
		if(!"10001".equals(getSiteNo(request).toString())){
			searchForm.setSiteNo(getSiteNo(request).toString());
		}		
		
		searchForm.setTotalCnt(goodsService.totalListGoodsFrontAjax(searchForm));
		List<Goods> goodsList = goodsService.listGoodsFrontAjax(searchForm);
		
	    response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(goodsList));		
	}	
	
	@RequestMapping(value = "/goodsDetail")
	public ModelAndView goodsDetail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ubiGdsNo") String ubiGdsNo) 
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		Member member = (Member)request.getSession().getAttribute("member");
		
		
		HttpSession session = request.getSession();
		int siteNo = getSiteNo(request);
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("siteNo", siteNo);
		hm.put("ubiGdsNo", ubiGdsNo);
		
		session.setAttribute("nowSeq", Integer.valueOf(categoryService.getSeasonSeq(hm)));
		
		
		
		//상품번호, 컬러정보 맵핑
		SearchForm searchForm = new SearchForm();
		searchForm.setUbiGdsNo(ubiGdsNo);
		searchForm.setNowSeq(Integer.parseInt(session.getAttribute("nowSeq").toString()));
		
		//worksout 접속
		if(!"10001".equals(getSiteNo(request).toString())){
			searchForm.setSiteNo(getSiteNo(request).toString());
		}
		
		//상품정보
		Goods goods = goodsService.selectGoodsFront(searchForm);
		
		//기본폼 셋팅
		goods.setDispYn(goods.getDispYn()==null?"Y":goods.getDispYn());
		goods.setSlTermCls(goods.getSlTermCls()==null?"GD00501":goods.getSlTermCls());
		goods.setGdsStat(goods.getGdsStat()==null?"GD00401":goods.getGdsStat());
		
		//상품정보고시
		//List<GoodsAddInfoGrp> addInfoList = goodsService.listAddInfoGrp(searchForm);
		
		//상품조회이력
		GoodsView goodsView = new GoodsView();
		goodsView.setUbiGdsNo(ubiGdsNo);
		goodsView.setSiteNo(getSiteNo(request));
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("WL-Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("HTTP_CLIENT_IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("X-SIMPLEXI0"); 
		} 				
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getRemoteAddr(); 
		}		
		goodsView.setRegIp(ip);
		if(member != null){
			goodsView.setMemNo(member.getMemNo());
			goodsView.setRegrNo(member.getMemNo());	
		}else{
			goodsView.setMemNo(99999999);
			goodsView.setRegrNo(99999999);
		}

		int checkGdsView = goodsService.checkGdsView(goodsView);
		if(checkGdsView < 1){
			goodsService.insertGdsView(goodsView);
		}
		
		if(goods.getUbiGoods().getEtcGdsNo() != null){
			searchForm.setEtcGdsNo(goods.getUbiGoods().getEtcGdsNo());
			searchForm.setSeasonCode(goods.getUbiGoods().getSeasonCode());
			List<CurrentGoodsColors> currentGoodsColors = goodsService.listCurColors(searchForm);
			
			mav.addObject("currentGoodsColors", currentGoodsColors);
		}
		
		
		mav.addObject("goodsForm", goods);
		//mav.addObject("addInfoList", addInfoList);
		mav.setViewName("/worksout/goods/goodsDetail");
		return mav;
	}
	
	@RequestMapping(value = "/feature")
	public ModelAndView featureManage(
			@ModelAttribute("featureManageForm") FeatureManageForm featureManageForm,
			@RequestParam(value = "oneDepth", required = false) String oneDepth,
			@RequestParam(value = "nowSeq", required = false, defaultValue="0") int nowSeq,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		
		if(nowSeq != 0){
//			request.setAttribute("nowSeq", nowSeq);
			session.setAttribute("nowSeq", nowSeq);
		}else{
			nowSeq      = request.getAttribute("currentTopYn").equals("Y")?Integer.parseInt(request.getAttribute("currentSeq").toString()):Integer.parseInt(request.getAttribute("preSeq").toString());
//			request.setAttribute("nowSeq", nowSeq);
			session.setAttribute("nowSeq", nowSeq);
		}
		
		
		ModelAndView mav = new ModelAndView();
		
		String sex = featureManageForm.getSex()==null?"M":featureManageForm.getSex();
		
		List<FeatureManage> featureList = manageService.featureManageList(getSiteNo(request), sex);

		mav.addObject("featureList", featureList);

		mav.setViewName("/worksout/goods/feature");
		return mav;
	}	
	
	@RequestMapping(value = "/collaboration")
	public ModelAndView collaborationList(
			@ModelAttribute("searchForm") SearchForm searchForm,
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws UnsupportedEncodingException {
		
		ModelAndView mav = new ModelAndView();

		
		//site 리스트 
		List<Site> siteList = codeService.getSiteList();
		
		//검색조건 게시물의 총 결과 갯수
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		showListLimit = searchForm.getSearchCount()==null?showListLimit:searchForm.getSearchCount();
		
		
		searchForm.setSiteNo(getSiteNo(request).toString());
		searchForm.setPage(currentPage);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
	
		List<IntgBoard> collaborationList = goodsService.collaboList(searchForm);
		
		searchForm.setSiteName( searchForm.getSiteName()==null?"FILTER":searchForm.getSiteName() );				
		
		
		mav.addObject("siteList", siteList);
		mav.addObject("siteName", searchForm.getSiteName());
		mav.addObject("searchForm", searchForm);
		mav.addObject("collaborationList", collaborationList);
		
		mav.setViewName("/worksout/goods/collaboration");
		return mav;
	}
	
	@RequestMapping(value = "/collaborationAjax")
	public void collaborationAjax(Locale locale , HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws Exception {
		
		Gson gson = new Gson();
		
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		int nextPage = currentPage + 1;

		searchForm.setSiteNo(getSiteNo(request).toString());
		searchForm.setStartListNum((nextPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		List<IntgBoard> collaborationList = goodsService.collaboList(searchForm);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(collaborationList));
	}
	
	
	/**
	 * 상품 추가정보 상세내용(AJAX)
	 * @param locale
	 * @param request
	 * @param response
	 * @param model
	 * @param sidoNm
	 * @throws Exception
	 */
	@RequestMapping(value = "/goodsAddInfoAjax", method = RequestMethod.POST)
	public void goodsAddInfoAjax(Locale locale , HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam("ubiGdsNo") String ubiGdsNo) throws Exception {
		Gson gson = new Gson();

		SearchForm searchForm = new SearchForm();
		//searchForm.setGdsInfoNo(gdsInfoNo);
		searchForm.setUbiGdsNo(ubiGdsNo);
		
		GoodsAddInfoGrp addInfoList = goodsService.selectAddInfoGrp(searchForm);
		
	    response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(addInfoList));
	}
	
	@RequestMapping(value = "/brandListAjax", method = RequestMethod.GET)
	public @ResponseBody List<Code> productStatUpdate(Locale locale, Model model,
			@RequestParam(value = "depthCode", required = true) String depthCode,
			@RequestParam(value = "nowSeq", required = true) int nowSeq
			){
		try {
			
			SearchForm searchForm = new SearchForm();
			searchForm.setDepthCode(depthCode);
			searchForm.setNowSeq(nowSeq);
			
			List<Code> BrandList = categoryService.listBrand(searchForm);
			
			
			return BrandList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}		
}