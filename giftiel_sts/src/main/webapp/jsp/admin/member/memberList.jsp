<%--
 * =============================================================================
 * 파일명 : /member/memberList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 회원관리 > 회원목록
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
		
	    doPointReg = function(){
			$(".under_table").fadeToggle();
		};
		
		doPointSave = function(){
			var chkCnt = 0;
			var memNo = "";
			$("input:checkbox[id^=selChk]").each(function(){
				if(this.checked){
					memNo = $(this).attr("data-value");
					chkCnt++;
				}	
			});
			if(chkCnt > 1 || chkCnt == 0){
				alert("항목을 한개 선택하세요.");
				return;
			}
			
			if($("#rsvRsnCd").val()==""){
				alert("포인트 내용을 선택하세요.");
				return;
			}
			if($("#rsvPnt").val()==""){
				alert("포인트를 입력하세요.");
				$("#rsvPnt").focus();
				return;
			}
			if($("#rsvPnt").val().indexOf('.') > 0){
				alert("포인트에 소수는 입력할 수 없습니다.");
				return;
			}
			//포인트 숫자에 콤마 제거 
			$("#rsvPnt").val($("#rsvPnt").val().replace(/,/g, ''));
			
			//데이터 셋팅 
			var frmdata = {
					memNo		: memNo, 
					rsvRsnCd	: $("#rsvRsnCd").val(), 
					rsvPnt		:$("#rsvPnt").val(), 
					rsvCls		:$("#rsvCls").val(), 
					useYn		:$("#useYn").val()
				};
			
			$.ajax({
		        url : "<c:url value='/admin/member/insertPoint'/>",
		        type: "POST",
		        data : frmdata,
		        async: false,
		        //dataType: "json",
		        //contentType: "application/json", 
		        success : function(responseData){
		            var data = JSON.parse(responseData);
		            if(data=="1"){  //저장 성공 
						alert("저장되었습니다.");   
						$('#btn_search').click();
		            }
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};	
		
		
		
    });
    
    function doDetailMem(memNo){
		//$("#memNo").val(memNo);
		//var frm = document.schForm;
        //frm.action = "<c:url value='/admin/member/membershipInfo'/>";
        //frm.submit();
        location.href="<c:url value='/admin/member/membershipInfo'/>?memNo="+memNo;
	}
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
					<jsp:param name="menuFlag" value="member"/>
					<jsp:param name="onChk" value="memberList"/>
				</jsp:include>
				<!--[e] lnb -->

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
									<tr>
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
									<tr>
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
								<col width="5%" />
								<col width="7%" />
								<col width="*" />
								<col width="8%" />
								<col width="10%" />
								<col width="8%" />
								<col width="8%" />
								<col width="9%" />
								<col width="9%" />
								<col width="6%" />
								<col width="9%" />
								<col width="9%" />
							</colgroup>
							<thead>  
								<tr id="sortTr">
									<th><input type="checkbox" id="allCheck" name="allCheck" /></th>
									<th>구분</th>
									<th>Email 계정 <a id="EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>이름 <a id="NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>회원등급 <a id="MEM_GRD_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
<!-- 									<th>멤버쉽 번호</th> -->
									<th>성별 <a id="SEX" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>나이 <a id="AGE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>포인트 <a id="CUR_POINT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>접속 수 <a id="LOGIN_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>총 구매금액 <a id="ORDER_AMT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>총 구매건수 <a id="ORDER_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>회원 코멘트 <a id="CMT_CNT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th> 
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${memberList}" var="member" varStatus="listCount">							
									<tr>
										<td><input type="checkbox" id="selChk" name="selChk" data-value="${member.memNo}"/></td>
										<td>
										<c:choose>
											<c:when test="${member.wdrwYn eq 'Y'}">
												탈퇴 
											</c:when>
											<c:otherwise>
											      회원 
											</c:otherwise>
										</c:choose>
										</td>
										<td><a href="javascript:doDetailMem('${member.memNo}');">${member.email }</a></td>
										<td>${member.nm }</td>
										<td>${member.grdNm }</td>
										<td>
										<c:choose>
											<c:when test="${member.sex eq 'M'}">
											남
											</c:when>
											<c:when test="${member.sex eq 'W'}">
											여
											</c:when>
											<c:otherwise>
											기타
											</c:otherwise>
										</c:choose>
										</td>
										<td>${member.age }</td>
										<td>${member.curPoint }P</td>
										<td>${member.loginCnt }</td>
										<td>${member.orderAmt }</td>
										<td>${member.orderCnt }</td>
										<td>${member.cmtCnt }</td>
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
						<div class="left">
							<a href="javascript:doPointReg();" class="btnType2">선택회원 포인트 등록</a>
						</div>	
					</div>
					<!--[e] 페이징 -->
					
					<form:form id="regForm" name="regForm" method="post" modelAttribute="regForm" onsubmit="return check(form)">
					<form:hidden path="memNo" id="memNo"/>
					<form:hidden path="useYn" value="Y"/>
					<form:hidden path="rsvCls" value="CM01001"/>
					
					<!--[s] 포인트 직접등록 -->
					<div class="under_table tableType1" style="display:none">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="*" />
								<col width="30%" />
								<col width="15%" />										
							</colgroup>
							<thead>
								<tr>
									<th colspan="3" class="th_title">포인트 직접 등록</th>					
								</tr>
								<tr>
									<th>포인트내용</th>
									<th>포인트</th>
									<th>입력</th>
								</tr>
							</thead>
							<tbody>
								<tr>							
									<td>
										<form:select path="rsvRsnCd" id="rsvRsnCd" style="width:150px;">
											<form:option value="">선택</form:option>
											<form:options items="${rsvRsnList}" itemLabel="cdNm" itemValue="cdNo"/>
										</form:select>
									</td>
									<td><input type="text" class="ip_text wd_258" id="rsvPnt" name="rsvPnt" onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;"/></td>
									<td><a href="javascript:doPointSave();" class="btnType2">확인</a></td>
								</tr>										
							</tbody>
							</table>
						</div>
						</form:form>

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