<%--
 * =============================================================================
 * 파일명 :  /front/myPage/popUpOrderPrint.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 주문확인서
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
    			window.print();
    			
    		});
   		</script>
		
		
	</head>
	<body>
		<div class="order_print_wrap">
			<div class="order_print_content">
				<div class="order_top_content clfix">
					<div class="top_left_area">
						<img src="/html/worksout/images/common/img_print01.jpg" alt="WORKSOUT">
					</div>
					<div class="top_right_area">
						<p class="txt01">주문확인서</p>
						<dl class="clfix">
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">주문서번호</dt>
							<dd>${order.ordNo}</dd>
						</dl>
						<p class="line"></p>
						<dl class="clfix">
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">주문일시</dt>
							<dd><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
						</dl>
					</div>
				</div>
				<div class="order_info_content clfix">
					<div class="info_group">
						<div class="info_tit">주문자정보</div>
						<dl class="clfix">
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">이름</dt>
							<dd>${order.ordrNm}</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">전화번호</dt>
							<dd>${order.ordrTel}</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">휴대폰번호</dt>
							<dd>${order.ordrCp}</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">주소</dt>
							<dd>${order.ordrBsAddr} ${order.ordrDtlAddr}</dd>
						</dl>
					</div>
					<div class="info_group">
						<div class="info_tit">결제정보</div>
						<dl class="clfix"  <c:if test="${order.orderPay[0].payWay !='OR00803'}">style="display: none;"</c:if>>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제수단</dt>
							<dd>가상계좌</dd>
<!-- 							<dt> -->
<!-- 								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">계좌번호</dt> -->
<!-- 							<dd>기업은행 056-111111-11-111</dd> -->
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">예금주명</dt>
							<dd>${order.ordrNm}</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제일</dt>
							<dd><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
						</dl>
						
						<dl class="clfix"  <c:if test="${order.orderPay[0].payWay !='OR00802'}">style="display: none;"</c:if>>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제수단</dt>
							<dd>계좌이체</dd>
<!-- 							<dt> -->
<!-- 								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">계좌번호</dt> -->
<!-- 							<dd>기업은행 056-111111-11-111</dd> -->
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">입금자명</dt>
							<dd>${order.ordrNm}</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제일</dt>
							<dd><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
						</dl>
						
						<dl class="clfix"  <c:if test="${order.orderPay[0].payWay !='OR00801'}">style="display: none;"</c:if>>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제수단</dt>
							<dd>신용카드</dd>
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">카드명</dt>
							<dd>${order.orderPay[0].orderPayCrd[0].cardName}</dd>
<!-- 							<dt> -->
<!-- 								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">카드번호</dt> -->
<!-- 							<dd>000000000000</dd> -->
							<dt>
								<img src="/html/worksout/images/common/bu_dot01.gif" alt="">결제일</dt>
							<dd><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
						</dl>
					</div>
				</div>
				<div class="order_info_tbl">
					<table class="tbl_col02 tbl_col02_print">
						<caption>주문정보 테이블로 상품, 가격, 적립포인트, 상태를 확인 할 수 있습니다</caption>
						<colgroup>
							<col width="*">
								<col width="13%">
									<col width="13%">
										<col width="13%">
											<col width="22%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="first_child">상품</th>
								<th scope="col">색상</th>
								<th scope="col">사이즈</th>
								<th scope="col">가격</th>
								<th scope="col">교환/환불 요청 이유 코드</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
							<tr>
								<td class="first_child">[${good.brand}]
									<br>  ${good.ubiGdsNm}
									<br> ${good.ubiGdsNo}
								</td>
								<td>${good.ubiGdsColorNm}</td>
								<td>${good.ubiGdsSize}</td>
								<td class="td_price">
									<img src="/html/worksout/images/common/ico_price.png" alt="원">
									<span>${good.slPrc}</span>
								</td>
								<c:if test="${goodIndex.first}">
								<td class="user_check_area" rowspan="${fn:length(order.orderGoods)}">
									<div class="img_check">
										<img src="/html/worksout/images/common/img_print02.jpg" alt="교환/환불 요청 이유 코드">
									</div>
								</td>
								</c:if>
							</tr>
							</c:forEach>
<!-- 							<tr> -->
<!-- 								<td class="first_child">[OBEY] -->
<!-- 									<br> OBEY SURVEILLANCE EYE -->
<!-- 									<br> DE15SPJALL00002001 -->
<!-- 								</td> -->
<!-- 								<td>BLACK</td> -->
<!-- 								<td>S</td> -->
<!-- 								<td class="td_price"> -->
<!-- 									<img src="/html/worksout/images/common/ico_price.png" alt="원"> -->
<!-- 									<span>95,000</span> -->
<!-- 								</td> -->
<!-- 								<td></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td class="first_child">[OBEY] -->
<!-- 									<br> OBEY SURVEILLANCE EYE -->
<!-- 									<br> DE15SPJALL00002001 -->
<!-- 								</td> -->
<!-- 								<td>BLACK</td> -->
<!-- 								<td>S</td> -->
<!-- 								<td class="td_price"> -->
<!-- 									<img src="/html/worksout/images/common/ico_price.png" alt="원"> -->
<!-- 									<span>95,000</span> -->
<!-- 								</td> -->
<!-- 								<td></td> -->
<!-- 							</tr> -->
						</tbody>
					</table>
				</div>
				<div class="order_change_process">
					<p class="tit">교환환불절차</p>
					<div class="img">
						<img src="/html/worksout/images/common/img_print03.jpg" alt="교환환불절차">
					</div>
					<ul class="process_notice">
						<li>
							<span class="num">1.</span>
							<span class="txt">교환/환불은 제품을 수령하신 날 기준으로 7일 이내에 가능합니다.</span>
						</li>
						<li>
							<span class="num">2.</span>
							<span class="txt">수령일로부터 7일이 경과하거나, 고객님의 사용으로 인해 상품이 훼손, 손상, 가치가 감소한 경우는 보내주셔도 처리 불가능하기 때문에
								고객님께 반송될 수 있습니다.</span>
						</li>
						<li>
							<span class="num">3.</span>
							<span class="txt">고객님의 단순변심으로 인한 교환/환불의 경우 배송비는 고객님이 부담하셔야 합니다.</span>
						</li>
						<li>
							<span class="num">4.</span>
							<span class="txt">반품 시 필요한 부속품이 동봉되지 않은 경우, 재반송될 수 있습니다. (주문확인서, 단추, 상품 택, 라벨 등)</span>
						</li>
						<li>
							<span class="num">5.</span>
							<span class="txt">고객센터 운영시간 : 월요일 ~ 금요일 (09:30 ~ 12:30 / 13:30 ~ 18:30), 주말 및 공휴일 미운영</span>
						</li>
						<li>
							<span class="num">6.</span>
							<span class="txt">교환/반품주소 : 서울시 마포구 서교동 377-3번지 (주)웍스아웃 4층 고객지원센터</span>
						</li>
					</ul>
				</div>
				<div class="order_bottom_content clfix">
					<div class="bottom_left_area">
						<p class="txt01">반송제품</p>
						<p class="txt02 clfix">
							<span class="tit">주문서번호</span>
							<span class="num">${order.ordNo}</span>
						</p>
						<div class="img">
							<img src="/html/worksout/images/common/img_print04.jpg" alt="바코드">
						</div>
					</div>
					<div class="bottom_right_area">
						<img src="/html/worksout/images/common/img_print01.jpg" alt="WORKSOUT">
					</div>
				</div>
			</div>
		</div>
	</body>
</html>