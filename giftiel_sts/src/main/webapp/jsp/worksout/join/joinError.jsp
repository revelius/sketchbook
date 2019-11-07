<%--
 * =============================================================================
 * 파일명 : /manage/newsDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : news 상세
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
						<div class="menu_section"></div>
						<div class="content_section">
							<div class="content_area">
								<div class="error_content">
									<p class="txt01">인증을 받는 도중 오류가 발생하였습니다.</p>
									<p class="txt02">${errorTxt}</p>
									<p class="txt03">관련하여 문의 사항이 있으면
										<span class="style01"><a href="<c:url value="/front/contactUs"/>">CUSTOMER CARE</a></span>로 문의해 주시기 바랍니다.</p>
									<div class="error_btn_area">
										<a href="javascript:void(0);" onclick="history.back(); return false;" class="btn01">이전</a>
										<a href="<c:url value="/front/main"/>" class="btn02">첫화면</a>
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