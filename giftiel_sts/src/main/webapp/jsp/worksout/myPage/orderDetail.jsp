<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-09
 *
 * 파일 내용 : 주문상세
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		
		<script type="text/javascript">
    		$(function() { 
    			
    			//우체국 배송조회
	   			$("a[data-btn='btn_delivery']").on("click",function(e) {
	   				e.preventDefault();
	   				var $target = $(e.currentTarget);
	   				var invNo = $target.attr("data-invNo");
	   				var dlvCmpSrc = $target.attr("data-dlvCmpSrc");
    				openDlvPop(invNo, dlvCmpSrc);
    		    });
    			
	   			//반품신청
	   			$("a[data-btn='btn_return']").on("click",function(e) {
	   				e.preventDefault();
	   				
	   				var form = document.hiddenForm;
	   				form.action = "<c:url value='/front/myPage/orderReturnApply01'/>";
	   				form.submit();
    		    });
	   			
	   			
	   			
	   			//교환신청
	   			$("a[data-btn='btn_change']").on("click",function(e) {
	   				e.preventDefault();
	   				
	   				var form = document.hiddenForm;
	   				form.action = "<c:url value='/front/myPage/orderChangeApply01'/>";
	   				form.submit();
    		    });
    			
    			
    			//주문서 출력
    			openOrderPrint = function() {
    				var popUrl = "<c:url value='/front/myPage/popUpOrderPrint?orderNo=${order.ordNo}'/>";	//팝업창에 출력될 페이지 URL
    				var popOption = "width=1270, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
    					window.open(popUrl,"",popOption);
    			};
    			
    		});
    		
    		// 동적으로 form 생성
    		function create_form(nm,mt,ac,tg) {
    		    var fm = document.createElement("form");
    		    fm.name = nm;
    		    fm.method = mt;
    		    fm.action = ac;
    		    fm.target = tg;
    		      
    		    return fm;
    		}
    		
    		// 동적으로 input 객체 생성
    		function add_input(fm,nm,vu){
    		    var input = document.createElement("input");
    		    input.type = "hidden";
    		    input.name = nm;
    		    input.value =  vu;
    		    fm.insertBefore(input,null);
    		    return fm;
    		}    	
    		
    		//공통 취소팝업
    		function updateOrderProcess(ordNo, ordGdsSeq, modType, perOrdStat, payWay){
				<c:if test="${order.orderPay[0].payWay == 'OR00803' && order.ordStat != 'OR00202'}"><!-- 가상계좌 -->
					if($('#mod_bankcode').val()=="mod_bankcode_not_sel"){
						alert("환불 받으실 은행을 선택해주세요.");
						$('#mod_bankcode').focus();
						return false;
					}
					if($('#mod_account').val()==""){
						alert("환불 받으실 계좌번호를 입력해주세요.");
						$('#mod_account').focus();
						return false;
					}
					if($('#mod_depositor').val()==""){
						alert("환불 받으실 계좌주명을 입력해주세요.");
						$('#mod_depositor').focus();
						return false;
					}
				</c:if>    			
    			
		    	if (confirm("주문취소 하시겠습니까?") == false){    //확인
		    	    return false;
		    	}    			
    			
    			$("#cancelBtn").hide();
    			
    		    var frm = create_form('dummy', 'POST', '<c:url value="/front/order/modifyOrderGoodsStat"/>', 'dummyPop');
    		    fm = add_input(frm,'ordNo',ordNo);
    		    fm = add_input(frm,'ordGdsSeq',ordGdsSeq);
    		    fm = add_input(frm,'modType',modType);
    		    fm = add_input(frm,'perOrdStat',perOrdStat);
    		    fm = add_input(frm,'payWay',payWay);
    		   document.body.insertBefore(fm,null);

    		   //  post 방식으로 popup을 open하기 위하여 url을 공백으로 넘긴다.
    		   //window.open('','dummy',"width=500, height=500, resizable=no, scrollbars=no, status=no;"); 
    		 
    		   fm.target = 'cancelFrame';
    		   fm.submit();

				<c:if test="${order.orderPay[0].payWay == 'OR00802' || order.orderPay[0].payWay == 'OR00803'}"><!-- 가상계좌 -->
					setTimeout("vctlCancelData();",1000);
				</c:if>
    		}  
    		
    		function documentReload(){
    			location.href="/front/myPage/orderList";
    		}

    		
    		function vctlCancelData(){
				<c:if test="${order.orderPay[0].payWay == 'OR00803'}">
	    			$('#cancelFrame').contents().find("[name='mod_bankcode']").val($('#mod_bankcode').val());
	    			$('#cancelFrame').contents().find("[name='mod_account']").val($('#mod_account').val());
	    			$('#cancelFrame').contents().find("[name='mod_depositor']").val($('#mod_depositor').val());
	    			$('#cancelFrame').contents().find("[name='vcnt_use_yn']").attr("checked", true);
	    			$('#cancelFrame').contents().find("[name='vcnt_yn']").val("Y");
				</c:if>    			
    			$('#cancelFrame').contents().find("[id='mod_escrow_form']").submit();
    			
    			setTimeout("resultCheck();",3000);
    		}
    		
    		function resultCheck(){
    			if($('#cancelFrame').contents().find("[name='result_code']").val() == '0000'){
    				alert("주문이 취소되었습니다.");
    				location.href="/front/myPage/orderList";
    			}else{
    				alert("주문취소가 실패하였습니다. 온라인 팀 02-541-0852로 문의주시기 바랍니다.");
    				location.href="/front/myPage/orderList";
    			}
    		}
   		</script>
		
		
	</head>
	<body>
		<form id="hiddenForm" name="hiddenForm" method="post" >
			<input type="hidden" name="orderNo"  id="orderNo"  value="${order.ordNo}"/>
		</form>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap">
			<h2 class="hide_txt">주요 메뉴 영역</h2>
			<div id="header">
				<!-- header include -->
				<!-- header include -->
			</div>
			<h2 class="hide_txt">본문 영역</h2>
			<div id="container">
				<div id="content">
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">ORDER DETAIL</a>
							</li>
						</ul>
						<div class="menu_section">
							<c:choose>
							<c:when test="${nMemberFlag}">
								<div class="snb_depth01 on">
								<a href="#">ORDER LIST</a>
								<ul style="display:block;" class="snb_depth02_area">
									<li>
										<a href="<c:url value="/front/myPage/nMemOrderDetail"/>">주문 / 배송 내역</a>
									</li>
									<li>
										<a href="<c:url value="/front/myPage/nMemOrderCancelDetail"/>">취소 / 반품 내역</a>
									</li>
									<li>
										<a href="<c:url value="/front/myPage/nMemOrderChangeDetail"/>">교환내역</a>
									</li>
<!-- 									<li> -->
<%-- 										<a href="<c:url value='/front/myPage/nMemOrderAddPayDetail'/>">추가결제</a> --%>
<!-- 									</li> -->
								</ul>
								</div>
							</c:when>
							<c:otherwise>
								<div id="snb_mypage_area">
									<!-- snbMain include -->
									<!-- snbMain include -->
								</div>
							</c:otherwise>
							</c:choose>
							
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="mypage_area">
									<div class="mypage_tit clfix space03">
										<span class="txt01">주문/배송 내역</span>
									</div>
									<div class="order_detail_info01 clfix">
										<dl class="info_item01 clfix">
											<dt>주문번호
												<span class="bu">:</span>
											</dt>
											<dd>${order.ordNo}</dd>
										</dl>
										<dl class="info_item02 clfix">
											<dt>주문일시
												<span class="bu">:</span>
											</dt>
											<dd><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
										</dl>
										<span class="info_item03">
											<a href="#" class="btn_print" onclick="openOrderPrint();">주문서출력</a>
										</span>
									</div>
									<div class="mypage_tit clfix space02">
										<span class="txt01">주문정보</span>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>주문정보 테이블로 상품, 가격, 적립포인트, 상태를 확인 할 수 있습니다</caption>
										<thead>
											<tr>
												<th scope="col">NO</th>
												<th scope="col">상품</th>
												<th scope="col">가격</th>
												<th scope="col">적립포인트</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="cancelFlag" value="true"/>
											<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
											<tr>
												<td class="tbl_layout_no">
													<div class="mobile_th">NO</div>
													<div class="tbl_cont">${goodIndex.count}</div>
												</td>
												<td class="tbl_layout01 product_in_img02">
													<div class="mobile_th">상품</div>
													<div class="tbl_cont clfix">
														<a href="#" class="p_img">
															<img src="<c:url value="${uploadImage}${good.mainImg}"/>" alt="관리자에서 등록될 수 있도록 개발필요." style="width: 50px;height: 50px;">
														</a>
														<ul class="p_info">
															<li>[${good.brand}] ${good.ubiGdsNm}</li>
															<li>Color = ${good.ubiGdsColorNm} / Size = ${good.ubiGdsSize}</li>
															<li>${good.ubiGdsNo}</li>
														</ul>
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">가격</div>
													<div class="tbl_cont">
														<span class="ico_price">${good.slPrc}</span>
													</div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">적립포인트</div>
													<div class="tbl_cont">${good.expPnt}</div>
												</td>
												<td class="tbl_layout04">
													<div class="mobile_th">상태</div>
													<div class="tbl_cont">
														<span class="state">${good.perOrdStatNm}</span>
														<span class="btn_state">
															<c:if test="${good.perOrdStat eq 'OR00505'}"><!-- 배송완료 -->
																<a href="#" class="btn_underline01" data-btn="btn_return">반품신청</a>
																<a href="#" class="btn_underline01" data-btn="btn_change">교환신청</a>
															</c:if> 
															<a href="#" class="btn_underline01" data-btn="btn_delivery" data-invNo="${good.invNo}" data-dlvCmpSrc="${good.dlvRsPage}">배송추적</a>
															<c:if test="${good.perOrdStat eq 'OR00501'}"><!-- 결재대기 -->
																<%-- <a href="javascript:orderCancelPop('${order.ordNo }','${good.ordGdsSeq }');" class="btn_underline01">주문취소</a> --%>
															</c:if> 
															<c:if test="${good.perOrdStat eq 'OR00502'}"><!-- 결재완료 -->
																<%-- <a href="javascript:orderCancelPop('${order.ordNo }','${good.ordGdsSeq }','STSC','${order.orderPay[0].payWay }');" class="btn_underline01">결제취소</a> --%>
															</c:if> 
															
														</span>
													</div>
												</td>
											</tr>
											<c:if test="${good.perOrdStat == 'OR00503' || good.perOrdStat == 'OR00504' || good.perOrdStat == 'OR00505' || good.perOrdStat == 'OR00506' || good.perOrdStat == 'OR00507'
													 || good.perOrdStat == 'OR00508' || good.perOrdStat == 'OR00509' || good.perOrdStat == 'OR00510' || good.perOrdStat == 'OR00511'
													 || good.perOrdStat == 'OR00512' || good.perOrdStat == 'OR00513' || good.perOrdStat == 'OR00514' || good.perOrdStat == 'OR00515'}">
											
												<c:set var="cancelFlag" value="false"/>
											</c:if>
											</c:forEach>
										</tbody>
									</table>
									
									
									<!-- 더보기만 쓴다고 하면 .pagenavi.space01 이 클래스 영역의 HTML 지우면 됩니다. -->
									<!-- 페이징 및 더보기 영역이 필요하면 쓰고 불필요하면 주석부터 통으로 지우세요 -->
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>주문 정보 테이블로 총 가격, 포인트사용액, 배송비, 적립 예정포인트, 총 결제금액을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">총 가격</th>
												<th scope="col">배송비</th>
												<th scope="col">포인트사용액</th>
												<th scope="col">적립 예정포인트</th>
												<th scope="col">총 결제금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">총 가격</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${order.totalSlAmt}" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">배송비</div>
													<div class="tbl_cont">
														<c:choose>
															<c:when test="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst != ''}">
																+
																<fmt:formatNumber type="currency" value="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" />
															</c:when>
															<c:otherwise>
																+ 0
															</c:otherwise>	
														</c:choose>													
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">포인트사용액</div>
													<div class="tbl_cont clfix"><c:if test="${fn:length(order.orderPay) > 0}"><fmt:formatNumber type="currency" value="${order.totalPayAmt - order.totalSlAmt}" pattern="###,###" /></c:if></div>
												</td>
												<td class="tbl_layout04">
													<div class="mobile_th">적립 예정포인트</div>
													<div class="tbl_cont">${order.totalExpPnt}</div>
												</td>
												<td class="tbl_layout05">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont">
														<span class="ico_price"><fmt:formatNumber type="currency" value="${order.totalPayAmt + order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" /></span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<p class="mypage_txt_style02">- 포인트 적립율 변동 시, 기간별 적립 포인트가 상이할 수 있습니다.</p>
									<div class="mypage_tit clfix space01">
										<span class="txt01">주문자정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info04 floating">
												<li>
													<div class="tit">이름</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">전화번호</div>
													<div class="desc">${order.ordrTel}</div>
												</li>
												<li>
													<div class="tit">휴대폰번호</div>
													<div class="desc">${order.ordrCp}</div>
												</li>
												<li class="last_child">
													<div class="tit">주소</div>
													<div class="desc">${order.ordrBsAddr} ${order.ordrDtlAddr}</div>
												</li>
											</ul>
											<ul class="mypage_info04 floating">
												<li class="last_child">
													<div class="tit">배송시
														<br> 요청사항
													</div>
													<div class="desc">${order.dlvSvcMemo}
													</div>
												</li>
											</ul>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">결제정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00803'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">가상계좌 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">[${order.orderPay[0].orderPayVrtl[0].bankname}] ${order.orderPay[0].orderPayVrtl[0].account}</div>
												</li>
												<li>
													<div class="tit">예금주명</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00802'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">계좌이체 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">은행명</div>
													<div class="desc">${order.orderPay[0].orderPayRtm[0].bankName}</div>
												</li>
												<li>
													<div class="tit">입금자명</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00801'}">style="display: none;"</c:if>>	
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">신용카드 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">카드명</div>
													<div class="desc">${order.orderPay[0].orderPayCrd[0].cardName}</div>
												</li>
<!-- 												<li> -->
<!-- 													<div class="tit">카드번호</div> -->
<%-- 													<div class="desc"> ${order.orderPay[0].orderPayCrd[0].cardNo} </div> --%>
<!-- 												</li> -->
												<li class="last_child">
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
										</div>
									</div>
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
									<c:if test="${order.orderPay[0].payWay =='OR00803'}">
									<div class="mypage_tit clfix space01" id="vctlCancel01">
										<span class="txt01">가상계좌 환불 정보</span>
									</div>
									<div class="box_gray01 clfix" id="vctlCancel02">
										<div class="clfix">
											<ul class="mypage_info06 clfix">
												<li>
													<div class="tit">
														<label for="reason_detail">환불 은행</label>
													</div>
													<div class="desc">
														<span class="input_select">
															<select name='mod_bankcode' id='mod_bankcode'>
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
														</span><br/>
														<div class="tit">
															<label for="reason_detail">환불 계좌번호</label>
														</div>														
														<span class="input_txt">
															<input type="text" id="mod_account" name="mod_account" placeholder="환불받으실 계좌번호를 입력하세요.">
														</span><br/>
														<div class="tit">
															<label for="reason_detail">환불 계좌주명</label>
														</div>
														<span class="input_txt">
															<input type="text" id="mod_depositor" name="mod_depositor" placeholder="환불받으실 계좌주명을 입력하세요.">
														</span>
													</div>
												</li>
											</ul>
										</div>
									</div>
									
									</c:if>
									
									<div class="btn_area04 clfix">
										<div class="btn01">
											<a href="<c:url value="/front/myPage/orderList"/>" class="btn_gray01">목록보기</a>
										</div>
										<c:if test="${order.orderPay[0].payWay == 'OR00801'}"><!-- 신용카드 -->
											<c:set var="modeType" value="STSC"/>
										</c:if>
										<c:if test="${order.orderPay[0].payWay == 'OR00802'}"><!-- 실시간계좌 -->
											<c:set var="modeType" value="STE2"/>
										</c:if>
										<c:if test="${order.orderPay[0].payWay == 'OR00803'}"><!-- 가상계좌 -->
											<c:set var="modeType" value="STE2"/>
											<c:if test="${order.ordStat == 'OR00202'}"><!-- 가상계좌 입금전취소 -->
												<c:set var="modeType" value="STE5"/>
											</c:if>
										</c:if>
										<c:if test="${order.ordStat != 'OR00204'}">
											<c:if test="${cancelFlag == 'true'}">
												<div class="btn01" id="cancelBtn">
													<a href="javascript:updateOrderProcess('${order.ordNo}', '', '${modeType }', 'OR00507', '${order.orderPay[0].payWay }');" class="btn_gray01">주문취소</a>
												</div>
											</c:if>
										</c:if>
									</div>
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			<iframe id="cancelFrame" name="cancelFrame" style="display:none">
			
			</iframe>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>