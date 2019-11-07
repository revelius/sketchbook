<%@ page contentType="text/html; charset=utf-8" %>

<%@ include file="/jsp/admin/include/taglibs.jsp"%> 
 
<!DOCTYPE html> 
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"></jsp:include>
<script>
$(document).ready(function(){
	getSigungu();
	$("#sigunguNm").val("${param.sigunguNm }").attr("selected", "selected");
});
$(function() { 
	//시도를 변경했을 경우 시군구를 가져옴.
	$("#sidoNm").on("change",function(){
		getSigungu();
	});
	
	$('.addr_item').on("click",function(){
		var zip = $(this).attr("data-value");
		var address= $(this).text();
		console.log(zip ,  address);
		
		opener.document.frm.post_no.value = zip;
		opener.document.frm.address.value = address;
		self.close();
	});	
	
});

function doSelectAdddr(){
	if($("#sido").val()==""){
		alert("시도를 선택하세요.");
		return;
	}
	
	if($("#sigungu").val()==""){
		alert("시군구를 선택하세요.");
		return;
	}
	
    var frm = document.schForm;
    frm.target = '_self';
    frm.action = 'selectSido';
    frm.submit();	
}

function getSigungu(){
	var formdata = {};
	formdata = "sidoNm=" + $("#sidoNm").val();
	
	$.ajax({
        url : "<c:url value='/admin/popup/zipCode/sigunguList'/>",
        type: "post",
        data : formdata,
        async: true,
        success : function(responseData){
        	try{
	            var data = jQuery.parseJSON(responseData);
	            $("#sigunguNm").html("");
	            $("#sigunguNm").append("<option value=''>선택하세요.</option>");
	            for(var i=0;i<data.length;i++){
					$("#sigunguNm").append("<option value='"+data[i].sigunguNm+"'>"+data[i].sigunguNm+"</option>");
	            }
        	}catch(e){
        		alert(e);
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
<!-- 대 카테고리 추가 -->
<div class="layerWrap">
	<div class="title">
		<h1>우편번호</h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
	<div class="wrap">
		<div class="section a1">
			<p class="srh_way">검색방법 : 시/도 및 시/군/구 선택 후 동(읍/면) + 지번 입력 <br /> <span>예) 역삼동 737 → 서울특별시 선택 후 역삼동 (동명) + 737(지번)</span></p>
			<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
			<div class="zipcode_box">
				<div class="zipcode_srh">
					<span>시도</span>
					<form:select path="sidoNm" id="sidoNm">
						<form:option value="">전체</form:option>
						<form:option value="서울특별시">서울특별시</form:option>
						<form:option value="부산광역시">부산광역시</form:option>
						<form:option value="인천광역시">인천광역시</form:option>
						<form:option value="대구광역시">대구광역시</form:option>
						<form:option value="광주광역시">광주광역시</form:option>
						<form:option value="대전광역시">대전광역시</form:option>
						<form:option value="울산광역시">울산광역시</form:option>
						<form:option value="경기도">경기도</form:option>
						<form:option value="강원도">강원도</form:option>
						<form:option value="충청북도">충청북도</form:option>
						<form:option value="충청남도">충청남도</form:option>
						<form:option value="전라북도">전라북도</form:option>
						<form:option value="전라남도">전라남도</form:option>
						<form:option value="경상북도">경상북도</form:option>
						<form:option value="경상남도">경상남도</form:option>
						<form:option value="세종특별자치시">세종특별자치시</form:option>
						<form:option value="제주특별자치도">제주특별자치도</form:option>
					</form:select>
					<span class="pl30">시군구</span>
					<form:select path="sigunguNm" id="sigunguNm">
						<form:option value="">선택하세요.</form:option>
					</form:select>
					<div class="pt20" id="pt201">
						<span>검색어</span>
						<form:input path="searchText" id="searchText" placeholder="검색어를 입력하세요."/>
						<a href="javascript:doSelectAdddr();" class="btnType2">검색</a>
					</div>
				</div>
			</div>
			</form:form>
			
			<p class="srh_way">아래 목록에서 해당되는 주소를 클릭하세요.</p>
			<div class="zipcode_box">
				<ul class="addr_list">
					<c:forEach items="${zipCodeList}" var="zipCode" varStatus="listCount">
	           			<li>
	           			${fn:substring(zipCode.zipCd,0,3) }-${fn:substring(zipCode.zipCd,3,6) }
	           			<a href="#" class="addr_item" data-value="${fn:substring(zipCode.zipCd,0,3) }-${fn:substring(zipCode.zipCd,3,6) }">${zipCode.sidoNm } ${zipCode.sigunguNm } ${zipCode.loadNm } ${zipCode.buildNm }<br/></a>
	           			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(${zipCode.sidoNm } ${zipCode.sigunguNm } ${zipCode.lawEmdNm } ${zipCode.jibunBon }-${zipCode.jibunBu })<br/>
	           			</li>
					</c:forEach>
				</ul>
			</div>
			<p class="srh_way">※ 도로명 주소가 검색되지 않는 경우는 행정안전부 새주소안내시스템 <br /> <span>(<a href="http://www.juso.go.kr">http://www.juso.go.kr</a>) 에서 확인하시기 바랍니다.</span></p>
			<div class="btn">
				<a href="#" onclick="window.close()" class="btnType1">창닫기</a>
			</div>
		</div>
	</div>
</div>
<!-- //대 카테고리 추가 -->
</body>
</html>