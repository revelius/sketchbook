<%--
 * =============================================================================
 * 파일명 : /manage/regCollabo.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : COLLABORATION 등록
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
    	
    	//파일선택
	    $('#btn_file').click(function() {
	    	openFileUploadPop("image", "imgUrl", "collaboration");
	    });	
    	
    	
    	
    	
    	//등록
	    $('#btn_reg').click(function() {
	    	var frm = document.collabo;
	    	
			if(!confirm("등록하시겠습니까?")) return false;
	    	
	    	if(!formCheck(frm)) return false; 
	    	
	    	if($("#lnkUrlYN").is(":checked") == true){
	    		$("#lnkUrl").attr("disabled", false);  
	    	}else{
	    		$("#lnkUrl").attr("disabled", true);  
	    	}
	    	
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/collaboRegAjax'/>",
   		        type: "post",
   		        data : $("form#collabo").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다."); 
   						var frm = document.hiddenForm;
   						frm.action = "<c:url value='/admin/manage/collaborationList'/>";
			 	        frm.submit();
   					} else {
   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
   					}
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });
	    });
    	
    	
    	
    	
    	function formCheck(frm){
	    	
    		if(frm.siteNo.value == ""){
	    		alert("브렌드를 선택하세요.");
	    		frm.siteNo.focus();
	    		return false;
	    	}
    		
    		if(frm.dispYn.value == ""){
	    		alert("상태를 선택하세요.");
	    		frm.dispYn.focus();
	    		return false;
	    	}
    		
    		
    		if(frm.title.value == ""){
	    		alert("제목을 입력해 주세요.");
	    		frm.title.focus();
	    		return false;
	    	}
    		
			/* 
    		if($("#lnkUrlYN").is(":checked") == true && frm.lnkUrl.value == ""){
    			alert("연결 URL을 입력해 주세요.");
    			frm.lnkUrl.focus();
    			return false;
	    	}
			 */
			 
	    	if(frm.imgUrl.value == ""){
	    		alert("메인이미지를 선택해 주세요.");
	    		//frm.imgUrl.focus();
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
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 > 게시판관리 > COLLABORATION</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
					<form id="hiddenForm" name="hiddenForm" method="post">
						<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo" value="${hiddenSiteNo}"/>
						<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm" value="${hiddenStrDtm}"/>
						<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm" value="${hiddenEndDtm}"/>
						<input type="hidden" id="hiddenSearchText" name="hiddenSearchText" value="${hiddenSearchText}"/>
					</form>
					<form:form id="collabo" name="collabo" method="post" modelAttribute="collabo" onsubmit="">
						<form:hidden path="imgUrl" id="imgUrl" name="imgUrl"/>
						<div class="tableType2">
							<table>
								<caption>archive</caption>
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
												<form:radiobuttons path="siteNo" items="${siteList}" itemLabel="siteNm" itemValue="siteNo"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">상태</th>
										<td colspan="3">
											<div class="wrap">
												<form:radiobutton path="dispYn" label="공개" value="Y"/>
												<form:radiobutton path="dispYn" label="비공개" value="N"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">제목</th>
										<td colspan="3"><form:input path="title" id="title" cssClass="ip_tit" onkeyup="chkLen(this,50);"/></td>
									</tr>
									<tr>
										<th scope="col">시즌선택</th>
										<td>
											<form:select path="seasonCd" id="seasonCd" items="${season}" itemLabel="cateNm" itemValue="cateCd"></form:select>
										</td>
										<th scope="col">콜라보선택</th>
										<td>
<%-- 											<form:select path="clbltnNm" id="clbltnNm" items="${season}" itemLabel="cateNm" itemValue="cateCd"></form:select> --%>
											<form:select path="clbltnNm" id="clbltnNm" items="${collaboNm}" ></form:select>
										</td>
									</tr>
									<tr>
										<th scope="col">메인이미지</th>
										<td class="mainImg" colspan="3">
											<span class="imgBox"><img id="imgUrl" src="" alt="" style="width: 60px; height: 60px;" /></span> 
											<div class="imgUpload">
												<a href="#" id="btn_file" class="btnType1">파일선택</a>
												<p class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</p>
											</div>
										</td>
									</tr>
									<%-- 
									<tr>
										<th scope="col"><label><input type="checkbox" id="lnkUrlYN">연결 URL</label></th>
										<td colspan="3"><form:input path="lnkUrl" id="lnkUrl" cssClass="ip_tit" maxlength="100"/></td>
									</tr>
									 --%>
								</tbody>
							</table>
						</div>
					</form:form>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType2" id="btn_reg">등록</a>
						<a href="#" class="btnType1" id="btn_cancel" onclick="javascript:window.history.back(-1); return false;">취소</a>
					</div>
					<!-- //section -->
				</div>
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