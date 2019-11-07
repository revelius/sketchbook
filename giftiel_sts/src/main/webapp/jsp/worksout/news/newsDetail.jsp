<%--
 * =============================================================================
 * 파일명 : /manage/newsDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : news 상세
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
		<script async defer src="//platform.instagram.com/en_US/embeds.js"></script>
        <script type="text/javascript">
         	$(function(){
         		// 첫 페이지 로딩시 url 자동입력 
				$(".link_txt").val(location.href);

         		// 버튼클릭시 색상변경 
				$(".ui_link_area").click(function(){
					if($(this).hasClass("on")){
						$(this).removeClass("on");
						$(".link_box").toggle("slow");
					}else{
						$(this).addClass("on");
						$(".link_url").trigger("click");
						$(".link_box").toggle("slow");						
					}
				});
				
         		// url링크 클릭시 
				$(".link_url").click(function(){
					if($(".link_html").hasClass("on")){
						$(".link_html").removeClass("on");
					}
					$(this).addClass("on");
 					$(".link_txt").val(location.href);
				});
				
         		// html링크 클릭시 
				$(".link_html").click(function(){
					if($(".link_url").hasClass("on")){
						$(".link_url").removeClass("on");
					}
					$(this).addClass("on");
					$(".link_txt").val("${fn:replace(newsDetail.txt,'\"','\\"')}");
				});
         	});
         	
         	// 페이스북버튼 클릭시 
         	// 이미지는 렌덤 
       		facebookShare = function(){ 
	   			var url = "${siteUrl}"; 

	   			if(url !=""){
	        			url = url.replace(/&/gi,"%26");
	                	url = url.replace(/=/gi,"%3D");

	        			window.open("http://www.facebook.com/sharer/sharer.php?u="+url); 
	   			}
       		}
         	
       		function key_check(){
       	        if(event.keyCode == "37"){
       	        	newsMySwipe.prev(); return false;
       	        }else if(event.keyCode == "39"){
       	        	newsMySwipe.next(); return false;
       	        }
       	    };         	
        </script>
	</head>
	<body onkeyDown='key_check();'>
	<form:form id="schForm" name="schForm" method="POST" modelAttribute="searchForm" onsubmit="">
		<form:hidden path="newsType" id="newsType"/>
	</form:form>
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
				<div id="content">
					<div class="content_wrap">
						<div class="location_list_wrap">
							<div class="location_list_container">
								<ul class="location_list clfix">
									<li class="home">
										<a href="<c:url value='/front/main'/>">HOME</a>
									</li>
									<li>
										<a href="<c:url value='/front/news/newsList' />">NEWS</a>
									</li>
									<li>
										<a href="#">${newsDetail.txtTp}</a>
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
								<div class="news_view_aera">
								<c:choose>
									<c:when test="${newsDetail.sldDispYn == 'Y' }">
									<div class="news_slide_wrap">
										<div id="newsMySwipe" class="news_slide_container">
											<div class="news_slide_list">
												<div class="news_item">
													<c:choose>
														<c:when test="${newsDetail.txtCls == 'CM00502' }">
															<iframe class="news_ifream_area" src="${newsDetail.movUrl}" frameborder="0" allowfullscreen ></iframe>
														</c:when>
														<c:otherwise>
															<img src="${uploadImage}${newsDetail.imgUrl}" alt="News 메인이미지">
														</c:otherwise>
													</c:choose>
												</div>
												<c:choose>
													<c:when test="${not empty newsDetail.newsCont}">
														<c:forEach items="${newsDetail.newsCont}" var="news" varStatus="listCount">
														<div class="news_item">
															<c:choose>
															<c:when test="${news.addContType == 'CM00502'}">
																<iframe class="news_ifream_area" src="${news.addContAddr}" frameborder="0" allowfullscreen ></iframe>
															</c:when>
															<c:otherwise>
																<img src="${uploadImage}${news.addContAddr }" alt="News 메인이미지">
															</c:otherwise>
															</c:choose>
														</div>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</div>
										<a href="#" onclick="newsMySwipe.prev(); return false;" class="btn_prev">
											<span class="hide_txt">이전 이미지</span>
										</a>
										<a href="#" onclick="newsMySwipe.next(); return false;" class="btn_next">
											<span class="hide_txt">다음 이미지</span>
										</a>
									</div>
									</c:when>
								</c:choose>
									<div class="news_slide_txt_area <c:if test="${newsDetail.sldDispYn == 'N' }">nonSlide</c:if>">
										<p class="tit"><%-- [${newsDetail.txtTp}] --%> ${newsDetail.title}</p>
										<p class="date">${newsDetail.etc1} ${newsDetail.etc2}</p>
									<!-- s: 20160204 추가 영역 -->
										<div class="news_link_area">
											<ul class="clfix">
												<li>
													<a href="#" onclick="facebookShare();" class="ico01">
														<span class="hide_txt">facebook</span>
													</a>
												</li>
												<li>
													<a href="<c:if test="${siteNo == '10001'}">http://blog.naver.com/worksout_official</c:if>
												<c:if test="${siteNo == '10002'}">http://blog.naver.com/carharttwip_kr</c:if>
												<c:if test="${siteNo == '10003'}">http://blog.naver.com/obeykorea</c:if>
												<c:if test="${siteNo == '10004'}">http://blog.naver.com/brixtonkorea</c:if>
												<c:if test="${siteNo == '10006'}">http://blog.naver.com/worksout_official</c:if>" class="ico02" target="_blank">
														<span class="hide_txt">blog</span>
													</a>
												</li>
												<!-- a 태그에 on 붙을 수 있음. -->
												<li>
													<a href="#" class="ico03 ui_link_area">
														<span class="hide_txt">link</span>
													</a>
												</li>
											</ul>
											<!-- 아래 link_box 숨긴 후, 위 ui_link_area 클릭하면 노출 되면 됩니다. -->
											<div class="link_box" style="display:none;">
												<input type="text" class="link_txt">
<!-- 												<div class="link_txt">http://www.worksout.co.kr/front/news/newsDetail?page=1&amp;txtNo=1297&amp;newsType=</div> -->
												<!-- a 태그에 on 붙을 수 있음. -->
												<a href="#" class="link_url">URL</a>
												<!-- a 태그에 on 붙을 수 있음. -->
												<a href="#" class="link_html">HTML</a>
											</div>
										</div>
										<!-- e: 20160204 추가 영역 -->										
									</div>	
									
									<div class="news_view_content">
									<!-- 에디터 컨텐츠 들어가는곳 -->
									${fn:replace(newsDetail.txt,'http://www.worksout.co.kr/upload','http://worksout60.cafe24.com/upload')}
									</div>								

									<div class="btn_area">
										<a href="<c:url value='/front/news/newsList'/>" class="btn_animate01" data-id="btnArrowAnimate" data-btn-type="horizon">
											<span class="txt">LIST</span>
											<span class="animate" style="display:none;">
												<!-- <img src="<c:url value='/resources/worksout/images/common/bu_arrow_top02.png'/>" alt="">  -->
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
		var elem = document.getElementById('newsMySwipe');
		window.newsMySwipe = Swipe(elem,
		{
			// startSlide: 4,
			// auto: 3000,
			// continuous: true,
			// disableScroll: true,
			// stopPropagation: true,
			// callback: function(index, element) {},
			// transitionEnd: function(index, element) {}
		});
		</script>
		<h2 class="hide_txt">하단 영역</h2>
		<div id="footer">
			<!-- footer include -->
			<!-- footer include -->
		</div>
		</div>
	</body>
</html>