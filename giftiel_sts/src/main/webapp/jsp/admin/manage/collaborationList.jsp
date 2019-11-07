<%--
 * =============================================================================
 * 파일명 : /manage/collaborationList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : collaboration리스트
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
		        frm.action = "<c:url value='/admin/manage/collaborationList'/>";
		        frm.submit();
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
	    
	    
	    
	    
	    //상세페이지 이동
	    goDetail = function(e, clbltnNm, seasonCd){
	    	var $target = $(e);
	    	var txtNo = $target.attr('data-txtNo');
	    	var frm = document.hiddenForm;
	    	frm.txtNo.value = txtNo;
	    	frm.hiddenSiteNo.value = $("#siteNo").val();
	    	frm.hiddenStrDtm.value = $("#searchStrDtm").val();
	    	frm.hiddenEndDtm.value = $("#searchEndDtm").val();
	    	frm.hiddenSearchText.value = $("#searchText").val();
	    	frm.clbltnNm.value = clbltnNm;
	    	frm.seasonCd.value = seasonCd;
	    	frm.action = "<c:url value='/admin/manage/collaboDetail'/>";
	    	frm.submit();
	    };
	    
	    
	    //등록
	    $('#btn_reg').click(function() {
	    	var frm = document.hiddenForm;
	    	frm.hiddenSiteNo.value = $("#siteNo").val();
	    	frm.hiddenStrDtm.value = $("#searchStrDtm").val();
	    	frm.hiddenEndDtm.value = $("#searchEndDtm").val();
	    	frm.hiddenSearchText.value = $("#searchText").val();
	    	frm.action = "<c:url value='/admin/manage/regCollabo'/>";
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
					<input type="hidden" id="txtNo" name="txtNo"/>
					<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo"/>
					<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm"/>
					<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm"/>
					<input type="hidden" id="hiddenSearchText" name="hiddenSearchText"/>
					<input type="hidden" id="clbltnNm" name="clbltnNm"/>
					<input type="hidden" id="seasonCd" name="seasonCd"/>
				</form>
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
							<form:hidden path="excel" id="excel"/>
        					<form:hidden path="page" id="page"/>
        					<form:hidden path="siteNo" id="siteNo"/>
        					<form:hidden path="orderBy" id="orderBy"/>
       						<form:hidden path="orderFlag" id="orderFlag"/>
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 > COLLABORATION 관리 > COLLABORATION</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- 브랜드별 Collaboration 목록입니다.</li> -->
<!-- 							<li>- 브랜드 별 상세 목록 조회가 가능합니다.</li> -->
<!-- 							<li>- 등록된 Collaboration은 온라인샵에서 확인 가능합니다.</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<!-- tabWrap -->
					<div class="tabWrap">
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
						<div class="tabConWrap">
							<div class="tabCon">
								<div class="tableType2">
									<table>
										<caption>배송검색</caption>
										<colgroup>
											<col width="100px">
											<col width="*">
											<col width="100px">
										</colgroup>
										<tbody>
											<tr>
												<th>기간</th>
												<td>
													<div class="wrap">
														<form:input path="searchStrDtm" id="searchStrDtm" name="searchStrDtm" readonly="true" cssClass="datepicker1"/> ~
														<form:input path="searchEndDtm" id="searchEndDtm" name="searchEndDtm" readonly="true" cssClass="datepicker2"/>				
													</div>
												</td>
												<td rowspan="2" class="bd_left">
													<a href="#" id="btn_search" class="btnType2">검색</a> <br /><br />
													<a href="#" id="btn_reset" class="btnType1">초기화</a>
												</td>
											</tr>
											<tr>
												<th>검색</th>
												<td>
													<form:input path="searchText" id="searchText" type="text" class="wd_200" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="section a2">
									<div class="tableTitle">
										<div class="right">
											<form:select path="searchCount" onchange="javascript:doNumList();">
												<form:option value="15">15개</form:option>
												<form:option value="30">30개</form:option>
												<form:option value="50">50개</form:option>
												<form:option value="100">100개</form:option>
											</form:select>
										</div>
									</div>
									<div class="tableType1">
										<table>
											<caption>Archive</caption>
											<colgroup>
												<col style="width: 8%" />
												<col style="width: 10%" />
												<col style="width: *" />
												<col style="width: 12%" />
												<col style="width: 15%" />
												<col style="width: 15%" />
											</colgroup>
											<thead>
												<tr id="sortTr">
													<th scope="row">No</th>
													<th scope="row">상태 <a id="DISP_YN" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
													<th scope="row">제목</th>
													<th scope="row">작성자</th>
													<th scope="row">작성일<a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
											<c:choose>
												<c:when test="${not empty collaborationList}">
													<c:forEach items="${collaborationList}" var="collabo" varStatus="listCount">
														<tr>
															<td>${collabo.rnum}</td>	
															<td>${collabo.dispYn}</td>
															<td class="tl"><a href="#" onclick="javascript:goDetail(this, '${collabo.clbltnNm}', '${collabo.seasonCd}');" data-txtNo="<c:out value='${collabo.txtNo}'/>">${collabo.title}</a></td>
															<td>${collabo.regUserNm}</td>
															<td>${collabo.updDts}</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="5">
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
											<c:when test="${not empty collaborationList}">
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
											<div>
												
											</div>
										</div>
									<!--[e] 페이징 -->
								</div>
							</div>
						</div>
					</div>
					<!-- //tabWrap -->
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