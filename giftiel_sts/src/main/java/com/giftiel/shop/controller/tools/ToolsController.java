package com.giftiel.shop.controller.tools;

import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Table;
import com.giftiel.shop.service.CodeService;
import com.giftiel.shop.service.UtilsService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/tools")
public class ToolsController {

	@Autowired
	private UtilsService utilsService;
	@Autowired
	private CodeService codeService;
	
	private static final Logger logger = LoggerFactory.getLogger(ToolsController.class);
	
	@RequestMapping(value = "/selectTableList", method = RequestMethod.GET)
	public ModelAndView selectTableList(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		List<Table> table = utilsService.selectTableList();
		model.addAttribute("tableList", table);
		mav.setViewName("/tools/tables");
		return mav;
	}
	
	@RequestMapping(value = "/classCreate", method = RequestMethod.GET)
	public ModelAndView classCreate(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		Table table = new Table();
		table.setTableName(reqeust.getParameter("tableName"));
		
		List<Table> result = utilsService.selectColumnList(table);
		model.addAttribute("selectColumnList", result);
		model.addAttribute("tableName", reqeust.getParameter("tableName"));
		mav.setViewName("/tools/classCreate");
		return mav;
	}	
	
	@RequestMapping(value = "/sqlCreate", method = RequestMethod.GET)
	public ModelAndView sqlCreate(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		Table table = new Table();
		table.setTableName(reqeust.getParameter("tableName"));
		
		List<Table> result = utilsService.selectColumnList(table);
		model.addAttribute("selectColumnList", result);
		model.addAttribute("tableName", reqeust.getParameter("tableName"));
		mav.setViewName("/tools/sqlCreate");
		return mav;
	}	
	
	/**
	 * 코드 추가기능만 있음.
	 * @param locale
	 * @param model
	 * @param reqeust
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insertCode", method = RequestMethod.GET)
	public ModelAndView insertCode(Locale locale, Model model, HttpServletRequest reqeust, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		Code code = new Code();
			code.setCdNo("OR00204");         //코드번호 
			code.setSupCdNo("OR002");         //상위코드번호 
			code.setCdNm("주문취소");         //코드명 
			code.setCdDesc("주문상태 - 주문취소");         //코드설명 
			code.setCdTp("AD00202");         //코드유형 AD00201:그룹 AD00201:항목 
			code.setWrkClsCd("OR");         //업무분류코드 
			code.setPrir(0);         //우선순위 
			code.setUseYn("Y");         //사용여부 
			code.setRegrNo(0);         //등록자 
			code.setRegDts(new Date());         //등록일시
		
		//codeService.insertCd(code); //사용할때만 활성
		return mav;
	}		
}
