<%-- 
 작성자 : jhr
 작성일 : 2015-04-14
 화면명 : 관리자 환경설정 - 상점운영정책
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
	<script type="text/javascript">
	    $(function() { 
		
			// 앵커태그 void로 치환
			$("a[href=#]").attr("href", "javascript:void(0);");

			// 브랜드선택시 해당 앵커태그에 class 변경
			if( $("#site_no").val() != "" && $("#site_no").val() != null ){
		    	$("a[data-brand='brand'][id='"+$("#site_no").val()+"']").attr("class", "current");
		    	$("#depth").css("display","");
			}else{
				$("a[data-brand='brand'][id='']").attr("class", "current");
				$("#depth").css("display","none");
			}
	    	
	    	//브랜드 선택
			setSite= function(e){
				var $target = $(e);
				var siteNo = $target.attr('id');
				$("#site_no").val(siteNo);
				goSubmit();
			};
			
		    //검색
		    goSubmit = function(){
		    	 var frm = document.schForm;
				frm.action = "<c:url value='/admin/setting/storeManage'/>";
				frm.submit();
		    };
			
	    });
	
		//신규등록
		function doRegist(){
			$("#regFlag").val("");
			var frm = document.schForm;
			frm.target = '_self';
		    frm.action = "<c:url value='/admin/setting/storeWrite'/>";
		    frm.submit();
		}
	
		//수정
		function doUpdate(plcy_no){
			$("#plcy_no").val(plcy_no);
			$("#regFlag").val("Y");
			
			var frm = document.schForm;
		    frm.target = '_self';
		    frm.action = "<c:url value='/admin/setting/storeUpdate'/>";
		    frm.submit();
		}
	
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">	
			
			<div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb -->  
				
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
				<form:hidden path="site_no" id="site_no"/>
				<form:hidden path="plcy_no" id="plcy_no"/>
				<form:hidden path="regFlag" id="regFlag"/>
			</form:form>
				
			<!--[s] contents -->
			<div class="contents"><!-- contents_tab -->
				<h3><span class="icon1"></span>환경설정 > 상점운영정책 > 상점운영정책</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 회원가입시 이용약관, 개인정보취급방침 내용을 관리할 수 있습니다.</li> -->
<!-- 						<li>- 이용약관, 개인정보취급방침, 청소년보호정책, 이메일무단수집거부 내용을 관리할 수 있습니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				
				<!-- tabWrap -->
				<div class="tabWrap">
					<ul class="tabList">
						<c:choose>
							<c:when test="${not empty siteList}">
								<li><a href="#" onclick="setSite(this);" data-brand="brand" id="">ALL</a></li>
								<c:forEach items="${siteList}" var="site" varStatus="listCount">
									<li><a href="#" onclick="setSite(this);" data-brand="brand" id="${site.siteNo}">${site.siteNm}</a></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</ul> <!-- LEXDRAY -->
					<div class="tabConWrap">
						<div class="tabCon">
							<div class="tableType1">
								<table>
									<caption>전체매출통계</caption>
									<colgroup>
										<col style="width: 5%" />
										<col style="width: *" />
										<col style="width: 30%" />
										<col style="width: 10%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="row">No</th>
											<th scope="row">제목</th>
											<th scope="row">적용위치</th>
											<th scope="row">관리</th>
										</tr>
									</thead>
									<tbody>	
										<c:forEach items="${list}" var="list" varStatus="listCount">		
										<tr>	
											<td>${listCount.count}</td>
											<td>${list.plcy_nm}</td>
											<td>${list.plcy_desc}</td>
											<td><a href="javascript:doUpdate('${list.plcy_no}');" class="btnType1">수정</a></td>
										</tr>
										</c:forEach>
										<c:if test="${empty list}">
											<tr>
												<td colspan="4">조회된 데이터가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
							<a href="javascript:doRegist();" class="btnType2 right">등록</a>
						</div>
					</div>
				</div>
				<!-- //tabWrap -->
			</div>
			<!--[e] contents -->
		  </div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>