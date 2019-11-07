package com.giftiel.shop.controller.giftiel;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.dto.GiftielViewInput;
import com.giftiel.shop.service.GiftielViewService;
import com.google.gson.Gson;


@Controller
@RequestMapping("/giftiel")
public class GiftielViewController {

	@Autowired
	private GiftielViewService giftielViewService;
	
	private static final Logger log = LoggerFactory.getLogger(GiftielViewController.class);
	
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public ModelAndView giftielView(Locale locale, HttpServletRequest reqeust, HttpServletResponse response) {
		log.info("=========== giftelView Test");
		
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		
		GiftielViewInput giftielViewInput = new GiftielViewInput();
		giftielViewInput.setCiCode("1111");
		giftielViewInput.setCiPwd("1111");
		giftielViewInput.setCouponCode("testCouponCode");
		giftielViewInput.setCouponNum("testCounponNum");
		
		String result = giftielViewService.getReplyData(giftielViewInput);

		mav.addObject("giftielObject", gson.toJson(result));
		mav.setViewName("/giftiel/giftielView");

		return mav;
	}
	
	
	
	
	
}
