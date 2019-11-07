<%-- 
 작성자 : kyj
 작성일 : 2019-11-07
 화면명 : 로그인 화면 
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<! DOCTYPE html>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<title>Login</title>
<!-- 	<link rel="stylesheet" href="/resources/admin/css/adminDefault.css" type="text/css" /> -->
<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
<script>
$(document).ready(function() {
	$(function() {
		
		$("a[data-country]").on("click", function(e){
			e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	//alert($target.attr("data-country"));
	    	
	    	var frm = document.joinForm;
	    	frm.countryCd.value = $target.attr("data-country");
			frm.action = "<c:url value='/front/join/joinInfo'/>";
        	frm.submit();
 	        
		});
		
	});
});
</script>
</head>
 
<body>
	<div id="wrap">
		<!--[s] login -->
		<div id="login">
			<h1><!-- <a href="/admin/index.html"> -->기프티엘비즈에 오신 것을 환영합니다.</h1>
			<div class="loginWrap">
				<h2>로그인 후 기프티엘비즈의 다양한 혜택을 바로 확인해보세요.</h2>
				<form:form id="joinForm" name="joinForm" method="post" modelAttribute="joinForm" onsubmit="">
					<form:hidden path="siteNo"/>
					<form:hidden path="countryCd"/>
				</form:form>
				<div class="loginForm">
					<ul style="padding-left: 50px;">
						<li><input type="text" id="AdminID" name="AdminID" class="loginInput" value="" placeholder="아이디"></li>
						<li><input type="password" id="Pass" name="Pass" class="loginInput" value="" placeholder="비밀번호"></li>
					</ul>
					<div class="saveId"><input type="checkbox" id="saveId" name=""><label for="saveId">아이디 저장</label></div>
					<button type="button" class="btnLogin" onsubmit="return false;">LOGIN</button>
					<div class="pt20 pl30">
						<a class="pr50" href="#" data-country="ME00101">회원가입</a>
						<a class="pl30" href="">아이디 찾기</a>
						<a class="ml10" href="">비밀번호 찾기</a>
					</div>
				</div>
				
			</div>
			<p class="copyright" style="color:#333">Copyright ⓒ 2019 by WORKSOUT. ALL RIGHTS RESERVED.</p>
		</div>
		<!--[e] login -->
	</div>
</body>
</html>