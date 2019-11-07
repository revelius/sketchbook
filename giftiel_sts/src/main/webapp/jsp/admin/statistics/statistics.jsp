<%--
 * =============================================================================
 * 파일명 : /statistics/statistics.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 통계 메인
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<jsp:include page="/jsp/admin/include/head.jsp" />
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<jsp:include page="/jsp/admin/include/top.jsp" />
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="static" />
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3>
							<span class="icon1"></span>통계/분석
						</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 사이트에 관련된 일반적인 통계를 분석합니다.</li>
							</ul>
							<!-- [s] 매출통계 -->
							<div class="tableTitle">
								<div class="left">
									<span class="icon2"></span>매출통계
								</div>
							</div>
							<table>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>전체매출통계</th>
										<td><a href="#">쇼핑몰의 전반적인 매출상황을 보실 수 있는 곳입니다.</a></td>
									</tr>
									<tr>
										<th>상품매출통계</th>
										<td><a href="#">상품당 매출 상황 및 분포도, 구매고객을 한눈에 보실 수 있는 곳입니다.</a></td>
									</tr>
									<tr>
										<th>회원별매출통계</th>
										<td><a href="#">각 회원들의 매출 상황을 보실 수 있는 곳입니다.</a></td>
									</tr>
								</tbody>
							</table>
							<!-- [e] 매출통계 -->
							<!-- [s] 회원통계 -->
							<div class="tableTitle">
								<div class="left">
									<span class="icon2"></span>회원통계
								</div>
							</div>
							<table>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>남녀비율통계</th>
										<td><a href="<c:url value='/admin/statistics/genderStatistics'/>">사이트에 가입한 회원들의 남여 비율입니다.</a></td>
									</tr>
									<tr>
										<th>연령대별통계</th>
										<td><a href="<c:url value='/admin/statistics/ageStatistics'/>">사이트에 가입한 회원들을 연령대별로 분석합니다.</a></td>
									</tr>
									<tr>
										<th>거주자별통계</th>
										<td><a href="<c:url value='/admin/statistics/residenceStatistics'/>">사이트에 가입한 회원들을 거주지역별로 분석합니다.</a></td>
									</tr>
								</tbody>
							</table>
							<!-- [e] 권한관리 -->
							<!-- [s] 접속통계 -->
							<div class="tableTitle">
								<div class="left">
									<span class="icon2"></span>접속통계
								</div>
							</div>
							<table>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>방문자접속통계</th>
										<td><a href="<c:url value='/admin/statistics/visitantStatistics'/>">쇼핑몰의 전반적인 매출상황을 보실 수 있는 곳입니다.</a></td>
									</tr>
									<tr>
										<th>접속방향통계</th>
										<td><a href="<c:url value='/admin/statistics/contactStatistics/All'/>">쇼핑몰 이용자들이 어떤 곳을 통해서 들어왔는지 한눈에 보실 수 있는 곳입니다.</a></td>
									</tr>
								</tbody>
							</table>
							<!-- [e] 접속통계 -->
							<!-- [s] 상품통계 -->
							<div class="tableTitle">
								<div class="left">
									<span class="icon2"></span>상품통계
								</div>
							</div>
							<table>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>상품별통계</th>
										<td><a href="<c:url value="/admin/statistics/goodsProductStatistics" />">사이트에 주문한 상품별 통계입니다.</a></td>
									</tr>
									<!-- 								<tr> -->
									<!-- 									<th>상품보관함통계</th> -->
									<!-- 									<td>상품보관함에 가장 많이 담긴 상품 및 판매수를 한 눈에 볼 수 있는 곳입니다.</td> -->
									<!-- 								</tr> -->
									<!-- 								<tr> -->
									<!-- 									<th>고객평점통계</th> -->
									<!-- 									<td>판매 후, 고객들의 평점을 비교해 볼 수 있는 곳 입니다.</td> -->
									<!-- 								</tr> -->
								</tbody>
							</table>
							<!-- [e] 상품통계 -->
							<!-- [s] 마케팅통계 -->
							<div class="tableTitle">
								<div class="left">
									<span class="icon2"></span>마케팅통계
								</div>
							</div>
							<table>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>적립금사용통계</th>
										<td><a href="<c:url value='/admin/statistics/savingStatistics'/>">날짜별로 회원들의 적립금 사용액 및 획득한 적립금을 볼 수 있는 곳입니다.</a></td>
									</tr>
								</tbody>
							</table>
							<!-- [e] 마케팅통계 -->
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