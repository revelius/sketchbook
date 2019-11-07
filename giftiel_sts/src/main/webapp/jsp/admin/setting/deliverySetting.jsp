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
//취소
function doReset(){
// 	$("form").each(function() {  
//         this.reset();  
//     }); 
	$(':input').each(function(index) {
    	if($(this).attr('type')=="text"){
    		$(this).val("");
    	}
    });
}


//저장
function doSave(){
	if($("#cnd_free_dlv_amt").val()==""){
		alert("무료배송금액을 입력하세요.");
		$("#cnd_free_dlv_amt").focus();
		return;
	}
	if($("#dlv_cst").val()==""){
		alert("배송비를 입력하세요.");
		$("#dlv_cst").focus();
		return;
	}
	
	$("#cnd_free_dlv_amt").val($("#cnd_free_dlv_amt").val().replace(/,/g, ''));
	$("#dlv_cst").val($("#dlv_cst").val().replace(/,/g, ''));
	
	var frmdata = JSON.stringify(convertFrmToJSON($("#frm")));

 	$.ajax({
        url : "<c:url value='/admin/setting/settingMallSave'/>",
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
			<!--[s] contents -->
			
			<div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb -->  
			
			<div class="contents"><!-- contents_tab -->
				<h3><span class="icon1"></span>환경설정 > 전체운영설정 > 배송설정</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 총 구매액 설정으로 배송비 무료로 설정합니다.</li> -->
<!-- 						<li>- 총 구매액 미만일 경우의 배송비 선불 처리를 설정합니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- [s] 전체운영설정 컨텐츠 -->
				<div class="tabCon_inner">
					<!-- [s] 기본 배송정책 설정 테이블 -->
					<div class="tableType2">
						<table>
							<caption>기본 배송정책</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="2" class="row_tit">기본 배송정책</th>
							    </tr>
							    
								
								<form:form name="frm" id="frm" method="post" modelAttribute="regFrm" onsubmit="return check(form)">
								<tr>
									<th scope="col">기본 배송정책</th>
									<td>총 구매액 
 										<%-- <fmt:formatNumber value="${list.cnd_free_dlv_amt}" groupingUsed="true" var="cnd_free_dlv_amt"/> --%>
										<form:input path="cnd_free_dlv_amt" name="cnd_free_dlv_amt" id="cnd_free_dlv_amt" onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;"/>
									원 이상일 때 <span class="highlight">무료</span>
									 	<p class="pt_14 under">미만일 때 
									 	<%-- <fmt:formatNumber value="${list.dlv_cst}" groupingUsed="true" var="dlv_cst"/> --%>
									 	<form:input path="dlv_cst" name="dlv_cst" id="dlv_cst" onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;"/>
									 	 원 선불</p></td>
								</tr>
								</form:form>
							</tbody>	 
						</table>        
					</div>     
					<!-- [e] 기본 배송정책 설정 테이블 -->  
					<div class="pt20"></div>
					<div class="section a2 btn">
						<a href="javascript:doSave();" class="btnType2">저장</a> 
						<a href="javascript:doReset();" class="btnType1">취소</a>
					</div>
				</div>
				<!-- [e] 상점환경설정 컨텐츠 -->	
			</div>
			<!--[e] contents -->
		  </div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>