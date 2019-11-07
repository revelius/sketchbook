<%--
 * =============================================================================
 * 파일명 : /manage/smsSend.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-04
 *
 * 파일 내용 : SMS발송
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

		// 라디오버튼 클릭시 다른선택 비활성화
		$("input:radio").click(function(){
			var thisId = $(this).attr("id");

			if(thisId != "aloneMem"){
				$(".receiver").attr("disabled",true);
				$("#rcvrEmail").val("");
				$("#memPopup").attr("href","javascript:void();");
				
				if(thisId == "gradeMem"){
					$("#getMem").attr("disabled",false);
					$("#siteNo").attr("disabled",true);
				}else if(thisId == "brandMem"){
					$("#getMem").attr("disabled",true);
					$("#siteNo").attr("disabled",false);
				}else{
					$("#getMem").attr("disabled",true);
					$("#siteNo").attr("disabled",true);
				}
			}else{
				$("#memPopup").attr("href","javascript:memPopup();");
				$(".receiver").attr("disabled",false);
			}
		});
		
		
    	//전송
    	$("#insertSms").on("click",function(){
    	
    		if(!confirm("전송하시겠습니까?")) return false;

			var frm = document.smsForm;
// 			alert(callTo.value);
// 			 alert(smsTxt.value);
		    if(!formCheck(frm)) return false;
		    
	    	$.ajax({
		        url : "<c:url value='/admin/manage/smsInsert'/>",
		        type: "post",
		        data : $("form#smsForm").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("발송하였습니다."); 
   						frm.action = "<c:url value='/admin/manage/smsSend'/>";
			 	        frm.submit();
					} else {
						alert("발송에 실패 하였습니다.");
					}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        },
		        complete : function() {
		        	$("form#smsForm").submit();
		        }
		   	});
   		});
		
    	
    	function formCheck(frm){
	    	
    		if(frm.smsTxt.value == ""){
	    		alert("내용을 입력 하세요.");
	    		frm.smsTxt.focus();
	    		return false;
	    	}
    		
    		if(frm.callTo.value == ""){
    			var arrType = $.trim($("#callTo").val()).split("\n");

    			if(arrType.length > 2){
    				for ( var i = 0; i < arrType.length; i++) {
						if(!regPhone($("#callTo"))) {
		   	 	    		alert("핸드폰 번호 형식에 맞지 않습니다.");
		   	 	    		$("#callTo").focus();
		   	 	    		return false;
						}
					}
    			}else{
    				if(!regPhone($("#callTo"))){
	   	 	    		alert("핸드폰 번호 형식에 맞지 않습니다.");
	   	 	    		$("#callTo").focus();
	   	 	    		return false;
   	 	    		}
    			}
	    	}
    		

	    	return true;
	    };
    });
   

	
	 function memPopup(){
			window.open("<c:url value='/admin/manage/memSearch?hiddenSendType=smsSendType'/>","popup","width=950px,height=650px,location=no,scrollbars=yes,resizable=yes");
		}
	
	function setChildValue(cpNo2) {
		  document.getElementById("callTo").value+=cpNo2+"\n";
/* 		  alert(document.getElementById("callTo").value);
		  alert(cpNo2); */
		}
 	function setSmsMg(mngTitle){
//  		alert(setSms);
	 var setSms = document.getElementById("mngNo").value;
// 	 alert(setSms);
	 document.getElementById("smsTxt").innerHTML = setSms;
// 	 alert(document.getElementById("smsTxt").value);
} 
 	
 	 function chkTxt(obj,maximumByte) {
         //var before = $count.text() * 1;
         var str_len = obj.value.length;
         var cbyte = 0;
         var li_len = 0;
         for (i = 0; i < str_len; i++) {
             var ls_one_char = obj.value.charAt(i);
             if (escape(ls_one_char).length > 4) {
                 cbyte += 2; //한글이면 2를 더한다
             } else {
                 cbyte++; //한글아니면 1을 다한다
             }
             if (cbyte <= maximumByte) {
                 li_len = i + 1;
             }
         }
         // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
         if (parseInt(cbyte) > parseInt(maximumByte)) {
        	 alert(maximumByte + '자를 초과되었습니다.\r\n\n초과된 부분은 자동으로 삭제됩니다.');
             var str = obj.value;
             var str2 = obj.value.substr(0, li_len);
             obj.value = str2;
             var cbyte = 0;
             for (i = 0; i < obj.value.length; i++) {
                 var ls_one_char = obj.value.charAt(i);
                 if (escape(ls_one_char).length > 4) {
                     cbyte += 2; //한글이면 2를 더한다
                 } else {
                     cbyte++; //한글아니면 1을 다한다
                 }
             }
         }
         document.getElementById("txtCnt").innerHTML = cbyte+ "/<span>80 Byte</span>";
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
					<h3><span class="icon1"></span>운영관리 > SMS관리 > SMS발송</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- SMS로 즉시 발송됩니다.</li> -->
<!-- 							<li>- 자동발송 메세지를 선택하여 불러온 후 편집하여 발송 가능합니다.</li> -->
<!-- 							<li>- 자동발송 메세지는 선택 목록은 회원용과 관리자용으로 구분됩니다.</li> -->
<!-- 							<li>- 회원 개인 또는 등급별 메세지를 보낼 수 있습니다.</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<!-- section -->
					<div class="section a1 tabCon_inner">
						<!-- [s] 문의 테이블 -->
						<form:form id="smsForm" name="smsForm" method="post" modelAttribute="smsForm" onsubmit="">
						<div class="tableType2">
							<table>
								<caption>문의</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">내용</th>
										<td>
											<div class="smsWrap smsSel">
												<div class="sms">
													<div class="smsBox">
														<strong>SMS</strong>
														<textarea cols="30" rows="10" class="smsTxt" id="smsTxt" name="smsTxt" onkeyup="chkTxt(this,80);">[NAME]님, [BRANDSITE]에 회원 가입해 주셔서 감사합니다.</textarea>
														<p id="txtCnt">$/<span>80 Byte</span></p>
													</div>
												</div>
												<div class="smsM">
													[자동발송 메세지 선택] <br />
											<form:select path="mngSelect" items="${SmsMngTitleList}" id="mngNo" itemLabel="mngTitle" itemValue="smsTxt" onchange="setSmsMg(this.value)"/>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="col" >수신자 선택</th>
										<td class="receiverSel">
										
										
										
											<form:radiobutton path="rsvTgGb" id="aloneMem" checked="checked" value="CM01201"/> <label for="aloneMem">개별발송</label>
											<a href="javascript:memPopup();" class="btnType1" id="memPopup">회원 주소록</a>
											<br /><br />
											<textarea cols="30" rows="10" class="receiver" id="callTo" name="callTo"></textarea>
										
											
											<ul>
												<li>*한줄당 하나의 발송번호를 입력해 주세요.</li>
												<li>*번호는 “-”없이 숫자만 입력해 주세요.</li>
												<li>*개별 발송시 10명 이상보낼시 부하가 발생합니다.</li>
												</ul>
										
									<br /><br />
										<span class="listInput">
												<form:radiobutton path="rsvTgGb" id="gradeMem" value="CM01202"/> <label for="gradeMem">등급별 발송</label>
												<form:select path="getMem" items="${memberGradeList}" itemLabel="grdNm" itemValue="memGrdNo"></form:select>
											</span>
							<br />
											 
											<span class="listInput">
												<form:radiobutton path="rsvTgGb" id="brandMem" value="CM01203"/> <label for="brandMem">브랜드별 발송</label>
												<form:select path="getBrnd" items="${siteList}" id="siteNo" itemLabel="siteNm" itemValue="siteNo" />
											</span>
											<br />
											 
											<form:radiobutton path="rsvTgGb" id="allMem" value="CM01204" /><label for="allMem">전체회원 발송</label>
										</td>
									</tr>
									<tr>
										<th scope="col">발송 번호</th>
										<td>
											<input type="text" class="wd_200"  id="callFrom" name="callFrom"/>
											<p class="addtxt">*발송자 핸드폰 번호를 “-” 없이 숫자만 입력해 주세요.</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						</form:form>
						<!-- [e] 문의 테이블 -->
					</div>
					<!-- //section -->
					<!-- section -->
					<div class="section btn a2">
						<a href="#" class="btnType2" id="insertSms">발송</a>
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