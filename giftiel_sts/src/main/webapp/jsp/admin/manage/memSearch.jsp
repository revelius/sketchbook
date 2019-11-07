<%--
 * =============================================================================
 * 파일명 : /member/memsearch.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : sms발송 > 회원목록
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
    	
 
		//리스트 검색 공통
	    $('#btn_search').click(function() {
	    	$("#page").val("1");
	    	
	        var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = 'memSearch';
	        frm.submit();
	    });
		
		//검색 초기화 버튼
	    $('#btn_reset').click(function() {
            $(':input').each(function(index) {
            	if($(this).attr('type')=="text"){
            		$(this).val("");
            	}
            });
            $('select').find('option:first').attr('selected', 'selected');
	    });		
	    
		//페이징처리
		paging = function(page) {
	        document.getElementById("page").value = page;
	        $('#btn_search').trigger('click');
		};
		
	    //정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			$('#btn_search').click();			
		};
		
		$('#sortTr a').each(function() {
			if ( $('#orderBy').val() == $(this).attr("id") && $('#orderFlag').val() == "DESC" ) {
				$(this).html("▼");
				$(this).removeClass("up");
				$(this).addClass("down");
			}else{
				$(this).html("▲");
				$(this).removeClass("down");
				$(this).addClass("up");
			}
		});	
		
    });
    
    function sendChildSmsValue(cpNo){
    	cpNo2 = cpNo.replace(/-/g,"");
    	opener.setChildValue(cpNo2);
    }
    
    function sendChildMailValue(cpNo,cpNm){
    	opener.setChildMailValue(cpNo,cpNm);
    }
    
    
    
	</script>
</head> 
<body>
	<div class="layerWrap">
		<div class="title">
			<h1>회원주소록</h1>
			<a href="javascript:;" onclick="window.close()">Close</a>
		</div>
		<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="">
		<form:hidden path="page" id="page" name="page"/>		
		<!--[s] contents -->
		<div class="memberList" style="margin-left:30px;margin-bottom:30px;margin-right:30px;">
			<!--[s] 검색목록 -->
			<div class="section a1">
				<h3><span class="icon1"></span>회원목록</h3>						
				<div class="tableType2">
					<p class="boxP"> 다음은 회원목록 입니다.<span>총 회원수 : <fmt:formatNumber value="${totalCnt }" groupingUsed="true"/> 
					/ 탈퇴 : 
					<c:choose>
						<c:when test="${not empty wdrwCnt}">
							<fmt:formatNumber value="${wdrwCnt}" groupingUsed="true"/>
						</c:when>
						<c:otherwise>
						0
						</c:otherwise>	
					</c:choose>
					</span> </p>
					
						<form:hidden path="excel" id="excel"/>
	     						<form:hidden path="page" id="page"/>
	     						<form:hidden path="orderBy" id="orderBy"/>
	     						<form:hidden path="orderFlag" id="orderFlag"/>
	     						<form:hidden path="memNo" id="memNo"/>
	     						
						<table>
						<caption>회원목록 검색</caption>
						<colgroup>
							<col width="132px" />
							<col width="456px" />
							<col width="132px" />
							<col width="300px" />
						</colgroup>
						<tbody>
							<tr>
								<th>직점검색</th>
								<td colspan="3">
									<div class="wrap">
										<form:select path="searchGb">
											<form:option value="">검색구분</form:option>
											<form:option value="email">email</form:option>
											<form:option value="nm">이름</form:option>
											<form:option value="cp_No">핸드폰 번호</form:option>
										</form:select>
										<form:input path="searchText" id="searchText"/>
									</div>
								</td>
							</tr>
						</tbody>
						</table>
					
				</div>
				<div class="btn">
					<a href="javascript:void(0);" id="btn_search" class="btnType2">검색</a>
					<a href="javascript:void(0);" id="btn_reset" class="btnType2">초기화</a>
				</div>
			</div>
			<!--[e] 검색목록 -->
	
			<!--[s] 검색결과 리스트 -->
			<div class="section a2">
				<div class="tableTitle">
					<div class="left"><span class="icon2"></span>검색된 회원은 <span class="blue">${totalCnt }</span> 명 입니다.</div>					
				</div>
				<div class="tableType1">
					<table>
					<caption>회원목록 검색 결과 리스트</caption>
					<colgroup>
						
						<col width="50px" />
						<col width="50px" />
						<col width="30px" />
						<col width="50px" />
						
					</colgroup>
					<thead>  
						<tr id="sortTr">
							<!-- <th><input type="checkbox" id="allCheck" name="allCheck" /></th>
							<th>구분</th> -->
							<th>Email 계정 <a id="EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
							<th>이름 <a id="NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
							<th>성별 <a id="SEX" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
							<th>핸드폰번호 <a id="CP_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberList}" var="member" varStatus="listCount">
							<tr>
								<td>
									<c:choose>
										<c:when test="${hiddenSendType == 'mailSendType'}">
										<a href="javascript:sendChildMailValue('${member.email}','${member.nm }');">
											${member.email }
										</a>										
										</c:when>
										<c:otherwise>
											${member.email }
										</c:otherwise>
									</c:choose>
								</td>
								<td id="memName">${member.nm }</td>
								<td>
								<c:choose>
									<c:when test="${member.sex eq 'M'}">
									남
									</c:when>
									<c:when test="${member.sex eq 'F'}">
									여
									</c:when>
									<c:otherwise>
									기타
									</c:otherwise>
								</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${hiddenSendType == 'smsSendType'}">
									<a href="javascript:sendChildSmsValue('${member.cpNo }')">
										${member.cpNo }
									</a>
									</c:when>
									<c:otherwise>
										${member.cpNo }
									</c:otherwise>
								</c:choose>
								</td>								
							</tr>
						</c:forEach>
						
						<c:if test="${empty memberList}">
							<tr>
								<td colspan="4">조회된 데이터가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
					</table>
				</div>
			</div>
			<!--[e] 검색결과 리스트 -->
	
			<!--[s] 페이징 -->
			<div class="paging">
				${pageHtml}
			</div>
			<!--[e] 페이징 -->
	
		</div>
		</form:form>
		<!--[e] contents -->
	</div>
</body>
</html>