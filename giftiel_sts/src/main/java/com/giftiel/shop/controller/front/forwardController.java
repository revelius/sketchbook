package com.giftiel.shop.controller.front;

import java.io.UnsupportedEncodingException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.giftiel.shop.controller.common.FrontController;


/**
 * Handles requests for the application home page.
 */
@Controller
public class forwardController extends FrontController{
	@RequestMapping(value = "/store")
	public String store(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) 
	throws UnsupportedEncodingException {
    	return "redirect:/front/onlineShop/feature";
	}

}