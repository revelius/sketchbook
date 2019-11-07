package com.giftiel.shop.controller.front;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.LookBook;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.LookBookService;
import com.google.gson.Gson;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/obey")
public class ObeyController extends FrontController{
	
	@Autowired
	private LookBookService lookbookService;
	@Autowired
	private CodeService codeService;
	
	private int currentPage = 1;
	private int showListLimit = 15;
	
	
	
	
	@RequestMapping(value = "/test")
	public ModelAndView test(
			Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("searchForm") SearchForm searchForm) 
			throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//site 리스트 
		List<Site> siteList = codeService.getSiteList();
		
		
		mav.addObject("siteList", siteList);
		mav.setViewName("/"+getSiteDir(request)+"/test");
		return mav;
	}
	
	
	
	
	
	
	
	
	
	/**
	 * LookBook 리스트
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm) 
			throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//site 리스트 
		List<Site> siteList = codeService.getSiteList();
		
		//첫 페이지 조회
		currentPage = 1;
		searchForm.setPage(currentPage);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		searchForm.setSiteName( searchForm.getSiteName()==null?"All Brand":searchForm.getSiteName() );		
		
		List<LookBook> lookbookList = lookbookService.list(searchForm);
		
		mav.addObject("siteList", siteList);
		mav.addObject("searchForm", searchForm);
		mav.addObject("siteName", searchForm.getSiteName());
		mav.addObject("lookbookList", lookbookList);
		mav.setViewName("/"+getSiteDir(request)+"/lookbook/list");
		return mav;
	}
	
	/**
	 * LookBook 리스트 더보기 (ajax)
	 * @param locale
	 * @param request
	 * @param response
	 * @param searchForm
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAjax", method = RequestMethod.POST)
	public void listAjax(Locale locale , HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm)
			throws Exception {
		Gson gson = new Gson();
		
		currentPage = searchForm.getPage()==null?currentPage:searchForm.getPage();
		int nextPage = currentPage + 1;
		searchForm.setStartListNum((nextPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit -1);
		
		List<LookBook> lookbookList = lookbookService.list(searchForm);
		
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().print(gson.toJson(lookbookList));
	}
	
	/**
	 * LookBook 상세보기
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param txtNo
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/detail")
	public ModelAndView detail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam int txtNo)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		
		LookBook lookbook = lookbookService.detail(txtNo);
		mav.addObject("detail", lookbook);
		mav.setViewName("/"+getSiteDir(request)+"/lookbook/detail");
		return mav;		
	}
	
}
