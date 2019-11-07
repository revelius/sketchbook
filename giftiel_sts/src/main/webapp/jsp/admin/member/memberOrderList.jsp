<%--
 * =============================================================================
 * 파일명 : /member/memberOrderList.jsp
 * 작성자 : 박필종
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원관리 > 주문내역 
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
	    $("a[href=#]").attr("href", "javascript:void(0);");
		
		//페이징 처리
	    paging = function(page) {
			$('#page').val(page);
	        goSubmit();
	    };	    
	    
	    //결과 갯수 셋팅
	    doNumList = function() {
	    	var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/member/memberOrderList'/>";
		        frm.submit();
	    };
	    
	    goSubmit = function(){
	    	 var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/member/memberOrderList'/>";
		        frm.submit();
	    };
	    
	    $('#orderTable').rowspan(1);
	    
    });

	doGoMove = function(gubun){
		if(gubun== "1"){ //회원정보
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/membershipInfo'/>";
	        frm.submit();
		}else if(gubun== "2"){
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/inquire'/>";
	        frm.submit();
		}else if(gubun== "3"){
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/cartList'/>";
	        frm.submit();
		}
	};
	
    goDetail = function(cnslNo){
    	var $target = $(cnslNo);
    	var cnslNo = $target.attr('data-cnslNo');
    	var frm = document.hiddenForm;
    	frm.cnslNo.value = cnslNo;
    	frm.action = "<c:url value='/admin/manage/inquiryDetail'/>";
        frm.submit();
    };
    
 	 //주문상세팝업
    gotoOrderPopup = function(ordNo) {
    	
		var popUrl = "<c:url value='/admin/order/popupOrder'/>";	//팝업창에 출력될 페이지 URL
		var param = "?ordNo="+ordNo;
		var popOption = "width=1100, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl+param,"",popOption);
			
    };		
    
    
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
					<jsp:param name="menuFlag" value="member"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents memberList">				
					<h3><span class="icon1"></span>회원정보</h3>	
					<p class="pt_14">${searchForm.nm}(${searchForm.email }) 님의 정보<span>최종로그인
						<c:if test="${empty logingHist.regDts}">
						: 로그인 이력 없음
						</c:if>
						<fmt:formatDate value="${logingHist.regDts}" pattern="yyyy-MM-dd HH:mm:SS" /> </span></p>

					<div class="tabType1">
						<ul>
							<li><a href="javascript:doGoMove('1');">회원정보</a></li>
							<li class="on"><a href="#">주문내역</a></li>
							<li><a href="javascript:doGoMove('2');">1:1 문의</a></li>
							<li><a href="javascript:doGoMove('3');">Cart</a></li><!-- /admin/member/cart.html -->
						</ul>
					</div>
					
					<form id="hiddenForm" name="hiddenForm" method="post">
						<input type="hidden" id="cnslNo" name="cnslNo"/>
					</form>
				
					<!--[s] 주문내역 리스트 -->
					<div class="section a2">
						<div class="tableTitle">
							<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
								<form:hidden path="nm" id="nm"/>
        						<form:hidden path="email" id="email"/>
        						<form:hidden path="memNo" id="memNo"/>
        						<form:hidden path="page"/>
        													
							<div class="select2">								
								<form:select path="payWay" onchange="javascript:doNumList();">
									<form:option value="">결제방법</form:option>
									<form:options items="${payWayList}" itemLabel="cdNm" itemValue="cdNo"/>
								</form:select>
								<form:select path="perOrdStat" onchange="javascript:doNumList();">
									<form:option value="">주문상태구분</form:option>
									<form:options items="${perOrdStatList}" itemLabel="cdNm" itemValue="cdNo"/>
								</form:select>
								<form:select path="searchCount" onchange="javascript:doNumList();">
									<form:option value="">선택</form:option>
									<form:option value="15">15개 보기</form:option>
									<form:option value="30">30개 보기</form:option>
									<form:option value="50">50개 보기</form:option>
									<form:option value="100">100개 보기</form:option>
									<form:option value="200">200개 보기</form:option>
								</form:select>							
							</div>
							
							</form:form>
						</div>

						<div class="tableType1">
							<table id="orderTable">
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="10%" />
								<col width="15%" />
								<col width="*" />
								<col width="15%" />
								<col width="10%" />
								<col width="5%" />
								<col width="10%" />
							</colgroup>
							<thead>
								<tr  id="sortTr">
									<th>매장명</th>
									<th>주문번호</th>
									<th>상품</th>
									<th>주문일시</th>
									<th>판매가</th>
									<th>수량</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orderList}" var="order" varStatus="listCount">
										<tr>	
											
											<td>${order.siteNm}</td>
											<td onclick="javascript:gotoOrderPopup('${order.ordNo }')" style="cursor:pointer">${order.ordNo}</td>
											<td>[${order.brand}]${order.ubiGdsNm}/${order.ubiGdsColorNm}/${order.ubiGdsSize}</td>
											<td><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd HH:mm:SS" /></td>
											<td><fmt:formatNumber type="currency" value="${order.slPrc}" pattern="###,###" />원</td>
											<td>${order.ordQty}개</td>
											<td>${order.perOrdStatNm}<%-- <br />(${order.ordStatNm}) --%></td>
										</tr>
								</c:forEach>
								<c:if test="${empty orderList}">
									<tr>
										<td colspan="7">조회할 항목이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!--[e] 주문내역 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						<c:if test="${not empty orderList}">
							${pageHtml}
						</c:if>
						<div class="left">
							<a href="<c:url value='/admin/member/memberList'/>" class="btnType1">회원목록</a>
						</div>
					</div>
					<!--[e] 페이징 -->				

				</div>
				<!--[e] contents -->

			</div>
		<!--[e] subWrap -->

		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>