<%--
 * =============================================================================
 * 파일명 : /member/membershipInfo.jsp
 * 작성자 : 정해란
 * 작성일자 : 2015-04-20
 *
 * 파일 내용 : 회원관리 > 회원상세정보 
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>

	<script>
	//등급 수정
	//function doUpdGrd(memNo){
	doUpdGrd = function(memNo){
	 	$.ajax({
	        url : "<c:url value='/admin/member/updateMemGrd'/>",
	        type: "post",
	        data : {memNo : memNo, memGrdNo : $("#memGrdNo").val()},
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data=="1"){  //저장 성공 
					alert("수정 되었습니다.");                	
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	}; 
	
	//글쓰기 버튼 클릭시 토글 페이드
	doCommentW = function(){
		$(".sectionComment").fadeToggle();
		$("#comment").val("");
		$("#regDts").val("");
		$("#regrNo").val("");
	};
	
	//글쓰기 취소시
	doCancel = function(){
		doCommentW();
	};
	
	//회원코멘트 상세 내용 보기
	doDetailView = function(i){
		$("#commentDtl"+i).fadeToggle();
	};
	//회원 코멘트 등록
	doSave = function(memNo){
		if($("#comment").val()==""){
			alert("등록할 내용을 입력하세요.");
			$("#comment").focus();
			return;
		}
		
	 	$.ajax({
	        url : "<c:url value='/admin/member/insertMemComment'/>",
	        type: "post",
	        data : {memNo : memNo, comment : $("#comment").val()},
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data=="1"){  //저장 성공 
					alert("등록 되었습니다.");
	            	location.href = "<c:url value='/admin/member/membershipInfo?memNo='/>"+memNo;
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};
	
	//회원 코멘트 삭제
	doDelete = function(cmntNo,memNo){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}		
	 	$.ajax({
	        url : "<c:url value='/admin/member/deleteMemComment'/>",
	        type: "post",
	        data : {cmntNo : cmntNo},
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data=="1"){  //삭제 성공 
					alert("삭제 되었습니다.");
	            	location.href = "<c:url value='/admin/member/membershipInfo?memNo='/>"+memNo;
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};
	
	doGoMove = function(gubun){
		 if(gubun== "1"){
			var frm = document.schForm;
	        frm.action = "<c:url value=' /admin/member/memberOrderList'/>";
	        frm.submit();
		}else if(gubun== "2"){
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/inquire'/>";
	        frm.submit();
		}else if(gubun== "3"){
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/cartList'/>";
	        frm.submit();
		}	
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
				
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
				<form:hidden path="nm" id="nm"/>
				<form:hidden path="email" id="email"/>
				<form:hidden path="memNo" id="memNo"/>
				
				<!--[s] contents -->
				<div class="contents memberList">
					<!--[s] 회원정보 목록 -->
					<div class="section a1">
						<h3><span class="icon1"></span>회원정보</h3>	
						<p class="pt_14">${memberList.nm}(${memberList.email}) 님의 정보</p>

						<div class="tabType1">
							<ul><%-- <c:url value='/admin/member/membershipInfo?memNo=${memberList.memNo}'/> --%>
								<li class="on"><a href="#">회원정보</a></li>
								<li><a href="javascript:doGoMove('1');">주문내역</a></li><!-- /admin/member/orderList.html -->
								<li><a href="javascript:doGoMove('2');">1:1 문의</a></li><!-- /admin/member/inquire.html -->
								<li><a href="javascript:doGoMove('3');">Cart</a></li><!-- /admin/member/cart.html -->
							</ul>
						</div>

						<!--[s] 기본정보 -->
						<div class="section a2">
							<div class="tableType1 table_left">
								<table class="mb_16">
								<caption>기본정보</caption>
									<colgroup>
										<col width="10%" />
										<col width="20%" />
										<col width="10%" />
										<col width="20%" />
										<col width="10%" />
										<col width="20%" />
									</colgroup>
									<thead>
										<tr>
											<th colspan="6" class="th_title">기본정보</th>					
										</tr>
									</thead>
									<tbody>
									 	<tr>
									 		<th>구분</th>
									 		<td colspan="5" class="tl">
									 		<c:choose>
									 			<c:when test="${memberList.wdrwYn eq 'Y'}">
									 				<span class="c_f00">탈퇴</span>
									 			</c:when>
												<c:otherwise>
													회원
												</c:otherwise>									 			
									 		</c:choose>
									 		</td>
									 	</tr>
										<tr>
											<th>ID</th>
											<td>${memberList.email}</td>
											<th>생년월일</th>
											<td><fmt:formatDate value="${memberList.birthDt}" pattern="yyyy.MM.dd" /></td>
											<th>회원등급</th>
											<td>
												<c:choose>
													<c:when test="${userCls eq 'AD02001'}">
														<form:select path="memGrdNo" id="memGrdNo">
															<form:options items="${memberGradeList}" itemLabel="grdNm" itemValue="memGrdNo"/>
														</form:select>
														<a href="javascript:doUpdGrd('${memberList.memNo}');" class="btnType1">수정</a>
													</c:when>
													<c:otherwise>
														${memberList.grdNm}
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>									
											<th>성별</th>
											<td><c:if test="${memberList.sex eq 'M'}">남</c:if><c:if test="${memberList.sex eq 'W'}">여</c:if>(${memberList.age})</td>
											<th>휴대폰번호</th>
											<td>${memberList.cpNo}</td>
											<th>포인트</th>
											<td><fmt:formatNumber value="${memberList.curPoint}" groupingUsed="true"/> P</td>
										</tr>
										<tr>
									 		<th>주소1</th>
									 		<td colspan="5" class="tl">${memberList.bsAddr1} ${memberList.dtlAddr1}</td>
									 	</tr>
									 	<tr>
									 		<th>주소2</th>
									 		<td colspan="5" class="tl">${memberList.bsAddr2} ${memberList.dtlAddr2}</td>
									 	</tr>
									 	<tr>
									 		<th>주소3</th>
									 		<td colspan="5" class="tl">${memberList.bsAddr3} ${memberList.dtlAddr3}</td>
									 	</tr>	
										<tr>									
											<th>최초가입일</th>
											<td><fmt:formatDate value="${memberList.regDts}" pattern="yyyy.MM.dd" /><br><fmt:formatDate value="${memberList.regDts}" pattern="HH:mm:ss" /></td>
											<th>최초가입<br>사이트</th>
											<td>${memberList.siteDesc}</td>
											<th>최근 접속일</th>
											<td><fmt:formatDate value="${memberList.loginCnt}" pattern="yyyy.MM.dd" /><br><fmt:formatDate value="${memberList.loginCnt}" pattern="HH:mm:ss" /></td>
										</tr>		
									</tbody>
								</table>						
							</div>
						</div>
						<!--[e] 기본정보 -->	

						<!--[s] 탈퇴정보 -->
						<c:if test="${memberList.wdrwYn eq 'Y'}">
						<div class="section a2">
							<div class="tableType1">
								<table class="mb_16">
									<caption>탈퇴정보</caption>
									<colgroup>
										<col width="20%" />
										<col width="*" />
									</colgroup>
									<thead>
										<tr>
											<th colspan="2" class="th_title">탈퇴정보</th>					
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>탈퇴일자</th>
											<td class="tl"><fmt:formatDate value="${memberList.updDts}" pattern="yyyy.MM.dd HH:MM:SS" /></td>
										</tr>
										<tr>
											<th>탈퇴사유</th>
											<td class="tl">${memberList.wdrwDtlRsn}</td>
										</tr>										
									</tbody>
								</table>
							</div>
						</div>
						</c:if>
						<!--[e] 탈퇴정보 -->			

						<!--[s] 구매정보 -->
						<div class="section a2">
							<div class="tableType1">
								<table class="mb_16">
								<caption>구매정보</caption>
								<colgroup>
									<col width="20%" />
									<col width="20%" />
									<col width="20%" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="5" class="th_title">구매정보</th>					
									</tr>
									<tr>
										<th>구매횟수</th>
										<th>(누적)구매갯수</th>
										<th>구매 총 금액</th>
										<th>최초 구매일</th>
										<th>최종 구매일</th>
									</tr>
								</thead>
								<tbody>
									<tr>									
										<td><fmt:formatNumber value="${ordInfo.countOrd}" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${ordInfo.orderCnt}" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${ordInfo.slPrc}" groupingUsed="true"/></td>
										<td><fmt:formatDate value="${ordInfo.regDts}" pattern="yyyy.MM.dd" /></td>
										<td><fmt:formatDate value="${ordInfo.updDts}" pattern="yyyy.MM.dd" /></td>								
									</tr>										
								</tbody>
								</table>
							</div>
						</div>
						<!--[e] 구매정보 -->		

						<!--[s] 회원코멘트 -->
						<div class="section a2">
							<div class="tableType1">
								<table class="mb_16">
								<caption>회원코멘트</caption>
								<colgroup>
									<col width="20%" />
									<col width="*" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="4" class="th_title">회원코멘트</th>					
									</tr>
									<tr>
										<th>NO</th>
										<th>내용</th>
										<th>작성일</th>
										<th>작성자</th>
									</tr>
								</thead>
								<tbody>
									
									<c:forEach items="${memberCmtList}" var="memberCmtList" varStatus="listCount">		
									<tr>									
										<td>${listCount.count}</td>
										<td><a href="javascript:doDetailView('${listCount.count}');">${fn:substring(memberCmtList.cmntTxt,0,30)}...</a></td>
										<td><fmt:formatDate value="${memberCmtList.regDts}" pattern="yyyy.MM.dd" /></td>
										<td>${memberCmtList.regrNm}</td>							
									</tr>
									<tr id="commentDtl${listCount.count}" style="display:none;">
										<td colspan="4">
											<p class="coment">${memberCmtList.cmntTxt}</p>
											<a href="javascript:doDelete('${memberCmtList.cmntNo}','${memberList.memNo}');" class="btnType1 comentDel">삭제</a>
										</td>
									</tr>
									</c:forEach>
									<c:if test="${empty memberCmtList}">
										<tr>
											<td colspan="4">내용이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
								</table>
								<div class="btn">
									<a href="javascript:doCommentW();" class="btnType2 right">글쓰기</a>
								</div>
							</div>
						</div>
						<!--[e] 회원코멘트 -->

						<!--[s] 회원코멘트 글쓰기 -->
						<div class="section a2 sectionComment" style="display:none;">
							<div class="tableType1">
								<table class="mb_16">
								<caption>회원코멘트</caption>
								<colgroup>
									<col width="5%" />
									<col width="*" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="4" class="th_title">회원코멘트</th>					
									</tr>
									<tr>
										<th>NO</th>
										<th>내용</th>
										<th>작성일</th>
										<th>작성자</th>
									</tr>
								</thead>
								<tbody>
<!-- 									<tr>									 -->
<!-- 										<td>1</td> -->
<!-- 										<td>구매 번복을 자주 요청하는 회원…</td> -->
<!-- 										<td>yyyy.mm.dd</td> -->
<!-- 										<td>CS팀 홍길동</td>							 -->
<!-- 									</tr> -->
									<tr>
										<td>1</td>
										<td><input type="text" class="ip_tit" name="comment" id="comment" maxlength="100" onblur="javascript:chkLen(this,100);"/></td>
										<%
										Date today = new Date();
										SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
										String dt = sf.format(today);
										%>
										<td><%=dt%></td>
										<td>${adminNm}</td>		
									</tr>
								</tbody>
								</table>   
								<div class="btn">
									<div class="right">
										<a href="javascript:doSave('${memberList.memNo}');" class="btnType2">등록</a>
										<a href="javascript:doCancel();" class="btnType2">취소</a>
									</div>
								</div>
							</div>
						</div>
						<!--[e] 회원코멘트 글쓰기 -->					
					</div>
					<!--[e] 회원정보목록 -->				

				</div>
				<!--[e] contents -->
				
				</form:form>
				
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