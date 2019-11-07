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
    /* =   PAGE : 지불 요청 및 결과 처리 PAGE                                       = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */

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
    <%@ include file="/jsp/common/order/site_conf_inc.jsp"%>
<%
WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
OrderDao orderDao = (OrderDao)wac.getBean("orderDao");
PointDao pointDao = (PointDao)wac.getBean("pointDao");
CommonDao commonDao = (CommonDao)wac.getBean("commonDao");
SMSSend smsSend = (SMSSend)wac.getBean("SMSSend");

SearchForm searchForm = new SearchForm();
searchForm.setOrdNo(request.getParameter("ordr_idxx"));
Order order = orderDao.selectOrder(searchForm);

int ubiOrderNo = orderDao.ubiOrderSeq();
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
    /* ------------------------------------------------------------------------------ */
    /* =   null 값을 처리하는 메소드 END                                            = */
    /* ============================================================================== */
%>
<%
    /* ============================================================================== */
    /* =   POST 형식 체크부분                                                       = */
    /* = -------------------------------------------------------------------------- = */
    if ( request.getMethod() != "POST" )
    {
        out.println("잘못된 경로로 접속하였습니다.");
        return;
    }
    /* ============================================================================== */
%>
<%
    request.setCharacterEncoding ( "utf-8" ) ;

	//회원정보
	Member member = (Member)request.getSession().getAttribute("member");
    /* ============================================================================== */
    /* =   02. 지불 요청 정보 설정                                                  = */
    /* = -------------------------------------------------------------------------- = */
    String req_tx         = f_get_parm( request.getParameter( "req_tx"         ) ); // 요청 종류
    String tran_cd        = f_get_parm( request.getParameter( "tran_cd"        ) ); // 처리 종류
    /* = -------------------------------------------------------------------------- = */
    String cust_ip        = f_get_parm( request.getRemoteAddr()                  ); // 요청 IP
    String ordr_idxx      = f_get_parm( request.getParameter( "ordr_idxx"      ) ); // 쇼핑몰 주문번호
    String good_name      = f_get_parm( request.getParameter( "good_name"      ) ); // 상품명
    String good_mny       = f_get_parm( request.getParameter( "good_mny"       ) ); // 결제 총금액
    /* = -------------------------------------------------------------------------- = */
    String res_cd         = "";                                                     // 응답코드
    String res_msg        = "";                                                     // 응답 메세지
    String escw_yn        = "";                                                     // 에스크로 사용여부
    String tno            = f_get_parm( request.getParameter( "tno"            ) ); // KCP 거래 고유 번호
    String vcnt_yn        = f_get_parm( request.getParameter( "vcnt_yn"        ) ); // 가상계좌 에스크로 사용 유무
    /* = -------------------------------------------------------------------------- = */
    String buyr_name      = f_get_parm( request.getParameter( "buyr_name"      ) ); // 주문자명
    String buyr_tel1      = f_get_parm( request.getParameter( "buyr_tel1"      ) ); // 주문자 전화번호
    String buyr_tel2      = f_get_parm( request.getParameter( "buyr_tel2"      ) ); // 주문자 핸드폰 번호
    String buyr_mail      = f_get_parm( request.getParameter( "buyr_mail"      ) ); // 주문자 E-mail 주소
    /* = -------------------------------------------------------------------------- = */
    String use_pay_method = f_get_parm( request.getParameter( "use_pay_method" ) ); // 결제 방법
    String bSucc          = "";                                                     // 업체 DB 처리 성공 여부
    /* = -------------------------------------------------------------------------- = */
    String app_time       = "";                                                     // 승인시간 (모든 결제 수단 공통)
    String amount		  = "";                                                     // KCP 실제 거래금액
    String total_amount   = "0";                                                    // 복합결제시 총 거래금액
    String coupon_mny     = "";                                                     // 쿠폰금액
    /* = -------------------------------------------------------------------------- = */
    String card_cd        = "";                                                     // 신용카드 코드
    String card_name      = "";                                                     // 신용카드 명
    String app_no         = "";                                                     // 신용카드 승인번호
    String noinf          = "";                                                     // 신용카드 무이자 여부
    String quota          = "";                                                     // 신용카드 할부개월
    String partcanc_yn    = "";                                                     // 부분취소 가능유무
    String card_bin_type_01 = "";                                                   // 카드구분1
    String card_bin_type_02 = "";                                                   // 카드구분2
    String card_mny       = "";                                                     // 카드금액
    /* = -------------------------------------------------------------------------- = */
    String bank_name      = "";                                                     // 은행명
    String bank_code      = "";                                                     // 은행코드
    String bk_mny         = "";                                                     // 계좌이체결제금액
    /* = -------------------------------------------------------------------------- = */
    String bankname       = "";                                                     // 입금할 은행명
    String depositor      = "";                                                     // 입금할 계좌 예금주 성명
    String account        = "";                                                     // 입금할 계좌 번호
    String va_date        = "";                                                     // 가상계좌 입금마감시간
    /* = -------------------------------------------------------------------------- = */
    String pnt_issue      = "";                                                     // 결제 포인트사 코드
    String pnt_amount     = "";                                                     // 적립금액 or 사용금액
    String pnt_app_time   = "";                                                     // 승인시간
    String pnt_app_no     = "";                                                     // 승인번호
    String add_pnt        = "";                                                     // 발생 포인트
    String use_pnt        = "";                                                     // 사용가능 포인트
    String rsv_pnt        = "";                                                     // 총 누적 포인트
    /* = -------------------------------------------------------------------------- = */
    String commid         = "";                                                     // 통신사코드
    String mobile_no      = "";                                                     // 휴대폰번호
    /* = -------------------------------------------------------------------------- = */
    String shop_user_id	  = f_get_parm( request.getParameter( "shop_user_id"   ) ); // 가맹점 고객 아이디
    String tk_shop_id     = f_get_parm( request.getParameter( "tk_shop_id"   ) );   // 가맹점 고객 아이디
    String tk_van_code	  = "";                                                     // 발급사코드
    String tk_app_no	  = "";                                                     // 승인번호
    /* = -------------------------------------------------------------------------- = */
    String cash_yn        = f_get_parm( request.getParameter( "cash_yn"      ) );   // 현금 영수증 등록 여부
    String cash_authno    = "";                                                     // 현금 영수증 승인 번호
    String cash_tr_code   = f_get_parm( request.getParameter( "cash_tr_code" ) );   // 현금 영수증 발행 구분
    String cash_id_info   = f_get_parm( request.getParameter( "cash_id_info" ) );   // 현금 영수증 등록 번호
    /* ============================================================================== */
    /* =   01-1. 에스크로 지불 요청 정보 설정                                       = */
    /* = -------------------------------------------------------------------------- = */
    String escw_used      = f_get_parm( request.getParameter( "escw_used"   ) );    // 에스크로 사용 여부
    String pay_mod        = f_get_parm( request.getParameter( "pay_mod"     ) );    // 에스크로 결제처리 모드
    String deli_term      = f_get_parm( request.getParameter( "deli_term"   ) );    // 배송 소요일
    String bask_cntx      = f_get_parm( request.getParameter( "bask_cntx"   ) );    // 장바구니 상품 개수
    String good_info      = f_get_parm( request.getParameter( "good_info"   ) );    // 장바구니 상품 상세 정보
    String rcvr_name      = f_get_parm( request.getParameter( "rcvr_name"   ) );    // 수취인 이름
    String rcvr_tel1      = f_get_parm( request.getParameter( "rcvr_tel1"   ) );    // 수취인 전화번호
    String rcvr_tel2      = f_get_parm( request.getParameter( "rcvr_tel2"   ) );    // 수취인 휴대폰번호
    String rcvr_mail      = f_get_parm( request.getParameter( "rcvr_mail"   ) );    // 수취인 E-Mail
    String rcvr_zipx      = f_get_parm( request.getParameter( "rcvr_zipx"   ) );    // 수취인 우편번호
    String rcvr_add1      = f_get_parm( request.getParameter( "rcvr_add1"   ) );    // 수취인 주소
    String rcvr_add2      = f_get_parm( request.getParameter( "rcvr_add2"   ) );    // 수취인 상세주소
    /* = -------------------------------------------------------------------------- = */
    /* =   01. 지불 요청 정보 설정 END                                              = */
    /* ============================================================================== */
    //모바일에서만 사용{
    String param_opt_1    = f_get_parm( request.getParameter( "param_opt_1" ) );
    String param_opt_2    = f_get_parm( request.getParameter( "param_opt_2" ) );
    String param_opt_3    = f_get_parm( request.getParameter( "param_opt_3" ) );
    //}
    /* ============================================================================== */
    /* =   02. 인스턴스 생성 및 초기화(변경 불가)                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   결제에 필요한 인스턴스를 생성하고 초기화 합니다.                         = */
    /* =   ※ 주의 ※ 이 부분은 변경하지 마십시오                                   = */
    /* = -------------------------------------------------------------------------- = */

	C_PP_CLI_T c_PayPlus = new C_PP_CLI_T();
	c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode );
	c_PayPlus.mf_init_set();

    /*
    윈도우버전과 유닉스 버전은 샘플이 다르기 때문에 반드시 OS별 샘플을 구분하여 다운로드하시기 바랍니다. 
    Windows 의 경우 : pp_cli_exe.exe 파일 이용 
    UNIX 계열의 경우 : pp_cli 파일 이용 

    pp_cli_hub 페이지에서 mf_init 하는 인자값 개수 상이 
    // Unix / Linux Platform 
    c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode ); 
    // Windows Platform 
    c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_key_dir, g_conf_log_dir, g_conf_tx_mode );
    */

    /* = -------------------------------------------------------------------------- = */
    /* =   02. 인스턴스 생성 및 초기화 END                                          = */
    /* ============================================================================== */


    /* ============================================================================== */
    /* =   03. 처리 요청 정보 설정                                                  = */
    /* = -------------------------------------------------------------------------- = */
    /* = -------------------------------------------------------------------------- = */
    /* =   03-1. 승인 요청 정보 설정                                                = */
    /* = -------------------------------------------------------------------------- = */

    if ( req_tx.equals( "pay" ) )
    {
            c_PayPlus.mf_set_enc_data( f_get_parm( request.getParameter( "enc_data" ) ),
                                       f_get_parm( request.getParameter( "enc_info" ) ) );

            /* 1004원은 실제로 업체에서 결제하셔야 될 원 금액을 넣어주셔야 합니다. 결제금액 유효성 검증
            if(good_mny.trim().length() > 0)
            {
                int ordr_data_set_no;

                ordr_data_set_no = c_PayPlus.mf_add_set( "ordr_data" );

                c_PayPlus.mf_set_us( ordr_data_set_no, "ordr_mony", good_mny );
                c_PayPlus.mf_set_us( ordr_data_set_no, "ordr_idxx", ordr_idxx );
            }
            */
    }
    /* ============================================================================== */
    /* =   04. 실행                                                                 = */
    /* = -------------------------------------------------------------------------- = */
    if ( tran_cd.length() > 0 )
    {
    	c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", ordr_idxx, g_conf_log_level, "0", g_conf_log_path );

        res_cd  = c_PayPlus.m_res_cd;  // 결과 코드
        res_msg = c_PayPlus.m_res_msg; // 결과 메시지
    }
    else
    {
        c_PayPlus.m_res_cd  = "9562";
        c_PayPlus.m_res_msg = "연동 오류|Payplus Plugin이 설치되지 않았거나 tran_cd값이 설정되지 않았습니다.";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   04. 실행 END                                                             = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* =   06. 승인 결과 값 추출                                                    = */
    /* = -------------------------------------------------------------------------- = */
    if ( req_tx.equals( "pay" ) )
    {
        if ( res_cd.equals( "0000" ) )
        {
            tno    = c_PayPlus.mf_get_res( "tno"    ); // KCP 거래 고유 번호
            amount = c_PayPlus.mf_get_res( "amount" ); // KCP 실제 거래 금액
            pnt_issue = c_PayPlus.mf_get_res( "pnt_issue" ); // 결제 포인트사 코드
            coupon_mny = c_PayPlus.mf_get_res( "coupon_mny" ); // 쿠폰금액

    /* = -------------------------------------------------------------------------- = */
    /* =   06-1. 신용카드 승인 결과 처리                                            = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals( "100000000000" ) )
            {
                card_cd   = c_PayPlus.mf_get_res( "card_cd"   ); // 카드사 코드
                card_name = c_PayPlus.mf_get_res( "card_name" ); // 카드사 명
                app_time  = c_PayPlus.mf_get_res( "app_time"  ); // 승인시간
                app_no    = c_PayPlus.mf_get_res( "app_no"    ); // 승인번호
                noinf     = c_PayPlus.mf_get_res( "noinf"     ); // 무이자 여부
                quota     = c_PayPlus.mf_get_res( "quota"     ); // 할부 개월 수
                partcanc_yn = c_PayPlus.mf_get_res( "partcanc_yn" ); // 부분취소 가능유무
                card_bin_type_01 = c_PayPlus.mf_get_res( "card_bin_type_01" ); // 카드구분1
                card_bin_type_02 = c_PayPlus.mf_get_res( "card_bin_type_02" ); // 카드구분2
                card_mny = c_PayPlus.mf_get_res( "card_mny" ); // 카드결제금액

                /* = -------------------------------------------------------------- = */
                /* =   06-1.1. 복합결제(포인트+신용카드) 승인 결과 처리             = */
                /* = -------------------------------------------------------------- = */
                if ( pnt_issue.equals( "SCSK" ) || pnt_issue.equals( "SCWB" ) )
                {
                    pnt_amount   = c_PayPlus.mf_get_res( "pnt_amount"   ); // 적립금액 or 사용금액
                    pnt_app_time = c_PayPlus.mf_get_res( "pnt_app_time" ); // 승인시간
                    pnt_app_no   = c_PayPlus.mf_get_res( "pnt_app_no"   ); // 승인번호
                    add_pnt      = c_PayPlus.mf_get_res( "add_pnt"      ); // 발생 포인트
                    use_pnt      = c_PayPlus.mf_get_res( "use_pnt"      ); // 사용가능 포인트
                    rsv_pnt      = c_PayPlus.mf_get_res( "rsv_pnt"      ); // 총 누적 포인트
                    total_amount = amount + pnt_amount;                    // 복합결제시 총 거래금액
                }
            }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-2. 계좌이체 승인 결과 처리                                            = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals("010000000000") )
            {
                app_time  = c_PayPlus.mf_get_res( "app_time"  ); // 승인시간
                bank_name = c_PayPlus.mf_get_res( "bank_name" ); // 은행명
                bank_code = c_PayPlus.mf_get_res( "bank_code" ); // 은행코드
                bk_mny    = c_PayPlus.mf_get_res( "bk_mny"    ); // 계좌이체결제금액
            }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-3. 가상계좌 승인 결과 처리                                            = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals( "001000000000" ) )
            {
                bankname  = c_PayPlus.mf_get_res( "bankname"  ); // 입금할 은행 이름
                depositor = c_PayPlus.mf_get_res( "depositor" ); // 입금할 계좌 예금주
                account   = c_PayPlus.mf_get_res( "account"   ); // 입금할 계좌 번호
                va_date   = c_PayPlus.mf_get_res( "va_date"   ); // 가상계좌 입금마감시간
            }

	/* = -------------------------------------------------------------------------- = */
    /* =   06-4. 포인트 승인 결과 처리                                              = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals( "000100000000" ) )
            {
                pnt_amount   = c_PayPlus.mf_get_res( "pnt_amount"   ); // 적립금액 or 사용금액
	            pnt_app_time = c_PayPlus.mf_get_res( "pnt_app_time" ); // 승인시간
	            pnt_app_no   = c_PayPlus.mf_get_res( "pnt_app_no"   ); // 승인번호
	            add_pnt      = c_PayPlus.mf_get_res( "add_pnt"      ); // 발생 포인트
	            use_pnt      = c_PayPlus.mf_get_res( "use_pnt"      ); // 사용가능 포인트
                rsv_pnt      = c_PayPlus.mf_get_res( "rsv_pnt"      ); // 총 누적 포인트
            }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-5. 휴대폰 승인 결과 처리                                              = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals( "000010000000" ) )
            {
                app_time = c_PayPlus.mf_get_res( "hp_app_time" ); // 승인 시간
                commid	 = c_PayPlus.mf_get_res( "commid"	   ); // 통신사 코드
                mobile_no= c_PayPlus.mf_get_res( "mobile_no"   ); // 휴대폰 번호
            }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-6. 상품권 승인 결과 처리                                              = */
    /* = -------------------------------------------------------------------------- = */
            if ( use_pay_method.equals( "000000001000" ) )
            {
                app_time    = c_PayPlus.mf_get_res( "tk_app_time" ); // 승인 시간
                tk_van_code = c_PayPlus.mf_get_res( "tk_van_code" ); // 발급사 코드
                tk_app_no   = c_PayPlus.mf_get_res( "tk_app_no"   ); // 승인 번호
            }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-7. 현금영수증 승인 결과 처리                                          = */
    /* = -------------------------------------------------------------------------- = */
            cash_authno = c_PayPlus.mf_get_res( "cash_authno" ); // 현금영수증 승인번호
        }

    /* = -------------------------------------------------------------------------- = */
    /* =   06-8. 에스크로 여부 결과 처리                                            = */
    /* = -------------------------------------------------------------------------- = */
        escw_yn  = c_PayPlus.mf_get_res( "escw_yn" ); // 에스크로 여부
    }
    /* = -------------------------------------------------------------------------- = */
    /* =   06. 승인 결과 처리 END                                                   = */
    /* ============================================================================== */


    /* = ========================================================================== = */
    /* =   07. 승인 및 실패 결과 DB 처리                                            = */
    /* = -------------------------------------------------------------------------- = */
    /* =      결과를 업체 자체적으로 DB 처리 작업하시는 부분입니다.                 = */
    /* = -------------------------------------------------------------------------- = */
	

    
    if ( req_tx.equals( "pay" ) )
    {
    	
    /* = -------------------------------------------------------------------------- = */
    /* =   07-1. 승인 결과 DB 처리(res_cd == "0000")                                = */
    /* = -------------------------------------------------------------------------- = */
    /* =        각 결제수단을 구분하시어 DB 처리를 하시기 바랍니다.                 = */
    /* = -------------------------------------------------------------------------- = */
        if ( res_cd.equals( "0000" ) )
        {
        	
        	Order orderResult = new Order();
        	orderResult.setOrdNo(ordr_idxx);
        	if(member == null){
        		orderResult.setUpdrNo(99999999); //수정자
        	}else{
	        	orderResult.setUpdrNo(member.getMemNo()); //수정자
        	}
        	
        	OrderPay OrderPayResult = new OrderPay();
        	OrderPayResult.setOrdNo(ordr_idxx);
        	if(member == null){
        		OrderPayResult.setUpdrNo(99999999); //수정자
        	}else{
        		OrderPayResult.setUpdrNo(member.getMemNo()); //수정자
        	}         	
        	
    		try {
                // 07-1-1. 신용카드
                if ( use_pay_method.equals( "100000000000" ) )
                {
					OrderPay orderPay = new OrderPay();
					orderPay.setPayNo(commonDao.createKey("SEQ_OR_PAY_NO"));
					orderPay.setOrdNo(ordr_idxx);
					orderPay.setPayAmt(Integer.parseInt(amount));
					orderPay.setPayWay("OR00801");
					orderPay.setPayTp("OR00703");
					orderPay.setPayStat("OR00902");
					orderPay.setOrdClmCls("OR00601");
		        	orderPay.setRegrNo(member.getMemNo());
					orderDao.insertOrdPay(orderPay);
					
        			UbiOrder ubiOrder = new UbiOrder();
            		ubiOrder.set매장코드("WE001");
            		ubiOrder.set판매번호(String.format("%04d", ubiOrderNo));
            		ubiOrder.set판매연번(String.format("%04d", order.getOrderGoods().size()+1));
            		ubiOrder.set작업구분("0");
            		ubiOrder.set품번("000000000000000002");
            		ubiOrder.set색상("000");
            		ubiOrder.set사이즈("NO");
            		ubiOrder.set판매수량(1);
            		ubiOrder.set실판매금액(Integer.parseInt(amount));
            		ubiOrder.set적립포인트(0);
            		ubiOrder.set사용포인트(0);
            		ubiOrder.set수정여부("N");
            		ubiOrder.set처리여부("N");
            		ubiOrder.set에러사유("");
            		ubiOrder.set주문번호(ordr_idxx);
                	ubiOrder.set적립율(0);
            		if(member == null){
                		ubiOrder.set온라인고객코드("99999999");
                	}else{
                		ubiOrder.set온라인고객코드(member.getMemNo().toString());	
                	}
            		
            		orderDao.insertUbiOrder(ubiOrder);
                }

                // 07-1-2. 계좌이체
                if ( use_pay_method.equals("010000000000") )
                {
					OrderPay orderPay = new OrderPay();
					orderPay.setPayNo(commonDao.createKey("SEQ_OR_PAY_NO"));
					orderPay.setOrdNo(ordr_idxx);
					orderPay.setPayAmt(Integer.parseInt(amount));
					orderPay.setPayWay("OR00802");
					orderPay.setPayTp("OR00703");
					orderPay.setPayStat("OR00902");
					orderPay.setOrdClmCls("OR00601");
					orderPay.setRegrNo(member.getMemNo());
					orderDao.insertOrdPay(orderPay);
					
        			UbiOrder ubiOrder = new UbiOrder();
            		ubiOrder.set매장코드("WE001");
            		ubiOrder.set판매번호(String.format("%04d", ubiOrderNo));
            		ubiOrder.set판매연번(String.format("%04d", order.getOrderGoods().size()+1));
            		ubiOrder.set작업구분("0");
            		ubiOrder.set품번("000000000000000002");
            		ubiOrder.set색상("000");
            		ubiOrder.set사이즈("NO");
            		ubiOrder.set판매수량(1);
            		ubiOrder.set실판매금액(Integer.parseInt(amount));
            		ubiOrder.set적립포인트(0);
            		ubiOrder.set사용포인트(0);
            		ubiOrder.set수정여부("N");
            		ubiOrder.set처리여부("N");
            		ubiOrder.set에러사유("");
            		ubiOrder.set주문번호(ordr_idxx);
                	ubiOrder.set적립율(0);
            		if(member == null){
                		ubiOrder.set온라인고객코드("99999999");
                	}else{
                		ubiOrder.set온라인고객코드(member.getMemNo().toString());	
                	}
            		
            		orderDao.insertUbiOrder(ubiOrder);					
                }
                // 07-1-3. 가상계좌
                if ( use_pay_method.equals("001000000000") )
                {
					/* OrderPay orderPay = new OrderPay();
					orderPay.setPayNo(commonDao.createKey("SEQ_OR_PAY_NO"));
					orderPay.setOrdNo(ordr_idxx);
					orderPay.setPayAmt(Integer.parseInt(amount));
					orderPay.setPayWay("OR00803");
					orderPay.setPayTp("OR00703");
					orderPay.setPayStat("OR00902");
					orderPay.setOrdClmCls("OR00601");
					orderPay.setRegrNo(member.getMemNo());
					orderDao.insertOrdPay(orderPay); */
                }
                // 07-1-4. 포인트
                if ( use_pay_method.equals("000100000000") )
                {

                }
                // 07-1-5. 휴대폰
                if ( use_pay_method.equals("000010000000") )
                {

                }
                // 07-1-6. 상품권
                if ( use_pay_method.equals("000000001000") )
                {

                }
                
/*             	//KCP전문내역
            	KcpHist kcpHist = new KcpHist();
            	kcpHist.setOrdNo(ordr_idxx);         //주문번호 
            	kcpHist.setTno(tno);         //KCP거래번호 
            	kcpHist.setResCd(res_cd);         //결과코드 
            	kcpHist.setResMsg(res_msg);         //결과메세지 
            	kcpHist.setBsucc(bSucc);         //자동취소 구분 
            	kcpHist.setEscwYn(escw_yn);         //에스크로결제여부 
            	if(member == null){
            		kcpHist.setRegrNo(99999999);         //등록자
            	}else{
            		kcpHist.setRegrNo(member.getMemNo());         //등록자	
            	}        	
            	
            	orderDao.insertKpcHist(kcpHist);     */            
				            	
    			//SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
    			//smsSend.sendSMS(3, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), ordr_idxx, 0);

    			//TODO MAIL 발송
    		} catch (Exception e) {
            	//orderResult.setOrdStat("OR00204");
            	//orderResult.setPerOrdStat("OR00507");
            	//OrderPayResult.setPayStat("OR00904");    			
    			
    			bSucc = "false";
    		}

        /* = -------------------------------------------------------------------------- = */
        /* =   07-2. 승인 실패 DB 처리(res_cd != "0000")                                = */
        /* = -------------------------------------------------------------------------- = */
            if( !"0000".equals ( res_cd ) )
            {

            }
        }
    }
    /* = -------------------------------------------------------------------------- = */
    /* =   07. 승인 및 실패 결과 DB 처리 END                                        = */
    /* = ========================================================================== = */

    /* = ========================================================================== = */
    /* =   08. 승인 결과 DB 처리 실패시 : 자동취소                                  = */
    /* = -------------------------------------------------------------------------- = */
    /* =      승인 결과를 DB 작업 하는 과정에서 정상적으로 승인된 건에 대해         = */
    /* =      DB 작업을 실패하여 DB update 가 완료되지 않은 경우, 자동으로          = */
    /* =      승인 취소 요청을 하는 프로세스가 구성되어 있습니다.                   = */
    /* =                                                                            = */
    /* =      DB 작업이 실패 한 경우, bSucc 라는 변수(String)의 값을 "false"        = */
    /* =      로 설정해 주시기 바랍니다. (DB 작업 성공의 경우에는 "false" 이외의    = */
    /* =      값을 설정하시면 됩니다.)                                              = */
    /* = -------------------------------------------------------------------------- = */

    // 승인 결과 DB 처리 에러시 bSucc값을 false로 설정하여 거래건을 취소 요청

    if (req_tx.equals("pay") )
    {
        if (res_cd.equals("0000") )
        {
            if ( bSucc.equals("false") )
            {
                int mod_data_set_no;

                c_PayPlus.mf_init_set();

                tran_cd = "00200000";
	/* ============================================================================== */
    /* =   07-1.자동취소시 에스크로 거래인 경우                                     = */
    /* = -------------------------------------------------------------------------- = */
            String bSucc_mod_type; // 즉시 취소 시 사용하는 mod_type

                if ( escw_yn.equals("Y") && use_pay_method.equals("001000000000") )
                {
                    bSucc_mod_type = "STE5"; // 에스크로 가상계좌 건의 경우 가상계좌 발급취소(STE5)
                }
                else if ( escw_yn.equals("Y") )
                {
                    bSucc_mod_type = "STE2"; // 에스크로 가상계좌 이외 건은 즉시취소(STE2)
                }
                else
                {
                    bSucc_mod_type = "STSC"; // 에스크로 거래 건이 아닌 경우(일반건)(STSC)
                }
	/* = ---------------------------------------------------------------------------- = */
    /* =   07-1. 자동취소시 에스크로 거래인 경우 처리 END                             = */
    /* = ============================================================================== */

                mod_data_set_no = c_PayPlus.mf_add_set( "mod_data" );

                c_PayPlus.mf_set_us( mod_data_set_no, "tno",      tno                          ); // KCP 원거래 거래번호
                c_PayPlus.mf_set_us( mod_data_set_no, "mod_type", bSucc_mod_type               ); // 원거래 변경 요청 종류
                c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",   cust_ip                      ); // 변경 요청자 IP
                c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc", "가맹점 결과 처리 오류 - 가맹점에서 취소 요청"  ); // 변경 사유

                c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", ordr_idxx, g_conf_log_level, "0", g_conf_log_path );

                res_cd  = c_PayPlus.m_res_cd;
                res_msg = c_PayPlus.m_res_msg;
            }
        }
    }
        // End of [res_cd = "0000"]
    /* = ---------------------------------------------------------------------------- = */
    /* =   08. 승인 결과 DB 처리 END                                                  = */
    /* = ============================================================================ = */

    ///* ============================================================================== */
    ///* =   09. 폼 구성 및 결과페이지 호출                                           = */
    ///* = -------------------------------------------------------------------------- = */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <script src="<c:url value='/resources/worksout/js/jquery.js'/>" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript">
            function goResult()
            {
            	//parent.document.pay_info.submit();
    			//주문데이터 init, pg호출
    			alert("결제되었습니다.");
    			$("#parent").window.reload();
    		 /*    	$("#pay_info").attr("target", "_parent");
    		    	$("#pay_info").attr("action", "orderResult");
    		    	$("#pay_info").submit(function(){
    		    		$("#parent").load(function() {
    	                	 console.log(this);
    	                });
    	            }).submit(); */
            }

            // 결제 중 새로고침 방지 샘플 스크립트
            function noRefresh()
            {
                /* CTRL + N키 막음. *///
                if ((event.keyCode == 78) && (event.ctrlKey == true))
                {
                    event.keyCode = 0;
                    return false;
                }
                /* F5 번키 막음. */
                if(event.keyCode == 116)
                {
                    event.keyCode = 0;
                    return false;
                }
            }
            document.onkeydown = noRefresh ;
            
            $(window).load(function() {
            	setTimeout("goResult();",1000);
            });             
        </script>
    </head>

    <body onload="" >
    <form name="pay_info" id="pay_info" method="post" action="/front/order/orderResult">
        <input type="hidden" name="site_cd"           value="<%=g_conf_site_cd  %>">  <!-- 사이트코드 -->
        <input type="hidden" name="req_tx"            value="<%=req_tx          %>">  <!-- 요청 구분 -->
        <input type="hidden" name="use_pay_method"    value="<%=use_pay_method  %>">  <!-- 사용한 결제 수단 -->
        <input type="hidden" name="bSucc"             value="<%=bSucc           %>">  <!-- 쇼핑몰 DB 처리 성공 여부 -->

        <input type="hidden" name="amount"            value="<%=amount          %>">  <!-- 금액 -->
        <input type="hidden" name="res_cd"            value="<%=res_cd          %>">  <!-- 결과 코드 -->
        <input type="hidden" name="res_msg"           value="<%=res_msg         %>">  <!-- 결과 메세지 -->
        <input type="hidden" name="ordr_idxx"         value="<%=ordr_idxx       %>">  <!-- 주문번호 -->
        <input type="hidden" name="tno"               value="<%=tno             %>">  <!-- KCP 거래번호 -->
        <input type="hidden" name="good_mny"          value="<%=good_mny        %>">  <!-- 결제금액 -->
        <input type="hidden" name="good_name"         value="<%=good_name       %>">  <!-- 상품명 -->
        <input type="hidden" name="buyr_name"         value="<%=buyr_name       %>">  <!-- 주문자명 -->
        <input type="hidden" name="buyr_tel1"         value="<%=buyr_tel1       %>">  <!-- 주문자 전화번호 -->
        <input type="hidden" name="buyr_tel2"         value="<%=buyr_tel2       %>">  <!-- 주문자 휴대폰번호 -->
        <input type="hidden" name="buyr_mail"         value="<%=buyr_mail       %>">  <!-- 주문자 E-mail -->
        <input type="hidden" name="app_time"          value="<%=app_time        %>">  <!-- 승인시간 -->

        <!-- 신용카드 정보 -->
        <input type="hidden" name="card_cd"           value="<%=card_cd         %>">  <!-- 카드코드 -->
        <input type="hidden" name="card_name"         value="<%=card_name       %>">  <!-- 카드명 -->
        <input type="hidden" name="noinf"             value="<%=noinf           %>">  <!-- 무이자여부 -->
        <input type="hidden" name="app_no"            value="<%=app_no          %>">  <!-- 승인번호 -->
        <input type="hidden" name="quota"             value="<%=quota           %>">  <!-- 할부개월 -->
        <input type="hidden" name="partcanc_yn"       value="<%= partcanc_yn    %>">  <!-- 부분취소가능유무 -->
        <input type="hidden" name="card_bin_type_01"  value="<%= card_bin_type_01 %>"><!-- 카드구분1 -->
        <input type="hidden" name="card_bin_type_02"  value="<%= card_bin_type_02 %>"><!-- 카드구분2 -->

        <!-- 계좌이체 정보 -->
        <input type="hidden" name="bank_name"         value="<%=bank_name       %>">  <!-- 은행명 -->
        <input type="hidden" name="bank_code"         value="<%=bank_code       %>">  <!-- 은행코드 -->

        <!-- 가상계좌 정보 -->
        <input type="hidden" name="bankname"          value="<%=bankname        %>">  <!-- 입금할 은행 -->
        <input type="hidden" name="depositor"         value="<%=depositor       %>">  <!-- 입금할 계좌 예금주 -->
        <input type="hidden" name="account"           value="<%=account         %>">  <!-- 입금할 계좌 번호 -->
        <input type="hidden" name="va_date"           value="<%=va_date         %>">  <!-- 가상계좌 입금마감시간 -->

        <!-- 포인트 정보 -->
        <input type="hidden" name="pnt_issue"         value="<%=pnt_issue       %>">  <!-- 포인트 서비스사 -->
        <input type="hidden" name="pnt_app_time"      value="<%=pnt_app_time    %>">  <!-- 승인시간 -->
        <input type="hidden" name="pnt_app_no"        value="<%=pnt_app_no      %>">  <!-- 승인번호 -->
        <input type="hidden" name="pnt_amount"        value="<%=pnt_amount      %>">  <!-- 적립금액 or 사용금액 -->
        <input type="hidden" name="add_pnt"           value="<%=add_pnt         %>">  <!-- 발생 포인트 -->
        <input type="hidden" name="use_pnt"           value="<%=use_pnt         %>">  <!-- 사용가능 포인트 -->
        <input type="hidden" name="rsv_pnt"           value="<%=rsv_pnt         %>">  <!-- 총 누적 포인트 -->

        <!-- 휴대폰 정보 -->
        <input type="hidden" name="commid"            value="<%=commid          %>">  <!-- 통신사 코드 -->
        <input type="hidden" name="mobile_no"         value="<%=mobile_no       %>">  <!-- 휴대폰 번호 -->

        <!-- 상품권 정보 -->
        <input type="hidden" name="tk_van_code"       value="<%=tk_van_code     %>">  <!-- 발급사 코드 -->
        <input type="hidden" name="tk_app_no"         value="<%=tk_app_no       %>">  <!-- 승인 번호 -->

        <!-- 현금영수증 정보 -->
        <input type="hidden" name="cash_yn"           value="<%=cash_yn         %>">  <!-- 현금영수증 등록 여부 -->
        <input type="hidden" name="cash_authno"       value="<%=cash_authno     %>">  <!-- 현금 영수증 승인 번호 -->
        <input type="hidden" name="cash_tr_code"      value="<%=cash_tr_code    %>">  <!-- 현금 영수증 발행 구분 -->
        <input type="hidden" name="cash_id_info"      value="<%=cash_id_info    %>">  <!-- 현금 영수증 등록 번호 -->

        <!-- 에스크로 정보 -->
        <input type="hidden" name="escw_yn"           value="<%=escw_yn         %>">  <!-- 에스크로 유무 -->
        <input type="hidden" name="deli_term"         value="<%=deli_term       %>">  <!-- 배송 소요일 -->
        <input type="hidden" name="bask_cntx"         value="<%=bask_cntx       %>">  <!-- 장바구니 상품 개수 -->
        <input type="hidden" name="good_info"         value="<%=good_info       %>">  <!-- 장바구니 상품 상세 정보 -->
        <input type="hidden" name="rcvr_name"         value="<%=rcvr_name       %>">  <!-- 수취인 이름 -->
        <input type="hidden" name="rcvr_tel1"         value="<%=rcvr_tel1       %>">  <!-- 수취인 전화번호 -->
        <input type="hidden" name="rcvr_tel2"         value="<%=rcvr_tel2       %>">  <!-- 수취인 휴대폰번호 -->
        <input type="hidden" name="rcvr_mail"         value="<%=rcvr_mail       %>">  <!-- 수취인 E-Mail -->
        <input type="hidden" name="rcvr_zipx"         value="<%=rcvr_zipx       %>">  <!-- 수취인 우편번호 -->
        <input type="hidden" name="rcvr_add1"         value="<%=rcvr_add1       %>">  <!-- 수취인 주소 -->
        <input type="hidden" name="rcvr_add2"         value="<%=rcvr_add2       %>">  <!-- 수취인 상세주소 -->
        
        <input type="hidden" name="param_opt_1"       value="<%= param_opt_1 %>">
        <input type="hidden" name="param_opt_2"       value="<%= param_opt_2 %>">
        <input type="hidden" name="param_opt_3"       value="<%= param_opt_3 %>">        
    </form>
    </body>
</html>
