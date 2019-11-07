<%--
 * =============================================================================
 * 파일명 : /common/scriptView/script.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-27
 *
 * 파일 내용 : 공통 > 스크립트 결과 출력
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<jsp:include page="/jsp/admin/include/head.jsp"/>
	<script type="text/javascript">
		alert("${alert}");
		
		if("${openerReload}" == "true"){
			opener.location.reload(true);
		}
		
		if("${redirect}" != ""){
			document.location.href = "${redirect}";
		}
		
		if("${windowClose}" == "true"){
			window.close();
		}

		if("${parentReload}" == "true"){
			parent.documentReload();
		}
		
	</script>
</head>
<body>
</body>
</html>
