<%--
 * =============================================================================
 * 파일명 : /front/order/orderPay.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-29
 *
 * 파일 내용 : order > 주문데이터 init, pg호출
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<%
	/* ============================================================================== */
	/* =   PAGE : 에스크로 구매확인 후 취소 요청 및 결과 처리 PAGE                  = */
	/* = -------------------------------------------------------------------------- = */
	/* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
	/* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do                    = */
	/* = -------------------------------------------------------------------------- = */
	/* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
	/* ============================================================================== */

	/* ============================================================================== */
	/* =   환경 설정 파일 Include                                                   = */
	/* = -------------------------------------------------------------------------- = */
	/* =   ※ 필수                                                                  = */
	/* =   테스트 및 실결제 연동시 site_conf_inc.asp파일을 수정하시기 바랍니다.     = */
	/* = -------------------------------------------------------------------------- = */
%>
<%@ page import="com.kcp.*"%>
<%@ page import="com.giftiel.shop.dao.*"%>
<%@ page import="com.giftiel.shop.dto.*"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="site_conf_inc.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

	WebApplicationContext wac = WebApplicationContextUtils
			.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
	OrderDao orderDao = (OrderDao) wac.getBean("orderDao");
	PointDao pointDao = (PointDao) wac.getBean("pointDao");

	String ordNo = request.getParameter("ordNo");

	Integer ordGdsSeq = 0;
	if (request.getParameter("ordGdsSeq") != "") {
		ordGdsSeq = Integer.parseInt(request.getParameter("ordGdsSeq"));
	}

	SearchForm searchForm = new SearchForm();
	searchForm.setOrdNo(ordNo);
	Order order = orderDao.selectOrder(searchForm);

	//기본값 셋팅
%>
<%!/* ============================================================================== */
	/* =   null 값을 처리하는 메소드                                                = */
	/* = -------------------------------------------------------------------------- = */
	public String f_get_parm(String val) {
		if (val == null)
			val = "";
		return val;
	}
	/* ------------------------------------------------------------------------------ */
	/* =   null 값을 처리하는 메소드 END                                            = */
	/* ============================================================================== */%>
<%
	/* ============================================================================== */
	/* =   POST 형식 체크부분                                                       = */
	/* = -------------------------------------------------------------------------- = */
	if (request.getMethod() != "POST") {
		out.println("잘못된 경로로 접속하였습니다.");
		return;
	}
	/* ============================================================================== */
%>
<%
	/* ============================================================================== */
	/* =   02. 지불 요청 정보 설정                                                  = */
	/* = -------------------------------------------------------------------------- = */
	String req_tx = "mod_escrow"; // 요청종류

	String cust_ip = f_get_parm(request.getRemoteAddr()); // 요청 IP
	String tran_cd = "";
	String res_cd = ""; // 응답코드
	String res_msg = ""; // 응답메시지
	/* ============================================================================== */

	String mod_type = ""; // 변경수단

	String tno = order.getKcpHist().get(0).getTno(); // 거래번호
	String mod_desc = "주문취소"; // 취소사유
	String mod_depositor = f_get_parm(request.getParameter("mod_depositor")); // 환불계좌주명(환불시에만 사용)
	String mod_account = f_get_parm(request.getParameter("mod_account")); // 환불계좌번호(환불시에만 사용)
	String mod_bankcode = f_get_parm(request.getParameter("mod_bankcode")); // 환불은행코드(환불시에만 사용)
	String mod_sub_type = f_get_parm(request.getParameter("mod_sub_type")); // 취소상세구분
	String sub_mod_type = f_get_parm(request.getParameter("sub_mod_type")); // 취소유형
	/* ============================================================================== */
	String vcnt_yn = "N"; // 상태변경시 계좌이체, 가상계좌 여부
	/* = -------------------------------------------------------------------------- = */
	String y_rem_mny = f_get_parm(request.getParameter("rem_mny")); // 환불 가능 금액
	String y_mod_mny = f_get_parm(request.getParameter("mod_mny")); // 환불 금액
	String y_tax_mny = f_get_parm(request.getParameter("tax_mny")); // 부분취소 과세금액
	String y_free_mod_mny = f_get_parm(request.getParameter("free_mod_mny")); // 부분취소 비과세금액
	String y_add_tax_mny = f_get_parm(request.getParameter("add_tax_mny")); // 부분취소 부과세 금액
	String y_refund_account = f_get_parm(request.getParameter("a_refund_account")); // 환불계좌번호
	String y_refund_nm = f_get_parm(request.getParameter("a_refund_nm")); // 환불계좌주명
	String y_bank_code = f_get_parm(request.getParameter("a_bank_code")); // 은행코드
	String y_mod_desc_cd = f_get_parm(request.getParameter("mod_desc_cd")); // 취소구분
	String y_mod_desc = f_get_parm(request.getParameter("mod_desc")); // 취소사유

	y_mod_desc_cd = "CA06";
	y_mod_desc = "주문취소";
	//입금대기중 취소
	if ("OR00202".equals(order.getOrdStat())) {
		mod_type = "STE5"; //발급계좌 해지
	} else if ("OR00203".equals(order.getOrdStat())) {
		if ("OR00802".equals(order.getOrderPay().get(0).getPayWay())) { //실시간계좌이체
			vcnt_yn = "Y";
			//환불정보 임시
			mod_bankcode = "03";
			mod_account = "143124124";
			mod_depositor = "권용재";
		} else if ("OR00803".equals(order.getOrderPay().get(0).getPayWay())) { //가상계좌
			vcnt_yn = "Y";
			//환불정보 임시
			mod_bankcode = "03";
			mod_account = "143124124";
			mod_depositor = "권용재";
		}
		mod_type = "STE2"; //즉시취소 : 발송전 취소
	}

	/*     if("OR00801".equals(order.getOrderPay().get(0).getPayWay())){ //신용카드
	    	req_tx = "mod";
	    }else if("OR00802".equals(order.getOrderPay().get(0).getPayWay())){ //실시간계좌이체 
	    	req_tx = "mod_escrow";
	    }else if("OR00803".equals(order.getOrderPay().get(0).getPayWay())){ //가상계좌
	    	req_tx = "mod_escrow";
	    } */

	/* = -------------------------------------------------------------------------- = */
	/* =   01. 지불 요청 정보 설정 END                                              = */
	/* ============================================================================== */

	out.println("req_tx====" + req_tx);
	out.println("<br/>mod_type====" + mod_type);
	out.println("<br/>tno====" + tno);
	/* ============================================================================== */
	/* =   02. 인스턴스 생성 및 초기화(변경 불가)                                   = */
	/* = -------------------------------------------------------------------------- = */
	/* =   결제에 필요한 인스턴스를 생성하고 초기화 합니다.                         = */
	/* =   ※ 주의 ※ 이 부분은 변경하지 마십시오                                   = */
	/* = -------------------------------------------------------------------------- = */

	C_PP_CLI c_PayPlus = new C_PP_CLI();

	c_PayPlus.mf_init(g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_key_dir, g_conf_log_dir,
			g_conf_tx_mode);
	c_PayPlus.mf_init_set();

	/* = -------------------------------------------------------------------------- = */
	/* =   02. 인스턴스 생성 및 초기화 END                                          = */
	/* ============================================================================== */

	/* ============================================================================== */
	/* =   03. 처리 요청 정보 설정                                                  = */
	/* = -------------------------------------------------------------------------- = */
	/* = -------------------------------------------------------------------------- = */
	/* =   03-1. 에스크로 상태변경 요청                                             = */
	/* = -------------------------------------------------------------------------- = */
	if (req_tx.equals("mod_escrow")) {
		int mod_data_set_no;

		mod_data_set_no = c_PayPlus.mf_add_set("mod_data");
		c_PayPlus.mf_set_us(mod_data_set_no, "tno", tno); // KCP 원거래 거래번호
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_ip", cust_ip); // 변경 요청자 IP
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_desc", mod_desc); // 변경 사유

		if (mod_type.equals("STE9_C") || mod_type.equals("STE9_CP") || mod_type.equals("STE9_A")
				|| mod_type.equals("STE9_AP") || mod_type.equals("STE9_AR") || mod_type.equals("STE9_V")
				|| mod_type.equals("STE9_VP")) {
			tran_cd = "70200200";
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_type", "STE9");
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_desc_cd", y_mod_desc_cd);
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_desc", y_mod_desc);

			if (mod_type.equals("STE9_C")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STSC");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC03");
			} else if (mod_type.equals("STE9_CP")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STPC");
				c_PayPlus.mf_set_us(mod_data_set_no, "part_canc_yn", "Y");
				c_PayPlus.mf_set_us(mod_data_set_no, "rem_mny", y_rem_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "amount", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC03");
				//c_PayPlus.mf_set_us( mod_data_set_no, "tax_flag"        , "TG03"            ); // 복합과세 부분취소
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_tax_mny"     , y_tax_mny         ); // 공급가 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_free_mny"    , y_free_mod_mny    ); // 비과세 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_vat_mny"     , y_add_tax_mny     ); // 부가세 부분취소 금액
			} else if (mod_type.equals("STE9_A")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STSC");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC03");
			} else if (mod_type.equals("STE9_AP")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STPC");
				c_PayPlus.mf_set_us(mod_data_set_no, "part_canc_yn", "Y");
				c_PayPlus.mf_set_us(mod_data_set_no, "rem_mny", y_rem_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "amount", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC04");
				//c_PayPlus.mf_set_us( mod_data_set_no, "tax_flag"        , "TG03"            ); // 복합과세 부분취소
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_tax_mny"     , y_tax_mny         ); // 공급가 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_free_mny"    , y_free_mod_mny    ); // 비과세 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_vat_mny"     , y_add_tax_mny     ); // 부가세 부분취소 금액
			} else if (mod_type.equals("STE9_AR")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STHD");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC04");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_bankcode", y_bank_code);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_account", y_refund_account);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_depositor", y_refund_nm);
			} else if (mod_type.equals("STE9_V")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STHD");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC00");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_bankcode", y_bank_code);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_account", y_refund_account);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_depositor", y_refund_nm);
			} else if (mod_type.equals("STE9_VP")) {
				c_PayPlus.mf_set_us(mod_data_set_no, "sub_mod_type", "STPD");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny", y_mod_mny);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_sub_type", "MDSC04");
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_bankcode", y_bank_code);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_account", y_refund_account);
				c_PayPlus.mf_set_us(mod_data_set_no, "mod_depositor", y_refund_nm);
				//c_PayPlus.mf_set_us( mod_data_set_no, "tax_flag"        , "TG03"            ); // 복합과세 부분취소
				//c_PayPlus.mf_set_us( mod_data_set_no, "rem_mny"         , y_rem_mny         ); // 공급가 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_tax_mny"     , y_tax_mny         ); // 비과세 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_free_mny"    , y_free_mod_mny    ); // 부가세 부분취소 금액
				//c_PayPlus.mf_set_us( mod_data_set_no, "mod_vat_mny"     , y_add_tax_mny     );
				c_PayPlus.mf_set_us(mod_data_set_no, "part_canc_yn", "Y");
			}
		} else {
			tran_cd = "00200000";

			c_PayPlus.mf_set_us(mod_data_set_no, "mod_type", mod_type); // 원거래 변경 요청 종류

			if (mod_type.equals("STE1")) // 상태변경 타입이 [배송요청]인 경우
			{
				c_PayPlus.mf_set_us(mod_data_set_no, "deli_numb", request.getParameter("deli_numb")); // 운송장 번호
				c_PayPlus.mf_set_us(mod_data_set_no, "deli_corp", request.getParameter("deli_corp")); // 택배 업체명
			}
			if (mod_type.equals("STE2") || mod_type.equals("STE4")) // 상태변경 타입이 [즉시취소] 또는 [취소]인 계좌이체, 가상계좌의 경우
			{
				if (vcnt_yn.equals("Y")) {
					c_PayPlus.mf_set_us(mod_data_set_no, "refund_account", mod_account); // 환불수취계좌번호
					c_PayPlus.mf_set_us(mod_data_set_no, "refund_nm", mod_depositor); // 환불수취계좌주명
					//c_PayPlus.mf_set_us( mod_data_set_no, "bank_code",      bank_code      );  // 환불수취은행코드
				}
			}
		}
	}
	/* = -------------------------------------------------------------------------- = */
	/* =   03. 에스크로 상태변경 요청 END                                           = */
	/* ============================================================================== */

	/* ============================================================================== */
	/* =   04. 실행                                                                 = */
	/* = -------------------------------------------------------------------------- = */
	if (tran_cd.length() > 0) {
		c_PayPlus.mf_do_tx(g_conf_site_cd, g_conf_site_key, tran_cd, "", "", g_conf_log_level, "0");

		res_cd = c_PayPlus.m_res_cd; // 결과 코드
		res_msg = c_PayPlus.m_res_msg; // 결과 메시지
	}

	else {
		c_PayPlus.m_res_cd = "9562";
		c_PayPlus.m_res_msg = "연동 오류|tran_cd값이 설정되지 않았습니다.";
	}

	/* = -------------------------------------------------------------------------- = */
	/* =   04. 실행 END                                                             = */
	/* ============================================================================== */

	/* ================================================================================== */
	/* =   05.구매확인 후 취소 성공 결과 처리                                           = */
	/* = ------------------------------------------------------------------------------ = */
	if (req_tx.equals("mod")) {
		if (res_cd.equals("0000")) {
		} // End of [res_cd = "0000"]

		/* = -------------------------------------------------------------------------- = */
		/* =   05.구매확인 후 취소 실패 결과 처리                                       = */
		/* = -------------------------------------------------------------------------- = */
		else {
		}
	} else if (req_tx.equals("mod_escrow")) { // End of Proces
		if (res_cd.equals("0000")) {
			//공통 생성자
			Order orderResult = new Order();
			orderResult.setOrdNo(order.getOrdNo());
			orderResult.setUpdrNo(99999999); //수정자

			OrderPay OrderPayResult = new OrderPay();
			OrderPayResult.setOrdNo(order.getOrdNo());
			OrderPayResult.setUpdrNo(99999999); //수정자
			//가상계좌 발급해지
			if ("STE5".equals(mod_type)) {
				orderResult.setOrdStat("OR00204");
				orderResult.setPerOrdStat("OR00507");
				OrderPayResult.setPayStat("OR00904");
			}

			//주문상태 수정
			orderDao.updateOrdr(orderResult);
			//주문개별상태 수정
			orderDao.updateOrdStat2(orderResult);
			//주문결제 상태
			orderDao.updateOrdPay(OrderPayResult);
		}
	}
	///* ============================================================================== */
	///* =   05. 폼 구성 및 결과페이지 호출                                           = */
	///* = -------------------------------------------------------------------------- = */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>*** KCP [AX-HUB Version] ***</title>
<script type="text/javascript">
	function goResult() {
		document.mod_info.submit();
		openwin.close();
	}

	// 결제 중 새로고침 방지 샘플 스크립트
	function noRefresh() {
		/* CTRL + N키 막음. */
		if ((event.keyCode == 78) && (event.ctrlKey == true)) {
			event.keyCode = 0;
			return false;
		}
		/* F5 번키 막음. */
		if (event.keyCode == 116) {
			event.keyCode = 0;
			return false;
		}
	}
	document.onkeydown = noRefresh;
</script>
</head>

<br /><%=res_cd%>
<br /><%=res_msg%>
</body>
</html>
