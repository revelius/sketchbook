<%--
 * =============================================================================
 * 파일명 : /front/goods/collaboration.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-24
 *
 * 파일 내용 : onlineShop > collaboration
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
		$(function() {
			//lookbook 리스트 조회
			gotoList = function(siteNo) {
				$(location).attr('href',$(location).attr('pathname')+(siteNo==''?'':'?siteNo='+siteNo));
			};

			//load more
			var isLoading = false;
			loadMore = function() {
				if (isLoading) {
					alert('처리중');
					return;
				}
				isLoading = true;
				
				$.ajax({
			        url : "<c:url value='/front/onlineShop/collaborationAjax'/>",
			        type: "post",
			        data : $('#searchForm').serialize(),
			        async: false,
			        success : function(responseData){
			        	try{
			        		var data = jQuery.parseJSON(responseData);

			        		if (data.length >= 1) {
			        			var collaboration_view = $('.collaboration_view');
					        		
			        			for(var i=0;i<data.length;i++) {
			        				var html = 
			        					"<li>" +
			        					"	<div class='cb_txt_area'>" +
			        					"		<div class='cb_txt'>" +
			        					"			<span>" + data[i].title + "</span>" +
			        					"		</div>" +
			        					"	</div>" +
			        					"	<div class='cb_img'>" +
			        					"		<a href='" + data[i].lnkUrl + "'>" +
			        					"			<img src='${uploadImage}" + data[i].imgUrl + "' alt='COLLABORATION 이미지'>"+
			        					"		</a>" +
			        					"	</div>" +
			        					"</li>";
			        					
										collaboration_view.append(html);
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
			
			brnFilter = function(strNo, strNm){
				$("#siteName").val(strNm);
				$("#siteNo").val(strNo);
				$("#searchForm").submit();
			};
			
			
			openMenu = function(id) {
		    	/* if("${param.sex}" == "M" || "${param.sex}" == ""){
		    		$('#menCategory').trigger('click');
		    		$('#MEN_${param.twoDepth}').show();

		    		$("a#MEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").addClass('on');

		    		$("a#MEN_${param.oneDepth}${param.twoDepth}").css("color","#000000");
		    		$("a#MEN_${param.oneDepth}${param.twoDepth}").css("font-weight","bold");
		    		$("a#MEN_${param.oneDepth}${param.twoDepth}").css("font-size","14px");
		    		$("ul#MEN_${param.twoDepth}").children().children().css("color","#000000");
		    		$("a#MEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").css("color","#000000");
		    		$("a#MEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").css("text-decoration","underline");
		    	}else if("${param.sex}" == "W"){
		    		$('#womenCategory').trigger('click');
		    		$('#WOMEN_${param.twoDepth}').show();

		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").addClass('on');

		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}").css("color","#000000");
		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}").css("font-weight","bold");
		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}").css("font-size","14px");
		    		$("ul#WOMEN_${param.twoDepth}").children().children().css("color","#000000");
		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").css("color","#000000");
		    		$("a#WOMEN_${param.oneDepth}${param.twoDepth}${param.threeDepth}").css("text-decoration","underline");
		    	}

		    	if("${param.brand}" == ""){
		    		$("a#BRAND_ALL").css("color","#000000");
		    		$("a#BRAND_ALL").css("font-weight","bold");
		    		$("a#BRAND_ALL").css("text-decoration","underline");
		    	}else{
		    		$("a#BRAND_${param.brand}").css("color","#000000");
		    		$("a#BRAND_${param.brand}").css("font-weight","bold");
		    		$("a#BRAND_${param.brand}").css("text-decoration","underline");
		    	}

		    	if("${param.oneDepth}" != "OUTLET"){
		    		$('a#season').css("color","#000000");
		    		$('a#season').css("font-weight","bold");
		    		$('a#season').css("text-decoration","underline");
		    	}else{
		    		$('#noSeason').css("color","#000000");
		    		$('#noSeason').css("font-weight","bold");
		    		$('#noSeason').css("text-decoration","underline");
		    	} */
		    	
	    		$("a#collaboration").css("color","#000000");
	    		$("a#collaboration").css("font-weight","bold");
	    		$("a#collaboration").css("text-decoration","underline");		    	
		    };
		    
		    $(window).load(function() {
		    	setTimeout('openMenu()',500);
		    });
			
		});
		</script>
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
				<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm">
				<form:hidden path="page" id="page"/>
				<form:hidden path="siteNo" id="siteNo"/>
				<form:hidden path="siteName" id="siteName"/>
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
								<a href="#">COLLABORATION</a>
							</li> -->
						</ul>
						<div class="menu_section">
							<div id="snb_shop_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<!-- 
								<div class="content_top">
									<div class="content_menu">
										<!-- on 클래스 붙으면 활성화 됨
										<a href="#" class="on last_child">COLLABORATION</a>
									</div>
								</div>
								-->
								<ul class="collaboration_view">
									<c:forEach items="${collaborationList}" var="collaboration" varStatus="listCount">
									<li>
										<div class="cb_txt_area">
											<div class="cb_txt">
												<span>${collaboration.title}</span>
											</div>
										</div>
										<div class="cb_img">
											<a href="/front/onlineShop/goodsList?clbltnNm=${fn:replace(collaboration.clbltnNm,'%','%25')}&oneDepth=${collaboration.seasonCd }">
												<img src="${uploadImage}${collaboration.imgUrl}" alt="COLLABORATION 이미지">
											</a>
										</div>
									</li>
									</c:forEach>
								</ul>
								
								<c:if test="${fn:length(collaborationList) < 1}"> 
									<div class="btn_area goodslist_no_area">
										<div class="goodslist_no_content">해당 카테고리에는 상품이 없습니다.</div>
									</div>
								</c:if>
								
							</div>
							
							<c:if test="${fn:length(collaborationList) > 0}">
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
<%-- 						<c:if test="${siteNo == '10001' }">
						<div class="etc_section">
							<div class="snb_fixed">
								<div class="snb_filter_area">
									<a href="#" class="btn_select">${siteName }</a>
									<!-- a태그에 on 클래스 붙으면 활성화 -->
									<div class="filter_size">
										<a href="javascript:brnFilter('','All BRANDS');"></a>
										<c:forEach items="${siteList}" var="rightSiteList" varStatus="listCount">
											<c:if test="${rightSiteList.siteNo != '10001'}">
												<a href="javascript:brnFilter(${rightSiteList.siteNo},'${rightSiteList.siteNm}');">${rightSiteList.siteDesc}</a>
											</c:if>
										</c:forEach>
									</div>
								</div>																	
							</div>
						</div>
						</c:if>			 --%>									
					</div>
				</div>
				</form:form>
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>