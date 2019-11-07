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
					<jsp:param name="menuFlag" value="goods"/>
					<jsp:param name="onChk" value="main"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>상품관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 쇼핑몰의 상품을 올리실 수 있는 곳입니다. 먼저 상품에 맞는 카테고리를 설정해 주세요.</li>
								<li>- 상품정보를 엑셀로 업로드 하실 수 있습니다.</li>
							</ul>
							<!-- [s] 카테고리 관리 -->
<!-- 							<div class="tableTitle"> -->
<!-- 								<div class="left"><span class="icon2"></span>카테고리 관리</div> -->
<!-- 							</div> -->
<!-- 							<table class="cateinfo"> -->
<!-- 							<colgroup> -->
<!-- 								<col width="132px" /> -->
<!-- 								<col width="*" /> -->
<!-- 							</colgroup> -->
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<th>일반카테고리관리</th> -->
<!-- 									<td><a href="#">아이템 지정하시고 디렉토리를 설정합니다.</a></td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 							</table> -->
							<!-- [e] 카테고리 관리 -->
							<!-- [s] 상품관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>상품관리</div>
							</div>
							<table class="cateinfo">
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
<!-- 								<tr> -->
<!-- 									<th>상품등록</th> -->
<!-- 									<td><a href="#">가격과 상품이미지 설정하여 상품 등록합니다. </a></td> -->
<!-- 								</tr> -->
								<tr>
									<th>상품목록</th>
									<td><a href="<c:url value='/admin/goods/goodsList'/>">등록하신 일반상품들을 수정/관리 하실 수 있습니다.</a></td>
								</tr>
								<tr>
									<th>상품진열설정</th>
									<td><a href="<c:url value='/admin/goods/goodsDisplay'/>">등록하신 상품의 진열순서를 설정하실 수 있습니다.</a></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<th>상품휴지통</th> -->
<!-- 									<td>삭제된 상품들을 모았습니다.복원 누르면 다시 복구됩니다. </a></td> -->
<!-- 								</tr> -->
								<tr>
									<th>상품 엑셀 일괄 등록</th>
									<td><a href="<c:url value='/admin/goods/saveGoodsExcel'/>">상품을 엑셀로 일괄 등록/수정 할 수 있습니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 상품관리 -->
							<!-- [s] 상품고시정보 관리 -->
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>상품고시정보 관리</div>
							</div>
							<table class="cateinfo">
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>상품고시정보 관리</th>
									<td><a href="<c:url value='/admin/goods/goodsAddInfoGrpList'/>">품목별 상품 고시정보를 관리합니다.</a></td>
								</tr>
							</tbody>
							</table>
							<!-- [e] 상품고시정보 관리 -->
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