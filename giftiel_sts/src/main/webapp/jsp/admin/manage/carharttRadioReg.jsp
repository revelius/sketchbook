<%--
 * =============================================================================
 * 파일명 : /manage/carharttRadioReg.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 통계 메인
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
		openFilePopup = function(num){
			if (num != null) {
				openFileUploadPop("image", "imgUrl"+num, "carharttRADIO");				
			}
		};
		
    	initImg = function(num){
    		if (num != null) {
        		if(!confirm("삭제하시겠습니까?")) return false;
        		
        		$("input[id=imgUrl" + num + "]").val("");
        		$("img[id=imgUrl" + num + "]").attr("src","");	
			}
    	};
		
    	//등록
    	$("#btn_reg").on("click",function(){

    		if(!formCheck()) return false;
    		
    		if(!confirm("저장하시겠습니까?")) return false;
		    
	    	$.ajax({
		        url : "<c:url value='/admin/manage/carharttRadioProc'/>",
		        type: "post",
		        data : $("form#carharttRadioForm").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("저장하였습니다."); 
  						location.href = "<c:url value='/admin/manage/carharttRadioList'/>";
					} else {
						alert("저장에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		   	});
    	
   		});
    	
		formCheck = function(){

			if($("#radioTitle").val() == ""){
	    		alert("타이틀을 입력해 주세요.");
	    		$("#radioTitle").focus();
	    		return false;
	    	}
			
			if($("#radioArtist").val() == ""){
	    		alert("아티스트를 입력해 주세요.");
	    		$("#radioArtist").focus();
	    		return false;
	    	}    		
    		
   			if($("input:radio[name='dispYn']").is(":checked") == false){
	    		alert("등록상태를 선택하세요.");
	    		$("#dispYn").focus();
	    		return false;
	    	}
    		var frm = document.carharttRadioForm;
    		
    		if (frm.bgImgUrl.value == "") {
				alert("배경이미지를 등록해 주세요.");
// 				$("#imgUrl3").focus();
	    		return false;
			}
    		
    		if(frm.banImgUrl.value == ""){
	    		alert("배너 이미지를 등록해 주세요.");
	    		$("#imgUrl1").focus();
	    		return false;
	    	}
    		
    		if(frm.cvImgUrl.value == ""){
	    		alert("커버 썸네일을 등록해 주세요.");
	    		$("#imgUrl2").focus();
	    		return false;
	    	}
    		
    		if ($("#radioLink").val() == "") {
				alert("링크URL을 입력하세요.");
				$("#radioLink").focus();
	    		return false;
			}
    		
    		if($("#radioInfo").val() == ""){
	    		alert("Info를 입력해 주세요.");
	    		$("#radioInfo").focus();
	    		return false;
	    	}
    		
    		if($("#radioTrackList").val() == ""){
	    		alert("TrackList를 입력해 주세요.");
	    		$("#radioTrackList").focus();
	    		return false;
	    	}
    		
    		if($("#radioArtistInfo").val() == ""){
	    		alert("ArtistInfo를 입력해 주세요.");
	    		$("#radioArtistInfo").focus();
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
			
			<form:form id="carharttRadioForm" name="carharttRadioForm" method="post" modelAttribute="carharttRadioForm" onsubmit="">
			<form:hidden path="updrNo" id="updrNo" value="${adminNo }"/>
			<form:hidden path="updDts" id="updDts" value="${thisDay }"/>
			<form:hidden path="type" id="type" value="Add"/>
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>운영관리 &gt; MUSIC 관리 &gt; CARHARTT RADIO</h3>
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
							<tbody>
								<tr>
									<th scope="col">작성자</th>
									<td><strong>${adminNm }</strong></td>
									<th scope="col">작성일</th>
									<td>${thisDay }</td>
								</tr>
								<tr>
									<th scope="col">타이틀</th>
									<td><form:input path="radioTitle" id="radioTitle" cssClass="wd_300"/></td>
									<th scope="col">아티스트</th>
									<td><form:input path="radioArtist" id="radioArtist" cssClass="wd_300"/></td>
								</tr>
								<tr>
									<th scope="col">상태</th>
									<td colspan="3">
										<form:radiobutton path="dispYn" id="dispY" label="공개" value="Y"/>
										<form:radiobutton path="dispYn" id="dispN" label="미공개" value="N"/>
									</td>
								</tr>
								<tr>
									<th scope="col">배경이미지</th>
									<td colspan="3">
										<a href="#" id="btn_file" class="btnType1" onclick="openFilePopup(3)">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />
										<span class="imgBox"><img id="imgUrl3" src="" alt="" style="width: 60px; height: 60px;" /></span>
										<form:input path="bgImgUrl" id="imgUrl3" cssClass="wd_200"  readOnly = "true"/><a href="#" onclick="initImg(3);"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
									</td>
								</tr>
								<tr>
									<th scope="col">배너 이미지</th>
									<td colspan="3">
										<a href="#" id="btn_file" class="btnType1" onclick="openFilePopup(1)">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />
										<span class="imgBox"><img id="imgUrl1" src="" alt="" style="width: 60px; height: 60px;" /></span>
										<form:input path="banImgUrl" id="imgUrl1" cssClass="wd_200"  readOnly = "true"/><a href="#" onclick="initImg(1);"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
									</td>
								</tr>
								<tr>
									<th scope="col">커버 썸네일</th>
									<td colspan="3">
										<a href="#" id="btn_file" class="btnType1" onclick="openFilePopup(2)">파일선택</a> <span class="addtxt">*이미지 최대 크기는 3MB입니다. 가로 사이즈  700픽셀의 jpg,gif,png 파일로 업로드 바랍니다.</span><br /><br />
										<span class="imgBox"><img id="imgUrl2" src="" alt="" style="width: 60px; height: 60px;" /></span>
										<form:input path="cvImgUrl" id="imgUrl2" cssClass="wd_200"  readOnly = "true"/><a href="#" onclick="initImg(2);"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="" /></a>
									</td>
								</tr>
								<tr>
									<th scope="col">링크URL</th>
									<td colspan="3">
										<form:input path="radioLink" id="radioLink"  cssClass="wd_700" />
									</td>
								</tr>
								<tr>
									<th scope="col" colspan="4">Info</th>
								</tr>
								<tr>
									<td colspan="4">
										<form:textarea path="radioInfo" id="radioInfo" cols="30" rows="10" cssClass="txtareaAll"/>
									</td>
								</tr>
								<tr>
									<th scope="col" colspan="4">Tracklist</th>
								</tr>
								<tr>
									<td colspan="4">
										<form:textarea path="radioTrackList" id="radioTrackList" cols="30" rows="10" cssClass="txtareaAll"/>
									</td>
								</tr>
								<tr>
									<th scope="col" colspan="4">Artist</th>
								</tr>
								<tr>
									<td colspan="4">
										<form:textarea path="radioArtistInfo" id="radioArtist" cols="30" rows="10" cssClass="txtareaAll"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn">
						<div class="right">
							<a href="#" class="btnType2" id="btn_reg">등록</a>
							<a href="#" class="btnType1" id="btn_cancel" onclick="javascript:window.history.back(-1); return false;">취소</a>
						</div>
					</div>
				</div>
				<!-- //section -->
			</div>
			<!--[e] contents -->
			</form:form>
		</div>
		<!--[e] container -->
		
		<!--[s] footer -->
		<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->
	</div>
	</div>
</body>
</html>