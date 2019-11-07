<%--
 * =============================================================================
 * 파일명 : /manage/operatorList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-24
 *
 * 파일 내용 : 권한관리 > 부운영자
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	
	<script type="text/javascript">
    $(function() { 
    	//검색
	    goSubmit = function(){
	    	 var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/manage/operatorList'/>";
		        frm.submit();
	    };
	     
	    
	    //정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			goSubmit();		
		};
		
		$('#sortTr a').each(function() {
			if ( $('#orderBy').val() == $(this).attr("id") && $('#orderFlag').val() == "DESC" ) {
				$(this).html("▼");
				$(this).removeClass("up");
				$(this).addClass("down");
			}else{
				$(this).html("▲");
				$(this).removeClass("down");
				$(this).addClass("up");
			}
		});
		
		
		//페이징 처리
	    paging = function(page) {
	        var frm = document.schForm;
	        document.getElementById("page").value = page;
	        goSubmit();
	    };	    
	    
	    
	    
	    

		//운영자 신규등록
	    regOperator = function(e){
	    	var frm = document.hiddenForm;
	    	frm.action = "<c:url value='/admin/manage/regOperator'/>";
	        frm.submit();
	    };
	    
	    
	    //수정
	    updateOperator = function(e) {
	    	
	    	var $target= $(e);
	    	
	    	var frm = document.hiddenForm;
	    	frm.userNo.value = $target.parent().attr("data-userNo");
	    	frm.action = "<c:url value='/admin/manage/updateOperator'/>";
	        frm.submit();
	    };	  
	    
	    
	    //삭제
	    delOperator= function(e) {
	    	if(!confirm("삭제하시겠습니까?")) return false;
	    	var $target= $(e);
	    	
	    	var frm = document.hiddenForm;
	    	frm.userNo.value = $target.parent().attr("data-userNo");
	    	frm.action = "<c:url value='/admin/manage/delOptProc'/>";
	        frm.submit();
	    };	  
	    
	    
	    
    });
    
	</script>
</head> 
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">			
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="manage"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form id="hiddenForm" name="hiddenForm" method="post">
					<input type="hidden" id="userNo" name="userNo"/>
				</form>
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
        					<form:hidden path="page" id="page"/>
        					<form:hidden path="orderBy" id="orderBy"/>
       						<form:hidden path="orderFlag" id="orderFlag"/>
				<div class="contents">
				<h3><span class="icon1"></span>운영관리 > 권한관리 > 부운영자</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 부운영자 생성 및 메뉴 별 권한을 부여하실 수 있습니다.</li> -->
<!-- 						<li>- 접속수는 부운영자 권한 부여 후부터 누적입니다.</li> -->
<!-- 						<li>- 최근접속일은 마지막으로 로그인한 시점입니다.</li> -->
<!-- 						<li>- 삭제시 복구할 수 없습니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<div class="tableType1">
						<table>
							<caption>부운영자</caption>
							<colgroup>
								<col style="width: 6%" />
								<col style="width: 15%" />
								<col style="width: 10%" />
								<col style="width: 15%%" />
								<col style="width: 8%" />
								<col style="width: *" />
								<col style="width: 15%" />
								<col style="width: 15%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th scope="row">No</th>
									<th scope="row">아이디</th>
									<th scope="row">이름</th>
									<th scope="row">연락처</th>
									<th scope="row">접속수 <a href="#" id="TOT_CONNECT" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">최근접속일 <a href="#" id="LATELY_CONNECT" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">등록일자 <a href="#" id="REG_DTS" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">관리</th>
								</tr>
							</thead>
							<tbody>	
							<c:choose>
								<c:when test="${not empty operatorList}">
									<c:forEach items="${operatorList}" var="operator" varStatus="listCount">
									<tr>	
										<td>${operator.rnum}</td>
										<td>${operator.id}</td>
										<td>${operator.userNm}</td>
										<td>${operator.cpNo}</td>
										<td>${operator.totConnect}</td>
										<td>${operator.latelyConnect}</td>
										<td>${operator.regDts}</td>
										<td data-userNo="${operator.userNo}">
											<a href="#" id="updateBtn" onclick="updateOperator(this);" class="btnType1">수정</a>
											<a href="#" id="delBtn" onclick="delOperator(this);" class="btnType1">삭제</a>
										</td>
									</tr>
									</c:forEach>
									</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8">
											조회할 항목이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
								
							</tbody>
						</table>
					</div>
					<!--[s] 페이징 -->
					<c:choose>
						<c:when test="${not empty operatorList}">
						<div class="paging">
							${pageHtml}
							<div class="right">
								<a href="#" class="btnType2" onclick="regOperator();">신규등록</a>
							</div>
						</div>
						</c:when>
					</c:choose>
					<!--[e] 페이징 -->
				</div>
				<!-- //section -->
			</div>
			</form:form>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>