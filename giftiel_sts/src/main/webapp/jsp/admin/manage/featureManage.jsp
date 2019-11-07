<%--
 * =============================================================================
 * 파일명 : /manage/featureManage.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : FEATURE 관리
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
    	
    	
    	
   		//성별 선택
   	    $(document).on("click","a[data-btn='M'],a[data-btn='W']",function(e){  
   	    	e.preventDefault();
   	    	
   	    	if(changValueCheck()){
   	    		if(!confirm("변경된 내용이 있습니다. 이동시 변경된 내용은 저장되지 않습니다. 이동하시겠습니까?")) return false;
   	    	}
   	    	
   	    	
   	    	var $target = $(e.currentTarget);
   	    	var sex = $target.attr("data-btn");
   	    	$("input[name='sex']").val(sex);
			var siteNo = $("input[name='siteNo']").val();
   	    	
   	    	var frm = document.featureManageForm;
	    	frm.action = "<c:url value='/admin/manage/featureManage/"+siteNo+"'/>";
	        frm.submit();
   	    });	
    	
    	//파일선택
	    $(document).on("click","a[data-btn=btn_imgFind]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetImg = $target.parent().parent().find($("input[name$=imgUrl]")).attr("id");
	    	openFileUploadPop("image", targetImg, "mainManage");
	    });	
    	
    	
    	//등록
	    $(document).on("click","a[data-btn=btn_reg]",function(e){ 
	    	e.preventDefault();
	    	
			if(!confirm("등록하시겠습니까?")) return false;
	    	
	    	//if(!formCheck()) return false; 
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/featureManageRegAjax'/>",
   		        type: "post",
   		        data : $("form#featureManageForm").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다."); 
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
	    	var form = document.featureManageForm;
// 	    	if(!formCheck()) return false; 
	    	form.action = "<c:url value='/admin/manage/featurePreView'/>";
	    	form.target = "POP";
	    	
	    	var w = 1200, h = 600; // default sizes
// 	        if (window.screen) {
// 	            w = window.screen.availWidth * percent / 100;
// 	            h = window.screen.availHeight * percent / 100;
// 	        }
	    	
	    	window.open("",'POP', "toolbar=no,width="+w+", height="+h+", top=200, left=30, scrollbars=no, resizable=yes");
	    	
	    	form.submit();
	    	
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
    	
    	
    	function goodsPopup(resultId) {
			var popUrl = "<c:url value='/admin/popup/goods/popupGoodsList'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
			var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		};
    	
		
		$("img").attr("onError", "this.src = ''");
		
		
		function changValueCheck(){
			result = false;
			
			
			$.ajax({
   		        url : "<c:url value='/admin/manage/changValueCheckAjax'/>",
   		        type: "post",
   		        data : $("form#featureManageForm").serialize(),
   		        async: false,
   		        success : function(res){
   		            result = res;
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });
			
			return result;
		}
		
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
				<div class="contents productList">
					<h3><span class="icon1"></span>운영관리 > FEATURE 관리 > ${siteNm}</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- FEATURE의 MEN과 WOMEN의 관리 화면입니다.</li> -->
<!-- 							<li>- 이미지 변경 및 연결 URL, 상품, 콘텐츠 변경이 가능합니다.</li> -->
<!-- 							<li>- 상품 및 콘텐츠 연결시 검색을 통해 선택 가능합니다.</li> -->
<!-- 							<li>- 이미지는 컴퓨터에 있는 파일로 변경합니다.</li> -->
<!-- 							<li>- 최종 등록시 즉시 반영됨으로 미리보기를 통해 확인 후 변경 바랍니다</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<div class="frameLeft">
							<div class="frame"><span>1</span><img id="imgUrl1" src="<spring:eval expression="@file['upload.image']"/>${featureManage[0].imgUrl}" alt="" style="width: 100%; height: 165px; "/></div>
							<div class="frame frameType2">
								<div class="contType"><span>2</span><img id="imgUrl2" src="<spring:eval expression="@file['upload.image']"/>${featureManage[1].imgUrl}" alt="" style="width: 100%; height: 100%; " /></div>
								<div class="contType2"><span>3</span><img id="imgUrl3" src="<spring:eval expression="@file['upload.image']"/>${featureManage[2].imgUrl}" alt="" style="width: 100%; height: 100%; " /></div>
								<div class="contType2"><span>4</span><img id="imgUrl4" src="<spring:eval expression="@file['upload.image']"/>${featureManage[3].imgUrl}" alt="" style="width: 100%; height: 100%; " /></div>
							</div>
							<div class="frame frameType3"><span>5</span><img id="imgUrl5" src="<spring:eval expression="@file['upload.image']"/>${featureManage[4].imgUrl}" alt="" style="width: 100%; height: 165px; " /></div>
						</div>
						<div class="frameRight">
							<ul class="tabList linkTab">
								<li><a href="#" <c:if test="${sex eq 'M'}">class="current"</c:if> data-btn="M" >MEN</a></li>
								<li><a href="#" <c:if test="${sex eq 'W'}">class="current"</c:if> data-btn="W" >WOMEN</a></li>
							</ul>
							<div class="tableType1">
								<form:form id="featureManageForm" name="featureManageForm" method="post" modelAttribute="featureManageForm" onsubmit="">
								<input type="hidden" name="siteNo" value="${siteNo}"/>
								<input type="hidden" name="sex" value="${sex}"/>
								<table>
									<caption>feature관리</caption>
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
										<c:forEach var="listCount" begin="0" end="4"> 
										<tr data-featureNo="${featureManage[listCount].featureNo}">
											<td rowspan="2">
												<input type="hidden" id="imgUrl${listCount+1}" name="featureManage[${listCount}].imgUrl" value="${featureManage[listCount].imgUrl}"/>
												<input type="hidden" name="featureManage[${listCount}].featureNo" value="${listCount+1}"/>
											 	<span data-rowNo>${listCount+1}</span>
										    </td>
											<td>연결</td>
											<td class="tl">
												<a href="#" class="btnType2 mb5" data-btn="btn_lnk_url">URL입력</a>
												<a href="#" class="btnType1 mb5" data-btn="btn_lnk_goods">상품연결</a> <br />
												<input type="text" class="ip_tit" id="lnkUrl${listCount}" name="featureManage[${listCount}].lnkUrl" value="${featureManage[listCount].lnkUrl}"/>
											</td>
											<td  rowspan="2">
												<a href="#" class="btnType1" data-btn="btn_imgFind">찾아보기</a>
											</td>
										</tr>
										<tr>
											<td class="bd_left">내용</td>
											<td><input type="text" class="ip_tit" name="featureManage[${listCount}].txt" value="${featureManage[listCount].txt}"/></td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
								</form:form>
							</div>
						</div>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType1" data-btn="btn_preView">미리보기</a>
						<a href="#" class="btnType2" data-btn="btn_reg">등록</a>
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