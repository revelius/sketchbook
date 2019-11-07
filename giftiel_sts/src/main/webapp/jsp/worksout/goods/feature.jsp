<%--
 * =============================================================================
 * 파일명 : /front/goods/feature.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-24
 *
 * 파일 내용 : onlineShop > feature
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
			$(document).ready(function(){
				
				$(".product_view li").css("cursor","pointer");
				$("ul li").on("click",function(){
					if($(this).attr("data-link")){
						location.href = $(this).attr("data-link");
					}
				});
			});
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
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
								<a href="#">ONLINESHOP</a>
							</li>
							<!-- <li>
								<a href="#">FEATURE</a>
							</li> -->
						</ul>
						<div class="menu_section">
							<div id="snb_shop_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<input type="hidden" id="oneDepth" value="${param.oneDepth }">
						<input type="hidden" id="twoDepth" value="${param.twoDepth }">
						<input type="hidden" id="threeDepth" value="${param.threeDepth }">
						<input type="hidden" id="brand" value="${param.brand }">
						<input type="hidden" id="sex" value="${param.sex }">
						<input type="hidden" id="ubiGdsSize" value="${param.ubiGdsSize }" />				
						<input type="hidden" id="clbltnNm" value="${param.clbltnNm }">
						<input type="hidden" id="orderFlag" value="${param.orderFlag }">
						<input type="hidden" id="orderBy" value="${param.orderBy }">			
						<input type="hidden" id="viewType" value="${param.viewType }">						
						<input type="hidden" id="nowSeq" value="${param.nowSeq}">						
						<div class="content_section">
							<div class="content_area">
								<!-- 
								<div class="content_top">
									<div class="content_menu">
										<!-- on 클래스 붙으면 활성화 됨
										<a href="<c:url value='/front/onlineShop/goodsList'/>">PRODUCTS LIST</a>
										<a href="#" class="on last_child">FEATURE</a>
									</div>
								</div>
								-->
								<ul class="product_view clfix">
									<c:forEach items="${featureList }" varStatus="idx" var="feature">
										<li class="view0${idx.count }" <c:if test="${feature.lnkUrl ne null }">data-link="${feature.lnkUrl}"</c:if>>
										<c:if test="${feature.txt ne null}">
											<div class="p_txt_area">
												<div class="p_txt">
													<span>${feature.txt}</span>
												</div>
											</div>
										</c:if>
											<div class="p_img">
												<img src="${uploadImage}${feature.imgUrl}" alt="이미지" width="100%">
											</div>
										</li>									
									</c:forEach>
								</ul>
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