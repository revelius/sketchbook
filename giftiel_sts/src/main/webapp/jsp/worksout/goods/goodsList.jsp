<%--
 * =============================================================================
 * 파일명 : /front/goods/goodsList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-05-19
 *
 * 파일 내용 : onlineShop > 상품목록
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
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap" class="goodslist_height">
		<div class='box' id='loadingBar' style="display:none;"><div class='loader3'></div></div>
			<h2 class="hide_txt">주요 메뉴 영역</h2>
			<div id="header">
				<!-- header include -->
				<!-- header include -->
			</div>

				<script>
					$(function() {
						var currentPage = 2;

/* 						$(window).scroll(function(){
						   if($(window).scrollTop() == $(document).height() - $(window).height()){
							   if("${totalPage}" != currentPage){
							   	getGoodsList();
							   }

						   }
						}); */
    					
						//상품리스트 AJAX
						getGoodsList = function() {
							loadingBarShow();
								$("#loadMoreBtn").hide();
								
								var formdata = {};
								formdata = "sex=${param.sex }&brand=${param.brand }&oneDepth=${param.oneDepth }&twoDepth=${param.twoDepth }&threeDepth=${param.threeDepth }&orderFlag=${param.orderFlag }&orderBy=${param.orderBy }&ubiGdsSize=${param.ubiGdsSize}&clbltnNm=${param.clbltnNm}&newArvl=${param.newArvl}&currentPage=" + currentPage;
	
								$.ajax({
							        url : "<c:url value='/front/onlineShop/goodsListAjax'/>",
							        type: "post",
							        data : formdata,
							        async: true,
							        success : function(responseData){
							        	try{
								            var goods = jQuery.parseJSON(responseData);
								            if (goods.length >= 1) {
									            for(var i=0;i<goods.length;i++){
		 							            	var html = "<li>";
		 							            		html += "<a href=\"javascript:gotoGoodsDetailBlank('"+goods[i].ubiGoods.ubiGdsNo+"','${param.oneDepth }');\">";
// 		 							            		html += "<img id=\"wait_"+goods[i].ubiGoods.ubiGdsNo+"\" src=\"<c:url value='http://worksout60.cafe24.com/upload/image/img-loading.gif'/>\">";
// 		 							            		html += "<img id=\"load_"+goods[i].ubiGoods.ubiGdsNo+"\" src=\"<c:url value='"+goods[i].mainImg+"'/>\" onload=\"$('#wait_"+goods[i].ubiGoods.ubiGdsNo+"').hide();$('#load_"+goods[i].ubiGoods.ubiGdsNo+"').fadeIn('slow');\" style=\"display:none;\">";
														html += "<img src=\"<c:url value='"+goods[i].mainImg+"'/>\">";
		 							            		html += "</a>";
	
		 							             		html += "<div class=\"product_info\">";
		 							            		html += "<div class=\"name01\">"+goods[i].ubiGoods.brand+"</div>";
		 							            		html += "<div class=\"name02\">"+goods[i].ubiGoods.ubiGdsNm+"</div>";
		 							            		if(goods[i].totalStock < 1){
		 							            			html += "<span class=\"soldout\" style=\"color:#CD5C5C\">SOLD OUT</span>";
		 							            		}else{
		 							            			<c:if test="${param.oneDepth == 'OUTLET'}">
		 							            				//html += "<span class=\"discount\">￦ "+comma(goods[i].ubiGoods.ubiCostPrc)+"</span>";
		 							            			</c:if>
		 							            			if(goods[i].ubiGoods.ubiCostPrc != goods[i].ubiGoods.ubiSlPrc){
		 							            				html += "<span class=\"discount\">￦ "+comma(goods[i].ubiGoods.ubiCostPrc)+"</span>";
		 							            			}
		 							            			html += "<span class=\"price\">￦ "+comma(goods[i].ubiGoods.ubiSlPrc)+"</span>";
		 							            		}
		 							            		
														<c:if test="${goods.totalStock > 0}">
														<c:if test="${param.oneDepth != currentSeason}">
	<%-- 														<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span> --%>
														</c:if>
														<c:if test="${goods.ubiGoods.ubiCostPrc != goods.ubiGoods.ubiSlPrc}">
															<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span>
														</c:if>
														<span class="price">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc}" pattern="###,###" /></span>
														</c:if>
		 							            		
		 							            		html += "</div>";
									    	    		html += "</li>";
	
	
									    	    	$('#goodsList').append(html);
									            }
									            if(${totalPage} != currentPage){
									            	$("#loadMoreBtn").show();	
									            }
									            
									            currentPage++;
									            loadingBarHide();
								            }else{
								            	$("div .btn_area").html("<span style='color:red;'>더 이상 상품 리스트가 없습니다.</span>");
												$("div .btn_area").animate({opacity: 0}, 2000, function(e){
									            	$("div .btn_area").html("");
												});											
	// 							            	alert("리스트 끝");
								            }
							        	}catch(e){
							        		//alert(e);
							        		$("#loadMoreBtn").show();
							        	}
							        },
							        error:function(request,status,error){
							            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
							        	$("#loadMoreBtn").show();
							        },
							        complete: function(responseData){
							        	var goods = jQuery.parseJSON(responseData);
							        	$("#loadMoreBtn").show();
							        	$( "#loadingBar" ).hide();							        	
							        }
							});
							
							
						};

					    viewChange = function(seq) {
					    	if(seq == 3){
							    $(".product_visual").fadeOut( "slow", function() {
							    });
						    	$("ul#goodsList").fadeOut( "slow", function() {
							    	$('ul#goodsList').removeClass("product_list");
							    	$('ul#goodsList').addClass("product_list_new");
							    	$('a#viewType5').removeClass("on");
							    	$('a#viewType3').addClass("on");
							    	$("ul#goodsList").fadeIn( "slow", function() {
							    	});
						    	});
					    	}else{
						    	$("ul#goodsList").fadeOut( "slow", function() {
							    	$('ul#goodsList').removeClass("product_list_new");
							    	$('ul#goodsList').addClass("product_list");
							    	$('a#viewType3').removeClass("on");
							    	$('a#viewType5').addClass("on");
							    	$("ul#goodsList").fadeIn( "slow", function() {
							    	});
								    $(".product_visual").fadeIn( "slow", function() {
								    });
						    	});
					    	}
					    };
					});
				</script>
			<c:set var="viewType" value="product_list"/>
			<c:if test="${fn:indexOf(param.brand, 'NI') > -1 }">
				<c:set var="viewType" value="product_list_new"/>
				<script>
				    //페이지 init
				    $(window).load(function() {
						$("#viewType3").addClass("on");
						$("#viewType5").removeClass("on");
				    });							
				</script>
			</c:if>				
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
							<%-- <li>
								<a href="goodsList?oneDepth=${param.oneDepth }">F/W 15</a>
							</li> --%>
						</ul>
						<div class="menu_section">
							<div id="snb_shop_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
						<input type="hidden" id="oneDepth" value="${param.oneDepth }">
						<input type="hidden" id="twoDepth" value="${param.twoDepth }">
						<input type="hidden" id="threeDepth" value="${param.threeDepth }">
						<input type="hidden" id="brand" value="${param.brand }">
						<input type="hidden" id="sex" value="${param.sex }">
						<input type="hidden" id="ubiGdsSize" value="${param.ubiGdsSize }">
						<input type="hidden" id="clbltnNm" value="${param.clbltnNm }">
						<input type="hidden" id="orderFlag" value="${param.orderFlag }">
						<input type="hidden" id="orderBy" value="${param.orderBy }">
						<input type="hidden" id="viewType" value="${param.viewType }">
						<input type="hidden" id="newArvl" value="${param.newArvl }">
							<div class="content_area">
								<!--
								<div class="content_top">
									<div class="content_menu">
										<!-- on 클래스 붙으면 활성화 됨
										<a href="#" class="on">PRODUCTS LIST</a>
										<a href="<c:url value='/front/onlineShop/feature'/>" class="last_child">FEATURE</a>
									</div>
								</div>
								-->
								<!-- 상단 배너 영역 하드코딩 -->
<!-- 								<div class="product_visual"> -->
<!-- 									<img src="/resources/worksout/images/onlineshop/img_p_v01.jpg" alt="PATTA X CARHARTT WIP"> -->
<!-- 								</div> -->
								<ul class="${viewType } clfix" id="goodsList">
									<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
										<li>
											<a href="javascript:gotoGoodsDetail('${goods.ubiGoods.ubiGdsNo }','${param.oneDepth }');">
<%-- 												<img id="wait_${goods.ubiGoods.ubiGdsNo }" src="<c:url value='http://worksout60.cafe24.com/upload/image/img-loading.gif'/>" alt="로딩중 이미지"> --%>
<%-- 												<img id="load_${goods.ubiGoods.ubiGdsNo }" src="<c:url value='${goods.mainImg}'/>" alt="상품이미지" onload="$('#wait_${goods.ubiGoods.ubiGdsNo }').hide();$('#load_${goods.ubiGoods.ubiGdsNo }').fadeIn('slow');" style="display:none;"> --%>
													<img src="<c:url value='${goods.mainImg}'/>" alt="" >
											</a>
											<div class="product_info">
<%-- 												${goods.updDts } --%>
												<div class="name01">${goods.ubiGoods.brand }</div>
												<div class="name02">${goods.ubiGoods.ubiGdsNm }</div>
												<c:if test="${goods.totalStock < 1 || goods.gdsStat == 'GD00404'}">
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${goods.ubiGoods.brandCode == 'VS' or goodsForm.ubiGoods.brandCode == 'CG'}"> --%>
<%--  															<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span> --%> 
<%-- 															<span class="price">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc}" pattern="###,###" /></span> --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<span class="soldout">SOLD OUT</span> -->
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
													<span class="soldout" style="color:#CD5C5C">SOLD OUT</span>
												</c:if>
												<c:if test="${goods.totalStock > 0 && goods.gdsStat == 'GD00402'}">
													<c:if test="${param.oneDepth != currentSeason}">
<%-- 														<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span> --%>
													</c:if>
													<c:if test="${goods.ubiGoods.ubiCostPrc != goods.ubiGoods.ubiSlPrc}">
														<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span>
													</c:if>
													<span class="price">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc}" pattern="###,###" /></span>
												</c:if>
<%-- 												</br>${goods.updDts } --%>
											</div>
										</li>
									</c:forEach>
								</ul>
								<c:if test="${fn:length(goodsList) < 1}"> 
									<div class="btn_area goodslist_no_area">
										<div class="goodslist_no_content">해당 카테고리에는 상품이 없습니다.</div>
									</div>
								</c:if>
								<c:if test="${fn:length(goodsList) > 0}">
									<c:if test="${totalPage != 1}">
										<div class="btn_area">
											<a href="javascript:void(0);" class="btn_animate02" data-id="btnArrowAnimate" data-btn-type="vertical" onclick="javascript:getGoodsList();"  id="loadMoreBtn">
								    	    	<span class="txt01">LOAD</span>
							    	    		<span class="txt02">MORE</span>
						    	    			<span class="animate" style="display:none;">
						    	    				<img src="/resources/worksout/images/common/bu_arrow_top.png" alt="">
							    				</span>
					    					</a>
										</div>
									</c:if>
								</c:if>
							</div>
						</div>
						<div class="etc_section">
							<div class="snb_fixed">
								<div class="view_type clfix">
									<span>VIEWTYPE</span>
									<a href="javascript:viewChange(3);" id="viewType3" class="">3</a>
									<a href="javascript:viewChange(5);" id="viewType5" class="last_child on">5</a>
								</div>
								<div class="snb_filter_area">
									<a href="#" class="btn_select">FILTER</a>
									<!-- a태그에 on 클래스 붙으면 활성화 -->
									<c:if test="${param.twoDepth != null and param.twoDepth != ''}">
										<div class="filter_size">
											<c:forEach items="${goodsSizeList}" var="goodsSize" varStatus="listCount">
												<a href="goodsList?sex=${param.sex }&brand=${param.brand }&oneDepth=${param.oneDepth }&twoDepth=${param.twoDepth }&threeDepth=${param.threeDepth }&ubiGdsSize=${goodsSize.ubiGoods.ubiGdsSize }&orderFlag=${param.orderFlag }&orderBy=${param.orderBy }">${goodsSize.ubiGoods.ubiGdsSize }</a>
											</c:forEach>
										</div>
									</c:if>
									<!-- a태그에 on 클래스 붙으면 활성화 -->
									<div class="filter_sort_by">
										<span>Sort by</span>
										<a href="goodsList?sex=${param.sex }&brand=${param.brand }&oneDepth=${param.oneDepth }&twoDepth=${param.twoDepth }&threeDepth=${param.threeDepth }&ubiGdsSize=${param.ubiGdsSize }&orderFlag=DESC&orderBy=REG_DTS" id="DESC_REG_DTS">Latest Arrivals</a>
										<a href="goodsList?sex=${param.sex }&brand=${param.brand }&oneDepth=${param.oneDepth }&twoDepth=${param.twoDepth }&threeDepth=${param.threeDepth }&ubiGdsSize=${param.ubiGdsSize }&orderFlag=ASC&orderBy=UBI_SL_PRC" id="ASC_UBI_SL_PRC">Price : low to high</a>
										<a href="goodsList?sex=${param.sex }&brand=${param.brand }&oneDepth=${param.oneDepth }&twoDepth=${param.twoDepth }&threeDepth=${param.threeDepth }&ubiGdsSize=${param.ubiGdsSize }&orderFlag=DESC&orderBy=UBI_SL_PRC" id="DESC_UBI_SL_PRC">Price : high to low</a>
									</div>
								</div>
							</div>
						</div>
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