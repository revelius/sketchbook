<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 환경설정 인덱스 화면 
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
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>환경설정</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 관리하는 모든 사이트의 설정이 가능합니다.</li>
							</ul>
							<!-- [s] 상점기본정보관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>상점기본정보관리</div>		
							</div>						
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>상점환경설정</th>
									<td><a href="<c:url value='/admin/setting/storeSetting'/>">관리자 로그인정보 변경 및 상점의 기본적인 정보를 입력하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 상점기본정보관리 -->
							<!-- [s] 사이트정보관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>사이트정보관리</div>		
							</div>
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>사이트환경설정</th>
									<td><a href="<c:url value='/admin/setting/siteSetting'/>">사이트의 기본정보 및 상품관련환경을 설정하실 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 사이트정보관리 -->
							<!-- [s] 전체운영 설정 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>전체운영 설정</div>		
							</div>							
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>배송설정</th>
									<td><a href="<c:url value='/admin/setting/deliverySetting'/>">전체 배송환경을 설정합니다.</a></td>
								</tr>
								<tr>
									<th>회원등급관리</a></th>
									<td><a href="<c:url value='/admin/setting/memberSetting'/>">회원등급을 관리합니다.</a></td>
								</tr>
								<tr>
									<th>포인트설정</th>
									<td><a href="<c:url value='/admin/setting/pointSetting'/>">포인트 설정을 관리합니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 전체운영 설정 -->
							<!-- [s] 상점운영정책 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>상점운영정책</div>		
							</div>					
							<table>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>								
								<tr>
									<th>상점운영정책</th>
									<td><a href="<c:url value='/admin/setting/storeManage'/>">상점운영정책을 관리할 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 상점운영정책 -->
					</div>
					<!--[e] 카테고리관리 -->
				</div>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

	</div>
	</div>
</body>
</html>