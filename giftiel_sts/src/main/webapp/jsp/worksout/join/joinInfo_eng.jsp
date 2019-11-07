<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm_eng.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입 정보입력
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
		
		<script type="text/javascript" src="<c:url value='/resources/worksout/js/jquery-ui.min.js'/>"></script>
		
		<link rel="stylesheet" href="<c:url value='/resources/worksout/css/jquery-ui.css'/>" type="text/css" />
		<link rel="stylesheet" href="<c:url value='/resources/worksout/css/contents.css'/>" type="text/css" />
		
		<script type="text/javascript">
			$(function() {
				
				$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
				
				var idDuplFlag = false;
				var joinPwdFlag = false;
				
				var joinPwdTxtNormal = "<span style='color:green;'>AVAILABLE</span>";
		    	var joinPwdTxtFail = "<span style='color:red;'>UNAVAILABLE</span>";
		    	
		    	var reJoinPwdTxtSuccess = "<span style='color:green;'>AGREEMENT</span>";
		    	var reJoinPwdTxtFail = "<span style='color:red;'>INCONSISTENCY</span>";
				
				setDuplStat = function(){
		    		idDuplFlag = false;
		    	};
				
				//ID 중복체크
			    idDuplChk = function(){
			    	var joinEmail = $("#joinEmail").val();
			    	
			    	
				    if(joinEmail==""){
				    	$("#emailUseText").html("");
				    	return false;
				    }
				    if (!regEmail($("#joinEmail"))) {
				    	$("#emailUseText").html("<span style='color:red;'>THE INCORRECT TYPE.</span>");
						return false;
					}
			    	
			    	$.ajax({
				        url : "<c:url value='/front/join/idDuplChkAjax'/>",
				        type: "post",
				        data : "&email="+joinEmail,
				        async: true,
				        success : function(res){
				            if (res > 0) {
				            	$("#emailUseText").html("<span style='color:red;'>UNAVAILABLE</span>");
							} else {
								idDuplFlag = true;
								$("#emailUseText").html("<span style='color:green;'>AVAILABLE</span>");
							}
				        },
				        error:function(request,status,error){
				            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
				        }
				    });
			    };
			    
			    
			  //비밀번호 체크
			    pwdChk = function(){
			    	var joinPwd = $("#joinPwd").val();
			    	var reJoinPwd = $("#reJoinPwd").val();
			    	
			    	pwdValidationChk(joinPwd);
			    	
			    	if(reJoinPwd!=""){
			    		reJoinPwdValidationChk(reJoinPwd);
			    	}
			    	
			    };
			    
			    //비밀번호 재입력 체크
			    rePwdChk = function(){
			    	var reJoinPwd = $("#reJoinPwd").val();
			    	
			    	reJoinPwdValidationChk(reJoinPwd);
			    	
			    };
			    
			    
			    //password체크
			    function pwdValidationChk(joinPwd){
			    	if(joinPwd == ""){
			    		$("#joinPwdTxt").html("");
			    		return;
			    	}
			    	
			    	var regJoinPwd = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
			    	
			    	if(!regJoinPwd.test(joinPwd)) {
			    		$("#joinPwdTxt").html(joinPwdTxtFail);
			    		 joinPwdFlag = false;
			    	    return false;
			    	}else{
			    		$("#joinPwdTxt").html(joinPwdTxtNormal);
			    		 joinPwdFlag = true;
			    		return true;
			    	};
			    };
			    
			    
			 	//password 재입력 체크
			    function reJoinPwdValidationChk(reJoinPwd){
			    	var joinPwd = $("#joinPwd").val();
				  	if(reJoinPwd == ""){
			    		$("#reJoinPwdTxt").html("");
			    		return;
			    	}
			    	
			    	if(joinPwd == reJoinPwd){
			    		$("#reJoinPwdTxt").html(reJoinPwdTxtSuccess);
			    	}else{
			    		$("#reJoinPwdTxt").html(reJoinPwdTxtFail);
			    	};
			    	
			    };
			    
			    
			    //저장
		    	$("#saveBtn").on("click",function(){
			    	var frm = document.joinForm;
			    	
			    	if(!confirm("Would you like to have this information?")) return false;
			    	
			    	if(!formCheck(frm)) return false; 
			    	
			    	$("#saveBtn").hide();
			    	
			    	//$("input[id='cpNo']").val(frm.phone_number[0].value+"-"+frm.phone_number[1].value+"-"+frm.phone_number[2].value);
			        frm.action = "<c:url value='/front/join/joinProc'/>";
			        frm.submit();
			    });
			    
			    
		    	//폼체크
			    function formCheck(frm){
		    		
			    	if(frm.id.value == ""){
			    		alert("Please type Email(ID)");
			    		frm.id.focus();
			    		return false;
			    	}
			    	
			    	if(idDuplFlag == false){
			    		alert("Please type available Email(ID) ");
			    		frm.joinEmail.focus();
			    		return false;
			    	}
			    	
			    	
			    	if(joinPwdFlag==false){
			    		alert("Please check the password");
			    		frm.pwd.focus();
			    		return false;
			    	}
			    	
			    	if(frm.pwd.value != frm.rePwd.value){
			    		alert("Please check the password");
			    		frm.rePwd.focus();
			    		return false;
			    	}
			    	
			    	
			    	return true;
		    	}
		    	
			    // datepicker 
				$(".datepicker").datepicker({
					inline: true, 
					dateFormat: "yymmdd",    /* 날짜 포맷 */ 
					//showOn: "both", 
					//buttonImage: "<c:url value='/resources/admin/images/common/icon_calender.gif'/>",
					//buttonImageOnly: true, 
					minDate: '-30y', 
					showMonthAfterYear: true,   /* 년과 달의 위치 바꾸기 */ 
					/* 한글화 */ 
					monthNames : ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'], 
					monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
					dayNames : ['Sun', 'Mon', 'Tue', 'Wed', ' Thu', 'Fri', 'Sat'],
					dayNamesShort : ['Sun', 'Mon', 'Tue', 'Wed', ' Thu', 'Fri', 'Sat'],
					dayNamesMin : ['Sun', 'Mon', 'Tue', 'Wed', ' Thu', 'Fri', 'Sat'],
					showAnim: 'slideDown', 
					/* 날짜 유효성 체크 */ 
					onClose: function( selectedDate ) { 
					  $('#fromDate').datepicker("option","minDate", selectedDate); 
					} 
				});
				$('#ui-datepicker-div').addClass('dateCal');
		    	
		    	
			    
			    
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
				<form:form id="joinForm" name="joinForm" method="post" modelAttribute="joinForm" onsubmit="">
					<form:hidden path="siteNo"/>
					<form:hidden path="countryCd"/>
					<form:hidden path="mySlfCertYn"/>
					<form:hidden path="mailSndYn"/>
					<form:hidden path="smsSndYn"/>
					
					<form:hidden path="nm"/>
					<form:hidden path="sex"/>
					<form:hidden path="birthDt"/>
					<form:hidden path="cpNo" id="cpNo"/>
				
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">JOIN</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_join_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<a href="#">
											<span class="txt">CERTIFICATION</span>
										</a>
										<a href="#" class="on">
											<span class="txt">PROFILE</span>
										</a>
										<a href="#" class="last_child">
											<span class="txt">COMPLETION</span>
										</a>
									</div>
								</div>
								<div class="join_area">
									<div class="join_agree_area02 space02">
										<div class="join_agree_tit">PROFILE</div>
									</div>
									<div class="join_mobile_certify">
										<table class="tbl_row02 tbl_space02">
											<caption>외국인 정보입력 테이블로 name, email, password, password confirm, cellular phone,
												sex, birth 에 대해 확인 할 수 있습니다.</caption>
											<colgroup>
												<col width="128px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">NAME</span>
														</span>
													</th>
													<td>${joinForm.nm}</td>
												</tr>
												<tr>
													<th class="vertical_top">
														<label for="id01" class="tit_style01">
															<span class="underline">ID(email)</span>
														</label>
													</th>
													<td>
														<div class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 															<input type="text" id="id_emal" name="id_emal" placeholder="WORKSOUT@WORKSOUT.CO.KR"> -->
															<form:input path="email" class="wd_200" id="joinEmail" name="joinEmail" onchange="setDuplStat();" onblur="idDuplChk();" placeholder="WORKSOUT@WORKSOUT.CO.KR"/>
														</div>
														<!-- 일치 하지 않을 경우 .no_confirm 클래스를 붙여 줍니다. -->
														<div class="form_notice_area" id="emailUseText"></div>
													</td>
												</tr>
												<tr>
													<th class="vertical_top">
														<label for="pwd" class="tit_style01">
															<span class="underline">PASSWORD</span>
														</label>
													</th>
													<td>
														<div class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 															<input type="password" id="pwd" name="pwd" placeholder="WITHIN 6~15, USE CHARACTERS+NUMBER+SPECIAL CHARACTERS"> -->
															<form:password  path="pwd" class="wd_200" id="joinPwd" name="pwd" onblur="pwdChk();" placeholder="WITHIN 6~15, USE CHARACTERS+NUMBER+SPECIAL CHARACTERS"/>
														</div>
														<div class="form_notice_area"  id="joinPwdTxt"></div>
													</td>
												</tr>
												<tr>
													<th class="vertical_top">
														<label for="pwd_confirm" class="tit_style01">
															<span class="underline">PASSWORD CONFIRM</span>
														</label>
													</th>
													<td>
														<div class="input_txt">
															<input type="password" class="wd_200" id="reJoinPwd" name="rePwd" onblur="rePwdChk();"/>
														</div>
														<div class="form_notice_area" id="reJoinPwdTxt"></div>
													</td>
												</tr>
												<tr>
													<th>
														<label for="phone_number01" class="tit_style01">
															<span class="underline">CELLULAR PHONE</span>
														</label>
													</th>
													<td>
														${joinForm.cpNo}
<!-- 														<div class="form_layout_style04 clfix"> -->
<!-- 															<ul class="form01 clfix"> -->
<!-- 																<li> -->
<!-- 																	<span class="input_txt"> -->
<!-- 																		id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 																		<input type="text" id="phone_number01" name="phone_number" numberonly="true" maxlength="3"> -->
<!-- 																	</span> -->
<!-- 																</li> -->
<!-- 																<li class="etd_child"> -->
<!-- 																	<span class="input_txt"> -->
<!-- 																		id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 																		<input type="text" id="phone_number02" name="phone_number" numberonly="true" maxlength="4"> -->
<!-- 																	</span> -->
<!-- 																</li> -->
<!-- 																<li class="last_child"> -->
<!-- 																	<span class="input_txt"> -->
<!-- 																		id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 																		<input type="text" id="phone_number03" name="phone_number" numberonly="true" maxlength="4"> -->
<!-- 																	</span> -->
<!-- 																</li> -->
<!-- 															</ul> -->
<!-- 														</div> -->
													</td>
												</tr>
												<tr>
													<th>
														<label for="male" class="tit_style01">
															<span class="underline">GENDER</span>
														</label>
													</th>
													<td>
														${joinForm.sex}
<!-- 														<ul class="form_layout_style02 clfix"> -->
<!-- 															<li> -->
<!-- 																<span class="input_radio"> -->
<%-- 																	<form:radiobutton path="sex" name="sex" label=" MALE" value="0"/> --%>
<!-- 																</span> -->
<!-- 															</li> -->
<!-- 															<li> -->
<!-- 																<span class="input_radio"> -->
<!-- 																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<%-- 																	<form:radiobutton path="sex" name="sex" label=" FEMALE" value="1"/> --%>
<!-- 																</span> -->
<!-- 															</li> -->
<!-- 														</ul> -->
													</td>
												</tr>
												<tr>
													<th>
														<label for="birthday" class="tit_style01">
															<span class="underline">BIRTH</span>
														</label>
													</th>
													<td>
<!-- 														<div class="input_txt"> -->
<%-- 															<form:input path="birthDt" id="birthDt" name="birthDt" readonly="true" cssClass="datepicker"/> --%>
<!-- 														</div> -->
														${joinForm.birthDt}
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="btn_area">
										<a href="#" class="btn_black01" id="saveBtn">SIGN UP</a>
									</div>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
					</form:form>
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