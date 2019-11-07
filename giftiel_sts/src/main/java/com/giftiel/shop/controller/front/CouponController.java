package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.common.SMSSend;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.service.CouponService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front/coupon")
public class CouponController extends FrontController{
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	@Autowired
	private SMSSend smsSend;
	
	@Autowired
	private CouponService couponService;
	@Autowired
	private Seed seed;	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailSend mailSend;
	
	private int currentPage = 1;
	private int showListLimit = 10;
	private int showPageLimit = 10;	
	private StringBuffer pageHtml = null;
	
	@RequestMapping(value = "/offCpnInfoAjax")
	public void offCpnInfo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("offCpnNo") String offCpnNo,
			@RequestParam("ubiGdsNo") String ubiGdsNo
			) 
	throws IOException {
	    SearchForm searchForm = new SearchForm();
	    searchForm.setOffCpnNo(offCpnNo);
	    searchForm.setUbiGdsNo(ubiGdsNo);
	    
	    Coupon coupon = couponService.offCpnInfo(searchForm);
	    
	    Gson gson = new Gson();
	    String result = gson.toJson(coupon);
	    
	    response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(result);
	}
}
