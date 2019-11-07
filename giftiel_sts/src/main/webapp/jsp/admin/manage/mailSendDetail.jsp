<%--
 * =============================================================================
 * 파일명 : /manage/newsList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : News 리스트 
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
			<form:form id="mailManage" name="mailManage" method="post" modelAttribute="mailManage" onsubmit="">
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>운영관리 &gt; 메일발송관리 &gt; 발송내역</h3>
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<div class="tableType2">
						<table>
							<caption>메일발송</caption>
							<colgroup>
								<col width="130px">
								<col width="*">
								<col width="130px">
								<col width="350px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">발송일</th>
									<td>${mailManage.sndDts }</td>
<!-- 									<th scope="col">발송상태</th> -->
<!-- 									<td>발송완료</td> -->
								</tr>
								<tr>
									<th scope="col">수신자선택</th>
									<td>
									${mailManage.regUserNm }
										<div class="sendMember">${mailManage.rcvrEmail }</div>
<!-- 										등급별 발송 -->
<!-- 										<div class="sendMember">1등급</div> -->
<!-- 										전체회원 발송 -->
									</td>
								</tr>
								<tr>
									<td colspan="2">
										${mailManage.txtHtml } 
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->
				<!-- section -->
				<div class="section a2 btn">
					<a href="<c:url value='/admin/manage/mailSendList' />" class="btnType2" id="btn_list">목록</a>
					<a href="#" class="btnType2">재발송</a>
				</div>
				<!-- //section -->
			</div>
			<!--[e] contents -->
			</form:form>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>