package com.giftiel.shop.controller.admin;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.service.CartService;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/cart")
public class CartController {
	@Autowired
	private CartService cartService;

	@RequestMapping(value = "/sizeList", method = RequestMethod.POST)
	public void sizeList(Locale locale, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam("ubiGdsNo") String ubiGdsNo) throws Exception {
		Gson gson = new Gson();

		List<Cart> list = cartService.sizeList(ubiGdsNo);

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(list));
	}
}