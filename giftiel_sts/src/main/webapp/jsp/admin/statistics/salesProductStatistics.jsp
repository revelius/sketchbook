<%--
 * =============================================================================
 * 파일명 : /statistics/salesProductStatistics.jsp
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
			 
			$("#searchText").val("${param.searchText}");
			$("#ubiGdsNo").val("${param.ubiGdsNo}");

			if( $("#searchText").val() != "" && $("#searchText").val() != null ) {
			 	$("#inGoodCode").html("<span id='fNm'>${param.searchText}</span> <a href='javascript:removeFind();' id='cls'>X</a>");
		 	}
			
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
	            removeFind("fNm");
		    });
			
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
			
		 	// 앵커태그 void로 치환
			$("a[href=#]").attr("href", "javascript:void(0);");
		 	
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

			//정렬기호변경 및 class 변경
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
		    
			// 브랜드선택시 해당 앵커태그에 class 변경
			if( $("#siteNo").val() != "" && $("#siteNo").val() != null ){
		    	$("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
		    	$("#depth").css("display","");
			}else{
				$("a[data-brand='brand'][id='']").attr("class", "current");
				$("#depth").css("display","none");
			}

			 /*★★★★★ 기간 검색조건 START ★★★★★*/
		    if($("#searchStrDtm").val() == ""){//default기간 셋팅
		    	setSearchPeriod("set1");
		    }
			 
		    //기간검색 이벤트 추가
		    $('#set1').on('click', function(e){ setSearchPeriod("set1"); });
		    $('#set2').on('click', function(e){ setSearchPeriod("set2"); });
		    $('#set3').on('click', function(e){ setSearchPeriod("set3"); });
		    $('#set4').on('click', function(e){ setSearchPeriod("set4"); });
		    $('#set5').on('click', function(e){ setSearchPeriod("set5"); });
		    $('#set6').on('click', function(e){ setSearchPeriod("set6"); });
		    $('#set7').on('click', function(e){ setSearchPeriod("set7"); });
		    
		    
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
		    

		    //페이징 처리
		    paging = function(page) {
		    	$('#page').val(page);
				goSubmit();
		    };
		    
		    //검색
		    goSubmit = function(){
				var frm = document.searchForm;				
				frm.action = "<c:url value='/admin/statistics/salesProductStatistics'/>";
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
			
			// 상품 팝업
			goodsPopup = function(resultId) {
				var popUrl = "<c:url value='/admin/popup/goods/popupGoodsListForStatistics'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
				var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
					window.open(popUrl,"productPopup",popOption);
			};
			
			//검색상품명 삭제
			removeFind = function(){
				$("#fNm").remove();
				$("a#cls").remove();
				$("#searchText").val("");
		    	$("#ubiGdsNo").val("");
			};
			
			//상품팝업에서 호출함
		    callback_setGoods = function(goodsData, resultId){
		    	var goodsNo = goodsData.split(":")[0];
		    	var goodsName = goodsData.split(":")[1];

		    	$("#"+resultId).html("<span id='fNm'>"+goodsName+"</span> <a href='javascript:removeFind();' id='cls'>X</a>");
		    	$("#searchText").val(goodsName);
		    	$("#ubiGdsNo").val(goodsNo);
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
			<form:hidden path="searchText" id="searchText"/>
			<form:hidden path="ubiGdsNo" id="ubiGdsNo" />
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 매출통계 &gt; 상품별매출통계</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 총매출은 배송 완료된 주문의 주문금액 [((판매가+옵션가)×수량)-회원할인금-포인트사용+선배송비]으로 배송완료일자 기준의 총합계 금액입니다.</li> -->
<!-- 						<li>- 판매순위는 검색된 내용 중 총매출에 대한 순위입니다.</li> -->
<!-- 						<li>- 판매수/취소수/반품수/환불수취소금액/반품금액/환불금액 은 처리일 기준의 합계 입니다.</li> -->
<!-- 						<li>- 포인트적립은 배송완료일 기준의 합계입니다.</li> -->
<!-- 						<li>- 포인트사용은 주문일 기준의 합계입니다.</li> -->
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
											<c:if test="${searchForm.siteNo eq 10001}">
												<th>브랜드</th>
												<td>
													<form:select path="brand">
														<form:option value="">전체</form:option>
														<form:options items="${brandDepth}" itemLabel="cateNm" itemValue="cateCd"/>
													</form:select>
												</td>
											</c:if>
											
											<td rowspan="5" class="bd_left">
												<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
												<a href="#" id="btn_reset" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td <c:if test="${searchForm.siteNo eq 10001}">colspan="3"</c:if>>
												<form:select path="oneDepth">
													<form:option value="">1차 분류</form:option>
													<form:options items="${oneDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
												<form:select path="twoDepth">
													<form:option value="">2차 분류</form:option>
													<form:options items="${twoDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
												<form:select path="threeDepth">
													<form:option value="">3차 분류</form:option>
													<form:options items="${threeDepth}" itemLabel="cateNm" itemValue="cateCd"/>
												</form:select>
											</td>
										</tr>
										<tr>
											<th>사이즈</th>
											<td <c:if test="${searchForm.siteNo eq 10001}">colspan="3"</c:if>>
												<form:select path="ubiGdsSize">
													<form:option value="">전체</form:option>
													<c:forEach items="${goodsSizeList}" var="goodsSize" varStatus="listCount">
														<c:if test="${goodsSize.ubiGoods.ubiGdsSize != null }">
														<form:option value="${goodsSize.ubiGoods.ubiGdsSize }">${goodsSize.ubiGoods.ubiGdsSize }</form:option>
														</c:if>
													</c:forEach>
												</form:select>
											</td>
										</tr>
										<tr>
											<th>상품</th>
<!-- 											<td colspan="3"><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td> -->
											<td <c:if test="${searchForm.siteNo eq 10001}">colspan="3"</c:if> id="find"><a href="javascript:goodsPopup('inGoodCode')" class="btnType1">찾기</a><span id="inGoodCode"></span> </td>
										</tr>
									</tbody>
								</table>
							</div>
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
											<caption>상품 통계</caption>
											<colgroup>
												<col style="width: 4%" />
												<col style="width: 4%" />
												<col style="width: 4%" />
												<col style="width: 4%" />
												<col style="width: 19%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
												<col style="width: 6%" />
											</colgroup>
											<thead>
												<tr id="sortTr">
													<th scope="row" colspan="4">상품분류</th>
													<th scope="row" rowspan="2">상품명 <a id="UBI_GDS_NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">색상 <a id="COLOR" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">사이즈 <a id="UBI_GDS_SIZE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">상품코드 <a id="UBI_GDS_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">총매출 <a id="SUM_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">판매가 <a id="SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">실결제액 <a id="SUM_PAY_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">판매수 <a id="ORD_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">취소수 <a id="CANCEL_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">취소금액 <a id="CANCEL_SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">포인트적립 <a id="EXP_PNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row" rowspan="2">포인트사용 <a id="USE_PNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												</tr>
												<tr id="sortTr">
													<th scope="row">브랜드 <a id="BRNDNM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">1차분류 <a id="SEASONGROUP_CODE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">2차분류 <a id="CATEGORY1_CODE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">3차분류 <a id="CATEGORY2_CODE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												</tr>
											</thead>
											<tfoot>
												<c:choose>
													<c:when test="${not empty salesProductList}">
														<c:forEach items="${sumSalesProductList}" var="sum" varStatus="listCount">
															<tr class="txtBold">
																<td class="tdBg" colspan="8">합계</td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.sumPrc }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.slPrc }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.sumPayPrc }" pattern="###,###" /></td>
																<td class="tdBg">${sum.ordCnt }</td>
																<td class="tdBg">${sum.cancelCnt }</td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.cancelSlPrc }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.expPnt }" pattern="###,###" /></td>
																<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.usePnt }" pattern="###,###" /></td>
															</tr>
														</c:forEach>
													</c:when>
												</c:choose>
											</tfoot>
											<tbody>	
											<c:choose>
												<c:when test="${not empty salesProductList}">
													<c:forEach items="${salesProductList}" var="sales" varStatus="listCount">
														<tr>
															<td>${sales.brndNm }</td>
															<td>${sales.seasonGroupCode }</td>
															<td>${sales.category1Code }</td>
															<td>${sales.category2Code }</td>
															<td>${sales.ubiGdsNm }</td>
															<td>${sales.color }</td>
															<td>${sales.size }</td>
															<td>${sales.ubiGdsNo }</td>
															<td><fmt:formatNumber type="currency" value="${sales.sumPrc }" pattern="###,###" /></td>
															<td><fmt:formatNumber type="currency" value="${sales.slPrc }" pattern="###,###" /></td>
															<td><fmt:formatNumber type="currency" value="${sales.sumPayPrc }" pattern="###,###" /></td>
															<td>${sales.ordCnt }</td>
															<td>${sales.cancelCnt }</td>
															<td><fmt:formatNumber type="currency" value="${sales.cancelSlPrc }" pattern="###,###" /></td>
															<td><fmt:formatNumber type="currency" value="${sales.expPnt }" pattern="###,###" /></td>
															<td><fmt:formatNumber type="currency" value="${sales.usePnt }" pattern="###,###" /></td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="17">
															조회할 항목이 없습니다.
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
											</tbody>
										</table>
									</div>
									
									<!--[s] 페이징 -->
									<div class="paging">
									<c:choose>
										<c:when test="${not empty salesProductList}">
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
								<!-- graph none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
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