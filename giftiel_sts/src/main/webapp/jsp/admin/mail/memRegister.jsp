<%--
 * =============================================================================
 * 파일명 : /mail/memRegister.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-09-21
 *
 * 파일 내용 : 메일폼(회원가입)
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
	<table cellpadding="0" cellspacing="0" style="font-size:12px;width:100%;margin:0 auto;padding:0;border:0;font-family:Arial;background-color:#fff;text-align: center;">

		<tr>
			<td style="text-align: center;padding:60px 0 100px 0;"><img style="vertical-align:top" src="${url}/resources/worksout/images/logo/${siteDir }_web.png" alt="${siteDir }" width="167" height="32" border="0" align="absmiddle" /></td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: center;font-weight: bold">${nm}님</td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal;padding:10px 0 0 0;">회원가입을 축하드립니다.</td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal;padding:30px 0 0 0">ID : ${email}</td>
		</tr>
		<tr>
			<td style="font-size:12px;text-align: center;font-weight: normal;padding:30px 0 0 0">홈페이지에 등록된 개인정보는 <span style="font-size:12px;border-bottom:1px solid #000000"><a href="${url}/front/myPage/myPageHome"> 마이페이지</a></span>에서 수정할 수 있습니다.</td>
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