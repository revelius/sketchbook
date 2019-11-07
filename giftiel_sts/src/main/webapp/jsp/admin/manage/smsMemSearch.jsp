<%--
 * =============================================================================
 * 파일명 : /member/smsMemSearch.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : sms발송 > 회원목록
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
	        var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = 'memberList';
	        frm.submit();
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
	    
		//페이징처리
		paging = function(page) {
	        var frm = document.schForm;
	        document.getElementById("page").value = page;
	        $('#btn_search').trigger('click');
		};
		
		//결과 갯수 셋팅
		doNumList = function() {
			$('#btn_search').click();
		};
		
	    //정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			$('#btn_search').click();			
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
		
		//엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$('#btn_search').click();
	    	$("#excel").val("false");
	    });		
		
    });
    
    function doDetailMem(memNo){
		//$("#memNo").val(memNo);
		//var frm = document.schForm;
        //frm.action = "<c:url value='/admin/member/membershipInfo'/>";
        //frm.submit();
        location.href="<c:url value='/admin/member/membershipInfo'/>?memNo="+memNo;
	}
    
    function sendChildValue(cpNo){
    	cpNo2 = cpNo.replace(/-/g,"");
    	opener.setChildValue(cpNo2);
    	
    	
    }
    
    
    
	</script>
</head> 
<body>
<div class="layerWrap">
		<div class="title">
		<h1>회원주소록</h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<%-- <jsp:include page="/jsp/admin/include/top.jsp"/> 
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">			
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
			 	<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="member"/>
					<jsp:param name="onChk" value="memberList"/>
				</jsp:include> 
				<!--[e] lnb -->		--%>

				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
				
				<!--[s] contents -->
				<div class="contents memberList">
					<!--[s] 검색목록 -->
					<div class="section a1">
						<h3><span class="icon1"></span>회원목록</h3>						
						<div class="tableType2">
							<p class="boxP"> 다음은 회원목록 입니다.<span>총 회원수 : <fmt:formatNumber value="${totalCnt }" groupingUsed="true"/> 
							/ 탈퇴 : 
							<c:choose>
								<c:when test="${not empty wdrwCnt}">
									<fmt:formatNumber value="${wdrwCnt}" groupingUsed="true"/>
								</c:when>
								<c:otherwise>
								0
								</c:otherwise>	
							</c:choose>
							</span> </p>
							
								<form:hidden path="excel" id="excel"/>
        						<form:hidden path="page" id="page"/>
        						<form:hidden path="orderBy" id="orderBy"/>
        						<form:hidden path="orderFlag" id="orderFlag"/>
        						<form:hidden path="memNo" id="memNo"/>
        						
								<table>
								<caption>회원목록 검색</caption>
								<colgroup>
									<col width="132px" />
									<col width="456px" />
									<col width="132px" />
									<col width="300px" />
								</colgroup>
								<tbody>
<%-- 									<tr>
										<th>최근 접속일</th>
										<td  colspan="3">
											<div class="dateWrap dateWrapFirst">
												<span class="dateinput"><form:input path="loginStrDtm" id="loginStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
												<span class="dateinput"><form:input path="loginEndDtm" id="loginEndDtm" readonly="true" cssClass="datepicker2"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>구매일</th>
										<td  colspan="3">
											<div class="wrap">
												<span class="dateinput"><form:input path="ordStrDtm" id="ordStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
												<span class="dateinput"><form:input path="ordEndDtm" id="ordEndDtm" readonly="true" cssClass="datepicker2"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>가입일</th>
										<td  colspan="3">
											<div class="wrap">
												<span class="dateinput"><form:input path="joinStrDtm" id="joinStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
												<span class="dateinput"><form:input path="joinEndDtm" id="joinEndDtm" readonly="true" cssClass="datepicker2"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>등급별</th>
										<td  colspan="3">
											<div class="wrap">
												<form:select path="memGrdNo">
													<form:option value="">전체</form:option>
													<form:options items="${memberGradeList}" itemLabel="grdNm" itemValue="memGrdNo"/>
												</form:select>
											</div>
										</td>
									</tr>
									<tr>
										<th>총 구매금액</th>
										<td>
											<form:input path="actlPayStrPrc" id="actlPayStrPrc"/> 원 ~ <form:input path="actlPayEndPrc" id="actlPayEndPrc"/> 원 
										</td>									
										<th>총 구매건수</th>
										<td><form:input path="ordGdsCnt" id="ordGdsCnt"/> 건</td>
									</tr>
									<tr>
										<th>포인트 적립</th>
										<td colspan="3"><form:input path="rsvStrPnt" id="rsvStrPnt"/> &nbsp;P ~ <form:input path="rsvEndPnt" id="rsvEndPnt"/> &nbsp;P </td>
									</tr>
									<tr> --%>
										<th>직점검색</th>
										<td colspan="3">
											<div class="wrap">
												<form:select path="searchGb">
													<form:option value="">검색구분</form:option>
													<form:option value="email">email</form:option>
													<form:option value="nm">이름</form:option>
													<form:option value="cp_No">핸드폰 번호</form:option>
												</form:select>
												<form:input path="searchText" id="searchText"/>
											</div>
										</td>
									</tr>
								</tbody>
								</table>
							
						</div>
						<div class="btn">
							<a href="javascript:void(0);" id="btn_search" class="btnType2">검색</a>
							<a href="javascript:void(0);" id="btn_reset" class="btnType2">초기화</a>
						</div>
					</div>
					<!--[e] 검색목록 -->

					<!--[s] 검색결과 리스트 -->
					<div class="section a2">
						<div class="tableTitle">
							<div class="left"><span class="icon2"></span>검색된 회원은 <span class="blue">${totalCnt }</span> 명 입니다.</div>					
							<div class="select2">								
								<form:select path="searchCount" onchange="javascript:doNumList();">
									<form:option value="">선택</form:option>
									<form:option value="15">15개 보기</form:option>
									<form:option value="30">30개 보기</form:option>
									<form:option value="50">50개 보기</form:option>
									<form:option value="100">100개 보기</form:option>
									<form:option value="200">200개 보기</form:option>
								</form:select>
							</div>
						</div>
						<div class="tableType1">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								
								<col width="50px" />
								<col width="50px" />
								<col width="30px" />
								<col width="50px" />
								
							</colgroup>
							<thead>  
								<tr id="sortTr">
									<!-- <th><input type="checkbox" id="allCheck" name="allCheck" /></th>
									<th>구분</th> -->
									<th>Email 계정 <a id="EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>이름 <a id="NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>성별 <a id="SEX" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>핸드폰번호 <a id="CP_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${memberList}" var="member" varStatus="listCount">							
									<tr>
										<%-- <td><input type="checkbox" id="selChk" name="selChk" /></td>
										<td>
										<c:choose>
											<c:when test="${member.wdrwYn eq 'Y'}">
												탈퇴 
											</c:when>
											<c:otherwise>
											      회원 
											</c:otherwise>
										</c:choose>
										</td> --%>
										<td><a href="javascript:doDetailMem('${member.memNo}');">${member.email }</a></td>
										<td>${member.nm }</td>
							<%-- 			<td>${member.grdNm }</td> --%>
										<td>
										<c:choose>
											<c:when test="${member.sex eq 'M'}">
											남
											</c:when>
											<c:when test="${member.sex eq 'F'}">
											여
											</c:when>
											<c:otherwise>
											기타
											</c:otherwise>
										</c:choose>
										</td>
										<td><a href="javascript:sendChildValue('${member.cpNo }')">${member.cpNo }</a></td><%-- <td>${member.age }</td>
										<td>${member.curPoint }P</td>
										<td>${member.loginCnt }</td>
										<td>${member.orderAmt }</td>
										<td>${member.orderCnt }</td>
										<td>${member.cmtCnt }</td> --%>
									</tr>
								</c:forEach>
								
								<c:if test="${empty memberList}">
									<tr>
										<td colspan="12">조회된 데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!--[e] 검색결과 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						${pageHtml}
						<div class="right">
							<a href="javascript:void(0);" class="btnType2" id="btn_excel">엑셀출력</a>
						</div>
					</div>
					<!--[e] 페이징 -->

				</div>
				</form:form>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->

	<%-- 	<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer --> --%>

	</div>
</body>
</html>