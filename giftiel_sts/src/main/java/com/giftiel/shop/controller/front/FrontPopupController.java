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

import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.ZipCode;
import com.giftiel.shop.service.CarharttRadioService;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.ZipCodeService;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;
  

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/popup")
public class FrontPopupController extends FrontController{
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
	@Autowired
	private CarharttRadioService carharttRadioService;
	
	private int currentPage = 1;
	private int showListLimit = 10;
	private int showPageLimit = 10;	
	private StringBuffer pageHtml = null;	
	

	
	@RequestMapping(value = "/zipCode/selectSido")
	public ModelAndView selectSido(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response, @ModelAttribute("searchForm") SearchForm searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(searchForm.getSidoNm() != null){
			List<SearchForm> zipCodeList = zipCodeService.selectAddressList(searchForm);
			model.addAttribute("zipCodeList", zipCodeList);
		}
		
		mav.setViewName("/admin/popup/zipcode");
		return mav;
	}
	
	@RequestMapping(value = "/zipCode/sigunguList", method = RequestMethod.POST)
	public void sigunguList(Locale locale , HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam("sidoNm") String sidoNm) throws Exception {
		Gson gson = new Gson();

		List<ZipCode> list = zipCodeService.selectSiGungu(sidoNm);
		
	    response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(list));
	}

	@RequestMapping(value = "/carharttRadioPopup",method = RequestMethod.GET)
	public ModelAndView carharttRadioPopup(
			Locale locale, 
			Model model, 
			HttpServletRequest reqeust, 
			HttpServletResponse response, 
			@ModelAttribute("searchForm") SearchForm searchForm
			,@RequestParam int radioNo
			) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		List<CarharttRadioForm> carharttRadioList = carharttRadioService.carharttRadioList(searchForm); 

		CarharttRadioForm carharttRadioPopup = carharttRadioService.carharttRadioPopup(radioNo);
		
		if(carharttRadioPopup.getRadioLink() != null){
				carharttRadioPopup.setRadioLink(convertGetSrc(carharttRadioPopup.getRadioLink()));
		}
		
		mav.addObject("carharttRadioPopup", carharttRadioPopup);
		mav.addObject("carharttRadioList", carharttRadioList);
		mav.addObject("uploadImage"	, uploadImage);
		mav.setViewName("/worksout/popup/carharttRadioPopUp");
		return mav;
	}
	
}