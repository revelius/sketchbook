package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.common.SMSSend;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MydlvAddr;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.UbiOrder;
import com.giftiel.shop.service.CartService;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.SettingService;
import com.giftiel.shop.utils.Seed;
import com.google.gson.Gson;


/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes({"order"})
@RequestMapping("/front/order")
public class FrontOrderController extends FrontController{
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	@Autowired
	private SMSSend smsSend;
	
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private CartService cartService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private SettingService settingService;		
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
	
	@RequestMapping(value = "/cartList")
	public ModelAndView cartList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("cartForm") Cart cartForm) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		Setting setting = settingService.pointSettingList();
		
		Member member = (Member)request.getSession().getAttribute("member");
		SearchForm searchForm = new SearchForm();
		
		int curDcPer = 0;
		int curRsvPer = 0;
		
		if(member == null){ //비회원(비로그인)
			searchForm.setMemNo(99999999+"");
			
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
			
			searchForm.setIpAddr(ip);
		}else{ //회원(로그인)
			searchForm.setMemNo(member.getMemNo()+"");
			curDcPer = member.getCurDcPer();
			curRsvPer = member.getCurRsvPer();
		}
		
		searchForm.setSiteNo(getSiteNo(request).toString());
		
		List<Cart> cart = cartService.selectFrontCartList(searchForm);
		
		int totalSlAmt = 0 ;
		int deliveryCost = (int)setting.dlv_cst;
		for (int i = 0; i < cart.size(); i++) {
			//회원등급 할인
			cart.get(i).setUbiSlPrc(Integer.parseInt(cart.get(i).getUbiSlPrc()) - ((Integer.parseInt(cart.get(i).getUbiSlPrc())/100) * curDcPer) + "");
			cart.get(i).setUbiSlPrc((int)(Math.floor(Integer.parseInt(cart.get(i).getUbiSlPrc()))/100) * 100 + "");
			totalSlAmt += Integer.parseInt(cart.get(i).getUbiSlPrc());
		}
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			deliveryCost = 0;
		}else{
		}
		
		
		for (int j = 0; j < cart.size(); j++) {
			//회원 포인트 지급 정책 시작
			if(Constants.PNT_RSV_CLS_NONE.equals(setting.getPnt_rsv_cls())){
				cart.get(j).setExpPnt(0);	
			}else if(Constants.PNT_RSV_CLS_MEMLV.equals(setting.getPnt_rsv_cls())){
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc())/100) * curRsvPer);
			}else if(Constants.PNT_RSV_CLS_SLPRC.equals(setting.getPnt_rsv_cls())){
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc())/100) * (int)setting.getPnt_rsv_rt());
			}else if(Constants.PNT_RSV_CLS_PAYAMT.equals(setting.getPnt_rsv_cls())){
				cart.get(j).setExpPnt((Integer.parseInt(cart.get(j).getUbiSlPrc())/100) * (int)setting.getPnt_rsv_rt());
			}
		}
		

		mav.addObject("cartList", cart);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("totalSlAmt", totalSlAmt);
		mav.addObject("deliveryCost", deliveryCost);
		mav.setViewName("/worksout/order/cartList");
		return mav;
	}
	
	@RequestMapping(value = "/cartInsert")
	public void cartInsert(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response
			, @RequestParam("ubiGdsNo") String ubiGdsNo, @RequestParam("ubiGdsSize") String ubiGdsSize) throws IOException{
		String resultCode = "0";
		
		
		Cart cart = new Cart();
		
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
		cart.setIpAddr(ip);

		try {
		
			Member member = (Member)request.getSession().getAttribute("member");
			if(member == null){ //비회원(비로그인)
				cart.setUbiGdsNo(ubiGdsNo);
				cart.setGdsSize(ubiGdsSize);
				cart.setMemNo(99999999);
				cart.setRegrNo(99999999);
				cart.setQty(1);
				cart.setMemYn("N");
				cart.setSiteNo(getSiteNo(request));
				
				List<Cart> chkCart = cartService.selectGdsCart(cart);
				//if(chkCart.size() > 0){
				//	cartService.updateGdsCart(cart);
				//}else{
					cartService.insertGdsCart(cart);				
				//}
			}else{ //회원(로그인)
				cart.setUbiGdsNo(ubiGdsNo);
				cart.setGdsSize(ubiGdsSize);
				cart.setMemNo(member.getMemNo());
				cart.setRegrNo(member.getMemNo());
				cart.setQty(1);
				cart.setMemYn("Y");
				cart.setSiteNo(getSiteNo(request));
				
				List<Cart> chkCart = cartService.selectGdsCart(cart);
				//if(chkCart.size() > 0){
				//	cartService.updateGdsCart(cart);
				//}else{
					cartService.insertGdsCart(cart);				
				//}
			}
			
		    response.setContentType("text/html;charset=UTF-8");
		    response.setHeader("Cache-Control", "no-cache");
		    response.getWriter().print(resultCode);
			
		} catch (IOException e) {
			response.getWriter().print("2");
		}
	}
	
	@RequestMapping(value = "/orderForm")
	public ModelAndView orderForm(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, 
			@ModelAttribute("cartForm") Cart cart, @ModelAttribute("orderForm") Order order) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(cart.getCarts() == null){
			mav.addObject("alert", "선택한 상품이 없습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}
		
		HashMap<String, Integer> cartMap = new HashMap<String, Integer>();
		
		//주문 전 재고수량 체크
		boolean checkStockFlag = false;
		for (int i = 0; i < cart.getCarts().size(); i++) {
			if(StringUtils.isNotEmpty(cart.getCarts().get(i).getUbiGdsNo())){
				if(cartMap.get(cart.getCarts().get(i).getUbiGdsNo()+"_"+cart.getCarts().get(i).getGdsSize()) != null){
					cartMap.put(cart.getCarts().get(i).getUbiGdsNo()+"_"+cart.getCarts().get(i).getGdsSize(), cartMap.get(cart.getCarts().get(i).getUbiGdsNo()+"_"+cart.getCarts().get(i).getGdsSize())+1);
				}else{
					cartMap.put(cart.getCarts().get(i).getUbiGdsNo()+"_"+cart.getCarts().get(i).getGdsSize(), 1);
				}
			}
		}
		
		Iterator<String> keys = cartMap.keySet().iterator();
        while( keys.hasNext() ){
            String key = keys.next();
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(StringUtils.split(key, "_")[0]);
			searchForm.setUbiGdsSize(StringUtils.split(key, "_")[1]);
			if(goodsService.checkGdsStock(searchForm) < cartMap.get(key)){
				checkStockFlag = true;
			}            
        }
		
			
		if(checkStockFlag){
			mav.addObject("alert", "재고수량이 부족한 상품이 있습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}
		//주문 전 재고수량 체크
		
		Setting setting = settingService.deliverySettingList();

		int totalSlAmt = 0 ;	//총상품금액
		int deliveryCost = (int)setting.dlv_cst;	//배송비
		
		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		
		if(member != null){
			List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
			
//			String view = "";
			
			if(mydlvAddrList.size() > 0){
				mav.addObject("mydlvAddrList", mydlvAddrList);
				mav.addObject("mydlvAddrListJson", gson.toJson(mydlvAddrList));
//				view = "manageDelivery";
			}else{
				MydlvAddr mydlvAddr = new MydlvAddr();
				mydlvAddr.setAddrBynm("주소1");
				mydlvAddr.setBaseValYn("Y");
				mav.addObject("mydlvAddr", mydlvAddr);
//				view = "regDelivery";
			}			
		}
			
		for (int i = 0; i < cart.getCarts().size(); i++) {
			if(cart.getCarts().get(i).isChkCart()){
				totalSlAmt += Integer.parseInt(cart.getCarts().get(i).getUbiSlPrc());
			}
		}
		
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			deliveryCost = 0;
		}
		
		mav.addObject("cartList", cart);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("totalSlAmt", totalSlAmt);
		mav.addObject("deliveryCost", deliveryCost);		
		mav.setViewName("/worksout/order/orderForm");
		return mav;
	}
	
	
	@RequestMapping(value = "/orderFormDefaultAddrAjax", method = RequestMethod.POST)
	public void orderFormDefaultAddrAjax(Locale locale , HttpServletRequest request, HttpServletResponse response) 
	throws Exception {

		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");

	
		List<MydlvAddr> mydlvAddrList = memberService.getDeliveryAddr(member);
	
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");

		response.getWriter().print(gson.toJson(mydlvAddrList));
	}
	
	@RequestMapping(value = "/orderFormRecentAddrAjax", method = RequestMethod.POST)
	public void orderFormRecentAddrAjax(Locale locale , HttpServletRequest request, HttpServletResponse response) 
	throws Exception {

		Gson gson = new Gson();
		Member member =  (Member)request.getSession().getAttribute("member");
		Integer memNo = member.getMemNo();
		MydlvAddr mydlvAddrList = memberService.getRecentAddr(memNo);
	
		response.setContentType("text/html;charset=UTF-8");
	    response.setHeader("Cache-Control", "no-cache");

		response.getWriter().print(gson.toJson(mydlvAddrList));
	}
	
    @ModelAttribute("order")
    public Order createOrderAttr() {
        return new Order();
    }
	
	@RequestMapping(value = "/orderConfirm", method = RequestMethod.POST)
	public ModelAndView orderConfirm(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("orderForm") Order order, SessionStatus status) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		Setting setting = settingService.deliverySettingList();
		
		//배송비 및 총상품금액 계산
		int totalSlAmt = 0 ;	//총상품금액
		int deliveryCost = (int)setting.dlv_cst;	//배송비

		if(order.getOrderGoods() != null){
			for (int i = 0; i < order.getOrderGoods().size(); i++) {
				totalSlAmt += order.getOrderGoods().get(i).getSlPrc();
			}
			order.setTotalSlAmt(totalSlAmt);			
		}

		
		
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			order.setTotalDlvCst(0);
			deliveryCost = 0;
		}else{
			order.setTotalDlvCst(deliveryCost);
		}
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("totalSlAmt", totalSlAmt);
		mav.addObject("deliveryCost", deliveryCost);
		mav.setViewName("/worksout/order/orderConfirm");
		return mav;
	}	
	
	/**
	 * 주문 init
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderPay")
	public ModelAndView orderPay(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("orderForm") Order order) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(order.getOrderGoods() == null){
			mav.addObject("alert", "선택한 상품이 없습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}
		
		//주문 전 재고수량 체크
		boolean checkStockFlag = false;
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
			searchForm.setUbiGdsSize(order.getOrderGoods().get(i).getUbiGdsSize());
			if(goodsService.checkGdsStock(searchForm) < 1){
				checkStockFlag = true;
			}
		}
		
		if(checkStockFlag){
			mav.addObject("alert", "재고수량이 부족한 상품이 있습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}			
		//주문 전 재고수량 체크
		
		Setting setting = settingService.deliverySettingList();
		Member member = (Member)request.getSession().getAttribute("member");
		
		order.setSiteNo(getSiteNo(request)); 					// 사이트 코드 : WORKSOUT(10001)
		order.setOrdStat(Constants.ORD_STAT_TEMP);	// 주문상태 : 주문대기
		
		
		if(member == null){ //비회원(비로그인)
			order.setMemId("GUEST");
			order.setMemNo(99999999);
			order.setOrdrEmail("GUEST");
			order.setRegrNo(0);
		}else{ //회원(로그인)
			order.setMemId(member.getEmail());
			order.setMemNo(member.getMemNo());
			order.setRegrNo(member.getMemNo());
			order.setOrdrEmail(member.getEmail());			
		}

		//모바일, PC 체크
		if(order.isMobile()){ //모바일
			order.setBrwsCls(Constants.BRWS_CLS_MOBILE);
		}else{ //PC
			order.setBrwsCls(Constants.BRWS_CLS_PC);
		}
		
		//사용자 접속 IP수집
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
		order.setRegIp(ip);
		
		order.setOrdrCp(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setOrdrTel(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());
		order.setRcpnCpNo(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setRcpnTelNo(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());		
		//order.setOrdrZipCd(order.getOrdrZipCd());
		order.setRcpnZipCd(order.getOrdrZipCd());
		order.setRcpnBsAddr(order.getOrdrBsAddr());
		order.setRcpnDtlAddr(order.getOrdrDtlAddr());
		order.setRcpnNm(order.getOrdrNm());
		
		//배송비 및 총상품금액 계산
		int totalSlAmt = 0 ;	//총상품금액
		int deliveryCost = (int)setting.dlv_cst;	//TODO배송비

		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			totalSlAmt += order.getOrderGoods().get(i).getSlPrc();
		}
		
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			order.setTotalDlvCst(0);
		}else{
			order.setTotalDlvCst(deliveryCost);
		}		
		
		Order orderResult = orderService.orderInit(order);
		totalSlAmt = 0;
		for (int i = 0; i < orderResult.getOrderGoods().size(); i++) {
			if(orderResult.getOrderGoods().get(i).getCpnPayAmt() != null){
				totalSlAmt += orderResult.getOrderGoods().get(i).getSlPrc() - orderResult.getOrderGoods().get(i).getCpnPayAmt();
			}else{
				totalSlAmt += orderResult.getOrderGoods().get(i).getSlPrc();
			}
		}
		order.setTotalSlAmt(totalSlAmt);
		
		mav.addObject("serverSetting", serverSetting);
		mav.addObject("ordNo", orderResult.getOrdNo());
		mav.addObject("order", orderResult);
		mav.addObject("totalSlAmt", order.getTotalSlAmt());
		mav.addObject("deliveryCost", order.getTotalDlvCst());
		
		mav.setViewName("/worksout/order/orderPay");
		return mav;
	}
	
	
	/**
	 * 주문 init
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderPayOnlyPoint")
	public ModelAndView orderPayOnlyPoint(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("orderForm") Order order) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(order.getOrderGoods() == null){
			mav.addObject("alert", "선택한 상품이 없습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");
			return mav;
		}
		
		//주문 전 재고수량 체크
		boolean checkStockFlag = false;
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
			searchForm.setUbiGdsSize(order.getOrderGoods().get(i).getUbiGdsSize());
			if(goodsService.checkGdsStock(searchForm) < 1){
				checkStockFlag = true;
			}
		}
		
		if(checkStockFlag){
			mav.addObject("alert", "재고수량이 부족한 상품이 있습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}			
		//주문 전 재고수량 체크
		
		Setting setting = settingService.deliverySettingList();
		Member member = (Member)request.getSession().getAttribute("member");
		
		order.setSiteNo(getSiteNo(request)); 					// 사이트 코드 : WORKSOUT(10001)
		order.setOrdStat(Constants.ORD_STAT_TEMP);	// 주문상태 : 주문대기
		
		
		if(member == null){ //비회원(비로그인)
			order.setMemId("GUEST");
			order.setMemNo(99999999);
			order.setOrdrEmail("GUEST");
			order.setRegrNo(0);
		}else{ //회원(로그인)
			order.setMemId(member.getEmail());
			order.setMemNo(member.getMemNo());
			order.setRegrNo(member.getMemNo());
			order.setOrdrEmail(member.getEmail());			
		}

		//모바일, PC 체크
		if(order.isMobile()){ //모바일
			order.setBrwsCls(Constants.BRWS_CLS_MOBILE);
		}else{ //PC
			order.setBrwsCls(Constants.BRWS_CLS_PC);
		}
		
		//사용자 접속 IP수집
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
		order.setRegIp(ip);
		
		order.setOrdrCp(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setOrdrTel(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());
		order.setRcpnCpNo(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setRcpnTelNo(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());		
		//order.setOrdrZipCd(order.getOrdrZipCd());
		order.setRcpnZipCd(order.getOrdrZipCd());
		order.setRcpnBsAddr(order.getOrdrBsAddr());
		order.setRcpnDtlAddr(order.getOrdrDtlAddr());
		order.setRcpnNm(order.getOrdrNm());
		
		//배송비 및 총상품금액 계산
		int totalSlAmt = 0 ;	//총상품금액
		int deliveryCost = (int)setting.dlv_cst;	//TODO배송비
		
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			totalSlAmt += order.getOrderGoods().get(i).getSlPrc();
		}
		order.setTotalSlAmt(totalSlAmt);
		
		
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			order.setTotalDlvCst(0);
		}else{
			order.setTotalDlvCst(deliveryCost);
		}
		
		try {
			Order orderResult = orderService.orderInit(order);
			orderService.orderProcessingOnlyPoint(orderResult,member);
			
			mav.addObject("order", orderResult);
			String res_cd = "0000";
			String res_msg = "성공";
			
			request.setAttribute("res_cd", res_cd);
			request.setAttribute("res_msg",res_msg);
			request.setAttribute("ordr_idxx",order.getOrdNo());
			
			
			smsSend.sendSMS(3, order.getOrdrCp(), request.getAttribute("siteNm").toString(), order.getRcpnNm(), order.getOrdNo(), 0);
			System.out.println("orderPayWeb=====================671" + order.getOrdrCp() + "," +request.getAttribute("siteNm").toString() + ", " + order.getRcpnNm() + "," + order.getOrdNo());
			//MAIL 발송`
			HashMap<String,Object> hm = new HashMap<String,Object>();
        	hm.put("orderNo", order.getOrdNo());
        	System.out.println("orderPayWeb=====================675");
        	int result = 0;
        	//메일발송 성공 : 1, 실패 : 0
        	if(member != null){
				result = mailSend.sendMail(order.getOrdrNm(),order.getOrdrEmail(),request,hm,"ordComp");
        	}
        	
		} catch (Exception e) {
			String res_cd = "0001";
			String res_msg = "포인트 결제 실패";
			request.setAttribute("res_cd", res_cd);
			request.setAttribute("res_msg",res_msg);
			request.setAttribute("ordr_idxx",order.getOrdNo());
		} finally{
			mav.setViewName("/worksout/order/orderPayOnlyPoint");
		}
		
		return mav;
	}	
	
	/**
	 * 주문 init
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderPay2")
	public ModelAndView orderPay2(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("orderForm") Order order) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(order.getOrderGoods() == null){
			mav.addObject("alert", "선택한 상품이 없습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}
		
		//주문 전 재고수량 체크
		boolean checkStockFlag = false;
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
			searchForm.setUbiGdsSize(order.getOrderGoods().get(i).getUbiGdsSize());
			if(goodsService.checkGdsStock(searchForm) < 1){
				checkStockFlag = true;
			}
		}
		
		if(checkStockFlag){
			mav.addObject("alert", "재고수량이 부족한 상품이 있습니다.");
			mav.addObject("redirect", "/front/order/cartList");
			mav.setViewName("/common/scriptView/script");			
			return mav;
		}			
		//주문 전 재고수량 체크		
		
		Setting setting = settingService.deliverySettingList();
		Member member = (Member)request.getSession().getAttribute("member");
		
		order.setSiteNo(getSiteNo(request)); 					// 사이트 코드 : WORKSOUT(10001)
		
		if("OR00803".equals(order.getOrderPay().get(0).getPayWay())){
			order.setOrdStat(Constants.ORD_STAT_STAND);	// 주문상태 : 입금대기
		}else{
			order.setOrdStat(Constants.ORD_STAT_TEMP);	// 주문상태 : 주문대기
		}
		
		
		if(member == null){ //비회원(비로그인)
			order.setMemId("GUEST");
			order.setMemNo(99999999);
			order.setOrdrEmail("GUEST");
			order.setRegrNo(0);
		}else{ //회원(로그인)
			order.setMemId(member.getEmail());
			order.setMemNo(member.getMemNo());
			order.setRegrNo(member.getMemNo());
			order.setOrdrEmail(member.getEmail());			
		}

		//모바일, PC 체크
		if(order.isMobile()){ //모바일
			order.setBrwsCls(Constants.BRWS_CLS_MOBILE);
		}else{ //PC
			order.setBrwsCls(Constants.BRWS_CLS_PC);
		}
		
		//사용자 접속 IP수집
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
		order.setRegIp(ip);
		
		order.setOrdrCp(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setOrdrTel(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());
		order.setRcpnCpNo(order.getOrdrCp01()+"-"+order.getOrdrCp02()+"-"+order.getOrdrCp03());
		order.setRcpnTelNo(order.getOrdrTel01()+"-"+order.getOrdrTel02()+"-"+order.getOrdrTel03());
		//order.setOrdrZipCd(order.getOrdrZipCd01()+order.getOrdrZipCd02());
		order.setRcpnZipCd(order.getOrdrZipCd());
		order.setRcpnBsAddr(order.getOrdrBsAddr());
		order.setRcpnDtlAddr(order.getOrdrDtlAddr());
		order.setRcpnNm(order.getOrdrNm());
		
		//배송비 및 총상품금액 계산
		int totalSlAmt = 0 ;	//총상품금액
		int deliveryCost = (int)setting.dlv_cst;	//TODO배송비
		
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			totalSlAmt += order.getOrderGoods().get(i).getSlPrc();
		}
		order.setTotalSlAmt(totalSlAmt);
		
		
		if(totalSlAmt > (int)setting.getCnd_free_dlv_amt()){
			order.setTotalDlvCst(0);
		}else{
			order.setTotalDlvCst(deliveryCost);
		}
		
		Order orderResult = orderService.orderInit(order);
		
		totalSlAmt = 0;
		for (int i = 0; i < orderResult.getOrderGoods().size(); i++) {
			if(orderResult.getOrderGoods().get(i).getCpnPayAmt() != null){
				totalSlAmt += orderResult.getOrderGoods().get(i).getSlPrc() - orderResult.getOrderGoods().get(i).getCpnPayAmt();
			}else{
				totalSlAmt += orderResult.getOrderGoods().get(i).getSlPrc();
			}
		}
		order.setTotalSlAmt(totalSlAmt);
		
		mav.addObject("serverSetting", serverSetting);
		mav.addObject("ordNo", orderResult.getOrdNo());
		mav.addObject("order", orderResult);
		mav.addObject("totalSlAmt", order.getTotalSlAmt());
		mav.addObject("deliveryCost", order.getTotalDlvCst());
		mav.setViewName("/worksout/order/orderPay2");
		return mav;
	}	
	
	@RequestMapping(value = "/orderPay2After")
	public ModelAndView orderPay2After(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @ModelAttribute("orderForm") Order order) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/order/orderPay2");
		return mav;
	}	
	
	@RequestMapping(value = "/orderPayWeb")
	public ModelAndView orderPayWeb(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("siteNm", getSiteNm(request));
		mav.setViewName("/worksout/order/orderPayWeb");
		return mav;
	}	
	
	
	@RequestMapping(value = "/orderPayAddWeb")
	public ModelAndView orderPayAddWeb(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("siteNm", getSiteNm(request));
		mav.setViewName("/worksout/order/orderPayAddWeb");
		return mav;
	}		
	
	@RequestMapping(value = "/orderResult")
	public ModelAndView orderResult(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(request.getParameter("ordr_idxx"));
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.setViewName("/worksout/order/orderResult");
		return mav;
	}
	
	@RequestMapping(value = "/orderCancel")
	public ModelAndView orderCancel(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo, @RequestParam("ordGdsSeq") Integer ordGdsSeq, @RequestParam("modType") String modType, @RequestParam("payWay") String payWay) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		if(payWay.equals(Constants.PAY_WAY_CARD)){
			mav.setViewName("/worksout/common/orderCancel");	
		}else{
			mav.setViewName("/worksout/order/orderCancelEscrow");
			//mav.setViewName("/worksout/order/modifyEscrow");
		}
		
		mav.setViewName("/worksout/order/orderCancelEscrow");
		//mav.setViewName("/worksout/order/modifyEscrow");
		return mav;
	}
	
	
	@RequestMapping(value = "/modifyOrderGoodsStat")
	public ModelAndView modifyEscrow(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo, @RequestParam("ordGdsSeq") Integer ordGdsSeq, @RequestParam("modType") String modType, @RequestParam("perOrdStat") String perOrdStat , @RequestParam("payWay") String payWay) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		//Admin admin = (Admin)request.getSession().getAttribute("admin");
		Member member = (Member)request.getSession().getAttribute("member");
		
		mav.addObject("ordNo", ordNo);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("modType", modType);
		mav.addObject("payWay", payWay);
		mav.addObject("perOrdStat", perOrdStat);
		boolean flag = false;
		
		if(Constants.NOT_PG_MODULES.indexOf(perOrdStat) > -1){ //주문상태만 변경
			flag = true;
		}
		
		//에스크로가 아닐 경우 배송상태는 내부에서만 변경
		if(Constants.PAY_WAY_CARD.equals(payWay)){
			if(Constants.PER_ORD_STAT_SEND_COMPL.equals(perOrdStat)){
				flag = true;
			}
		}
		
		if(flag){
			Order order = new Order();
			order.setOrdNo(ordNo);
			order.setPerOrdStat(perOrdStat);//개별주문상태
			order.setOrdGdsSeq(ordGdsSeq);//주문상품일련번호
			order.setUpdrNo(member.getMemNo());//수정자

			int uptCnt = orderService.updateOrdStat2(order);
			if(uptCnt > 0){
				mav.addObject("alert", "저장되었습니다.");
			}else{
				mav.addObject("alert", "저장에 실패 하였습니다.");
			}
			mav.addObject("windowClose", "true");
			mav.addObject("openerReload", "true");
			mav.setViewName("/common/scriptView/script");			
		}else{
			mav.setViewName("/common/order/modifyEscrow");	
		}
		
		if(Constants.PAY_WAY_CARD.equals(payWay)){
			if(Constants.PER_ORD_STAT_ORDER_CANCEL.equals(perOrdStat) || Constants.PER_ORD_STAT_RETURN_COMPL.equals(perOrdStat)){
				mav.setViewName("/common/order/cancel");
			}			
		}
		
		
		//포인트로만 결제된 주문취소
		if(Constants.PAY_WAY_ONLY_POINT.equals(payWay)){
			
			try {
				Order order = new Order();
				order.setOrdNo(ordNo);
				order.setPerOrdStat(perOrdStat);//개별주문상태
				order.setOrdGdsSeq(ordGdsSeq);//주문상품일련번호
				order.setUpdrNo(member.getMemNo());//수정자

				int uptCnt = orderService.updateOrdStat2(order);

				SearchForm searchForm = new SearchForm();
				searchForm.setOrdNo(ordNo);
				order = orderService.selectOrder(searchForm);
				
				
		    	UbiOrder ubiOrder = new UbiOrder();
		    	ubiOrder.set주문번호(order.getOrdNo().toString());
		    	orderService.insertUbiOrderCancel(ubiOrder);				
				
		     	//적립금 환불
		    	Point point = new Point();
				point.setRsvRsnCd("MT00206");
				point.setMemNo(order.getMemNo());
				point.setRsvPnt(order.getOrderPay().get(1).getPayAmt());	
				point.setRsvYn("Y");
				point.setRegrNo(order.getMemNo());
				point.setRsvCls("CM01002");
				point.setOrdNo(ordNo);
				orderService.insertPoint(point);		
				
				
				//SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
				smsSend.sendSMS(6, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), order.getOrdNo(), ordGdsSeq);
				
				//MAIL 발송
				HashMap<String,Object> hm = new HashMap<String,Object>();
		       	hm.put("orderNo", order.getOrdNo());
		       	int result = 0;
		       	//메일발송 성공 : 1, 실패 : 0
				result = mailSend.sendMail(order.getOrdrNm(),order.getOrdrEmail(),request,hm,"ordCancel");			
				
				
				if(uptCnt > 0){
					mav.addObject("alert", "취소 되었습니다.");
				}else{
					mav.addObject("alert", "취소에 실패 하였습니다.");
				}
				mav.addObject("parentReload", "true");
				mav.setViewName("/common/scriptView/script");
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/updateOrderProcess")
	public ModelAndView updateOrderProcess(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("ordNo") String ordNo, @RequestParam("ordGdsSeq") Integer ordGdsSeq, @RequestParam("modType") String modType, @RequestParam("payWay") String payWay) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("ordNo", ordNo);
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("modType", modType);
		mav.addObject("payWay", payWay);
		
		mav.setViewName("/common/order/updateOrderProcess");
		return mav;
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
	
	/**
	 * 회원 장바구니 상품 사이즈 변경하기 
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateGdsSize")
	public void updateGdsSize(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cartNo") Integer cartNo,	@RequestParam("gdsSize") String gdsSize) throws IOException {
	
		System.out.println("updateGdsSize============");
		
		Member member = (Member)request.getSession().getAttribute("member");

		int checkCart = 0;

		Cart cart = new Cart();
		cart.setCartNo(cartNo);
		cart.setGdsSize(gdsSize);
		
		if(member == null){ //비회원(비로그인)
			cart.setRegrNo(99999999);
		}else{ //회원(로그인)
			cart.setRegrNo(member.getMemNo());
		}		
		
		
		checkCart = cartService.updateGdsSize(cart);
		   
		response.getWriter().print(checkCart);		
	}
	
	/**
	 * 추가결제 init
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderPayAdd")
	public ModelAndView orderPayAdd(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("ordNo") String ordNo) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		Member member = (Member)request.getSession().getAttribute("member");

		String payway = request.getParameter("payway");
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(ordNo);
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("payway", payway);
		mav.setViewName("/worksout/order/orderPayAdd");
		return mav;
	}
	
	/**
	 * 주문 init
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param order
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/orderPayAdd2")
	public ModelAndView orderPayAdd2(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("ordNo") String ordNo) 
	throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		Member member = (Member)request.getSession().getAttribute("member");

		String payway = request.getParameter("payway");
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(ordNo);
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("payway", payway);
		mav.setViewName("/worksout/order/orderPayAdd2");
		return mav;
	}		
}
