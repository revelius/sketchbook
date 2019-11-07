<%--
 * =============================================================================
 * 파일명 : /worksout/lookbook/list.jsp
 * 작성자 : 신지영
 * 작성일자 : 2015-05-26
 *
 * 파일 내용 : LookBook > 목록
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
			$("a[href=#]").attr("href", "javascript:void(0);");
		    $("a[data-brand='brand'][id='"+$("#newsType").val()+"']").attr("class", "on");
		});

	    //상세페이지 이동
	    goDetail = function(e,path){
	    	var $target = $(e);
	    	var txtNo = $target.attr('data-txtNo');
	    	
	    	$("#txtNo").val(txtNo);
	    	$("#schForm").attr("action",path);
	    	$("#schForm").submit();
	    };
	    
	    //상세페이지 이동
	    goDetail2 = function(e,path){
	    	var $target = $(e);
	    	var txtNo = $target.attr('data-txtNo');
	    	
	    	window.open(path+'?txtNo='+txtNo, '_blank');
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
		        url : "<c:url value='/front/news/newsAjax'/>",
		        type: "post",
		        data : $('form#schForm').serialize(),
		        async: true,
		        success : function(responseData){
		        	try{
		        		var data = jQuery.parseJSON(responseData);

		        		if (data.length >= 1) {
		        			var news_list = $('.news_list');
				        		
		        			for(var i=0;i<data.length;i++) {
		        				var html = "<div class='news_item clfix'>";
		        					if(data[i].thmbUrl !=""){
		       						html += "	<div class='news_info_layout'>";
		       						html += "		<a href='javascript:void(0);' onclick=\"javascript:goDetail2(this,'<c:url value='/front/news/newsDetail' />');\" data-txtNo='" + data[i].txtNo + "'>";
		       						html += "			<img src='${uploadImage}" + data[i].thmbUrl + "' alt='관리자에서 등록 할 수 있게 개발 필요함.'>";
		       						html += "		</a>";
		       						html += "	</div>";		        						
		        					}
		        					html += "	<div class='news_info_layout'>";
		        					html += "		<div class='news_info'>";
		        					html += "			<div class='news_tit'><a href='javascript:void(0);' onclick=\"javascript:goDetail2(this,'<c:url value='/front/news/newsDetail' />');\" data-txtNo='" + data[i].txtNo + "'>" + data[i].title + "</a></div>";
		        					html += "			<div class='news_date'>" + data[i].etc1  + "</div>";
		        					html += "			<div class='news_desc'><a href='javascript:void(0);'>" + data[i].preview + "</a></div>";
		        					html += "			<div class='news_more'>";
		        					html += "				<a href='javascript:void(0);' onclick=\"javascript:goDetail2(this,'<c:url value='/front/news/newsDetail' />');\" data-txtNo='" + data[i].txtNo + "'>READ MORE</a>";
		        					html += "			</div>";
		        					html += "		</div>";
		        					html += "	</div>";
		        					html += "</div>";
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
<form:form id="schForm" name="schForm" method="GET" modelAttribute="searchForm" onsubmit="">
	<form:hidden path="page" id="page"/>
	<form:hidden path="txtNo" id="txtNo"/>
	<form:hidden path="newsType" id="newsType"/>
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
										<a href="#">NEWS</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="menu_section">
							<div id="snb_news_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="news_list">
							<c:choose>
								<c:when test="${not empty newsList}">
									<c:forEach items="${newsList}" var="news" varStatus="listCount">
										<div class="news_item clfix">
										<c:choose>
											<c:when test="${not empty news.thmbUrl }">
											<div class="news_info_layout">
												<a href="#" onclick="javascript:goDetail(this,'<c:url value='/front/news/newsDetail' />');" data-txtNo="<c:out value='${news.txtNo}'/>">
													<img src="${uploadImage}${news.thmbUrl }" alt="뉴스이미지">
												</a>
											</div>
											</c:when>
										</c:choose>
											<div class="news_info_layout">
												<div class="news_info">
													<div class="news_tit"><a href="#" onclick="javascript:goDetail(this,'<c:url value='/front/news/newsDetail' />');" data-txtNo="<c:out value='${news.txtNo}'/>"><%-- [${news.txtTp}] --%> ${news.title }</a></div>
													<div class="news_date">${news.etc1 }</div>
													<div class="news_desc"><a href="#">${news.preview }</a></div>
													<div class="news_more">
														<a href="#" onclick="javascript:goDetail(this,'<c:url value='/front/news/newsDetail' />');" data-txtNo="<c:out value='${news.txtNo}'/>">READ MORE</a>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>								
								<c:otherwise>											
									<div class="news_info_layout">
										<div class="news_info">해당 카테고리에는 뉴스가 없습니다.</div>
									</div>																			
								</c:otherwise>
							</c:choose>
								</div>
							<div class="btn_area">
								<a href="javascript:loadMore();" class="btn_animate02" data-id="btnArrowAnimate" data-btn-type="vertical">
									<span class="txt01">LOAD</span>
									<span class="txt02">MORE</span>
									<span class="animate" style="display:none;">
										<!-- <img src="/resources/worksout/images/common/bu_arrow_top.png" alt=""> -->
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


