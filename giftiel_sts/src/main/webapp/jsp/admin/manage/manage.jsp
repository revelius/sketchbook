<%--
 * =============================================================================
 * 파일명 : /manage/manage.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : 고객운영관리 
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

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>운영관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 브랜드 사이트와 회원에게 제공되는 정보 관리를 할 수 있습니다.</li>
							</ul>
							<!-- [s] 고객운영관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>고객운영관리</div>		
							</div>						
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>1:1문의관리</th>
									<td><a href="<c:url value='/admin/manage/inquiryList'/>">소비자 문의 사항을 확인하고 답변하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 고객운영관리 -->
							<!-- [s] 권한관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>권한관리</div>		
							</div>
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>부운영자</th>
									<td><a href="<c:url value='/admin/manage/operatorList'/>">부운영자를 등록하고 메뉴에 대한 권한관리를 하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 권한관리 -->
							<!-- [s] SMS관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>SMS관리</div>		
							</div>							
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>문구관리</th>
									<td><a href="<c:url value='/admin/manage/smsManage'/>">SMS 발송문구를 일괄 관리하실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>SMS발송</th>
									<td><a href="<c:url value='/admin/manage/smsSend'/>">자동발송 외 메세지를 추가로 보내실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>발송내역</th>
									<td><a href="<c:url value='/admin/manage/smsSendList'/>">자동발송 외 발송내역을 확인하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] SMS관리 -->
							<!-- [s] 메일발송관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>메일발송관리</div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>메일발송</th>
									<td><a href="<c:url value='/admin/manage/mailSend'/>">자동발송 외 이메일을 추가로 보내실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>발송내역</th>
									<td><a href="<c:url value='/admin/manage/mailSendList'/>">자동발송 외 발송내역을 확인하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 메일발송관리 -->
							<!-- [s] 메인관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>메인관리</div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>WORKSOUT</th>
									<td><a href="<c:url value='/admin/manage/mainManage/10001'/>">WORKSOUT 사이트 메인페이지 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>CARHARTT</th>
									<td><a href="<c:url value='/admin/manage/mainManage/10002'/>">CARHARTT 사이트 메인페이지 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>OBEY</th>
									<td><a href="<c:url value='/admin/manage/mainManage/10003'/>">OBEY 사이트 메인페이지 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>BRIXTON</th>
									<td><a href="<c:url value='/admin/manage/mainManage/10004'/>">BRIXTON 사이트 메인페이지 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>DEUS</th>
									<td><a href="<c:url value='/admin/manage/mainManage/10006'/>">DEUS 사이트 메인페이지 이미지 변경이 가능합니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 메인관리 -->
							<!-- [s] FEATURE 관리  -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>FEATURE 관리 </div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>WORKSOUT</th>
									<td><a href="<c:url value='/admin/manage/featureManage/10001'/>">WORKSOUT 사이트 FEATURE 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>CARHARTT</th>
									<td><a href="<c:url value='/admin/manage/featureManage/10002'/>">CARHARTT 사이트 FEATURE 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>OBEY</th>
									<td><a href="<c:url value='/admin/manage/featureManage/10003'/>">OBEY 사이트 FEATURE 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>BRIXTON</th>
									<td><a href="<c:url value='/admin/manage/featureManage/10004'/>">BRIXTON 사이트 FEATURE 이미지 변경이 가능합니다.</a></td>
								</tr>
								<tr>
									<th>DEUS</th>
									<td><a href="<c:url value='/admin/manage/featureManage/10005'/>">DEUS 사이트 FEATURE 이미지 변경이 가능합니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [s] COLLABORATION 관리   -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>COLLABORATION 관리</div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>COLLABORATION</th>
									<td><a href="<c:url value='/admin/manage/collaborationList'/>">각 브랜드 사이트 COLLABORATION 이미지 변경이 가능합니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] COLLABORATION 관리   -->
							<!-- [s] 게시판 관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>게시판 관리</div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>News</th>
									<td><a href="<c:url value='/admin/manage/newsList'/>">브랜드 별 News 내용 입력을 관리하실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>Lookbook</th>
									<td><a href="<c:url value='/admin/manage/lookbookList'/>">브랜드 별 Lookbook 내용을 관리하실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>WORK WITH US</th>
									<td><a href="<c:url value='/admin/manage/workWithUsList'/>">브랜드 별 WORK WITH US 내용을 관리하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 게시판 관리 -->
						</div>
					</div>
					<!--[e] 카테고리관리 -->
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