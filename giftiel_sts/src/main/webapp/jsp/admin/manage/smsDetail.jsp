<%--
 * =============================================================================
 * 파일명 : /manage/smsDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-14
 *
 * 파일 내용 : 운영관리 > SMS관리 > 발송내역 > 상세
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
	<form id="hiddenForm" name="hiddenForm" method="post">
 		<input type="hidden" name="msgSeq"  id="msgSeq"  value="${smsMng.msgSeq}"/>
		<input type="hidden" name="curState"  id="curState"  value="${smsMng.curState}"/>
		<input type="hidden" name="sentDate"  id="sentDate"  value="${smsMng.sentDate}"/>
		<input type="hidden" name="callTo"  id="callTo"  value="${smsMng.callTo}"/>
		<input type="hidden" name="callFrom"  id="callFrom"  value="${smsMng.callFrom}"/>
		<input type="hidden" name="smsTxt"  id="smsTxt"  value="${smsMng.smsTxt}"/>	
	</form>
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
				<div class="contents">
				<h3><span class="icon1"></span>운영관리 > SMS관리 > 발송내역 > 상세</h3>
		
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<!-- [s] 문의 테이블 -->
					<div class="tableType2">
						<table>
							<caption>문의</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
								<col width="132px" />
								<col width="350px" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="4" class="row_tit">상세내역</th>
							    </tr>
								<tr>
									<th scope="col">수신번호</th>
									<td>${smsMng.callTo}</td>
									<th scope="col">발신번호</th>
									<td>${smsMng.callFrom}</td>
								</tr>
								<tr>
									<th scope="col">발송일</th>
									<td>${smsMng.sentDate}</td>
									<th scope="col">발송상태</th>
									<td>
									<c:choose>
										<c:when test="${smsMng.curState eq '0'}">
												전송요구 
											</c:when>
											<c:when test="${smsMng.curState eq '1'}">
												전송중 
											</c:when>
											<c:when test="${smsMng.curState eq '2'}">
												결과대기
											</c:when>
											<c:when test="${smsMng.curState eq '3'}">
												전송완료 
											</c:when>
									
									<c:otherwise>
											      미처리 
											</c:otherwise>
												</c:choose></td>
								</tr>
								<tr>
									<th scope="col">내용</th>
									<td colspan="3">${smsMng.smsTxt}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 문의 테이블 -->
				</div>
				
				<!-- //section -->
				<!-- section -->
				<div class="section btn a2">
				<a href="#" class="btnType1" id="btn_check" onclick="javascript:window.history.back(-1); return false;">확인</a>
				</div>
				<!-- //section -->
			</div>
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