<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 환경설정 - 상점환경설정 
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function openDaumZipAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            jQuery('#post_no').val(data.zonecode);
            jQuery('#address').val(data.address);
            jQuery('#dtl_address').focus();
            console.log(data);
        }
    }).open();
}
</script>  
	
<script>  
$(document).ready(function(){
	
	//비밀번호 
	$("#pwd").on("keyup",function(){
		$(".password_chk").text("*6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
	});
	
	//비밀번호 
	$("#pwd").on("blur",function(){
		if(!doChkPassword(this)){
			$(".password_chk").text("*비밀번호 형식이 잘못되었습니다.");
		}else{
			$(".password_chk").text("");
		}		
	});
	
	//비밀번호 확인 
	$("#pwd_confirm").on("blur",function(){
		if($("#pwd").val() != $("#pwd_confirm").val()){
			$(".password_chk_confirm").text("*비밀번호가 일치하지 않습니다.");
		}else{
			$(".password_chk_confirm").text("*비밀번호가 일치합니다.");
		} 
	});
	
});

//비밀번호 유효성 체크 
function doChkPassword(obj){
	if(obj.value.length < 6 || obj.value.length > 16)
    {
        //alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
        return false;
    }
    if(!obj.value.match(/^.*(?=^.{6,12}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/))
    {
        //alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
        return false;
    }
    return true;
}

//취소
function doReset(){
	$(':input').each(function(index) {
    	if($(this).attr('type')=="text"){
    		$(this).val("");
    	}
    }); 
}

//저장
function doSave(){
	if($("#pwd").val()==""){
		alert("비밀번호를 입력하세요.");
		$("#pwd").focus();
		return;
	}
	if(!doChkPassword(document.frm.pwd)){
		alert("비밀번호 형식이 잘못 되었습니다.");
		return;
	}
	if($("#pwd_confirm").val()==""){
		alert("비밀번호 확인을 입력하세요.");
		$("#pwd_confirm").focus();
		return;
	}
	if($("#pwd").val() != $("#pwd_confirm").val()){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	if($("#user_name").val()==""){
		alert("관리자명을 입력하세요.");
		$("#user_name").focus();
		return;
	}
	if(!chkByteLen($("#user_name"),10)){
		alert("관리자명은 10자 이내로 입력하시기 바랍니다.");
		$("#user_name").focus();
		return;
	}
	if(!regEmail($("#email"))){
		alert("이메일 주소가 유효하지 않습니다.");
		$("#email").focus();
		return;
	}
	if($("#com_name").val()==""){
		alert("회사명을 입력하세요.");
		$("#com_name").focus();
		return;
	}
	if($("#repre_name").val()==""){
		alert("대표자명을 입력하세요.");
		$("#repre_name").focus();
		return;
	}
	if($("#info_name").val()==""){
		alert("개인정보 관리자명을 입력하세요.");
		$("#info_name").focus();
		return;
	}
	if($("#info_email").val()==""){
		alert("개인정보 이메일을 입력하세요.");
		$("#info_email").focus();
		return;
	}
	if(!regEmail($("#info_email"))){
		alert("개인정보 이메일 주소가 유효하지 않습니다.");
		$("#info_email").focus();
		return;
	}
	if($("#address").val()==""){
		alert("회사주소를 입력하세요.");
		$("#address").focus();
		return;
	}
	if($("#tel_no").val()==""){
		alert("대표전화를 입력하세요.");
		$("#tel_no").focus();
		return;
	}
// 	if(!regPhone($("#tel_no"))){
// 		alert("대표전화가 유효하지 않습니다.");
// 		$("#tel_no").focus();
// 		return;  
// 	}  
	if($("#fax_no").val()==""){
		alert("팩스를 입력하세요.");
		$("#fax_no").focus();
		return;
	}
// 	if(!regPhone($("#fax_no"))){
// 		alert("팩스번호가 유효하지 않습니다.");
// 		$("#fax_no").focus();
// 		return;
// 	}
	if($("#com_no").val()==""){
		alert("사업자등록번호를 입력하세요.");
		$("#com_no").focus();
		return;
	}
	if($("#biz_reg_no").val()==""){
		alert("통신판매업신고번호를 입력하세요.");
		$("#biz_reg_no").focus();
		return;
	}
	if($("#biz_st").val()==""){
		alert("업태를 입력하세요.");
		$("#biz_st").focus();
		return;
	}
	if($("#event").val()==""){
		alert("종목을 입력하세요.");
		$("#event").focus();
		return;
	}
	
 	var frmdata = JSON.stringify(ConvertFormToJSON());

 	$.ajax({
        url : "<c:url value='/admin/setting/settingStoreSave'/>",
        type: "post",
        data : frmdata,
        async: false,
        dataType: "json",
        contentType: "application/json", 
        success : function(responseData){
            var data = JSON.parse(responseData);
            if(data=="1"){  //저장 성공 
				alert("저장되었습니다.");                	
            }              
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}

function ConvertFormToJSON(){
    var array = $("#frm").serializeArray();
    var json = {};
    
    jQuery.each(array, function() {
        json[''|| this.name || ''] = this.value || '';
    });
    
    return json;
}

function doAddressPopup(){
	window.open("<c:url value='/admin/popup/zipCode/selectSido'/>","popup","width=500px,height=500px,scrollbars=yes");
}

</script>
</head>
<body>
	<div id="wrap">
		
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">	
			
			<div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb -->  
				
			<!--[s] contents -->
				<div class="contents">
					<h3><span class="icon1"></span>환경설정 > 상점기본정보관리 > 상점환경설정 </h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- 관리자 접속에 필요한 정보를 관리자 정보에서 설정합니다.</li> -->
<!-- 							<li>- 보안을 위해 패스워드는 자주 바꿔주시기 바랍니다.</li> -->
<!-- 							<li>- 사업자 정보는 홈페이지 하단 카피라이트부분에 노출됩니다</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					
					<!-- [s] 상점환경설정 컨텐츠 -->
					<div class="tabCon_inner">
						<form:form name="frm" id="frm" method="post" modelAttribute="regFrm" onsubmit="return check(form)">
						<form:hidden path="admin_id" id="admin_id"/>
<%-- 						<input type="hidden" name="admin_id" id="admin_id" value="${list.admin_id}"/> --%>
						
						<!-- [s] 슈퍼관리자정보 테이블 -->
						<div class="tableType2">
							<table>
								<caption>상점환결설정</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
								    <tr>
								    	<th scope="row" colspan="2" class="row_tit">슈퍼관리자 정보</th>
								    </tr>
									<tr>
										<th scope="col">아이디</th>
										<td>${admin_id}</td>
									</tr>
									<tr>
										<th scope="col">비밀번호</th>
										<td><input type="password" class="wd_200" id="pwd" name="pwd"/> <span class="addtxt ml_5 password_chk"></span></td>
									</tr>
									<tr>
										<th scope="col">비밀번호 확인</th>
										<td><input type="password" class="wd_200" id="pwd_confirm" name="pwd_confirm"/> <span class="addtxt ml_5 password_chk_confirm"></span></td>
									</tr>
									<tr>
										<th scope="col">관리자명</th>
										<td><form:input path="user_name" class="wd_200" id="user_name" name="user_name" maxlength="50" onblur="javascript:chkLen(this,50);"/> <span class="addtxt ml_5">* 10자 이하로 입력 바랍니다.</span></td>
									</tr>
									<tr>
										<th scope="col">이메일</th>
										<td><form:input path="email" class="wd_200" id="email" name="email" maxlength="40" onblur="javascript:chkLen(this,40);"/> <span class="addtxt ml_5">*제휴문의 및 자동이메일의 사용될 이메일 계정을 설정 바랍니다.</span></td>
									</tr>
								</tbody>
							</table>
							
						</div>
						<!-- [e] 슈퍼관리자정보 테이블 -->
						<!-- [s] 사업자 정보 테이블 -->
						<div class="tableType2 pt20">
							<table>
								<caption>사업자 정보 입력 폼</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
									<col width="132px" />
									<col width="380px" />
								</colgroup>
								<tbody>
								    <tr>
								    	<th scope="row" colspan="4" class="row_tit">사업자 정보</th>
								    </tr>
									<tr>
										<th scope="col">회사명</th>
										<td colspan="3"><form:input path="com_name" class="wd_200" id="com_name" name="com_name" maxlength="50"  onblur="javascript:chkLen(this,50);"/> <span class="addtxt ml_5">* worksout 및 브랜드 사이트 통합하는 회사명을 입력하시기 바랍니다.</span></td>
									</tr>
									<tr>
										<th scope="col">대표자명</th>
										<td colspan="3"><form:input path="repre_name" class="wd_200" id="repre_name" name="repre_name" maxlength="50"  onblur="javascript:chkLen(this,50);"/></td>
									</tr>
									<tr>
										<th scope="col">개인정보관리자</th>
										<td colspan="3">
											<form:input path="info_name" class="wd_200" id="info_name" name="info_name" maxlength="50"  onblur="javascript:chkLen(this,50);"/> <form:input path="info_email" class="wd_200" placeholder="이메일 입력" id="info_email"  name="info_email" maxlength="40"  onblur="javascript:chkLen(this,40);"/>
											<p class="addtxt">* 개인정보관리자의 성명과 이메일 주소를 입력하시기 바랍니다.</p>
										</td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th scope="col">회사명</th> -->
<!-- 										<td colspan="3"><input type="text" class="wd_200" id="info_com_name"/></td> -->
<!-- 									</tr> -->
									<tr>
										<th scope="col">회사주소</th>
										<td colspan="3">
											<form:input path="post_no" id="post_no" name="post_no" readonly="true"/> <a href="javascript:openDaumZipAddress();" class="btnType1 mb5">우편번호</a> <br />
											<form:input path="address" class="ip_tit" id="address" name="address" readonly="true"/><br>
											<form:input path="dtl_address" class="ip_tit" id="dtl_address" name="dtl_address" maxlength="255" onblur="javascript:chkLen(this,255);"/>
										</td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th scope="col">이메일</th> -->
<!-- 										<td colspan="3"><input type="text" class="wd_200" id="com_email"/></td> -->
<!-- 									</tr> -->
									<tr>
										<th scope="col">대표전화</th>
										<td><form:input path="tel_no" class="wd_200" id="tel_no" name="tel_no" maxlength="30" onblur="javascript:chkLen(this,30);"/></td>
										<th scope="col">팩스</th>
										<td><form:input path="fax_no" class="wd_200" id="fax_no" name="fax_no" maxlength="30" onblur="javascript:chkLen(this,30);"/></td>
									</tr>
									<tr>
										<th scope="col">사업자등록번호</th>
										<td><form:input path="com_no" class="wd_200" id="com_no" name="com_no" maxlength="50" onblur="javascript:chkLen(this,50);"/></td>
										<th scope="col">통신판매업신고번호</th>
										<td><form:input path="biz_reg_no" class="wd_200" id="biz_reg_no" name="biz_reg_no" maxlength="50" onblur="javascript:chkLen(this,50);"/></td>
									</tr>
									<tr>
										<th scope="col">업태</th>
										<td><form:input path="biz_st" class="wd_200" id="biz_st" name="biz_st" maxlength="50" onblur="javascript:chkLen(this,50);"/></td>
										<th scope="col">종목</th>
										<td><form:input path="event" class="wd_200" id="event" name="event" maxlength="50" onblur="javascript:chkLen(this,50);"/></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						</form:form>
						
						<!-- [e]  테이블 -->
						<div class="section a2 btn">
						<c:choose>
							<c:when test="${admin_userCls=='AD02001'}">
								<!-- 수퍼 관리자인 경우만 수정할 수 있음. 수퍼 관리자는 한명뿐임. : AD02001 -->
								<a href="javascript:doSave();" class="btnType2">저장</a>
								<a href="javascript:doReset();" class="btnType1">취소</a>
							</c:when>
						</c:choose>
						</div>
					</div>
					<!-- [e] 상점환경설정 컨텐츠 -->	
				</div>
				<!--[e] contents -->
			</div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>