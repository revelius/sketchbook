package com.giftiel.shop.interceptor;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.SeasonForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.StatisticsForm;
import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.service.SettingService;
import com.giftiel.shop.service.StatisticService;
import com.giftiel.shop.utils.DateUtils;

public class FrontInterceptor extends HandlerInterceptorAdapter {
	protected Logger log = LoggerFactory.getLogger(FrontInterceptor.class);

	@Autowired
	private SettingService settingService;
	@Autowired
	private StatisticService statisticService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private CategoryService categoryService;

	@Value("${server.contextPath}")
	private String contextPath;

	@Value("${server.site.no}")
	private Integer siteNo;

	@Value("${cdn.server.url}")
	private String cdnServerUrl;

	@Value("${upload.image}")
	private String uploadImage;

	//true 시 아이피로 접근가능
	private boolean testCls = false;

	//시즌오프 시작 시간
	private String worksoutSeasonOffStrTime = "2017-01-04 18:00";
	private String carharttSeasonOffStrTime = "2017-01-19 14:00";

	//시즌오프 종료 시간
	private String worksoutSeasonOffEndTime = "2017-01-09 10:00";
	private String carharttSeasonOffEndTime = "2017-01-22 12:00";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(true);
		Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);

		request.setAttribute("uploadImage", uploadImage);
		request.setAttribute("cdnServerUrl", cdnServerUrl);

		if (!"/front/snbShop".equals(request.getRequestURI()) && !"/front/snbStoreInfo".equals(request.getRequestURI())
				&& !"/front/header".equals(request.getRequestURI()) && !"/front/footer".equals(request.getRequestURI())
				&& !"/front/snbMain".equals(request.getRequestURI()) && !"/front/snbShop".equals(request.getRequestURI())
				&& !"/front/snbStoreInfo".equals(request.getRequestURI()) && !"/front/cartListAjax".equals(request.getRequestURI())
				&& !"/front/news/snbNews".equals(request.getRequestURI()) && !"popUpOrderPrint".equals(request.getRequestURI())) {
			//log.error(" Request URI \t:  " + request.getRequestURI() + " === " + request.getHeader("Referer"));
		}

		if (!"/front/order/orderPayWeb".equals(request.getRequestURI())) {
			Enumeration<?> eNames = request.getParameterNames();
			if (eNames.hasMoreElements()) {
				while (eNames.hasMoreElements()) {
					String name = (String) eNames.nextElement();
					String[] values = request.getParameterValues(name);
					if (values.length > 0) {
						String value = values[0];
						for (int i = 1; i < values.length; i++) {
							value += "," + values[i];
						}
						if (!FrontInterceptor.checkingInjection(value)) {
							log.error(name + " : " + value);
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
							log.error("XSS 공격이 감지되었습니다.===[" + value + "]" + "IP_ADDR=====" + ip);
							response.sendRedirect("/jsp/common/error.jsp");
							return false;
						}
					}
				}
			}
		}

		String currentQueryString = "";
		if (request.getQueryString() != null) {
			currentQueryString = "?" + request.getQueryString();
		}

		if (request.getServerName().toString().indexOf("loc") == -1) {
			if (request.getServerName().toString().indexOf("www.") == -1) {
				response.sendRedirect(request.getScheme() + "://www." + request.getServerName() + request.getRequestURI() + currentQueryString);
				return false;
			}
		}

		//worksout 본사에서만 접근가능
		//        if(request.getRemoteAddr().indexOf("123.111.221.48") == -1){
		//			response.sendRedirect("/jsp/common/notice.jsp");
		//			return false;
		//        }

		Member member = (Member) request.getSession().getAttribute("member");

		if (member != null) {
			SearchForm searchForm = new SearchForm();
			searchForm.setMemNo(member.getMemNo().toString());
			member = memberService.selectMemInfo(searchForm);
		}

		String reqURI = request.getRequestURI().toString();
		String reqURL = request.getRequestURL().toString();

		String domain = request.getScheme() + "://" + request.getServerName();
		request.setAttribute("domain", domain);

		if ((reqURI.indexOf("/front/myPage") > -1) && (reqURI.indexOf("/nMem") < 0)) {
			if (member == null && (reqURI.indexOf("/confirmAjax") < 0)) {
				if (!(reqURI.indexOf("/popUpOrderPrint") > -1 || reqURI.indexOf("/snb_mypage") > -1)) {
					request.getSession().setAttribute("reqURL", reqURL);
					response.sendRedirect(contextPath + "/front/main");
					return false;
				}
			}
		} else if ((reqURI.indexOf("/front/myPage") > -1) && (reqURI.indexOf("/nMem") > -1)) {
			if (request.getSession().getAttribute("nMemOrdNo") == null) {
				request.getSession().setAttribute("reqURL", reqURL);
				response.sendRedirect(contextPath + "/front/main");
				return false;
			}
		}

		//로그인 확인
		if (member == null) {
			request.setAttribute("isLogined", false);
			//response.sendRedirect(contextPath+"/front/main"); 
			//return false;
		} else {
			request.setAttribute("member", member);
			request.setAttribute("isLogined", true);
		}

		//모바일 접근 확인
		String userAgent = (String) request.getHeader("User-Agent");
		String[] mobileos = { "iPhone", "iPad", "Android", "BlackBerry", "Windows CE", "Nokia", "Webos", "Opera Mini", "SonyEricsson", "Opera Mobi",
				"IEMobile" };

		boolean isMobile = false;
		int j = -1;
		if (userAgent != null && !userAgent.equals("")) {
			for (int i = 0; i < mobileos.length; i++) {
				j = userAgent.indexOf(mobileos[i]);
				if (j > -1) {
					isMobile = true;
				}
			}
		}
		//		isMobile = true;
		request.setAttribute("isMobile", isMobile);

		int siteIdx = 0;
		Setting setting = new Setting();
		List<Site> siteList = settingService.siteSettingList(setting);

		for (int i = 0; i < siteList.size(); i++) {
			if ((reqURL.indexOf(StringUtils.lowerCase(siteList.get(i).getSiteNm())) > -1)) {
				siteIdx = i;
				request.setAttribute("siteNo", siteList.get(i).getSiteNo());
				request.setAttribute("siteNm", siteList.get(i).getSiteNm());
				request.setAttribute("siteDesc", siteList.get(i).getSiteDesc());
				request.setAttribute("siteDir", StringUtils.lowerCase(siteList.get(i).getSiteNm())); // 사이트 메일링에 로고경로
				request.setAttribute("siteTitle", siteList.get(i).getFabiconNm()); // 사이트 타이틀
				request.setAttribute("siteFavicon", siteList.get(i).getFabiconImg()); // 사이트 파비콘 경로
				request.setAttribute("siteKeyWords", siteList.get(i).getKwd()); // 사이트 meta Tag의 검색 키워드
				request.setAttribute("siteDesc2", siteList.get(i).getSiteDesc2()); // 사이트 meta Tag의 설명
			}
		}

		//TODO 임시 사이트 세팅
		request.setAttribute("siteNo", 10001);
		request.setAttribute("siteNm", "giftiel");
		request.setAttribute("siteDesc", "giftiel");
		request.setAttribute("siteDir", "giftiel"); // 사이트 메일링에 로고경로
		request.setAttribute("siteTitle", "giftiel"); // 사이트 타이틀
		request.setAttribute("siteFavicon", "giftiel"); // 사이트 파비콘 경로
		request.setAttribute("siteKeyWords", "giftiel"); // 사이트 meta Tag의 검색 키워드
		request.setAttribute("siteDesc2", "giftiel"); // 사이트 meta Tag의 설명

		// SNS에 사용할 사이트 URL
		request.setAttribute("siteUrl", domain + request.getRequestURI() + currentQueryString);

		boolean statisticsFlag = true;
		//중복실행 방지
		for (int i = 0; i < Constants.interceptorEgnoreUrl.length; i++) {
			if ((reqURI.indexOf(Constants.interceptorEgnoreUrl[i]) > -1)) {
				statisticsFlag = false;
			}
		}

		FrontController frontDir = new FrontController();
		DateFormat sdFormat = new SimpleDateFormat();
		Date visitDate = new Date();

		StatisticsForm statisticsForm = new StatisticsForm();

		String toDate = sdFormat.format(visitDate);
		statisticsForm.setConnDtm(toDate);

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
		String clientIp = ip; // 사용자 IP
		statisticsForm.setConnIpAddr(clientIp);

		String clientBrowser = frontDir.getClientBrowser(userAgent); //사용자 브라우져
		statisticsForm.setConnBrws(clientBrowser);

		String clientOS = frontDir.getClientOS(userAgent); // 사용자 OS
		statisticsForm.setConnOs(clientOS);

		//		Integer clientBrandNo = siteList.get(siteIdx).getSiteNo();	// 사용자 접속 브랜드
		//		statisticsForm.setConnBrnd(clientBrandNo);

		String clientURI = request.getHeader("Referer") == null ? reqURL : request.getHeader("Referer"); // 사용자 접속 URL

		statisticsForm.setConnDomain(clientURI);

		if (statisticsFlag) {
			// 접속 통계를 위한 프로세스

			//			statisticsForm.setTotalCnt(statisticService.countVisit(statisticsForm));

			//			int cnt = statisticsForm.getTotalCnt();

			//			if(cnt == 0){
			//				statisticService.insertVisit(statisticsForm);
			//			}

		}

		request.setAttribute("connInfo", statisticsForm);

		//SEASON OFF 로직
		String seasonOffStrTime = worksoutSeasonOffStrTime;
		String seasonOffEndTime = worksoutSeasonOffEndTime;

		if (request.getAttribute("siteNo") != null) {
			if (StringUtils.equals(request.getAttribute("siteNo").toString(), "10002")) {//worksout과 carhartt 진행 날짜가 다름
				seasonOffStrTime = carharttSeasonOffStrTime;
				seasonOffEndTime = carharttSeasonOffEndTime;
			} else {
				seasonOffStrTime = worksoutSeasonOffStrTime;
				seasonOffEndTime = worksoutSeasonOffEndTime;
			}
		}
		if (DateUtils.overDate(seasonOffStrTime) && DateUtils.preDate(seasonOffEndTime)) {
			if ("/front/order/cartList".equals(request.getRequestURI()) || "/front/order/orderForm".equals(request.getRequestURI())) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();

				out.println("<script>location.href='/jsp/common/seasonOff.jsp';</script>");
				out.flush();
			}
		}
		//SEASON OFF 로직 끝

		/*
		 * //SEASON START 로직 시작 { String seasonStartTime = worksoutSeasonStartTime; String currentSeason2 = currentSeason; String currentSeasonName2 = currentSeasonName; if(request.getAttribute("siteNo") != null){ if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10001")){ seasonStartTime = worksoutSeasonStartTime; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10002")){ seasonStartTime = carharttSeasonStartTime; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10003")){ seasonStartTime = obeySeasonStartTime; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10004")){ seasonStartTime = brixtonSeasonStartTime; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10006")){ seasonStartTime = deusSeasonStartTime; } if(DateUtils.overDate(seasonStartTime)){ if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10001")){ currentSeason2 = worksoutSeason; currentSeasonName2 = worksoutSeasonName; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10002")){ currentSeason2 = carharttSeason; currentSeasonName2 = carharttSeasonName; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10003")){ currentSeason2 = obeySeason; currentSeasonName2 = obeySeasonName; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10004")){ currentSeason2 = brixtonSeason; currentSeasonName2 = brixtonSeasonName; }else if(StringUtils.equals(request.getAttribute("siteNo").toString(), "10006")){ currentSeason2 = deusSeason; currentSeasonName2 = deusSeasonName; } } } //SEASON START 로직 끝 } request.setAttribute("currentSeasonName", currentSeasonName2); request.setAttribute("currentSeason", currentSeason2);
		 */

		///////////-시즌정보 가져오기 [s]-/////////////////////////////////////////
		String currentSeason1 = "";
		String currentSeasonName1 = "";
		String currentDispYn1 = "";
		String currentTopYn1 = "";
		int currentSeq1 = 0;

		String currentSeason2 = "";
		String currentSeasonName2 = "";
		String currentDispYn2 = "";
		String currentTopYn2 = "";
		int currentSeq2 = 0;

		String currentSeasonOutlet = "";
		String currentSeasonNameOutlet = "";
		String currentDispYnOutlet = "";
		int currentSeqOutlet = 0;

		if (request.getAttribute("siteNo") != null) {
			//			SeasonForm seasonForm = categoryService.getSeasonCategory((int)request.getAttribute("siteNo"));
			//			
			//			//시즌2 정보
			//			currentSeasonName1 = seasonForm.getCate1Season().getSeasonCdDisp();
			//			currentSeason1     = seasonForm.getCate1Season().getSeasonCd();
			//			currentDispYn1     = seasonForm.getCate1Season().getDispYn();
			//			currentSeq1        = seasonForm.getCate1Season().getSeasonSeq();
			//			currentTopYn1      = seasonForm.getCate1Season().getTopYn();
			//			
			//			//시즌2 정보
			//			currentSeasonName2 = seasonForm.getCate2Season().getSeasonCdDisp();
			//			currentSeason2     = seasonForm.getCate2Season().getSeasonCd();
			//			currentDispYn2     = seasonForm.getCate2Season().getDispYn();
			//			currentSeq2        = seasonForm.getCate2Season().getSeasonSeq();
			//			currentTopYn2      = seasonForm.getCate2Season().getTopYn();
			//			
			//			
			//			//outlet
			//			currentSeasonNameOutlet = seasonForm.getCateOutlet().getSeasonCdDisp();
			//			currentSeasonOutlet     = seasonForm.getCateOutlet().getSeasonCd();
			//			currentDispYnOutlet     = seasonForm.getCateOutlet().getDispYn();
			//			currentSeqOutlet        = seasonForm.getCateOutlet().getSeasonSeq();
		}

		request.setAttribute("preSeason", currentSeason1);
		request.setAttribute("preSeasonName", currentSeasonName1);
		request.setAttribute("preDispYn", currentDispYn1);
		request.setAttribute("preTopYn", currentTopYn1);
		request.setAttribute("preSeq", currentSeq1);

		request.setAttribute("currentSeason", currentSeason2);
		request.setAttribute("currentSeasonName", currentSeasonName2);
		request.setAttribute("currentDispYn", currentDispYn2);
		request.setAttribute("currentTopYn", currentTopYn2);
		request.setAttribute("currentSeq", currentSeq2);

		request.setAttribute("outletSeason", currentSeasonOutlet);
		request.setAttribute("outletSeasonName", currentSeasonNameOutlet);
		request.setAttribute("outletDispYn", currentDispYnOutlet);
		request.setAttribute("outletSeq", currentSeqOutlet);

		///////////-시즌정보 가져오기 [e]-/////////////////////////////////////////

		return super.preHandle(request, response, handler);
	}

	private static boolean checkingInjection(String value) {
		boolean result = true;
		if (value.toUpperCase().contains("SELECT"))
			result = false;
		if (value.toUpperCase().contains("UPDATE"))
			result = false;
		if (value.toUpperCase().contains("DELETE"))
			result = false;
		//		 if(value.toUpperCase().contains("INSERT")) result=false;
		//if(value.toUpperCase().contains("AND")) result=false;
		//		 if(value.toUpperCase().contains("TRIM")) result=false;
		//if(value.toUpperCase().contains("FALSE")) result=false;
		//if(value.toUpperCase().contains("TRUE")) result=false;
		//if(value.toUpperCase().contains("OR")) result=false;\
		if (value.toUpperCase().contains("<SCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</SCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("<JAVASCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</JAVASCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("</VBSCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("<VBSCRIPT>"))
			result = false;
		if (value.toUpperCase().contains("\\/*"))
			result = false;
		if (value.toUpperCase().contains("*\\/"))
			result = false;
		//if(value.toUpperCase().contains("--")) result=false;
		//		 if(value.toUpperCase().contains("/*")) result=false;
		//		 if(value.toUpperCase().contains("*/")) result=false;
		//		 if(value.toUpperCase().contains("!--")) result=false;
		//		 if(value.toUpperCase().contains("--!")) result=false;
		//		 if(value.toUpperCase().contains("\\(")) result=false;
		//		 if(value.toUpperCase().contains("\\)")) result=false;
		//if(value.toUpperCase().contains("%")) result=false;
		//if(value.toUpperCase().contains("=")) result=false;
		if (value.toUpperCase().contains("--!"))
			result = false;
		//if(value.toUpperCase().contains("+")) result=false;
		if (value.toUpperCase().contains("ALERT"))
			result = false;
		//if(value.toUpperCase().contains("SCRIPT")) result=false;
		//if(value.toUpperCase().contains("\'")) result=false;
		if (value.toUpperCase().contains("||"))
			result = false;
		//if(value.toUpperCase().contains("\"")) result=false;
		if (value.toUpperCase().contains("JAVASCRIPT"))
			result = false;
		if (value.toUpperCase().contains("--BEGIN_MARK_TAG--"))
			result = false;
		//if(value.toUpperCase().contains("1234")) result=false;
		if (value.toUpperCase().contains("../"))
			result = false;
		if (value.toUpperCase().contains("WFXSSPROBE"))
			result = false;
		if (value.toUpperCase().contains("PROBEPHISHING"))
			result = false;
		if (value.toUpperCase().contains("/USR/"))
			result = false;
		if (value.toUpperCase().contains("/BIN/"))
			result = false;
		if (value.toUpperCase().contains("$("))
			result = false;
		if (value.toUpperCase().contains("AVAK"))
			result = false;
		if (value.toUpperCase().contains("PROBE"))
			result = false;
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	}
}