<%--
 * =============================================================================
 * 파일명 : /statistics/visitantWeekStatistics.jsp
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
	    	
	    	$("input:radio[name=dateType]").click(function(){
	    		var frm = document.schForm;
		        frm.action = "<c:url value='/admin/statistics/visitantStatistics'/>";
		        frm.submit();
	    	});
	    
	    	$("a[href=#]").attr("href", "javascript:void(0);");
	    	
	    	//리스트 검색 공통
		    $('#btn_search').click(function() {
		    	goSubmit();
		    });
			
			//검색 초기화 버튼
		    $('#btn_reset').click(function() {
	            $(':input').each(function(index) {
	            	if($(this).attr('type')=="text"){
	            		$(this).val("");
	            	}
	            });
	            $('select').find('option:first').attr('selected', 'selected');
		    });		
			
		     
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
		    
		    
		    
		    //datepicker 위치조절
		    $("img.ui-datepicker-trigger").attr("style", "margin-left:2px; vertical-align:middle; cursor: Pointer;");
		    
		    //검색
		    goSubmit = function(){
		    	 var frm = document.schForm;
			        frm.action = "<c:url value='/admin/statistics/visitantStatistics'/>";
			        frm.submit();
		    };
		    
		    //엑셀 다운로드
		    $('#btn_excel').click(function() {
		    	$("#excel").val("true");
		    	$('#btn_search').click();
		    	$("#excel").val("false");
		    });
		    
		    $("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
		    
		    $('#statisticsTable').rowspan(0);
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
			<div class="contents">
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="excel" id="excel"/>
				<h3><span class="icon1"></span>통계/분석 &gt; 접속통계 &gt; 방문자접속통계</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
				<div class="first">
					<div class="tableType2">
						<table>
							<caption>방문자접속통계</caption>
							<colgroup>
								<col width="100px">
								<col width="*">
								<col width="100px">
								<col width="200px">
								<col width="120px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">조건</th>
									<td colspan="3">
										<div class="wrap">
											<form:radiobutton path="dateType" id="dateType1" name="dateType" value="Day" label="일별(시간단위)"/>
											<form:radiobutton path="dateType" id="dateType2" name="dateType" value="Month" label="월별(일단위)"/>
											<form:radiobutton path="dateType" id="dateType3" name="dateType" value="Year" label="연도별(월단위)"/>
											<form:radiobutton path="dateType" id="dateType4" name="dateType" value="Week" label="요일별"/>
											<form:radiobutton path="dateType" id="dateType5" name="dateType" value="Hour" label="시간대별"/>
										</div>
									</td>
									<td rowspan="2" class="bd_left">
										<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
										<a href="#" id="btn_reset" class="btnType1">초기화</a>
									</td>
								</tr>
								<tr>
									<th scope="col">기간</th>
									<td>
										<div class="wrap">
											<form:input path="searchStrDtm" id="searchStrDtm" name="searchStrDtm" readonly="true" cssClass="datepicker1"/> ~
											<form:input path="searchEndDtm" id="searchEndDtm" name="searchEndDtm" readonly="true" cssClass="datepicker2"/>
										</div>
									</td>
									<th scope="col">브랜드</th>
									<td>
										<form:select path="siteName" items="${siteList}" id="siteList" itemLabel="siteNm" itemValue="siteNo">
											<form:option itmes="siteName" value="">전체</form:option>
										</form:select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				</form:form>
				<!-- section -->
				<div class="section a2">
					<div class="tableTitle">
						<div class="left">${dateText }</div>
					</div>
					<div class="tableType1">
						<table id="statisticsTable">
							<caption>거주지별통계 그래프</caption>
							<colgroup>
								<col width="10%" />
								<col width="8%" />
								<col width="8%" />
								<col width="*" />
							</colgroup>
							<thead>
								<tr>
									<th scope="row">요일</th>
									<th scope="row">브랜드</th>
									<th scope="row">접속수</th>
									<th scope="row">그래프</th>
								</tr>
							</thead>
							<tfoot>
								<tr class="txtBold">
									<th scope="col" colspan="2">합계</th>
									<td class="tdBg"><fmt:formatNumber value="${tot }" pattern="###,###"/></td>
									<td class="tdBg"></td>
								</tr>
							</tfoot>
							<tbody>
								<c:choose>
									<c:when test="${not empty statisticsConnList}">
										<c:forEach var="list" items="${statisticsConnList}" varStatus="stat">
											<c:forEach var="brand" items="${list.brand}" varStatus="stat">
											<tr>
												<td>${list.period}</td>
												<td>${brand.brandNm}</td>
												<td><fmt:formatNumber value="${brand.brandTot}" pattern="###,###"/></td>
												<td><span class="graphArea">
												<c:choose>
													<c:when test="${stat.index mod 2 == 0 }">
														<c:set var="cssClass" value="barRed" />
													</c:when>
													<c:otherwise>
														<c:set var="cssClass" value="barBlue" />
													</c:otherwise>
												</c:choose>
												<span class="<c:if test="${brand.brandNm != '합계'}">${cssClass }</c:if>" style="width: ${brand.brandTot div 1000}%; max-width:100%;"></span></span></td>
											</tr>
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->
				
				<!--[s] 엑셀 다운로드 -->
				<div class="paging">
					<div class="right">
						<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
					</div>
				</div>
				<!--[e] 엑셀 다운로드 -->
				
			</div>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->
	</div>
</body>
</html>