package com.giftiel.shop.controller.giftiel;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.utils.Seed;


@Controller
@RequestMapping("/test")
public class ViewTestController {

	@Autowired
	private Seed seed;
	
	private static final Logger log = LoggerFactory.getLogger(ViewTestController.class);
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView sketchTest(Locale locale, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("joinForm") MemInfo joinForm) {
		log.info("=========== imsi login page");
		log.info("======================== sketchTest login joinForm {}", joinForm.toString());
		
		ModelAndView mav = new ModelAndView();
//		joinForm.setSiteNo(getSiteNo(request));
		mav.addObject("joinForm", joinForm);
		mav.setViewName("/worksout/join/login");
		return mav;
	}
	
	@RequestMapping(value = "/view3", method = RequestMethod.GET)
	public ModelAndView sketchTest2(Locale locale, HttpServletRequest reqeust, HttpServletResponse response) {
		log.info("=========== View Test");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/main");
		return mav;
	}
	
}
