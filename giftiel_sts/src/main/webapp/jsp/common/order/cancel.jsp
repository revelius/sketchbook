<%--
 * =============================================================================
 * 파일명 : /front/order/cancel.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-29
 *
 * 파일 내용 : order > 에스크로 제외 주문취소
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%
    /* ============================================================================== */
    /* =   PAGE : 지불 요청 및 결과 처리 PAGE                                       = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */

    /* ============================================================================== */ 
    /* =   POST 형식 체크부분                                                       = */ 
    /* = -------------------------------------------------------------------------- = */ 
    if ( request.getMethod() != "POST" ) 
    {
        //out.println("잘못된 경로로 접속하였습니다.");
        //return;
    }
    /* ============================================================================== */ 
%>
<%
    /* ============================================================================== */
    /* =   환경 설정 파일 Include                                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 필수                                                                  = */
    /* =   테스트 및 실결제 연동시 site_conf_inc.jsp파일을 수정하시기 바랍니다.     = */
    /* = -------------------------------------------------------------------------- = */
%>
	<%@ page import="com.kcp.*" %>
	<%@ page import="com.giftiel.shop.dao.*" %>
	<%@ page import="com.giftiel.shop.dto.*" %>
	<%@ page import="com.giftiel.shop.common.*" %>
	<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
	<%@ page import="org.springframework.web.context.WebApplicationContext" %>
	<%@ page import="java.net.URLEncoder"%>
	<%@ page import="java.util.HashMap"%>
	<%@ include file="/jsp/common/order/site_conf_inc.jsp"%>
<%
	WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
	OrderDao orderDao = (OrderDao)wac.getBean("orderDao");
	PointDao pointDao = (PointDao)wac.getBean("pointDao");
	SMSSend smsSend = (SMSSend)wac.getBean("SMSSend");
	MailSend mailSend = (MailSend)wac.getBean("MailSend");
	
	String ordNo = request.getParameter("ordNo");
	String payWay = request.getParameter("payWay");
	String perOrdStat = request.getParameter("perOrdStat");
	
	Integer ordGdsSeq = 0;
	if(request.getParameter("ordGdsSeq") != ""){
		ordGdsSeq = Integer.parseInt(request.getParameter("ordGdsSeq"));
	}
	
	String dlvCls = "";
	if(request.getParameter("dlvCls") != null){
		dlvCls = request.getParameter("dlvCls");
	}	
	
	SearchForm searchForm = new SearchForm();
	searchForm.setOrdNo(ordNo);
	Order order = orderDao.selectOrder(searchForm);
	
	Integer cancelAmt = 0;
	cancelAmt = order.getOrderPay().get(0).getPayAmt();
	
	//적립된 적립금 회수
	Integer returnRsvPnt = 0;
	for (int i = 0; i < order.getOrderGoods().size(); i++) {
		if(ordGdsSeq > 0){
			if(ordGdsSeq.equals(order.getOrderGoods().get(i).getOrdGdsSeq())){
				returnRsvPnt = returnRsvPnt + order.getOrderGoods().get(i).getExpPnt();
			}			
		}else{
			returnRsvPnt = returnRsvPnt + order.getOrderGoods().get(i).getExpPnt();
		}
	}
	


	int orderGdsSeq = 0;
	boolean halfFlag = true;
	
	for (int i = 0; i < order.getOrderGoods().size(); i++) {
		if(ordGdsSeq.equals(order.getOrderGoods().get(i).getOrdGdsSeq())){
			orderGdsSeq = i;
			if(halfFlag){
				cancelAmt = order.getOrderGoods().get(i).getActlPayPrc();
			}		
		}
	}	
	
	if("true".equals(dlvCls)){
		cancelAmt = cancelAmt + order.getOrderDelivery().get(0).getOrderDlvCsts().get(0).getActlDlvCst();
	}	
%>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   환경 설정 파일 Include END                                               = */
    /* ============================================================================== */
%>

<%!
    /* ============================================================================== */
    /* =   null 값을 처리하는 메소드                                                = */
    /* = -------------------------------------------------------------------------- = */
        public String f_get_parm( String val )
        {
          if ( val == null ) val = "";
          return  val;
        }
    /* ============================================================================== */
%>
<%
    request.setCharacterEncoding ( "euc-kr" ) ;
    /* ============================================================================== */
    /* =   02. 지불 요청 정보 설정                                                  = */
    /* = -------------------------------------------------------------------------- = */
    String req_tx         = "";                                                     // 취소요청
    String tran_cd        = "";                                                     // 업무코드
    String cust_ip        = f_get_parm( request.getRemoteAddr()                  ); // 요청 IP
    /* = -------------------------------------------------------------------------- = */
    String res_cd         = "";                                                     // 응답코드
    String res_msg        = "";                                                     // 응답 메세지
    String tno            = order.getKcpHist().get(0).getTno(); 					// 거래번호
    /* = -------------------------------------------------------------------------- = */
    String mod_type          = f_get_parm( request.getParameter( "modType"    ) ); // 변경수단
    if("STE9_CP".equals(mod_type)){
    	mod_type = "STPC";
    }
    String mod_desc       = "";                                                     // 변경사유
    String panc_mod_mny   = "";              // 부분취소 금액
    String panc_rem_mny   = "";              // 부분취소 가능 금액
    String mod_tax_mny    = "";                                                     // 공급가 부분 취소 요청 금액
    String mod_vat_mny    = "";                                                     // 부과세 부분 취소 요청 금액
    String mod_free_mny   = "";                                                     // 비과세 부분 취소 요청 금액
    /* ============================================================================== */
    /* =   02. 지불 요청 정보 설정 END                                              = */
    /* ============================================================================== */
		
    

    /* ============================================================================== */
    /* =   03. 인스턴스 생성 및 초기화(변경 불가)                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =       결제에 필요한 인스턴스를 생성하고 초기화 합니다.                     = */
    /* = -------------------------------------------------------------------------- = */

    //윈도우
    //C_PP_CLI c_PayPlus = new C_PP_CLI();
    //c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_key_dir, g_conf_log_dir, g_conf_tx_mode );
    //c_PayPlus.mf_init_set();

    C_PP_CLI_T c_PayPlus = new C_PP_CLI_T();
    c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode );
    c_PayPlus.mf_init_set();
    
    /*
    윈도우버전과 유닉스 버전은 샘플이 다르기 때문에 반드시 OS별 샘플을 구분하여 다운로드하시기 바랍니다. 
    Windows 의 경우 : pp_cli_exe.exe 파일 이용
    UNIX 계열의 경우 : pp_cli 파일 이용

    pp_ax_hub 페이지에서 mf_init 하는 인자값 개수 상이
    // Unix / Linux Platform
    c_PayPlus.mf_init( home_dir, gw_url, gw_port, tx_mode );
    // Windows Platform
    c_PayPlus.mf_init( home_dir, gw_url, gw_port, key_dir, log_dir, tx_mode );
    */

    /* ============================================================================== */
    /* =   03. 인스턴스 생성 및 초기화 END                                          = */
    /* ============================================================================== */


    /* ============================================================================== */
    /* =   04. 처리 요청 정보 설정                                                  = */
    /* = -------------------------------------------------------------------------- = */

    /* = -------------------------------------------------------------------------- = */
    /* =   04-1. 취소/매입 요청                                                     = */
    /* = -------------------------------------------------------------------------- = */
    if ( req_tx.equals( "" ) )
    {
        int    mod_data_set_no;

        tran_cd = "00200000";
        mod_data_set_no = c_PayPlus.mf_add_set( "mod_data" );

        c_PayPlus.mf_set_us( mod_data_set_no, "tno",        tno          ); // KCP 원거래 거래번호
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_type",   mod_type      ); // 전체취소 STSC / 부분취소 STPC 
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",     cust_ip     ); // 변경 요청자 IP
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc",   ""          ); // 변경 사유

        if ( mod_type.equals( "STPC" ) ) // 부분취소의 경우
        {
            c_PayPlus.mf_set_us( mod_data_set_no, "mod_mny", cancelAmt+"" ); // 취소요청금액
            c_PayPlus.mf_set_us( mod_data_set_no, "rem_mny", order.getOrderPay().get(0).getPayAmt()-order.getOrderPay().get(0).getCnclAmt()+"" ); // 취소가능잔액
			
            //복합거래 부분 취소시 주석을 풀어 주시기 바랍니다.
            //c_PayPlus.mf_set_us( mod_data_set_no, "tax_flag",     "TG03"                       ); // 복합과세 구분
            //c_PayPlus.mf_set_us( mod_data_set_no, "mod_tax_mny",  mod_tax_mny                  ); // 공급가 부분 취소 요청 금액
            //c_PayPlus.mf_set_us( mod_data_set_no, "mod_vat_mny",  mod_vat_mny                  ); // 부과세 부분 취소 요청 금액
            //c_PayPlus.mf_set_us( mod_data_set_no, "mod_free_mny", mod_free_mny                 ); // 비과세 부분 취소 요청 금액
        }
    }
    /* = -------------------------------------------------------------------------- = */
    /* =   04. 처리 요청 정보 설정 END                                              = */
    /* = ========================================================================== = */


    /* = ========================================================================== = */
    /* =   05. 실행                                                                 = */
    /* = -------------------------------------------------------------------------- = */
    if ( tran_cd.length() > 0 )
    {
        //c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", "", g_conf_log_level, "0" );
        
        c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", "", g_conf_log_level, "0", g_conf_log_path );

        res_cd  = c_PayPlus.m_res_cd;  // 결과 코드
        res_msg = c_PayPlus.m_res_msg; // 결과 메시지
    }
    else
    {
        c_PayPlus.m_res_cd  = "9562";
        c_PayPlus.m_res_msg = "연동 오류";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   05. 실행 END                                                             = */
    /* ============================================================================== */
	if ( res_cd.equals( "0000" ) ) // 정상결제 인 경우
    {
    	Order orderResult = new Order();
    	orderResult.setOrdNo(order.getOrdNo());
   		orderResult.setUpdrNo(99999999); //수정자
    	
    	OrderPay OrderPayResult = new OrderPay();
    	OrderPayResult.setOrdNo(order.getOrdNo());
    	OrderPayResult.setUpdrNo(99999999); //수정자
    	OrderPayResult.setCnclAmt(cancelAmt);
    	orderResult.setOrdStat("OR00204");
    	OrderPayResult.setPayStat("OR00904");
    	orderDao.updateOrdr(orderResult);//주문상태 수정
    	orderDao.updateOrdPay(OrderPayResult);//주문결제 상태
    	
    	orderResult.setPerOrdStat(perOrdStat);//개별상품상태
    	
    	if ( mod_type.equals( "STPC" ) ){
    		orderResult.setOrdGdsSeq(order.getOrderGoods().get(orderGdsSeq).getOrdGdsSeq());
    	}
    	orderDao.updateOrdStat2(orderResult);//주문개별상태 수정		
    	
    	
    	UbiOrder ubiOrder = new UbiOrder();
    	ubiOrder.set주문번호(order.getOrdNo().toString());
    	if ( mod_type.equals( "STPC" ) ){
	    	ubiOrder.set품번(order.getOrderGoods().get(orderGdsSeq).getUbiGdsNo());
	    	ubiOrder.set색상(order.getOrderGoods().get(orderGdsSeq).getUbiGdsColorCd());
	    	ubiOrder.set사이즈(order.getOrderGoods().get(orderGdsSeq).getUbiGdsSize());
    	}
    	
    	if("OR00507".equals(perOrdStat)){
    		orderDao.insertUbiOrderCancel2(ubiOrder);
    	}else{
    		orderDao.insertUbiOrderCancel(ubiOrder);
    	}
    	
    	//배송비
		if("true".equals(dlvCls)){
			UbiOrder ubiOrderDlv = new UbiOrder();
			ubiOrderDlv.set주문번호(order.getOrdNo().toString());
			ubiOrderDlv.set품번("000000000000000001");
			ubiOrderDlv.set색상("000");
			ubiOrderDlv.set사이즈("NO");
        	orderDao.insertUbiOrderCancel(ubiOrderDlv);   
		}    	
    	
     	//적립금 환불
    	Point point = new Point();
		point.setRsvRsnCd("MT00206");
		point.setMemNo(order.getMemNo());
		//부분취소
		if ( mod_type.equals( "STPC" ) ){
			point.setRsvPnt(order.getOrderGoods().get(orderGdsSeq).getUsePnt());			
		}else{ //전체취소
			point.setRsvPnt(order.getOrderPay().get(1).getPayAmt());	
		}
		point.setRsvYn("Y");
		point.setRegrNo(order.getMemNo());
		point.setRsvCls("CM01002");
		point.setOrdNo(order.getOrdNo());
		orderDao.insertPoint(point);
    	
// 		//회원일때만 적립금 회수로직 실행
// 		if(!"GUEST".equals(order.getMemId())){
// 	    	//적립금 환불
// 	    	Point point2 = new Point();
// 	    	point2.setRsvRsnCd("MT00205");
// 	    	point2.setMemNo(order.getMemNo());
// 	    	point2.setRsvPnt(returnRsvPnt);	
// 	    	point2.setRsvYn("N");
// 	    	point2.setRegrNo(order.getMemNo());
// 	    	point2.setRsvCls("CM01002");
// 			orderDao.insertPoint(point2);			
// 		}

		if("OR00507".equals(perOrdStat)){ //주문취소
	    	//SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
			smsSend.sendSMS(6, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), order.getOrdNo(), ordGdsSeq);
			
			//MAIL 발송
			HashMap<String,Object> hm = new HashMap<String,Object>();
	       	hm.put("orderNo", order.getOrdNo());
	       	hm.put("ordGdsSeq", order.getOrderGoods().get(orderGdsSeq).getOrdGdsSeq());
	       	int result = 0;
	       	//메일발송 성공 : 1, 실패 : 0
			result = mailSend.sendMail(order.getOrdrNm(),order.getOrdrEmail(),request,hm,"ordCancel");			
		}else if("OR00514".equals(perOrdStat)){ //반품완료
			smsSend.sendSMS(12, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), order.getOrdNo(), ordGdsSeq);
		}

	%>
	<script>
		alert("주문이 취소 되었습니다.");
		parent.documentReload();
	</script>
	<% 	
        out.println( "취소요청이 완료되었습니다.      <br>");
        //out.println( "결과코드 : "      + res_cd   + "<br>");
        //out.println( "결과메세지 : "    + res_msg  + "<p>");
	%>
	<%
    }
    else
    {
        out.println( "취소요청이 처리 되지 못하였습니다.  <br>");
        out.println( "결과코드 : "      + res_cd       + "<br>");
        out.println( "결과메세지 : "    + res_msg      + "<p>");
        %>
    <script>
		alert("취소요청이 처리 되지 못하였습니다.");
		parent.documentReload();
	</script>
    <%}%>