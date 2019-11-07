<%--
 * =============================================================================
 * 파일명 : /statistics/statistics.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 통계 거주지별
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
		 	
			
			$("#sido").val("${param.sido }").attr('selected', 'selected');
			<c:if test="${param.sido != null && param.sido != ''}">
	 			gugunChange();		 					
				$("#gugun").val("${param.gugun }").attr('selected', 'selected');
			</c:if>

		 	$("a[href=#]").attr("href", "javascript:void(0);");

			// datepicker 
			$( ".datepicker1, .datepicker2" ).datepicker({
				inline: true, 
				dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
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
			    var start_date = today.getFullYear() + "-" + start_month + "-" + start_day;
		    	
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
			    var end_date = today.getFullYear() + "-" + end_month + "-" + end_day;
				    $("#searchStrDtm").val(end_date);
				    $("#searchEndDtm").val(start_date);
		    };
		    /*★★★★★ 기간 검색조건 END ★★★★★*/

		    //정렬기준
			setOrderBy = function(obj) {
				var $this	= $(obj);
				$('#orderBy').val($this.attr("id"));
				if ( $this.hasClass("up") ) {
					$('#orderFlag').val("DESC");
				}else{
					$('#orderFlag').val("ASC");
				}
				$("#btn_search").trigger("click");
			};
			
			$('#sortTr a').each(function() {
				if ( $('#orderBy').val() == $(this).attr("id") && $('#orderFlag').val() == "DESC" ) {
					$(this).html("▼");
					$(this).removeClass("up");
					$(this).addClass("down");
				}else{
					$(this).html("▲");
					$(this).removeClass("down");
					$(this).addClass("up");
				}
			});

			//리스트 검색 공통
		    $('#btn_search').click(function() {
		        var frm = document.schForm;
// 		        frm.hiddenGugun.value = $("#gugun").val();
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/statistics/residenceStatistics'/>";
		        frm.submit();
		    });
			
		  //검색 초기화 버튼
		    $('#btn_reset').click(function() {
	            $(':input').each(function(index) {
	            	if($(this).attr('type')=="text"){
	            		$(this).val("");
	            	}
	            });
	         	// 당일로 셋팅 후 시작일을 그달에 1일로 변경
	            setSearchPeriod("set1");
	            $('select').find('option:first').attr('selected', 'selected');
	            $('#gugun').html("<option value=''>시군구-전체</option>");
		    });
		  
		  //시도 선택
		  $("#sido").change(function(){
			  gugunChange();
		  	});
		  
		    //엑셀 다운로드
		    $('#btn_excel').click(function() {
		    	$("#excel").val("true");
		    	$('#btn_search').click();
		    	$("#excel").val("false");
		    });	
		  
		  $('#residenceTable').rowspan(0);	// 지역검색시 첫번째 row 병합
		  $('#residenceTable').rowspan(1);	// 전체 검색시 두번재 row 병합
		  
	 	});
	 
	 function gugunChange(){
		  $.ajax({
		        url : "<c:url value='/admin/statistics/residenceStatisticsAjax'/>",
		        type: "POST",
		        data : $('form#schForm').serialize(),
		        async: false,
		        success : function(responseData){
		        	try{
		        		var data = jQuery.parseJSON(responseData);
		        		var str = "<option value=''>시군구-전체</option>";

		        		for (var i=0; i<data.length; i++) {
							str +="<option value='" + data[i].SIGUNGU_NM + "'>" + data[i].SIGUNGU_NM + "</option>";
						}
		        		
						$("#gugun").html(str);

						$("#gugun").val($("#gugun").val()).attr('selected', 'selected');
			        }catch(e){
		        		alert(e);
		        	}
	    	    },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        },
		        complete:function(request,status){
		        	isLoading = false;
		        }
		  });
	  }
	 
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
			<form:form id="schForm" name="schForm" method="POST" modelAttribute="searchForm" onsubmit="">
				<form:hidden path="orderBy" id="orderBy"/>
				<form:hidden path="orderFlag" id="orderFlag"/>
				<form:hidden path="excel" id="excel"/>
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 회원통계 &gt; 거주지별통계</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
				<div class="first">
					<div class="tableType2">
						<table>
							<caption>배송검색</caption>
							<colgroup>
								<col width="100px">
								<col width="*">
								<col width="100px">
								<col width="200px">
								<col width="120px">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">기간</th>
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
									<th scope="col">지역</th>
									<td>
										<form:select path="sido" id="sido">
											<form:option value="">시도-전체</form:option>
											<form:option value="강원">강원</form:option>
											<form:option value="경기">경기</form:option>
											<form:option value="경남">경남</form:option>
											<form:option value="경북">경북</form:option>
											<form:option value="광주">광주</form:option>
											<form:option value="대구">대구</form:option>
											<form:option value="대전">대전</form:option>
											<form:option value="부산">부산</form:option>
											<form:option value="서울">서울</form:option>
											<form:option value="세종특별자치시">세종특별자치시</form:option>
											<form:option value="울산">울산</form:option>
											<form:option value="인천">인천</form:option>
											<form:option value="전남">전남</form:option>
											<form:option value="전북">전북</form:option>
											<form:option value="제주특별자치도">제주특별자치도</form:option>
											<form:option value="충남">충남</form:option>
											<form:option value="충북">충북</form:option>
										</form:select>
										<form:select path="gugun" id="gugun">
											<form:option value="">시군구-전체</form:option>
										</form:select>
									</td>
									<td class="bd_left">
										<a href="#" class="btnType2" id="btn_search">검색</a> <br /><br />
										<a href="#" class="btnType1" id="btn_reset">초기화</a>
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
					</div>
					<div class="tableType1">
						<table id="residenceTable">
							<caption>거주지별통계 그래프</caption>
							<colgroup>
								<col width="12%" />
								<col width="12%" />
								<col width="10%" />
								<col width="10%" />
								<col width="*" />
							</colgroup>
							<thead>
								<tr>
									<th scope="row" colspan="2">지역</th>
									<th scope="row" rowspan="2">회원수</th>
									<th scope="row" rowspan="2">비율</th>
									<th scope="row" rowspan="2">그래프</th>
								</tr>
								<tr id="sortTr">
									<th scope="row">시도 <a id="F_COLUMN" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<c:choose>
										<c:when test="${sido == null && sido == ''}">
											<th scope="row">시군구</th>
										</c:when>
										<c:otherwise>
											<th scope="row">시군구 <a id="GUGUN" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										</c:otherwise>
									</c:choose>
									<c:if test="">
									</c:if>
									<c:if test="${sido != null && sido != '' }">
									</c:if>
								</tr>
							</thead>
							<tfoot>
								<tr class="txtBold">
									<th scope="col" colspan="2">합계</th>
									<c:forEach items="${residenceTotal }" var="residenceTot">
										<td class="tdBg">${residenceTot.visitCnt }</td>
										<td class="tdBg">${residenceTot.totAvg }%</td>										
									</c:forEach>
									<td class="tdBg"></td>
								</tr>
							</tfoot>
							<tbody>
								<c:choose>
									<c:when test="${not empty residenceVisit }">
										<c:forEach items="${residenceVisit}" var="residence" varStatus="listCount">
										<tr>
											<td>${residence.firstColumn }</td>
											<td>${residence.guGun }</td>
											<td>${residence.areaCnt }</td>
											<td>${residence.totAvg }%</td>
											<td><span class="graphArea"><span class="barRed" style="width: ${residence.totAvg }%;max-width:100%">${residence.totAvg }%</span></span></td>
										</tr>
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