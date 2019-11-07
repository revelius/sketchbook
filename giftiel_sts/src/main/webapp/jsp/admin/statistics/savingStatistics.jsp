<%--
 * =============================================================================
 * 파일명 : /statistics/savingStatistics.jsp
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
			        frm.action = "<c:url value='/admin/statistics/savingStatistics'/>";
			        frm.submit();
		    };
		  
		  	//엑셀 다운로드
		    $('#btn_excel').click(function() {
		    	$("#excel").val("true");
		    	$('#btn_search').click();
		    	$("#excel").val("false");
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
			<!--[s] lnb -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
				<jsp:param name="menuFlag" value="static"/>
			</jsp:include>
			<!--[e] lnb -->
				
			<!--[s] contents -->
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="page" id="page"/>
			<form:hidden path="excel" id="excel"/>
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 마케팅통계 &gt; 적립금사용통계</h3>
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
									<td colspan="3">
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
									<td rowspan="2" class="bd_left">
										<a href="#" class="btnType2" id="btn_search">검색</a> <br /><br />
										<a href="#" class="btnType1" id="btn_reset">초기화</a>
									</td>
								</tr>
								<tr>
									<th>등급</th>
									<td>
										<form:select path="memGrdNo" items="${memberGradeList}" itemLabel="grdNm" itemValue="memGrdNo" />
									</td>
									<th>브랜드</th>
									<td>
										<form:select path="siteNo" items="${siteList}" id="siteNo" itemLabel="siteNm" itemValue="siteNo" />
									</td>
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
						<table>
							<caption>적립금 통계 테이블</caption>
							<colgroup>
								<col width="20%" />
								<col width="20%" />
								<col width="20%" />
								<col width="20%" />
								<col width="20%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="row">일자</th>
									<th scope="row">판매금액</th>
									<th scope="row">회원할인</th>
									<th scope="row">포인트적립</th>
									<th scope="row">포인트사용</th>
								</tr>
							</thead>
							<tfoot>
								<tr class="txtBold">
									<th scope="col">${savingStatisticsTotal[0].firstColumn }</th>
									<td class="tdBg"><fmt:formatNumber type="currency" value="${savingStatisticsTotal[0].totPay }" pattern="###,###" /></td>
									<td class="tdBg"><fmt:formatNumber type="currency" value="${savingStatisticsTotal[0].memGradeDc }" pattern="###,###" /></td>
									<td class="tdBg"><fmt:formatNumber type="currency" value="${savingStatisticsTotal[0].totPoint }" pattern="###,###" /></td>
									<td class="tdBg"><fmt:formatNumber type="currency" value="${savingStatisticsTotal[0].usePoint }" pattern="###,###" /></td>
								</tr>
							</tfoot>
							<tbody>
							<c:choose>
									<c:when test="${not empty savingStatisticsList }">
										<c:forEach items="${savingStatisticsList}" var="saving" varStatus="listCount">
											<tr>
												<td>${saving.firstColumn }</td>
												<td><fmt:formatNumber type="currency" value="${saving.totPay }" pattern="###,###" /></td>
												<td><fmt:formatNumber type="currency" value="${saving.memGradeDc }" pattern="###,###" /></td>
												<td><fmt:formatNumber type="currency" value="${saving.totPoint }" pattern="###,###" /></td>
												<td><fmt:formatNumber type="currency" value="${saving.usePoint }" pattern="###,###" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
									<td colspan="5"> 조회된 데이터가 없습니다.</td>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<!--[s] 페이징 -->
						<div class="paging">
							<c:choose>
								<c:when test="${not empty savingStatisticsList}">
									${pageHtml}
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
	</div>
</body>
</html>