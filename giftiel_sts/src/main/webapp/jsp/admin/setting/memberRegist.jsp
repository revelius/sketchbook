<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 환경설정 - 상점환경설정 
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
$(document).ready(function() {
	//$("#grd_nm").focus();
});

var chkFlag = true;
var saveFlag = false;
//중복확인 여부 
function doCheck(){
	chkFlag = false;
}

function doSaveFlag(){
	saveFlag = true;
}

function doChkDup(){
	if($("#grd_nm").val()==null || $("#grd_nm").val()==""){
		alert("등급명을 입력하세요.");
		$("#grd_nm").focus();
		return;
	}
	
	var grd_no = "";
	if($("#grd_no").val() != undefined && $("#grd_no").val() != null && $("#grd_no").val() != ""){
		grd_no  = $("#grd_no").val();
	}
	$.ajax({
        url : "<c:url value='/admin/setting/chkDupGrd'/>",
        type: "post",
        data : { "grd_nm" : $("#grd_nm").val() , "grd_no" : grd_no },
        success : function(responseData){
            var data = JSON.parse(responseData);
			
            if(data=="1"){  //로그인 성공 
            	alert("사용중인 등급명입니다.");
            	chkFlag = false;
            	return;              	
            }else if(data=="2"){ //존재하지 않는 정보 
            	alert("사용 가능한 등급명입니다.");
            	chkFlag = true;
            	return;
            }
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}
//저장
function doSave(){
	if($("#grd_nm").val()==""){
		alert("등급명을 입력하세요.");
		$("#grd_nm").focus();
		return;
	}
	if(chkFlag==false){
		alert("중복확인을 하세요.");
		return;
	}
	if($("#dc_amt").val()==""){
		alert("할인율을 입력하세요.");
		$("#dc_amt").focus();
		return;
	}
	if($("#pnt_rsv_rt").val()==""){
		alert("적립율을 입력하세요.");
		$("#pnt_rsv_rt").focus();
		return;
	}
	
	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	
	$("#dc_amt").val($("#dc_amt").val().replace(/,/g, ''));
	$("#pnt_rsv_rt").val($("#pnt_rsv_rt").val().replace(/,/g, ''));
	
	var urlVal = "";
	if($("#grd_no").val() != undefined && $("#grd_no").val() != null && $("#grd_no").val() != ""){
		urlVal = "<c:url value='/admin/setting/memberGrdUpdate'/>";
	}else{
		urlVal = "<c:url value='/admin/setting/memberGrdInsert'/>";
	}
	
	$.ajax({
		url : urlVal,
        type: "post",
        contentType: "application/json", 
        data : JSON.stringify(convertFrmToJSON($("#frm"))),
        dataType: "json",
        success : function(responseData){
            var data = JSON.parse(responseData);
			
            if(data=="1"){  //로그인 성공 
            	alert("저장 되었습니다.");
            	location.href="<c:url value='/admin/setting/memberSetting'/>";          	
            }
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}
function doList(){
	if(saveFlag){
		if(confirm("저장하지 않고 목록으로 이동하시겠습니까?")){
			location.href="<c:url value='/admin/setting/memberSetting'/>";
		}
	}else{
		location.href="<c:url value='/admin/setting/memberSetting'/>";
	}
}
function doDelete(){
	if(!confirm("삭제시 복구 불가능 합니다.\n삭제하시겠습니까?")){
		return;
	}
	
	$.ajax({
		url : "<c:url value='/admin/setting/memberGrdDelete'/>",
        type: "post",
        data : JSON.stringify(convertFrmToJSON($("#frm"))),
        contentType: "application/json", 
        success : function(responseData){
            var data = JSON.parse(responseData);
			
            if(data=="1"){  //로그인 성공 
            	alert("삭제 되었습니다.");
            	location.href="<c:url value='/admin/setting/memberSetting'/>";          	
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
			<div class="contents"><!--  -->
				<h3><span class="icon1"></span>환경설정 > 전체운영설정 > 회원등급관리</h3>
				<!-- [s] 전체운영설정 컨텐츠 -->
				<div class="tabCon_inner">
					<!-- [s] 기본 배송정책 설정 테이블 -->
					<div class="tableType2">
					<form:form name="frm" id="frm" method="post" modelAttribute="regFrm" onsubmit="return check(form)">
						<table>
							<caption>기본 배송정책</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
								<col width="132px" />
								<col width="350px" />
							</colgroup>
							<tbody>
<%-- 								<c:forEach var="list" items="${list}" varStatus="status"> --%>
<%-- 										<c:set var="reg_dts" value="${list.reg_dts}"/>	 --%>
<%-- 										<c:set var="regr_no" value="${list.regr_no}"/>		 --%>
<%-- 										<c:set var="grd_nm" value="${list.grd_nm}"/>				 --%>
<%-- 										<c:set var="dc_amt" value="${list.dc_amt}"/>				 --%>
<%-- 										<c:set var="pnt_rsv_rt" value="${list.pnt_rsv_rt}"/>	 --%>
<%-- 										<c:set var="grd_no" value="${list.grd_no}"/>																		 --%>
<%-- 							    </c:forEach> --%>
								
								<c:if test="${not empty search.regFlag}">
								<input type="hidden" name="grd_no" id="grd_no" value="${search.grd_no}"/>
<%-- 								<form:hidden path="reg_dts" id="reg_dts"/> --%>
<%-- 								<form:hidden path="regr_no" id="regr_no"/> --%>
								
								<tr>
									<th scope="col">작성일</th>
									<td><fmt:formatDate pattern="yyyy.MM.dd" value="${search.reg_dts}"/></td>
									<th scope="col">작성자</th>
									<td>${search.regr_no}</td>
								</tr>
								</c:if>
								
								<tr>
									<th scope="col">등급명</th>
									<td colspan="3"><form:input path="grd_nm" class="wd_270" name="grd_nm" id="grd_nm" onkeyup="javascript:doCheck();doSaveFlag();"/> <a href="javascript:doChkDup();" class="btnType1">중복확인</a></td>
								</tr>
								<tr>
									<th scope="col">할인율</th>
									<td colspan="3">
										<form:input path="dc_amt" class="txt100" name="dc_amt"  id="dc_amt" onkeyup="inputNumberFormat(this);doSaveFlag();" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<45) || (event.keyCode>57)) event.returnValue=false;"/>% <!-- <input type="radio" id="radio1" name="radio" checked="checked" /> <label for="radio1">%</label> <input type="radio" id="radio2" name="radio" /> <label for="radio2">원</label> -->
									</td>
								</tr>
								<tr>
									<th scope="col">적립율</th>
									<td colspan="3">
										<form:input path="pnt_rsv_rt" name="pnt_rsv_rt" id="pnt_rsv_rt"  onkeyup="inputNumberFormat(this);doSaveFlag();" style="text-align:right;IME-MODE:disabled;" onkeyPress="if ((event.keyCode<45) || (event.keyCode>57)) event.returnValue=false;"/>%  <!-- <input type="radio" id="radio1" name="radio" checked="checked" /> <label for="radio1">%</label> <input type="radio" id="radio2" name="radio" /> <label for="radio2">원</label> -->
									</td>
								</tr>
								
							</tbody>
						</table>
						</form:form>
					</div>
					<!-- [e] 기본 배송정책 설정 테이블 -->
					<div class="section a2 btn">
						<a href="javascript:doSave();" class="btnType2">저장</a> 
						<a href="javascript:doList();" class="btnType1">취소</a>
						
						<c:if test="${not empty search.regFlag}">
							<a href="javascript:doDelete();" class="btnType1">삭제</a>
						</c:if>
					</div>
				</div>
				<!-- [e] 상점환경설정 컨텐츠 -->	
			</div>
		   </div>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
	</div>
</body>
</html>