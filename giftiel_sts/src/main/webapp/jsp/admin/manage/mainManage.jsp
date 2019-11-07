<%--
 * =============================================================================
 * 파일명 : /manage/mainMainge.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : 고객운영관리 > 메인관리 > Worksout
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
    	
    	
    	var rowHtml = "<tr data-mainNo='$count$'>";
    	rowHtml += "<td rowspan='2'>";
    	rowHtml += "<input type='hidden' id='imgUrl$count$' name='mainManage.imgUrl' value=''/>";
    	rowHtml += "<input type='hidden' name='mainManage.mainNo' value='$count$'/>";
    	rowHtml += "<span data-rowNo></span>";
    	rowHtml += "</td>";
    	rowHtml += "<td>연결</td>";
    	rowHtml += "<td class='tl'>";
    	rowHtml += "<a href='#' class='btnType2 mb5' data-btn='btn_lnk_url'>URL입력</a> ";
    	rowHtml += "<a href='#' class='btnType1 mb5' data-btn='btn_lnk_goods'>상품연결</a> ";
    	rowHtml += "<br />";
    	rowHtml += "<input type='text' class='ip_tit' id='lnkUrl$count$' name='mainManage.lnkUrl' value=''/>";
    	rowHtml += "</td>";
    	rowHtml += "<td  rowspan='2'>";
    	rowHtml += "<a href='#' class='btnType1' data-btn='btn_imgFind'>찾아보기</a><br><br>";
    	rowHtml += "<a href='#' class='btnType2' data-btn='btn_del'>삭제</a>";
    	rowHtml += "</td>";
    	rowHtml += "</tr>";
    	rowHtml += "<tr>";
    	rowHtml += "<td class='bd_left'>타이틀</td>";
    	rowHtml += "<td style='text-align: left;'>";
//     	rowHtml += "<a href='javascript:void();' id='btn_file$count$' class='btnType1'>파일선택</a><br /><br />";
		if("${siteNo}" == "10004"){
			rowHtml += "<input type='text' name='mainManage[1000].txt' id='subImgUrl$count$' class='wd_300'  value=''/>";
		}else{
			rowHtml += "<span class='imgBox'><img id='subImgUrl$count$' src='' alt='' style='width: 60px; height: 60px;' /></span>   ";
	    	rowHtml += "<a href='javascript:void();' id='btn_file$count$' class='btnType1'>파일선택</a>   ";
	    	rowHtml += "<input type='text' name='mainManage[1000].txt' id='subImgUrl$count$' class='wd_300'  readOnly = 'true' value=''/>";
		}
    	
    	rowHtml += "</td>";
    	rowHtml += "</tr>";
    	
    	
    	var rowImgHtml = "<div class='frame'><span style='font-size: xx-large;'></span><img id='imgUrl$count$' src='' alt='' style='width: 100%; height: 165px;' /></div>";
   		rowImgHtml += "<input type='hidden' name='mainNo' id='mainNo' value='$count$' />";
   		rowImgHtml += "<input type='hidden' name='sortNo' id='sortNo'/>";
    	
    	
    	//이미지파일선택
	    $(document).on("click","a[data-btn=btn_imgFind]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetImg = $target.parent().parent().find($("input[name$=imgUrl]")).attr("id");
	    	openFileUploadPop("image", targetImg, "mainManage");
	    });	
    	
	  	//타이틀 이미지 선택
	    $(document).on("click","a[id^=btn_file]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetImg = $target.parent().find("img[id^=subImgUrl]").attr("id");
	    	openFileUploadPop("image", targetImg, "mainManage");
	    });
    	
	    
    	
    	
	    
	  	//등록
	    $(document).on("click","a[data-btn=btn_reg]",function(e){ 
	    	e.preventDefault();
	    	
			if(!confirm("등록하시겠습니까?")) return false;
	    	
	    	if(!formCheck()) return false; 
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/mainManageRegAjax'/>",
   		        type: "post",
   		        data : $("form#mainManageForm").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다.");
   						location.reload();
   					} else {
   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
   					}
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });
	    	
	    });
	  	
	  	
	    //미리보기
	    $(document).on("click","a[data-btn=btn_preView]",function(e){ 
	    	e.preventDefault();
	    	var form = document.mainManageForm;
	    	if(!formCheck()) return false; 
	    	form.action = "<c:url value='/admin/manage/mainPreView'/>";
	    	form.target = "POP";
	    	
	    	var w = 1200, h = 600; // default sizes
// 	        if (window.screen) {
// 	            w = window.screen.availWidth * percent / 100;
// 	            h = window.screen.availHeight * percent / 100;
// 	        }
	    	
	    	window.open("",'POP', "toolbar=no,width="+w+", height="+h+", top=200, left=30, scrollbars=no, resizable=yes");
	    	
	    	form.submit();
	    	
	    });
	  	
    	
	    //row삭제
	    $(document).on("click","a[data-btn=btn_del]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetMainNo = $target.parent().parent().attr("data-mainNo");
	    	
	    	if(!confirm("삭제하시겠습니까?")) return false;
	    	
// 	    	$.ajax({
//    		        url : "<c:url value='/admin/manage/delMainNoAjax'/>",
//    		        type: "post",
//    		        data : "targetMainNo="+targetMainNo,
//    		        async: false,
//    		        success : function(res){
//    		            if (res != null && res > 0) {
   		            	$("img[id='imgUrl"+targetMainNo+"']").parent().remove();
   		            	$target.parent().parent().next().remove();
   		            	$target.parent().parent().remove();
   		            	setRowNo();
//    					} else {
//    						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
//    					}
//    		        },
//    		        error:function(request,status,error){
//    		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
//    		        }
//    		    });
	    });
    	
    	//추가
	    $(document).on("click","a[data-btn=btn_addRow]",function(e){ 
	    	e.preventDefault();

			var mainNo = 0;
			var flag = false;

			$.ajax({
   		        url : "<c:url value='/admin/manage/createMainNoAjax'/>",
   		        type: "post",
   		        data : "",
   		    	async: false,
   		        success : function(res){
   		            if (res != null && res > 0) {
   		            	mainNo = res;
   		            	flag = true;
   					} else {
   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
   					}
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });

			if(!flag) return;
			$("tr[data-nodata]").remove();
			
			var row = rowHtml;
			row = row.split("$count$").join(mainNo);
			$(document).find("tbody").append(row);
			
			row = rowImgHtml;
			row = row.split("$count$").join(mainNo);
			$("#sortTable").append(row);

			setRowNo();
	    });
    	
    	
	  	//URL 입력, 상품연결,콘텐츠 연결 
	    $(document).on("click","a[data-btn^=btn_lnk]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	$target.parent().find("a[data-btn^='btn_lnk']").attr("class","btnType1  mb5");
	    	$target.attr("class","btnType2 mb5");
	    	
	    	if($target.attr("data-btn") == "btn_lnk_url"){//URL입력
	    		$target.parent().find("input[name$='lnkUrl']").attr("readOnly" , false);
	    	}else if($target.attr("data-btn") == "btn_lnk_goods"){//상품연결
	    		$target.parent().find("input[name$='lnkUrl']").attr("readOnly" , true);
	    		goodsPopup($target.parent().find("input[name$='lnkUrl']").attr("id"));
	    		//goodsPopup("hiddenLnkUrl");
	    	}else if($target.attr("data-btn") == "btn_lnk_contents"){//콘텐츠연결
	    		$target.parent().find("input[name$='lnkUrl']").attr("readOnly" , true);
	    	}
	    	
	    });	
		
    	
    	
    	//row number set
    	function setRowNo(){
	    	for ( var i = 0; i < $("tbody").find("tr[data-mainNo]").size(); i++) {
	    		$("tbody").find("span[data-rowNo]").eq(i).text(i+1);
	    		$("tbody").find("input[name$='imgUrl']").eq(i).attr("name", "mainManage["+i+"].imgUrl");
	    		$("tbody").find("input[name$='mainNo']").eq(i).attr("name", "mainManage["+i+"].mainNo");
	    		$("tbody").find("input[name$='lnkUrl']").eq(i).attr("name", "mainManage["+i+"].lnkUrl");
	    		$("tbody").find("input[name$='txt']").eq(i).attr("name", "mainManage["+i+"].txt");
	    		$("img[id^='imgUrl']").parent().find("span").eq(i).text(i+1);
	    		$("input#sortNo").eq(i).val(i+1);
			}
	    	
	    	if($("tbody").find("tr[data-mainNo]").size() == 0){
	    		var row = "<tr data-nodata><td colspan='4'>해당 설정이 없습니다. 추가 버튼을선택하여 추가해 주세요</td>	</tr>";
	    		$(document).find("tbody").append(row);
	    	}
    	}
    	
    	
		function formCheck(){
			var flag = true;
			
			if($("tr[data-mainNo]").size() < 1){
				alert("추가 버튼을 눌러 등록해 주세요.");
				return false;
			}
			
			$("input[name$='imgUrl']").each(function(){
	    		if($(this).val()==""){
	    			alert("이미지를 선택해 주세요.");
	    			flag = false;
	    			return false;
	    		}
	    	});
			if(!flag) return false;
			
			
			$("input[name$='lnkUrl']").each(function(){
				if($(this).val()==""){
	    			alert("연결Url을 입력해 주세요.");
	    			flag = false;
	    			return false;
	    		}
			});
			if(!flag) return false;
			
			
// 			$("input[name$='txt']").each(function(){
// 				if($(this).val()==""){
// 	    			alert("타이틀을 입력해 주세요.");
// 	    			flag = false;
// 	    			return false;
// 	    		}
// 			});
// 			if(!flag) return false;
			
			
			
	    	return true;
	    };
	    
	    
	    function goodsPopup(resultId) {
			//var resultId = "tempGoods";
			var popUrl = "<c:url value='/admin/popup/goods/popupGoodsList'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
			var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		};
		
		
	 	//드래그앤 드롭 테이블 초기화
		$( "#sortTable" ).sortable(
 			{
	        	placeholder: "ui-state-highlight"
	        	,
	        	update: function( event, ui ) {
		 			for ( var i = 0; i < $("#sortTable div").size(); i++) {
		 				$("input#sortNo").eq(i).val(i+1);
		 				$("img[id^='imgUrl']").parent().find("span").eq(i).text(i+1);
		 			}
	        	}
       		}
		);
	   	$( "#sortTable" ).disableSelection();    
    	
    	
    });
    
    //상품팝업에서 호출함
    function callback_setGoods(goodsData, resultId){
    	goodsData = goodsData.split("|")[0];
    	var ubiGdsNo = goodsData.split(":")[0];
    	$(document).find("input[id='"+resultId+"']").val("/front/onlineShop/goodsDetail?ubiGdsNo="+ubiGdsNo);
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
					<jsp:param name="menuFlag" value="manage"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 > 메인관리 > ${siteNm}</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- 메인화면의 이미지 변경 및 연결 URL 또는 상품 변경이 가능합니다.</li> -->
<!-- 							<li>- 상품 연결시 검색을 통해 선택 가능합니다.</li> -->
<!-- 							<li>- 이미지는 컴퓨터에 있는 파일로 변경합니다.</li> -->
<!-- 							<li>- 최종 등록시 메인화면에 즉시 반영됨으로 미리보기를 통해 확인 후 변경 바랍니다.</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<!-- section -->
					<form:form id="mainManageForm" name="mainManageForm" method="post" modelAttribute="mainManageForm" onsubmit="">
					<input type="hidden" name="siteNo" value="${siteNo}"/>
					<div class="section a1 tabCon_inner">
						<div class="frameLeft" id="sortTable">
						<c:choose>
							<c:when test="${not empty mainManage}">
								<c:forEach items="${mainManage}" var="mainManage" varStatus="listCount">
								<div class='frame'><span style="font-size: xx-large;">${listCount.count}</span><img id="imgUrl${mainManage.mainNo}" src="<spring:eval expression="@file['upload.image']"/>${mainManage.imgUrl}" alt="" style="width: 250px;height: 165px" />
								<input type="hidden" name="mainNo" id="mainNo" value="${mainManage.mainNo }" />
								<input type="hidden" name="sortNo" id="sortNo" value="${mainManage.sortNo}"/>
								</div>
								</c:forEach>
							</c:when>
						</c:choose>
						</div>
						<div class="frameRight">
							<div style="color:red">※ 이미지 drag & drop으로 순서설정 가능.</div>
							<div class="tableType1">
								<table>
									<caption>메인관리</caption>
									<colgroup>
										<col width="5%" />
										<col width="10%" />
										<col width="*" />
										<col width="15%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="row">No</th>
											<th scope="row">내용</th>
											<th scope="row">연결</th>
											<th scope="row">이미지변경</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty mainManage}">
												<c:forEach items="${mainManage}" var="mainManage" varStatus="listCount">
												<tr data-mainNo="${mainManage.mainNo}">
													<td rowspan="2">
														<input type="hidden" id="imgUrl${mainManage.mainNo}" name="mainManage[${listCount.index}].imgUrl" value="${mainManage.imgUrl}"/>
														<input type="hidden" name="mainManage[${listCount.index}].mainNo" value="${mainManage.mainNo}"/>
													 	<span data-rowNo>${listCount.count}</span>
												    </td>
													<td>연결</td>
													<td class="tl">
														<a href="#" class="btnType2 mb5" data-btn="btn_lnk_url">URL입력</a>
														<a href="#" class="btnType1 mb5" data-btn="btn_lnk_goods">상품연결</a> <br />
														<input type="text" class="ip_tit" id="lnkUrl${mainManage.mainNo}" name="mainManage[${listCount.index}].lnkUrl" value="${mainManage.lnkUrl}"/>
													</td>
													<td  rowspan="2">
														<a href="#" class="btnType1" data-btn="btn_imgFind">찾아보기</a><br><br>
														<a href="#" class="btnType2" data-btn="btn_del">삭제</a>
													</td>
												</tr>
												<tr>
													<td class="bd_left">타이틀</td>
													<td style="text-align: left;">
													<c:choose>
														<c:when test="${siteNo eq '10004'}">
															<input type="text" name="mainManage[${listCount.index}].txt" id="subImgUrl${mainManage.mainNo}" class="wd_300"  value="${mainManage.txt}"/>
														</c:when>
														<c:otherwise>
	<%-- 														<input type="text" class="ip_tit" name="mainManage[${listCount.index}].txt" value="${mainManage.txt}"/> --%>
	<%-- 														<a href="javascript:void();" id="btn_file${mainManage.mainNo}" class="btnType1">파일선택</a><br /><br /> --%>
															<span class="imgBox"><img id="subImgUrl${mainManage.mainNo}" src="<c:if test="${mainManage.txt ne null}"><spring:eval expression="@file['upload.image']"/>${mainManage.txt}</c:if>" alt="" style="width: 60px; height: 60px;" /></span>
															<a href="javascript:void();" id="btn_file${mainManage.mainNo}" class="btnType1">파일선택</a>
															<input type="text" name="mainManage[${listCount.index}].txt" id="subImgUrl${mainManage.mainNo}" class="wd_300"  readOnly = "true" value="${mainManage.txt}"/>
														</c:otherwise>
													</c:choose>
													</td>
												</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr data-nodata>
													<td colspan="4">
														해당 설정이 없습니다. 추가 버튼을선택하여 추가해 주세요
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- //section -->
					</form:form>
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType1" data-btn="btn_preView">미리보기</a>
						<a href="#" class="btnType2" data-btn="btn_reg">등록</a>
						<a href="#" class="btnType2" data-btn="btn_addRow">추가</a>
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