package com.giftiel.shop.controller.admin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dto.Admin;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.SiteSetting;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.SettingService;
import com.giftiel.shop.utils.Seed;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/setting")
public class SettingController {
	protected Logger log = LoggerFactory.getLogger(SettingController.class);

	@Autowired
	private SettingService settingService;

	@Autowired
	private Seed sed;

	@Autowired
	CodeService codeService;

	@Value("${upload.image}")
	private String uploadImage;

	//부트스트랩용 메뉴 전역 flag
	@ModelAttribute("globalMenuFlag")
	public String returnMenuFlag() {
		return "setting";
		// request.setAttirubte("globalMenuFlag", "setting") 와 같으며
		// 선언된 클래스의 전역으로 실행된다.
	}

	/**
	 * 관리자 환경설정 인덱스 페이지
	 **/
	@RequestMapping(value = "/index")
	public ModelAndView selectIndexPage(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/setting");
		return mav;
	}

	/**
	 * 관리자 환경설정 - 상점환경설정 페이지
	 *
	 * @throws UnsupportedEncodingException
	 **/
	@RequestMapping(value = "/storeSetting")
	public ModelAndView selectStoreSettingPage(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("regFrm") Setting frm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//mav.addObject("admin_id", reqeust.getSession().getAttribute("admin_id"));

		Setting bean = new Setting();

		HashMap<Object, Object> temp = new HashMap<Object, Object>();
		List<Object> list = settingService.selectSuperAdmin();

		if (list != null && list.size() > 0) {
			temp = (HashMap) list.get(0);

			if (temp.get("ID") != null) {
				bean.setAdmin_id(temp.get("ID").toString());
			}
			if (temp.get("USER_NM") != null) {
				bean.setUser_name(temp.get("USER_NM").toString());
			}
			if (temp.get("EMAIL") != null) {
				bean.setEmail(sed.decrypt(temp.get("EMAIL").toString()));
			}
			if (temp.get("CMP_NM") != null) {
				bean.setCom_name(temp.get("CMP_NM").toString());
			}
			if (temp.get("REPR_NM") != null) {
				bean.setRepre_name(temp.get("REPR_NM").toString());
			}
			if (temp.get("PERSON_INFO_MNGR") != null) {
				bean.setInfo_name(temp.get("PERSON_INFO_MNGR").toString());
			}
			if (temp.get("PERSON_INFO_MNGR_EMAIL") != null) {
				bean.setInfo_email(sed.decrypt(temp.get("PERSON_INFO_MNGR_EMAIL").toString()));
			}
			if (temp.get("ZIP_CD") != null) {
				bean.setPost_no(temp.get("ZIP_CD").toString());
			}
			if (temp.get("ADDR") != null) {
				bean.setAddress(temp.get("ADDR").toString());
			}
			if (temp.get("DTL_ADDR") != null) {
				bean.setDtl_address(temp.get("DTL_ADDR").toString());
			}
			if (temp.get("TEL") != null) {
				bean.setTel_no(temp.get("TEL").toString());
			}
			if (temp.get("FAX_NO") != null) {
				bean.setFax_no(temp.get("FAX_NO").toString());
			}
			if (temp.get("BIZ_REG_NO") != null) {
				bean.setCom_no(temp.get("BIZ_REG_NO").toString());
			}
			if (temp.get("TELE_SALES_BIZ_REG_NO") != null) {
				bean.setBiz_reg_no(temp.get("TELE_SALES_BIZ_REG_NO").toString());
			}
			if (temp.get("BIZ_ST") != null) {
				bean.setBiz_st(temp.get("BIZ_ST").toString());
			}
			if (temp.get("EVENT") != null) {
				bean.setEvent(temp.get("EVENT").toString());
			}
		}
		mav.addObject("regFrm", bean);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/storeSetting");
		return mav;
	}

	/**
	 * 상점환경설정 저장
	 **/
	@RequestMapping(value = "/settingStoreSave", method = RequestMethod.POST)
	public @ResponseBody int storeSettingSave(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestBody Setting bean,
			Model model) throws IOException {

		//암호화
		bean.setPwd(sed.encrypt(bean.getPwd()));
		bean.setEmail(sed.encrypt(bean.getEmail()));
		bean.setInfo_email(sed.encrypt(bean.getInfo_email()));

		int successCnt = settingService.storeSettingSave(bean);

		//response.getWriter().print(successCnt);
		return successCnt;
	}

	/**
	 * 관리자 사이트 설정 인덱스 페이지
	 **/
	@RequestMapping(value = "/siteSetting")
	public ModelAndView siteSetting(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("setting") Setting setting) throws Exception {

		ModelAndView mav = new ModelAndView();
		//		Setting bean  = new Setting();

		//site 리스트
		List<Site> siteList = settingService.siteSettingList(setting);

		mav.addObject("siteList", siteList);
		mav.addObject("uploadImage", uploadImage);
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/siteSetting");
		return mav;
	}

	/**
	 * 사이트 설정 저장
	 **/
	@RequestMapping(value = "/settingSiteSave", method = RequestMethod.POST)
	public @ResponseBody int settingSiteSave(Locale locale, HttpServletRequest request, HttpServletResponse response, Model model,
			@ModelAttribute("setting") Setting setting) throws Exception {

		int successCnt = 0;

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		List<SiteSetting> siteSetting = setting.getSiteSetting();

		if (siteSetting != null) {
			for (int j = 0; j < siteSetting.size(); j++) {
				siteSetting.get(j).setRegr_no(admin.getUserNo().toString());
			}
		}
		setting.setSiteSetting(siteSetting);

		successCnt = settingService.siteSettingReg(setting);

		return successCnt;
	}

	/**
	 * 관리자 환경설정 인덱스 페이지
	 **/
	@RequestMapping(value = "/deliverySetting")
	public ModelAndView deliverySetting(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("regFrm") Setting frm) {
		ModelAndView mav = new ModelAndView();
		//Setting bean  = new Setting();

		Setting list = settingService.deliverySettingList();
		if (list != null) {
			mav.addObject("regFrm", list);
		} else {
			mav.addObject("regFrm", frm);
		}

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/deliverySetting");
		return mav;
	}

	/**
	 * 상점환경설정 저장
	 **/
	@RequestMapping(value = "/settingMallSave", method = RequestMethod.POST)
	public @ResponseBody int settingMallSave(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestBody Setting bean,
			Model model) throws IOException {

		int successCnt = 0;
		Setting list = settingService.deliverySettingList();
		if (list != null) {
			successCnt = settingService.deliverySettingSave(bean);
		} else {
			successCnt = settingService.deliverySettingInsert(bean);
		}

		return successCnt;
	}

	/**
	 * 관리자 환경설정 인덱스 페이지
	 **/
	@RequestMapping(value = "/memberSetting")
	public ModelAndView memberSetting(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		//Setting bean  = new Setting();

		List<Object> list = settingService.memberSettingList();
		mav.addObject("list", list);

		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/memberSetting");
		return mav;
	}

	/**
	 * 관리자 회원등급관리 등록 페이지
	 **/
	@RequestMapping(value = "/memberRegist")
	public ModelAndView memberRegist(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response,
			@ModelAttribute("regFrm") Setting frm) {
		ModelAndView mav = new ModelAndView();
		Setting bean = new Setting();
		bean.setRegFlag("");

		mav.addObject("search", bean);
		mav.setViewName("/admin/setting/memberRegist");
		return mav;
	}

	/**
	 * 관리자 회원등급관리 수정 페이지
	 **/
	@RequestMapping(value = "/memberModify")
	public ModelAndView memberModify(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("regFrm") Setting frm) {
		ModelAndView mav = new ModelAndView();
		Setting bean = new Setting();
		bean.setRegFlag("Y");
		bean.setGrd_no(request.getParameter("grd_no"));
		Setting list = settingService.memberLevelList(bean);

		if (list != null) {
			bean.setRegr_no(list.getRegr_no());
			bean.setReg_dts(list.getReg_dts());
			mav.addObject("regFrm", list);
		} else {
			mav.addObject("regFrm", bean);
		}
		//log.info(list.toString());
		mav.addObject("search", bean);
		mav.setViewName("/admin/setting/memberRegist");
		return mav;
	}

	@RequestMapping(value = "/memberGrdUpdate")
	public @ResponseBody int memberGrdUpdate(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestBody Setting bean) throws UnsupportedEncodingException {
		//ModelAndView mav = new ModelAndView();

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		bean.setRegr_no(admin.getRegrNo().toString());
		//		bean.setRegr_no(request.getSession().getAttribute("user_no").toString());
		//bean.setRegr_no("1");
		int val = settingService.memberGrdUpdate(bean);
		return val;
	}

	@RequestMapping(value = "/memberGrdInsert")
	public @ResponseBody int memberGrdInsert(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestBody Setting bean) throws UnsupportedEncodingException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		bean.setRegr_no(admin.getRegrNo().toString());
		//		bean.setRegr_no(request.getSession().getAttribute("user_no").toString());
		//bean.setRegr_no("1");
		int val = settingService.memberGrdInsert(bean);
		return val;
	}

	/**
	 * 관리자 로그인 성공시 메인으로 이동.
	 **/
	@RequestMapping(value = "/chkDupGrd")
	public void chkDupGrd(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("grd_nm") String grd_nm,
			@RequestParam("grd_no") String grd_no) throws IOException {
		String checkGrd = "";

		Setting bean = new Setting();
		if (grd_no != null && !"".equals(grd_no)) {
			bean.setGrd_no(grd_no);
		}
		bean.setGrd_nm(grd_nm);
		List<Object> list = settingService.memberGrdList(bean);

		if (list != null && list.size() > 0) {
			checkGrd = "1";
		} else {
			checkGrd = "2";
		}
		response.getWriter().print(checkGrd);
	}

	/**
	 * 관리자 로그인 성공시 메인으로 이동.
	 **/
	@RequestMapping(value = "/memberGrdDelete")
	public @ResponseBody int memberGrdDelete(Locale locale, Model model, HttpServletRequest request, HttpServletResponse esponse,
			@RequestBody Setting bean) throws IOException {

		//Setting bean = new Setting();
		//bean.setGrd_no(grd_no);
		int val = settingService.memberGrdDelete(bean);

		return val;
	}

	/**
	 * 관리자 회원등급관리 수정 페이지
	 **/
	@RequestMapping(value = "/pointSetting")
	public ModelAndView pointSetting(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("regFrm") Setting frm) {
		ModelAndView mav = new ModelAndView();
		Setting bean = new Setting();
		Setting list = settingService.pointSettingList();
		if (list != null) {
			mav.addObject("regFrm", list);
		} else {
			mav.addObject("regFrm", bean);
		}
		mav.setViewName("/admin" + Constants.MODE_ADMIN + "/setting/pointSetting");
		return mav;
	}

	/**
	 * 포인트 설정 저장
	 **/
	@RequestMapping(value = "/pointSettingSave", method = RequestMethod.POST)
	public @ResponseBody int pointSettingSave(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestBody Setting bean,
			Model model) throws IOException {

		int successCnt = 0;
		Setting list = settingService.pointSettingList();

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		bean.setRegr_no(admin.getRegrNo().toString());

		//		bean.setRegr_no(request.getSession().getAttribute("user_no").toString());

		if (list != null) {
			successCnt = settingService.pointSettingSave(bean);
		} else {
			successCnt = settingService.pointSettingInsert(bean);
		}
		return successCnt;
	}

	/**
	 * 백오피스 상점운영정책 목록
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/storeManage")
	public ModelAndView selectTableList(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") Setting searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		//site 리스트
		List<Site> siteList = codeService.getSiteList();

		if (searchForm.getSite_no() == null || "".equals(searchForm.getSite_no())) {
			searchForm.setSite_no("10001"); //WORKSOUT 브랜드 목록
		}
		List<Setting> list = settingService.storeManageList(searchForm);

		//view 전달객체 셋팅
		mav.addObject("siteList", siteList);
		mav.addObject("list", list);
		//mav.addObject("searchForm", searchForm);

		mav.setViewName("/admin/setting/storeManage");
		return mav;
	}

	/**
	 * 백오피스 상점운영정책 등록 페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/storeWrite")
	public ModelAndView storeWrite(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") Setting searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		mav.addObject("searchForm", searchForm);

		mav.setViewName("/admin/setting/storeWrite");
		return mav;
	}

	/**
	 * 백오피스 상점운영정책 수정 페이지
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/storeUpdate")
	public ModelAndView storeUpdate(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchForm") Setting searchForm) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();

		Setting list = settingService.storeManageSelect(searchForm);
		if (list != null) {
			list.setRegFlag(searchForm.getRegFlag());
			mav.addObject("searchForm", list);
		} else {
			mav.addObject("searchForm", searchForm);
		}

		mav.setViewName("/admin/setting/storeWrite");
		return mav;
	}

	/**
	 * 백오피스 상점운영정책 수정
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/storeMngUpdate")
	public @ResponseBody int storeMngUpdate(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestBody Setting bean,
			Model model) throws IOException {
		Admin admin = (Admin) request.getSession().getAttribute("admin");

		bean.setRegr_no(admin.getRegrNo().toString());
		//		bean.setRegr_no(request.getSession().getAttribute("user_no").toString());

		int successCnt = settingService.storeMngSave(bean);
		return successCnt;
	}

	/**
	 * 백오피스 상점운영정책 등록
	 *
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @param searchForm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/storeMngInsert")
	public @ResponseBody int storeMngInsert(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestBody Setting bean,
			Model model) throws IOException {

		Admin admin = (Admin) request.getSession().getAttribute("admin");

		bean.setRegr_no(admin.getRegrNo().toString());
		//		bean.setRegr_no(request.getSession().getAttribute("user_no").toString());

		int successCnt = settingService.storeMngInsert(bean);
		return successCnt;
	}
}