package com.giftiel.shop.controller.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.MailSend;
import com.giftiel.shop.dto.MailManage;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderClm;
import com.giftiel.shop.dto.OrderClmGds;
import com.giftiel.shop.dto.OrderDlvCmp;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.SettingService;




@Controller
@RequestMapping("/mail")
public class MailController extends FrontController{

//	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MailSend MailSend;
	
	@Autowired
	private ManageService manageService;
	
	@Value("${server.contextPath}")
	private String contextPath;	
	
	@Autowired
	private OrderService orderService;	
	
	@Value("${upload.image}")
	private String uploadImage;	
    
	//	2015-10-08 2차 오픈후 추가
	@Autowired
	private SettingService settingService;
    
    /**
     * 
     * @param
     * @return
     */
	@RequestMapping(value = "/mailTest/{formKind}", method = RequestMethod.GET)
	public @ResponseBody String mailTest(
			@PathVariable("formKind") String formKind,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		
		String to      = "njjogali@naver.com";
		
		HashMap<String,String> hm = new HashMap<String,String>();
		
		
		
		if(formKind.equals("memRegister")){ //회원가입
			hm.put("nm", "서민우");
			hm.put("email", "minoos11@naver.com");
		}else if(formKind.equals("ordComp")){ //주문완료
			hm.put("orderNo", "2016041213455180");
		}else if(formKind.equals("payComp")){ //결제확인
			hm.put("orderNo", "2016041213455180");
		}else if(formKind.equals("shippComp")){ //배송완료
			hm.put("orderNo", "2016041213455180");
		}else if(formKind.equals("ordCancel")){ //취소
			hm.put("ordGdsSeq", "951");
			hm.put("orderNo", "2015091820105213");
		}else if(formKind.equals("ordReturn")){ //반품
			hm.put("ordGdsSeq", "951");
			hm.put("orderNo", "2015091820105213");
		}else if(formKind.equals("ordChange")){ //교환
			hm.put("ordGdsSeq", "951");
			hm.put("orderNo", "2015091820105213");
		}
		
		
		
		
		//성공 : 1, 실패 : 0   memReg : 회원가입, ordComp : 주문완료
		int result = MailSend.sendMail("최길동",to,request,hm,formKind);
		
		return "<script>alert('" + formKind + "[" + result + "]');</script>";
         
    }
	
	/**
	 * 
	 * @param
	 * @return
	 * */
	@RequestMapping(value = "/contactUsMail", method = RequestMethod.POST)
	public @ResponseBody int contactUsMail(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("mailManage") MailManage mailManage
			) throws Exception{

		String from = mailManage.getSndrEmail();
		String to = mailManage.getRcvrEmail();
		String subject = mailManage.getTitle();
		String message = mailManage.getTxtHtml();
		String userName = mailManage.getSndrName();

		String attachFile = mailManage.getAtchFile();
		
		mailManage.setTmplUrl("");			// 템플릿URL
		mailManage.setUpdrNo(000000);		// 작성자
		mailManage.setRegrNo(000000);		// 작성자
		mailManage.setRsvTgGb("CM01201");	// 개별발송
		mailManage.setRsvTg("0");			// 수신대상

		//성공 : 1, 실패 : 그외
		int result = MailSend.sendMailFile(mailSender, subject, from, to, message, attachFile, userName);
		if(result > 0){
			manageService.insertSndMail(mailManage);
		}
		
		return result;
	}
	
	/**
	 * 메일폼 반환(회원가입시)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memRegister", method = RequestMethod.GET)
	public ModelAndView memRegister(
    		@RequestParam(value="nm")String nm,
    		@RequestParam(value="email")String email,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		nm = new String(nm.getBytes("8859_1"), "UTF-8");
		email = new String(email.getBytes("8859_1"), "UTF-8");
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		//		2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("nm", nm);
		mav.addObject("email", email);
		mav.addObject("url", url);
		mav.setViewName("/admin/mail/memRegister");
		return mav;
         
    }
	
	/**
	 * 메일폼 반환(주문완료)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ordComp", method = RequestMethod.GET)
	public ModelAndView ordComp(@RequestParam(value="orderNo") String orderNo, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
//		String url = request.getScheme() + "://" +  request.getServerName();
		
		ModelAndView mav = new ModelAndView();

		//	2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
		
		Order order = orderService.selectOrder(searchForm);
		
		mav.addObject("order", order);
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		mav.setViewName("/admin/mail/ordComp");
		return mav;
         
    }
	
	
	/**
	 * 메일폼 반환(입금확인)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/payComp", method = RequestMethod.GET)
	public ModelAndView payComp(
    		@RequestParam(value="orderNo")String orderNo,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
		
		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String  thisDay = sdformat.format(date);
		
//		2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		mav.addObject("thisDay", thisDay);
		mav.setViewName("/admin/mail/payComp");
		return mav;
         
    }
	
	
	/**
	 * 메일폼 반환(배송확인)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/shippComp", method = RequestMethod.GET)
	public ModelAndView shippComp(
    		@RequestParam(value="orderNo")String orderNo,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
		
		
		Order order = orderService.selectOrder(searchForm);
		
/*		int dlvCmpNo = order.getDlvCmpNo();
		OrderDlvCmp orderDlvCmp = orderService.dlvCmp(dlvCmpNo);*/
		
		
		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String  thisDay = sdformat.format(date);
		
//		2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		//mav.addObject("orderDlvCmp", orderDlvCmp);
		mav.addObject("thisDay", thisDay);
		mav.setViewName("/admin/mail/shippComp");
		return mav;
         
    }
	
	
	
	/**
	 * 메일폼 반환(취소)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ordCancel", method = RequestMethod.GET)
	public ModelAndView ordCancel(
    		@RequestParam(value="orderNo") String orderNo,
//			@RequestParam(value="ordGdsSeq") int ordGdsSeq,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
//		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		
		Order order = orderService.selectOrder(searchForm);

		
		
// 부분 취소시 해당하는 로직이라 주석 처리하여 뺌 2015-10-12 이현우
		//해당 order객체 따로 뽑아줌
//		List<OrderGoods> good = order.getOrderGoods();
//		OrderGoods tempGood = new OrderGoods();
//		int cnt = 0;
//		for(OrderGoods gd:good){
//			int a = gd.getOrdGdsSeq();
//			if(ordGdsSeq == a){
//				tempGood = good.get(cnt);
//			}
//			cnt += 1;
//		}
//		good = new ArrayList<OrderGoods>();
//		good.add(tempGood);
//		order.setOrderGoods(good);
		
		
		
//		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
//		
//		List<OrderClm> tempList = order.getOrderClm();
//		OrderClm orderclm = new OrderClm();
//		
//		
//		//해당 claim 객체 따로 뽑아줌 
//		for(OrderClm oc:tempList){
//			int a = clmNoMap.get("clmNo");
//			int b = oc.getClmNo();
//			
//			if(a == b){
//				orderclm = oc;
//				List<OrderClmGds> subTempList = oc.getOrderClmGds();
//				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
//				for(OrderClmGds ocg:subTempList){
//					int c = ocg.getClmGdsSeq();
//					int d = clmNoMap.get("clmGdsSeq");
//					if(c == d){
//						orderClmGdsList.add(ocg);
//						orderclm.setOrderClmGds(orderClmGdsList);
//					}
//				}
//			}
//		}
		
//		mav.addObject("ordGdsSeq", ordGdsSeq);
//		mav.addObject("clmNoMap", clmNoMap);
//		mav.addObject("orderclm", orderclm);

//		2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		mav.setViewName("/admin/mail/ordCancel");
		return mav;
         
    }
	
	
	/**
	 * 메일폼 반환(반품)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ordReturn", method = RequestMethod.GET)
	public ModelAndView ordReturn(
    		@RequestParam(value="orderNo")String orderNo,
			@RequestParam(value="ordGdsSeq") int ordGdsSeq,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("cancleAndTakeBack");
		
		
		Order order = orderService.selectOrder(searchForm);
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
		
		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
//		2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		//	2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		mav.setViewName("/admin/mail/ordReturn");
		return mav;
         
    }
	
	
	
	/**
	 * 메일폼 반환(교환)
	 * @param nm
	 * @param email
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ordChange", method = RequestMethod.GET)
	public ModelAndView ordChange(
    		@RequestParam(value="orderNo")String orderNo,
			@RequestParam(value="ordGdsSeq") int ordGdsSeq,
    		Locale locale, 
			Model model, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		String url = request.getScheme() + "://" +  request.getServerName() + ":" +  request.getServerPort();
		
		
		ModelAndView mav = new ModelAndView();
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(orderNo);
		searchForm.setOrdGdsSeq(ordGdsSeq);
		searchForm.setOrdKnd("exchange");
		
		
		Order order = orderService.selectOrder(searchForm);
		
		//해당 order객체 따로 뽑아줌
		List<OrderGoods> good = order.getOrderGoods();
		OrderGoods tempGood = new OrderGoods();
		int cnt = 0;
		for(OrderGoods gd:good){
			int a = gd.getOrdGdsSeq();
			if(ordGdsSeq == a){
				tempGood = good.get(cnt);
			}
			cnt += 1;
		}
		good = new ArrayList<OrderGoods>();
		good.add(tempGood);
		order.setOrderGoods(good);
		
		
		
		HashMap<String,Integer> clmNoMap = orderService.getClmNo(searchForm);
		
		List<OrderClm> tempList = order.getOrderClm();
		OrderClm orderclm = new OrderClm();
		
		
		//해당 claim 객체 따로 뽑아줌 
		for(OrderClm oc:tempList){
			int a = clmNoMap.get("clmNo");
			int b = oc.getClmNo();
			
			if(a == b){
				orderclm = oc;
				List<OrderClmGds> subTempList = oc.getOrderClmGds();
				List<OrderClmGds> orderClmGdsList = new ArrayList<OrderClmGds>();
				for(OrderClmGds ocg:subTempList){
					int c = ocg.getClmGdsSeq();
					int d = clmNoMap.get("clmGdsSeq");
					if(c == d){
						orderClmGdsList.add(ocg);
						orderclm.setOrderClmGds(orderClmGdsList);
					}
				}
			}
		}
		
		// 2015-10-08 2차 오픈후 추가
        String reqURL = request.getRequestURL().toString();
		
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);
		
		for (int i = 0; i < siteList.size(); i++) {
			if((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)){
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm()));
			}
		} 
		// 2015-10-08 2차 오픈후 추가
		
		mav.addObject("siteDir",request.getAttribute("siteDir"));
		
		mav.addObject("ordGdsSeq", ordGdsSeq);
		mav.addObject("clmNoMap", clmNoMap);
		mav.addObject("orderclm", orderclm);
		
		mav.addObject("order", order);
		mav.addObject("uploadImage", uploadImage);
		mav.addObject("url", url);
		mav.setViewName("/admin/mail/ordChange");
		return mav;
         
    }
  
     
}

