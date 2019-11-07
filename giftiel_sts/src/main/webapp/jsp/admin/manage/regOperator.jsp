<%--
 * =============================================================================
 * 파일명 : /manage/regOperator.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-24
 *
 * 파일 내용 : 권한관리 > 부운영자
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	
	<script type="text/javascript">
    $(function() { 
    	var idDuplFlag = false;
    	var pwdFlag = false;
    	
    	var procFlag = "${procFlag}";
    	if(procFlag == "update"){
    		idDuplFlag = true;
    	}
    	
    	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    	
    	var pwdTxtNormal = "*6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
    	var pwdTxtFail = "비밀번호 형식이 잘못되었습니다.";
    	
    	var rePwdTxtSuccess = "*비밀번호가 일치합니다.";
    	var rePwdTxtFail = "비밀번호가 일치하지 않습니다.";
    	
    	
    	//저장
    	$("#saveBtn").on("click",function(){
	    	var frm = document.joinForm;
	    	
	    	if(!confirm("저장하시겠습니까?")) return false;
	    	
	    	if(!formCheck1(frm)) return false; 
	    	
	        frm.action = "<c:url value='/admin/manage/regOptProc'/>";
	        frm.submit();
	    	
			
	    	
	    });
    	
    	
    	//삭제
    	$("#delBtn").on("click",function(){
	    	var frm = document.joinForm;
	    	
	    	if(!confirm("삭제시 복구불가능 합니다.\n삭제하시겠습니까?")) return false;
	    	
	    	
	        frm.action = "<c:url value='/admin/manage/delOptProc'/>";
	        frm.submit();
	    	
			
	    	
	    });
    	
    	//수정저장
    	$("#updateBtn").on("click",function(){
	    	var frm = document.joinForm;
	    	
	    	if(!confirm("저장하시겠습니까?")) return false;
	    	
	    	if(!formCheck2(frm)) return false; 
	    	
	        frm.action = "<c:url value='/admin/manage/updateOptProc'/>";
	        frm.submit();
	    	
			
	    	
	    });
    	
    	//취소
    	$("#cancelBtn").on("click",function(){
    		var frm = document.joinForm;
	        frm.action = "<c:url value='/admin/manage/operatorList'/>";
	        frm.submit();
	    });
	    
    	
    	setDuplStat = function(){
    		idDuplFlag = false;
    	};
    	
    	
    	setPwdStat = function(){
    		//pwdFlag = false;
    	};
	    
	    //ID 중복체크
	    idDuplChk = function(){
	    	var id = $("#id").val();
	    	
		    if(!idValidationChk(id)) return false;
	    	
	    	$.ajax({
		        url : "<c:url value='/admin/manage/idDuplChkAjax'/>",
		        type: "post",
		        data : "&id="+id,
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("사용중인 아이디 입니다."); 
					} else {
						idDuplFlag = true;
						alert("사용 가능한 아이디 입니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
	    };
	    
	    //비밀번호 체크
	    pwdChk = function(){
	    	var pwd = $("#pwd").val();
	    	var rePwd = $("#rePwd").val();
	    	
	    	pwdValidationChk(pwd);
	    	
	    	if(rePwd!=""){
	    		rePwdValidationChk(rePwd);
	    	}
	    	
	    };
	    
	    //비밀번호 재입력 체크
	    rePwdChk = function(){
	    	var rePwd = $("#rePwd").val();
	    	
	    	rePwdValidationChk(rePwd);
	    	
	    };
	    
	    
	    $("#allCheckAuthGrp").on("click" ,function(){
			if($("#allCheckAuthGrp").is(":checked")) {
				$("input[name=authGrpNo]").prop("checked",true);
			} else {
				$("input[name=authGrpNo]").prop("checked",false);
			}
		});
	    
	    
	    //id체크
	    function idValidationChk(str){
	    	var chk_eng = str.search(/[a-zA-Z]/ig);
	    	var chk_kor = str.search(/[ㄱ-ㅎㅏ-ㅣ가-힣]/gi);
		    var chktext = str.search(/[~!@\#$%<>^&*\()\-=+_\']/gi);
		    
		    
		    if(str.length < 5 || str.length > 12){
		    	alert('5~12자사이의 값을 입력하세요'); 
		        return false;
		    }
		    
		    if(chktext >= 0)
		    { 
		        alert('특수문자 사용이 불가능 합니다.'); 
		        return false;
		    }
		    
		    if(chk_eng < 0)
		    { 
		        alert('영문 또는 영문+숫자만 가능합니다.'); 
		        return false;
		    }
		    
		    if(chk_kor >= 0)
		    { 
		        alert('영문 또는 영문+숫자만 가능합니다.'); 
		        return false;
		    }
		    
		   
		    return true;
	    };
	    
	    
	    //password체크
	    function pwdValidationChk(pwd){
	    	if(pwd == ""){
	    		$("#pwdTxt").text(pwdTxtNormal);
	    		return;
	    	}
	    	
	    	var regPwd = /^.*(?=^.{6,12}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).{6,16}.*$/;
	    	
	    	if(!regPwd.test(pwd)) {
	    		$("#pwdTxt").text(pwdTxtFail);
	    		 pwdFlag = false;
	    	    return false;
	    	}else{
	    		$("#pwdTxt").text("");
	    		 pwdFlag = true;
	    		return true;
	    	};
	    };
	    
	    //password 재입력 체크
	    function rePwdValidationChk(rePwd){
	    	var pwd = $("#pwd").val();
		  	if(rePwd == ""){
	    		$("#rePwdTxt").text("");
	    		return;
	    	}
	    	
	    	if(pwd == rePwd){
	    		$("#rePwdTxt").text(rePwdTxtSuccess);
	    	}else{
	    		$("#rePwdTxt").text(rePwdTxtFail);
	    	};
	    	
	    };
	    
	    
	    //폼체크 부운영자 등록시 폼체크
	    function formCheck1(frm){
	    	
	    	if(frm.id.value == ""){
	    		alert("아이디를 입력해 주세요.");
	    		frm.id.focus();
	    		return false;
	    	}
	    	
	    	if(frm.pwd.value == ""){
	    		alert("비밀번호를 입력해 주세요");
	    		frm.pwd.focus();
	    		return false;
	    	}
	    	
	    	if(frm.rePwd.value == ""){
	    		alert("비밀번호를 확인해 주세요.");
	    		frm.rePwd.focus();
	    		return false;
	    	}
	    	
	    	if(frm.userNm.value == ""){
	    		alert("이름을 입력해 주세요.");
	    		frm.userNm.focus();
	    		return false;
	    	}
	    	
	    	if(frm.tel.value == ""){
	    		alert("연락처를 입력해 주세요.");
	    		frm.tel.focus();
	    		return false;
	    	}
	    	
	    	if(frm.email.value == ""){
	    		alert("이메일을 입력해 주세요.");
	    		frm.email.focus();
	    		return false;
	    	}
	    	
	    	
	    	if(!$("input:checkbox[name='tempSiteAuthNo']").is(":checked") == true){
	    		alert("브랜드를 선택해 주세요.");
	    		return false;
	    	}
	    	
	    	/* 환경설정 기본권한 가짐
	    	if(!$("input:checkbox[name='authGrpNo']").is(":checked") == true){
	    		alert("권한을 선택해 주세요.");
	    		return false;
	    	}
	    	 */
	    	
	    	if(idDuplFlag == false){
	    		alert("아이디 중복확인을 해주세요");
	    		frm.idDuplChkBtn.focus();
	    		return false;
	    	}
	    	
	    	if(pwdFlag==false){
	    		alert("비밀번호를 확인해 주세요.");
	    		frm.pwd.focus();
	    		return false;
	    	}
	    	
	    	if(frm.pwd.value != frm.rePwd.value){
	    		alert("비밀번호를 확인해 주세요.");
	    		frm.rePwd.focus();
	    		return false;
	    	}
	    	
	    	
	    	
	    	
	    	
	    	return true;
	    };
	    
	    
	    
	  //폼체크 부운영자 수정시 폼체크
	    function formCheck2(frm){
	    	
	    	
	    	
	    	/* 
	    	if(frm.pwd.value == ""){
	    		alert("비밀번호를 입력해 주세요");
	    		frm.pwd.focus();
	    		return false;
	    	}
	    	
	    	if(frm.rePwd.value == ""){
	    		alert("비밀번호를 확인해 주세요.");
	    		frm.rePwd.focus();
	    		return false;
	    	}
	    	 */
	    	
	    	if(frm.userNm.value == ""){
	    		alert("이름을 입력해 주세요.");
	    		frm.userNm.focus();
	    		return false;
	    	}
	    	
	    	if(frm.tel.value == ""){
	    		alert("연락처를 입력해 주세요.");
	    		frm.tel.focus();
	    		return false;
	    	}
	    	
	    	if(frm.email.value == ""){
	    		alert("이메일을 입력해 주세요.");
	    		frm.email.focus();
	    		return false;
	    	}
	    	
	    	
	    	if(!$("input:checkbox[name='tempSiteAuthNo']").is(":checked") == true){
	    		alert("브랜드를 선택해 주세요.");
	    		return false;
	    	}
	    	
	    	/* 환경설정 기본권한 가짐
	    	if(!$("input:checkbox[name='authGrpNo']").is(":checked") == true){
	    		alert("권한을 선택해 주세요.");
	    		return false;
	    	}
	    	 */
	    	
	    	
	    	if(frm.pwd.value != ""){
	    		if(pwdFlag==false){
		    		alert("비밀번호를 확인해 주세요.");
		    		frm.pwd.focus();
		    		return false;
		    	}
		    	
		    	if(frm.pwd.value != frm.rePwd.value){
		    		alert("비밀번호를 확인해 주세요.");
		    		frm.rePwd.focus();
		    		return false;
		    	}
	    	}
	    	
	    	
	    	
	    	
	    	
	    	
	    	return true;
	    };
	    
	    
	    
	    
	    
    });
    
	</script>
</head> 
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->




		<!--[s] container -->
		<div id="container">	
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="manage"/>
				</jsp:include>
				<!--[e] lnb -->
				
				<!--[s] contents -->
				<form:form modelAttribute="user" id="joinForm" name="joinForm" method="post">
					<form:hidden path="userNo" id="userNo" value="${user.userNo}" />
				<div class="contents">
					
					<h3><span class="icon1"></span>운영관리 > 권한관리 > 부운영자</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<div class="tableType2">
							
							
							<table>
								<caption>부운영자</caption>
								<colgroup>
									<col width="132px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<c:if test="${procFlag eq 'reg'}">
										<th scope="col">아이디</th>
										<td><form:input path="id" class="wd_200" id="id" name="id" onchange="setDuplStat();"/> <a href="#" onclick="idDuplChk();" id="idDuplChkBtn" name="idDuplChkBtn" class="btnType1">중복확인</a> <span class="addtxt ml_5">*5~12자의 영문 또는 영문+숫자만 사용 가능합니다.</span></td>
										</c:if>
										<c:if test="${procFlag eq 'update'}">
										<th scope="col">아이디</th>
										<td><b>${user.id}</b></td>
										</c:if>
									</tr>
									<tr>
										<th scope="col">비밀번호</th>
										<td><form:password  path="pwd" class="wd_200" id="pwd" name="pwd" onblur="pwdChk();" onchange="setPwdStat();"/><span class="addtxt ml_5" id="pwdTxt">*6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span></td>
									</tr>
									<tr>
										<th scope="col">비밀번호 확인</th>
										<td><input  type="password" class="wd_200" id="rePwd" name="rePwd" onblur="rePwdChk();"/> <span class="addtxt ml_5" id="rePwdTxt"></span></td>
									</tr>
									<tr>
										<th scope="col">이름</th>
										<td><form:input path="userNm"  class="wd_200" id="userNm" name="userNm" /></td>
									</tr>
									<tr>
										<th scope="col">연락처</th>
										<td><form:input path="tel"  class="wd_200" id="tel" name="tel" numberonly="true"/><span class="addtxt ml_5">*숫자만 입력 가능합니다.</span></td>
									</tr>
									<tr>
										<th scope="col">이메일</th>
										<td><form:input path="email"  class="wd_200" id="email" name="email" /></td>
									</tr>
									<tr>
										<th scope="col">브랜드</th>
										<td>
											<form:checkboxes path="tempSiteAuthNo" id="tempSiteAuthNo" items="${siteList}" itemLabel="siteNm" itemValue="siteNo"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2">
						<div class="tableType1">
							<table>
								<caption>부운영자</caption>
								<colgroup>
									<col style="width: 3%" />
									<col style="width: 10%" />
									<col style="width: 20%" />
									<col style="width: *" />
								</colgroup>
								<thead>
									<tr>
										<th scope="row"><input type="checkbox" id="allCheckAuthGrp" name="allCheckAuthGrp" /></th>
										<th scope="row">권한</th>
										<th scope="row">구분</th>
										<th scope="row">항목</th>
									</tr>
								</thead>
								<tbody>	
								
								<c:forEach items="${authGrpList}" var="authGrp" varStatus="authGrpCount">
									<c:forEach items="${authGrp.supMenu}" var="supMenu" varStatus="supMenuCount">
										<c:forEach items="${supMenu.menu}" var="menu" varStatus="menuCount">
										<tr>
											<c:if test="${supMenuCount.index eq 0 && menuCount.index eq 0}">
												<td rowspan="${authGrp.grpTot}"><form:checkbox path="authGrpNo"  id="authGrp${authGrpCount.count}" name="authGrpNo" value="${authGrp.authGrpNo}"/></td>
												<td rowspan="${authGrp.grpTot}">${authGrp.authGrpNm}</td>
											</c:if>
											<c:if test="${menuCount.index eq 0}">
												<td rowspan="${fn:length(supMenu.menu)}" class="bd_left">${supMenu.supMenuNm}</td>
											</c:if>
											<td class="bd_left">${menu.menuNm}</td>
										</tr>
										</c:forEach>
									</c:forEach>
								</c:forEach>	
								</tbody>
							</table>
						</div>
					</div>
					<!-- //section -->
					<div class="section a2 btn">
						<c:if test="${procFlag eq 'reg'}">
						<a href="#" id="saveBtn" class="btnType2">저장</a>
						<a href="#" id="cancelBtn" class="btnType1">취소</a>
						</c:if>
						<c:if test="${procFlag eq 'update'}">
						<a href="#" id="updateBtn" class="btnType2">저장</a>
						<a href="#" id="cancelBtn" class="btnType1">취소</a>
						<a href="#" id="delBtn" class="btnType1">삭제</a>
						</c:if>
					</div>
				</div>
				</form:form>
				<!--[e] contents -->
			</div>
		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>