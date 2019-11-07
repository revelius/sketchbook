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
					<th scope="row">요일</th>
					<th scope="row">브랜드</th>
					<th scope="row">접속수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty statisticsConnList}">
						<c:forEach var="list" items="${statisticsConnList}" varStatus="stat">
							<c:forEach var="brand" items="${list.brand}" varStatus="stat">
							<tr>
								<td>${list.period}</td>
								<c:choose>
									<c:when test="${dateType == 'Week' }">
								<td>${brand.brandNm}</td>
									</c:when>
									<c:otherwise>
								<td>${brand.connBrnd}</td>
									</c:otherwise>	
								</c:choose>																	
								<td>${brand.brandTot}</td>
							</tr>
							</c:forEach>
						</c:forEach>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr class="txtBold">
					<th scope="col" colspan="2">합계</th>
					<td class="tdBg">${tot}</td>
				</tr>
			</tfoot>
		</table>
</body>
</html>