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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.NewsService;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/news")
public class NewsController extends FrontController{	
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${server.site.no}")
	private String serverSiteNo;
	
	@Value("${upload.image}")
	private String uploadImage;
	
	
	@Autowired
	private NewsService newsService;
	@Autowired
	private CodeService codeService;
	
	
	private int currentPage = 1;
	private int showListLimit = 10;
	
	@RequestMapping(value = "/newsList")
	public ModelAndView newsList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm) 
	throws Exception {
		ModelAndView mav = new ModelAndView();

		//첫 페이지 조회
		currentPage = 1;
		searchForm.setPage(currentPage);
		searchForm.setSiteNo(getSiteNo(request).toString());
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		List<News> newsList = newsService.newsList(searchForm);
		
		
		for (int i = 0; i < newsList.size(); i++) {
			//날짜 변환
			String regDts = newsList.get(i).getRegDts();
			regDts = regDts.replace("-", "").substring(0, 8);
			newsList.get(i).setRegDts(regDts);
		}

		mav.addObject("newsList", newsList);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/worksout/news/newsList");
		return mav;
	}
	
	@RequestMapping(value = "/snbNews")
	public ModelAndView snbNews(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
	throws Exception{
		ModelAndView mav = new ModelAndView();
		
		//뉴스타입 코드리스트
		Code code = new Code();
		code.setCdNm("ALL");
		List<Code> newsTypeList = codeService.listCd(Constants.NEWS_TYPE_CODE);
		newsTypeList.add(0, code);

		mav.addObject("newsTypeList", newsTypeList);
		mav.setViewName("/worksout/include/layout/snb_news");
		return mav;
	}

	@RequestMapping(value = "/newsAjax")
	public void newsAjax(Locale locale , HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws Exception {
		
		Gson gson = new Gson();
		
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		int nextPage = currentPage + 1;
		
		searchForm.setSiteNo(getSiteNo(request).toString());
		searchForm.setStartListNum((nextPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		searchForm.setSiteNo(getSiteNo(request).toString());
		List<News> newsList = newsService.newsList(searchForm);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(newsList));
	}
	
	@RequestMapping(value = "/newsDetail" , method =  {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView newsDetail(@RequestParam int txtNo,Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws UnsupportedEncodingException{
		ModelAndView mav = new ModelAndView();

		List<Code> newsType = codeService.listCd(Constants.NEWS_TYPE_CODE);
		
		News newsDetail = newsService.detail(txtNo);

		
		if(newsDetail == null){
			mav.setViewName("/common/error");
			return mav;
		}
		
		
		if(newsDetail.getEtc1() != null){
			String regEtc1 = newsDetail.getEtc1();
			regEtc1 = regEtc1.replace(".", "").substring(0, 8);
			newsDetail.setEtc1(regEtc1);
		}
		
		if(newsDetail.getMovUrl() != null){
			newsDetail.setMovUrl(convertGetSrc(newsDetail.getMovUrl()));
		}
		
		if(newsDetail.getTotalCnt() != null){
			newsDetail.setMovUrl(convertGetSrc(newsDetail.getMovUrl()));
		}
		
		for(int i=0; i< newsDetail.getNewsCont().size(); i++){
			String aUrl = newsDetail.getNewsCont().get(i).getAddContAddr();
			
			newsDetail.getNewsCont().get(i).setAddContAddr(convertGetSrc(aUrl));
		}

		mav.addObject("newsType", newsType);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("newsDetail", newsDetail);
		mav.setViewName("/worksout/news/newsDetail");
		return mav;
	}
	
}



