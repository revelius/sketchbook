<%--
 * =============================================================================
 * 파일명 : /manage/regLookbook.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : lookbook 등록
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
    	
    	//전체선택 체크박스
    	$(document).on("click" ,"input[data-chkBox='allcheck']",function(e){
    		var $target = $(e.currentTarget);
			if($target.is(":checked")) {
				$target.parent().parent().parent().parent().find("input[data-chkBox='gds']").prop("checked",true);
			} else {
				$target.parent().parent().parent().parent().find("input[data-chkBox='gds']").prop("checked",false);
			}
		});
    	
    	
    	//드래그앤 드롭 테이블 초기화
		$("table[data-sort='sortTable'] tbody").sortable({				
			axis: "y",
        	placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
				for ( var i = 0; i < $(this).find("tr").size(); i++) {
					lnkGdsNumInit($(this),i);
				}
        	}
       	});
		$( "table[data-sort='sortTable'] tbody" ).disableSelection();
    	
    	
    	//파일선택
	    $(document).on("click","a[data-btnId=btn_file]",function(e){  
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetImg = $target.attr("data-target");
	    	
	    	openFileUploadPop("image", targetImg, "lookbook");
	    });	
	    
	    
	
    	//등록
    	$(document).on("click","#btn_reg",function(e){ 
	    	var frm = document.lookbook;
	    	
			if(!confirm("등록하시겠습니까?")) return false;
	    	
	    	if(!formCheck(frm)) return false; 
	    	
	    	$.ajax({
   		        url : "<c:url value='/admin/manage/lookbookRegAjax'/>",
   		        type: "post",
   		        data : $("form#lookbook").serialize(),
   		        async: false,
   		        success : function(res){
   		            if (res > 0) {
   						alert("저장 되었습니다."); 
   						var frm = document.hiddenForm;
   						frm.action = "<c:url value='/admin/manage/lookbookList'/>";
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
	    		return false;
	    	}
    		
    		if(frm.dispYn.value == ""){
	    		alert("상태를 선택하세요.");
	    		return false;
	    	}
    		
    		
    		if(frm.title.value == ""){
	    		alert("제목을 입력해 주세요.");
	    		return false;
	    	}

			
			var flag = true;
			$("input[name$='imgUrl']").each(function(){
				if($(this).val()=="" && $(this).parent().attr("class") == "mainImg"){
	    			alert("이미지를 선택해 주세요.");
	    			flag = false;
	    			return false;
	    		}
	    	});
			
			if(!flag) return false;
			
			
			flag = true;
			$("input[name$='dtlImgUrl']").each(function(){
	    		if($(this).val()==""){
	    			alert("디테일 이미지를 선택해 주세요.");
	    			flag = false;
	    			return false;
	    		}
	    	});
			if(!flag) return false;
			
			
			$("tbody[id^='linkGds']").each(function(){
// 	    		if($(this).find($("tr[data-count]")).size() < 1){
// 	    			alert("연결상품을 추가해 주세요.");
// 	    			flag = false;
// 	    			return false;
// 	    		}
	    		
	    		if($(this).find($("tr[data-count]")).size() > 50){
	    			alert("연결상품은 최대 50개까지 가능합니다.");
	    			flag = false;
	    			return false;
	    		}
	    		
	    	});
			
			if(!flag) return false;
			
	    	return true;
	    };	
	    
	    
	    
	    
	    //상품선택 - 상품선택 팝업 완료될때 까지 test
	    $(document).on("click","a[data-btnId=btn_goodsLnk]",function(e){ 
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
			var targetId = $target.parent().find("tbody").attr("id");
			
			goodsPopup(targetId);
	    	
	    });
	    	
	  
	    //직접입력
	    $(document).on("click","a[data-btnId=btn_psnlReg]",function(e){ 
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	var targetTbody = $target.parent().find("tbody").attr("id");
	    	openPersonallyRegisterPop("image", "imgUrl", "lookbook",targetTbody);
	    });
    
	    
	    //이미지 추가
	    $(document).on("click","#btn_addImg",function(e){ 
    		e.preventDefault();
    		addImg(imgRowHtml);
    		 
			$("table[data-sort='sortTable'] tbody").sortable({	
    			axis: "y",
            	placeholder: "ui-state-highlight",
            	update: function( event, ui ) {
    				for ( var i = 0; i < $(this).find("tr").size(); i++) {
    					lnkGdsNumInit($(this),i);
    				}
            	}
           	});
			$( "table[data-sort='sortTable'] tbody" ).disableSelection();
    		
    		for ( var i = 0; i < $("input[data-imgPrir]").size(); i++) {
				$("input[data-imgPrir]").eq(i).val(i+2);
			}
    		
	    });
	    
	    
	    
	    
	  	//이미지 샂제
	    $(document).on("click","#btn_removeImg",function(e){ 
    		e.preventDefault();
    		if(!confirm("삭제하시겠습니까?")) return false;
    		$("input:checkbox[data-chkBox='img']").each(function(index) {
    		    if($(this).is(":checked") == true){
    		    	var targetCnt = $(this).attr("data-imgRowNum");
    		    	$("tr[data-imgRowNum="+targetCnt+"]").remove();
    		    }
    		});
    		
    		for ( var i = 0; i < $("input[data-imgPrir]").size(); i++) {
				$("input[data-imgPrir]").eq(i).val(i+2);
			}
    		
	    });

	    
	    
    	
    	
    	//연결상품 삭제
    	$(document).on("click","#btn_gesDel",function(e){
    		e.preventDefault();
    		var $target = $(e.currentTarget);
    		if(!confirm("삭제하시겠습니까?")) return false;
    		
    		$target.parent().parent().parent().find("input:checkbox[data-chkBox='gds']").each(function(index) {
    		    if($(this).is(":checked") == true){
    		    	var targetCnt = $(this).attr("data-gdsRowNum");
    		    	$(this).parent().parent().parent().find("tr[data-subCount="+targetCnt+"]").remove();
    		    }
    		});
    		
    		
    		for ( var i = 0; i < $target.parent().parent().parent().find("tr").size(); i++) {
    			lnkGdsNumInit($target.parent().parent().parent(),i);
    		}
    		
	    });
	    
	   
    	//상품선택 팝업
    	function goodsPopup(resultId) {
			var popUrl = "<c:url value='/admin/popup/goods/popupGoodsList'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
			var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		};
	    
	    
    });
    
    
    var goodsLnkHtml = "<tr data-count=$count$ data-subCount=$subCount$>";
    goodsLnkHtml += "<td>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].imgUrl' value='$imgUrl$'/>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].gdsNm' value='$gdsNm$'/>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].ubiGdsNo' value='$ubiGdsNo$'/>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].linkUrl' value='$linkUrl$'/>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].slPrc' value='$slPrc$'/>";
    goodsLnkHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].prir' value='' data-sort='prir'/>";
    goodsLnkHtml += "<input type='checkbox'  data-chkBox='gds'  data-gdsRowNum='$subCount$'/></td>";
    goodsLnkHtml += "<td>$gubun$</td>";
    goodsLnkHtml += "<td class='tl'>$gdsNm$</td>";
    goodsLnkHtml += "<td>$linkUrl$</td>";
    goodsLnkHtml += "<td class='tr'>$slPrc$</td>";
    goodsLnkHtml += "<td><span data-sort='prir'></span></td>";
    goodsLnkHtml += "</tr>";
    
    
    
    
    //상품팝업에서 호출함
    function callback_setGoods(goodsData, resultId){
    	goodsData = goodsData.split("|")[0];
    	var ubiGdsNo = goodsData.split(":")[0];
    	var gdsNm = goodsData.split(":")[1];
    	var ubiSlPrc = goodsData.split(":")[2];
    	var stock = goodsData.split(":")[3];
    	var mainImg = goodsData.split(":")[4];

		var $target = $("tbody[id="+resultId+"]");
		
		var count = $target.attr("data-count");
    	arrGdsCnt[count] += 1;
		
    	var row = goodsLnkHtml;
		row = row.split("$count$").join(count);
		row = row.split("$subCount$").join(arrGdsCnt[count]);
		row = row.split("$gubun$").join("상품선택");
		row = row.split("$imgUrl$").join(mainImg);
		row = row.split("$gdsNm$").join(gdsNm);
		row = row.split("$ubiGdsNo$").join(ubiGdsNo);
		row = row.split("$linkUrl$").join("/front/onlineShop/goodsDetail?ubiGdsNo="+ubiGdsNo);
		row = row.split("$slPrc$").join(ubiSlPrc);
		
		$target.append(row);
		
    	for ( var i = 0; i < $target.find("tr").size(); i++) {
    		lnkGdsNumInit($target,i);
		}
	}
    
    
    var imgElementCnt = 0;
    var arrGdsCnt =  Array();
    arrGdsCnt[0] = -1;
    
    $("#table").html();
    
    var imgRowHtml = "<tr data-imgRowNum='$count$'>";
    imgRowHtml += "<th rowspan='3'><input type='checkbox' data-chkBox='img'  data-imgRowNum='$count$'/></th>";
    imgRowHtml += "<th scope='col'>이미지</th>";
    imgRowHtml += "<td colspan='3' class='mainImg'>";
    imgRowHtml += "<input type='hidden' id='imgUrl$count$' name='intgBoardCnts[$count$].imgUrl' />";
    imgRowHtml += "<input type='hidden' name='intgBoardCnts[$count$].imgCls' value='CM00602'/>";
    imgRowHtml += "<input type='hidden' name='intgBoardCnts[$count$].prir' data-imgPrir value=''/>";
    imgRowHtml += "<span class='imgBox'><img id='imgUrl$count$' src='' alt='' style='width: 60px; height: 60px;'/></span> ";
    imgRowHtml += "<div class='imgUpload'>";
    imgRowHtml += "<a href='#' data-btnId='btn_file' data-target='imgUrl$count$' class='btnType1'>파일선택</a>";
    imgRowHtml += "<p class='addtxt'>*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</p>";
    imgRowHtml += "</div>";
    imgRowHtml += "</td>";
    imgRowHtml += "</tr>";
    
    imgRowHtml += "<tr data-imgRowNum='$count$'>";
    imgRowHtml += "<th scope='col'>디테일 이미지</th>";
    imgRowHtml += "<td colspan='3' class='mainImg'>";
    imgRowHtml += "<input type='hidden' id='dtlImgUrl$count$' name='intgBoardCnts[$count$].dtlImgUrl' />";
    imgRowHtml += "<span class='imgBox'><img id='dtlImgUrl$count$' src='' alt='' style='width: 60px; height: 60px;'/></span> ";
    imgRowHtml += "<div class='imgUpload'>";
    imgRowHtml += "<a href='#' data-btnId='btn_file' data-target='dtlImgUrl$count$' class='btnType1'>파일선택</a>";
    imgRowHtml += "<p class='addtxt'>*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</p>";
    imgRowHtml += "</div>";
    imgRowHtml += "</td>";
    imgRowHtml += "</tr>";
    
    imgRowHtml += "<tr data-imgRowNum='$count$'>";
    imgRowHtml += "<th scope='col'>연결상품</th>";
    imgRowHtml += "<td colspan='3' class='tblDndWrap'>";
    imgRowHtml += "<a href='#' class='btnType1' data-btnId='btn_goodsLnk'>상품선택</a>  ";
    //직접입력 버튼 임시 숨김
    //imgRowHtml += "<a href='#' class='btnType1' data-btnId='btn_psnlReg'>직접입력</a>";
    imgRowHtml += "<span class='addtxt'>* 연결상품은 최대 50개까지 가능합니다.</span> <br />";
    imgRowHtml += "<div class='tableType1 tableInTbl tblYscroll' style='height: 147px;'>";
    imgRowHtml += "<table class=''    data-sort='sortTable'>";
    imgRowHtml += "<caption></caption>";
    imgRowHtml += "<colgroup>";
    imgRowHtml += "<col width='5%' />";
    imgRowHtml += "<col width='10%' />";
    imgRowHtml += "<col width='*' />";
    imgRowHtml += "<col width='25%' />";
    imgRowHtml += "<col width='10%' />";
    imgRowHtml += "<col width='10%' />";
    imgRowHtml += "</colgroup>";
    imgRowHtml += "<thead>";
    imgRowHtml += "<tr>";
    imgRowHtml += "<th scope='row'><input type='checkbox' data-chkBox='allcheck'/></th>";
    imgRowHtml += "<th scope='row'>구분</th>";
    imgRowHtml += "<th scope='row'>제목(상품명)</th>";
    imgRowHtml += "<th scope='row'>연결(URL)</th>";
    imgRowHtml += "<th scope='row'>금액</th>";
    imgRowHtml += "<th scope='row'>노출순서</th>";
    imgRowHtml += "</tr>";
    imgRowHtml += "</thead>";
    imgRowHtml += "<tbody id='linkGds$count$' data-count='$count$'>";
    imgRowHtml += "</tbody>";
    imgRowHtml += "</table>";
    imgRowHtml += "</div>";
    imgRowHtml += "<div class='btn'>";
    imgRowHtml += "<div class='right'><a href='#' class='btnType2' id='btn_gesDel'>삭제</a></div>";
    imgRowHtml += "</div>";
    imgRowHtml += "</td>";
    imgRowHtml += "</tr>";
    
    
    
    var rowHtml = "<tr data-count=$count$ data-subCount=$subCount$>";
    rowHtml += "<td>";
    rowHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].imgUrl' value='$imgUrl$'/>";
    rowHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].gdsNm' value='$gdsNm$'/>";
    rowHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].linkUrl' value='$linkUrl$'/>";
    rowHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].slPrc' value='$slPrc$'/>";
    rowHtml += "<input type='hidden' name='intgBoardCnts[$count$].boardGds[$subCount$].prir' value='' data-sort='prir'/>";
    rowHtml += "<input type='checkbox' data-chkBox='gds'  data-gdsRowNum='$subCount$'/></td>";
    rowHtml += "<td>$gubun$</td>";
    rowHtml += "<td class='tl'>$gdsNm$</td>";
    rowHtml += "<td>$linkUrl$</td>";
    rowHtml += "<td class='tr'>$slPrc$</td>";
    rowHtml += "<td><span data-sort='prir'></span></td>";
    rowHtml += "</tr>";
	
    
    var imgUrl  = []; //이미지 경로
	var gdsNm   = []; //상품명
	var linkUrl = []; //링크URL 
	var slPrc   = []; //판매가
	
	
	//연결상품 추가
	function setGds(target){
		var elementCnt = imgUrl.length;
		var count = $(document).find("tbody[id="+target+"]").attr("data-count");
		
		for(var i=0;i < elementCnt;i++){
			arrGdsCnt[count] += 1;
			
			var row = rowHtml;
			row = row.split("$count$").join(count);
			row = row.split("$subCount$").join(arrGdsCnt[count]);
			row = row.split("$gubun$").join("직접입력");
			row = row.split("$imgUrl$").join(imgUrl[i].value);
			row = row.split("$gdsNm$").join(gdsNm[i].value);
			row = row.split("$linkUrl$").join(linkUrl[i].value);
			row = row.split("$slPrc$").join(slPrc[i].value);
			/* count테스트용
	 		row = row.split("$gdsNm$").join(count + "//" + arrGdsCnt[count]);
	 		row = row.split("$linkUrl$").join(count + "//" + arrGdsCnt[count]);
	 		row = row.split("$slPrc$").join(count + "//" + arrGdsCnt[count]);
			 */
			addGdsRow(row, target, count);
		}
		
	}
	
	
	
	
	
	//상품 row 추가
    function addGdsRow(row , target, count){
    	$(document).find("tbody[id="+target+"]").append(row);
    	
    	for ( var i = 0; i < $("tbody[id="+target+"]").find("tr").size(); i++) {
    		lnkGdsNumInit($("tbody[id="+target+"]"),i);
		}
    };
    
    
    
    
    
    //이미지row 추가
    function addImg(img){
    	imgElementCnt += 1;
    	arrGdsCnt.push(-1);
    	var img = imgRowHtml;
    	img = img.split("$count$").join(imgElementCnt);
    	$(document).find("tbody[data-id=mainBody]").append(img);
    };
    
    
    
  	//연결상품 배열번호 초기화 -- 연결 상품이 추가,삭제, 순서변경이 될때마다 배열을 초기화 해줌
	function lnkGdsNumInit(target,i){
		var $target = $(target);
		$target.find("input[data-sort='prir']").eq(i).val(i+1);
		$target.find("span[data-sort='prir']").eq(i).text(i+1);
		$target.find("[data-subcount]").eq(i).attr("data-subcount",i);
		
		
		var regExp = /boardGds\[.\]/;
        
		$target.find("[data-subcount]").eq(i).find("input[name^='intgBoardCnts']").each(function(index) {
            var str = $(this).attr("name");
            var result = str.replace(regExp, "boardGds["+i+"]");
            $(this).attr("name",result);
        });
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
					<h3><span class="icon1"></span>운영관리 > 게시판관리 > Lookbook</h3>
					<!-- section -->
					<div class="section a1 tabCon_inner">
					<form id="hiddenForm" name="hiddenForm" method="post">
						<input type="hidden" id="hiddenSiteNo" name="hiddenSiteNo" value="${hiddenSiteNo}"/>
						<input type="hidden" id="hiddenStrDtm" name="hiddenStrDtm" value="${hiddenStrDtm}"/>
						<input type="hidden" id="hiddenEndDtm" name="hiddenEndDtm" value="${hiddenEndDtm}"/>
						<input type="hidden" id="hiddenSearchGb" name="hiddenSearchGb" value="${hiddenSearchGb}"/>
						<input type="hidden" id="hiddenSearchText" name="hiddenSearchText" value="${hiddenSearchText}"/>
					</form>
					<form:form id="lookbook" name="lookbook" method="post" modelAttribute="lookbook" onsubmit="">
						
						<div class="tableType2">
							<table>
								<caption>Lookbook</caption>
								<colgroup>
									<col width="50px">
									<col width="90px">
									<col width="*">
									<col width="130px">
									<col width="350px">
								</colgroup>
								<tbody data-id="mainBody">
									<tr>
										<th scope="col" colspan="2">브랜드</th>
										<td colspan="3">
											<div class="wrap">
												<form:radiobuttons path="siteNo" items="${siteList}" itemLabel="siteNm" itemValue="siteNo"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col"  colspan="2">상태</th>
										<td colspan="3">
											<div class="wrap">
												<form:radiobutton path="dispYn" label="공개" value="Y"/>
												<form:radiobutton path="dispYn" label="비공개" value="N"/>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col" colspan="2">제목</th>
										<td colspan="3"><form:input path="title" id="title" cssClass="ip_tit" onkeyup="chkLen(this,100);"/></td>
									</tr>
									<tr>
										<th scope="col" colspan="2">메인이미지</th>
										<td class="mainImg" colspan="3">
											<input type="hidden" id="imgUrl0" name="intgBoardCnts[0].imgUrl" />
											<input type="hidden" name="intgBoardCnts[0].imgCls" value="CM00601"/>
											<input type="hidden" name="intgBoardCnts[0].prir" value="1"/>
											<span class="imgBox"><img id="imgUrl0" src="" alt="" style="width: 60px; height: 60px;" /></span> 
											<div class="imgUpload">
												<a href="#" data-btnId="btn_file" data-target="imgUrl0" class="btnType1">파일선택</a>
												<p class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</p>
											</div>
										</td>
									</tr>
									
<!-- 									<tr> -->
<!-- 										<th scope="col" colspan="2">연결상품</th> -->
<!-- 										<td colspan="3" class="tblDndWrap"> -->
<!-- 											<a href="#" class="btnType1" data-btnId="btn_goodsLnk">상품선택</a>  -->
<!-- 											<a href="#" class="btnType1" data-btnId="btn_psnlReg">직접입력</a> <span class="addtxt">* 연결상품은 최대 50개까지 가능합니다.</span> <br /> -->
<!-- 											<div class="tableType1 tableInTbl tblYscroll" style="height: 147px;"> -->
<!-- 												<table class=""  data-sort="sortTable"> -->
<!-- 													<caption></caption> -->
<!-- 													<colgroup> -->
<!-- 														<col width="5%" /> -->
<!-- 														<col width="10%" /> -->
<!-- 														<col width="*" /> -->
<!-- 														<col width="25%" /> -->
<!-- 														<col width="10%" /> -->
<!-- 														<col width="10%" /> -->
<!-- 													</colgroup> -->
<!-- 													<thead> -->
<!-- 														<tr> -->
<!-- 															<th scope="row"><input type="checkbox"  data-chkBox='allcheck'/></th> -->
<!-- 															<th scope="row">구분</th> -->
<!-- 															<th scope="row">제목(상품명)</th> -->
<!-- 															<th scope="row">연결(URL)</th> -->
<!-- 															<th scope="row">금액</th> -->
<!-- 															<th scope="row">노출순서</th> -->
<!-- 														</tr> -->
<!-- 													</thead> -->
<!-- 													<tbody id="linkGds0" data-count="0"> -->
<!-- 													</tbody> -->
<!-- 												</table> -->
<!-- 											</div> -->
<!-- 											<div class="btn"> -->
<!-- 												<div class="right"><a href="#" class="btnType2" id="btn_gesDel">삭제</a></div> -->
<!-- 											</div> -->
<!-- 										</td> -->
<!-- 									</tr> -->
									
								</tbody>
							</table>
						</div>
					</form:form>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<div class="left">
							<a href="#" class="btnType2" id="btn_addImg">이미지추가</a>
							<a href="#" class="btnType1" id="btn_removeImg">이미지삭제</a>
						</div>
						<div class="right">
							<a href="#" class="btnType2" id="btn_reg">등록</a>
							<a href="#" class="btnType1" onclick="javascript:window.history.back(-1); return false;">취소</a>
						</div>
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