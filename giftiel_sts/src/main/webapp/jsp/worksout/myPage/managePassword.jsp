<%--
 * =============================================================================
 * 파일명 :  /front/myPage/managePassword.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-30
 *
 * 파일 내용 : 비밀번호관리
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		
		<script type="text/javascript">
    		$(function() { 
    			
				var pwdFlag = false;
				
				var pwdTxtNormal = "<span style='color:green;'>사용가능한 비밀번호입니다.</span>";
		    	var pwdTxtFail = "<span style='color:red;'>6~15자 이내 영문자,숫자조합으로 이루어져야 합니다.</span>";
		    	
		    	var rePwdTxtSuccess = "<span style='color:green;'>일치합니다.</span>";
		    	var rePwdTxtFail = "<span style='color:red;'>일치하지 않습니다.</span>";
    			
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
			    
			    
			    //password체크
			    function pwdValidationChk(pwd){
			    	if(pwd == ""){
			    		$("#pwdTxt").html("");
			    		return;
			    	}
			    	
			    	var regPwd = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
			    	
			    	if(!regPwd.test(pwd)) {
			    		$("#pwdTxt").html(pwdTxtFail);
			    		 pwdFlag = false;
			    	    return false;
			    	}else{
			    		$("#pwdTxt").html(pwdTxtNormal);
			    		 pwdFlag = true;
			    		return true;
			    	};
			    };
			    
			    
			 	//password 재입력 체크
			    function rePwdValidationChk(rePwd){
			    	var pwd = $("#pwd").val();
				  	if(rePwd == ""){
			    		$("#rePwdTxt").html("");
			    		return;
			    	}
			    	
			    	if(pwd == rePwd){
			    		$("#rePwdTxt").html(rePwdTxtSuccess);
			    	}else{
			    		$("#rePwdTxt").html(rePwdTxtFail);
			    	};
			    	
			    };
			    
			    
			  //폼체크
			    function formCheck(frm){
		    		
			    	if($("#existPwd").val() ==""){
			    		alert("현재 비밀번호를 입력해 주세요.");
			    		frm.rePwd.focus();
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
		    	}
			  
			  	//현재 비밀번호 체크
// 			    existPwdChk = function(){
// 			    	var existPwd = $("#existPwd").val();
			    	
// 			    	$.ajax({
// 				        url : "<c:url value='/front/myPage/checkExistPwdAjax'/>",
// 				        type: "post",
// 				        data : "&existPwd="+existPwd,
// 				        async: true,
// 				        success : function(res){
//        	   		            if(res < 1) {
//        	   		          		alert("현재비밀번호를 확인해 주세요"); 
//        	   					}
//        	   		        },
// 				        error:function(request,status,error){
// 				            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
// 				        }
// 				    });
			    	
// 			    };
			  
			  
			  	//저장
		    	$("#saveBtn").on("click",function(){
			    	var frm = document.memberForm;
			    	
			    	if(!confirm("변경하시겠습니까?")) return false;
			    	
			    	if(!formCheck(frm)) return false; 
			    	
			    	var existPwd = $("#existPwd").val();
			    	var pwd = $("#pwd").val();
			    	
			    	$.ajax({
       	   		        url : "<c:url value='/front/myPage/changePassAjax'/>",
       	   		        type: "post",
       	   		  		data : "&existPwd="+existPwd+"&pwd="+pwd,
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   						alert("정보가 변경되었습니다."); 
//        	   						var frm = document.hiddenForm;
//        	   						frm.action = "<c:url value='/front/myPage/changeMemberInfo'/>";
//        				 	        frm.submit();
       	   					} else if (res < 0) {
       	   						alert("현재비밀번호를 확인해 주세요."); 
   	   						} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
			    });
			    
			    
			    
			    
    			
    		});
   		</script>
		
		
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap">
			<h2 class="hide_txt">주요 메뉴 영역</h2>
			<div id="header">
				<!-- header include -->
				<!-- header include -->
			</div>
			<h2 class="hide_txt">본문 영역</h2>
			<div id="container">
				<div id="content">
					<form:form id="memberForm" name="memberForm" method="post" modelAttribute="memberForm" onsubmit="">
						<form:hidden path="memNo"/>
						<div class="content_wrap">
							<ul class="location_list clfix">
								<li class="home">
									<a href="<c:url value='/front/main'/>">HOME</a>
								</li>
								<li>
									<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
								</li>
								<li>
									<a href="#">PROFILE</a>
								</li>
							</ul>
							<div class="menu_section">
								<div id="snb_mypage_area">
									<!-- snbMain include -->
									<!-- snbMain include -->
								</div>
							</div>
							<div class="content_section">
								<div class="content_area">
									<div class="content_top">
										<div class="content_menu clfix">
											<!-- on 클래스 붙으면 활성화 됨 -->
											<span class="menu_link">
												<a href="<c:url value="/front/myPage/memberInfo"/>">회원정보관리</a>
												<a href="<c:url value="/front/myPage/managePassword"/>"class="on">비밀번호관리</a>
												<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지관리</a>
												<a href="<c:url value="/front/myPage/managePoint"/>">포인트현황</a>
											</span>
										</div>
									</div>
									<div class="mypage_area">
										<div class="mypage_top_tit">비밀번호관리</div>
										<div class="mypage_content_layout01 space01">
											<table class="tbl_row02">
												<caption>비밀번호관리 테이블로 현재비밀번호, 새비밀번호, 비밀번호 확인 을 확인 할 수 있습니다.</caption>
												<colgroup>
													<col width="128px">
														<col width="*">
												</colgroup>
												<tbody>
													<tr>
														<th>
															<label for="pwd" class="tit_style01">
																<span class="underline">현재비밀번호</span>
															</label>
														</th>
														<td>
															<div class="input_txt">
																<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																<input type="password" id="existPwd" name="existPwd"">
															</div>
														</td>
													</tr>
													<tr>
														<th class="vertical_top">
															<label for="new_pwd" class="tit_style01">
																<span class="underline">비밀번호</span>
															</label>
														</th>
														<td>
															<div class="input_txt">
																<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 																<input type="password" id="new_pwd" name="new_pwd" placeholder="6-15자 이내 영,숫자,특수문자를 사용하세요."> -->
																<form:password  path="pwd" class="wd_200" id="pwd" name="pwd" onblur="pwdChk();" placeholder="6-15자 이내 영,숫자,특수문자를 사용하세요."/>
															</div>
															<div class="form_notice_area"  id="pwdTxt"></div>
														</td>
													</tr>
													<tr>
														<th class="vertical_top">
															<label for="new_pwd_confirm" class="tit_style01">
																<span class="underline">비밀번호 확인</span>
															</label>
														</th>
														<td>
															<div class="input_txt">
																<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
	<!-- 															<input type="password" id="new_pwd_confirm" name="new_pwd_confirm"> -->
																<input  type="password" class="wd_200" id="rePwd" name="rePwd" onblur="rePwdChk();"/>
															</div>
															<div class="form_notice_area" id="rePwdTxt"></div>
														</td>
													</tr>
												</tbody>
											</table>
											<div class="btn_area clfix space01">
												<div class="btn01">
													<a href="#" class="btn_black01" id="saveBtn">변경</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="etc_section"></div>
						</div>
					</form:form>/
				</div>
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>