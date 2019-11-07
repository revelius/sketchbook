<%--
 * =============================================================================
 * 파일명 : admin/goods/categoryConfig.jsp
 * 작성자 : 김진성
 * 작성일자 : 2016-02-29
 *
 * 파일 내용 : 상품 카테고리설정
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
		//저장
// 	    $('#btn_save').click(function() {
// 	        var frm = document.categoryForm;
// 	        frm.target = '_self';
// 	        frm.action = 'saveSeason';
// 	        frm.submit();
// 	    });	
		
		
	$(function() { 
		
		//전체 선택
		$('#allCheck').click(function(e) {
			//var $target = $(e);
			var $target = $(e.currentTarget)
			if($target.is(":checked")){
				$("input[type='checkbox']").prop("checked" , true);
			}else{
				$("input[type='checkbox']").prop("checked" , false);
			}
 	    });	
		
		
		$("#btn_save1,#btn_save2").on("click",function(){
			
// 			if(!formCheck()) return false;
    		
    		if(!confirm("저장하시겠습니까?")) return false;
    		
    		
    		
   		    $.ajax({
   		        url : "<c:url value='/admin/goods/saveCateAjax'/>",
   		        type: "post",
   		        data : $("form#categoryForm").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다."); 
   						
   						//캐쉬삭제
   						$.ajax({
   			   		        url : "<c:url value='/common/cacheReload'/>",
   			   		        type: "get",
   			   		        data : "",
   			   		        async: true,
   			   		        success : function(res){
   			   		           
   			   		        },
   			   		        error:function(request,status,error){
   			   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   			   		        }
   			   		    });
   						
   						
   					} else {
   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
   					}
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });
    		
    	});
		
		
		
		//폼체크
// 		formCheck = function(){

// 			var flag = false;
// 			//$("input[name='cateMenDepth2']:checked").hide();
// 			//alert($("input[name='cateMenDepth2']:checked").each(function(){$(this).val()}));
			
// 			var chked_val = "";
// 			  $("input[name='cateMenDepth2']:checked").each(function(pi,po){
// 			    chked_val += ","+po.value;
// 			  });
// 			alert(chked_val);
// 			return flag;
// 	    };
	    
	    
	  	//검색
	    goSubmit = function(){
	    	 var frm = document.categoryForm;
		        frm.action = "<c:url value='/admin/goods/categoryConfig'/>";
		        frm.submit();
	    };
	    
	    
	  	//브랜드 선택
	    setSite= function(e){
	    	var $target = $(e);
	    	var siteNo = $target.attr('id');
	    	$("#siteNo").val(siteNo);
	    	$("#seasonSeq").val("");
	    	goSubmit();
	    };
	    
	  	//시즌 선택
	    setSeason= function(e){
	    	var $target = $(e);
	    	var seasonSeq = $target.attr('id');
	    	$("#seasonSeq").val(seasonSeq);
	    	goSubmit();
	    };
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    //NEW ARRIVAL명 수정
	    renameNa= function(cateDepth1){

	    	var target = "";
	    	if(cateDepth1 == "CM01501"){
	    		target = $("#menNaDispNm").val();
	    	}else{
	    		target = $("#womenNaDispNm").val();
	    	}
	    	
	    	if(trim(target) == ""){
	    		alert("값을 입력해 주세요");
	    		return false;
	    	}
	    	
	    	if(!confirm("NEW ARRIVAL명을 수정하시겠습니까??")) return false;
			$("#cateDepth1").val(cateDepth1);
	    	$.ajax({
   		        url : "<c:url value='/admin/goods/updateNaAjax'/>",
   		        type: "post",
   		        data : $("form#categoryForm").serialize(),
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
	    };
	    
		
		
		
	    $("a[data-brand='brand'][id='"+$("#siteNo").val()+"']").attr("class", "current");
	    $("a[data-season][id='"+$("#seasonSeq").val()+"']").attr("class", "current");
		
	});
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="goods"/>
					<jsp:param name="onChk" value="categoryConfig"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="categoryForm" name="categoryForm" method="post" modelAttribute="categoryForm" onsubmit="">
					<form:hidden path="siteNo" id="siteNo"/>
					<form:hidden path="seasonSeq" id="seasonSeq"/>
					<form:hidden path="cateDepth1" id="cateDepth1"/>
				<div class="contents">
					<div class="section a1">
						<h3><span class="icon1"></span>카테고리관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 온라인샵의 카테고리 노출 설정을 할 수 있습니다.</li>
							</ul>
						</div>
					</div>
					<ul class="tabList">
					<c:choose>
						<c:when test="${not empty siteList}">
<!-- 							<li><a href="#" onclick="setSite(this);" data-brand="brand" id="">ALL</a></li> -->
							<c:forEach items="${siteList}" var="site" varStatus="listCount">
								<li><a href="#" onclick="setSite(this);" data-brand="brand" id="${site.siteNo}">${site.siteNm}</a></li>
							</c:forEach>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					</ul>
					<!-- section -->
					<div class="section a2">
						<h3><span class="icon2"></span>카테고리</h3>						
						<ul class="tabList">
						<li><a href="javascript:void();">현재 등록된 시즌 : </a></li>
						<c:choose>
							<c:when test="${not empty seasonList}">
								<c:forEach items="${seasonList}" var="season" varStatus="listCount">
									<li><a href="#" onclick="setSeason(this);" data-season id="${season.SEASON_SEQ}">${season.SEASON_CD_DISP}</a></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						</ul><br/><br/>
						
						<input type="checkbox" id="allCheck"> 전체 선택 
						<a href="javascript:void(0);" id="btn_save1" class="btnType2">저장</a>
						<br/><br/>
						
						<!-- 카테고리 [s]-->
						<div class="tableType1">
							<table>
								<caption>카테고리 설정</caption>
								<colgroup>
									<col style="width: 10%" />
									<col style="width: 20%" />
									<col style="width: *" />
								</colgroup>
								<thead>
									<tr>
										<th scope="row">1DEPTH</th>
										<th scope="row">2DEPTH</th>
										<th scope="row">3DEPTH</th>
									</tr>
								</thead>
								<tbody>	
								
								<tr>
									<td rowspan="${ubiCodeList[0].tot + 1}">MEN</td>
									<td>
										<input type="checkbox" name="menNaDispYn" value="Y" <c:if test="${categoryForm.menNaDispYn eq 'Y'}">checked</c:if>>
										<form:input path="menNaDispNm" id="menNaDispNm" maxlength="20"/>&nbsp;<a href="javascript:void(0);" id="btn_renameNa_man" class="btnType2" onclick="renameNa('CM01501');">수정</a>
									</td>
									<td></td>
								</tr>
								<c:forEach items="${ubiCodeList}" var="dept2" varStatus="dept2Count">
									<c:forEach items="${dept2.subUbiCode}" var="dept3" varStatus="dept3Count">
										<tr>
											<c:if test="${dept3Count.index eq 0}">
												<td rowspan="${dept2.grpTot}" class="bd_left"><input type="checkbox" name="cateMenDepth2" value="${dept2.cateCd}" <c:if test="${fn:indexOf(categoryForm.cateMenDepth2,dept2.cateCd) > -1}">checked</c:if>  />${dept2.cateNm}</td>
											</c:if>
											<td class="bd_left" align="left"><input type="checkbox" name="cateMenDepth3" value="${dept3.cateCd}" <c:if test="${fn:indexOf(categoryForm.cateMenDepth3,dept3.cateCd) > -1}">checked</c:if> />${dept3.cateNm}</td>
										</tr>
									</c:forEach>
								</c:forEach>	
								
								<tr>
									<td rowspan="${ubiCodeList[0].tot + 1}">WOMEN</td>
<%-- 									<td><input type="checkbox" name="womenNaDispYn" value="Y" <c:if test="${categoryForm.womenNaDispYn eq 'Y'}">checked</c:if>>NEW ARRIVAL</td> --%>
									<td>
										<input type="checkbox" name="womenNaDispYn" value="Y" <c:if test="${categoryForm.womenNaDispYn eq 'Y'}">checked</c:if>>
										<form:input path="womenNaDispNm" id="womenNaDispNm" maxlength="20"/>&nbsp;<a href="javascript:void(0);" id="btn_renameNa_woman" class="btnType2" onclick="renameNa('CM01502');">수정</a>
									</td>
									<td></td>
								</tr>
								<c:forEach items="${ubiCodeList}" var="dept2" varStatus="dept2Count">
									<c:forEach items="${dept2.subUbiCode}" var="dept3" varStatus="dept3Count">
										<tr>
											<c:if test="${dept3Count.index eq 0}">
												<td rowspan="${dept2.grpTot}" class="bd_left"><input type="checkbox" name="cateWomenDepth2" value="${dept2.cateCd}" <c:if test="${fn:indexOf(categoryForm.cateWomenDepth2,dept2.cateCd) > -1}">checked</c:if>  />${dept2.cateNm}</td>
											</c:if>
											<td class="bd_left" align="left"><input type="checkbox" name="cateWomenDepth3" value="${dept3.cateCd}" <c:if test="${fn:indexOf(categoryForm.cateWomenDepth3,dept3.cateCd) > -1}">checked</c:if> />${dept3.cateNm}</td>
										</tr>
									</c:forEach>
								</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 카테고리 [e]-->
						<div <c:if test="${categoryForm.siteNo ne '10001'}"> style="display: none;"</c:if>>
						</br></br></br>
						<h3><span class="icon2"></span>브랜드</h3></br>
						
						<!-- 브랜드 [s]-->
						
						<div class="tableType1">
							<table>
								<caption>브랜드 설정</caption>
								<colgroup>
									<col style="width: *" />
								</colgroup>
								<thead>
									<tr>
										<th scope="row">MEN</th>
										<th scope="row">WOMEN</th>
									</tr>
								</thead>
								<tbody>	
								
								<c:forEach items="${brandList}" var="brand" varStatus="brandCount">
									<tr>
										<td><input type="checkbox" name="brandCd" value="${brand.cdNm}" <c:if test="${fn:indexOf(categoryForm.brandCd,brand.cdNm) > -1}">checked</c:if> />${brand.cdDesc}</td>
										<td><input type="checkbox" name="brandCd2" value="${brand.cdNm}" <c:if test="${fn:indexOf(categoryForm.brandCd2,brand.cdNm) > -1}">checked</c:if> />${brand.cdDesc}</td>
									</tr>
								</c:forEach>	
								
								</tbody>
							</table>
						</div>
						
						<!-- 브랜드 [e]-->
						</div>
					</div>
					<!-- //section -->
					<div class="paging">
						<div class="right">
							<a href="javascript:void(0);" id="btn_save1" class="btnType2">저장</a>
						</div>
					</div>
						
					<!--[e] 시즌 설정관리 -->
				</div>
				</form:form>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->
		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

	</div>
</body>
</html>