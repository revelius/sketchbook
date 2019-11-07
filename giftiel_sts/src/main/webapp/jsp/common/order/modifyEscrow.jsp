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
    /* ============================================================================== */
    /* =   PAGE : 에스크로 상태 변경 PAGE                                           = */
    /* = -------------------------------------------------------------------------- = */
    /* =   아래의 ※ 주의 ※ 부분을 꼭 참고하시어 연동을 진행하시기 바랍니다.       = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
	<%@ page import="com.kcp.*" %>
	<%@ page import="com.giftiel.shop.dao.*" %>
	<%@ page import="com.giftiel.shop.dto.*" %>
	<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
	<%@ page import="org.springframework.web.context.WebApplicationContext" %>
	<%@ page import="java.net.URLEncoder"%>
	<%@ include file="site_conf_inc.jsp"%>
	<script type="text/javascript" src="<c:url value='/resources/admin/js/jquery-1.11.2.min.js'/>"></script>
<%
WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
OrderDao orderDao = (OrderDao)wac.getBean("orderDao");
PointDao pointDao = (PointDao)wac.getBean("pointDao");

String ordNo = request.getParameter("ordNo");
Integer cancelAmt = 0;

String dlvCls = "";
if(request.getParameter("dlvCls") != null){
	dlvCls = request.getParameter("dlvCls");
}

Integer ordGdsSeq = 0;
boolean halfFlag = false;
if(request.getParameter("ordGdsSeq") != ""){
	ordGdsSeq = Integer.parseInt(request.getParameter("ordGdsSeq"));
	halfFlag = true;
}

SearchForm searchForm = new SearchForm();
searchForm.setOrdNo(ordNo);
Order order = orderDao.selectOrder(searchForm);

cancelAmt = order.getOrderPay().get(0).getPayAmt();

int orderGdsSeq = 0;
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>*** KCP [AX-HUB Version] ***</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

    <script language="javascript">
    function  jsf__go_mod(form)
    {
        if(form.mod_type.value=="mod_type_not_sel")
        {
          alert( "상태변경 구분을 선택하십시오.");
        }
        else if ( form.tno.value.length < 14 )
        {
            alert( "KCP 거래 번호를 입력하세요." );
            form.tno.focus();
            form.tno.select();
        }

        else if(form.mod_type.value() == 1 && form.deli_numb.value=="")
        {
            alert( "운송장 번호를 입력하세요." );
            form.deli_numb.focus();
            form.deli_numb.select();
        }
        else if(form.mod_type.selectedIndex == 1 && form.deli_corp.value=="")
        {
            alert( "택배 업체명을 입력하세요." );
            form.deli_corp.focus();
            form.deli_corp.select();
        }
        else if((form.mod_type.selectedIndex == 2 || form.mod_type.selectedIndex == 4) && form.vcnt_use_yn.checked && form.mod_account.value=="")
        {
            alert( "환불 수취 계좌번호를 입력하세요." );
            form.mod_account.focus();
            form.mod_account.select();
        }
        else if((form.mod_type.selectedIndex == 2 || form.mod_type.selectedIndex == 4) && form.vcnt_use_yn.checked && form.mod_depositor.value=="")
        {
            alert( "환불 수취 계좌주명을 입력하세요." );
            form.mod_depositor.focus();
            form.mod_depositor.select();
        }
        else if((form.mod_type.selectedIndex == 2 || form.mod_type.selectedIndex == 4) && form.vcnt_use_yn.checked && form.mod_bankcode.value=="mod_bankcode_not_sel")
        {
            alert( "환불 수취 은행코드를 선택해 주세요." );
        }
        else
        {
            return true ;
        }
        return false;
    }
    function typeChk()
    {
        if ($("#mod_type").val() == 'STE1')
        {
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE1.style.display = "block";
            type_STE9.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
        }
        else if ($("#mod_type").val() == 'STE2' || $("#mod_type").val() == 'STE4')
        {
            type_STE1.style.display = "none";
            type_STE5.style.display = "none";
            type_STE2N4.style.display = "block";
            type_STE9.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
        }
        else if ($("#mod_type").val() == 'STE5')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "block";
            type_STE9.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
        }
        else if ($("#mod_type").val() == 'STE9_C')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
            type_STE9.style.display = "block";
        }
        else if ($("#mod_type").val() == 'STE9_CP')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "block";
            type_STE9_2.style.display = "block";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
            type_STE9.style.display = "block";
        }
        else if ($("#mod_type").val() == 'STE9_A')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
            type_STE9.style.display = "block";
        }
        else if ($("#mod_type").val() == 'STE9_AP')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "block";
            type_STE9_2.style.display = "block";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "none";
            type_STE9.style.display 	= "block";
        }
        else if ($("#mod_type").val() == 'STE9_AR')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "block";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "block";
            type_STE9.style.display = "block";
        }
        else if ($("#mod_type").val() == 'STE9_V')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "none";
            type_STE9_2.style.display = "none";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "block";
            type_STE9.style.display = "block";
        }
        else if ($("#mod_type").val() == 'STE9_VP')
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
            type_STE9_1.style.display = "block";
            type_STE9_2.style.display = "block";
            type_STE9_3.style.display = "none";
            type_STE9_4.style.display = "block";
            type_STE9.style.display = "block";
        }
        else
        {
            type_STE1.style.display = "none";
            type_STE2N4.style.display = "none";
            type_STE5.style.display = "none";
        }
    }

    function selfDeliChk( form )
    {
        if (form.self_deli_yn.checked)
        {
            form.deli_numb.value = "0000";
            form.deli_corp.value = "자가배송";
        }
        else
        {
            form.deli_numb.value = "";
            form.deli_corp.value = "";
        }
    }

    function vcntUseChk( form )
    {
        if (form.vcnt_use_yn.checked)
        {
            type_RFND.style.display = "block";
            form.vcnt_yn.value = "Y";
        }
        else
        {
            type_RFND.style.display = "none";
            form.vcnt_yn.value = "N";
        }
    }
    
    //페이지 init
    $(window).load(function() {
    	typeChk();
    });     
    </script>
</head>

<body>

<div id="sample_wrap">
<%
    /* ============================================================================== */
    /* =    상태변경 요청 입력 폼(mod_escrow_form)                                  = */
    /* = -------------------------------------------------------------------------- = */
    /* =   상태변경 요청에 필요한 정보를 설정합니다.                                = */
    /* = -------------------------------------------------------------------------- = */
%>
    <form name="mod_escrow_form" id="mod_escrow_form" method="post" action="updateOrderProcess" accept-charset="EUC-KR">
    	<input type="text" name="ordNo" value="${ordNo }" />
    	<input type="text" name="ordGdsSeq" value="${ordGdsSeq }" />
    	<input type="text" name="modType" value="${modType }" />
    	<input type="text" name="payWay" value="${payWay }" />
    	<input type="text" name="perOrdStat" value="${perOrdStat }" />
    	<input type="text" name="dlvCls" value="${dlvCls }" />
                <!-- 취소 요청 정보 입력 테이블 Start -->
                    <h2>&sdot; 에스크로 상태변경 요청</h2>
                    <table class="tbl" cellpadding="0" cellspacing="0">
                <!-- 요청 구분 : 에스크로 상태변경 요청 -->
                <!-- 요청 구분 : 배송시작, 즉시취소, 정산보류, 취소, 발급계좌해지 -->
                    <tr>
                        <th>상태변경 구분</th>
                        <td>
                            <c:if test="${modType =='STE1' }"><input type="text" id="mod_type" name="mod_type" value="STE1"/></c:if>
                            <c:if test="${modType =='STE2' }"><input type="text" id="mod_type" name="mod_type" value="STE2"/></c:if>
                            <c:if test="${modType =='STE3' }"><input type="text" id="mod_type" name="mod_type" value="STE3"/></c:if>
                            <c:if test="${modType =='STE4' }"><input type="text" id="mod_type" name="mod_type" value="STE4"/></c:if>
                            <c:if test="${modType =='STE5' }"><input type="text" id="mod_type" name="mod_type" value="STE5"/></c:if>
                            <c:if test="${modType =='STE9_C' }"><input type="text" id="mod_type" name="mod_type" value="STE9_C"/></c:if>
                            <c:if test="${modType =='STE9_CP' }"><input type="text" id="mod_type" name="mod_type" value="STE9_CP"/></c:if>
                            <c:if test="${modType =='STE9_A' }"><input type="text" id="mod_type" name="mod_type" value="STE9_A"/></c:if>
                            <c:if test="${modType =='STE9_AP' }"><input type="text" id="mod_type" name="mod_type" value="STE9_AP"/></c:if>
                            <c:if test="${modType =='STE9_AR' }"><input type="text" id="mod_type" name="mod_type" value="STE9_AR"/></c:if>
                            <c:if test="${modType =='STE9_V' }"><input type="text" id="mod_type" name="mod_type" value="STE9_V"/></c:if>
                            <c:if test="${modType =='STE9_VP' }"><input type="text" id="mod_type" name="mod_type" value="STE9_VP"/></c:if>
                        </td>
                    </tr>
                    <!-- KCP 거래번호(tno) -->
                    <tr>
                        <th>KCP 거래번호</th>
                        <td><input type="text" name="tno" value="<%=order.getKcpHist().get(0).getTno() %>"  class="frminput" size="20" maxlength="14"/></td>
                    </tr>
              </table>
              <span id="type_STE1" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr style="display:none">
                      <th>자가배송여부</th>
                      <td>&nbsp;&nbsp;&nbsp;자가배송의 경우 체크&nbsp;<input type='checkbox' name='self_deli_yn' onClick='selfDeliChk(this.form)'></td>
                  </tr>
                  <tr>
                      <th>운송장번호</th>
                      <td><input type='text' name='deli_numb' value='<%=order.getOrderGoods().get(orderGdsSeq).getInvNo() %>' class="frminput" size='20' maxlength='25'></td>
                  </tr>
                  <tr>
                      <th>택배 업체명</th>
                      <td><input type='text' name='deli_corp' value='<%=order.getOrderGoods().get(orderGdsSeq).getDlvCmpNm() %>' class="frminput" size='20' maxlength='25'></td>
                  </tr>
              </table>
              </span>
              <span id="type_STE2N4" style="">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>가상계좌 거래</th>
                      <td>
                          &nbsp;&nbsp;&nbsp;가상계좌 취소&nbsp;<input type='checkbox' name='vcnt_use_yn' onClick='vcntUseChk(this.form)'>
                      </td>
                  </tr>
              </table>
              <div id="type_RFND" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>환불수취계좌번호</th>
                      <td>
                          <input type='text' name='mod_account' class="frminput" value='${order.orderClm[0].rfndAcctNo}' size='23' maxlength='50'>
                      </td>
                  </tr>
                  <tr>
                      <th>환불수취계좌주명</th>
                      <td>
                          <input type='text' name='mod_depositor' value='' class="frminput" size='23' maxlength='50'>
                      </td>
                  </tr>
                  <tr>
                      <th>환불수취은행코드</th><!-- 기타 합병된 은행이나 증권사는 매뉴얼을 참고하시기 바랍니다 -->
                      <td>
                          <select name='mod_bankcode'>
                              <option value="mod_bankcode_not_sel" selected>선택</option>
                              <option value="39">경남은행</option>
                              <option value="34">광주은행</option>
                              <option value="04">국민은행</option>
                              <option value="03">기업은행</option>
                              <option value="11">농협</option>
                              <option value="31">대구은행</option>
                              <option value="32">부산은행</option>
                              <option value="45">새마을금고</option>
                              <option value="07">수협</option>
                              <option value="88">신한은행</option>
                              <option value="48">신협</option>
                              <option value="05">외환은행</option>
                              <option value="20">우리은행</option>
                              <option value="71">우체국</option>
                              <option value="35">제주은행</option>
                              <option value="81">하나은행</option>
                              <option value="27">한국시티은행</option>
                              <option value="54">HSBC</option>
                              <option value="23">SC제일은행</option>
                              <option value="02">산업은행</option>
                              <option value="37">전북은행</option>
                          </select>
                      </td>
                  </tr>
              </table>
              </div>
              </span>
              <span id="type_STE5" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <td><center>발급계좌해지 요청은 가상계좌 결제에 대해서만 이용하시기 바랍니다.</center></td>
                  </tr>
              </table>
              </span>
              <span id="type_STE9_1" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>남아있는금액</th>
                          <td>
                              <input type='text' name='rem_mny' value='<%=order.getOrderPay().get(0).getPayAmt()-order.getOrderPay().get(0).getCnclAmt() %>' size='20' maxlength='20'>원
                          </td>
                  </tr>
              </table>
              </span>
              <span id="type_STE9_2" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>취소요청금액</th>
                          <td>
                              <input type='text' name='mod_mny' value='<%=cancelAmt %>' size='20' maxlength='20'>원
                          </td>
                  </tr>
              </table>
              </span>

              <span id="type_STE9_3" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>과세 취소 요청금액</th>
                          <td>
                              <input type='text' name='tax_mny' value='' size='20' maxlength='20'>원
                          </td>
                  </tr>
                  <tr>
                      <th>비과세 취소 요청금액</th>
                          <td>
                              <input type='text' name='free_mod_mny' value='' size='20' maxlength='20'>원
                          </td>
                  </tr>
                  <tr>
                      <th>부과세 취소 요청금액</th>
                          <td>
                              <input type='text' name='add_tax_mny' value='' size='20' maxlength='20'>원
                          </td>
                  </tr>
              </table>
              </span>

              <span id="type_STE9_4" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>환불계좌번호</th>
                          <td>
                              <input type='text' name='a_refund_account' value='' size='23' maxlength='50'>
                          </td>
                  </tr>
                  <tr>
                      <th>환불계좌주명</th>
                          <td>
                              <input type='text' name='a_refund_nm' value='' size='23' maxlength='50'>
                          </td>
                  </tr>
                  <tr>
                      <th>환불은행코드</th>
                          <td>
                              <select name='a_bank_code'>
                              <option value="bank_code_not_sel" selected>선택</option>
                              <option value="39">경남은행</option>
                              <option value="34">광주은행</option>
                              <option value="04">국민은행</option>
                              <option value="03">기업은행</option>
                              <option value="11">농협</option>
                              <option value="31">대구은행</option>
                              <option value="32">부산은행</option>
                              <option value="45">새마을금고</option>
                              <option value="07">수협</option>
                              <option value="88">신한은행</option>
                              <option value="48">신협</option>
                              <option value="05">외환은행</option>
                              <option value="20">우리은행</option>
                              <option value="71">우체국</option>
                              <option value="35">제주은행</option>
                              <option value="81">하나은행</option>
                              <option value="27">한국시티은행</option>
                              <option value="54">HSBC</option>
                              <option value="23">SC제일은행</option>
                              <option value="02">산업은행</option>
                              <option value="37">전북은행</option>
                              </select>
                          </td>
                  </tr>
              </table>
              </span>
              <span id="type_STE9" style="display:none">
              <table class="tbl" cellpadding="0" cellspacing="0">
                  <tr>
                      <th>승인취소사유</th>
                          <td>
                              <input type='text' name='mod_desc_cd' value='CA06'>
                          </td>
                  </tr>
                  <tr>
                      <th>취소사유</th>
                          <td>
                              <input type='text' name='mod_desc' value='주문취소' size='40' maxlength='40'>
                          </td>
                  </tr>
              </table>
              </span>
                    <!-- 에스크로 상태변경 요청/처음으로 버튼 테이블 START -->
                    <div class="btnset">
                            <input name="" id="escrowUpdateSendBtn" type="submit" class="submit" value="변경요청" onclick="return jsf__go_mod(this.form);" alt="에스크로 상태변경을 요청합니다"/>
                            <a href="javascript:typeChk();" class="home" alt="처음으로 이동합니다" />reset</a>
                    </div>
                    <!-- 에스크로 상태변경 요청/처음으로 버튼 테이블 End -->
                </div>
            <div class="footer">
                Copyright (c) KCP INC. All Rights reserved.
            </div>
<%
    /* ============================================================================== */
    /* =   에스크로 상태변경 요청 필수 정보 설정                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   ※ 필수 - 반드시 필요한 정보입니다.                                      = */
    /* = -------------------------------------------------------------------------- = */
%>
        <input type="hidden" name="req_tx"   value="mod_escrow" />
        <c:if test="${modType =='STE9_VP' }">
        	<input type="hidden" name="vcnt_yn"  value="Y" />
        </c:if>
        <c:if test="${modType !='STE9_VP' }">
        	<input type="hidden" name="vcnt_yn"  value="N" />
        </c:if>
        
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   에스크로 상태변경 요청 정보 END                                          = */
    /* ============================================================================== */
%>
    </form>
</div>
</body>
</html>
