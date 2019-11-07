<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm.jsp
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
		<script type="text/javascript">
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
																		<input  type="text" class="wd_200" id="" name="" onblur="" placeholder="아이디를 입력해주세요."/>
																	</span>
																</li>
																<div class="btn_area" style="width: 27%;float: right; padding: 0 0;">
																	<a href="#" class="btn_black01" onclick="sendCertNo();">중복확인</a>
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
	<!-- 															<input type="password" id="joinPwd" name="pwd" placeholder="6-15자 이내 영,숫자,특수문자를 사용하세요."> -->
	<%-- 															<form:password  path="pwd" class="wd_200" id="joinPwd" name="pwd" onblur="pwdChk();" placeholder="6-15자 이내 영,숫자,특수문자를 사용하세요."/> --%>
															<input style="width: 70%;" type="password" class="wd_200" id="joinPwd" name="pwd" onblur="rePwdChk();" placeholder="비밀번호를 입력해주세요."/>
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
	<!-- 															<input type="password" id="pwd_confirm" name="pwd_confirm"> -->
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
														<th></th>
														<td>
															<div class="input_txt">
	<%-- 															<form:input path="nm" class="wd_200" id="nm" name="nm" placeholder="홍길동"/> --%>
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
																<input  type="text" class="wd_200" id="" name="" onblur="" placeholder="사업자등록증과 동일하게 작성해주세요."/>
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
	<%-- 														<form:radiobutton path="sex" class="wd_200" value="M" label="MEN"/> --%>
	<%-- 														<form:radiobutton path="sex" class="wd_200" value="W" label="WOMEN"/> --%>
															<input type="radio">법인사업자</>
															<input type="radio">개인사업자</>
	<%-- 														<form:hidden path="birthDt" class="wd_200" placeholder="87/01/11"/>														 --%>
	<!-- 														<div class="form_layout_style04 clfix"> -->
	<!-- 															<ul class="form01 clfix"> -->
	<!-- 																<li style="width: 35%;"> -->
	<!-- 																	<span class="input_txt"> -->
	<%-- <%-- 																		<form:input path="birth01" id="birth01" numberonly="true" maxlength="4" placeholder="1900"/> --%>
	<!-- 																	</span> -->
	<!-- 																</li> -->
	<!-- 																<li class="etd_child"  style="width: 20%;"> -->
	<!-- 																	<span class="input_txt"> -->
	<%-- <%-- 																		<form:input path="birth02" id="birth02" numberonly="true" maxlength="2" placeholder="01"/> --%>
	<!-- 																	</span> -->
	<!-- 																</li> -->
	<!-- 																<li class="last_child"  style="width: 20%;"> -->
	<!-- 																	<span class="input_txt"> -->
	<%-- <%-- 																		<form:input path="birth03" id="birth03" numberonly="true" maxlength="2" placeholder="31"/> --%>
	<!-- 																	</span> -->
	<!-- 																</li> -->
	<!-- 															</ul> -->
	<!-- 														</div>														 -->
														</td>
													</tr>
													<tr>
														<th>
															<label for="phone_number01" class="tit_style01">
																<span class="underline">업태/업종</span>
															</label>
														</th>
														<td>
															<div class="form_layout_style04 clfix">
	<%-- 															<form:select path="oneDepth"> --%>
	<%-- 																<form:option value="">대 카테고리</form:option> --%>
	<%-- 																<form:options items="${oneDepth}" itemLabel="cateNm" itemValue="cateCd"/> --%>
	<%-- 															</form:select> --%>
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
																<input  type="text" class="wd_200" id="" name="" onblur="" placeholder="입력해주세요."/>
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
																<input  type="text" class="wd_200" id="" name="" onblur="" placeholder="입력해주세요."/>
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
																<input  type="text" class="wd_200" id="" name="" onblur="" placeholder="입력해주세요."/>
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
																			<select>
																				<option>선택</option>
																				<option>02</option>
																				<option>031</option>
																			</select>
	<%-- 																		<form:input path="cpNo01" id="cpNo01" numberonly="true" maxlength="3"/> --%>
																		</span>
																	</li>
																	<li class="etd_child"  style="width: 25%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo02" id="cpNo02" numberonly="true" maxlength="4"/> --%>
																		</span>
																	</li>
																	<li class="last_child"  style="width: 25%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo03" id="cpNo03" numberonly="true" maxlength="4"/> --%>
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
																			<select>
																				<option>선택</option>
																				<option>010</option>
																				<option>018</option>
																			</select>
	<%-- 																		<form:input path="cpNo01" id="cpNo01" numberonly="true" maxlength="3"/> --%>
																		</span>
																	</li>
																	<li class="etd_child"  style="width: 25%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo02" id="cpNo02" numberonly="true" maxlength="4"/> --%>
																		</span>
																	</li>
																	<li class="last_child"  style="width: 25%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo03" id="cpNo03" numberonly="true" maxlength="4"/> --%>
																		</span>
																	</li>
																	<div class="btn_area" style="width: 27%;float: right; padding: 0 0;">
																		<a href="#" class="btn_black01" onclick="sendCertNo();">인증하기</a>
																	</div>
																</ul>
															</div>
														</td>
													</tr>
													<tr>
														<th>
															<label for="phone_number01" class="tit_style01">
																<span class="underline">이메일</span>
															</label>
														</th>
														<td>
															<div class="form_layout_style04 clfix">
																<ul class="form01 clfix">
																	<li style="width: 20%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo01" id="cpNo01" numberonly="true" maxlength="3"/> --%>
																		</span>
																	</li>
																	<li class="etd_child"  style="width: 25%;">
																		<span class="input_txt">
																			<input  type="text" class="wd_200" id="" name="" onblur=""/>
	<%-- 																		<form:input path="cpNo02" id="cpNo02" numberonly="true" maxlength="4"/> --%>
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
									</div>
								</div>
								<!--[s] 약관 동의 -->
								<jsp:include page="joinConfirm.jsp"></jsp:include>
								<!--[e] 약관 동의 -->
							</form:form>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
				<
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>