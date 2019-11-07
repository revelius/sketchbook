<%--
 * =============================================================================
 * 파일명 : admin/goods/seasonConfig.jsp
 * 작성자 : 김진성
 * 작성일자 : 2016-02-24
 *
 * 파일 내용 : 시즌설정
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
		
		
		
		//우선노출 선택(시즌1)
		$("[id^='topYnPre']").click(function(e) {
			var $target = $(e.currentTarget);
			if($target.is(":checked")){
				$target.parent().next().find("[id^='topYnCur']").prop("checked" , false);
			}else{
				$target.parent().next().find("[id^='topYnCur']").prop("checked" , true);
			}
 	    });
		
		
		//우선노출 선택(시즌2)
		$("[id^='topYnCur']").click(function(e) {
			var $target = $(e.currentTarget);
			if($target.is(":checked")){
				$target.parent().prev().find("[id^='topYnPre']").prop("checked" , false);
			}else{
				$target.parent().prev().find("[id^='topYnPre']").prop("checked" , true);
			}
 	    });
		
		
		
		$("#btn_save").on("click",function(){
			
			if(!formCheck()) return false;
    		
    		if(!confirm("저장하시겠습니까?")) return false;
    		
    		
    		
   		    $.ajax({
   		        url : "<c:url value='/admin/goods/saveSeason'/>",
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
		formCheck = function(){

			var flag = true;
			$("tr[data-siteRow]").each(function(){
				if(!$(this).find("input[type='checkbox'][name$='dispYn']").is(":checked") == true){
					var site = $(this).children().eq(0).text();
					alert(site+" : SITE당 하나의 시즌은 선택해야 합니다.");
					flag = false;
					return false;
				}
			});
			if(flag == false) return flag;
			
			
			$("tr[data-siteRow]").each(function(){
				if(!$(this).find("input[type='checkbox'][name$='topYn']").is(":checked") == true){
					var site = $(this).children().eq(0).text();
					alert(site+" : 우선 노출될 시즌을 선택해 주세요.");
					flag = false;
					return false;
				}
			});
			if(flag == false) return flag;
			
			
			$("input[type='checkbox']:checked").each(function(){
				if($(this).parent().find("select").val()==""){
					alert("선택한 시즌의 시즌코드를 선택하세요");
					flag = false;
					return false;
				}
				
				if($(this).parent().find("input[name$='seasonCdDisp']").val()==""){
					alert("선택한 시즌의 시즌타이틀을 입력 하세요");
					flag = false;
					return false;
				}
			});
			
			
			//우선노출 선택만 시즌 가능하게
			$("tr[data-siteRow]").each(function(){
				var $target = $(this).find("input[type='checkbox'][name$='topYn']:checked");
				if($target.parent().find("input[type='checkbox'][name$='dispYn']").is(":checked") == false){
					var site = $(this).children().eq(0).text();
					alert(site+" : 우선 노출은 노출을 선택한 시즌만 설정 가능합니다.");
					flag = false;
					return false;
				}
			});
			if(flag == false) return flag;
			
			
			//우선노출 선택만 시즌 가능하게
			$("tr[data-siteRow]").each(function(){
				var $target1 = $(this).find("select[name$='cate1Season.seasonCd']");
				var $target2 = $(this).find("select[name$='cate2Season.seasonCd']");
				var duplFlag = $(this).find("input[type='checkbox'][name$='dispYn']:checked").length == 2;
				
				if(duplFlag && $target1.val() == $target2.val()){
					var site = $(this).children().eq(0).text();
					alert(site+" : 동일한 시즌을 설정할수 없습니다.");
					flag = false;
					return false;
				}
				
			});
			
			
			
			return flag;
	    };
	    
		
		
		
		
		
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
					<jsp:param name="onChk" value="seasonConfig"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="categoryForm" name="categoryForm" method="post" modelAttribute="categoryForm" onsubmit="">
				<div class="contents">
					<!--[s] 시즌 설정관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>시즌 설정관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 웍스아웃, 브랜드사이트 온라인샵의 시즌설정을 할 수 있습니다.</li>
								<li>- 각 사이트별 시즌설정을 선택해주세요.</li>
							</ul>
						</div>
						<div class="tableType1">
							<table>
							<colgroup>
								<col width="132px" />
								<col width="350px" />
								<col width="350px" />
							</colgroup>
							<tbody>
								<tr>
									<th>SITE</th>
									<td>시즌1</td>
									<td>시즌2</td>
								</tr>
								<c:forEach var="list" items="${categoryForm.seasonFormList}" varStatus="stat">
								<form:hidden path="seasonFormList[${stat.index}].cate1Season.siteNo"/>
								<form:hidden path="seasonFormList[${stat.index}].cate1Season.seasonGubun"/>
								<form:hidden path="seasonFormList[${stat.index}].cate2Season.siteNo"/>
								<form:hidden path="seasonFormList[${stat.index}].cate2Season.seasonGubun"/>
								<form:hidden path="seasonFormList[${stat.index}].cateOutlet.siteNo"/>
								<form:hidden path="seasonFormList[${stat.index}].cateOutlet.seasonGubun"/>
								
								<tr data-siteRow>
									<th>${list.siteNm}</th>
									<td>
										<form:checkbox path="seasonFormList[${stat.index}].cate1Season.topYn" value="Y" id="topYnPre${stat.index}"/>우선노출여부<br/>
										<form:checkbox path="seasonFormList[${stat.index}].cate1Season.dispYn" value="Y"/> 시즌선택
										<form:select path="seasonFormList[${stat.index}].cate1Season.seasonCd">
											<form:option value="">UBI 시즌코드</form:option>
											<form:options items="${seasonList}" itemLabel="cateNm" itemValue="cateCd"/>
										</form:select></br>
										시즌타이틀 <form:input path="seasonFormList[${stat.index}].cate1Season.seasonCdDisp"/>
									</td>
									<td>
										<form:checkbox path="seasonFormList[${stat.index}].cate2Season.topYn" value="Y" id="topYnCur${stat.index}"/>우선노출여부<br/>
										<form:checkbox path="seasonFormList[${stat.index}].cate2Season.dispYn" value="Y"/> 시즌선택
										<form:select path="seasonFormList[${stat.index}].cate2Season.seasonCd">
											<form:option value="">UBI 시즌코드</form:option>
											<form:options items="${seasonList}" itemLabel="cateNm" itemValue="cateCd"/>
										</form:select></br>
										시즌타이틀 <form:input path="seasonFormList[${stat.index}].cate2Season.seasonCdDisp"/>
									</td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<div class="paging">
						<div class="right">
							<a href="javascript:void(0);" id="btn_save" class="btnType2">저장</a>
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