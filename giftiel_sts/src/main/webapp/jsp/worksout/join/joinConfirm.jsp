<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입약관동의및 본인인증 
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
					<div class="content_wrap">
						<div class="content_section">
							<div class="content_area">
								<div class="join_area">
									<div class="join_agree_area02 space02">
										<div class="join_agree_tit">약관 동의</div>
									</div>
									<div class="join_agree_area">
										<div class="join_agree_tit">기프티엘비즈 서비스 이용약관</div>
										<div id="join_agreement_load01" class="join_agreement">
											<!-- /inc/layout/agreement01.html -->
										</div>
										<div class="join_agree_check">
											<label for="agree" class="inputu_check">
												<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
												<span class="txt">위의 약관을 모두 확인하였으며 동의합니다. (동의하지 않을 시 회원가입이 불가합니다.)</span>
												<input type="checkbox" id="agree" name="agree">
											</label>
										</div>
									</div>
									<div class="join_agree_area">
										<div class="join_agree_tit">개인정보 수집•이용동의</div>
										<div id="join_agreement_load02" class="join_agreement">
											<!-- /inc/layout/agreement02.html -->
										</div>
										<div class="join_agree_check">
											<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
											<label for="agree02" class="inputu_check">
												<span class="txt">위의 약관을 모두 확인하였으며 동의합니다. (동의하지 않을 시 회원가입이 불가합니다.)</span>
												<input type="checkbox" id="agree02" name="agree02">
											</label>
										</div>
									</div>
									<div class="join_agree_area">
										<div class="join_agree_tit">개인정보 수집•이용동의(선택)</div>
										<div id="join_agreement_load03" class="join_agreement">
											<!-- /inc/layout/agreement02.html -->
										</div>
										<div class="join_agree_check">
											<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
											<label for="agree02" class="inputu_check">
												<span class="txt">위의 약관을 모두 확인하였으며 동의합니다.</span>
												<input type="checkbox" id="agree02" name="agree02">
											</label>
										</div>
									</div>
									<div class="join_agree_all_check">
										<label for="all_check">위 기프티엘비즈 전체약관을 확인하였으며 동의합니다.</label>
										<span class="input_check">
											<input type="checkbox" id="all_check" name="all_check" data-chkBox='allcheck'>
											<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
										</span>
									</div>
									<div class="join_agree_area">
 									<div class="btn_area04">
										<a href="#" class="btn01 btn_black01" data-btn="skipAuth">회원가입</a>
										<a href="#" class="btn02 btn_black01" data-btn="skipAuth">취소</a>
									</div>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
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

