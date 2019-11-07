package com.giftiel.shop.controller.front;

import java.io.IOException;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.giftiel.shop.common.SMSSend;
import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.StatisticsForm;
import com.giftiel.shop.service.MemberService;
import com.giftiel.shop.utils.Seed;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/front")
public class FrontLoginController extends FrontController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Seed seed;
	@Value("${server.contextPath}")
	private String contextPath;
	@Autowired
	private SMSSend smsSend;

	/**
	 * 회원 로그인 요청
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param email
	 * @param pwd
	 * @throws IOException
	 */
	@RequestMapping(value = "/login")
	public void login(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("email") String email,
			@RequestParam("pwd") String pwd) throws IOException {

		SearchForm searchForm = new SearchForm();
		searchForm.setEmail(email);

		Member member = memberService.selectMemInfo(searchForm);

		String result = "";

		if (member != null) {
			if (StringUtils.equals(member.getWdrwYn(), "Y")) {
				result = "2";
			} else if (seed.encrypt(pwd).equals(member.getPwd())) {
				request.getSession().invalidate();
				request.getSession().setAttribute("member", member);
				request.getSession().setMaxInactiveInterval(43200); // 세션 24시간 임시셋팅

				StatisticsForm statisticsForm = (StatisticsForm) request.getAttribute("connInfo");
				statisticsForm.setMemNo(member.getMemNo());
				memberService.setLoginHist(statisticsForm);

				result = "0";
			} else {
				result = "1";
			}
		} else {
			result = "1";
		}

		response.getWriter().print(result);
	}

	/**
	 * 회원 로그아웃
	 *
	 * @throws IOException
	 **/
	@RequestMapping(value = "/logout")
	public void logout(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, SessionStatus sessionStatus)
			throws IOException {
		request.getSession().removeAttribute("member");
		response.sendRedirect(contextPath + "/front/main");
		//response.sendRedirect(request.getHeader("referer"));
	}

	/**
	 * 인증절차[아이디찾기]
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param email
	 * @param pwd
	 * @throws IOException
	 */
	@RequestMapping(value = "/idChecking")
	public void idChecking(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("nm") String nm,
			@RequestParam("cpNo") String cpNo) throws IOException {

		SearchForm searchForm = new SearchForm();
		searchForm.setNm(nm);
		searchForm.setCpNo(cpNo);

		Member member = memberService.selectMemInfo(searchForm);

		Random oRandom = new Random();
		String certNumber = oRandom.nextInt(10) + "" + oRandom.nextInt(10) + "" + oRandom.nextInt(10) + "" + oRandom.nextInt(10) + ""
				+ oRandom.nextInt(10) + "" + oRandom.nextInt(10);
		String result = "";
		if (member != null) {
			smsSend.sendSMS(27, cpNo, getSiteDesc(request), nm, certNumber, 0);
			result = "0," + certNumber + "," + member.getEmail();
		} else {
			result = "1," + certNumber + ",,";
		}
		response.getWriter().print(result);
	}

	/**
	 * 인증절차[아이디찾기]
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param email
	 * @param pwd
	 * @throws IOException
	 */
	@RequestMapping(value = "/passChecking")
	public void idChecking(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("nm") String nm,
			@RequestParam("cpNo") String cpNo, @RequestParam("email") String email) throws IOException {

		SearchForm searchForm = new SearchForm();
		searchForm.setNm(nm);
		searchForm.setEmail(email);
		searchForm.setCpNo(cpNo);

		Member member = memberService.selectMemInfo(searchForm);

		Random oRandom = new Random();
		String certNumber = oRandom.nextInt(10) + "" + oRandom.nextInt(10) + "" + oRandom.nextInt(10) + "" + oRandom.nextInt(10) + ""
				+ oRandom.nextInt(10) + "" + oRandom.nextInt(10);
		String result = "";
		if (member != null) {
			smsSend.sendSMS(27, cpNo, getSiteDesc(request), nm, certNumber, 0);
			result = "0," + certNumber;
		} else {
			result = "1," + certNumber;
		}
		response.getWriter().print(result);
	}

	@RequestMapping(value = "/changePass")
	public void changePass(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("pass") String pass,
			@RequestParam("email") String email) throws IOException {

		Member member = new Member();
		SearchForm searchForm = new SearchForm();
		searchForm.setEmail(email);
		member = memberService.selectMemInfo(searchForm);

		MemInfo changeMember = new MemInfo();
		changeMember.setMemNo(member.getMemNo());
		changeMember.setPwd(seed.encrypt(pass));

		int result = memberService.changeMemberInfo(changeMember);
		if (result > 0) {
			result = 0;
		} else {
			result = 1;
		}
		response.getWriter().print(result + "");
	}
}
