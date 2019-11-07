<%--
 * =============================================================================
 * 파일명 : /manage/storeWrite.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-12-11
 *
 * 파일 내용 : 관리자 환경설정 - 상점운영정책
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
			//ver2.0
			$("textarea#plcy_txt").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
		});
		
		var saveFlag = false;
		
		//변경된 내역이 있는지 체크
		function doSaveFlag(){
			saveFlag = true;
		}
		
		//취소 - 목록으로 이동
		function doList(){
			$("#plcy_no").val("");
			if(saveFlag){
				if(confirm("저장하지 않고 목록으로 이동하시겠습니까?")){
					var frm = document.frm;
				    frm.target = '_self';
				    frm.action = "<c:url value='/admin/setting/storeManage'/>";
				    frm.submit();
				}
			}else{
				var frm = document.frm;
			    frm.target = '_self';
			    frm.action = "<c:url value='/admin/setting/storeManage'/>";
			    frm.submit();
			}
		}
		
		//저장
		function doSave(){
			if($("#plcy_nm").val()==""){
				alert("제목을 입력하세요.");
				$("#plcy_nm").focus();
				return;
			}
			if($("#plcy_desc").val()==""){
				alert("적용위치를 입력하세요.");
				$("#plcy_desc").focus();
				return;
			}
			if($("#plcy_txt").val()==""){
				alert("내용을 입력하세요.");
				$("#plcy_txt").focus();
				return;
			}
			
			if(!confirm("저장 하시겠습니까?")){
				return;
			}  
			
			var urlVal = "";
			if($("#regFlag").val() != undefined && $("#regFlag").val() != null && $("#regFlag").val() != ""){
				urlVal = "<c:url value='/admin/setting/storeMngUpdate'/>";
			}else{
				urlVal = "<c:url value='/admin/setting/storeMngInsert'/>";
			}
			
			//alert(JSON.stringify(convertFrmToJSON($("#frm"))));
			//alert(urlVal);
			
			$.ajax({
				url : urlVal,
		        type: "post",
		        contentType: "application/json", 
		        data :JSON.stringify(convertFrmToJSON($("#frm"))), //JSON.stringify(convertFrmToJSON($("#frm")))
		        dataType: "json",
		        success : function(responseData){
		            var data = JSON.parse(responseData);
					
		            if(data=="1"){  //로그인 성공 
		            	alert("저장 되었습니다.");
		            	$("#plcy_no").val("");
		            	var frm = document.frm;
		        	    frm.target = '_self';
		        	    frm.action = "<c:url value='/admin/setting/storeManage'/>";
		        	    frm.submit();        	
		            }
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		}
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">	
			<div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb --> 
				
			<!--[s] contents -->
			<div class="contents"><!-- contents_tab -->
				<h3><span class="icon1"></span>환경설정 > 상점운영정책 > 상점운영정책</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 회원가입시 이용약관, 개인정보취급방침 내용을 관리할 수 있습니다.</li> -->
<!-- 						<li>- 이용약관, 개인정보취급방침, 청소년보호정책, 이메일무단수집거부 내용을 관리할 수 있습니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
			
				<!-- 수정 모드인 경우 정책을 가져와서 보여줌. -->
<%-- 				<c:forEach items="${list}" var="list" varStatus="listCount">		 --%>
<%-- 					<c:set var="plcy_nm" value="${list.plcy_nm}"/> --%>
<%-- 					<c:set var="plcy_desc" value="${list.plcy_desc}"/> --%>
<%-- 					<c:set var="plcy_txt" value="${list.plcy_txt}"/> --%>
<%-- 				</c:forEach> --%>
				
				<!-- [s] 전체운영설정 컨텐츠 -->
				<div class="tabCon_inner">
					<!-- [s] 기본 배송정책 설정 테이블 -->
					<form:form id="frm" name="frm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
						<form:hidden path="site_no" id="site_no"/>
						<form:hidden path="plcy_no" id="plcy_no"/>
						<form:hidden path="regFlag" id="regFlag"/>
					<div class="tableType2">
						<table>
							<caption>상점운영정책 쓰기 테이블</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">브랜드</th>
									<td>
										<c:choose>
											<c:when test="${searchForm.site_no eq '10001'}">
												WORKSOUT
											</c:when>
											<c:when test="${searchForm.site_no eq '10002'}">
												CARHARTT
											</c:when>
											<c:when test="${searchForm.site_no eq '10003'}">
												OBEY
											</c:when>
											<c:when test="${searchForm.site_no eq '10004'}">
												BRIXTON
											</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th scope="col">제목</th>
									<td><form:input path="plcy_nm" id="plcy_nm" onkeyup="javascript:doSaveFlag();" onblur="javascript:chkLen(this,200);"/></td>
								</tr>
								<tr>
									<th scope="col">적용위치</th>
									<td><form:input path="plcy_desc" id="plcy_desc" onkeyup="javascript:doSaveFlag();" onblur="javascript:chkLen(this,200);"/></td>
								</tr>
								<tr>
									<td colspan="2">
										<form:textarea path="plcy_txt" id="plcy_txt" cols="20" rows="10" onkeyup="javascript:doSaveFlag();"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</form:form>
					<!-- [e] 기본 배송정책 설정 테이블 -->
					<div class="section a2 btn">
						<a href="javascript:doSave();" class="btnType2">저장</a> 
						<a href="javascript:doList();" class="btnType1">취소</a>
					</div>
				</div>
				<!-- [e] 상점환경설정 컨텐츠 -->					
			</div>
			<!--[e] contents -->
		   </div>
		</div>
		<!--[e] container -->
	</div>
</body>
</html>