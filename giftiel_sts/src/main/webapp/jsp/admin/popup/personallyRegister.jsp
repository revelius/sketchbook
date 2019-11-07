<%--
 * =============================================================================
 * 파일명 : /manage/personallyRegister.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : 직접등록
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
    	
    	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    	
    	var elementCnt = 0;
    	var txtAddWarning = "모두 입력 후 추가하시기 바랍니다.";
    	var txtRegWarning = "올바르지 않은 데이터가 있습니다. 확인 후 다시 시도하시기 바랍니다.";
    	var targetTbody = "${targetTbody}";
    	
    	
	    var rowHtml = "<tr>";
	    rowHtml += "<input type='hidden' id='imgUrl$count$' name='imgUrl'>";
	    rowHtml += "<input type='hidden' id='ubiGdsNo$count$'>";
	    rowHtml += "<td rowspan='2' class='imgBox'><img id='imgUrl$count$' src='' alt='' style='width: 50px; height: 50px;' /></td>";
	    rowHtml += "<td>이미지</td>";
	    rowHtml += "<td><a href='#' id='btn_file$count$' data-imgUrl=imgUrl$count$ name='btn_file' class='btnType1'>파일선택</a></td>";
	    rowHtml += "<td>제목(상품명)</td>";
	    rowHtml += "<td><input type='text' class='ip_tit' id=gdsNm$count$ name='gdsNm'/></td>";
	    rowHtml += "</tr>";
	    rowHtml += "<tr>";
	    rowHtml += "<td class='bd_left'>연결(URL)</td>";
	    rowHtml += "<td><input type='text' class='ip_tit' id=linkUrl$count$ name='linkUrl'/></td>";
	    rowHtml += "<td>금액</td>";
	    rowHtml += "<td><input type='text' class='ip_tit' id=slPrc$count$ name='slPrc'  numberonly='true'/></td>";
	    rowHtml += "</tr>";
	    
	    addRow();
	    
	    
	    //추가
	    $('#btn_add').click(function(e) {
	    	if(!formCheck(txtAddWarning)) return false; 
	    	
	    	e.preventDefault();
	    	var $target = $(e.currentTarget);
	    	addRow();
	    });
	    
	    
	    //row 추가
	    function addRow(){
	    	elementCnt += 1;
	    	var row = rowHtml.split("$count$").join(elementCnt);
	    	$(document).find("tbody").append(row);
	    };
	    
	    //값체크
	    function formCheck(txtWarnin){
	    	var flag = true;
	    	$("input[name=imgUrl],input[name=gdsNm],input[name=linkUrl],input[name=slPrc]").each(function(){
	    		if($(this).val()==""){
	    			alert(txtWarnin);
	    			flag = false;
	    			return false;
	    		}
	    	});
	    	
	    	return flag;
	    }
		
		
	    
	    //파일선택
		$(document).on("click","a[name=btn_file]",function(e){  
			e.preventDefault();
	    	var $target = $(e.currentTarget);
		    openFileUploadPop("${type}", $target.attr("data-imgUrl"), "${folderNm}");
	    });
	    
	    
		var imgUrl  = []; //이미지 경로
		var gdsNm   = []; //상품명
		var linkUrl = []; //링크URL 
		var slPrc   = []; //판매가
		
		
		//등록
		$('#btn_reg').click(function(e) { 
			e.preventDefault();
			
			if(!formCheck(txtRegWarning)) return false; 
			
			imgUrl  = $("input[name=imgUrl]");
			gdsNm   = $("input[name=gdsNm]");
			linkUrl = $("input[name=linkUrl]");
			slPrc   = $("input[name=slPrc]");
			
			
			opener.parent.imgUrl  = imgUrl;
			opener.parent.gdsNm   = gdsNm;
			opener.parent.linkUrl = linkUrl;
			opener.parent.slPrc   = slPrc;
			opener.parent.setGds(targetTbody);
			
			window.close();
			
		});
		
	    
	    
    	
    });
    	
   	</script>
	
	

	<link rel="stylesheet" href="/resources/admin/css/adminDefault.css" type="text/css" />
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/admin/js/common.js"></script>

</head>
<body>
<!-- 대 카테고리 추가 -->
<div class="layerWrap">
	<div class="title">
		<h1><span class="icon1"></span>직접등록</h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
	<div class="wrap">
		<div class="section a1">
			<div class="tableTitle">
				<div class="right">
					<a href="#" class="btnType2" id="btn_add">추가</a>
				</div>
			</div>
			<div class="tableType1">
				<table>
					<caption>브랜드</caption>
					<colgroup>
						<col style="width: 10%" />
						<col style="width: 15%" />
						<col style="width: 30%" />
						<col style="width: 15%" />
						<col style="width: 30%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="row">이미지</th>
							<th scope="row" colspan="4">내용</th>
						</tr>
					</thead>
					<tbody>	
						
					</tbody>
				</table>
			</div>
			<div class="btn">
				<div class="right">
					<a href="#" class="btnType2" id="btn_reg">등록</a>
					<a href="#" class="btnType1" onclick="window.close()">취소</a>
				</div>			
			</div>
		</div>
	</div>
</div>
<!-- //대 카테고리 추가 -->
</body>
</html>