<%--
 * =============================================================================
 * 파일명 : admin/popup/featurePreView.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-08-18
 *
 * 파일 내용 : 관리자 피쳐 미리보기
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
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				
				
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
								<a href="#">HOME</a>
							</li>
							<li>
								<a href="#">ONLINESHOP</a>
							</li>
							<li>
								<a href="#">FEATURE</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_shop_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<a href="<c:url value='/front/onlineShop/goodsList'/>">PRODUCTS LIST</a>
										<a href="#" class="on last_child">FEATURE</a>
									</div>
								</div>
								<ul class="product_view clfix">
									
									<li class="view01" data-link="${featureManageForm.featureManage.get(0).lnkUrl}">
										<div class="p_txt_area">
											<div class="p_txt">
												<span>${featureManageForm.featureManage.get(0).txt}</span>
											</div>
										</div>
										<div class="p_img">
											<img src="${uploadImage}${featureManageForm.featureManage.get(0).imgUrl}" alt="이미지">
										</div>
									</li>
									<li class="view02" data-link="${featureManageForm.featureManage.get(1).lnkUrl}">
										<div class="p_txt_area">
											<div class="p_txt">
												<span>${featureManageForm.featureManage.get(1).txt}</span>
											</div>
										</div>
										<div class="p_img">
											<img src="${uploadImage}${featureManageForm.featureManage.get(1).imgUrl}" alt="이미지">
										</div>
									</li>
									<li class="view03" data-link="${featureManageForm.featureManage.get(2).lnkUrl}">
										<div class="p_txt_area">
											<div class="p_txt">
												<span>${featureManageForm.featureManage.get(2).txt}</span>
											</div>
										</div>
										<div class="p_img">
											<img src="${uploadImage}${featureManageForm.featureManage.get(2).imgUrl}" alt="이미지">
										</div>
									</li>
									<li class="view04" data-link="${featureManageForm.featureManage.get(3).lnkUrl}">
										<div class="p_txt_area">
											<div class="p_txt">
												<span>${featureManageForm.featureManage.get(3).txt}</span>
											</div>
										</div>
										<div class="p_img">
											<img src="${uploadImage}${featureManageForm.featureManage.get(3).imgUrl}" alt="이미지">
										</div>
									</li>
									<li class="view05" data-link="${featureManageForm.featureManage.get(4).lnkUrl}">
										<div class="p_txt_area">
											<div class="p_txt">
												<span>${featureManageForm.featureManage.get(4).txt}</span>
											</div>
										</div>
										<div class="p_img">
											<img src="${uploadImage}${featureManageForm.featureManage.get(4).imgUrl}" alt="이미지">
										</div>
									</li>									
									
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