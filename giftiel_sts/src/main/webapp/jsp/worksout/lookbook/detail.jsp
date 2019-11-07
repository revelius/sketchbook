<%--
 * =============================================================================
 * 파일명 : /worksout/lookbook/detail.jsp
 * 작성자 : 신지영
 * 작성일자 : 2015-05-26
 *
 * 파일 내용 : LookBook > 상세
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
		<META http-equiv="Cache-Control" content="max-age"> 	
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazyload/1.9.1/jquery.lazyload.js"></script>		
		<script type="text/javascript">
		$(function() {
     		//이미지 순차로딩
     		$('img').lazyload({effect : 'fadeIn'});
     		
			/* 
			$(".btn_ctr_prev").hide();
			$(".btn_ctr_next").hide();
			 */
			
			//연관상품 페이지 이동
			gotoGoods = function(linkUrl) {
				$(location).attr('href',linkUrl);
			};
			
			
			/* 
			$(".lookbook_slide_wrap").hover(function(e){
				$(".btn_ctr_prev").show();
				$(".btn_ctr_next").show();
			},function(e){    
				$(".btn_ctr_prev").hide();
				$(".btn_ctr_next").hide();
			});
			 */
			 
			 
			$(".grayscale").hover(function(e){
				var $target = $(e.currentTarget);
				$target.attr("class", "");
			},function(e){
				var $target = $(e.currentTarget);
				$target.attr("class", "grayscale");
			});
			
		});
		
		
		function imgLoad(e){
			//alert($(e).attr("src"));
			var w, h;
	        var img = document.createElement('img');
	        img.src = $(e).attr("src");
	        w = img.width;
	        h = img.height;
	        if(w>=h){
	        	$(e).attr("data-type","horizontal");
	        }else{
	        	$(e).attr("data-type","vertical");
	        }
	        img = null;    
		}
		
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="${contextPath}/resources/worksout/images/common/blank_size_100.png" alt="">
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
						<ul class="location_list clfix ui_lookbook_list">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/lookbook/list'/>">LOOK BOOK</a>
							</li>
							<li>
								<a href="#">DETAIL</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_lookbook_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						
						
						
						
						<div class="content_section">
							<div class="content_area">
								<div class="lookbook_list_area">
									<ul class="lookbook_detail_new clfix">
										<c:forEach var="image" items="${detail.images}" varStatus="status">
											<li>
												<a href="#">
													 <span>
														<img src="<c:url value='http://worksout60.cafe24.com/upload/image/img-loading.gif'/>" data-original="${image.frontImgUrl}" alt="관리자에서 등록할 수 있게 개발 필요" <c:if test="${siteNo != 10004 }">class="grayscale"</c:if> onload="imgLoad(this);" class="lazy">
													</span>
												</a>
											</li>
										</c:forEach>
										
									</ul>
									
									<div class="btn_area">
										<a href="<c:url value='/front/lookbook/list' />" class="btn_animate01" data-id="btnArrowAnimate" data-btn-type="horizon">
											<span class="txt color_gray">LIST</span>
											<span class="animate" style="display:none;">
												<!-- <img src="/resources/worksout/images/common/bu_arrow_top02.png" alt=""> -->
											</span>
										</a>
									</div>
									
								</div>
							</div>
						</div>
						
						
						
						
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			
			
			<script>
			/* $(function()
			{
				$('.lookbook_detail_new > li > a').on('click', function(e)
				{
					var $target = $(e.currentTarget);
					var src = $target.find("span > img").prop("src");
					
					//$(".lookbook_detail_layer_wrap").find("img").attr("src", src);	
					$('.lookbook_detail_layer').show();
				});
				
				$('.lookbook_detail_layer_close').on('click', function(e)
				{
					$('.lookbook_detail_layer').hide();
				});
			}); */
			</script>
			<div class="lookbook_detail_layer ui_lookbook_detail">
				<div class="lookbook_detail_layer_tit">${detail.title }<!-- DEUS EX MACHINA<br> SUMMER 2015 COLLECTION --></div>
				
				<div class="lookbook_detail_layer_wrap ui_lookbook_detail_wrap">
					<ul class="lookbook_detail_layer_list clfix">
						<c:forEach var="image" items="${detail.images}" varStatus="status">
						<li class="lookbook_detail_layer_item lookbook_item">
							<!-- 카운터 넘버링과 의류 가격정보등을 개발에서 데이터로 미리 가져 옵니다. -->
							<span class="hide_txt count">1/23</span>
							<ul class="hide_txt lookbook_item_info_list">
								<c:if test="${not empty image.goodss}">
									<c:forEach var="goods" items="${image.goodss}">
										<li><a href="javascript:gotoGoods('${goods.linkUrl}');"> ${goods.gdsNm} <fmt:formatNumber value="${goods.slPrc}" pattern="w#,###.##"/></a></li>
									</c:forEach>
								</c:if>
							</ul>
							<img id="${image.imgSeq}" data-src="${image.frontDtlImgUrl}" alt="관리자에서 들어갈 수 있도록 개발 필요." data-img data-type="horizon" onload="imgLoad(this);">
						</li>
						</c:forEach>
					</ul>
				</div>
				
				<a href="#" class="btn_ctr_prev ui_btn_prev">
					<span class="hide_txt">이전 이미지</span>
				</a>
				<a href="#" class="btn_ctr_next ui_btn_next">
					<span class="hide_txt">다음 이미지</span>
				</a>
				<!-- 위의 데이터를 스크립트로 가져와서 밑에 뿌림 -->
				<div class="lookbook_detail_layer_info clfix">
					<div class="count">1/23</div>
					<ul>
						<li>[1] Soto Jacket
							<strong>179,000sdfgsdf</strong>
						</li>
						<li>[Pants] Buccaneer Pant
							<strong>179,000</strong>
						</li>
						<li>[Cap] Morgan Cap
							<strong>179,000</strong>
						</li>
					</ul>
				</div>
				
				<a href="#" class="lookbook_detail_layer_close">
					<img src="/html/worksout/images/common/btn_lookbook_detail_layer_close.png"
					alt="관리자등록">
				</a>
			</div>
			
			
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>