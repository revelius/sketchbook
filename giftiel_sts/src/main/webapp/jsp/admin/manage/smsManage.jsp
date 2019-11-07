<%--
 * =============================================================================
 * 파일명 : /manage/smsManage.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-30
 *
 * 파일 내용 : 고객운영관리 > SMS관리 > 문구관리
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

    	// textarea에 입력된 문자의 바이트 수를 체크
    	checkByte = function(textarea) {
    		$target = $(textarea);
    		$message = $target.val();
    		$byteArea = $target.parent().parent().find($("span[data-byte=byte]"));
    		
    		var totalByte = 0;
   	        var message = $message;
   	        var limitByte = 80;

   	        for(var i =0; i < message.length; i++) {
                var currentByte = message.charCodeAt(i);
                if(currentByte > 128) totalByte += 2;
    			else totalByte++;
    	    }
   	     	$byteArea.text(totalByte);

   	        if(totalByte > limitByte) {
                //alert( limitByte+"바이트까지 전송가능합니다.");
    			//frm.messagebox.value = message.substring(0,limitByte);
   	        	$byteArea.css("color", "red");
   	        	$byteArea.css("font-weight", "bold");
   	        }else{
   	        	$byteArea.removeAttr("style");
   	        }
    	};
    	$("textarea[class=smsTxt]").trigger("keyup");
    	
    	
    	$("#saveBtn").on("click",function(){
    		
    		if(!confirm("저장하시겠습니까?")) return false;
    		
   		    $.ajax({
   		        url : "<c:url value='/admin/manage/smsManageUpdate'/>",
   		        type: "post",
   		        data : $("form#smsForm").serialize(),
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
    	
    	
    	chkAutoSend = function(e){
    		$target = $(e);
    		$auto = $target.parent().parent().find("input[name=autoCls]");
    		if($target.is(":checked") == true){
    			$auto.val("Y");
    		}else{
    			$auto.val("N");
    		};
    	};
    	
    	
    	
	    
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
				<div class="contents">
<!-- 				<form id="hiddenForm" name="hiddenForm" method="post"> -->
<!-- 					<input type="hidden" id="cnslNo" name="cnslNo" value="test"/> -->
<!-- 				</form> -->
				<form id="smsForm" name="smsForm" method="post" >
					
				<!-- section -->
					<h3><span class="icon1"></span>운영관리 > SMS관리 > 문구관리</h3>
<!-- 					<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 					<div class="helpBox"> -->
<!-- 						<ul class="boxLi"> -->
<!-- 							<li>- SMS로 발송되는 문구를 관리합니다.</li> -->
<!-- 							<li>- 사용자모드는 사용자에게 자동 발송되는 항목입니다.</li> -->
<!-- 							<li>- 관리자모드는 관리자에게 자동 발송되는 항목입니다.</li> -->
<!-- 							<li>- 자동발송 선택된 항목만 자동으로 발송되며, 휴대폰번호가 정확하지 않을 시에는 발송되지 않습니다.</li> -->
<!-- 							<li>- 도움문구 <br /> [NAME] : 회원이름. [ORDERNUMBER] : 주문번호. [BRANDSITE] : 브랜드사이트.</li> -->
<!-- 						</ul> -->
<!-- 						<a href="#" class="close">X</a> -->
<!-- 					</div> -->
					<div class="section a1 tabCon_inner">
						<div class="tableTitle">
							<div class="left"><span class="icon2"></span>[사용자모드] : 고객에게 보내지는 메세지를 설정합니다.</div>		
						</div>
						<div class="smsWrap">
						<c:choose>
							<c:when test="${not empty smsMngList}">
								<c:forEach items="${smsMngList}" var="smsMng" varStatus="listCount">
								<c:if test = "${smsMng.sndCls eq 'CM01002'}">
								<div class="sms"  data-no="${smsMng.mngNo}">
									<input type="hidden" name="mngNo" value="${smsMng.mngNo}"/>
									<input type="hidden" name="autoCls" value="${smsMng.autoCls}"/>
									<p class="smsTit">${smsMng.mngTitle}[${smsMng.mngNo}]</p>
									<div class="smsBox">
										<strong>SMS</strong>
										<textarea cols="30" rows="10" class="smsTxt" name="smsTxt" onKeyUp="checkByte(this);">${smsMng.smsTxt}</textarea>
										<p><span data-byte="byte">80 </span>Byte</p>
									</div>
									<span class="autoSend"><input type="checkbox" id="autoSendChkU${listCount.index}" onchange="chkAutoSend(this);" <c:if test="${smsMng.autoCls eq 'Y'}">checked='checked'</c:if>/> <label for="autoSendChkU${listCount.index}">자동발송</label></span>
								</div>
								</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
										등록된 SMS문구가 없습니다.
							</c:otherwise>
						</c:choose>
						</div>
					</div>
					<!-- //section -->
<%-- 					<div class="section a2">
						<div class="tableTitle">
							<div class="left"><span class="icon2"></span>[관리자모드] : 관리자에게 보내지는 메세지를 설정합니다.</div>		
						</div>
						<div class="smsWrap">
						<c:choose>
							<c:when test="${not empty smsMngList}">
								<c:forEach items="${smsMngList}" var="smsMng" varStatus="listCount">
								<c:if test = "${smsMng.sndCls eq 'CM01001'}">
								<div class="sms"  data-no="${smsMng.mngNo}">
									<input type="hidden" name="mngNo" value="${smsMng.mngNo}"/>
									<input type="hidden" name="autoCls" value="${smsMng.autoCls}"/>
									<p class="smsTit">${smsMng.mngTitle}</p>
									<div class="smsBox">
										<strong>SMS</strong>
										<textarea cols="30" rows="10" class="smsTxt" name="smsTxt" onKeyUp="checkByte(this);">${smsMng.smsTxt}</textarea>
										<p><span data-byte="byte">80 </span>Byte</p>
									</div>
									<span class="autoSend"><input type="checkbox" id="autoSendChkO${listCount.index}" onchange="chkAutoSend(this);" <c:if test="${smsMng.autoCls eq 'Y'}">checked='checked'</c:if> /> <label for="autoSendChkO${listCount.index}">자동발송</label></span>
								</div>
								</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
										등록된 SMS문구가 없습니다.
							</c:otherwise>
						</c:choose>
						</div>
					</div> --%>
					<div class="section a2 btn">
						<a href="#" id="saveBtn" class="btnType2">저장</a>
						<a href="#" id="cancelBtn" class="btnType1" onclick="javascript:window.history.back(-1); return false;">취소</a>
					</div>
				</form>
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