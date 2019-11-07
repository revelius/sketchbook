<%--
 * =============================================================================
 * 파일명 : /front/search/onlineShopSearchResult.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-16
 *
 * 파일 내용 : SEARCH > 상품목록
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
		
			//load more
			var isLoading = false;
			
			loadMore = function() {
				if (isLoading) {
					alert('처리중');
					return;
				}
				isLoading = true;
				
				$.ajax({
			        url : "<c:url value='/front/search/onlineShopAjax'/>",
			        type: "post",
			        data : $('#schForm').serialize(),
			        async: false,
			        success : function(responseData){
			        	try{
			        		var data = jQuery.parseJSON(responseData);
			        		if (data.length >= 1) {
			        			var product_list = $('.product_list');
	        					
			        			for(var i=0;i<data.length;i++) {
	
			        				var html = 
			        					
			        					"<li>" +
			        					"	<a href=\"javascript:gotoGoodsDetailBlank('" + data[i].ubiGoods.ubiGdsNo + "','${param.oneDepth }');\">" +
			        					"		<img src='<c:url value='" + data[i].mainImg + "'/>' alt='상품이미지..'>" +
			        					"	</a>" +
			        					"	<div class='product_info'>" +
			        					"		<div class='name01'>" + data[i].ubiGoods.brand + "</div>" +
			        					"		<div class='name02'>" + data[i].ubiGoods.ubiGdsNm + "</div>" +
			        					"		<span class='price'>" + Number(data[i].ubiGoods.ubiSlPrc).toLocaleString() + "</span>" +
			        					"	</div>" +
			        					"</li>";       					
			        					
			        					product_list.append(html);
			        			}
			        			var currentPage = Number($('#page').val()) + 1;
				        		$('#page').val(currentPage);
			        		} else {
			        			alert("리스트 끝");
			        		}
			        	}catch(e){
			        		alert(e);
			        	}
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        },
			        complete:function(request,status){
			        	isLoading = false;
			        }
			    });
			};
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
<form:form id="schForm" name="schForm" method="GET" modelAttribute="searchForm">
	<form:hidden path="searchText" id="searchText"/>
	<form:hidden path="page" id="page"/>
</form:form>
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
										<a href="#">SEARCH</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="menu_section">
							<div id="snb_search_area">
								<!-- snbSearch include -->
								<!-- snbSearch include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="search_tit">
										<strong class="point">"${searchText}"</strong>에 대한 검색결과는 총
										<strong class="point">${totalCnt}건</strong>
										입니다.</div>
								</div>
								<div class="search_area">
									<ul class="product_list clfix">
							<c:choose>
								<c:when test="${not empty goodsList}">
									<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
										<li>
											<a href="javascript:gotoGoodsDetail('${goods.ubiGoods.ubiGdsNo }','${param.oneDepth }');">
												<img id="wait_${goods.ubiGoods.ubiGdsNo }" src="<c:url value='http://worksout60.cafe24.com/upload/image/img-loading.gif'/>" alt="로딩중 이미지">
												<img id="load_${goods.ubiGoods.ubiGdsNo }" src="<c:url value='${goods.mainImg}'/>" alt="상품이미지" onload="$('#wait_${goods.ubiGoods.ubiGdsNo }').hide();$('#load_${goods.ubiGoods.ubiGdsNo }').fadeIn('slow');" style="display:none;">												
											</a>
											<div class="product_info">
												<div class="name01">${goods.ubiGoods.brand }</div>
												<div class="name02">${goods.ubiGoods.ubiGdsNm }</div>
												<c:if test="${goods.totalStock < 1}">
													<span class="soldout">SOLD OUT</span>
												</c:if>
												<c:if test="${goods.totalStock > 0}">
													<c:if test="${goods.ubiGoods.seasonCode != currentSeason}">
<%-- 														<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span> --%>
													</c:if>
													<c:if test="${goods.ubiGoods.ubiCostPrc != goods.ubiGoods.ubiSlPrc}">
														<span class="discount">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" /></span>
													</c:if>
													<span class="price">￦ <fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc }" pattern="###,###" /></span>
												</c:if>												
											</div>
										</li>									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li>
										조회할 항목이 없습니다.
									</li>
								</c:otherwise>
							</c:choose>
									</ul>
									<c:if test="${fn:length(goodsList) > 0}">
									<div class="btn_area">
										<a href="javascript:loadMore();" class="btn_animate02" data-id="btnArrowAnimate" data-btn-type="vertical">
											<span class="txt01">LOAD</span>
											<span class="txt02">MORE</span>
											<span class="animate" style="display:none;">
												<!-- <img src="/resources/worksout/images/common/bu_arrow_top.png" alt=""> -->
											</span>
										</a>
									</div>
									</c:if>
									
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