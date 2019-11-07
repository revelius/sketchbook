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
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/plugins/jqplot.barRenderer.min.js"></script>
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/plugins/jqplot.highlighter.min.js"></script>
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/plugins/jqplot.cursor.min.js"></script>
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/plugins/jqplot.pointLabels.min.js"></script>
	<script type="text/javascript" src="/resources/common/jqplot.1.0.8/plugins/jqplot.categoryAxisRenderer.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/common/jqplot.1.0.8/jquery.jqplot.min.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${not empty salesList}">
			$.jqplot.config.enablePlugins = true;
	        var s1 = [
						<c:forEach items="${salesList}" var="sales" varStatus="listCount">
							${sales.sumPrc },
						</c:forEach>                  
	                  ];
	        var ticks = [
	                     <c:forEach items="${salesList}" var="sales" varStatus="listCount">
	                  		'${sales.ordDts }',
	                  	</c:forEach>
	                     ];
	         
	        plot1 = $.jqplot('chart1', [s1], {
	            // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
	            animate: !$.jqplot.use_excanvas,
	            seriesDefaults:{
	                renderer:$.jqplot.BarRenderer,
	                pointLabels: { show: true }
	            },
	            axes: {
	                xaxis: {
	                    renderer: $.jqplot.CategoryAxisRenderer,
	                    ticks: ticks
	                },
	                yaxis: { 
	                    tickOptions: { 
	                        formatString: "￦%'d"  
	                    }
	                }
	                        
	            },
	            highlighter: { show: false }
	        });
	     
	        $('#chart1').bind('jqplotDataClick', 
	            function (ev, seriesIndex, pointIndex, data) {
	                //$('#info1').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	            }
	        );
		</c:if>
        
    });
	</script>
		
	<script type="text/javascript">
		 $(function() {
			// 앵커태그 void로 치환
			$("a[href=#]").attr("href", "javascript:void(0);");

			// 브랜드선택시 해당 앵커태그에 class 변경
			if( $("#siteNo").val() != "" && $("#siteNo").val() != null ){
		    	$("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
		    	$("#depth").css("display","");
			}else{
				$("a[data-brand='brand'][id='']").attr("class", "current");
				$("#depth").css("display","none");
			}
			
		    // datepicker 
			$( ".datepicker1, .datepicker2" ).datepicker({
				inline: true, 
				dateFormat: "yy.mm.dd",    /* 날짜 포맷 */ 
				showOn: "both", 
				buttonImage: "<c:url value='/resources/admin/images/common/icon_calender.gif'/>",
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
			
			 /*★★★★★ 기간 검색조건 START ★★★★★*/
		    if($("#searchStrDtm").val() == ""){//default기간 셋팅
		    	setSearchPeriod("set1");
		    }
		    
		    $('#sortTr a').each(function() {
				if ( $('#orderBy').val() == $(this).attr("id") && $('#orderFlag').val() == "ASC" ) {
					$(this).html("▼");
					$(this).removeClass("up");
					$(this).addClass("down");
				}else{
					$(this).html("▲");
					$(this).removeClass("down");
					$(this).addClass("up");
				}
			});
			 
		    //기간검색 이벤트 추가
		    $("a[href=#]").attr("href", "javascript:void(0);");
		    $('#set1').on('click', function(e){ setSearchPeriod("set1"); });
		    $('#set2').on('click', function(e){ setSearchPeriod("set2"); });
		    $('#set3').on('click', function(e){ setSearchPeriod("set3"); });
		    $('#set4').on('click', function(e){ setSearchPeriod("set4"); });
		    $('#set5').on('click', function(e){ setSearchPeriod("set5"); });
		    $('#set6').on('click', function(e){ setSearchPeriod("set6"); });
		    $('#set7').on('click', function(e){ setSearchPeriod("set7"); });
		    
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
	            $('select').find('option:first').attr('selected', 'selected');
		    });
		    
		    //기간설정
		    setSearchPeriod = function(pCode){
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
		    setdate = function(gubun,period){
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

			//정렬기준
			setOrderBy = function(obj) {
				var $this	= $(obj);
				$('#orderBy').val($this.attr("id"));
				if ( $this.hasClass("up") ) {
					$('#orderFlag').val("ASC");
				}else{
					$('#orderFlag').val("DESC");
				}
				goSubmit();		
			};

		    //페이징 처리
		    paging = function(page) {
		        document.getElementById("page").value = page;
		        goSubmit();
		    };
		    
		    //검색
		    goSubmit = function(){
				var frm = document.searchForm;
				
				frm.action = "<c:url value='/admin/statistics/salesGraphStatistics'/>";
				frm.submit();
		    };
		    
		  	//브랜드 선택
		    setSite= function(e){
		    	var $target = $(e);
		    	var siteNo = $target.attr('id');
		    	$("#siteNo").val(siteNo);
		    	$('#btn_search').click();
		    };
		    
		  	//결과 갯수 셋팅
			doNumList = function() {
				$('#btn_search').click();
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
				
			<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="excel" id="excel"/>
			<form:hidden path="siteNo" id="siteNo" value="" />
			<form:hidden path="page" id="page" />
			<form:hidden path="orderBy" id="orderBy"/>
			<form:hidden path="orderFlag" id="orderFlag"/>
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 매출통계 &gt; 전체매출통계 </h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 매출 통계는 배송완료 기준입니다.</li> -->
<!-- 						<li>- 전체 현황과 각 브랜드 별 매출에 대한 상세 검색이 가능합니다.</li> -->
<!-- 						<li>- 결제건수는 소비자 입금(신용카드, 핸드폰, 계좌이체, 가상계좌)한 입금일자 기준의 합계입니다.</li> -->
<!-- 						<li>- 취소건수는 소비자 또는 관리자에 의해 주문 취소된 합계입니다.</li> -->
<!-- 						<li>- 포인트적립은 상품 주문 결제시 발생된 포인트를 배송완료시점의 합계입니다.</li> -->
<!-- 						<li>- 포인트사용은 상품 주문 결제시 사용한 포인트 합계입니다.</li> -->
<!-- 						<li>- 결제금액은 결제 완료된 주문의 주문금액[(판매가+옵션가)x수량)-회원할인금-포인트사용+선배송비]으로 주문완료일자 기준의 총합계 금액입니다.</li> -->
<!-- 						<li>- 총매출은 배송 완료된 주문의 주문금액 [((판매가+옵션가)×수량)-회원할인금-포인트사용+선배송비]으로 배송완료일자 기준의 총합계 금액입니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- tabWrap -->
				<div class="tabWrap">
					<ul class="tabList">
						<c:choose>
							<c:when test="${not empty siteList}">
								<li><a href="#" onclick="setSite(this);" data-brand="brand" id="">전체</a></li>
								<c:forEach items="${siteList}" var="site" varStatus="listCount">
									<li><a href="#" onclick="setSite(this);" data-brand="brand" id="${site.siteNo}">${site.siteNm}</a></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</ul>
					<div class="tabConWrap">
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
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
											<td rowspan="4" class="bd_left">
												<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
												<a href="#" id="btn_reset" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>결제</th>
											<td>
												<div class="wrap">
<%-- 													<form:checkbox path="payWays" value="" id="payWay1" /><label for="payWay1">전체</label> --%>
													<c:forEach items="${payWayList}" var="payWay" varStatus="payWayCount">
														<form:checkbox path="payWays" value="${payWay.cdNo}" id="payWay${payWayCount.count+1}"/><label for="payWay${payWayCount.count+1}">${payWay.cdNm}</label>
													</c:forEach>
												</div>
											</td>
										</tr>
										<tr>
											<th>접속디바이스</th>
											<td>
												<div class="wrap">
													<form:checkbox path="web" id="web"/><label for="web">WEB</label>
													<form:checkbox path="mobile" id="mobile"/><label for="mobile">MOBILE</label>
												</div>
											</td>
										</tr>										
										<tr id="depth" style="display:none;">
											<th>분류</th>
											<td>
												<form:select path="brand">
													<form:option value="">1차 분류</form:option>
													<form:options items="${brandDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
												<form:select path="oneDepth">
													<form:option value="">2차 분류</form:option>
													<form:options items="${oneDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
												<form:select path="twoDepth">
													<form:option value="">3차 분류</form:option>
													<form:options items="${twoDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
												<form:select path="threeDepth">
													<form:option value="">4차 분류</form:option>
													<form:options items="${threeDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
											</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<th>상품</th> -->
<!-- 											<td><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td> -->
<!-- 										</tr> -->
									</tbody>
								</table>
							</div>
							<br/>
							<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
							<div class="" id="chart1" >

							</div>
							<!-- //grap -->										
							
							<div class="section a2">
								<div class="tableTitle">
									<div class="left">${dateText }</div>
									<div class="right">
<!-- 										<a href="#" class="btnType2">Graph</a> -->
<!-- 										<a href="#" class="btnType2">List</a> -->
										<form:select path="searchCount" onchange="javascript:doNumList();">
											<form:option value="">선택</form:option>
											<form:option value="10">10개 보기</form:option>
											<form:option value="30">30개 보기</form:option>
											<form:option value="50">50개 보기</form:option>
											<form:option value="100">100개 보기</form:option>
											<form:option value="200">200개 보기</form:option>
										</form:select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr id="sortTr">
													<th scope="row">일자 <a id="ORD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">주문건수 <a id="ORD_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">결제건수 <a id="ACTL_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">취소건수 <a id="CANCEL_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">포인트적립 <a id="EXP_PNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">포인트사용 <a id="USE_PNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">배송비 <a id="ACTL_DLV_CST" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">결제금액 <a id="ACTL_PAY_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">총매출 <a id="SUM_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${not empty salesList}">
														<c:forEach items="${salesList}" var="sales" varStatus="listCount">
															<tr>
																<td>${sales.ordDts }</td>
																<td>${sales.ordCnt }</td>
																<td>${sales.actlCnt }</td>
																<td>${sales.cancelCnt }</td>
																<td><fmt:formatNumber type="currency" value="${sales.expPnt }" pattern="###,###" /></td>
																<td><fmt:formatNumber type="currency" value="${sales.usePnt }" pattern="###,###" /></td>
																<td><fmt:formatNumber type="currency" value="${sales.actlDlvCst }" pattern="###,###" /></td>
																<td><fmt:formatNumber type="currency" value="${sales.actlPayPrc }" pattern="###,###" /></td>
																<td><fmt:formatNumber type="currency" value="${sales.sumPrc }" pattern="###,###" /></td>
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="9">
																조회할 항목이 없습니다.
															</td>
														</tr>
													</c:otherwise>
												</c:choose>
											</tbody>
											<tfoot>
												<c:choose>
													<c:when test="${not empty salesList}">
														<c:forEach items="${sumSalesList}" var="sum" varStatus="listCount">
															<tr class="txtBold">	
																<th scope="col">합계</th>
																<td class="tdBg">${sum.ordCnt }</td>
																<td class="tdBg">${sum.actlCnt }</td>
																<td class="tdBg">${sum.cancelCnt }</td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.expPnt }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.usePnt }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.actlDlvCst }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.actlPayPrc }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.sumPrc }" pattern="###,###" /></td>
															</tr>
														</c:forEach>
													</c:when>
												</c:choose>
											</tfoot>
										</table>
									</div>
									
									
									<!--[s] 페이징 -->
									<div class="paging">
									<c:choose>
										<c:when test="${not empty salesList}">
											${pageHtml}
											<div class="right">
												<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
											</div>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
										<div>
											
										</div>
									</div>
									<!--[e] 페이징 -->
									
								</div>
								<!-- //list -->
							</div>
						</div>
					</div>
				</div>
				<!-- //tabWrap -->
			</div>
			<!--[e] contents -->
			</form:form>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>