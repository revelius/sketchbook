<%--
 * =============================================================================
 * 파일명 : /storeInfoCaNoon.jsp(WORKSOUT 서울눈스퀘어)
 * 작성자 : 이현우
 * 작성일자 : 2016-10-19
 *
 * 파일 내용 : storeInfo
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<script type='text/javascript' src='http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=a7590aae765537ff016a9b3126a7e2be' charset='utf-8'></script>
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
						<div class="location_list_wrap">
							<div class="location_list_container">
								<ul class="location_list clfix">
									<li class="home">
										<a href="<c:url value='/front/main'/>">HOME</a>
									</li>
									<li>
										<a href="#">STORE INFO</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="menu_section">
							<div id="snb_store_info_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="store_info_aera">
									<div class="store_info_slide_wrap">
										<div id="mySwipe" class="store_info_slide_container ui_swipe">
											<div class="store_info_slide_list">
											<!-- [Start] 스토어 이미지 슬라이드 등록부분 -->
												<div class="store_info_item">
													<img src="/resources/worksout/images/storeinfo/CA_NOON_01.jpg" alt="서울 눈스퀘어">
												</div>
												<div class="store_info_item">
													<img src="/resources/worksout/images/storeinfo/CA_NOON_02.jpg" alt="서울 눈스퀘어">
												</div>
												<div class="store_info_item">
													<img src="/resources/worksout/images/storeinfo/CA_NOON_03.jpg" alt="서울 눈스퀘어몰">
												</div>
												<div class="store_info_item">
													<img src="/resources/worksout/images/storeinfo/CA_NOON_04.jpg" alt="서울 눈스퀘어">
												</div>
											<!-- [End] 스토어 이미지 슬라이드 등록부분 -->
											</div>
										</div>
										<a href="#" class="btn_prev">
											<span class="hide_txt">이전 이미지</span>
										</a>
										<a href="#" class="btn_next">
											<span class="hide_txt">다음 이미지</span>
										</a>
<!-- 										<div class="store_info_pagenavi ui_rolling"> -->

<!-- 										</div> -->
									</div>

									<div class="store_info_map_wrap">
										<!-- NHN 맵 영역 -->
										<div id="naverMap" title="서울 눈스퀘어" >
										<input type="hidden" id="lat" value="37.5633734" />
										<input type="hidden" id="lng" value="126.98288619999994" />
										</div>
									</div>

									<dl class="store_info_txt">
										<dt>CARHARTT WIP STORE <!-- 서울 눈스퀘어 -->/ SEOUL NOON SQUARE</dt>
										<dd>서울특별시 중구 명동길 14 눈스퀘어 4층</dd>
										<dd>02.3783.5225</dd>
<!-- 										<dd>AM 10:30 – PM 20:00 평일 / AM 10:30 – PM 21:00 금, 토, 일, 공휴일</dd> -->
										<dd>MON - SUN, 11:00AM - 10:00PM</dd>
										<!-- 아래 a태그 에 on 클래스 붙으면 활성화 됨. -->
										<dd class="btn_map">
											<a href="javascript:void(0)">MAP</a>
										</dd>
									</dl>
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