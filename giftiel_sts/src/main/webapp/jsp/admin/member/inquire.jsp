<%--
 * =============================================================================
 * 파일명 : /member/inquire.jsp
 * 작성자 : 정해란
 * 작성일자 : 2015-04-21
 *
 * 파일 내용 : 회원관리 > 1:1문의 
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
	    $("a[href=#]").attr("href", "javascript:void(0);");
	    
	    //정렬기준
		setOrderBy = function(obj) {
			var $this	= $(obj);
			$('#orderBy').val($this.attr("id"));
			if ( $this.hasClass("up") ) {
				$('#orderFlag').val("DESC");
			}else{
				$('#orderFlag').val("ASC");
			}
			goSubmit();		
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
		
		
		//페이징 처리
	    paging = function(page) {
	        var frm = document.schForm;
	        document.getElementById("page").value = page;
	        goSubmit();
	    };	    
	    
	    
	    //결과 갯수 셋팅
	    doNumList = function() {
	    	var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/member/inquire'/>";
		        frm.submit();
	    };
	    
	    
	    goSubmit = function(){
	    	 var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/member/inquire'/>";
		        frm.submit();
	    };
    });
    
    doGoMove = function(gubun){
		if(gubun== "1"){ //회원정보
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/membershipInfo'/>";
	        frm.submit();
		}else if(gubun== "2"){
			var frm = document.schForm;
	        frm.action = "<c:url value=' /admin/member/memberOrderList'/>";
	        frm.submit();
		}else if(gubun== "3"){
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/cartList'/>";
	        frm.submit();
		}	
	};
    
    goDetail = function(cnslNo){
    	var $target = $(cnslNo);
    	var cnslNo = $target.attr('data-cnslNo');
    	var frm = document.hiddenForm;
    	frm.cnslNo.value = cnslNo;
    	frm.action = "<c:url value='/admin/manage/inquiryDetail'/>";
        frm.submit();
    };
    
    //파일다운로드
    fileExport= function(fileName){
    	var $target = $(e);
    	//var fileName = $target.attr('data-file');
    	
    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"'/>");
    };
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
					<jsp:param name="menuFlag" value="member"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents memberList">				
					<h3><span class="icon1"></span>회원정보</h3>	
					<p class="pt_14">${searchForm.nm}(${searchForm.email }) 님의 정보<span>최종로그인
						<c:if test="${empty logingHist.regDts}">
						: 로그인 이력 없음
						</c:if>
						<fmt:formatDate value="${logingHist.regDts}" pattern="yyyy-MM-dd HH:mm:SS" /> </span></p>

					<div class="tabType1">
						<ul>
							<li><a href="javascript:doGoMove('1');">회원정보</a></li>
							<li><a href="javascript:doGoMove('2');">주문내역</a></li>
							<li class="on"><a href="#">1:1 문의</a></li>
							<li><a href="javascript:doGoMove('3');">Cart</a></li><!-- /admin/member/cart.html -->
						</ul>
					</div>
					
					<form id="hiddenForm" name="hiddenForm" method="post">
						<input type="hidden" id="cnslNo" name="cnslNo"/>
					</form>
				
					<!--[s] 1:1문의 리스트 -->
					<div class="section a2">
						<div class="tableTitle">
							<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
								<form:hidden path="nm" id="nm"/>
        						<form:hidden path="email" id="email"/>
        						<form:hidden path="memNo" id="memNo"/>
        						<form:hidden path="orderFlag" id="orderFlag"/>
        						<form:hidden path="orderBy" id="orderBy"/>
        													
							<div class="select2">								
								<form:select path="replGb" onchange="javascript:doNumList();">
									<form:option value="">전체</form:option>
									<form:option value="y">답변완료</form:option>
									<form:option value="n">미답변</form:option>
								</form:select>	
								
								<form:select path="searchCount" onchange="javascript:doNumList();">
									<form:option value="">선택</form:option>
									<form:option value="15">15개 보기</form:option>
									<form:option value="30">30개 보기</form:option>
									<form:option value="50">50개 보기</form:option>
									<form:option value="100">100개 보기</form:option>
									<form:option value="200">200개 보기</form:option>
								</form:select>							
							</div>
							
							</form:form>
						</div>

						<div class="tableType1">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="5%" />
								<col width="10%" />
								<col width="*" />
								<col width="5%" />
								<col width="10%" />
								<col width="15%" />
								<col width="12%" />
								<col width="12%" />
							</colgroup>
							<thead>
								<tr  id="sortTr">
									<th>No</th>
									<th>문의</th>
									<th>제목</th>
									<th>첨부파일</th>
									<th>이름</th>
									<th>브랜드</th>
									<th>작성일<a id="UPD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>답변여부 <a id="CNSL_STAT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${inquiryList}" var="inquiry" varStatus="listCount">
										<tr>	
											<td>${inquiry.rnum}</td>
											<td>문의</td>
											<td class="ta_l"><a href="#" onclick="javascript:goDetail(this);" data-cnslNo="<c:out value='${inquiry.cnslNo}'/>">${inquiry.title}</a></td>
											<td>
											<c:choose>
												<c:when test="${not empty inquiry.atchFile}">
													<a href="javascript:fileExport('${inquiry.atchFile}');">
													<img src="<c:url value='/resources/admin/images/common/file.jpg'/>" alt="">
													</a>
												</c:when>
												<c:otherwise>
												-
												</c:otherwise>
											</c:choose>
											</td>
											<td>${inquiry.memNm}</td>
											<td>${inquiry.email}</td>
											<td>${inquiry.updDts}</td>
											<td>${inquiry.cnslStat}</td>
										</tr>
								</c:forEach>
								<c:if test="${empty inquiryList}">
									<tr>
										<td colspan="8">조회할 항목이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!--[e] 1:1문의 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						<c:if test="${not empty inquiryList}">
							${pageHtml}
						</c:if>
						<div class="left">
							<a href="<c:url value='/admin/member/memberList'/>" class="btnType1">회원목록</a>
						</div>
					</div>
					<!--[e] 페이징 -->				

				</div>
				<!--[e] contents -->

			</div>
		<!--[e] subWrap -->

		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>