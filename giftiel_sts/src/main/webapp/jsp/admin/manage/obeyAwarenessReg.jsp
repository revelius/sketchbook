<%--
 * =============================================================================
 * 파일명 : /manage/obeyAwarenessReg.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-08-06
 *
 * 파일 내용 : Obey 특화 메뉴 Awareness 등록페이지
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
	<jsp:include page="/jsp/common/froalaEditor2.3.2.jsp"/>
	
	<script type="text/javascript">
    $(function(){
    	
    	
    	
//     	var awnesClsListJson = ${awnesClsListJson};
    	
    	//파일선택
    	openFilePopup = function(e){
    		var imgUrl = $(e).parent().find("img").attr("id");
    		openFileUploadPop("image", imgUrl, "awareness");				
    	}; 
    	
    	//등록게시물 체크
    	chkDsp = function(e){
    		$.ajax({
   		        url : "<c:url value='/admin/manage/chkDspAjax'/>",
   		        type: "post",
   		        data : "",
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("1개의 게시물만 공개 가능합니다."); 
   						$("#dispN").prop("checked", true);
   					} 
   		        },
   		        error:function(request,status,error){
   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   		        }
   		    });
    	}; 
    	
    	//등록
    	$(document).on("click","#btn_reg",function(e){ 
    		e.preventDefault();
	    	var frm = document.awnesForm;
	    	
			if(!confirm("등록하시겠습니까?")) return false;
	    	
	    	if(!formCheck(frm)) return false; 
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/obeyAwarenessRegAjax'/>",
   		        type: "post",
   		        data : $("form#awnesForm").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다."); 
   						
   						location.href = "<c:url value='/admin/manage/obeyAwarenessList'/>";
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
	    	
    		if(frm.dispYn.value == ""){
	    		alert("상태를 선택하세요.");
	    		return false;
	    	}
    		
    		
    		if(frm.title.value == ""){
	    		alert("제목을 입력해 주세요.");
	    		return false;
	    	}
    		
    		if(frm.dtlTxt.value == ""){
	    		alert("상세내용을 입력해 주세요.");
	    		return false;
	    	}

			
			var flag = true;
			$("div[id^='clsGood']:visible,div[id^='clsImg']:visible").find("input[name$='imgUrl']").each(function(){
	    		if($(this).val()==""){
	    			alert("이미지를 선택해 주세요.");
	    			flag = false;
	    			return false;
	    		}
	    	});
			if(!flag) return false;
			
			
			var flag = true;
			$("div[id^='clsGood']:visible,div[id^='clsVideo']:visible").find("input[name$='contUrl']").each(function(){
	    		if($(this).val()==""){
	    			alert("내용을 입력해 주세요.");
	    			flag = false;
	    			return false;
	    		}
	    	});
			if(!flag) return false;
			
			
	    	return true;
	    };	
	    
    	
    	
    	
    	
    	
    	
    	//컨텐츠 초기화
    	initCont = function(){
    		
//     		alert($("input[id^='contCls']").size());
//     		alert($("label[for^='contCls']").size());

    		for( var i = 0; i < $("#sortTable").find("tbody").size(); i++) {
    			var $target = $("[data-rowNum]").eq(i);
    			
    			$target.attr("data-rowNum",i);
    			$("div[id^='clsGood']").eq(i).attr("id","clsGood"+i);
				$("div[id^='clsVideo']").eq(i).attr("id","clsVideo"+i);
				$("div[id^='clsImg']").eq(i).attr("id","clsImg"+i);
				
				$target.parent().find("input[name$='imgUrl']").attr("name","awnesCont["+i+"].imgUrl");
    			$target.parent().find("input[name$='contUrl']").attr("name","awnesCont["+i+"].contUrl");
    			$target.parent().find("input[name$='contUrl']").attr("id","awnesCont"+i);
    			$target.parent().find("input[name$='contCls']").attr("name","awnesCont["+(i+1000)+"].contCls"); //값 배열값 재설정시 radio버튼 check 해제되는 현상으로 임시 높음배열값으로 설정
//     			$target.parent().find("input[name$='contCls']").attr("name","awnesCont["+i+"].contCls");
    			$("input[name$='prir']").eq(i).attr("name","awnesCont["+i+"].prir");
    			$("input[name$='prir']").eq(i).attr("id","awnesCont"+i);
				$("input[name$='prir']").eq(i).val(i+1);
				
				
				
				for( var j = 0; j < $target.find("input[id^='contCls']").size(); j++) {
					$target.find("input[id^='contCls']").eq(j).attr("id","contCls"+i+j);
					$target.find("label[for^='contCls']").eq(j).attr("for","contCls"+i+j);
					
				};
				
				for( var k = 0; k < $target.parent().find("img[id^='imgUrl']").size(); k++) {
					$target.parent().find("img[id^='imgUrl']").eq(k).attr("id","imgUrl"+i+k);
					$target.parent().find("input[id^='imgUrl']").eq(k).attr("id","imgUrl"+i+k);
					
				};
				
			}
    		
    		
    		//값 배열값 재설정시 radio버튼 check 해제되는 현상으로 임시 설정 해준 배열값 원래대로 셋팅
    		for( var i = 0; i < $("#sortTable").find("tbody").size(); i++) {
    			var $target = $("[data-rowNum]").eq(i);
    			$target.parent().find("input[name$='contCls']").attr("name","awnesCont["+i+"].contCls");
    		}
    		
    	};
    	
    	
    	//유형선택시
    	changeCls = function(cls,obj){
    		
    		var $target = $(obj);
    		var row = $target.parents("tr").attr("data-rowNum");
    	
    		
    		var $text = $target.parents("[data-cont]").find("[data-contText]");
    		
   			if(cls == "CM00501"){ //이미지
       			$("#" + "clsGood" + row).hide();
       			$("#" + "clsGood" + row).find("input").attr("disabled",true);
       			$("#" + "clsImg" + row).show();
       			$("#" + "clsImg" + row).find("input").attr("disabled",false);
       			$("#" + "clsVideo" + row).hide();
       			$("#" + "clsVideo" + row).find("input").attr("disabled",true);
       			$text.text("이미지");
       		}else if(cls == "CM00502"){ //동영상
       			$("#" + "clsGood" + row).hide();
       			$("#" + "clsGood" + row).find("input").attr("disabled",true);
       			$("#" + "clsImg" + row).hide();
       			$("#" + "clsImg" + row).find("input").attr("disabled",true);
       			$("#" + "clsVideo" + row).show();
       			$("#" + "clsVideo" + row).find("input").attr("disabled",false);
       			$text.text("동영상");
       		}else if(cls == "CM00503"){ //상품
       			$("#" + "clsGood" + row).show();
       			$("#" + "clsGood" + row).find("input").attr("disabled",false);
       			$("#" + "clsImg" + row).hide();
       			$("#" + "clsImg" + row).find("input").attr("disabled",true);
       			$("#" + "clsVideo" + row).hide();
       			$("#" + "clsVideo" + row).find("input").attr("disabled",true);
       			$text.text("연결상품");
       		}
   			$target.parent().parent().find("input[name$='contCls']").attr("checked",false);
   			$target.attr("checked",true);
   			$target.prop("checked",true);
    	};
    	
    	
    	//드래그앤 드롭 테이블 초기화
		$("#sortTable").sortable({
			axis: "y",
			placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
        		initCont();
        	}
       	});
    	$("#sortTable").disableSelection();
    	
    	
    	
    	 /* 
    	 $("#test").sortable({
 			axis: "y",
 			placeholder: "ui-state-highlight",
//          	items: 'tbody',
//          	cursor: 'move',
         	update: function( event, ui ) {
         		initCont();
         	}
        });
    	$("#test").disableSelection();
    	 */
    	
    	//컨텐츠 추가
    	$(document).on("click" , "#btn_addCont", function(e){
    		e.preventDefault();
    		var htmlRow = "<tbody data-cont>" + $("[data-cont]").last().html().split("awnesCont").join("awnesCont[1000]") + "</tbody>" ; 
	    	$("#sortTable").append(htmlRow);
	    	$("#sortTable").find("tbody").last().find("img").attr("src","");
	    	$("#sortTable").find("tbody").last().find("input[id^='imgUrl']").val("");
	    	$("#sortTable").find("tbody").last().find("input[name$='contUrl']").val("");
   			initCont();
    	});
    	
    	
    	//컨텐츠 삭제
    	$(document).on("click" , "#btn_removeCont", function(e){
    		e.preventDefault();
    		if(!confirm("삭제하시겠습니까?")) return false;
    		
    		if($("#sortTable").find("tbody").size() <= $("input:checkbox[data-chkBox='cont']:checked").size()){
    			alert("최소한 1개의 컨텐츠는 등록 되어야 합니다.");
    			return;
    		}
    		
    		
    		$("input:checkbox[data-chkBox='cont']").each(function(index) {
    		    if($(this).is(":checked") == true){
    		    	$(this).parents("[data-cont]").remove();
    		    	
    		    }
    		});
    		
    		initCont();
    	});
    	
    	
    	initCont();
    	
    	$("#sortTable").find("tbody").last().find("[id^=contCls]").eq(0).trigger("click");
	    
	    
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
				<form:form id="awnesForm" name="awnesForm" method="post" modelAttribute="awnesForm" onsubmit="">
					<form:hidden path="awnesNo" id="awnesNo"/>
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 > 특화메뉴관리 > OBEY Awareness</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<div class="tableType2" style="border-bottom:0px;">
							<table style="border-bottom:0px;">
								<caption>awnes</caption>
								<colgroup>
									<col width="150px">
									<col width="*">
									<col width="130px">
									<col width="350px">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">작성자</th>
										<td>${admin.userNm}</td>
										<th scope="col">작성일</th>
										<td>${thisDay}</td>
									</tr>
									<tr>
										<th scope="col">상태</th>
										<td  colspan="3">
											<div class="wrap">
												<form:radiobutton path="dispYn" id="dispY" label="공개" value="Y" onclick="chkDsp()"/>
												<form:radiobutton path="dispYn" id="dispN" label="비공개" value="N" checked="checked"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">제목</th>
										<td colspan="3"><form:input path="title" id="title" cssClass="ip_tit" onkeyup="chkLen(this,50);"/></td>
									</tr>
									<tr>
										<th scope="col">상세내용</th>
										<td colspan="3"><form:textarea path="dtlTxt" id="dtlTxt" cssClass="txtareaAll" rows="10"  onkeyup="chkLen(this,4000);"/></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="tableType2">
							<table id="sortTable">
								<caption>awnes</caption>
								<colgroup>
									<col width="50px">
									<col width="100px">
									<col width="*">
									<col width="130px">
									<col width="350px">
								</colgroup>
								
								
								<tbody data-cont>
									<tr data-rowNum="0">
										<th rowspan="2">
											<input type="checkbox" data-chkBox="cont"/>
										</th>
										<th scope="col">분류</th>
										<td>
											<div class="wrap">
												<form:radiobuttons path="awnesCont[0].contCls" id="contCls" items="${awnesClsList}" itemLabel="cdNm" itemValue="cdNo"  onchange="changeCls(this.value,this);"/>
<%-- 												<c:forEach var="list" items="${awnesClsList}" varStatus="stat"> --%>
<%-- 													<input type="radio" id="tempCls${stat.index}" name="tempCls" value="${list.cdNo}" > --%>
<%-- 													<label for="tempCls${stat.index}">${list.cdNm}</label> --%>
<%-- 												</c:forEach> --%>
											</div>
										</td>
										<th scope="col">노출순서</th>
										<td>
										<form:input path="awnesCont[0].prir" readOnly="readOnly" value="1"/>
										</td>
									</tr>
									<tr>
										<th scope="col" data-contText>연결상품</th>
										<td colspan="3">
										
											
											<div id="clsGood0">
												<form:hidden path="awnesCont[0].imgUrl" id="imgUrl"/>
												<span class="imgBox"><img id="imgUrl" src="" alt="" style="width: 60px; height: 60px;" /></span>&nbsp;&nbsp;<a href="javascript:void();" id="btn_file" class="btnType1" onclick="openFilePopup(this)">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. jpg,gif,png 파일로 업로드 바랍니다.</span><br/><br/>
												 연결 url &nbsp;<form:input path="awnesCont[0].contUrl" cssClass="wd_700"  onkeyup="chkLen(this,255);"/>
												 <p class="addtxt">* 연결할 상품 url을 입력해 주세요.</p>
											</div>
											
											<div id="clsVideo0" style="display: none;">
										    <form:input path="awnesCont[0].contUrl"  cssClass="wd_700" onkeyup="chkLen(this,255);"/>
											<p class="addtxt">* 등록할 유투브 동영상 주소를 입력해 주세요.</p>
											</div>
											
											<div id="clsImg0" style="display: none;">
												<form:hidden path="awnesCont[0].imgUrl" id="imgUrl"/>
												<span class="imgBox"><img id="imgUrl" src="" alt="" style="width: 60px; height: 60px;" /></span>&nbsp;&nbsp;<a href="javascript:void();" id="btn_file" class="btnType1" onclick="openFilePopup(this)">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. jpg,gif,png 파일로 업로드 바랍니다.</span>
											</div>
										</td>
									</tr>
								</tbody>
								
								
							</table>
							
							
						</div>
<!-- 						<div class="tableType2"> -->
<!-- 							<table> -->
<!-- 							<tbody id="test"> -->
<!-- 								<tr> -->
<!-- 									<td> -->
<!-- 										<table style="margin: 0px; padding: 0px;"> -->
<!-- 										<tr> -->
<!-- 											<td>111</td> -->
<!-- 										</tr> -->
<!-- 										</tbody> -->
<!-- 										<tbody> -->
<!-- 										<tr> -->
<!-- 											<td>222</td> -->
<!-- 										</tr> -->
<!-- 										</tbody> -->
<!-- 										<tbody> -->
<!-- 										<tr> -->
<!-- 											<td>333</td> -->
<!-- 										</tr> -->
<!-- 										</table> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 							</table> -->
<!-- 						</div> -->
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<div class="left">
							<a href="#" class="btnType2" id="btn_addCont">추가</a>
							<a href="#" class="btnType1" id="btn_removeCont">선택삭제</a>
						</div>
						<div class="right">
							<a href="#" class="btnType2" id="btn_reg">등록</a>
							<a href="#" class="btnType1" onclick="javascript:window.history.back(-1); return false;">취소</a>
						</div>
					</div>
					<!-- //section -->
				</div>
				</form:form>
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