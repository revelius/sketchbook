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
		<META http-equiv="Cache-Control" content="max-age"> 	
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<script type="text/javascript">
		$(function() {
			//lookbook 리스트 조회
			gotoList = function(siteNo) {
				$(location).attr('href',$(location).attr('pathname')+(siteNo==''?'':'?siteNo='+siteNo));
			};
			
			//lookbook 상세 이동
			gotoDetail = function(txtNo) {
				$(location).attr('href','${contextPath}/front/lookbook/detail?txtNo='+txtNo);
			};
			
			brnFilter = function(strNo, strNm){
				$("#siteName").val(strNm);
				$("#siteNo").val(strNo);
				$("#searchForm").submit();
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
			        url : "<c:url value='/front/lookbook/listAjax'/>",
			        type: "post",
			        data : $('#searchForm').serialize(),
			        async: true,
			        success : function(responseData){
			        	try{
			        		
			        		var data = jQuery.parseJSON(responseData);
			        		
			        		if (data.length > 0) {
			        			for(var i=0;i<data.length;i++) {
			        				//alert($("div[class='lookbook_list_area']").find("li[class='first_child']").size() +"////"+$("div[class='lookbook_list_area']").find("li[class='last_child']").size());
			        				var html = "";
				        			if($("div[class='lookbook_list_area']").find("li[class='first_child']").size() != $("div[class='lookbook_list_area']").find("li[class='last_child']").size()){
				        				html += "<li class='last_child'>";
				        				html += "<a href=\"javascript:gotoDetail('" + data[i].txtNo +"');\">";
				        				html += "	<img src=\"${contextPath}/upload/image" + data[i].imgUrl + "\" alt=\"관리자에서 등록할 수 있게 개발 필요\">";
				        				//html += "	<img src=\"/html/worksout/images/lookbook/img_lookbook_list_new03.jpg\" alt=\"관리자에서 등록할 수 있게 개발 필요\">";
				        				html += "</a>";
				        				html += "</li>";
				        				//alert(html);
				        				$("li[class='first_child']").last().parent().append(html);
					        		}else{
					        			html += "<ul class=\"lookbook_list_new clfix\">";
					        			html += "<li class='first_child'>";
					        			html += "<a href=\"javascript:gotoDetail('" + data[i].txtNo +"');\">";
					        			html += "	<img src=\"${contextPath}/upload/image" + data[i].imgUrl + "\" alt=\"관리자에서 등록할 수 있게 개발 필요\">";
					        			//html += "	<img src=\"/html/worksout/images/lookbook/img_lookbook_list_new03.jpg\" alt=\"관리자에서 등록할 수 있게 개발 필요\">";
					        			html += "</a>";
					        			html += "</li>";
					        			html += "</ul>";
					        			//alert(html);
					        			$("ul[class='lookbook_list_new clfix']").last().after(html);
					        		}
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
		});
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
				<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm">
				<form:hidden path="page" id="page"/>
				<form:hidden path="siteNo" id="siteNo"/>
				<form:hidden path="siteName" id="siteName"/>
				<div id="content">
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">LOOK BOOK</a>
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
									
									<c:forEach var="lookbook" items="${lookbookList}" varStatus="listCnt">
									<c:if test="${listCnt.count % 2 ne 0}"><ul class="lookbook_list_new clfix"></c:if>
										<li class="<c:if test="${listCnt.count % 2 ne 0}">first_child</c:if><c:if test="${listCnt.count % 2 eq 0}">last_child</c:if>">
											<a href="javascript:gotoDetail('${lookbook.txtNo}');">
												<img src="${uploadImage}${lookbook.imgUrl}" alt="관리자에서 등록할 수 있게 개발 필요">
<%-- 												<img src="http://59.6.197.196/upload/image${lookbook.imgUrl}" alt="관리자에서 등록할 수 있게 개발 필요"> --%>
<!-- 												<img src="/html/worksout/images/lookbook/img_lookbook_list_new03.jpg" alt="관리자에서 등록할 수 있게 개발 필요"> -->
											</a>
										</li>
									<c:if test="${listCnt.count % 2 eq 0}"></ul></c:if>
									<c:if test="${listCnt.last and listCnt.count  % 2 ne 0}"></ul></c:if>
									</c:forEach>
									
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
							
						</div>
						<div class="etc_section">
							<div class="snb_fixed">
							</div>
						</div>
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