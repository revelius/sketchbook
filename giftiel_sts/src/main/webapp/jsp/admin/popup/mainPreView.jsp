<%--
 * =============================================================================
 * 파일명 : admin/popup/mainPreView.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-08-18
 *
 * 파일 내용 : 관리자 메인 미리보기
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
		<style type="text/css">
			a {
				cursor:default;
			}
			
			.main_visual li {
				padding: 0 0 0px
			}
		</style>
		
		<script type="text/javascript">
		$(function() { 
			


			
		 });
		
		function noScript(){
			$("a").off("click");
			$("input").off("keydown");
			 
			$(document).on("click","a",function(){
				return false;
			});
			
			
			$(document).on("keydown",function(e){
				return false;
				
			});
			 
		}
		</script>
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
										<c:when test="${not empty mainManageForm.mainManage}">
											<c:forEach items="${mainManageForm.mainManage}" var="mainManage" varStatus="listCount">
												<c:choose>
													<c:when test="${listCount.last}">
													<li class="last_child">
														<div class="txt_area">
															<div class="txt">
																<img src="<c:url value='${uploadImage}${mainManage.txt}'/>" alt="Main Text Image" class="grayscale" />
															</div>
														</div>
														<a href="${mainManage.lnkUrl}">
															<img name="mainImg" src="<c:url value='${uploadImage}${mainManage.imgUrl}'/>" alt="Main Image" class="grayscale grayscale-fade" />
														</a>
													</li>												
													</c:when>
													<c:otherwise>
													<li>
														<div class="txt_area">
															<div class="txt">
																<img src="<c:url value='${uploadImage}${mainManage.txt}'/>" alt="Main Text Image" class="grayscale" />
															</div>
														</div>
														<a href="${mainManage.lnkUrl}">
															<img name="mainImg" src="<c:url value='${uploadImage}${mainManage.imgUrl}'/>" alt="Main Image" class="grayscale grayscale-fade" />
														</a>
													</li>
													</c:otherwise>	
												</c:choose>										
											</c:forEach>
										</c:when>
										<c:otherwise>
													<li>
														<div class="txt_area">
															<div class="txt">
																<span></span>
															</div>
														</div>
														<a href="javascript:void();">
															등록된 내용이 없습니다.
														</a>
													</li>
										</c:otherwise>
									</c:choose>
								</ul>
<!-- 								<div class="btn_area"> -->
<%-- 									<a href="<c:url value='/front/news/newsList' />"> --%>
<%-- 										<img src="<c:url value='/resources/worksout/images/common/btn_other_news.png'/>" alt="OTHER NEWS"> --%>
<!-- 									</a> -->
<!-- 								</div> -->
								
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
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>