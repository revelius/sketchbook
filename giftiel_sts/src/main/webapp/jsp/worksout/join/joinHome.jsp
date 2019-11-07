<%--
 * =============================================================================
 * 파일명 : /front/join/joinHome.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입홈 
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
    			
    			$("a[data-country]").on("click", function(e){
    				e.preventDefault();
    		    	var $target = $(e.currentTarget);
    		    	//alert($target.attr("data-country"));
    		    	
    		    	var frm = document.joinForm;
    		    	frm.countryCd.value = $target.attr("data-country");
					frm.action = "<c:url value='/front/join/joinConfirm'/>";
	 	        	frm.submit();
		 	        
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
				<div id="content">
<!-- 				<form id="hiddenForm" name="hiddenForm" method="post"> -->
<!-- 					<input type="hidden" id="countryCd" name="countryCd" value=""/> -->
<!-- 				</form> -->
				<form:form id="joinForm" name="joinForm" method="post" modelAttribute="joinForm" onsubmit="">
					<form:hidden path="siteNo"/>
					<form:hidden path="countryCd"/>
				</form:form>
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">JOIN</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_join_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						
						<div class="content_section">
							<div class="content_area">
								<div class="join_area_etc">
									<ul class="join_members_txt">
										<li class="type01">
											<span class="txt01">WORKSOUT</span>
											<span class="txt02">통합회원가입</span>
										</li>
										<li class="type02">WORKSOUT Inc. 통합회원가입을 환영합니다.
											<br> 회원으로 가입하시면 WORKSOUT, CARHARTT WIP, OBEY,
											<br> BRIXTON 등 WORKSOUT Inc.에서 운영하는 매장과 웹사이
											<br> 트의 서비스를 하나의 아이디로 이용하실 수 있습니다.</li>
									</ul>
									<div class="btn_area02 clfix">
										<div class="btn01" style="width:100%">
											<a href="#" class="btn_black01" data-country="ME00101">통합 회원가입</a>
										</div>
<!-- 										<div class="btn02"> -->
<!-- 											<a href="#" class="btn_white01" data-country="ME00102">FOR FOREIGNERS</a> -->
<!-- 										</div> -->
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