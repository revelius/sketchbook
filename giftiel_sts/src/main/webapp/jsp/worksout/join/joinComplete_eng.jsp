<%--
 * =============================================================================
 * 파일명 : /front/join/joinComplete_eng.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 가입완료화면_외국인
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
										<a href="#">
											<span class="txt">PROFILE</span>
										</a>
										<a href="#" class="on last_child">
											<span class="txt">COMPLETION</span>
										</a>
									</div>
								</div>
								<div class="join_area">
									<div class="join_agree_area02 space02">
										<div class="join_agree_tit">COMPLETION</div>
									</div>
									<div class="join_complete">
										<p class="style01 font_size01">WELCOME ${joinForm.nm} !</p>
										<p class="style02">YOU CAN GET THE BENEFITS OF MEMBERSHIP.</p>
										<ul class="style03">
											<li class="last_child">
												<a href="#" onclick="location.href ='<c:url value='/front/main'/>'" class="btn_black01">HOME</a>
											</li>
										</ul>
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