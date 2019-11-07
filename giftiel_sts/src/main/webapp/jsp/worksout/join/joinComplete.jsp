<%--
 * =============================================================================
 * 파일명 : /front/join/joinComplete.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 가입완료화면 
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
		<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
		 <script type="text/javascript">
		var _nasa={};
		 _nasa["cnv"] = wcs.cnv("2","10"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
		</script>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
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
											<span class="txt">약관동의 및 본인인증</span>
										</a>
										<a href="#">
											<span class="txt">정보입력</span>
										</a>
										<a href="#" class="on last_child">
											<span class="txt">가입완료</span>
										</a>
									</div>
								</div>
								<div class="join_area">
									<div class="join_agree_area02 space02">
										<div class="join_agree_tit">회원가입완료</div>
									</div>
									<div class="join_complete">
										<p class="style01">${joinForm.nm}님의 회원가입이 완료되었습니다.</p>
										<p class="style02">이제 회원님께서는 아래와 같은
											<strong class="point">혜택</strong>
											을 누리실 수 있습니다.</p>
										<ul class="style03">
											<li>- 제품 구매 시마다 포인트가 적립됩니다.</li>
											<li>- 온라인 쇼핑몰 뿐만 아니라 오프라인 매장에서도 포인트 적립이 가능합니다.</li>
											<li>- 적립하신 포인트는 온라인 쇼핑몰에서 현금처럼 사용이 가능합니다.</li>
											<li class="last_child">
												<a href="#" class="btn_black01" onclick="location.href ='<c:url value='/front/main'/>'">홈으로 가기</a>
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