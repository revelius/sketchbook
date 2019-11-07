package com.giftiel.shop.controller.front;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.CategoryForm;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Event;
import com.giftiel.shop.dto.MailManage;
import com.giftiel.shop.dto.MainManage;
import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.WorkWithUs;
import com.giftiel.shop.service.CarharttRadioService;
import com.giftiel.shop.service.CartService;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.EventService;
import com.giftiel.shop.service.ManageService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.SettingService;
import com.giftiel.shop.service.WorkWithUsService;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front")
public class MainController extends FrontController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SettingService settingService;

	@Value("${server.setting}")
	private String serverSetting;

	@Value("${server.contextPath}")
	private String contextPath;

	@Value("${upload.image}")
	private String uploadImage;

	@Autowired
	private ManageService manageService;

	@Autowired
	private WorkWithUsService workWithUsService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private CartService cartService;

	@Autowired
	private CarharttRadioService carharttRadioService;

	@Autowired
	private EventService eventService;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/header")
	public ModelAndView header(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, SearchForm searchForm)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//탑배너 뉴스 리스트
		searchForm.setTopBnnrDispYn("Y");
		searchForm.setStartListNum(1);
		searchForm.setEndListNum(Integer.MAX_VALUE);
		searchForm.setSiteNo(getSiteNo(request).toString());
		List<News> newsList = manageService.newsListFront(searchForm);

		if (getSiteNo(request) == 10002) {
			List<CarharttRadioForm> carharttRadioList = carharttRadioService.carharttRadioList(searchForm);
			mav.addObject("carharttRadioList", carharttRadioList);
		}

		//onlineshop에서 전달
		String oneDepth = request.getParameter("oneDepth");

		//		if(getSiteNo(request) == 10003){
		//
		//			List<Awnes> awnes =  manageService.getFrontAwnes();
		//
		//			if(awnes != null){
		//				List<AwnesCont> awnesCont = awnes.get(0).getAwnesCont();
		//
		//				if(!awnesCont.equals(0)){
		//					for(AwnesCont anc:awnesCont){
		//						if(anc.getContUrl() != null){
		//							anc.setContUrl(convertGetSrc(anc.getContUrl()));
		//						}
		//					}
		//				}
		//			}
		//
		//			mav.addObject("awnes", awnes);
		//		}

		mav.addObject("oneDepth", oneDepth);
		mav.addObject("newsList", newsList);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/worksout/include/layout/header");
		return mav;
	}

	@RequestMapping(value = "/main")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		List<MainManage> worksoutList = manageService.mainManageList(getSiteNo(request) == null ? 10001 : getSiteNo(request));

		mav.addObject("worksoutList", worksoutList);
		mav.addObject("uploadImage", uploadImage);

		mav.setViewName("/worksout/main");
		return mav;
	}

	@RequestMapping(value = "/snbMain")
	public ModelAndView snbMain(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("siteNo", getSiteNo(request).toString());
		mav.setViewName("/worksout/include/layout/snb_main");
		return mav;
	}

	@RequestMapping(value = "/about")
	public ModelAndView about(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		String siteNo = getSiteNo(request).toString();
		String siteNm = getSiteNm(request).toLowerCase();

		mav.addObject("siteNo", siteNo);
		mav.addObject("siteNm", siteNm);
		mav.setViewName("/worksout/about");
		return mav;
	}

	@RequestMapping(value = "/storeInfo/{locationPath}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView storeInfo(@PathVariable("locationPath") String locationPath, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		// 네이버 지도api Key
		String key = "a7590aae765537ff016a9b3126a7e2be";
		String nhnApi = "http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=" + key;
		//String nhnApi = "<script type='text/javascript' src='http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=" + key + "' charset='utf-8'></script>";

		mav.addObject("apiPath", nhnApi);
		mav.setViewName("/worksout/storeInfo" + locationPath);
		return mav;
	}

	@RequestMapping(value = "/snbStoreInfo")
	public ModelAndView snbStoreInfo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("siteNo", getSiteNo(request).toString());
		mav.setViewName("/worksout/include/layout/snb_store_info");
		return mav;
	}

	@RequestMapping(value = "/dealers")
	public ModelAndView dealers(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("siteNo", getSiteNo(request).toString());
		mav.setViewName("/worksout/dealers");
		return mav;
	}

	@RequestMapping(value = "/contactUs")
	public ModelAndView contactUs(@ModelAttribute("mailManage") MailManage mailManage, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		if ((Member) request.getSession().getAttribute("member") != null && !((Member) request.getSession().getAttribute("member")).equals("")) {
			mailManage.setSndrName(((Member) request.getSession().getAttribute("member")).getNm());
			mailManage.setSndrEmail(((Member) request.getSession().getAttribute("member")).getEmail());
		}

		Setting searchForm = new Setting();

		searchForm.setSite_no(/* getSiteNo(request).toString() */"10001"); //WORKSOUT 브랜드 목록

		searchForm.setPlcy_desc("CONTACT US");
		Setting CONTACTUS = settingService.storeManageSelect(searchForm);
		mav.addObject("CONTACTUS", CONTACTUS);

		searchForm.setPlcy_desc("ORDER/PAYMENT");
		Setting ORDER = settingService.storeManageSelect(searchForm);
		mav.addObject("ORDER", ORDER);

		searchForm.setPlcy_desc("SHIPPING");
		Setting SHIPPING = settingService.storeManageSelect(searchForm);
		mav.addObject("SHIPPING", SHIPPING);

		searchForm.setPlcy_desc("EXCHANGE");
		Setting EXCHANGE = settingService.storeManageSelect(searchForm);
		mav.addObject("EXCHANGE", EXCHANGE);

		searchForm.setPlcy_desc("POINT");
		Setting POINT = settingService.storeManageSelect(searchForm);
		mav.addObject("POINT", POINT);

		searchForm.setPlcy_desc("A/S");
		Setting AS = settingService.storeManageSelect(searchForm);
		mav.addObject("AS", AS);

		searchForm.setPlcy_desc("USE_AGREEMENT");
		Setting USE_AGREEMENT = settingService.storeManageSelect(searchForm);
		mav.addObject("USE_AGREEMENT", USE_AGREEMENT);

		searchForm.setPlcy_desc("POLICY");
		Setting POLICY = settingService.storeManageSelect(searchForm);
		mav.addObject("POLICY", POLICY);

		searchForm.setPlcy_desc("CONTACT_US_SEND_MAIL");
		Setting CONTACT_US_SEND_MAIL = settingService.storeManageSelect(searchForm);
		mav.addObject("CONTACT_US_SEND_MAIL", CONTACT_US_SEND_MAIL);

		mav.setViewName("/worksout/contactUs");
		return mav;
	}

	@RequestMapping(value = "/workWithUsList")
	public ModelAndView workWithUsList(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		//첫 페이지 조회
		int currentPage = 1;
		int showListLimit = 10;

		searchForm.setSiteNo(getSiteNo(request).toString());
		searchForm.setPage(currentPage);
		searchForm.setStartListNum((currentPage - 1) * showListLimit + 1);
		searchForm.setEndListNum(searchForm.getStartListNum() + showListLimit - 1);

		List<WorkWithUs> workwithUsList = workWithUsService.listWorkWithus(searchForm);

		mav.addObject("workwithUsList", workwithUsList);
		mav.setViewName("/worksout/workWithUsList");
		return mav;
	}

	@RequestMapping(value = "/workWithUsDetail")
	public ModelAndView workWithUsDetail(@ModelAttribute("searchForm") SearchForm searchForm, Locale locale, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		int seq = Integer.parseInt(searchForm.getTxtNo());

		WorkWithUs workWithUs = workWithUsService.workWithUsDetail(seq);

		mav.addObject("workWithUs", workWithUs);
		mav.setViewName("/worksout/workWithUsDetail");
		return mav;
	}

	@RequestMapping(value = "/snbShop")
	public ModelAndView snbShop(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		Setting setting = new Setting();

		//worksout 에서만 브랜드 노출
		if (StringUtils.equals(getSiteNo(request).toString(), Constants.WORKSOUT_SITE_CODE)) {
			List<Site> site = settingService.siteSettingList(setting);
			mav.addObject("siteList", site);
		}

		String curOneDepth = request.getParameter("oneDepth");
		String curTwoDepth = request.getParameter("twoDepth");
		String curThreeDepth = request.getParameter("threeDepth");
		String curBrand = request.getParameter("brand");
		String curSex = request.getParameter("sex");
		String clbltnNm = request.getParameter("clbltnNm");
		String orderFlag = request.getParameter("orderFlag");
		String orderBy = request.getParameter("orderBy");
		String viewType = request.getParameter("viewType");
		String newArvl = request.getParameter("newArvl");

		int curSeq = Integer.parseInt(request.getAttribute("currentSeq").toString()); //선택한 시즌 seq
		//		String prese = (String)request.getAttribute("preSeason"); //선택한 시즌 seq
		//		String curse = (String)request.getAttribute("currentSeason"); //선택한 시즌 seq

		if (StringUtils.isEmpty(curOneDepth)) {
			//			curOneDepth = request.getAttribute("currentSeason").toString();
			curOneDepth = request.getAttribute("currentTopYn").equals("Y") ? request.getAttribute("currentSeason").toString()
					: request.getAttribute("preSeason").toString();
			curSeq = request.getAttribute("currentTopYn").equals("Y") ? Integer.parseInt(request.getAttribute("currentSeq").toString())
					: Integer.parseInt(request.getAttribute("preSeq").toString());
		}

		HttpSession session = request.getSession();
		if (session.getAttribute("nowSeq") == null) {
			session.setAttribute("nowSeq", curSeq);
		}

		if (StringUtils.isEmpty(curBrand)) {
			//curBrand = "";
		}

		//카테고리 리스트
		List<Category> oneDepth = categoryService.listCategory(Constants.CATE_GUBUN_1DEPTH);

		SearchForm searchForm = new SearchForm();
		if (!"10001".equals(getSiteNo(request).toString())) {
			searchForm.setSiteNo(getSiteNo(request).toString());
		}

		if (session.getAttribute("nowSeq") != null) {
			searchForm.setNowSeq(Integer.parseInt(session.getAttribute("nowSeq").toString()));
		}

		searchForm.setCurSeason(request.getAttribute("currentDispYn").equals("Y") ? request.getAttribute("currentSeason").toString()
				: request.getAttribute("preSeason").toString());
		searchForm.setBrand(curBrand);

		searchForm.setSex("M");
		searchForm.setGubun("CATEGORY1");
		searchForm.setSeasonCode(curOneDepth);
		List<Category> twoDepth = categoryService.listCategoryGdsCnt(searchForm);
		searchForm.setCategory1Code(curTwoDepth);
		searchForm.setGubun("CATEGORY2");
		List<Category> threeDepth = categoryService.listCategoryGdsCnt(searchForm);

		searchForm.setSex("W");
		searchForm.setGubun("CATEGORY1");
		searchForm.setSeasonCode(curOneDepth);
		List<Category> wtwoDepth = categoryService.listCategoryGdsCnt(searchForm);
		searchForm.setCategory1Code(curTwoDepth);
		searchForm.setGubun("CATEGORY2");
		List<Category> wthreeDepth = categoryService.listCategoryGdsCnt(searchForm);

		///////임시 카테고리 불러오는것 devDB용... 삭제 예정~~~
		//		twoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		//		threeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);
		//		wtwoDepth = categoryService.listCategory(Constants.CATE_GUBUN_2DEPTH);
		//		wthreeDepth = categoryService.listCategory(Constants.CATE_GUBUN_3DEPTH);
		//////

		//카테고리 설정값 가져오기
		CategoryForm categoryForm = new CategoryForm();
		categoryForm.setSeasonSeq(String.valueOf(searchForm.getNowSeq()));
		HashMap<String, String> cateHm = categoryService.getCateDepth(categoryForm);

		List<Category> twoDepthMen = new ArrayList<Category>();
		List<Category> threeDepthMen = new ArrayList<Category>();
		List<Category> twoDepthWomen = new ArrayList<Category>();
		List<Category> threeDepthWomen = new ArrayList<Category>();

		//men2뎁스
		if (cateHm.get("MEN2") != null) {
			for (Category ct : twoDepth) {
				if (cateHm.get("MEN2").indexOf(ct.getCateCd()) > -1) {
					twoDepthMen.add(ct);
				}
			}
		}

		//men3뎁스
		if (cateHm.get("MEN3") != null) {
			for (Category ct : threeDepth) {
				if (cateHm.get("MEN3").indexOf(ct.getCateCd()) > -1) {
					threeDepthMen.add(ct);
				}
			}
		}

		//women2뎁스
		if (cateHm.get("WOMEN2") != null) {
			for (Category ct : wtwoDepth) {
				if (cateHm.get("WOMEN2").indexOf(ct.getCateCd()) > -1) {
					twoDepthWomen.add(ct);
				}
			}
		}

		//women3뎁스
		if (cateHm.get("WOMEN3") != null) {
			for (Category ct : wthreeDepth) {
				if (cateHm.get("WOMEN3").indexOf(ct.getCateCd()) > -1) {
					threeDepthWomen.add(ct);
				}
			}
		}

		//설정한 브랜드 가져오기
		searchForm.setBrand(Constants.BRAND);
		List<Code> brandCode = categoryService.listCd(searchForm);
		//		List<Code> brandCode = codeService.listCd(Constants.BRAND);

		mav.addObject("oneDepth", oneDepth);
		mav.addObject("twoDepth", twoDepth);
		mav.addObject("threeDepth", threeDepth);

		mav.addObject("menNaDispYn", cateHm.get("MEN_NA_DISP_YN"));
		mav.addObject("twoDepthMen", twoDepthMen);
		mav.addObject("threeDepthMen", threeDepthMen);
		mav.addObject("womenNaDispYn", cateHm.get("WOMEN_NA_DISP_YN"));
		mav.addObject("twoDepthWomen", twoDepthWomen);
		mav.addObject("threeDepthWomen", threeDepthWomen);
		mav.addObject("menNaDispNm", cateHm.get("MEN_NA_DISP_NM"));
		mav.addObject("womenNaDispNm", cateHm.get("WOMEN_NA_DISP_NM"));

		mav.addObject("curBrand", curBrand);
		mav.addObject("curOneDepth", curOneDepth);
		mav.addObject("curTwoDepth", curTwoDepth);
		mav.addObject("curThreeDepth", curThreeDepth);
		mav.addObject("curSex", curSex);
		mav.addObject("clbltnNm", clbltnNm);
		mav.addObject("brandCode", brandCode);
		mav.addObject("newArvl", newArvl);

		mav.addObject("orderFlag", orderFlag);
		mav.addObject("orderBy", orderBy);
		mav.addObject("viewType", viewType);
		mav.addObject("currentSiteNo", getSiteNo(request).toString());
		mav.addObject("nowSeq", searchForm.getNowSeq());
		mav.setViewName("/worksout/include/layout/snb_shop");
		return mav;
	}

	@RequestMapping(value = "/cartListAjax")
	public void cartListAjax(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		SearchForm searchForm = new SearchForm();

		Member member = (Member) request.getSession().getAttribute("member");
		if (member == null) { //비회원(비로그인)
			searchForm.setMemNo(99999999 + "");
			searchForm.setIpAddr(getIp(request));
		} else { //회원(로그인)
			searchForm.setMemNo(member.getMemNo() + "");
		}

		searchForm.setSiteNo(getSiteNo(request).toString());

		//System.out.println("searchForm.getSiteNo()" + searchForm.getSiteNo());
		//System.out.println("searchForm.getIpAddr()" + searchForm.getIpAddr());

		List<Cart> cart = cartService.selectFrontCartList(searchForm);

		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().print(gson.toJson(cart));
	}

	@RequestMapping(value = "/footer")
	public ModelAndView footer(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("event") Event event) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("siteNo", getSiteNo(request));
		mav.addObject("siteNm", getSiteDesc(request));

		mav.setViewName("/worksout/include/layout/footer");
		return mav;
	}

	@RequestMapping(value = "/footerAjax", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody int footerAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("event") Event event) throws Exception {

		int result = 0;
		int emailChkCnt = 0;

		// 등록여부 체크
		if (event.getEmail() != null) {
			emailChkCnt = eventService.evtJoinEmailChk(event.getEmail().toString());
		}

		if (emailChkCnt == 0) {

			event.setEvtNo(99999999); // 임시 이벤트번호(광고메일수집번호)
			event.setEvtNm("광고메일수집");

			Member member = (Member) request.getSession().getAttribute("member");

			if (member != null) {
				event.setMemNo(member.getMemNo()); //로그인시 회원 번호
				event.setRegrNo(member.getMemNo()); //로그인시 회원 번호
			} else {
				event.setMemNo(99999999); //비로그인시 비회원번호
				event.setRegrNo(99999999); //비로그인시 비회원번호
			}

			event.setEmailRcpYn("Y");
			event.setSiteNo(getSiteNo(request));

			result = eventService.insertEvtJoin(event);
		} else {
			result = 0;
		}

		return result;
	}

	@RequestMapping(value = "/mailSendCancel")
	public ModelAndView mailSendCancel(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/worksout/mailSendCancel");
		return mav;
	}

	@RequestMapping(value = "mailSendCancelAjax")
	public @ResponseBody int mailSendCancelAjax(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") SearchForm searchForm) throws Exception {
		int result = 0;
		int emailChkCnt = 0;

		Member memberList = memberService.selectMemInfo(searchForm);

		if (memberList != null) {
			if (memberList.getMailSndYn().charAt(0) != 'N') {
				MemInfo memInfo = new MemInfo();
				memInfo.setMemNo(memberList.getMemNo());
				memInfo.setEmail(memberList.getEmail());
				memInfo.setMailSndYn("N");

				result = memberService.changeMemberInfo(memInfo); // 1

			}
		}

		emailChkCnt = eventService.evtJoinEmailChk(searchForm.getEmail());

		if (emailChkCnt != 0) {

			Event event = new Event();
			event.setEmail(searchForm.getEmail());
			event.setEmailRcpYn("N");
			result = eventService.updateEvtJoin(event);

		}

		return result;
	}

	/**
	 * 에스크로 팝업 호출
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/escrowPop")
	public ModelAndView escrowPop(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/worksout/include/layout/escrowPop");
		return mav;
	}

}
