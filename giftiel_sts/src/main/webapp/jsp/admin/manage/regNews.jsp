<%--
 * =============================================================================
 * 파일명 : /manage/regNews.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : News 등록
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
    $(function() { 
	
//     	$("textarea#txt").editable({inlineMode: false, language: 'ko', theme: 'gray'});
// 		ver2.0
    	$("textarea#txt").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
    	$("#txtCls1").attr("checked",true);
//     	$("#clsImg").hide();
		$("#clsVideo").hide();
		
		// datepicker 
		$(".datepicker1").datepicker({
			inline: true, 
			dateFormat: "yy.mm.dd",    /* 날짜 포맷 */ 
			showOn: "both", 
			buttonImage: "<c:url value='/resources/admin/images/common/icon_calender.gif'/>",
			buttonImageOnly: true, 
			minDate: '-30y', 
			showMonthAfterYear: true,   /* 년과 달의 위치 바꾸기 */ 
			/* 한글화 */ 
			monthNames : ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'], 
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
			showAnim: 'slideDown', 
			/* 날짜 유효성 체크 */ 
			onClose: function( selectedDate ) { 
			  $('#fromDate').datepicker("option","minDate", selectedDate); 
			} 
		});
		$('#ui-datepicker-div').addClass('dateCal');
    	
		//datepicker 위치조절
	    $("img.ui-datepicker-trigger").attr("style", "margin-left:2px; vertical-align:middle; cursor: Pointer;");
		
    	//파일선택
    	openFilePopup = function(num){
    		if (num != null) {
    			openFileUploadPop("image", "imgUrl"+num, "news");				
			}
    	};
    	
    	openFilePopupThum =function(num){
    		if (num != null) {
    			openFileUploadPop("image", "thmbUrl"+num, "news");				
			}
    	}; 
    	//등록
    	$("#btn_reg").on("click",function(){
    		
    		if(!confirm("저장하시겠습니까?")) return false;
    		
	    	var frm = document.newsForm;
	    	
		    if(!formCheck(frm)) return false;
		    
	    	$.ajax({
		        url : "<c:url value='/admin/manage/regNewsProc'/>",
		        type: "post",
		        data : $("form#newsForm").serialize(),
		        async: true,
		        success : function(res){
		            if (res > 0) {
						alert("저장하였습니다."); 
						var frm = document.hiddenForm;
   						frm.action = "<c:url value='/admin/manage/newsList'/>";
			 	        frm.submit();
					} else {
						alert("저장에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		   	});
    	
   		});
    	
    	
    	//유형선택시
    	changeCls = function(cls,obj){
    		var $target = $(obj);
    		var row = $target.parents("tr").attr("data-rowNum");
    		
    		if(row!="main"){
    			if(cls == "CM00501"){
        			$("#" + "clsImg" + row).show();
        			$("#" + "clsVideo" + row).hide();
        			$("input[id=movUrl" + row+ "]").val("");
        		}else{
        			$("#" + "clsImg" + row).hide();
        			$("#" + "clsVideo" + row).show();
        			$("input[id=imgUrl" + row + "]").val("");
            		$("img[id=imgUrl" + row + "]").attr("src","");
        		}
    		}else{
    			if(cls == "CM00501"){
        			$("#clsImg").show();
        			$("#clsVideo").hide();
        			$("input[id=movUrl]").val("");
        		}else{
        			$("#clsImg").hide();
        			$("#clsVideo").show();
        			$("input[id=imgUrl]").val("");
            		$("img[id=imgUrl]").attr("src","");
        		}
    		}
    	};
    	
    	
    	//메인이미지초기화
    	initImg = function(num){
    		if (num != null) {
        		if(!confirm("삭제하시겠습니까?")) return false;
        		
        		$("input[id=imgUrl" + num + "]").val("");
        		$("img[id=imgUrl" + num + "]").attr("src","");	
			}
    	};
    	
    	//리스트 썸네일 초기화
    	initThumImg = function(num){
    		if (num != null) {
        		if(!confirm("삭제하시겠습니까?")) return false;
        		
        		$("input[id=thmbUrl" + num + "]").val("");
        		$("img[id=thmbUrl" + num + "]").attr("src","");	
			}
    	};
    	
    	//추가 컨텐츠삭제
    	delRow = function(obj){
    		
    		var $target = $(obj);
    		var row = $target.parents("tr").attr("data-rowNum");
    		
    		if (row != null) {
         		if(!confirm("삭제하시겠습니까?")) return false;
        		$("tr[id^='addRow']").eq(row).remove();
			}
    		setRowNo();
    	};
    	
    	
    	//row number set
    	function setRowNo(){
    		var rowNum = $("tr[id^='addRow']").length;
    		if(rowNum == 0){
    			$("a[id='btn_add']").show();
    		}else{
    			$("a[id='btn_add']").hide();
    		}
    		
	    	for ( var i = 0; i < rowNum; i++) {
	    		$target = $("tr[id^='addRow']").eq(i);
	    		$target.attr("id","addRow"+i);
	    		$target.attr("data-rowNum",i);
	    		$target.find("[name$='addContType']").attr("name","newsCont["+i+"].addContType");
	    		$target.find("[name$='addContAddr']").attr("name","newsCont["+i+"].addContAddr");
	    		$target.find("a[id^=btn_delRow]").attr("id","btn_delRow"+i);
	    		$target.find("span[id='viewArea']").text(i+2);
	    		
	    		$target.find("div[id^='clsImg']").attr("id","clsImg"+i);
	    		$target.find("div[id^='clsVideo']").attr("id","clsVideo"+i);
	    		
	    		
	    		if(i==rowNum-1){
	    			$target.find("a[id^='btn_add']").show();
	    		}else{
	    			$target.find("a[id^='btn_add']").hide();
	    		}
	    		
	    		
	    		
			}
    	}
    	
    	
    	
		function formCheck(frm){
	    	
    		if($("input:checkbox[name='siteNo']").is(":checked") == false){
	    		alert("브랜드를 선택하세요.");
	    		return false;
	    	}
    		
    		if(frm.txtTp.value == ""){
	    		alert("분류를 선택하세요.");
	    		return false;
	    	}
    		
    		if(frm.topBnnrDispYn.value == ""){
    			alert("탑배너 노출여부를 선택하세요.");
    			return false;
    		}
    		
    		if(frm.dispYn.value == ""){
	    		alert("상태를 선택하세요.");
	    		return false;
	    	}
    		if(frm.etc1.value == ""){
	    		alert("등록일자를 선택하세요.");
	    		return false;
	    	}
    		if(frm.etc2.value == ""){
	    		alert("작성자명을 선택하세요.");
	    		return false;
	    	}
    		
    		if(frm.title.value == ""){
	    		alert("제목을 입력해 주세요.");
	    		return false;
	    	}
    		
    		if(frm.preview.value == ""){
	    		alert("텍스트 프리뷰를 입력해 주세요.");
	    		return false;
	    	}
    		
    		if(frm.thmbUrl.value == ""){
	    		alert("리스트 썸네일 이미지를 선택해 주세요.");
	    		return false;
	    	}
	
    		if(frm.sldDispYn.value == ""){
	    		alert("슬라이드 사용 유/무를 선택하세요.");
	    		return false;
	    	}
	    	
			if(frm.sldDispYn.value == "Y"){
	    		if(frm.txtCls.value == "CM00501"){
	    			if(frm.imgUrl.value == ""){
	    				alert("슬라이드 사용으로 선택되어 있습니다.");
	    	    		return false;
	    	    	}
	    		}else if(frm.txtCls.value == "CM00502"){
	    			if(frm.movUrl.value == ""){
	    				alert("슬라이드 사용으로 선택되어 있습니다.");
	    	    		return false;
	    	    	}
	    		}
			}
    		
    		if(frm.txt.value == ""){
	    		alert("컨텐츠 내용을 입력해 주세요.");
	    		return false;
	    	}
    		
    		
    		if(frm.sldDispYn.value == "Y"){
	    		var rowNum = $("tr[id^='addRow']").length;
	    		
	    		for ( var i = 0; i < rowNum; i++) {
	    			$target = $("tr[id^='addRow']").eq(i);
	    			if($target.find("[name$='addContType']").val() !=""){
	    				if($target.find("[name$='addContType']:checked").val() == "CM00501"){
	   						if($target.find("input[id^='imgUrl']").val()==""){
	    						alert("추가 슬라이드 이미지를 선택해 주세요");
	    						return false;
	   						}
	            			$target.find("[name$='addContAddr']").val($target.find("input[id^='imgUrl']").val());
	            		}else{
	            			if($target.find("input[id^='movurl']").val()==""){
	    						alert("추가 슬라이드 동영상주소를 입력해 주세요");
	    						return false;
	    					}
	            			$target.find("[name$='addContAddr']").val($target.find("input[id^='movurl']").val());
	            		}
	    			}else{
	    				alert("추가 슬라이드 유형을 선택하세요");
	    				return false;
	    			}
	    			
	    			
	    		}
    		}
    		
    		
    		
    		
	    	return true;
	    };
	    //보고있던 브랜드에서 등록버튼 선택시 해당 브랜드 default 체크
	    $("input[value='"+$("#hiddenSiteNo").val()+"']").attr("checked", true);	    	

		imgMovieAddRow = function(e){
	    	var rowNum = $("tr[id^='addRow']").length;
	    	var viewNumber = rowNum+2;
			if (rowNum < 50) {
		    var htmlRow = "	<tr id='addRow" + rowNum + "' data-rowNum='"+rowNum+"'>"+
					"		<th scope='col'>슬라이드<br />이미지/동영상 <br />(<span id='viewArea'>" + viewNumber + "</span>)<br /><a href='javascript:void(0);' onclick='imgMovieAddRow();' class='btnType2 btnAdd' id='btn_add" + rowNum+ "'>추가</a>&nbsp;<a href='javascript:void(0);' onclick='delRow(this);' class='btnType2 btnAdd' id='btn_delRow" + rowNum+ "'>삭제</a></th>"+
					"		<td colspan='3'>"+
					"			<input type='hidden'name='newsCont["+rowNum+"].addContAddr' id='addContAddr'/>"+
					"			<div class='wrap'>"+
					"				<span>"+
					"				<input type='radio' name='newsCont["+rowNum+"].addContType' id='txtCls1_" + rowNum + "' onchange='changeCls(this.value, this);' value='CM00501' checked/>"+
					"				<label for='txtCls1_" + rowNum + "'>이미지</label>"+
					"				</span>"+
					"				<span>"+
					"				<input type='radio' name='newsCont["+rowNum+"].addContType' id='txtCls2_" + rowNum  + "' onchange='changeCls(this.value, this);' value='CM00502'/>"+
					"				<label for='txtCls2_" + rowNum + "'>동영상</label>"+
					"				</span>"+				
					"			</div>"+
					"			<div id='clsImg" + rowNum + "'>"+
					"				<a href='javascript:void(0);' id='btn_file" + rowNum + "' class='btnType1' onclick='openFilePopup(" + rowNum + ")'>파일선택</a> <span class='addtxt'>*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />"+
					"				<span class='imgBox'><img id='imgUrl" + rowNum + "' src='' alt='' style='width: 60px; height: 60px;' /></span>"+
					"				<input id='imgUrl" + rowNum + "' name='imgUrl" + rowNum + "' class='wd_200' readonly='true' type='text' checked='checked' />"+
					"			</div>"+			
					"			<div id='clsVideo" + rowNum + "'>"+
					"				<input type='text' id='movurl" + rowNum + "' name='movUrl" + rowNum + "' class='ip_tit' maxlength=500 />"+
					"				<p class='addtxt'>* 유투브 동영상은 '소스코드'를 복사해서 등록, 비메오 동영상은 Share에 '임베딩' 을 복사해서 등록해주세요. </p>"+
					"			</div>"+
					"		</td>"+
					"	</tr>";	  
   	

		    	$("tbody[id='contentTbody']").find("tr:last").before(htmlRow);
	   			$("#"+ "clsVideo"+rowNum).hide();		
	   			
	   			setRowNo();
			}else{
				alert("추가 갯수를 초과하였습니다.");
				return false; 
			}

	    };
	    
	    $("input[name=sldDispYn]").click(function(){
	    	if($(this).val() == 'N'){
	    		$("#mainRow").hide();
	    		$("tr[id^='addRow']").hide();
	    	}else{
	    		$("#mainRow").show();
	    		$("tr[id^='addRow']").show();
	    	}
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
				<form id="hiddenForm" name="hiddenForm" method="post">
					<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo" value="${hiddenSiteNo}"/>
					<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm" value="${hiddenStrDtm}"/>
					<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm" value="${hiddenEndDtm}"/>
					<input type="hidden" id="hiddenNewsType" name="hiddenNewsType"  value="${hiddenNewsType}"/>
					<input type="hidden" id="hiddenSearchGb" name="hiddenSearchGb"  value="${hiddenSearchGb}"/>
					<input type="hidden" id="hiddenSearchText" name="hiddenSearchText" value="${hiddenSearchText}"/>
				</form>
				<form:form id="newsForm" name="newsForm" method="post" modelAttribute="newsForm" onsubmit="">
				<div class="contents">
					<h3><span class="icon1"></span>운영관리 &gt; 게시판관리 &gt; News</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<div class="tableType2">
							<table>
								<caption>News</caption>
								<colgroup>
									<col width="130px">
									<col width="*">
									<col width="130px">
									<col width="350px">
								</colgroup>
								<tbody id="contentTbody">
									<tr>
										<th scope="col">브랜드</th>
										<td colspan="3">
											<div class="wrap">
												<form:checkboxes path="siteNo" id="siteNo" items="${siteList}" itemLabel="siteNm" itemValue="siteNo"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">분류</th>
										<td>
											<form:select path="txtTp" id="txtTp" items="${newsTypeList}" itemLabel="cdNm" itemValue="cdNo"/>
										</td>
										<th scope="col">상태</th>
										<td>
											<div class="wrap">
												<form:radiobutton path="dispYn" label="공개" value="Y"/>
												<form:radiobutton path="dispYn" label="비공개" value="N"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col">탑배너 노출여부</th>
										<td colspan="3">
											<div class="wrap">
												<form:radiobutton path="topBnnrDispYn" label="공개" value="Y"/>
												<form:radiobutton path="topBnnrDispYn" label="비공개" value="N"/>
											</div>
										</td>
									</tr>										
									<tr>
										<th scope="col">등록일자</th>
										<td>
											<div class="wrap">
												<form:input path="etc1" id="etc1" readonly="true" cssClass="datepicker1"/> <span class="addtxt">&nbsp;* 사용자 화면에 표시되는 날짜입니다.</span>
											</div>
										</td>
										<th scope="col">작성자</th>
										<td>
											<form:input path="etc2" id="etc2" cssClass="wd_270" onkeyup="chkLen(this,50);" />
										</td>
									</tr>
									<tr>
										<th scope="col">제목</th>
										<td colspan="3"><form:input path="title" id="title" cssClass="ip_tit" onkeyup="chkLen(this,100);"/></td>
									</tr>
									
									<!-- [s]추가 -->
									<tr>
										<th scope="col">텍스트 프리뷰</th>
										<td colspan="3"><form:input path="preview" id="preview" cssClass="ip_tit" maxlength="300" onkeyup="chkLen(this,300);"/></td>
									</tr>
									<tr>
										<th scope="col">리스트 썸네일</th>
										<td colspan="3">
											<a href="javascript:void(0);" id="btn_fileList" class="btnType1" onclick="openFilePopupThum('1')">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />
											<span class="imgBox"><img id="thmbUrl1" src="" alt="" style="width: 60px; height: 60px;" /></span>
											<form:input path="thmbUrl" id="thmbUrl1" cssClass="wd_200"  readOnly = "true"/><a href="javascript:void(0);" onclick="initThumImg('1');"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
										</td>
									</tr>
									<tr>
										<th scope="col">슬라이드 사용 유/무</th>
										<td colspan="3"><div class="wrap">
												<form:radiobutton path="sldDispYn" label="사용" value="Y"/>
												<form:radiobutton path="sldDispYn" label="사용안함" value="N"/>
											</div></td>
									</tr>
									<!-- [e]추가 -->
									
									<tr id="mainRow" data-rowNum="main">
										<th scope="col">슬라이드<br/>이미지/동영상 <br />(1)<br /><a href="javascript:void(0);" onclick="imgMovieAddRow();" class="btnType2 btnAdd" id="btn_add">추가</a></th>
										<td colspan="3">
											<div class="wrap">
												<form:radiobuttons path="txtCls" id="txtCls" items="${newsClsList}" itemLabel="cdNm" itemValue="cdNo" onchange="changeCls(this.value,this);"/>
											</div>
											
											<div id="clsImg">
												<a href="javascript:void(0);" id="btn_file" class="btnType1" onclick="openFilePopup('')">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />
												<span class="imgBox"><img id="imgUrl" src="" alt="" style="width: 60px; height: 60px;" /></span>
												<form:input path="imgUrl" id="imgUrl" cssClass="wd_200"  readOnly = "true"/><a href="javascript:void(0);" onclick="initImg('');"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
											</div>
											
											<div id="clsVideo">
											<form:input path="movUrl" id="movUrl1" cssClass="ip_tit" maxlength="500"/>
											<p class="addtxt">* 유투브 동영상은 '소스코드'를 복사해서 등록, 비메오 동영상은 Share에 '임베딩' 을 복사해서 등록해주세요.</p>
											</div>
											 
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<form:textarea path="txt" id="txt" cssClass="txtareaAll"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="javascript:void(0);" class="btnType2" id="btn_reg">등록</a>
						<a href="javascript:void(0);" class="btnType1" id="btn_cancel" onclick="javascript:window.history.back(-1); return false;">취소</a>
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