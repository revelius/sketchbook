<%--
 * =============================================================================
 * 파일명 : /mail/payComp.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-09-21
 *
 * 파일 내용 : 메일폼(입금확인)
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>WORKSOUT</title>
</head> 
<body style="font-size:12px;margin:0;padding:0;background-color:#ffffff">
	<table cellpadding="0" cellspacing="0" style="font-size:12px;width:720px;margin:0 auto;padding:0;border:0;font-family:Arial;background-color:#fff;text-align: center;">

		<tr>
			<td style="text-align: center;padding:60px 0 100px 0;"><img style="vertical-align:top" src="${url}/resources/worksout/images/logo/${siteDir }_web.png" alt="${siteDir }" width="167" height="32" border="0" align="absmiddle" /></td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: left;font-weight: bold;padding:0 0 0 10px;">${order.ordrNm}님,</td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: left;font-weight: normal;padding:10px 0 0 10px;">주문내역을 확인하였습니다.</td>
		</tr>
	</table>

	<table cellpadding="0" cellspacing="0" style="font-size:12px;width:720px;margin:30px auto 0 auto;padding:0 0 0 0;border:1px solid #e1e1e1;font-family:Arial;background-color:#fff;text-align: center;">
		<tr>
			<td colspan="4" style="font-size:12px;text-align: left;font-weight: bold;padding:10px 0 10px 10px;">주문정보</td>
		</tr>
		<tr>
			<td style="width:50px;font-size:12px;text-align: left;font-weight: normal;padding:10px 0 10px 15px;background-color:#f0f0f0;color:#818181;">번호</td>
			<td style="width:465px;font-size:12px;text-align: center;font-weight: normal;padding:10px 0 10px 0;background-color:#f0f0f0;color:#818181;">상품</td>
			<td style="width:120px;font-size:12px;text-align: center;font-weight: normal;padding:10px 0 10px 0;background-color:#f0f0f0;color:#818181;">가격</td>
		</tr>
		
		
		
		<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
		<tr>
			<td style="width:50px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">${goodIndex.count}</td>
			<td style="width:465px;font-size:12px;text-align: left;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 15px;color:#000000;">
				<table cellpadding="0" cellspacing="0" style="font-size:12px;width:100%;margin:0;;padding:0 0 0 0;border:0;font-family:Arial;background-color:#fff;text-align: left;">
					<tr>
						<td style="width:90px;text-align: left">
							<img style="vertical-align:top" src="<c:url value="${uploadImage}${good.mainImg}"/>" alt="" width="76" height="94" border="0" align="absmiddle" />
						</td>
						<td style="text-align: left">
							<ul style="list-style:none;margin:0;padding:0;">
								<li style="list-style:none;margin:0;padding:0 0 5px 0;font-size:12px;font-weight:normal;color:#000000;">[${good.brand}]</li>
								<li style="list-style:none;margin:0;padding:0 0 5px 0;font-size:12px;font-weight:normal;color:#000000;">${good.ubiGdsNm}</li>
								<li style="list-style:none;margin:0;padding:0 0 5px 0;font-size:12px;font-weight:normal;color:#000000;">Color = ${good.ubiGdsColorNm} / Size = ${good.ubiGdsSize}</li>
								<li style="list-style:none;margin:0;padding:0;font-size:12px;font-weight:normal;color:grey;">${good.ubiGdsNo}</li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
			<td style="width:120px;font-size:12px;text-align: center;font-weight: bold;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">${good.slPrc}</td>
		</tr>
		</c:forEach>
	</table>
	
	
	<table cellpadding="0" cellspacing="0" style="font-size:12px;width:720px;margin:30px auto 0 auto;padding:0 0 0 0;border:1px solid #e1e1e1;font-family:Arial;background-color:#fff;text-align: center;">
		<tr>
			<td style="width:20px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">확인일시</td>
			<td style="width:70px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">${thisDay}</td>
		</tr>
		<tr>
			<td style="width:20px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">결제액</td>
			<td style="width:70px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;"><fmt:formatNumber type="currency" value="${order.totalPayAmt}" pattern="###,###" /></td>
		</tr>
		<tr>
			<td style="width:20px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">주문자명</td>
			<td style="width:70px;font-size:12px;text-align: center;font-weight: normal;border-right:1px solid #e1e1e1;border-top:1px solid #e1e1e1;padding:20px 0 20px 0;color:#000000;">${order.ordrNm}</td>
		</tr>
	</table>
	
	
	
	

	



	<table cellpadding="0" cellspacing="0" style="font-size:12px;width:100%;margin:0 auto;padding:100px 0 0 0;border:0;font-family:Arial;background-color:#fff;text-align: center;">
		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal;padding:0 0 10px 0"><a href="${url}/front/news/newsList" style="font-size:12px;color:#000000;text-decoration: none">NEWS</a></td>
		</tr>

		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal;padding:0 0 10px 0;"><a href="${url}/front/onlineShop/feature" style="font-size:12px;color:#000000;text-decoration: none">ONLINE SHOP</a></td>
		</tr>

		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal"><a href="${url}/front/contactUs" style="font-size:12px;color:#000000;text-decoration: none">CONTACT US</a></td>
		</tr>

<!-- 		<tr> -->
<%-- 			<td style="font-size:12px;text-align: center;font-weight: normal;padding:30px 0 30px 0;"><a href="${url}/front/myPage/myPageHome"  style="font-size:12px;color:#000000;text-decoration: none">UNSUBSCRIBE</a></td> --%>
<!-- 		</tr> -->
		<tr>
			<td style="font-size:12px;padding:15px 0 15px 0;background-color:#000000;text-align: center;font-weight: bold;color:#ffffff;">© COPYRIGHT 2015  
			<c:if test="${siteDir == 'worksout' }">WORKSOUT INC.</c:if>
			<c:if test="${siteDir == 'carhartt' }">CARHARTT WIP KOREA</c:if>
			<c:if test="${siteDir == 'obey' }">OBEY KOREA</c:if>
			<c:if test="${siteDir == 'brixton' }">BRIXTON KOREA</c:if>
			<c:if test="${siteDir == 'deus' }">DEUS KOREA </c:if> 
			</td>
		</tr>
	</table>
</body>
</html>