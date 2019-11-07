<%--
 * =============================================================================
 * 파일명 : /manage/collaboDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : COLLABORATION 상세
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
    	
    	$("#clbltnNm option[value='${clbltnNm}']").attr("selected","selected");
    	
    	//파일선택
	    $('#btn_file').click(function() {
	    	openFileUploadPop("image", "imgUrl", "collaboration");
	    });	
    	
    	
    	//수정
	    $('#btn_update').click(function() {
	    	var frm = document.collabo;
	    	if(!confirm("저장하시겠습니까?")) return false;
	    	
	    	if(!formCheck(frm)) return false; 
	    	
	    	if($("#lnkUrlYN").is(":checked") == true){
	    		$("#lnkUrl").attr("disabled", false);  
	    	}else{
	    		$("#lnkUrl").attr("disabled", true);  
	    	}
	    	
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/collaboUpdateAjax'/>",
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
    	
    	
    	
	    //삭제
	    $('#btn_delete').on("click",function() {
	    	if(!confirm("삭제하시겠습니까?")) return false;
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/collaboDeleteAjax'/>",
   		        type: "post",
   		        data : $("form#collabo").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("삭제 되었습니다."); 
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
	    
	    //페이지 init
	    $(document).ready(function() {
			//드래그앤 드롭 테이블 초기화
			$( "#sortTable tbody" ).sortable({
	        	placeholder: "ui-state-highlight",
	        	update: function( event, ui ) {
					for ( var i = 0; i < $("#sortTable tbody tr").size(); i++) {
						$("input#cllbSortNo").eq(i).val(i+1);
					}
	        	}
	       	});
	    	$( "#sortTable tbody" ).disableSelection();
	    });   	    
	    
		//정렬순서 저장
	    $('#btn_save').click(function() {
	        var frm = document.saveForm;
	        frm.target = '_self';
	        frm.action = '/admin/goods/saveGoodsDisplayCollabo';
	        frm.submit();
	    });			    
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
						<form:hidden path="txtNo" id="txtNo" name="txtNo"/>
						<form:hidden path="imgUrl" id="imgUrl" name="imgUrl"/>
						<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo" value="${hiddenSiteNo}"/>
						<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm" value="${hiddenStrDtm}"/>
						<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm" value="${hiddenEndDtm}"/>
						<input type="hidden" id="hiddenSearchText" name="hiddenSearchText" value="${hiddenSearchText}"/>						
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
										<th scope="col">작성자</th>
										<td>${collabo.regUserNm}</td>
										<th scope="col">작성일</th>
										<td>${collabo.updDts}</td>
									</tr>
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
										<td colspan="3">
											<form:input path="title" id="title" cssClass="ip_tit" onkeyup="chkLen(this,50);"/>
										</td>
									</tr>
									<tr>
										<th scope="col">시즌선택</th>
										<td>
											<form:select path="seasonCd" id="seasonCd" items="${season}" itemLabel="cateNm" itemValue="cateCd"></form:select>
										</td>
										<th scope="col">콜라보선택</th>
										<td>
<%-- 											<form:select path="clbltnNm" id="clbltnNm" items="${season}" itemLabel="cateNm" itemValue="cateCd"></form:select> --%>
											<form:select path="clbltnNm" id="clbltnNm" items="${collaboNm}" onchange="submit();"></form:select>
										</td>
									</tr>
									<tr>
										<th scope="col">메인이미지</th>
										<td  colspan="3" class="mainImg">
											<span class="imgBox"><img id="imgUrl" src="<spring:eval expression="@file['upload.image']"/>${collabo.imgUrl}" alt="" style="width: 60px; height: 60px;" /></span>
<%-- 											<span class="imgBox"><img id="test" src="<c:url value='<spring:eval expression="@file['upload.image']"/>${collabo.imgUrl}'/>" alt="" style="width: 60px; height: 60px;" /></span>  --%>
											<div class="imgUpload">
												<a href="#" id="btn_file" class="btnType1">파일선택</a>
												<p class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</p>
											</div>
										</td>
									</tr>
									<%-- 
									<tr>
										<th scope="col"><label><input type="checkbox" id="lnkUrlYN" <c:if test="${collabo.lnkUrl ne null}">checked="checked"</c:if>>연결 URL</label></th>
										<td colspan="3"><form:input path="lnkUrl" id="lnkUrl" cssClass="ip_tit" maxlength="100"/></td>
									</tr>
									 --%>
								</tbody>
							</table>
						</div>
					</form:form>
					</div>
					
					<form:form id="saveForm" name="saveForm" method="post" onsubmit="return check(form)">
					<div class="section a2">
						<div class="tableType1">
							<table id="sortTable">
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="8%" />
								<col width="10%" />
								<col width="10%" />
								<col width="29%" />
								<col width="8%" />
								<col width="8%" />
								<col width="6%" />
								<col width="6%" />
							</colgroup>
							<thead>
								<tr>
									<th>썸네일</th>
									<th>상품코드</th>
									<th>브랜드</th>
									<th>[카테고리]<br />[브랜드]상품명[컬러]</th>
									<th>최초판매가</th>
									<th>현판매가</th>
									<th><span class="c_f00">재고</span></th>
									<th>정렬</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
									<tr>
										<td>
										<c:if test="${goods.mainImg == null}">
											<img src="<c:url value='/resources/common/images/noimages.png'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
										<c:if test="${goods.mainImg != null}">
											<img src="<c:url value='${uploadImage}${goods.mainImg}'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
											
										</td>
										<td class="p_line5">
											<p>${goods.ubiGoods.ubiGdsNo }</p>
										</td>
										<td class="p_line5">
											<p>${goods.ubiGoods.brand }</p>
										</td>
										<td class="p_line5 p_lineL">
											<p>${goods.ubiGoods.season } > ${goods.ubiGoods.category1 } > ${goods.ubiGoods.category2 }</p>
											<p>${goods.ubiGoods.ubiGdsNm }[${goods.ubiGoods.color }] ${goods.ubiGoods.ubiGdsSize }</p>
											<!-- <p class="btn"><img src="" alt="상품아이콘" /> <img src="" alt="무료배송" /> </p> -->
										</td>
										<td class="p_line5">
											<p><fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" />원</p>
										</td>
										<td class="p_line5">
											<p><fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc }" pattern="###,###" />원</p>
										</td>
										<td class="p_line5">
											<p></p>
											<p>${goods.ubiGoods.stock }개</p>
										</td>
										<td class="p_line5">
											<input type="hidden" id="ubiGdsNo" name="ubiGdsNo" value="${goods.ubiGoods.ubiGdsNo }" style="width:40px;">
											<input type="text" id="cllbSortNo" name="cllbSortNo" value="${goods.cllbSortNo }" style="width:40px;">
										</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					</form:form>					
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType2" id="btn_update">수정</a>
						<a href="javascript:void(0);" id="btn_save" class="btnType2">정렬순서 저장</a>
						<a href="#" class="btnType1" id="btn_cancel" onclick="javascript:window.history.back(-1); return false;">취소</a>
						<a href="#" class="btnType1" id="btn_delete">삭제</a>
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