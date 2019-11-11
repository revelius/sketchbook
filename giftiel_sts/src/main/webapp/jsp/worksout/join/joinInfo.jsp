<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm.jsp
 * 작성자 : 김진성 / 김영준
 * 작성일자 : 2015-05-28 / 2019-11-07
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
<script type="text/javascript">
$(document).ready(function() {
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});



	//저장
	$("#saveBtn").on("click",function(){
    	var frm = document.joinForm;
    	
    	if(!formCheck(frm)) return false; 
//     	if(!confirm("해당정보로 가입하시겠습니까?")) return false;
    	
//     	$("#saveBtn").hide();
    	
    	//$("input[id='cpNo']").val(frm.phone_number[0].value+"-"+frm.phone_number[1].value+"-"+frm.phone_number[2].value);
//         frm.action = "<c:url value='/front/join/joinProc'/>";
//         frm.submit();
    });
	
	//폼체크
    function formCheck(frm){
    	if($.trim(frm.joinId.value) == ""){
    		alert("회원 아이디를 입력해 주세요.");
    		frm.joinId.value = $.trim(frm.joinId.value);
    		frm.joinId.focus();
    		return false;
    	}	

    	if(frm.joinPwd.value == ""){
    		alert("비밀번호를 입력해 주세요.");
    		frm.joinPwd.focus();
    		return false;
    	}	   

    	if(frm.reJoinPwd.value == ""){
			alert("비밀번호를 다시 입력해 주세요.");
			frm.reJoinPwd.focus();
			return false;
		}	

    	if(frm.pwd.value != frm.reJoinPwd.value){
			alert("비밀번호가 일치하지 않습니다.");
			frm.reJoinPwd.focus();
			return false;
		}

    	if($.trim(frm.joinCmpNm.value) == ""){
    		alert("상호명을 입력해 주세요.");
    		frm.joinCmpNm.value = $.trim(frm.joinCmpNm.value);
    		frm.joinCmpNm.focus();
    		return false;
    	}

    	if($('input:radio[name="cmpType"]:checked').val()!="C" && $('input:radio[name="cmpType"]:checked').val()!="P"){
			alert("사업자를 선택해 주세요.");
			return false;
    	}

    	// 업태 업종 선택 필요

    	if($.trim(frm.joinReprNm.value) == ""){
    		alert("대표자를 입력해주세요.");
    		frm.joinReprNm.value = $.trim(frm.joinReprNm.value);
    		frm.joinReprNm.focus();
    		return false;
    	}

    	if($.trim(frm.joinMngr.value) == ""){
    		alert("담당자를 입력해주세요.");
    		frm.joinMngr.value = $.trim(frm.joinMngr.value);
    		frm.joinMngr.focus();
    		return false;
    	}
    	
    	if($.trim(frm.joinDept.value) == ""){
    		alert("근무부서를 입력해주세요.");
    		frm.joinDept.value = $.trim(frm.joinDept.value);
    		frm.joinDept.focus();
    		return false;
    	}

    	if($("select[id='tel01']").val() == "0" ||  $.trim(frm.tel02.value) == "" ||  $.trim(frm.tel03.value) == "" ){
			alert("유선전화번호를 입력하세요.");
			return;
		}		

    	if($.trim(frm.tel02.value).length < 3  || $.trim(frm.tel03.value).length < 4) {
			alert("휴대폰번호를 확인해주세요.");
			if($.trim(frm.tel02.value).length < 3 ) {
				frm.tel02.value = $.trim(frm.tel02.value);
    			frm.tel02.focus();
			} else if($.trim(frm.tel03.value).length < 4) {
				frm.tel03.value = $.trim(frm.tel03.value);
    			frm.tel03.focus();
			}
			return;
		}

//     	if($("select[id='cpNo01']").val() == "0" || $.trim(frm.cpNo02.value) == "" || $.trim(frm.cpNo03.value) == ""){
// 			alert("휴대폰번호를 입력하세요.");
// 			return;
// 		}		    

// 		if($.trim(frm.cpNo02.value).length < 3  || $.trim(frm.cpNo03.value).length < 4) {
// 			alert("휴대폰번호를 확인해주세요.");
// 			if($.trim(frm.cpNo02.value).length < 3 ) {
// 				frm.cpNo02.value = $.trim(frm.cpNo02.value);
//     			frm.cpNo02.focus();
// 			} else if($.trim(frm.cpNo02.value).length < 4) {
// 				frm.cpNo03.value = $.trim(frm.cpNo03.value);
//     			frm.cpNo03.focus();
// 			}
// 			return;
// 		}
    	
		
    	
//     	if($("input#cpNo01").val() == "" || $("input#cpNo02").val() == "" || $("input#cpNo03").val() == ""){
//     		alert("휴대폰 번호를 입력하세요.");
//     		return;
//     	}		    	
    	
//     	if(!certCheck){
//     		alert("휴대폰 인증 후 가입하실 수 있습니다.");
//     		return false;
//     	}
	}
	
});
</script>
<title>Join</title>
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
					<!--[s] 사업자 인증번호 -->
					<jsp:include page="joinCertification.jsp"></jsp:include>
					<!--[e] 사업자 인증번호 -->
					<div class="content_wrap">
						<ul class="location_list clfix">
<!-- 							<li class="home"> -->
<%-- 								<a href="<c:url value='/front/main'/>">HOME</a> --%>
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<a href="#">JOIN</a> -->
<!-- 							</li> -->
						</ul>
					</div>
					<div class="menu_section">
						<div id="snb_join_area">
							<!-- snbMain include -->
							<!-- snbMain include -->
						</div>
					</div>
					<div class="content_section">
						<div class="content_area">
							<div class="join_area">
								<div class="join_agree_area02 space02">
									<div class="join_agree_tit">사업자 정보입력</div>
								</div>
								<div class="join_mobile_certify">
									<table class="tbl_row02 tbl_space02">
										<caption>사업자 정보를 입력하는 곳입니다.</caption>
										<colgroup>
											<col width="128px">
												<col width="*">
										</colgroup>
										<tbody>
										<tr>
											<th class="vertical_top">
												<label for="id_emal" class="tit_style01">
													<span class="underline">아이디</span>
												</label>
											</th>
											<td>
												<div class="form_layout_style04 clfix">
													<ul class="form01 clfix">
														<li style="width: 70%;">
															<span class="input_txt">
																<input type="text" class="wd_200" id="joinId" name="id" onblur="idChk();" placeholder="아이디를 입력해주세요."/>
<%-- 																<form:input path="id" class="wd_200" id="joinId" name="id" onblur="idChk();" placeholder="아이디를 입력해주세요."/> --%>
															</span>
														</li>
														<div class="btn_area" style="width: 27%;float: right; padding: 0 0;">
															<a href="#" class="btn_black01" onclick="sendId();">중복확인</a>
														</div>
													</ul>
												</div>
											</td>
										</tr>
										<tr>
											<th class="vertical_top">
												<label for="joinPwd" class="tit_style01">
													<span class="underline">비밀번호</span>
												</label>
											</th>
											<td>
												<div class="input_txt">
													<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
													<input type="password" class="wd_200" id="joinPwd" name="pwd" onblur="pwdChk();" placeholder="비밀번호를 입력해주세요."/>
<%-- 													<form:password  path="pwd" class="wd_200" id="joinPwd" name="pwd" onblur="pwdChk();" placeholder="비밀번호를 입력해주세요."/> --%>
												</div>
												<!-- 일치 하지 않을 경우 .no_confirm 클래스를 붙여 줍니다. -->
												<div class="form_notice_area"  id="joinPwdTxt"></div>
											</td>
										</tr>
											<tr>
												<th class="vertical_top">
													<label for="pwd_confirm" class="tit_style01">
														<span class="underline">비밀번호 확인</span>
													</label>
												</th>
												<td>
													<div class="input_txt">
														<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
														<input style="width: 70%;" type="password" class="wd_200" id="reJoinPwd" name="rePwd" onblur="rePwdChk();" placeholder="비밀번호를 다시 입력해주세요."/>
													</div>
													<!-- 일치 하지 않을 경우 .no_confirm 클래스를 붙여 줍니다. -->
													<div class="form_notice_area" id="reJoinPwdTxt"></div>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<div>
														<div>*비밀번호는 특수문자를 포함한 10~12자리로 입력해주세요.(영문,숫자,특수문자 조합)</div>
														<div>*아이디, 휴대폰번호, 이메일 주소를 포함할 수 없으며 <c:out value='#,<,>,(,),"'/> 와 같은 특수문자는 사용할 수 없습니다.</div>
													</div>
												</td>												
											</tr>
											<tr>
												<th>
													<span class="tit_style01">
														<span class="underline">상호명</span>
													</span>
												</th>
												<td>
													<span class="input_txt">
														<input type="text" class="wd_200" id="joinCmpNm" name="cmpNm" placeholder="사업자등록증과 동일하게 작성해주세요."/>
<%-- 														<form:input path="cmpNm" class="wd_200" id="joinCmpNm" name="cmpNm" placeholder="사업자등록증과 동일하게 작성해주세요."/> --%>
													</span>
												</td>
											</tr>
											<tr>
												<th></th>
												<td>
													<div>
														<div>*상호명에 ㈜가 들어갈 경우 ‘주식회사’로 입력바랍니다.</div>
														<div>*상호명 공백(띄어쓰기)없이 입력 바랍니다.</div>
													</div>
												</td>												
											</tr>
											<tr>
												<th>
													<span class="tit_style01">
														<span class="underline">사업자 구분</span>
													</span>
												</th>
												<td>
													<input type="radio" name="cmpType" class="wd_200" value="C">법인사업자
													<input type="radio" name="cmpType" class="wd_200" value="P">개인사업자
<%-- 													<form:radiobutton path="cmpType" class="wd_200" value="C" label="법인사업자"/> --%>
<%-- 													<form:radiobutton path="cmpType" class="wd_200" value="P" label="개인사업자"/> --%>
												</td>
											</tr>
											<tr>
												<th>
													<span class="tit_style01">
														<span class="underline">업태/업종</span>
													</span>
												</th>
												<td>
													<div class="form_layout_style04 clfix">
														<span class="input_txt">
															<select>
																<option>업태/업종을 선택해주세요.</optinon>
																<option>IT/통신</option>
																<option>마케팅/리서치/대행업</option>
																<option>유통</option>
																<option>F&B/뷰티</option>
																<option>금융/보험</option>
																<option>교육업</option>
																<option>의료/보건</option>
																<option>제조업</option>
																<option>기타</option>
															</select>
														</span>
<%-- 														<form:select path="bizSt"> --%>
<%-- 															<form:option value="">업태/업종을 선택해주세요.</form:option> --%>
<%-- 															<form:options items="${bizSt}" itemLabel="" itemValue=""/> --%>
<%-- 														</form:select> --%>
													</div>
												</td>
											</tr>
											<tr>
											<th>
													<span class="tit_style01">
														<span class="underline">대표자</span>
													</span>
												</th>
												<td>
													<span class="input_txt">
														<input type="text" class="wd_200" id="joinReprNm" name="reprNm" placeholder="입력해주세요."/>
<%-- 														<form:input path="reprNm" class="wd_200" id="reprNm" name="reprNm" placeholder="입력해주세요."/> --%>
													</span>
												</td>
											</tr>
											<tr>
												<th>
													<span class="tit_style01">
														<span class="underline">담당자</span>
													</span>
												</th>
												<td>
													<span class="input_txt">
														<input type="text" class="wd_200" id="joinMngr" name="mngr" placeholder="입력해주세요."/>
<%--  														<form:input path="mngr" class="wd_200" id="mngr" name="mngr" placeholder="입력해주세요."/> --%>
													</span>
												</td>
											</tr>
																						<tr>
												<th>
													<span class="tit_style01">
														<span class="underline">근무부서</span>
													</span>
												</th>
												<td>
													<span class="input_txt">
														<input type="text" class="wd_200" id="joinDept" name="dept" placeholder="입력해주세요."/>
<%-- 														<form:input path="dept" class="wd_200" id="dept" name="dept" placeholder="입력해주세요."/> --%>
													</span>
												</td>
											</tr>
											<tr>
												<th>
													<label for="phone_number01" class="tit_style01">
														<span class="underline">유선전화번호</span>
													</label>
												</th>
												<td>
													<div class="form_layout_style04 clfix">
														<ul class="form01 clfix">
															<li style="width: 20%;">
																<span class="input_txt">
																	<select id="tel01" name="tel01">
																		<option value="0">선택</option>
																		<option value="02">02</option>
																		<option value="031">031</option>
																	</select>
<%-- 																	<form:select path=""> --%>
<%-- 																		<form:option value="">선택</form:option> --%>
<%-- 																		<form:options itemLabel="" itemValue="">02</form:options> --%>
<%-- 																		<form:options itemLabel="" itemValue="">031</form:options> --%>
<%-- <%-- 																			<form:options items="${oneDepth}" itemLabel="tel01" itemValue="tel01"/> --%>
<%-- 																	</form:select> --%>
																</span>
															</li>
															<li class="etd_child"  style="width: 25%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="tel02" name="" numberonly="true" maxlength="4"/>
<%-- 																	<form:input class="wd_200" path="" id="tel02" numberonly="true" maxlength="4"/> --%>
																</span>
															</li>
															<li class="last_child"  style="width: 25%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="tel03" name="" numberonly="true" maxlength="4"/>
<%-- 																	<form:input class="wd_200" path="" id="tel03" numberonly="true" maxlength="4"/> --%>
																</span>
															</li>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<label for="phone_number01" class="tit_style01">
														<span class="underline">휴대폰번호</span>
													</label>
												</th>
												<td>
													<div class="form_layout_style04 clfix">
														<ul class="form01 clfix">
															<li style="width: 20%;">
																<span class="input_txt">
																	<select id="cpNo01" name="cpNo01">
																		<option value="0">선택</option>
																		<option value="010">010</option>
																		<option value="018">018</option>
																	</select>
<%-- 																	<form:select path=""> --%>
<%-- 																		<form:option value="">선택</form:option> --%>
<%-- 																		<form:options itemLabel="" itemValue="">010</form:options> --%>
<%-- 																		<form:options itemLabel="" itemValue="">018</form:options> --%>
<%-- 																	</form:select> --%>
																</span>
															</li>
															<li class="etd_child"  style="width: 25%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="cpNo02" name="" numberonly="true" maxlength="4"/>
<%-- 																	<form:input class="wd_200" path="" id="cpNo02" numberonly="true" maxlength="4"/> --%>
																</span>
															</li>
															<li class="last_child"  style="width: 25%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="cpNo03" name="" numberonly="true" maxlength="4"/>
<%-- 																	<form:input class="wd_200" path="" id="cpNo03" numberonly="true" maxlength="4"/> --%>
																</span>
															</li>
															<div class="btn_area" style="width: 27%;float: right; padding: 0 0;">
																<a href="#" class="btn_black01" onclick="sendPhoneCertNo();">인증하기</a>
															</div>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<label for="email" class="tit_style01">
														<span class="underline">이메일</span>
													</label>
												</th>
												<td>
													<div class="form_layout_style04 clfix">
														<ul class="form01 clfix">
															<li style="width: 20%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="joinEmail01" name="" onblur="" />
<%-- 																	<form:input path="" class="wd_200" id="joinEmail" name="email" onchange="setDuplStat();" onblur="idDuplChk();" /> --%>
																</span>
															</li>
															<li class="etd_child"  style="width: 25%;">
																<span class="input_txt">
																	<input type="text" class="wd_200" id="joinEmail02" name="" onblur="" placeholder="직접입력"/>
																</span>
															</li>
															<li class="last_child"  style="width: 25%;">
																<span class="input_txt">
																	<select>
																		<option>이메일 선택</option>
																		<option>naver.com</option>
																		<option>gmail.com</option>
																		<option>daum.net</option>
																	</select>
																</span>
															</li>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<div>
														<div>* 담당자/유선전화번호/휴대전화번호/이메일 변경은 회원가입 후 회원정보에서 변경할 수 있습니다.</div>
														<div>* 사업자정보(상호명/대표자/업태/업종)의 변경은 기프티엘비즈 고객센터(1234-1234)로 문의 부탁 드립니다.</div>
													</div>
												</td>												
											</tr>
											<tr>
												<td colspan="2">
													<div class="join_agree_area02 space02">
														<div class="join_agree_tit">부가정보</div>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<label for="" class="tit_style01">
														<span class="underline">광고성 정보 수신</span>
													</label>
												</th>
												<td>
													<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
													<label for="sms" class="inputu_check">
														<input type="checkbox" id="sms" name="sms">
														<span class="txt">SMS 알림</span>
													</label>
													<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
													<label for="mail" class="inputu_check">
														<input type="checkbox" id="mail" name="mail">
														<span class="txt">이메일 알림</span>
													</label>
												<div>이벤트/고객혜택 등의 정보를 선택하신 수단으로 알림 메시지를 전송합니다.</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="btn_area">
									<a href="#" class="btn_black01" id="saveBtn">Form 테스트</a>
								</div>
							</div>
						</div>
						<!--[s] 약관 동의 -->
						<jsp:include page="joinConfirm.jsp"></jsp:include>
						<!--[e] 약관 동의 -->
					</div>
				</form:form>
			</div>
		</div>
		<div class="etc_section"></div>
	</div>
	<div>
		<h2 class="hide_txt">하단 영역</h2>
		<div id="footer">
			<!-- footer include -->
			<!-- footer include -->
		</div>
	</div>
</body>
</html>