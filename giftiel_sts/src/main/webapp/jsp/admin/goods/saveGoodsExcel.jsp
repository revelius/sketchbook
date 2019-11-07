<%--
 * =============================================================================
 * 파일명 : /goods/goodsList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리 > 상품목록
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
		//저장
	    $("#btn_save").click(function() {
	    	var frm = document.goodsForm;
	        frm.target = '_self';
	        frm.action = 'saveGoodsExcel';
	        frm.submit();
	    });
    });
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
						<jsp:param name="onChk" value="saveGoodsExcel"/>
					</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="goodsForm" name="goodsForm" method="post" modelAttribute="goodsForm" onsubmit="return check(form)">
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>상품 엑셀 일괄 등록</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 상품을 엑셀 파일로 일괄 등록 및 관리합니다.</li>
							</ul>
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>상품 등록</div>		
							</div>
							<div class="tableType2">							
								<table>
								<caption>상품등록 폼</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>파일 첨부</th>
										<td>
											<a href="javascript:openFileUploadPop('excel','goodsExcel','goodsExcel');" class="btnType1 right2">상품 엑셀 업로드(excel)</a>
											<p class="addtxt">* 상품은 최대 1000개까지만 등록/수정할 수 있습니다. </p>
										</td>
									</tr>
								</tbody>
								</table>
							</div>
							<br/><br/>
							<div class="tableType2" style="overflow-x:scroll;">	
								<table class="chart" id="goodsExcel" >
									<tr>
										<th >UBI품번</th>
										<th>키워드1</th>
										<th>키워드2</th>
										<th>키워드3</th>
										<th>키워드4</th>
										<th>키워드5</th>
										<th>키워드6</th>
										<th>상품정보고시번호</th>
										<th>전시여부</th>
										<th>판매기간구분</th>
										<th>판매시작기간</th>
										<th>판매종료기간</th>
										<th>판매상태</th>
										<th>INFORMATION</th>
										<th>상세설명</th>
										<th>리스트이미지</th>
										<th>추가이미지1</th>
										<th>추가이미지2</th>
										<th>추가이미지3</th>
										<th>추가이미지4</th>
										<th>추가이미지5</th>
									</tr>
								</table>							
							</div>
							
							<div class="paging">
								<div class="right">
									<a href="javascript:void(0);" id="btn_save" class="btnType2">저장</a>
								</div>
							</div>
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>엑셀등록 도움말</div>
								<ul>
									<li>- 파일 내에서 행이나 열의 삭제/수정, 서식 이용, 순서 변경을 하지 마십시오.</li>
									<li>- 양식은 다른 이름으로 저장하더라도, 확장자는 유지해 주세요.</li>
								</ul>
							</div>
							<div class="paging">
								<div class="right">
									<a href="<c:url value="/resources/admin/download/goodsExcel.xlsx"/>" class="btnType2">엑셀 샘플 다운로드</a>
								</div>
							</div>
						</div>
					</div>
					<!--[e] 카테고리관리 -->
				</div>
				</form:form>
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