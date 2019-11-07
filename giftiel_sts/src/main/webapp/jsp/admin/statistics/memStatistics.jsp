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
	<script type="text/javascript">
		 $(function() {

			$("#sido").val("${param.sido }").attr('selected', 'selected');
// 			<c:if test="${param.sido != null && param.sido != ''}">
	 			gugunChange();		 					
				$("#gugun").val("${param.gugun }").attr('selected', 'selected');
			</c:if>
			
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
				frm.action = "<c:url value='/admin/statistics/memStatistics'/>";
				frm.submit();
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
			
			//시도 선택
			$("#sido").change(function(){
				gugunChange();
			});
		 });
		 
		 function gugunChange(){
			if($("#sido").val() != ""){
				 
				$.ajax({
			        url : "<c:url value='/admin/statistics/residenceStatisticsAjax'/>",
			        type: "POST",
			        data : $('form#searchForm').serialize(),
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
			 }else{
				 var str = "<option value=''>시군구-전체</option>";
				 $("#gugun").html(str);
			 }
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

			<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="excel" id="excel"/>
			<form:hidden path="page" id="page" />
			<form:hidden path="orderBy" id="orderBy"/>
			<form:hidden path="orderFlag" id="orderFlag"/>
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>통계/분석 &gt; 매출통계 &gt; 회원별매출통계</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 일반/SNS/매장 회원의 온라인 구매에 따른 매출통계입니다.</li> -->
<!-- 						<li>- 판매수는 배송완료일자 기준의 합계입니다.</li> -->
<!-- 						<li>- 수량은 판매된 상품(옵션포함)의 총 합계입니다.</li> -->
<!-- 						<li>- 총매출은 배송 완료된 주문의 주문금액 [((판매가+옵션가)×수량)-회원할인금-포인트사용+선배송비]으로 배송완료일자 기준의 총합계 금액입니다.</li> -->
<!-- 						<li>- 포인트적립은 배송완료일 기준의 합계입니다.</li> -->
<!-- 						<li>- 포인트사용은 주문일 기준의 합계입니다.</li> -->
<!-- 						<li>- 환불금액은 처리일 기준의 합계 입니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<div class="first">
					<div class="tableType2">
						<table>
							<caption>배송검색</caption>
							<colgroup>
								<col width="80px">
								<col width="220px">
								<col width="80px">
								<col width="220px">
								<col width="80px">
								<col width="220px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">기간</th>
									<td colspan="5">
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
									<td rowspan="5" class="bd_left">
										<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
										<a href="#" id="btn_reset" class="btnType1">초기화</a>
									</td>
								</tr>
								<tr>
									<th scope="col">등급</th>
									<td>
										<form:select path="memGrdNo">
											<form:option value="">전체</form:option>
											<c:forEach items="${memberGradeList}" var="grade" varStatus="listCount">
												<form:option value="${grade.memGrdNo }">${grade.grdNm }</form:option>
											</c:forEach>
											<form:option value="99999999">비회원</form:option>
										</form:select>
									</td>
									<th scope="col">성별</th>
									<td colspan="3">
										<form:select path="sex">
											<form:option value="">전체</form:option>
											<form:option value="M">남자</form:option>
											<form:option value="W">여자</form:option>
										</form:select>
									</td>
								</tr>
								<tr>
									<th scope="col">나이</th>
									<td>
										<form:select path="sAge" cssClass="secletW50">
											<form:option value="">전체</form:option>
											<c:forEach begin="1" end="99" step="1" var="cnt">
												<form:option value="${cnt }">${cnt }</form:option>
											</c:forEach>
										</form:select>
										~
										<form:select path="eAge" cssClass="secletW50">
											<form:option value="">전체</form:option>
											<c:forEach begin="1" end="99" step="1" var="cnt">
												<form:option value="${cnt }">${cnt }</form:option>
											</c:forEach>
										</form:select>
									</td>
									<th scope="col">지역</th>
									<td colspan="3">
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
								</tr>
								<tr>
									<th scope="col">회원</th>
									<td colspan="5">
										<form:select path="searchGb">
											<form:option value="TB_MEMBER.NM">회원명</form:option>
											<form:option value="TB_MEMBER.EMAIL">email</form:option>
										</form:select>
										<form:input path="searchText" cssClass="searchBar"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="section a2">
					<div class="tableTitle">
						<div class="left">${dateText }</div>
						<div class="right">
<!-- 						<a href="#" class="btnType2">Graph</a> -->
<!-- 						<a href="#" class="btnType2">List</a> -->
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
									<col style="width: 6%" />
									<col style="width: 10%" />
									<col style="width: 16%" />
									<col style="width: 5%" />
									<col style="width: 5%" />
									<col style="width: 6%" />
									<col style="width: 5%" />
									<col style="width: *" />
								</colgroup>
								<thead>
									<tr id="sortTr">
										<th scope="row">구분 <a id="MEM_GRD_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">회원명<a id="NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">Email 계정 <a id="EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">주소 <a id="ORDR_BS_ADDR" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">나이 <a id="AGE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">성별 <a id="SEX" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">판매수 <a id="ORD_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
<!-- 										<th scope="row">수량 <a id="BRNDNM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th> -->
										<th scope="row">총매출 <a id="SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">환불금액 <a id="CANCEL_SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
										<th scope="row">포인트적립 <a id="EXP_PNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
<!-- 										<th scope="row" rowspan="2">그래프 <a href="#" class="down">▼</a></th> -->
									</tr>
								</thead>
								<tfoot>
									<c:choose>
										<c:when test="${not empty memStatistics}">
											<c:forEach items="${sumMemStatistics}" var="sum" varStatus="listCount">
												<tr class="txtBold">
													<td class="tdBg" colspan="6">합계</td>
													<td class="tdBg">${sum.ordCnt }</td>
													<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.slPrc }" pattern="###,###" /></td>
													<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.cancelSlPrc }" pattern="###,###" /></td>
													<td class="tdBg"><fmt:formatNumber type="currency" value="${sum.expPnt }" pattern="###,###" /></td>
												</tr>
											</c:forEach>
										</c:when>
									</c:choose>
								</tfoot>
								<tbody>	
									<c:choose>
										<c:when test="${not empty memStatistics}">
											<c:forEach items="${memStatistics}" var="mem" varStatus="listCount">
												<tr>
													<td>${mem.memGrdNo}</td>
													<td>${mem.nm }</td>
													<td>${mem.email }</td>
													<td>${mem.ordrBsAddr }</td>
													<td>${mem.age }</td>
													<td>${mem.sex }</td>
													<td>${mem.ordCnt }</td>
													<td><fmt:formatNumber type="currency" value="${mem.slPrc }" pattern="###,###" /></td>
													<td><fmt:formatNumber type="currency" value="${mem.cancelSlPrc }" pattern="###,###" /></td>
													<td><fmt:formatNumber type="currency" value="${mem.expPnt }" pattern="###,###" /></td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="11">
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
							<c:when test="${not empty memStatistics}">
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
			<!--[e] contents -->
			</form:form>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>