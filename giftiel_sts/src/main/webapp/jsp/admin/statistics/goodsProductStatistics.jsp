<%--
 * =============================================================================
 * 파일명 : /statistics/goodsProductStatistics.jsp
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
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	<script type="text/javascript">
	 $(function() {

		 	$("a[href=#]").attr("href", "javascript:void(0);");

		 	$("#searchText").val("${param.searchText}");
	    	$("#ubiGdsNo").val("${param.ubiGdsNo}");
	    	
		 	if( $("#searchText").val() != "" && $("#searchText").val() != null ) {
			 	$("#inGoodCode").html("<span id='fNm'>${param.searchText}</span> <a href='javascript:removeFind();' id='cls'>X</a>");
		 	}
		 	
			// datepicker 
			$( ".datepicker1, .datepicker2" ).datepicker({
				inline: true, 
				dateFormat: "yy.mm.dd",    /* 날짜 포맷 */ 
				showOn: "both", 
				buttonImage: "${pageContext.request.contextPath}/resources/admin/images/common/icon2.gif",
				buttonImageOnly: true, 
				minDate: '-30y', 
				showMonthAfterYear: true,   /* 년과 달의 위치 바꾸기 */ 
				/* 한글화 */ 
				monthNames : ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'], 
				monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showAnim: 'slideDown', 
				/* 날짜 유효성 체크 */ 
				onClose: function( selectedDate ) { 
				  $('#fromDate').datepicker("option","minDate", selectedDate); 
				} 
			});
			$('#ui-datepicker-div').addClass('dateCal');
		 
		 	/*★★★★★ 기간 검색조건 START ★★★★★*/
		    if($("#searchStrDtm").val() == ""){//default기간 셋팅
		    	setSearchPeriod("set1");
		    }
		    
		    //기간검색 이벤트 추가
		    $("a[href=#]").attr("href", "javascript:void(0);");
		    $('#set1').on('click', function(e){ setSearchPeriod("set1"); });
		    $('#set2').on('click', function(e){ setSearchPeriod("set2"); });
		    $('#set3').on('click', function(e){ setSearchPeriod("set3"); });
		    $('#set4').on('click', function(e){ setSearchPeriod("set4"); });
		    $('#set5').on('click', function(e){ setSearchPeriod("set5"); });
		    $('#set6').on('click', function(e){ setSearchPeriod("set6"); });
		    $('#set7').on('click', function(e){ setSearchPeriod("set7"); });
		    
		    //기간설정
		    function setSearchPeriod(pCode){
		    	var gubun = "";
		    	var period = 0;
		    	if(pCode=="set1"){
		    		gubun = "day";
		    	}else if(pCode=="set2"){
		    		gubun = "day";
		    		period = -1;
		    	}else if(pCode=="set3"){
		    		gubun = "thisMonth";
		    	}else if(pCode=="set4"){
		    		gubun = "day";
		    		period = -7;
		    	}else if(pCode=="set5"){
		    		gubun = "day";
		    		period = -15;
		    	}else if(pCode=="set6"){
		    		gubun = "month";
		    		period = -1;
		    	}else if(pCode=="set7"){
		    		gubun = "month";
		    		period = -2;
		    	}
		    	setdate(gubun,period);
		    }
		    
		    //기간 실행
		    function setdate(gubun,period){
		    	var today = new Date();
			    var start_month = (today.getMonth() + 1);
			    var start_day = today.getDate();
				    start_month = (start_month < 10) ? "0"+start_month : start_month;
				    start_day = (start_day < 10) ? "0"+start_day : start_day;
			    var start_date = today.getFullYear() + "." + start_month + "." + start_day;
		    	
			    if(gubun == 'day'){
		    		today.setDate(today.getDate()+period);
		    	}else if(gubun == 'month'){
		    		today.setMonth(today.getMonth()+period);
		    	}else if(gubun == 'thisMonth'){
		    		today.setDate(1);
		    	}
			    	
			    var end_month = (today.getMonth() + 1);
			    var end_day = today.getDate();
				    end_month = (end_month < 10) ? "0"+end_month : end_month;
				    end_day = (end_day < 10) ? "0"+end_day : end_day;
			    var end_date = today.getFullYear() + "." + end_month + "." + end_day;
				    $("#searchStrDtm").val(end_date);
				    $("#searchEndDtm").val(start_date);
		    };
		    /*★★★★★ 기간 검색조건 END ★★★★★*/

			//리스트 검색 공통
		    $('#btn_search').click(function() {
				$("#page").val("1");
		    	goSubmit();
		    });
			
		  //검색 초기화 버튼
		    $('#btn_reset').click(function() {
	            $(':input').each(function(index) {
	            	if($(this).attr('type')=="text"){
	            		$(this).val("");
	            	}
	            });
	         	// 당일로 셋팅 후 시작일을 그달에 1일로 변경
	            setSearchPeriod("set3");
	            $('select').find('option:first').attr('selected', 'selected');
	            removeFind("fNm");
		    });
		  
			//페이징 처리
		    paging = function(page) {
		        document.getElementById("page").value = page;
		        goSubmit();
		    };	
		    //결과 갯수 셋팅
		    doNumList = function() {
		    	$('#btn_search').click();
		    };
		  	//검색
		    goSubmit = function(){
		    	 var frm = document.schForm;
			        frm.action = "<c:url value='/admin/statistics/goodsProductStatistics'/>";
			        frm.submit();
		    };
			
			goodsPopup = function(resultId) {
				//var resultId = "tempGoods";
				var popUrl = "<c:url value='/admin/popup/goods/popupGoodsListForStatistics'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
				var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
					window.open(popUrl,"productPopup",popOption);
			};
			
			//상품팝업에서 호출함
		    callback_setGoods = function(goodsData, resultId){
		    	var goodsNo = goodsData.split(":")[0];
		    	var goodsName = goodsData.split(":")[1];

		    	$("#"+resultId).html("<span id='fNm'>"+goodsName+"</span> <a href='javascript:removeFind();' id='cls'>X</a>");
		    	$("#searchText").val(goodsName);
		    	$("#ubiGdsNo").val(goodsNo);
			};
			
			removeFind = function(){
				$("#fNm").remove();
				$("a#cls").remove();
				$("#searchText").val("");
		    	$("#ubiGdsNo").val("");
			};
			
			//엑셀 다운로드
			$('#btn_excel').click(function() {
				$("#excel").val("true");
				$('#btn_search').click();
				$("#excel").val("false");
			});
			
			$('#goodsTable').rowspan(0);
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
			<!--[s] lnb --> 
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
				<jsp:param name="menuFlag" value="static"/>
			</jsp:include>
			<!--[e] lnb -->
					
			<!--[s] contents -->
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="page" id="page"/>
			<form:hidden path="searchText" id="searchText"/>
			<form:hidden path="ubiGdsNo" id="ubiGdsNo" />
			<form:hidden path="excel" id="excel"/>
			
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 상품통계 &gt; 상품별통계</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
				<div class="first">
					<div class="tableType2">
						<table>
							<caption>배송검색</caption>
							<colgroup>
								<col width="100px">
								<col width="*">
								<col width="100px">
								<col width="150px">
								<col width="120px">
							</colgroup>
							<tbody>
								<tr>
									<th>기간</th>
									<td>
										<a href="#" id="set1" class="btnType1">당일</a>
										<a href="#" id="set2" class="btnType1">전일</a>
										<a href="#" id="set3" class="btnType1">당월</a>
										<a href="#" id="set4" class="btnType1">1주</a>
										<a href="#" id="set5" class="btnType1">15일</a>
										<a href="#" id="set6" class="btnType1">한달</a>
										<a href="#" id="set7" class="btnType1">두달</a>
										<br /><br />
										<div class="wrap">
											<form:input path="searchStrDtm" id="searchStrDtm" name="searchStrDtm" readonly="true" cssClass="datepicker1"/> ~
											<form:input path="searchEndDtm" id="searchEndDtm" name="searchEndDtm" readonly="true" cssClass="datepicker2"/>			
										</div>
									</td>
									<th>브랜드</th>
									<td>
										<form:select path="siteNo" items="${siteList}" id="siteNo" itemLabel="siteNm" itemValue="siteNo" />
									</td>
									<td rowspan="2" class="bd_left">
										<a href="#" class="btnType2" id="btn_search">검색</a> <br /><br />
										<a href="#" class="btnType1" id="btn_reset">초기화</a>
									</td>
								</tr>
								<tr>
									<th>상품</th>
									<td colspan="3" id="find"><a href="javascript:goodsPopup('inGoodCode')" class="btnType1">찾기</a><span id="inGoodCode"></span> </td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- section -->
				<div class="section a2">
					<div class="tableTitle">
						<div class="left">${dateText }</div>
<!-- 						<div class="right"> -->
<%-- 							<form:select path="searchCount" onchange="javascript:doNumList();" cssClass="ml_5"> --%>
<%-- 								<form:option value="15">15개 보기</form:option> --%>
<%-- 								<form:option value="30">30개 보기</form:option> --%>
<%-- 								<form:option value="50">50개 보기</form:option> --%>
<%-- 								<form:option value="100">100개 보기</form:option> --%>
<%-- 							</form:select> --%>
<!-- 						</div> -->
					</div>
					<!-- 전체 -->
					<div class="tableType1">
						<table id="goodsTable">
							<caption>상품별 통계 테이블</caption>
							<colgroup>
								<col width="*" />
								<col width="12%" />
								<col width="12%" />
								<col width="12%" />
								<col width="12%" />
								<col width="12%" />
								<col width="12%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="row">일자</th>
									<th scope="row">브랜드</th>
									<th scope="row">상세보기 수</th>
									<th scope="row">장바구니 등록 수</th>
									<th scope="row">주문건 수</th>
									<th scope="row">판매 수</th>
									<th scope="row">매출액</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty goodsProductStatistics}">
										<c:forEach var="list" items="${goodsProductStatistics}" varStatus="stat">
											<c:forEach var="goodsPro" items="${list.brand}" varStatus="stat">
											<tr>
												<td>${list.period}</td>
												<td>${goodsPro.brandNm }</td>
												<td>${goodsPro.detailTot}</td>
												<td>${goodsPro.cartTot}</td>
												<td>${goodsPro.ordTot}</td>
												<td>${goodsPro.ordGdTot}</td>
												<td><fmt:formatNumber type="currency" value="${goodsPro.payTot }" pattern="###,###" /></td>
											</tr>
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tfoot>
								<c:forEach var="total" items="${goodsProductStatisticsTot}" varStatus="stat">
									<c:forEach var="goodsProductTotal" items="${total.brand}" varStatus="stat">
									<tr class="txtBold">
										<th scope="col" colspan="2">${total.period}</th>
										<td class="tgBg">${goodsProductTotal.detailTot}</td>
										<td class="tgBg">${goodsProductTotal.cartTot}</td>
										<td class="tgBg">${goodsProductTotal.ordTot}</td>
										<td class="tgBg">${goodsProductTotal.ordGdTot}</td>
										<td class="tgBg"><fmt:formatNumber type="currency" value="${goodsProductTotal.payTot }" pattern="###,###" /></td>
									</tr>
									</c:forEach>
								</c:forEach>
							</tfoot>
						</table>
						<!--[s] 페이징 -->
						<div class="paging">
							<c:choose>
								<c:when test="${not empty goodsProductStatistics}">
<%-- 									${pageHtml} --%>
									<div class="right">
										<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
									</div>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</div>
						<!--[e] 페이징 -->
					</div>
					<!-- 전체 -->
				</div>
				<!-- //section -->
			</div>
			</form:form>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->
	</div>
</body>
</html>