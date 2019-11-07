<%--
 * =============================================================================
 * 파일명 : /manage/inquiryList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-14
 *
 * 파일 내용 : 고객운영관리 > 1:1문의관리
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
			dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
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
			    $("#inqStrDtm").val(end_date);
			    $("#inqEndDtm").val(start_date);
	    }
	    
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
	    
// 	    if($("#inqStrDtm").val() == ""){
// 	    	setSearchPeriod("set1");
// 	    }
	    
	    
	    $("a[href=#]").attr("href", "javascript:void(0);");
	    
	    $('#set1').on('click', function(e){ setSearchPeriod("set1"); });
	    $('#set2').on('click', function(e){ setSearchPeriod("set2"); });
	    $('#set3').on('click', function(e){ setSearchPeriod("set3"); });
	    $('#set4').on('click', function(e){ setSearchPeriod("set4"); });
	    $('#set5').on('click', function(e){ setSearchPeriod("set5"); });
	    $('#set6').on('click', function(e){ setSearchPeriod("set6"); });
	    $('#set7').on('click', function(e){ setSearchPeriod("set7"); });
	    
	    //정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			goSubmit();		
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
		
		
		//페이징 처리
	    paging = function(page) {
	        var frm = document.schForm;
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
// 	    	 if(formCheck()){
// 	    		 return false;
// 	    	 }
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/manage/inquiryList'/>";
		        frm.submit();
	    };
	    
	    
	    //폼체크
// 	    formCheck = function(){
// 	    	if($('#inqStrDtm').val() == "" || $('#inqEndDtm').val() == ""){
// 	    		alert('조회기간을 입력해 주세요');
// 	    		return true;		
// 	    	}
// 	    	return false;
// 	    };
	    
	    
	    //상세페이지 이동
	    goDetail = function(e){
	    	var $target = $(e);
	    	var cnslNo = $target.attr('data-cnslNo');
	    	var frm = document.hiddenForm;
	    	frm.cnslNo.value = cnslNo;
	    	frm.action = "<c:url value='/admin/manage/inquiryDetail'/>";
	        frm.submit();
	    };
	    
	    
	    //파일다운로드
	    fileExport= function(e){
	    	var $target = $(e);
	    	var fileName = $target.attr('data-file');
	    	
	    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"'/>");
	    };
	    
	    
	    //브랜드 선택
	    setSite= function(e){
	    	var $target = $(e);
	    	var siteNo = $target.attr('id');
	    	$("#siteNo").val(siteNo);
	    	$('#btn_search').click();
	    };
	    
	    
	    
	    
	    
	    //엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$('#btn_search').click();
	    	$("#excel").val("false");
	    });	
	    
	    
	    
	    $("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
    });
    
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
					<jsp:param name="menuFlag" value="manage"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form id="hiddenForm" name="hiddenForm" method="post">
					<input type="hidden" id="cnslNo" name="cnslNo"/>
				</form>
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
							<form:hidden path="excel" id="excel"/>
        					<form:hidden path="page" id="page"/>
        					<form:hidden path="siteNo" id="siteNo"/>
        					<form:hidden path="orderBy" id="orderBy"/>
       						<form:hidden path="orderFlag" id="orderFlag"/>
				<div class="contents">
				<h3><span class="icon1"></span>운영관리 > 고객운영관리 > 1:1문의관리</h3>
				<ul class="tabList">
					<c:choose>
						<c:when test="${not empty siteList}">
							<li><a href="#" onclick="setSite(this);" data-brand="brand" id="">ALL</a></li>
							<c:forEach items="${siteList}" var="site" varStatus="listCount">
								<li><a href="#" onclick="setSite(this);" data-brand="brand" id="${site.siteNo}">${site.siteNm}</a></li>
							</c:forEach>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</ul>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 사용자 문의사항을 확인하실 수 있습니다.</li> -->
<!-- 						<li>- 기간검색은 작성일 기준으로 검색됩니다.</li> -->
<!-- 						<li>- 첫번째 문의사항은 ‘문의’로 표시되며 답변에 대한 문의사항 입력시 ‘재문의’로 표시됩니다.</li> -->
<!-- 						<li>- 첨부파일 선택시 다운로드 됩니다.</li> -->
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
									<col width="130px">
									<col width="250px">
									<col width="120px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">기간</th>
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
												<form:input path="inqStrDtm" id="inqStrDtm" readonly="true" cssClass="datepicker1"/> ~
												<form:input path="inqEndDtm" id="inqEndDtm" readonly="true" cssClass="datepicker2"/>
											</div>
										</td>
										<td rowspan="3" class="bd_left">
											<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
											<a href="#" id="btn_reset" class="btnType1">초기화</a>
										</td>
									</tr>
									<tr>
										<th scope="col">회원</th>
										<td>
											<form:select path="memGb">
												<form:option value="name">이름</form:option>
												<form:option value="email">email</form:option>
											</form:select>
											<form:input path="member" id="member" type="text" class="wd_200" />
										</td>
										<th scope="col">답변</th>
										<td>
											<form:select path="replGb">
												<form:option value="">전체</form:option>
												<form:option value="y">답변</form:option>
												<form:option value="n">미답변</form:option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th scope="col">검색</th>
										<td colspan="3">
											<form:select path="searchGb">
												<form:option value="title">제목</form:option>
												<form:option value="content">내용</form:option>
												<form:option value="all">제목+내용</form:option>
											</form:select>										
											<form:input type="text" path="searchText" id="searchText" class="wd_300" />
										</td>
									</tr>
								</tbody>
							</table>
						
					</div>
				</div>
				<!-- //section -->
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<div class="tableTitle">
						<div class="right">
							<form:select path="searchCount" onchange="javascript:doNumList();">
								<form:option value="15">15개 보기</form:option>
								<form:option value="30">30개 보기</form:option>
								<form:option value="50">50개 보기</form:option>
								<form:option value="100">100개 보기</form:option>
							</form:select>
						</div>
					</div>
					<div class="tableType1">
						<table>
							<caption>전체매출통계</caption>
							<colgroup>
								<col style="width: 6%" />
								<col style="width: 9%" />
								<col style="width: *" />
								<col style="width: 5%" />
								<col style="width: 8%" />
								<col style="width: 13%" />
								<col style="width: 11%" />
								<col style="width: 10%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th scope="row">No </th>
									<th scope="row">문의 </th>
									<th scope="row">제목 </th>
									<th scope="row">첨부파일</th>
									<th scope="row">이름 </th>
									<th scope="row">이메일 </th>
									<th scope="row">작성일 <a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">답변여부 <a id="CNSL_STAT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>	
							<c:choose>
								<c:when test="${not empty inquiryList}">
									<c:forEach items="${inquiryList}" var="inquiry" varStatus="listCount">
										<tr>	
											<td>${inquiry.rnum}</td>
											<td>문의</td>
											<td class="ta_l"><a href="#" onclick="javascript:goDetail(this);" data-cnslNo="<c:out value='${inquiry.cnslNo}'/>">${inquiry.title}</a></td>
											<td>
												<c:if test="${inquiry.atchFile != null}">
													<a href="#" data-file="<c:out value='${inquiry.atchFile}'/>" onclick="javascript:fileExport(this);" id="fileExport"><img src="<c:url value='/resources/admin/images/common/file.jpg'/>" alt="첨부파일"></a>
												</c:if>
											</td>
											<td>${inquiry.memNm}</td>
											<td>${inquiry.email}</td>
											<td>${inquiry.updDts}</td>
											<td>${inquiry.cnslStat}</td>
										</tr>
									</c:forEach>
									</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8">
											조회할 항목이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
					<!--[s] 페이징 -->
					<c:choose>
						<c:when test="${not empty inquiryList}">
						<div class="paging">
							${pageHtml}
							<div class="right">
								<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
							</div>
						</div>
						</c:when>
					</c:choose>
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