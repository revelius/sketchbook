<%--
 * =============================================================================
 * 파일명 : /manage/workWithUsList.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-06
 *
 * 파일 내용 : 고객운영관리 > WORK WITH US
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
	    
	    $("a[href=#]").attr("href", "javascript:void(0);");
	    
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
		        frm.action = "<c:url value='/admin/manage/workWithUsList'/>";
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
	    	var withusSeq = $target.attr('data-withusSeq');
	    	var frm = document.hiddenForm;
	    	frm.withusSeq.value = withusSeq;
	    	frm.type.value = "Modify";
	    	frm.hiddenSiteNo.value = $("#siteNo").val();
	    	frm.hiddenStrDtm.value = $("#searchStrDtm").val();
	    	frm.hiddenEndDtm.value = $("#searchEndDtm").val();
	    	frm.hiddenNewsType.value = $("#newsType").val();
	    	frm.hiddenSearchGb.value = $("#searchGb").val();
	    	frm.hiddenSearchText.value = $("#searchText").val();
	    	frm.action = "<c:url value='/admin/manage/workWithUsDetail'/>";
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
	    
	    //등록
	    $('#btn_reg').click(function() {
	    	var frm = document.hiddenForm;
	    	frm.action = "<c:url value='/admin/manage/regWorkWithUs'/>";
	    	frm.submit();
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
					<input type="hidden" id="withusSeq" name="withusSeq"/>
					<input type="hidden" id="type" name="type"/>
					<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo"/>
					<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm"/>
					<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm"/>
					<input type="hidden" id="hiddenNewsType" name="hiddenNewsType"/>
					<input type="hidden" id="hiddenSearchGb" name="hiddenSearchGb"/>
					<input type="hidden" id="hiddenSearchText" name="hiddenSearchText"/>
				</form>
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
					<form:hidden path="excel" id="excel"/>
					<form:hidden path="page" id="page"/>
					<form:hidden path="siteNo" id="siteNo"/>
					<form:hidden path="orderBy" id="orderBy"/>
					<form:hidden path="orderFlag" id="orderFlag"/>
				<div class="contents">
				<h3><span class="icon1"></span>운영관리 &gt; 고객운영관리 &gt; WORK WITH US</h3>
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
											<div class="wrap">
												<form:input path="searchStrDtm" id="searchStrDtm" name="searchStrDtm" readonly="true" cssClass="datepicker1" /> ~
												<form:input path="searchEndDtm" id="searchEndDtm" name="searchEndDtm" readonly="true" cssClass="datepicker2" />
											</div>
										</td>
										<td rowspan="3" class="bd_left">
											<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
											<a href="#" id="btn_reset" class="btnType1">초기화</a>
										</td>
									</tr>
									<tr>
										<th scope="col">검색</th>
										<td colspan="3">
											<form:select path="searchGb">
												<form:option value="cls">구분</form:option>
												<form:option value="area">지역</form:option>
												<form:option value="cl">모집분야</form:option>
												<form:option value="regr">작성자</form:option>
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
							<caption>Work With Us</caption>
							<colgroup>
								<col style="width: 6%" />
								<col style="width: 6%" />
								<col style="width: *" />
								<col style="width: 19%" />
								<col style="width: 8%" />
								<col style="width: 15%" />
								<col style="width: 7%" />
								<col style="width: 12%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th scope="row">No <a id="RNUM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">상태 <a id="WITHUS_STAT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">구분 <a id="WITHUS_CLS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">지역 <a id="WITHUS_AREA" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">모집분야 <a id="WITHUS_CL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">기간 <a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">작성자 <a id="REGR_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">작성일 <a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>	
							<c:choose>
								<c:when test="${not empty workWithUsList}">
									<c:forEach items="${workWithUsList}" var="workWithUs" varStatus="listCount">
										<tr>	
											<td>${workWithUs.rnum}</td>
											<td>${workWithUs.withusStat}</td>
											<td class="ta_l"><a href="#" onclick="javascript:goDetail(this);" data-withusSeq="<c:out value='${workWithUs.withusSeq}'/>">${workWithUs.withusCls}</a></td>
											<td>${workWithUs.withusArea}</td>
											<td>${workWithUs.withusCl}</td>
											<td>${workWithUs.strDts} ~ ${workWithUs.endDts}</td>
											<td>${workWithUs.regUserNm}</td>
											<td>${workWithUs.updDts}</td>
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
					<div class="paging">
					<c:choose>
						<c:when test="${not empty workWithUsList}">
							${pageHtml}
							<div class="right">
								<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
								<a href="#" class="btnType2" id="btn_reg">등록</a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="right">
								<a href="#" class="btnType2" id="btn_reg">등록</a>
							</div>
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