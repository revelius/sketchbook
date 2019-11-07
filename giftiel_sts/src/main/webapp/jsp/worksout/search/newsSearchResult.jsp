<%--
 * =============================================================================
 * 파일명 : /front/search/newsSearchResult.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-17
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
		        url : "<c:url value='/front/search/newsAjax'/>",
		        type: "post",
		        data : $('#schForm').serialize(),
		        async: false,
		        success : function(responseData){
        	
		        	try{
		        		var data = jQuery.parseJSON(responseData);

		        		if (data.length >= 1) {
		        			var news_list = $('.news_list');
        					
		        			for(var i=0;i<data.length;i++) {
		        				var html = 
		        					"<div class='news_item clfix'>" +
		        					"	<div class='news_info_layout'>" +
		        					"		<img src='<c:url value='${uploadImage}" + data[i].imgUrl + "'/>' alt='섬네일이미지'>" +
		        					"	</div>" +
		        					"	<div class='news_info_layout'>" +
		        					"		<div class='news_info'>" +
		        					"			<div class='news_tit'>[" + data[i].txtTp + "] " + data[i].title + "</div>" +
		        					"			<div class='news_date'>" + data[i].regDts + "</div>" +
		        					"			<div class='news_desc'>" + data[i].txt + "</div>" +
		        					"			<div class='news_more'><a href='javascript:gotoNewsDetail(" + data[i].txtNo + ",'" + ${contextPath} + "');'>READ MORE</a></div>" +
		        					"		</div>" +
		        					"	</div>" +
		        					"</div>";
		        					
		        					news_list.append(html);
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
<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm">
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
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">SEARCH</a>
							</li>
						</ul>
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
										<strong class="point">${totalCnt + goodsTotalCnt + lookbookTotalCnt}건</strong>
										입니다.</div>
								</div>
								<div class="search_area">
									<div class="tab_type01">
										<ul class="tab01_list clfix">
											<li>
												<a href="javascript:SearchType('ONLIEN','${searchText}','${contextPath}');" class="first_child">ONLINE SHOP
													<span>(${goodsTotalCnt })</span>
												</a>
											</li>
											<li class="on">
												<a href="javascript:void();">NEWS
													<span>(${totalCnt})</span>
												</a>
											</li>
											<li>
												<a href="javascript:SearchType('LOOKBOOK','${searchText}','${contextPath}');">LOOKBOOK
													<span>(${lookbookTotalCnt })</span>
												</a>
											</li>
<!-- 											<li> -->
<%-- 												<a href="javascript:SearchType('OTHER','${searchText}','${contextPath}');">OTHER --%>
<!-- 													<span>(33)</span> -->
<!-- 												</a> -->
<!-- 											</li> -->
										</ul>
									</div>
									<div class="news_list">
										<c:choose>
											<c:when test="${not empty newsList}">
												<c:forEach items="${newsList}" var="news" varStatus="listCount">
												<div class="news_item clfix">
													<div class="news_info_layout">
														<img src="<c:url value='${uploadImage}${news.imgUrl }'/>" alt="섬네일이미지">
													</div>
													<div class="news_info_layout">
														<div class="news_info">
															<div class="news_tit">[${news.txtTp }] ${news.title }</div>
															<div
															class="news_date">${news.regDts }</div>
															<div class="news_desc">${news.txt }</div>
															<div class="news_more"><a href="javascript:gotoNewsDetail(${news.txtNo},'${contextPath }');">READ MORE</a></div>
														</div>
													</div>
												</div>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<div class="news_item clfix">
													조회할 항목이 없습니다.
												</div>											
											</c:otherwise>
										</c:choose>										
									</div>
									<div class="btn_area space01">
										<a href="javascript:loadMore();">
											<img src="/html/worksout/images/common/btn_loadmore.png" alt="LOAD MORE">
										</a>
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