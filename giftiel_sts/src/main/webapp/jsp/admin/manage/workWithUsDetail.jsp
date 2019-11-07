<%--
 * =============================================================================
 * 파일명 : /manage/regNews.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : News 등록
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
	<jsp:include page="/jsp/common/froalaEditor2.3.2.jsp"/>	
	
	<script type="text/javascript">
    $(function() { 
	
//     	$("textarea#dtlDesc").editable({inlineMode: false, language: 'ko', theme: 'gray'});
// 		ver2.0
		$("textarea#dtlDesc").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
		
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
		
		//수정
    	$("#btn_mod").on("click",function(){
    		
    		if(!confirm("저장하시겠습니까?")) return false;
	    	
		    if(!formCheck()) return false;
	    	 $("#type").val("Mod");
		     
	    	$.ajax({
		        url : "<c:url value='/admin/manage/regWorkWithUsProc'/>",
		        type: "post",
		        data : $("form#workWithUsForm").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("저장하였습니다."); 
   						location.href = "<c:url value='/admin/manage/workWithUsList'/>";
					} else {
						alert("저장에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		   	});
    	
   		});
		
    	//삭제
    	$("#btn_del").on("click",function(){
    		if(!confirm("삭제하시겠습니까?")) return false;
    		 
    		$("#type").val("Del");
    		 
    		$.ajax({
		        url : "<c:url value='/admin/manage/regWorkWithUsProc'/>",
		        type: "post",
		        data : $("form#workWithUsForm").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("삭제하였습니다."); 
						location.href = "<c:url value='/admin/manage/workWithUsList'/>";
					} else {
						alert("삭제에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		   	});
    	});
    	
		formCheck = function(){
			
			var frm = document.workWithUsForm;
	    	
    		if($("input:checkbox[name='siteNo']").is(":checked") == false){
	    		alert("브렌드를 선택하세요.");
	    		return false;
	    	}
    		
    		if(frm.withusStat.value == ""){
	    		alert("상태를 선택하세요.");
	    		return false;
	    	}
    		
    		if(frm.withusCls.value == ""){
	    		alert("구분를 선택하세요.");
	    		return false;
	    	}    		
    		
    		if(frm.withusArea.value == ""){
	    		alert("지역을 입력해 주세요.");
	    		return false;
	    	}
    		
    		if(frm.withusCl.value == ""){
	    		alert("모집분야를 입력해 주세요.");
	    		return false;
	    	}
    		
    		if (frm.strDts.value == "") {
				alert("시작일을 입력하세요.");
			}
    		
    		if (frm.endDts.value == "") {
				alert("종료일을 입력하세요.");
			}
    		
    		var str = frm.strDts.value;
    		var end = frm.endDts.value;
    		
    		var arrayStr = str.split("-");
    		var arrayEnd = end.split("-");
    		
    		var strDate = new Date(arrayStr[0],arrayStr[1],arrayStr[2]);
    		var endDate = new Date(arrayEnd[0],arrayEnd[1],arrayEnd[2]);

    		if (str != "" && end != "") {
				
	    		if (strDate > endDate) {
					alert("시작일이 종료일보다 큽니다.");
					return false;
				}
	    		
				if (endDate < strDate) {
					alert("종료일이 시작일보다 작습니다.");
					return false;
				}
			}
    		if(frm.dtlDesc.value == ""){
	    		alert("내용을 입력해 주세요.");
	    		return false;
	    	}

    		return true;
	    };
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
				<form:form id="workWithUsForm" name="workWithUsForm" method="post" modelAttribute="workWithUsForm" onsubmit="">
				<form:hidden path="withusSeq" id="withusSeq" name="withusSeq" />
				<input type="hidden" id="type" name="type" />
				<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo" value="${hiddenSiteNo}"/>
				<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm" value="${hiddenStrDtm}"/>
				<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm" value="${hiddenEndDtm}"/>
				<input type="hidden" id="hiddenSearchGb" name="hiddenSearchGb"  value="${hiddenSearchGb}"/>
				<input type="hidden" id="hiddenSearchText" name="hiddenSearchText" value="${hiddenSearchText}"/>
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 &gt; 고객운영관리 &gt; WORK WITH US</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<div class="tableType2">
							<table>
								<caption>News</caption>
								<colgroup>
									<col width="130px">
									<col width="*">
									<col width="130px">
									<col width="350px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">브랜드</th>
										<td colspan="3">
											<div class="wrap">
											<form:checkboxes path="siteNo" id="siteNo" items="${siteList}" itemLabel="siteNm" itemValue="siteNo"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">상태</th>
										<td>
											<form:radiobutton path="withusStat" label="공개" value="Y"/>
											<form:radiobutton path="withusStat" label="비공개" value="N"/>
										</td>
									</tr>
									<tr>
										<th scope="col">구분</th>
										<td colspan="3">
											<form:input path="withusCls" id="withusCls" name="withusCls" cssClass="ip_tit" />
											<br/>*채용구분을 입력해주세요. Ex. CARHARTT WIP STORE 서울 압구정
										</td>
									</tr>
									<tr>
										<th scope="col">지역</th>
										<td colspan="3">
											<form:input path="withusArea" id="withusArea" name="withusArea" cssClass="ip_tit" />
											<br/>*채용지역 주소를 입력해주세요. Ex. 서울 강남구 압구정로 54길 21 신우빌딩 1층
										</td>
									</tr>
									<tr>
										<th scope="col">모집분야</th>
										<td colspan="3">
											<form:input path="withusCl" id="withusCl" name="withusCl" cssClass="ip_tit" />
											<br/>*채용 모집분야를 입력해주세요. Ex. 판매직원, 마케터
										</td>
									</tr>
									<tr>
										<th scope="col">기간</th>
										<td colspan="3">
											<form:input path="strDts" id="strDts" name="strDts" readonly="true" cssClass="datepicker1"/> ~
											<form:input path="endDts" id="endDts" name="endDts" readonly="true" cssClass="datepicker2"/>
											<br/>*채용 지원 가능 기간을 입력해주세요. 
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<form:textarea path="dtlDesc" name="dtlDesc" id="dtlDesc" cssClass="txtareaAll"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType2" id="btn_mod">수정</a>
						<a href="#" class="btnType1" id="btn_cancel" onclick="javascript:window.history.back(-1); return false;">취소</a>
						<a href="#" class="btnType1" id="btn_del">삭제</a>
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