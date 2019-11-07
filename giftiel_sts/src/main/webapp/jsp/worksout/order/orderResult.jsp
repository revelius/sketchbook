<%--
 * =============================================================================
 * 파일명 : /front/order/orderConfirm.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-26
 *
 * 파일 내용 : order > 주문서 작성 확인
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0);
%>
<%
String res_cd = request.getParameter("res_cd");
String res_msg = request.getParameter("res_msg");
%>
<html lang="ko">
	<!--<![endif]-->
	<head>
	 	<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script> 
		<script type="text/javascript">
		var _nasa={};
		 _nasa["cnv"] = wcs.cnv("1","${order.totalSlAmt + order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
		</script>	
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<script type="text/javascript">
		$(function() {
			//주문서 작성폼으로 이동
		    $("#btn_order").click(function() {
		    	var frm = document.cartForm;
		        frm.target = '_self';
		        frm.action = 'orderConfirm';
		        frm.submit();
		    });
		});		
		</script>
	</head>
	<body>
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
								<a href="#">SHOPPING CART</a>
							</li>
							<li>
								<a href="#">ORDER</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_order_area">
								<!-- snbOrder include -->
								<!-- snbOrder include -->
							</div>
						</div>
						<%if("0000".equals(res_cd)){%>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">상품선택</span>
											</a>
											<a href="#">
												<span class="txt">주문/결제</span>
											</a>
											<a href="#">
												<span class="txt">주문확인</span>
											</a>
											<a href="#" class="on last_child">
												<span class="txt">주문완료</span>
											</a>
										</span>
									</div>
								</div>
								<div class="cart_order_area">
									<div class="mypage_top_tit">주문/결제 완료</div>
									<div class="mypage_content_layout01">
										<ul class="withdraw_notice_list">
											<li class="tit02">주문이 완료되었습니다. 이용해 주셔서 감사합니다.</li>
											<li class="desc03">주문하신 내역은 Mypage &gt; ORDER LIST &gt; 에서도 확인 가능합니다.</li>
											<li class="desc04">가상계좌 결제시, 주문일시로부터
												<strong>24시간 내 결제</strong>를 해주셔야 하며,
												<br> 24시간 이후에도 결제대기일 경우
												<strong>자동취소</strong>됩니다.</li>
										</ul>
									</div>
									<div class="mypage_content_layout01 line01 space02">
										<table class="tbl_row02">
											<caption>주문/결제 완료 테이블로 총 결제금액, 주문일시, 결제기한, 주문서 번호, 상품, 결제수단, 계좌번호, 예금주명 의 내용을
												확인 할 수 있습니다.</caption>
											<colgroup>
												<col width="128px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th class="th_type01">
														<span class="tit_style01">
															<span>총 결제금액</span>
														</span>
													</th>
													<td class="td_type01 txt_align01">
														<span class="ico_price">${order.orderPay[0].payAmt + order.orderPay[1].payAmt}</span>
													</td>
												</tr>
												<tr>
													<th class="space01">
														<span class="tit_style01">
															<span>주문일시</span>
														</span>
													</th>
													<td class="space01 txt_align01"><fmt:formatDate value="${order.ordDts }" pattern="yyyy-MM-dd HH:mm:SS" /></td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">결제기한</span>
													</th>
													<td class="txt_align01">
													<fmt:parseDate var="dateString" value="${order.orderPay[0].orderPayVrtl[0].vaDate }" pattern="yyyyMMddHHmmss" />
													<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:SS"/>
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">주문서 번호</span>
													</th>
													<td class="txt_align01">${order.ordNo }</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">상품</span>
													</th>
													<td class="txt_align01">${order.orderGoods[0].ubiGdsNm } 외 ${fn:length(order.orderGoods)-1} 개</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">결제수단</span>
													</th>
													<td class="txt_align01">
														<c:if test="${order.orderPay[0].payWay == 'OR00801'}">
															신용카드
														</c:if>
														<c:if test="${order.orderPay[0].payWay == 'OR00802'}">
															실시간 계좌이체
														</c:if>
														<c:if test="${order.orderPay[0].payWay == 'OR00803'}">
															가상계좌
														</c:if>
														
														<c:if test="${order.orderPay[1].payAmt > 0}">
														+ 적립금
														</c:if>															
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">계좌번호</span>
													</th>
													<td class="txt_align01">${order.orderPay[0].orderPayVrtl[0].bankname } ${order.orderPay[0].orderPayVrtl[0].account }</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">예금주명</span>
													</th>
													<td class="txt_align01">${order.ordrNm }</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="mypage_content_layout01">
										<p class="notice_txt">- 입금 확인 후 배송이 진행됩니다.</p>
									</div>
									<div class="mypage_content_layout01 space01">
										<div class="btn_area02 clfix">
											<div class="btn01">
												<c:if test="${isLogined }">
													<a href="/front/myPage/orderDetail?orderNo=${order.ordNo }" class="btn_white01">주문/배송 내역 바로가기</a>
												</c:if>
												<c:if test="${!isLogined }">
													<a href="<c:url value='/front/myPage/nMemMyPageHome'/>" class="btn_white01">주문/배송 내역 바로가기</a>
												</c:if>													
											</div>
											<div class="btn02">
												<a href="/front/onlineShop/feature" class="btn_black01">온라인샵 바로가기</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%}else{%>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">상품선택</span>
											</a>
											<a href="#">
												<span class="txt">주문/결제</span>
											</a>
											<a href="#">
												<span class="txt">주문확인</span>
											</a>
											<a href="#" class="on last_child">
												<span class="txt">주문완료</span>
											</a>
										</span>
									</div>
								</div>
								<div class="cart_order_area">
									<div class="mypage_top_tit">주문/결제 실패</div>
									<div class="mypage_content_layout01">
										<ul class="withdraw_notice_list">
											<li class="tit02">주문이 실패하였습니다.</li>
											<li class="desc03">사유 : <%=res_msg %></li>
										</ul>
									</div>
									<div class="mypage_content_layout01 line01 space02">

									</div>
									<div class="mypage_content_layout01">
										<p class="notice_txt">- 처음부터 다시 진행해주세요.</p>
									</div>
									<div class="mypage_content_layout01 space01">
										<div class="btn_area02 clfix">
											<div class="btn01">
												<a href="/front/main" class="btn_white01">메인으로 돌아가기</a>
											</div>
											<div class="btn02">
												<a href="/front/onlineShop/feature" class="btn_black01">온라인샵 바로가기</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>						
						<% } %>						
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>