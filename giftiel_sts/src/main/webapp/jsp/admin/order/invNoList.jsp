<%--
 * =============================================================================
 * 파일명 : /order/orderList.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-10-21
 *
 * 파일 내용 : 주문매출관리 > 송장등록
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
	    	if($("#isExcel").val()){
		    	var frm = document.orderForm;
		        frm.target = '_self';
		        frm.action = 'saveInvNoExcel';
		        frm.submit();
	    	}else{
	    		alert("업로드된 파일이 없습니다.");
	    		return;
	    	}
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
						<jsp:param name="menuFlag" value="order"/>
						<jsp:param name="onChk" value="invNoList"/>
					</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="orderForm" name="orderForm" method="post" modelAttribute="orderForm" onsubmit="return check(form)">
				<input type="hidden" id="isExcel" />
				<div class="contents productList">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>송장 등록</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 주문상품의 송장번호를 엑셀 파일로 일괄 등록 및 관리합니다.</li>
							</ul>
							<div class="tableTitle">
								<div class="left"><span class="icon2"></span>송장 등록</div>		
							</div>
							<div class="tableType2">							
								<table>
								<caption>송장등록 폼</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>파일 첨부</th>
										<td>
											<a href="javascript:openFileUploadPop('excel','invNoExcel','invNoExcel');" class="btnType1 right2">송장번호 엑셀 업로드(excel)</a>
											<p class="addtxt">* 업로드 전 엑셀시트의 입력 값을 확인 하세요. </p>
										</td>
									</tr>
								</tbody>
								</table>
							</div>
							
							<br/><br/>
							<div class="tableType1">	
								<table class="chart" id="invNoExcel" >
									<tbody>
									<tr>
										<th>주문번호</th>
										<th>송장번호</th>
										<th>택배사번호</th>
									</tr>
									</tbody>
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
									<a href="<c:url value="/resources/admin/download/orderGoodsExcelSimple.xlsx"/>" class="btnType2">엑셀 샘플 다운로드</a>									
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