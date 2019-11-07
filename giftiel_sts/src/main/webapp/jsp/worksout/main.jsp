<%--
 * =============================================================================
 * 파일명 : /front/worksout/main.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-05-15
 *
 * 파일 내용 : worksout > main
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<style type="text/css">
			<c:if test="${siteNo ne '10004'}">
			.main_visual li {
				padding: 0 0 0px
			}
			</c:if>
			<c:if test="${siteNo eq '10004'}">
			/* 20160331 추가 */
			/* mobile portrait */
			@media screen and (max-width:480px){
				.main_visual li {
					padding: 0 0 30px 0;
				}
			}

			/* mobile landscape */
			@media screen and (min-width:481px) and (max-width:768px){
				.main_visual li {
					padding: 0 0 30px 0;
				}
			}
			/* 20160331 추가 */
			</c:if>
		</style>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<!--[if lte IE 11]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
		<img src="<c:url value='/resources/worksout/images/common/blank_size_100.png'/>" alt="">
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
						<div class="menu_section">
							<div id="snb_main_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<ul class="main_visual">
									<c:choose>
										<c:when test="${not empty worksoutList}">
											<c:forEach items="${worksoutList}" var="worksout" varStatus="listCount">
												<c:choose>
													<c:when test="${listCount.last}">
														<li class="last_child">
													</c:when>
													<c:otherwise>
														<li>
													</c:otherwise>	
												</c:choose>
												<c:choose>
													<c:when test="${not empty worksout.txt }">
															<c:if test="${siteNo ne '10004'}">
																<div class="txt_area">
																	<div class="txt">
																		<img src="<c:url value='${uploadImage}${worksout.txt}'/>" alt="Main Text Image" />
																	</div>
																</div>
															</c:if>
													</c:when>
												</c:choose>
														<a href="${worksout.lnkUrl}">
															<img name="mainImg" src="<c:url value='${worksout.frontImgUrl}'/>" alt="Main Image" data-id="original" />
														</a>
														<c:if test="${siteNo eq '10004'}">
															<div class="txt_area02">
																${worksout.txt}
															</div>
														</c:if>
														</li>
											</c:forEach>
										</c:when>
										<c:otherwise>
													<li>
														<div class="txt_area">
															<div class="txt">
															</div>
														</div>
														<a href="javascript:void();">
															등록된 내용이 없습니다.
														</a>
													</li>
										</c:otherwise>
									</c:choose>
								</ul>
								
								
								
								<div class="btn_area">
									<a href="<c:url value='/front/news/newsList' />" class="btn_animate01" data-id="btnArrowAnimate" data-btn-type="horizon">
										<span class="txt color_gray">OTHER NEWS</span>
										<span class="animate" style="display:none;">
											<!-- <img src="/resources/worksout/images/common/bu_arrow_top02.png" alt=""> -->
										</span>
									</a>
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
				<%@ page import="java.util.*"%>
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>