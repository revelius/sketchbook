<%--
 * =============================================================================
 * 파일명 : /common/fileUpload/fileUpload.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-13
 *
 * 파일 내용 : 공통 > 파일업로드 팝업
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link href="http://fonts.googleapis.com/css?family=Source+Code+Pro:400,700"	type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<c:url value='/resources/admin/js/jquery-1.11.2.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/admin/js/jquery-ui.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/admin/js/common.js'/>"></script>
	<link rel="stylesheet" href="<c:url value='/resources/worksout/css/common.css'/>" type="text/css" />
	<link rel="icon" href="/upload/image/favicon/${siteNm }.ico" type="image/x-icon" />
	<title>기프티엘 관리자페이지</title>
</head>
<body>
<div class="layer_popup_wrap02">
	<div class="layer_popup02" style="top:0px;">
		<div class="layer_popup_container02">
			<div class="layer_top_tit02">파일첨부</div>
			<div class="layer_popup_content02" style="padding: 40px 20px;">
				<div class="input_file_area_add">
					<ul class="input_file_name">
						<li></li>
					</ul>
					<div class="input_file">
						<span class="txt_file">FILE</span>
						<form:form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data">
							<input type="file" name="uploadFile" id="uploadFile" onchange="submit();" >
							<input type="hidden" name="folderNm" id="folderNm" value="${param.folderNm }">
							<input type="hidden" name="type" id="type" value="${param.type }">
							<input type="hidden" name="target" id="target" value="${param.target }">
						</form:form>
					</div>
				</div>
			</div>
		</div>
		<a href="#" onclick="window.close()" class="layer_btn_close02">
			<img src="/resources/worksout/images/common/btn_close_popup.png" alt="닫기">
		</a>
	</div>
</div>
</body>
</html>