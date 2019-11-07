<%--
 * =============================================================================
 * 파일명 : /storeInfoCaDg.jsp(CARHARTT WIP 압구정)
 * 작성자 : 권용재
 * 작성일자 : 2016-12-26
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
												<div class="store_info_item"><img src="/resources/worksout/images/storeinfo/CA_DG_01.jpg" alt="대구"></div>
												<div class="store_info_item"><img src="/resources/worksout/images/storeinfo/CA_DG_02.jpg" alt="대구"></div>
												<div class="store_info_item"><img src="/resources/worksout/images/storeinfo/CA_DG_03.jpg" alt="대구"></div>
												<div class="store_info_item"><img src="/resources/worksout/images/storeinfo/CA_DG_04.jpg" alt="대구"></div>
												<div class="store_info_item"><img src="/resources/worksout/images/storeinfo/CA_DG_05.jpg" alt="대구"></div>
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
										<div id="naverMap" title="대구 신세계점" >
										<input type="hidden" id="lat" value="35.8791541" />
										<input type="hidden" id="lng" value="128.6275587" />
										</div>
									</div>

									<dl class="store_info_txt">
										<dt>CARHARTT WIP STORE DAEGU</dt>
										<dd>대구광역시 동구 동부로 149 신세계백화점 대구점 6층</dd>
										<dd>053.661.6593</dd>
										<dd>MON - THU AM 10:30 – PM 20:00</dd>
										<dd>FRI - SUN AM 10:30 – PM 21:00</dd>
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