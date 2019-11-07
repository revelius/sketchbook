<%-- 
 작성자 : jhr
 작성일 : 2015-04-13
 화면명 : 관리자 회원 등급관리 화면 
--%>
<%@ page contentType="text/html; charset=utf-8" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>

<script>
function doDelete(grd_no){
	if(!confirm("삭제시 복구 불가능 합니다.\n삭제하시겠습니까?")){
		return;
	}
	
	$("#grd_no").val(grd_no);
	
	$.ajax({
		url : "<c:url value='/admin/setting/memberGrdDelete'/>",
        type: "post",
        data : JSON.stringify(convertFrmToJSON($("#frm"))),
        contentType: "application/json", 
        success : function(responseData){
            var data = JSON.parse(responseData);
			
            if(data=="1"){  // 성공 
            	alert("삭제 되었습니다.");
            	location.href="<c:url value='/admin/setting/memberSetting'/>";          	
            }
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}

//신규등록
function doRegist(){
	location.href="<c:url value='/admin/setting/memberRegist'/>";
}

function doUpdate(grd_no){
	$("#grd_no").val(grd_no);
	
	document.frm.action = "<c:url value='/admin/setting/memberModify'/>";
	document.frm.submit();
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
				
			<!--[s] contents -->
			<div class="contents"><!-- contents_tab -->
				<h3><span class="icon1"></span>환경설정 > 전체운영설정 > 회원등급관리</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 회원을 분류하여 관리합니다.</li> -->
<!-- 						<li>- 등급과 등급에 대한 명칭으로 구분합니다.</li> -->
<!-- 						<li>- 등급별 할인율 또는 적립율을 설정할 수 있습니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				
				<form name="frm" id="frm" method="post">
					<input type="hidden" name="grd_no" id="grd_no">
				</form>
				<!-- [s] 전체운영설정 컨텐츠 -->
				<div class="tabCon_inner">
					<!-- [s] 기본 배송정책 설정 테이블 -->
					<div class="tableType1">
						<table>
							<caption>회원등급관리 리스트</caption>
							<colgroup>
								<col width="5%">
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="row">No</th>
									<th scope="row">등급명</th>
									<th scope="row">할인율</th>
									<th scope="row">적립율</th>
									<th scope="row">작성자</th>
									<th scope="row">작성일</th>
									<th scope="row">관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="list" varStatus="listCount">							
									<tr>
										<td>${listCount.count}</td>
										<td>${list.GRD_NM}</td>
										<td>${list.DC_AMT}%</td>
										<td>${list.PNT_RSV_RT}%</td>
										<td>${list.REG_USER_NM}</td>
										<td><fmt:formatDate pattern="yyyy.MM.dd" value="${list.REG_DTS}"/></td>
										<td>
											<a href="javascript:doUpdate('${list.MEM_GRD_NO}');" class="btnType1">수정</a>
											<a href="javascript:doDelete('${list.MEM_GRD_NO}');" class="btnType1">삭제</a>
										</td>										
									</tr>
								</c:forEach>
								<c:if test="${empty list}">
									<tr>
										<td colspan="7">조회된 데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!-- [e] 기본 배송정책 설정 테이블 -->
					<a href="javascript:doRegist();" class="btnType2 right">신규등록</a>
					<!-- 스토리보드에 없어서 주석 처리함. -->
<!-- 					<div class="section a2 btn"> -->
<!-- 						<a href="#" class="btnType2">저장</a>  -->
<!-- 						<a href="#" class="btnType1">취소</a> -->
<!-- 					</div> -->
				</div>
				<!-- [e] 상점환경설정 컨텐츠 -->	
			</div>
			<!--[e] contents -->
		   </div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>