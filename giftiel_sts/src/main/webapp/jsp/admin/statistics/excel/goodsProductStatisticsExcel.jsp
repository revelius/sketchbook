<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<%
    String filename = request.getAttribute("fileName").toString();
    response.setHeader("Content-Type", "application/vnd.ms-xls");
    response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xls");
    
	response.setHeader("Pragma","");
	response.setHeader("Cache-Control","");
	// 작업 예정
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
		<table id="goodsTable" border="1">
			<colgroup>
				<col width="10%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="row">일자</th>
					<th scope="row">브랜드</th>
					<th scope="row">상세보기 수</th>
					<th scope="row">장바구니 등록 수</th>
					<th scope="row">주문건 수</th>
					<th scope="row">판매 수</th>
					<th scope="row">매출액</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty goodsProductStatistics}">
					<c:forEach var="list" items="${goodsProductStatistics}" varStatus="stat">
						<c:forEach var="goodsPro" items="${list.brand}" varStatus="stat">
						<tr>
							<td>${list.period}</td>
							<td>${goodsPro.brandNm }</td>
							<td>${goodsPro.detailTot}</td>
							<td>${goodsPro.cartTot}</td>
							<td>${goodsPro.ordTot}</td>
							<td>${goodsPro.ordGdTot}</td>
							<td><fmt:formatNumber type="currency" value="${goodsPro.payTot }" pattern="###,###" /></td>
						</tr>
						</c:forEach>
					</c:forEach>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</tbody>
		<tfoot>
			<c:forEach var="total" items="${goodsProductStatisticsTot}" varStatus="stat">
				<c:forEach var="goodsProductTotal" items="${total.brand}" varStatus="stat">
				<tr class="txtBold">
					<th scope="col" colspan="2">${total.period}</th>
					<td class="tgBg">${goodsProductTotal.detailTot}</td>
					<td class="tgBg">${goodsProductTotal.cartTot}</td>
					<td class="tgBg">${goodsProductTotal.ordTot}</td>
					<td class="tgBg">${goodsProductTotal.ordGdTot}</td>
					<td class="tgBg"><fmt:formatNumber type="currency" value="${goodsProductTotal.payTot }" pattern="###,###" /></td>
				</tr>
				</c:forEach>
			</c:forEach>
		</tfoot>
		</table>
</body>
</html>