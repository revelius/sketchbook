<%--
 * =============================================================================
 * 파일명 : /manage/carharttRadioList.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-08-14
 *
 * 파일 내용 : 칼하트 라디오
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
	        frm.target = '_self';
	        frm.action = "<c:url value='/admin/manage/carharttRadioList'/>";
	        frm.submit();
	    };
	    

	    //등록
	    $('#btn_reg').click(function() {
	    	var frm = document.schForm;
	    	frm.action = "<c:url value='/admin/manage/carharttRadioReg'/>";
	    	frm.submit();
	    });
	    
	    //상세페이지 이동
	    goDetail = function(e){
	    	var $target = $(e);
	    	var radioNo = $target.attr('data-radioNo');
    	
	    	var frm = document.schForm;
	    	$("#radioNo").val(radioNo);
	    	
	    	frm.action = "<c:url value='/admin/manage/carharttRadioDetail'/>";
	    	frm.submit();
	    };	    
	    
	    $("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
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
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
			<!--[s] lnb -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
				<jsp:param name="menuFlag" value="manage"/>
			</jsp:include>
			<!--[e] lnb -->			
		
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>운영관리 &gt; MUSIC 관리 &gt; CARHARTT RADIO</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- CARHARTT RADIO 목록 입니다.</li> -->
<!-- 						<li>- 상세 목록 조회가 가능합니다.</li> -->
<!-- 						<li>- 등록된  RADIO 배너는 상단 라디오버튼 클릭 후 노출되는 레이어 내에서 확인 가능합니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
				<form:hidden path="page" id="page"/>
				<form:hidden path="siteNo" id="siteNo"/>
				<form:hidden path="orderBy" id="orderBy"/>
				<form:hidden path="orderFlag" id="orderFlag"/>
				<input type="hidden" name="radioNo" id="radioNo" />
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<div class="tableType2">
						<table>
							<caption>music 관리</caption>
							<colgroup>
								<col width="130px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">작성일</th>
									<td>
										<form:input path="searchStrDtm" id="searchStrDtm" name="searchStrDtm" readonly="true" cssClass="datepicker1" /> ~
										<form:input path="searchEndDtm" id="searchEndDtm" name="searchEndDtm" readonly="true" cssClass="datepicker2" />
									</td>
									<td rowspan="3" class="bd_left">
										<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
										<a href="#" id="btn_reset" class="btnType1">초기화</a>
									</td>
								</tr>
								<tr>
									<th scope="col">상태</th>
									<td>
										<form:radiobutton path="dispYn" label="공개" value="Y"/>
										<form:radiobutton path="dispYn" label="미공개" value="N"/>
									</td>
								</tr>
								<tr>
									<th scope="col">검색</th>
									<td>
										<form:select path="searchGb">
											<form:option value="all">전체</form:option>
											<form:option value="radioTitle">타이틀</form:option>
											<form:option value="radioArtist">아티스트</form:option>
<%-- 											<form:option value="regrNo">작성자</form:option> --%>
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
				<div class="section a2">
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
							<caption>CARHARTT RADIO</caption>
							<colgroup>
								<col style="width: 6%" />
								<col style="width: 9%" />
								<col style="width: 15%" />
								<col style="width: *" />
								<col style="width: 15%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th scope="row">No <a id="RNUM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">상태 <a id="DISP_YN" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">배너 이미지 </th>
									<th scope="row">타이틀 <a id="RADIO_TITLE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">아티스트 <a id="RADIO_ARTIST" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th scope="row">작성자 </th>
									<th scope="row">작성일 <a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>
						<c:choose>
							<c:when test="${not empty carharttRadioList}">
								<c:forEach items="${carharttRadioList}" var="radio" varStatus="listCount">
								<tr>	
									<td>${radio.rnum }</td>
									<td>${radio.dispYn }</td>
									<c:choose>
										<c:when test="${not empty radio.banImgUrl }">
									<td><a href="#" onclick="javascript:goDetail(this);" data-radioNo="${radio.radioNo}"><img src="${uploadImage}${radio.banImgUrl }"/></a></td>
										</c:when>
										<c:otherwise>
									<td> - </td>
										</c:otherwise>
									</c:choose>
									<td><a href="#" onclick="javascript:goDetail(this);" data-radioNo="${radio.radioNo}">${radio.radioTitle}</a></td>
									<td>${radio.radioArtist }</td>
									<td>${radio.regUserNm }</td>
									<td>${radio.updDts }</td>
								</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="7">등록된 내용이 존재하지 않습니다.</td>
								</tr>									
							</c:otherwise>									
						</c:choose>	
							</tbody>
						</table>
					</div>
					<!--[s] 페이징 -->
					<div class="paging">
					<c:choose>
						<c:when test="${not empty carharttRadioList}">
							${pageHtml}
							<div class="right">
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
				</form:form>
			</div>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
	
		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->
	</div>
</div>
</body>
</html>