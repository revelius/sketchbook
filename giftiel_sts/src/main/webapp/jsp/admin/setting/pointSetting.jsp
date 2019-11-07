<%-- 
 작성자 : jhr
 작성일 : 2015-04-13
 화면명 : 관리자 회원 등급관리 화면 
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
<script>
var chkval = '';
$(document).ready(function(){
	chkval = $("input:radio[name='pnt_rsv_cls']").val();
	
	$("input:radio[name='pnt_rsv_cls']").change(function(){
		chkval = $(this).val();
		if(chkval == 'MT00101' || chkval == 'MT00102'){
			$("#pnt_rsv_rt").val("");
		}
 	});
});
//저장
function doSave(){
	if($("#mem_join_rsv_pnt").val()==""){
		alert("회원가입 포인트를 입력하세요.");
		$("#mem_join_rsv_pnt").focus();
		return;
	}
	if(chkval != 'MT00101' && chkval != 'MT00102'){
		if($("#pnt_rsv_rt").val()==""){
			alert("적립설정금액(율)을 입력하세요.");
			$("#pnt_rsv_rt").focus();
			return;
		}else{
			$("#pnt_rsv_rt").val($("#pnt_rsv_rt").val().replace(/,/g, ''));
		}
	}
	if($("#use_min_pnt").val()==""){
		alert("사용가능 제한 포인트를 입력하세요.");
		$("#use_min_pnt").focus();
		return;
	}
	if($("#min_paypnt").val()==""){
		alert("최저결제 포인트를 입력하세요.");
		$("#min_paypnt").focus();
		return;
	}
	if($("#max_paypnt").val()==""){
		alert("최대결제 포인트를 입력하세요.");
		$("#max_paypnt").focus();
		return;
	}
	
	$("#mem_join_rsv_pnt").val($("#mem_join_rsv_pnt").val().replace(/,/g, ''));
	$("#use_min_pnt").val($("#use_min_pnt").val().replace(/,/g, ''));
	$("#min_paypnt").val($("#min_paypnt").val().replace(/,/g, ''));
	$("#max_paypnt").val($("#max_paypnt").val().replace(/,/g, ''));
	
 	var frmdata = JSON.stringify(convertFrmToJSON($("#frm")));

 	$.ajax({
        url : "<c:url value='/admin/setting/pointSettingSave'/>",
        type: "post",
        data : frmdata,
        async: false,
        dataType: "json",
        contentType: "application/json", 
        success : function(responseData){
            var data = JSON.parse(responseData);
            if(data=="1"){  //저장 성공 
				alert("저장되었습니다.");                	
            }              
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}
</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">	
			<div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb -->  
				
			<!--[s] contents -->
			<div class="contents"><!-- contents_tab -->
				<h3><span class="icon1"></span>환경설정 > 전체운영설정 > 포인트설정</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 기본포인트, 상품포인트에 대한 설정이 가능합니다.</li> -->
<!-- 						<li>- 기본포인트는 회원 가입시 발생하는 적립금 설정입니다.</li> -->
<!-- 						<li>- 상품포인트는 상품 구매시 사용 및 적립에 대한 설정이 가능합니다.</li> -->
<!-- 						<li>- 내용 수정 후 저장시 즉시 시스템에 적용되오니 유의하시기 바랍니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				
<%-- 				<c:forEach items="${list}" var="list" varStatus="listCount">				 --%>
<%-- 					<c:set var="use_min_pnt" value="${list.USE_MIN_PNT}"/> --%>
<%-- 					<c:set var="min_paypnt"  value="${list.MIN_PAYPNT}"/> --%>
<%-- 					<c:set var="max_paypnt"  value="${list.MAX_PAYPNT}"/> --%>
<%-- 					<c:set var="pnt_rsv_rt" 	  value="${list.PNT_RSV_RT}"/> --%>
<%-- 					<c:set var="exp_pnt" 		  value="${list.EXP_PNT}"/> --%>
<%-- 					<c:set var="pnt_rsv_cls" 	  value="${list.PNT_RSV_CLS}"/> --%>
<%-- 					<c:set var="mem_join_rsv_pnt" value="${list.MEM_JOIN_RSV_PNT}"/> --%>
<%-- 				</c:forEach> --%>
				
				<form:form name="frm" id="frm" method="post" modelAttribute="regFrm" onsubmit="return check(form)">
				<!-- [s] 전체운영설정 컨텐츠 -->
				<div class="tabCon_inner">
					<!-- [s] 기본 배송정책 설정 테이블 -->
					<div class="tableType2">
						<table>
							<caption>기본 포인트</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="2" class="row_tit">기본 포인트</th>
							    </tr>
								<tr>
									<th scope="col">회원가입 포인트</th>
									<td><form:input path="mem_join_rsv_pnt" name="mem_join_rsv_pnt" id="mem_join_rsv_pnt" onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/> point <span class="addtxt ml_5">* 회원가입시 적립될 포인트를 입력바랍니다.</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 기본 배송정책 설정 테이블 -->
					<!-- [s] 상품 포인트 테이블 -->
					<div class="tableType2 pt20">
						<table>
							<caption>상품 포인트</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="2" class="row_tit">상품 포인트</th>
							    </tr>
								<tr>
									<th scope="col">적립 설정</th>
									<td>
										<div class="inputList">
											<form:radiobutton path="pnt_rsv_cls" id="radio2_1" name="pnt_rsv_cls" value="MT00101" checked="true"/> <label for="radio2_1">포인트 지급 안함</label> <br />
											<form:radiobutton path="pnt_rsv_cls" id="radio2_2" name="pnt_rsv_cls" value="MT00102"/> <label for="radio2_2">회원등급관리 설정에 따라 지급</label><br />
											<form:radiobutton path="pnt_rsv_cls" id="radio2_3" name="pnt_rsv_cls" value="MT00103"/> <label for="radio2_3">판매가 % 지급</label><br />
											<form:radiobutton path="pnt_rsv_cls" id="radio2_4" name="pnt_rsv_cls" value="MT00104"/> <label for="radio2_4">결제가 % 지급</label><br />
											<form:radiobutton path="pnt_rsv_cls" id="radio2_5" name="pnt_rsv_cls" value="MT00105"/> <label for="radio2_5">구매 상품(개수) 당 point 지급 <form:input path="pnt_rsv_rt" class="txt100" onkeyup="inputNumberFormat(this)" id="pnt_rsv_rt" name="pnt_rsv_rt" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/></label>
											
											<%-- <input type="radio" id="radio2_1" name="pnt_rsv_cls" value="MT00101" <c:if test="${empty pnt_rsv_cls or pnt_rsv_cls eq 'MT00101'}"> checked="checked" </c:if> /> <label for="radio2_1">포인트 지급 안함</label> <br />
											<input type="radio" id="radio2_2" name="pnt_rsv_cls" value="MT00102" <c:if test="${pnt_rsv_cls eq 'MT00102'}"> checked="checked" </c:if> /> <label for="radio2_2">회원등급관리 설정에 따라 지급</label><br />
											<input type="radio" id="radio2_3" name="pnt_rsv_cls" value="MT00103" <c:if test="${pnt_rsv_cls eq 'MT00103'}"> checked="checked" </c:if> /> <label for="radio2_3">판매가 <!-- <input type="text" class="txt100" style="text-align:right;"/>-->% 지급</label><br />
											<input type="radio" id="radio2_4" name="pnt_rsv_cls" value="MT00104" <c:if test="${pnt_rsv_cls eq 'MT00104'}"> checked="checked" </c:if> /> <label for="radio2_4">결제가 <!--<input type="text" class="txt100" style="text-align:right;"/>-->% 지급</label><br />
											<input type="radio" id="radio2_5" name="pnt_rsv_cls" value="MT00105" <c:if test="${pnt_rsv_cls eq 'MT00105'}"> checked="checked" </c:if> /> <label for="radio2_5">구매 상품(개수) 당 point 지급 <input type="text" class="txt100" style="text-align:right;" onkeyup="inputNumberFormat(this)" id="pnt_rsv_rt" name="pnt_rsv_rt" value="<fmt:formatNumber value="${pnt_rsv_rt}" groupingUsed="true"/>" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/></label> --%>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="col">사용 설정</th>
									<td>
										<div class="inputList">
											회원보유 point <form:input path="use_min_pnt" class="txt100" id="use_min_pnt" name="use_min_pnt"  onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/> point 이상 보유시 사용가능 <br />
											구매시 최소 <form:input path="min_paypnt" class="txt100" id="min_paypnt" name="min_paypnt"  onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/> point 이상 보유시 사용가능 <br />
											구매시 최대 <form:input path="max_paypnt" class="txt100" id="max_paypnt" name="max_paypnt"  onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/> point 이상 보유시 사용가능 
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 상품 포인트 테이블 -->
					<div class="section a2 btn">
						<a href="javascript:doSave();" class="btnType2">저장</a> 
						<a href="<c:url value='/admin/setting/pointSetting'/>" class="btnType1">취소</a>
					</div>
				</div>
				</form:form>
				<!-- [e] 상점환경설정 컨텐츠 -->	
			</div>
			<!--[e] contents -->
		   </div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>