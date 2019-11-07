<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 로그인 화면 
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<! DOCTYPE html>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<title>기프티엘 관리자페이지</title>
<!-- 	<link rel="stylesheet" href="/resources/admin/css/adminDefault.css" type="text/css" /> -->
<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
<script>
$(document).ready(function() {
    
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='AdminID']").val(userInputId); 
    
    if($("input[name='AdminID']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#saveId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
	
    $("#AdminID").focus();
    
    //로그인하기 
    $(".btnLogin").on("click",function() { 
    	if($("#AdminID").val()==null || $("#AdminID").val()==""){
    		alert("아이디를 입력하세요.");
    		$("#AdminID").focus();
    		return;
    	}
    	if($("#Pass").val()==null || $("#Pass").val()==""){
    		alert("비밀번호를 입력하세요.");
    		$("#Pass").focus();
    		return;
    	}
    	
    	$.ajax({
            url : "<c:url value='/admin/login'/>",
            type: "post",
            data : { "AdminID" : $("#AdminID").val() , "Pass" : $("#Pass").val() },
            success : function(responseData){
                var data = JSON.parse(responseData);
				
                if(data=="0"){  //로그인 성공 
					location.href="<c:url value='/admin/setting/index'/>";                	
                }else if(data=="1"){ //존재하지 않는 정보 
                	alert("로그인 정보가 맞지 않습니다.");
                	return;
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
            }
        });
    	
    });
    
    //엔터를 치면 로그인 함.
    $("#Pass").on("keyup",function(){
    	var keycode = event.keyCode;
    	
    	if(keycode==13){ //엔터를 치면 로그인 함.
    		$(".btnLogin").click();
    	}
    });
    
    //아이디 인풋에서 엔터를 치면 비밀번호 인풋으로 포커스 이동함.
    $("#AdminID").on("keyup",function(){
    	var keycode = event.keyCode;
    	if(keycode==13){ //엔터를 치면 비밀번호 인풋으로 포커스.
    		$("#Pass").focus();
    	    return;
    	}
    });
    
    //아이디 저장
    $("#saveId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#saveId").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='AdminID']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
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
			<h1><!-- <a href="/admin/index.html"> -->giftiel admin </h1>
			<div class="loginWrap">
				<h2>관리자페이지에 오신 것을 환영합니다</h2>
				<div class="loginForm">
					<ul>
						<li><span>아이디</span> <input type="text" id="AdminID" name="AdminID" class="loginInput" value=""></li>
						<li><span>비밀번호</span> <input type="password" id="Pass" name="Pass" class="loginInput" value=""></li>
					</ul>
					<div class="saveId"><input type="checkbox" id="saveId" name=""><label for="saveId">아이디 저장</label></div>
					<button type="button" class="btnLogin" onsubmit="return false;">LOGIN</button>
				</div>
			</div>
			<p class="copyright" style="color:#333">Copyright ⓒ 2014 by WORKSOUT. ALL RIGHTS RESERVED.</p>
		</div>
		<!--[e] login -->
	</div>
</body>
</html>