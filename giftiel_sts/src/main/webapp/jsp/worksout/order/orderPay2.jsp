<%--
 * =============================================================================
 * 파일명 : /front/order/orderPay2.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-07-30
 *
 * 파일 내용 : order > 주문데이터 init, pg호출 통신
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%
    /* ============================================================================== */
    /* =   PAGE : 결제 요청 PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   이 페이지는 Payplus Plug-in을 통해서 결제자가 결제 요청을 하는 페이지    = */
    /* =   입니다. 아래의 ※ 필수, ※ 옵션 부분과 매뉴얼을 참조하셔서 연동을        = */
    /* =   진행하여 주시기 바랍니다.                                                = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
<%
    /* ============================================================================== */
    /* =   환경 설정 파일 Include                                                   = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 필수                                                                  = */
    /* =   테스트 및 실결제 연동시 site_conf_inc.jsp 파일을 수정하시기 바랍니다.    = */
    /* = -------------------------------------------------------------------------- = */
%>
    <%@ include file="/jsp/common/order/site_conf_inc.jsp"%>
<%!
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
  	//request.setCharacterEncoding( "utf-8" );
	request.setCharacterEncoding( "euc-kr" );

    /* kcp와 통신후 kcp 서버에서 전송되는 결제 요청 정보 */
    String req_tx          = f_get_parm( request.getParameter( "req_tx"         ) ); // 요청 종류         
    String res_cd          = f_get_parm( request.getParameter( "res_cd"         ) ); // 응답 코드         
    String tran_cd         = f_get_parm( request.getParameter( "tran_cd"        ) ); // 트랜잭션 코드     
    String ordr_idxx       = f_get_parm( request.getParameter( "ordr_idxx"      ) ); // 쇼핑몰 주문번호   
    String good_name       = f_get_parm( request.getParameter( "good_name"      ) ); // 상품명            
    String good_mny        = f_get_parm( request.getParameter( "good_mny"       ) ); // 결제 총금액       
    String buyr_name       = f_get_parm( request.getParameter( "buyr_name"      ) ); // 주문자명          
    String buyr_tel1       = f_get_parm( request.getParameter( "buyr_tel1"      ) ); // 주문자 전화번호   
    String buyr_tel2       = f_get_parm( request.getParameter( "buyr_tel2"      ) ); // 주문자 핸드폰 번호
    String buyr_mail       = f_get_parm( request.getParameter( "buyr_mail"      ) ); // 주문자 E-mail 주소
    String use_pay_method  = f_get_parm( request.getParameter( "use_pay_method" ) ); // 결제 방법         
    String ipgm_date       = f_get_parm( request.getParameter( "ipgm_date"      ) ); // 가상계좌 마감시간 
    String enc_info        = f_get_parm( request.getParameter( "enc_info"       ) ); // 암호화 정보       
    String enc_data        = f_get_parm( request.getParameter( "enc_data"       ) ); // 암호화 데이터     
    String van_code        = f_get_parm( request.getParameter( "van_code"       ) );
    String cash_yn         = f_get_parm( request.getParameter( "cash_yn"        ) );
    String cash_tr_code    = f_get_parm( request.getParameter( "cash_tr_code"   ) );
    /* 기타 파라메터 추가 부분 - Start - */
    String param_opt_1    = f_get_parm( request.getParameter( "param_opt_1"     ) ); // 기타 파라메터 추가 부분
    String param_opt_2    = f_get_parm( request.getParameter( "param_opt_2"     ) ); // 기타 파라메터 추가 부분
    String param_opt_3    = f_get_parm( request.getParameter( "param_opt_3"     ) ); // 기타 파라메터 추가 부분
    /* 기타 파라메터 추가 부분 - End -   */

  String tablet_size     = "1.0"; // 화면 사이즈 고정
  String url             = curDomain+"/front/order/orderPayWeb";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>*** KCP [AX-HUB Version] ***</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="No-Cache">
<meta http-equiv="Pragma" content="No-Cache">

<meta name="viewport" content="width=device-width, user-scalable=<%=tablet_size%>, initial-scale=<%=tablet_size%>, maximum-scale=<%=tablet_size%>, minimum-scale=<%=tablet_size%>">

<link href="/resources/common/kcp/css/style.css" rel="stylesheet" type="text/css" id="cssLink"/>

<!-- 거래등록 하는 kcp 서버와 통신을 위한 스크립트-->
<script type="text/javascript" src="/resources/common/kcp/approval_key.js"></script>
<script src="<c:url value='/resources/worksout/js/jquery.js'/>" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
  var controlCss = "/resources/common/kcp/css/style_mobile.css";
  var isMobile = {
    Android: function() {
      return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
      return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
      return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
      return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
  };

  if( isMobile.any() )
    document.getElementById("cssLink").setAttribute("href", controlCss);
</script>
<script type="text/javascript">
   /* 주문번호 생성 예제 */
  function init_orderid()
  {
    var today = new Date();
    var year  = today.getFullYear();
    var month = today.getMonth() + 1;
    var date  = today.getDate();
    var time  = today.getTime();

    if (parseInt(month) < 10)
      month = "0" + month;

    if (parseInt(date) < 10)
      date  = "0" + date;

    var order_idxx = "TEST" + year + "" + month + "" + date + "" + time;
    var ipgm_date  = year + "" + month + "" + date;

    document.order_info.ordr_idxx.value = order_idxx;
    document.order_info.ipgm_date.value = ipgm_date;
  }

   /* kcp web 결제창 호츨 (변경불가) */
  function call_pay_form()
  {
    var v_frm = document.order_info;

    document.getElementById("sample_wrap").style.display = "none";
    document.getElementById("layer_all").style.display  = "block";

    v_frm.target = "frm_all";
    v_frm.action = PayUrl;

    if (v_frm.Ret_URL.value == "")
    {
	  /* Ret_URL값은 현 페이지의 URL 입니다. */
      alert("연동시 Ret_URL을 반드시 설정하셔야 됩니다.");
      return false;
    }
    else
    {
      v_frm.submit();
    }
  }

   /* kcp 통신을 통해 받은 암호화 정보 체크 후 결제 요청 (변경불가) */
  function chk_pay()
  {
    self.name = "tar_opener";
    var pay_form = document.pay_form;

    if (pay_form.res_cd.value == "3001" )
    {
      alert("사용자가 취소하였습니다.");
      pay_form.res_cd.value = "";
    }
    else if (pay_form.res_cd.value == "3000" )
    {
      alert("30만원 이상 결제를 할 수 없습니다.");
      pay_form.res_cd.value = "";
    }

    document.getElementById("sample_wrap").style.display = "block";
    document.getElementById("layer_all").style.display  = "none";

    if (pay_form.enc_info.value)
      pay_form.submit();
  }

   /* 에스크로 장바구니 상품 상세 정보 생성 예제 */
  function create_goodInfo()
  {
    var chr30 = String.fromCharCode(30);
    var chr31 = String.fromCharCode(31);

    var good_info = ""
    	<c:forEach items="${order.orderGoods}" varStatus="listCount" var="goods">
    	console.log('${listCount.count}');
        	<c:if test="${!listCount.last}">
        		good_info += "seq=${listCount.count}" + chr31 + "ordr_numb=${ordNo}_${listCount.count}" + chr31 + "good_name=${goods.ubiGdsNm}" + chr31 + "good_cntx=1" + chr31 + "good_amtx=${goods.slPrc}" + chr30;
        	</c:if>
        	<c:if test="${listCount.last}">
        		good_info += "seq=${listCount.count}" + chr31 + "ordr_numb=${ordNo}_${listCount.count}" + chr31 + "good_name=${goods.ubiGdsNm}" + chr31 + "good_cntx=1" + chr31 + "good_amtx=${goods.slPrc}";
        	</c:if>
    	</c:forEach>

    document.order_info.good_info.value = good_info;
  }

  function jsf__chk_type()
  {
    if ( document.order_info.ActionResult.value == "card" )
    {
      document.order_info.pay_method.value = "CARD";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "acnt" )
    {
      document.order_info.pay_method.value = "BANK";
      document.order_info.pay_mod.value = "O";
    }
    else if ( document.order_info.ActionResult.value == "vcnt" )
    {
      document.order_info.pay_method.value = "VCNT";
      document.order_info.pay_mod.value = "O";
    }
 /*    else if ( document.order_info.ActionResult.value == "mobx" )
    {
      document.order_info.pay_method.value = "MOBX";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "ocb" )
    {
      document.order_info.pay_method.value = "TPNT";
      document.order_info.van_code.value = "SCSK";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "tpnt" )
    {
      document.order_info.pay_method.value = "TPNT";
      document.order_info.van_code.value = "SCWB";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "scbl" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCBL";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "sccl" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCCL";
      document.order_info.pay_mod.value = "N";
    }
    else if ( document.order_info.ActionResult.value == "schm" )
    {
      document.order_info.pay_method.value = "GIFT";
      document.order_info.van_code.value = "SCHM";
      document.order_info.pay_mod.value = "N";
    } */
  }
  
  function submitPay(){
	  $("#btn_submit").trigger("click");
  }
  
  $(window).load(function() {
  	setTimeout("submitPay();",500);
  });        
</script>
</head>

<body onload="chk_pay();create_goodInfo();">
<div id="sample_wrap">
<form name="order_info" method="post" accept-charset="euc-kr">
  <!-- 타이틀 -->
  <div class="sample" style="display:none;">

    <!-- 상단 문구 -->
    <p>
      이 페이지는 결제를 요청하는 페이지입니다
    </p>

    <!-- 주문 정보 -->
    <h2>&sdot; 주문 정보</h2>
    <table class="tbl" cellpadding="0" cellspacing="0">
      <tr>
        <th>지불 방법</th>
        <td>
				<c:if test="${order.orderPay[0].payWay == 'OR00801'}">
				<input type="text" name="ActionResult" value="card">
				</c:if>
				<c:if test="${order.orderPay[0].payWay == 'OR00802'}">
				<input type="text" name="ActionResult" value="acnt">
				</c:if>
				<c:if test="${order.orderPay[0].payWay == 'OR00803'}">
				<input type="text" name="ActionResult" value="vcnt">
				</c:if>   
        </td>
      </tr>
      <tr>
        <th>주문 번호</th>
        <td><input type="text" name="ordr_idxx" value="${order.ordNo }" maxlength="40"/></td>
      </tr>
      <tr>
        <th>상품명</th>
        <td><input type="text" name="good_name" value="[${order.orderGoods[0].brnd }]${order.orderGoods[0].ubiGdsNm } 외 ${fn:length(order.orderGoods)-1} 개"/></td>
      </tr>
      <tr>
        <th>결제 금액</th>
        <td><input type="text" name="good_mny" value="${totalSlAmt+deliveryCost-order.orderPay[1].payAmt }" maxlength="9"/></td>
      </tr>
      <tr>
        <th>주문자명</th>
        <td><input type="text" name="buyr_name" value="${order.ordrNm }"/></td>
      </tr>
      <tr>
        <th>E-mail</th>
        <td><input type="text" name="buyr_mail" value="${order.ordrEmail }"/></td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td><input type="text" name="buyr_tel1" value="${order.ordrTel }"/></td>
      </tr>
      <tr>
        <th>휴대폰번호</th>
        <td><input type="text" name="buyr_tel2" value="${order.ordrCp }"/></td>
      </tr>
    </table>

        <!-- 에스크로 정보 필드 (에스크로 신청 가맹점은 필수로 값 세팅)-->
    <h2>&sdot; 에스크로 정보</h2>
    <table class="tbl" cellpadding="0" cellspacing="0">
      <tr>
        <th>수취인이름</th>
        <td><input type="text" name="rcvr_name" value="${order.rcpnNm }"/></td>
      </tr>
      <tr>
        <th>수취인 연락처</th>
        <td><input type="text" name="rcvr_tel1" value="${order.rcpnTelNo }"/></td>
      </tr>
      <tr>
        <th>수취인 휴대폰번호</th>
        <td><input type="text" name="rcvr_tel2" value="${order.rcpnCpNo }"/></td>
      </tr>
      <tr>
        <th>수취인 E-mail</th>
        <td><input type="text" name="rcvr_mail" value="${order.ordrEmail }"/></td>
      </tr>
      <tr>
        <th>수취인 우편번호</th>
        <td><input type="text" name="rcvr_zipx" value="${order.rcpnZipCd }"/></td>
      </tr>
      <tr>
        <th>수취인 주소</th>
        <td><input type="text" name="rcvr_add1" value="${order.rcpnBsAddr }"/></td>
      </tr>
      <tr>
        <th>수취인 상세주소</th>
        <td><input type="text" name="rcvr_add2" value="${order.rcpnDtlAddr }"/></td>
      </tr>
    </table>

    <!-- 결제 요청/처음으로 이미지 -->
    <div class="footer">
        <b>※ PC에서 결제요청시 오류가 발생합니다. ※</b>
    </div>
    <div class="btnset" id="display_pay_button" style="display:block">
      <input name="" type="button" id="btn_submit" class="submit" value="결제요청" onclick="kcp_AJAX();">
    </div>
  </div>
  <!--footer-->
  <div class="footer" style="display:none;">
    Copyright (c) KCP INC. All Rights reserved.
  </div>
  <!--//footer-->
  
  <!-- 공통정보 -->
  <input type="hidden" name="req_tx"          value="pay">                           <!-- 요청 구분 -->
  <input type="hidden" name="shop_name"       value="<%= g_conf_site_name %>">     <!-- 사이트 이름 --> 
  <input type="hidden" name="site_cd"         value="<%= g_conf_site_cd   %>">     <!-- 사이트 키 -->
  <input type="hidden" name="currency"        value="410"/>                          <!-- 통화 코드 -->
  <input type="hidden" name="eng_flag"        value="N"/>                            <!-- 한 / 영 -->
  <!-- 결제등록 키 -->
  <input type="hidden" name="approval_key"    id="approval">
  <!-- 인증시 필요한 파라미터(변경불가)-->
	<c:if test="${order.orderPay[0].payWay == 'OR00801'}">
	<input type="hidden" name="pay_method"  value="CARD"/><br/>
	</c:if>
	<c:if test="${order.orderPay[0].payWay == 'OR00802'}">
	<input type="hidden" name="pay_method"  value="BANK"/><br/>
	</c:if>
	<c:if test="${order.orderPay[0].payWay == 'OR00803'}">
	<input type="hidden" name="pay_method"  value="VCNT"/><br/>
	</c:if>  
  <input type="hidden" name="van_code"        value="<%=van_code%>">
  <!-- 신용카드 설정 -->
  <input type="hidden" name="quotaopt"        value="12"/>                           <!-- 최대 할부개월수 -->
  <!-- 가상계좌 설정 -->
  <input type="hidden" name="ipgm_date"       value="2"/>
  <!-- 가맹점에서 관리하는 고객 아이디 설정을 해야 합니다.(필수 설정) -->
  <input type="hidden" name="shop_user_id"    value=""/>
  <!-- 복지포인트 결제시 가맹점에 할당되어진 코드 값을 입력해야합니다.(필수 설정) -->
  <input type="hidden" name="pt_memcorp_cd"   value=""/>
  <!-- 현금영수증 설정 -->
  <input type="hidden" name="disp_tax_yn"     value="Y"/>
  <!-- 리턴 URL (kcp와 통신후 결제를 요청할 수 있는 암호화 데이터를 전송 받을 가맹점의 주문페이지 URL) -->
  <input type="hidden" name="Ret_URL"         value="<%=url%>">
  <!-- 화면 크기조정 -->
  <input type="hidden" name="tablet_size"     value="<%=tablet_size%>">

  <!-- 결제 정보 등록시 응답 타입 ( 필드가 없거나 값이 '' 일경우 TEXT, 값이 XML 또는 JSON 지원 -->
  <input type="hidden" name="response_type"  value="TEXT"/>
  <input type="hidden" name="PayUrl"   id="PayUrl"   value=""/>
  <input type="hidden" name="traceNo"  id="traceNo"  value=""/>

  <!-- 추가 파라미터 ( 가맹점에서 별도의 값전달시 param_opt 를 사용하여 값 전달 ) -->
  <input type="hidden" name="param_opt_1"     value="">
  <input type="hidden" name="param_opt_2"     value="">
  <input type="hidden" name="param_opt_3"     value="">

<%
    /* ============================================================================== */
    /* =   에스크로결제 사용시 필수 정보                                            = */
    /* = -------------------------------------------------------------------------- = */
    /* =   결제에 필요한 주문 정보를 입력 및 설정합니다.                            = */
    /* = -------------------------------------------------------------------------- = */
%>
  <!-- 에스크로 사용유무 에스크로 사용 업체(가상계좌, 계좌이체 해당)는 escw_used 를 Y로 세팅 해주시기 바랍니다.-->
  <input type="hidden" name="escw_used"  value="Y">
  <!-- 장바구니 상품 개수 -->
  <input type="hidden"  name="bask_cntx" value="${fn:length(order.orderGoods) }"/>
  <!-- 장바구니 정보(상단 스크립트 참조) -->
  <input type='hidden' name='good_info'  value="">
  <!-- 에스크로 결제처리모드 KCP 설정된 금액 결제(전체금액 : Y 설정된금액적용: O 사용안함: N)-->
	<c:if test="${order.orderPay[0].payWay == 'OR00801'}">
		<!-- 에스크로 결제처리 모드 : 에스크로: Y, 일반: N, KCP 설정 조건: O  -->
		<input type="hidden" name="pay_mod"         value="N"/>
	</c:if>
	<c:if test="${order.orderPay[0].payWay != 'OR00801'}">
		<!-- 에스크로 결제처리 모드 : 에스크로: Y, 일반: N, KCP 설정 조건: O  -->
		<input type="hidden" name="pay_mod"         value="Y"/>
	</c:if>  
  <!-- 배송소요기간 -->
  <input type="hidden" name='deli_term'  value='03'>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   에스크로결제 사용시 필수 정보  END                                       = */
    /* ============================================================================== */
%>
<%
    /* ============================================================================== */
    /* =   옵션 정보                                                                = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 옵션 - 결제에 필요한 추가 옵션 정보를 입력 및 설정합니다.             = */
    /* = -------------------------------------------------------------------------- = */
    /* 카드사 리스트 설정
    예) 비씨카드와 신한카드 사용 설정시
    <input type="hidden" name='used_card'    value="CCBC:CCLG">

    /*  무이자 옵션
            ※ 설정할부    (가맹점 관리자 페이지에 설정 된 무이자 설정을 따른다)                             - "" 로 설정
            ※ 일반할부    (KCP 이벤트 이외에 설정 된 모든 무이자 설정을 무시한다)                           - "N" 로 설정
            ※ 무이자 할부 (가맹점 관리자 페이지에 설정 된 무이자 이벤트 중 원하는 무이자 설정을 세팅한다)   - "Y" 로 설정
    <input type="hidden" name="kcp_noint"       value=""/> */

    /*  무이자 설정
            ※ 주의 1 : 할부는 결제금액이 50,000 원 이상일 경우에만 가능
            ※ 주의 2 : 무이자 설정값은 무이자 옵션이 Y일 경우에만 결제 창에 적용
            예) 전 카드 2,3,6개월 무이자(국민,비씨,엘지,삼성,신한,현대,롯데,외환) : ALL-02:03:04
            BC 2,3,6개월, 국민 3,6개월, 삼성 6,9개월 무이자 : CCBC-02:03:06,CCKM-03:06,CCSS-03:06:04
    <input type="hidden" name="kcp_noint_quota" value="CCBC-02:03:06,CCKM-03:06,CCSS-03:06:09"/> */

    /* KCP는 과세상품과 비과세상품을 동시에 판매하는 업체들의 결제관리에 대한 편의성을 제공해드리고자, 
       복합과세 전용 사이트코드를 지원해 드리며 총 금액에 대해 복합과세 처리가 가능하도록 제공하고 있습니다
       복합과세 전용 사이트 코드로 계약하신 가맹점에만 해당이 됩니다
       상품별이 아니라 금액으로 구분하여 요청하셔야 합니다
       총결제 금액은 과세금액 + 부과세 + 비과세금액의 합과 같아야 합니다. 
       (good_mny = comm_tax_mny + comm_vat_mny + comm_free_mny)
    
        <input type="hidden" name="tax_flag"       value="TG03">  <!-- 변경불가	   -->
        <input type="hidden" name="comm_tax_mny"   value=""    >  <!-- 과세금액	   -->
        <input type="hidden" name="comm_vat_mny"   value=""    >  <!-- 부가세	   -->
        <input type="hidden" name="comm_free_mny"  value=""    >  <!-- 비과세 금액 --> */
    /* = -------------------------------------------------------------------------- = */
    /* =   옵션 정보 END                                                            = */
    /* ============================================================================== */
%>

</form>
</div>

<!-- 스마트폰에서 KCP 결제창을 레이어 형태로 구현-->
<div id="layer_all" style="position:absolute; left:0px; top:0px; width:100%;height:100%; z-index:1; display:none;">
    <table height="100%" width="100%" border="-" cellspacing="0" cellpadding="0" style="text-align:center">
        <tr height="100%" width="100%">
            <td>
                <iframe name="frm_all" frameborder="0" marginheight="0" marginwidth="0" border="0" width="100%" height="100%" scrolling="auto"></iframe>
            </td>
        </tr>
    </table>
</div>
<form name="pay_form" method="post" action="<%=curDomain %>/front/order/orderPayWeb">
    <input type="hidden" name="req_tx"         value="<%=req_tx%>">               <!-- 요청 구분          -->
    <input type="hidden" name="res_cd"         value="<%=res_cd%>">               <!-- 결과 코드          -->
    <input type="hidden" name="tran_cd"        value="<%=tran_cd%>">              <!-- 트랜잭션 코드      -->
    <input type="hidden" name="ordr_idxx"      value="<%=ordr_idxx%>">            <!-- 주문번호           -->
    <input type="hidden" name="good_mny"       value="<%=good_mny%>">             <!-- 휴대폰 결제금액    -->
    <input type="hidden" name="good_name"      value="<%=good_name%>">            <!-- 상품명             -->
    <input type="hidden" name="buyr_name"      value="<%=buyr_name%>">            <!-- 주문자명           -->
    <input type="hidden" name="buyr_tel1"      value="<%=buyr_tel1%>">            <!-- 주문자 전화번호    -->
    <input type="hidden" name="buyr_tel2"      value="<%=buyr_tel2%>">            <!-- 주문자 휴대폰번호  -->
    <input type="hidden" name="buyr_mail"      value="<%=buyr_mail%>">            <!-- 주문자 E-mail      -->
    <input type="hidden" name="cash_yn"        value="<%=cash_yn%>">              <!-- 현금영수증 등록여부-->
    <input type="hidden" name="enc_info"       value="<%=enc_info%>">
    <input type="hidden" name="enc_data"       value="<%=enc_data%>">
    <input type="hidden" name="use_pay_method" value="<%=use_pay_method%>">
    <input type="hidden" name="cash_tr_code"   value="<%=cash_tr_code%>">
    <!-- 추가 파라미터 -->
    <input type="hidden" name="param_opt_1"	   value="<%=param_opt_1%>">
    <input type="hidden" name="param_opt_2"	   value="<%=param_opt_2%>">
    <input type="hidden" name="param_opt_3"	   value="<%=param_opt_3%>">
</form>
</body>
</html>