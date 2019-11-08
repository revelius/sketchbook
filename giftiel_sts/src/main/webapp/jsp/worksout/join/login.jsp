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
		// 페이지 로딩 시 아이디란 focus
	    $("#userId").focus();
		
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var userInputId = getCookie("userInputId");
	    $("input[name='userId']").val(userInputId); 

	    if($("input[name='userId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#userSaveId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }

	  	//로그인하기 
	    $(".btnLogin").on("click",function() { 
	    	if($("#userId").val()==null || $("#userId").val()==""){
	    		alert("아이디를 입력하세요.");
	    		$("#userId").focus();
	    		return;
	    	}
	    	if($("#userPass").val()==null || $("#userPass").val()==""){
	    		alert("비밀번호를 입력하세요.");
	    		$("#userPass").focus();
	    		return;
	    	}
	    	
	    	$.ajax({
	            url : "<c:url value='testtesttest'/>",
	            type: "post",
	            data : { "userId" : $("#userId").val() , "userPass" : $("#userPass").val() },
	            success : function(responseData){
	                var data = JSON.parse(responseData);

	                if(data=="0"){  //로그인 성공 
						location.href="<c:url value='testtesttest'/>";                	
	                }else if(data=="1"){ //존재하지 않는 정보 
	                	alert("등록되지 않은 아이디이거나 아이디 또는 비밀번호를 잘못 입력하셨습니다. 회원님의 아이디와 비밀번호를 확인 후 다시 입력해주세요.");
	                	return;
	                }
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"error:"+error+"\n"+"관리자에게 문의하십시오.");
	            }
	        });
	    	
	    });
	    
	    //엔터를 치면 로그인 함.
	    $("#userPass").on("keyup",function(){
	    	var keycode = event.keyCode;
	    	
	    	if(keycode==13){ //엔터를 치면 로그인 함.
	    		$(".btnLogin").click();
	    	}
	    });
	    
	    //아이디 인풋에서 엔터를 치면 비밀번호 인풋으로 포커스 이동함.
	    $("#userId").on("keyup",function(){
	    	var keycode = event.keyCode;
	    	if(keycode==13){ //엔터를 치면 비밀번호 인풋으로 포커스.
	    		$("#userPass").focus();
	    	    return;
	    	}
	    });

		// 아이디 저장
	    $("#userSaveId").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#userSaveId").is(":checked")){ // ID 저장하기 체크했을 때,
	            var userInputId = $("input[name='userId']").val();
	            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("userInputId");
	        }
	    });
	    
		// 회원가입 페이지 이동
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

//쿠키에 저장
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키 삭제
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키값 가져오기 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
</script>
</head>
 
<body>
	<div id="wrap">
		<!--[s] login -->
		<div id="login">
			<ul class="location_list clfix">
			<h1><!-- <a href="/admin/index.html"> -->기프티엘비즈에 오신 것을 환영합니다.</h1>
			<div class="loginWrap">
				<h2>로그인 후 기프티엘비즈의 다양한 혜택을 바로 확인해보세요.</h2>
				<form:form id="joinForm" name="joinForm" method="post" modelAttribute="joinForm" onsubmit="">
					<form:hidden path="siteNo"/>
					<form:hidden path="countryCd"/>
				</form:form>
				<div class="loginForm">
					<ul style="padding-left: 50px;">
						<li><input type="text" id="userId" name="userId" class="loginInput" value="" placeholder="아이디"></li>
						<li><input type="password" id="userPass" name="userPass" class="loginInput" value="" placeholder="비밀번호"></li>
					</ul>
					<div class="saveId"><input type="checkbox" id="userSaveId" name=""><label for="userSaveId">아이디 저장</label></div>
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