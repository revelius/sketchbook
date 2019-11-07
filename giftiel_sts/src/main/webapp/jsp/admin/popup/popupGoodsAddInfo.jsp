<%--
 * =============================================================================
 * 파일명 : /popup/popupGoodsAddInfo.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리 > 상품목록
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
		//상품정보고시 내용 추가
	    addTxt = function() {
	    	var idx = $("#addInfoList tbody tr").length - 2;
	    	var name = "goodsAddInfos["+idx+"].title";
	    	var name2 = "goodsAddInfos["+idx+"].txt";
	    	var delBtnPath = "<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>";
	    	var html = "<tr>";
	    		html += "<td><input id=\""+name+"\" name=\""+name+"\" type=\"text\"></td>";
	    		html += "<td><input id=\""+name2+"\" name=\""+name2+"\" type=\"text\"></td>";
	    		html += "<td><a href=\"#\" data-btn=\"btn_del\"><img src=\""+delBtnPath+"\" alt=\"\" /></a></td>";
	    		html += "</tr>";
	    		
	    	$('#addInfoList > tbody:last').append(html);
	    };
	    
	    //저장
	    $('#btn_save').click(function() {
	    	
	    	if($("#gdsInfoNm").val() == ""){
	    		alert("제목을 입력하세요.");
	    		return;
	    	}
	    	
	    	if($("[data-btn]").length == 0){
	    		alert("최소 하나의 항목을 입력하셔야 합니다.");
	    		return;
	    	}
	    	
	    	
	    	var flag = false;
	    	$("input[name$='title'],input[name$='txt']").each(function(){
	    		
	    		if($(this).val()==""){
	    			if(!confirm("제목이나 내용중 하나의 항목이라도 빈값이 들어 있는 항목은\n 저장에서 제외 됩니다. 저장하시겠습니까?")){
	    				flag =  true;
	    			}else{
	    				
	    			};
	    			return false;
	    		}
	    	});
	    	if(flag) return;
	    	
	        var frm = document.popupForm;
	        frm.target = '_self';
	        frm.action = 'saveGoodsAddInfo';
	        frm.submit();
	    });	 
	    
	    //row 삭제
	    $(document).on("click","[data-btn]",function(e) {
	    	var $target = $(e.currentTarget).closest("tr");
	    	$target.remove();
	    	
	    });	
	    
	});
	</script>
</head>
<body>
<!-- 대 카테고리 수정 -->
<div class="layerWrap">
	<div class="title">
		<h1><span class="icon1"></span>상품정보고시 관리</h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
	<form:form id="popupForm" name="popupForm" method="post" modelAttribute="goodsAddInfoGrp" onsubmit="return check(form)">
	<form:hidden path="gdsInfoNo" id="gdsInfoNo"/>
	<div class="wrap">
		<div class="section a1">
			<div class="tableType2 prd_manage">
				<ul class="boxLi">
					<li>- 상품정보고시를 등록 및 관리합니다.</li>
				</ul>
				
				<table class="cateinfo" id="addInfoList">
				<colgroup>
					<col width="100px" />
					<col width="*" />
				</colgroup>
				<tbody>					
					<tr>
						<th>제목</th>
						<td colspan="3"><form:input path="gdsInfoNm" id="gdsInfoNm"/></td>
					</tr>
					<tr>
						<th rowspan="200">상품정보고시<br />항목</th>
						<th>제 목</th>
						<th colspan="2">내 용</th>
					</tr>
					<c:forEach items="${goodsAddInfoGrp.goodsAddInfos }" varStatus="listCount">
					<tr>
						<td>
							<form:input path="goodsAddInfos[${listCount.count -1}].title" id="goodsAddInfos[${listCount.count -1}].title"/>
						</td>
						<td>
							<form:input path="goodsAddInfos[${listCount.count -1}].txt" id="goodsAddInfos[${listCount.count -1}].txt"/>
						</td>
						<td>
<!-- 							<a href="#" class="btnType2" data-btn="btn_del">삭제</a> -->
							<a href="#" data-btn="btn_del"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
				</table>
				<div class="btn">
					<div class="right">
						<a href="javascript:addTxt();" id="btn_add" class="btnType2">추가</a>
						<a href="#" id="btn_save" class="btnType2">저장</a>
						<a href="javascript:window.close();" class="btnType1">취소</a>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	</form:form>
</div>
<!-- //대 카테고리 수정 -->
</body>
</html>