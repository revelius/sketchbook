<%--
 * =============================================================================
 * 파일명 : /manage/mailSendList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : 메일발송리스트 
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
    	
    	//리스트 검색 공통
	    $('#btn_search').click(function() {
			$("#page").val("1");
	    	goSubmit();
	    });
		
		//검색 초기화 버튼
	    $('#btn_reset').click(function() {
	    	$("input[type='checkbox']").attr("checked", false);//checkbox초기화
	    	$("input[type='text']").val("");//textbox초기화
//             setSearchPeriod("set1");//달력 초기화
            $('select').find('option:first').attr('selected', 'selected');//selectbox초기화
	    });
	  	
		//정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			$('#btn_search').trigger('click');
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
		
    	// datepicker 
		$( ".datepicker1, .datepicker2" ).datepicker({
			inline: true, 
			dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
			showOn: "both", 
			buttonImage: "${pageContext.request.contextPath}/resources/admin/images/common/icon_calender.gif", 
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
		
		//페이징처리
		paging = function(page) {
			$('#page').val(page);
			goSubmit();
		};
		
		//결과 갯수 셋팅
		doNumList = function() {
			goSubmit();
		};
		
		//상세페이지 이동
	    goDetail = function(e){
	    	var $target = $(e);
	    	var sndNo = $target.attr('data-sndHistNo');

	    	$("#siteNo").val(sndNo);
	    	
	    	$("#schForm").attr("action","<c:url value='/admin/manage/mailSendDetail'/>");
	    	$("#schForm").submit();
	    };
		
	  	//엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$('#btn_search').click();
	    	$("#excel").val("false");
	    });	
		
		 /*★★★★★ 기간 검색조건 START ★★★★★*/
// 	    if($("#inqStrDtm").val() == ""){//default기간 셋팅
// 	    	setSearchPeriod("set1");
// 	    }
	    
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
	    }
	    /*★★★★★ 기간 검색조건 END ★★★★★*/

	    //검색
	    goSubmit = function(){
			var frm = document.schForm;
			frm.action = "<c:url value='/admin/manage/mailSendList'/>";
			frm.submit();
	    };
	    
    });
	</script>
</head> 
<body>
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
					<jsp:param name="menuFlag" value="manage"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div id="container">		
			<!--[s] contents -->
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
				<form:hidden path="excel" id="excel"/>
				<form:hidden path="page" id="page"/>
				<form:hidden path="siteNo" id="siteNo"/>
				<form:hidden path="orderBy" id="orderBy"/>
				<form:hidden path="orderFlag" id="orderFlag"/>
			<div class="contents">
				<h3><span class="icon1"></span>운영관리 &gt; 메일발송관리 &gt; 발송내역</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 이메일 발송내역을 확인하실 수 있습니다.</li> -->
<!-- 						<li>- 기간검색은 발송일 기준으로 검색됩니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<div class="tableType2">
						<table>
							<caption>배송검색</caption>
							<colgroup>
								<col width="130px">
								<col width="*">
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
											<span class="dateinput"><form:input path="searchStrDtm" id="searchStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
											<span class="dateinput"><form:input path="searchEndDtm" id="searchEndDtm" readonly="true" cssClass="datepicker2"/></span>				
										</div>
									</td>
									<td rowspan="3" class="bd_left">
										<a href="#" class="btnType2" id="btn_search">검색</a> <br /><br />
										<a href="#" class="btnType1" id="btn_reset">초기화</a>
									</td>
								</tr>
								<tr>
									<th scope="col">기간</th>
									<td>
										<form:select path="searchGb" id="searchGb" name="searchGb">
											<form:option value="">선택</form:option>
											<form:option value="email">이메일</form:option>
											<form:option value="title">제목</form:option>
											<form:option value="content">내용</form:option>
											<form:option value="all">제목+내용</form:option>
										</form:select>
										<form:input path="searchText" cssClass="wd_300"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //section -->
				<!-- section -->
				<div class="section a2">
					<div class="tableTitle">
						<div class="right">
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
					<div class="tableType1">
						<table>
							<caption>발송내역</caption>
							<colgroup>
								<col style="width: 6%" />
								<col style="width: *" />
								<col style="width: 15%" />
								<col style="width: 10%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th scope="row">No </th>
									<th scope="row">제목 <a id="TITLE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">발송일 <a id=UPD_DTS href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">자세히</th>
								</tr>
							</thead>
							<tbody>	
								<c:choose>
									<c:when test="${not empty mailManageList}">
										<c:forEach items="${mailManageList}" var="mail" varStatus="listCount">
											<tr>
												<td>${mail.rnum}</td>	
												<td class="ta_l">${mail.title}</td>
												<td>${mail.sndDts}</td>
												<td><a href="#" class="btnType1" onclick="javascript:goDetail(this);" data-sndHistNo="<c:out value='${mail.sndHistNo}'/>">상세</a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4">
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
						<c:when test="${not empty mailManageList}">
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
				<!-- //section -->
			</div>
			</form:form>
				<!--[e] contents -->
			</div>
		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>