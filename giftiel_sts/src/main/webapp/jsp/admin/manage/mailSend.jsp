<%--
 * =============================================================================
 * 파일명 : /manage/mailSend.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : 메일발송
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
	
		//$("textarea#bsDesc").editable({inlineMode: false, language: 'ko', theme: 'gray'});
// 		ver2.0
		$("textarea#bsDesc").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
		
		
		// 라디오버튼 클릭시 다른선택 비활성화
		$("input:radio").click(function(){
			var thisId = $(this).attr("id");

			if(thisId != "aloneMem"){
				$(".receiver").attr("disabled",true);
				$("#rcvrEmail").val("");
				$("#memPopup").attr("href","javascript:void();");
				
				if(thisId == "gradeMem"){
					$("#getMember").attr("disabled",false);
					$("#siteNo").attr("disabled",true);
				}else if(thisId == "brandMem"){
					$("#getMember").attr("disabled",true);
					$("#siteNo").attr("disabled",false);
				}else{
					$("#getMember").attr("disabled",true);
					$("#siteNo").attr("disabled",true);
				}
			}else{
				$("#memPopup").attr("href","javascript:memPopup();");
				$(".receiver").attr("disabled",false);
			}
		});
		
		
		$("#btn_send").click(function(){
			formSubmit();
		});
		
		//
		//formSubmit 이벤트
		//
		formSubmit = function(){
		
    		if($("#title").val() == ""){
	    		alert($("#title").attr("title") + "입력 하세요.");
	    		$("#title").focus();
	    		return false;
	    	}
			
//     		if($("textarea#bsDesc").val() == null && $("textarea#bsDesc").val() == ""){
// 				alert("aaaaaaaaaa");
// 			}
			
			if($("#aloneMem").is(":checked")){
				
				if($("#rcvrEmail").val() == ""){
					alert("한개 이상의 메일주소가 필요합니다.");
					$("#rcvrEmail").focus();
					return false;
				}
			}
    		if($("#rcvrEmail").val() != ""){
    			var arrType = $.trim($("#rcvrEmail").val()).split("\n");

    			if(arrType.length > 2){
    				for ( var i = 0; i < arrType.length; i++) {
						if(!regEmailValue(arrType[i])) {
		   	 	    		alert("이메일 형식에 맞지 않습니다.");
		   	 	    		$("#rcvrEmail").focus();
		   	 	    		return false;
						}
					}
    			}else{
    				if(!regEmailValue(arrType)){
	   	 	    		alert("이메일 형식에 맞지 않습니다.");
	   	 	    		$("#rcvrEmail").focus();
	   	 	    		return false;
   	 	    		}
    			}
    		}

//     		if ($("textarea#bsDesc").val() == "") {
// //     			alert($("#txt").attr("title"));
//     			$("textarea#bsDesc").focus();
//     			return false;
// 			}
			
     		if(!confirm("메일을 보내시겠습니까?")) return false;

	    	$.ajax({
		        url : "<c:url value='/admin/manage/mailSendProc' />",
		        type: "post",
		        data : $("form#mailManage").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("메일이 정상적으로 발송되었습니다.."); 
					} else {
						alert("메일 발송에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        },
		        complete : function() {
		        	$("form#mailManage").submit();
		        }
		   	});
		};

    });
	
    function memPopup(){
		window.open("<c:url value='/admin/manage/memSearch?hiddenSendType=mailSendType'/>","popup","width=950px,height=650px,location=no,scrollbars=yes,resizable=yes");
	}
	
	function setChildMailValue(cpNo2,cpNm) {
		if (cpNo2 != '') {
			var str = document.getElementById("rcvrEmail").value;
			
			if(str.indexOf(cpNo2) < 0){
				document.getElementById("rcvrEmail").value += cpNo2 + "\n";
			}else{
				alert('같은 메일형식이 존재합니다.');
				return false;
			}
		}
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
					<h3><span class="icon1"></span>운영관리 &gt; 메일발송관리 &gt; 메일발송</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- E-mail 로 즉시 발송됩니다.</li> -->
<!-- 							<li>- 회원 주소록에서 E-mail을 선택하여 불러온 후 편집하여 발송 가능합니다.</li> -->
<!-- 							<li>- 회원 개인 또는 등급별 메세지를 보낼 수 있습니다.</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<form:form id="mailManage" name="mailManage" method="post" modelAttribute="mailManage" onsubmit="">
						<div class="tableType2">
							<table>
								<caption>메일발송</caption>
								<colgroup>
									<col width="130px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">제목</th>
										<td>
											<form:input path="title" id="title" name="title" cssClass="ip_tit" title="제목" onkeyup="chkLen(this,50);"/>
										</td>
									</tr>
									<tr>
										<th scope="col">수신자선택</th>
										<td class="receiverSel">
											<form:radiobutton path="rsvTgGb" id="aloneMem" checked="checked" value="CM01201"/> <label for="aloneMem">개별발송</label>
											<a href="javascript:memPopup();" class="btnType1" id="memPopup">회원 주소록</a>
											<br /><br />
											
											<!-- 이메일 입력 -->
											<textarea cols="30" rows="10" class="receiver" id="rcvrEmail" name="rcvrEmail"></textarea>
											<br /><br />
											
											<span class="listInput">
												<form:radiobutton path="rsvTgGb" id="gradeMem" value="CM01202"/> <label for="gradeMem">등급별 발송</label>
												<form:select path="getMember" items="${memberGradeList}" itemLabel="grdNm" itemValue="memGrdNo"></form:select>
											</span>
											<br />
											 
											<span class="listInput">
												<form:radiobutton path="rsvTgGb" id="brandMem" value="CM01203"/> <label for="brandMem">브랜드별 발송</label>
												<form:select path="getBrnd" items="${siteList}" id="siteNo" itemLabel="siteNm" itemValue="siteNo" />
											</span>
											<br />
											 <p style="padding-bottom:6px;">
											<form:radiobutton path="rsvTgGb" id="allMem" value="CM01204" /><label for="allMem">전체회원 발송</label>
											 </p>											
											<form:radiobutton path="rsvTgGb" id="allTempMem" value="CM01205" /><label for="allMem">광고 동의회원 발송</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<form:textarea path="txtHtml" id="bsDesc"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						</form:form>
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section a2 btn">
						<a href="#" class="btnType2" id="btn_send">발송</a>
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