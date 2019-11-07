<%--
 * =============================================================================
 * 파일명 : /order/orderMain.jsp
 * 작성자 : 박필종
 * 작성일자 : 2015-05-07
 *
 * 파일 내용 : 주문매출관리 > 메인
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>

</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="order"/>
					<jsp:param name="onChk" value="main"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<div class="section a1">
						<h3><span class="icon1"></span>주문매출관리</h3>						
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 주문/매출을 관리할 수 있는 곳입니다.</li>
							</ul>

							<div class="tableTitle"><span class="icon2"></span>전체주문</div>
							<table class="cateinfo">
								<caption>전체주문</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>전체주문</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=order'/>">전체 주문을 관리하실 수 있습니다.</a></td>
									</tr>
								</tbody>
							</table>

							<div class="tableTitle"><span class="icon2"></span>주문관리</div>
							<table>
								<caption>주문관리</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<!-- 
									<tr>
										<th>결제관리</th>
										<td><a href="<c:url value='/admin/order/orderList'/>">결제대기/결제 완료된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
									 -->
									<tr>
										<th>배송관리</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=ship'/>">배송준비/출고지연/배송중/배송완료된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
									<!-- 
									<tr>
										<th>구매확정</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=buy'/>">구매확정된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
									 -->
								</tbody>
							</table>

							<div class="tableTitle"><span class="icon2"></span>취소/교환/반품신청관리</div>
							<table>
								<caption>취소/교환/반품신청관리</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>취소 관리</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=cancle'/>">주문 취소된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
									<tr>
										<th>교환 관리</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=exchange'/>">교환 신청된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
									<tr>
										<th>반품 관리</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=takeBack'/>">반품 신청된 내역을 관리하실 수 있습니다.</a></td>
									</tr>
								</tbody>
							</table>
				
							<div class="tableTitle"><span class="icon2"></span>추가결제관리</div>
							<table class="cateinfo">
								<caption>추가결제관리</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>추가결제관리</th>
										<td><a href="<c:url value='/admin/order/orderList?ordKnd=addBuy'/>">추가결제를 관리하실 수 있습니다.</a></td>
									</tr>
								</tbody>
							</table>					

				</div>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->
		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

	</div>
</body>
</html>