package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.service.CartService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.utils.Seed;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front")
public class FrontMemberController extends FrontController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private CartService cartService;	
	@Autowired
	private Seed seed;
	@Value("${server.contextPath}")
	private String contextPath;		
	
	
	/**
	 * 장바구니에 상품 담기 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/insertGdsCart")
	public void insertGdsCart(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("gdsNo") String gdsNo ,@RequestParam("memNo") String memNo,@RequestParam("gdsSize") String gdsSize) throws IOException {
	
		int checkGrd = 0;

		Cart cart = new Cart();
		cart.setGdsNo(gdsNo);
		cart.setMemNo(Integer.parseInt(memNo));
		cart.setGdsSize(gdsSize);
		cart.setRegrNo(Integer.parseInt(request.getSession().getAttribute("user_no").toString()));
		
		List<Cart> list = cartService.selectGdsCart(cart);
		
		if(list != null && list.size() > 0 ){
			checkGrd = cartService.updateGdsCart(cart);
		}else{
			checkGrd = cartService.insertGdsCart(cart);
		}
		
		response.getWriter().print(checkGrd);		
	}
	
	/**
	 * 장바구니에 상품 삭제하기  
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/deleteGdsCart")
	public void deleteGdsCart(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cartNo") Integer cartNo) throws IOException {
	
		int checkGrd = 0;

		checkGrd = cartService.deleteGdsCart(cartNo);
		
		response.getWriter().print(checkGrd);		
	}	
}
