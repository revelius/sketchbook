<%--
 * =============================================================================
 * 파일명 : /manage/inquiryDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-04-14
 *
 * 파일 내용 : 고객운영관리 > 1:1문의관리 상세
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
	    $("#saveBtn").on("click",function(){
	    	
	    	if($("#repl").val() == ""){
	    		alert("답변내용을 작성해 주세요");
	    		return false;
	    	}
	    	
	    	var frm = document.hiddenForm;
	    	frm.memoTxt.value = $("#repl").val();
	    	
	    	

	    	$.ajax({
		        url : "<c:url value='/admin/manage/regInquiryReplAjax'/>",
		        type: "post",
		        data : $("form#hiddenForm").serialize(),
		        async: false,
		        success : function(res){
		            if (res > 0) {
						alert("저장 되었습니다."); 
						/* 상세화면 재조회시 주석해제 --> 조회시 상태값 처리중으로 변경 해주는부분 처리 해줘야 함
			 	    	frm.action = "<c:url value='/admin/manage/inquiryDetail'/>";
			 	        frm.submit();
			 	         */
						//리스트 조회시 주석해제 
			 	    	frm.action = "<c:url value='/admin/manage/inquiryList'/>";
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
	    
	    $("#initBtn").on("click", function(){
	        location.href = "<c:url value='/admin/manage/inquiryList'/>";
	    });
	    
	    
	  	//파일다운로드
	    fileExport= function(e){
	    	var $target = $(e);
	    	var fileName = $target.attr('data-file');
	    	
	    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"'/>");
	    };
	    
	    
	    
    });
    
    function updateBtn(memoNo){
    	var html = $("#txt_"+memoNo).html().replace(/<br>/g, "\r\n");
    	$("#txt_"+memoNo).html("<textarea id='txtform_"+memoNo+"' style='margin: 0px; width: 732px; height: 65px;'>"+html+"</textarea>");
    	
    	$("#step_1_"+memoNo).hide();
    	$("#step_2_"+memoNo).show();
    };
    
    function saveBtn(memoNo){
    	var html = $("#txtform_"+memoNo).val();
    	var cnslNo = ${inquiry.cnslNo};
    	
    	$.ajax({
	        url : "<c:url value='/admin/manage/updateInquiryReplAjax'/>",
	        type: "post",
	        data : "cnslNo=" + cnslNo + "&txt=" + html + "&memoNo=" + memoNo,
	        async: false,
	        success : function(res){
	            if (res > 0) {
					//alert("저장 되었습니다."); 
				} else {
					//alert("저장에 실패 하였습니다.");
				}
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
    	
    	$("#txt_"+memoNo).html(html.replace(/\n/g, "<br>"));
    	
    	$("#step_2_"+memoNo).hide();
    	$("#step_1_"+memoNo).show();
    };
    
    function cancelBtn(){
    	location.reload();
    };
    
    function deleteBtn(memoNo){
    	if(!confirm("삭제하시겠습니까? 지워진 데이터는 복구되지 않습니다.")) return false;
    	var cnslNo = ${inquiry.cnslNo};
    	$.ajax({
	        url : "<c:url value='/admin/manage/deleteInquiryReplAjax'/>",
	        type: "post",
	        data : "cnslNo=" + cnslNo + "&memoNo=" + memoNo,
	        async: false,
	        success : function(res){
	            if (res > 0) {
	            	location.reload(); 
				} else {
					//alert("저장에 실패 하였습니다.");
				}
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
    };    
	</script>
</head> 
<body>
	<form id="hiddenForm" name="hiddenForm" method="post">
		<input type="hidden" name="cnslNo"  id="cnslNo"  value="${inquiry.cnslNo}"/>
		<input type="hidden" name="memoTxt" id="memoTxt" value=""/>
		<input type="hidden" name="memNo"   id="memNo"   value="${inquiry.memNo}"/>
		<input type="hidden" name="memNm"   id="memNm"   value="${inquiry.memNm}"/>
		<input type="hidden" name="tel"   id="tel"   value="${inquiry.tel}"/>
	</form>
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
				<h3><span class="icon1"></span>운영관리 > 고객운영관리 > 1:1문의관리</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 사용자 문의사항을 확인하실 수 있습니다.</li> -->
<!-- 						<li>- 기간검색은 작성일 기준으로 검색됩니다.</li> -->
<!-- 						<li>- 첫번째 문의사항은 ‘문의’로 표시되며 답변에 대한 문의사항 입력시 ‘재문의’로 표시됩니다.</li> -->
<!-- 						<li>- 첨부파일 선택시 다운로드 됩니다.</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- section -->
				<div class="section a1 tabCon_inner">
					<!-- [s] 문의 테이블 -->
					<div class="tableType2">
						<table>
							<caption>문의</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
								<col width="132px" />
								<col width="350px" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="4" class="row_tit">문의</th>
							    </tr>
								<tr>
									<th scope="col">브랜드</th>
									<td>${inquiry.siteNm}</td>
									<th scope="col">작성일</th>
									<td>${inquiry.updDts}</td>
								</tr>
								<tr>
									<th scope="col">제목</th>
									<td colspan="3">${inquiry.title}</td>
								</tr>
								<tr>
									<th scope="col">이름</th>
									<td>${inquiry.memNm}</td>
									<th scope="col">이메일</th>
									<td><a href="/admin/order/orderList?ordKnd=order&searchGb=ORDR_EMAIL&searchText=${inquiry.email}" target="_blank">${inquiry.email}</a></td>
								</tr>
								<tr>
									<th scope="col">휴대폰</th>
									<td>${inquiry.tel}</td>
									<th scope="col">첨부파일</th>
									<td>
										<span>
											<c:set value="${fn:split(inquiry.atchFile,'/') }" var="fileName" />
											<a href="#" data-file="<c:out value='${inquiry.atchFile}'/>" onclick="javascript:fileExport(this);" id="fileExport">
												<c:out value="${fileName[fn:length(fileName)-1] }"></c:out>
											</a>
											<c:if test="${inquiry.atchFile != null and inquiry.atchFile !='' }">
											<a href="/upload/image<c:out value='${inquiry.atchFile}'/>">[직접보기]</a>
											</c:if>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="col">내용</th>
									<td colspan="3">${inquiry.cnslTxt}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 문의 테이블 -->
				</div>
				<!-- //section -->
					
					
					
					
				<c:forEach items="${inquiryReplList}" var="inquiryRepl" varStatus="listCount">
					<c:choose>
						<c:when test="${inquiryRepl.wrtrCls eq 'CM01001'}">
							<!-- section -->
							<div class="section a1 tabCon_inner">
								<!-- [s] 답변 테이블 -->
								<div class="tableType2">
									<table>
										<caption>답변</caption>
										<colgroup>
											<col width="132px" />
											<col width="*" />
											<col width="132px" />
											<col width="350px" />
										</colgroup>
										<tbody>
										    <tr>
										    	<th scope="row" colspan="4" class="row_tit">답변</th>
										    </tr>
											<tr>
												<th scope="col">답변자</th>
												<td>${inquiryRepl.updrNm}</td>
												<th scope="col">작성일</th>
												<td>${inquiryRepl.updDts}</td>
											</tr>
											<tr>
												<th scope="col">답변내용</th>
												<td colspan="3" id="txt_${inquiryRepl.memoNo }">${inquiryRepl.memoTxt}</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- [e] 답변 테이블 -->
							</div>
							<div class="section btn a2" id="step_1_${inquiryRepl.memoNo }">
								<a href="#" onclick="updateBtn('${inquiryRepl.memoNo }')" class="btnType2">수정</a>
								<a href="#" onclick="deleteBtn('${inquiryRepl.memoNo }')" class="btnType1">삭제</a>
							</div>
							<div class="section btn a2" id="step_2_${inquiryRepl.memoNo }" style="display:none;">
								<a href="#" onclick="saveBtn('${inquiryRepl.memoNo }')" class="btnType2">저장</a>
								<a href="#" onclick="cancelBtn('${inquiryRepl.memoNo }')" class="btnType1">취소</a>
							</div>
							<!-- //section -->
						</c:when>
						<c:otherwise>
							<!-- section -->
							<div class="section a1 tabCon_inner">
								<!-- [s] 재문의 테이블 -->
								<div class="tableType2">
									<table>
										<caption>재문의</caption>
										<colgroup>
											<col width="132px" />
											<col width="*" />
										</colgroup>
										<tbody>
										    <tr>
										    	<th scope="row" colspan="4" class="row_tit">재문의</th>
										    </tr>
											<tr>
												<th scope="col">작성일</th>
												<td>${inquiryRepl.updDts}</td>
											</tr>
											<tr>
												<th scope="col">내용</th>
												<td>${inquiryRepl.memoTxt}</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- [e] 재문의 테이블 -->
							</div>
							<!-- //section -->
							
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
					
				
				<!-- section -->
				<div class="section a2">
					
					<!-- [s] 답변 테이블 -->
					<div class="tableType2 pt20">
						<table>
							<caption>답변</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
								<col width="132px" />
								<col width="350px" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="4" class="row_tit">답변</th>
							    </tr>
								<tr>
									<th scope="col">답변내용</th>
									<td colspan="3"><textarea id="repl" name="repl" cols="30" rows="10" class="txtareaAll"></textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 답변 테이블 -->
				</div>
				<!-- //section -->
				<!-- section -->
				<div class="section btn a2">
					<a href="#" id="saveBtn" class="btnType2">저장</a>
					<a href="#" id="initBtn" class="btnType1">취소</a>
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