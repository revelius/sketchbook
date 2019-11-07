<%--
 * =============================================================================
 * 파일명 : /goods/main.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리
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
	
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="member"/>
					<jsp:param name="onChk" value=""/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>회원관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 쇼핑몰의 가입 한 회원들의 정보를 볼 수 있는 곳입니다.</li>
								<li>- 관리자가 회원에게 포인트를 개별 지급할 수 있습니다.</li>
							</ul>
							<!-- [s] 회원관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>회원관리</div>
							</div>
							<table class="cateinfo">
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>회원목록</th>
									<td><a href="<c:url value='/admin/member/memberList'/>">온라인 샵에 가입한 회원들의 정보를 볼 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>포인트관리</th>
									<td><a href="<c:url value='/admin/member/pointList'/>">포인트가 지급된 내역을 볼 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 회원관리 -->
							
							<!-- [s] 회원관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>회원목록 엑셀다운로드</div>
							</div>
							<table class="cateinfo">
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th><a href="<c:url value='/admin/member/memberListXlsx'/>" style="text-decoration: underline;">회원목록.xlsx</a></th>
									<td>SMS, MAIL 서비스 수신동의 내역이 포함된 전체 회원 리스트를 제공합니다.</a></td>
								</tr>
							</tbody>
							</table>							
						</div>
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
</body>
</html>