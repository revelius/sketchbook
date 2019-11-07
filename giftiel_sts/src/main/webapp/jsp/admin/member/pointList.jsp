<%--
 * =============================================================================
 * 파일명 : /member/pointList.jsp
 * 작성자 : 정해란
 * 작성일자 : 2015-04-22
 *
 * 파일 내용 : 회원관리 > 포인트 관리  
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
	
	<script>
	$(function() { 
		
		// 버튼활성화
		if($("#searchText").val() != '' && $("#searchText").val() != null){
			$("#btn_search_all").show();
		}

		//리스트 검색 공통
	    $('#btn_search').click(function() {
	    	if($('#searchGb').val() == '' || $('#searchGb').val() == null){
	    		alert("검색구분을 선택하세요");
	    		return;
	    	}
	    	document.getElementById("page").value = '';
	    	functionSubmit();
	    });
		
		$('#btn_search_all').click(function(){
			location.href="/admin/member/pointList";
		});

		functionSubmit = function(){
			var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = "<c:url value='/admin/member/pointList'/>";
	        frm.submit();
		};
		
		//페이징처리
		paging = function(page) {
	        //var frm = document.schForm;
	        document.getElementById("page").value = page;
	        functionSubmit();
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
			functionSubmit();
		};
		
		//엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$("#page").val('');
	    	functionSubmit();
	    	$("#excel").val("false");
	    });
		
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
		
		doPointReg = function(){
			$(".under_table").fadeToggle();
		};
		
		doPointSave = function(){
			var chkCnt = 0;
			var memNo = "";
			$("input:checkbox[id^=selChk]").each(function(){
				if(this.checked){
					memNo = $(this).attr("data-value");
					chkCnt++;
				}	
			});
			
			if(chkCnt > 1 || chkCnt == 0){
				alert("항목을 한개 선택하세요.");
				return;
			}
			
			if($("#rsvRsnCd").val()==""){
				alert("포인트 내용을 선택하세요.");
				return;
			}
			
			if($("#rsvPnt").val()==""){
				alert("포인트를 입력하세요.");
				$("#rsvPnt").focus();
				return;
			}
			
			if($("#rsvPnt").val().indexOf('.') > 0){
				alert("포인트에 소수는 입력할 수 없습니다.");
				return;
			}
			
			//포인트 숫자에 콤마 제거 
			$("#rsvPnt").val($("#rsvPnt").val().replace(/,/g, ''));
			
			//데이터 셋팅 
			var frmdata = {
				memNo		: memNo, 
				rsvRsnCd	: $("#rsvRsnCd").val(), 
				rsvPnt		:$("#rsvPnt").val(), 
				rsvCls		:$("#rsvCls").val(), 
				useYn		:$("#useYn").val()
			};
			
			$.ajax({
		        url : "<c:url value='/admin/member/insertPoint'/>",
		        type: "POST",
		        data : frmdata,
		        async: false,
		        //dataType: "json",
		        //contentType: "application/json", 
		        success : function(responseData){
		            var data = JSON.parse(responseData);
		            if(data=="1"){  //저장 성공 
						alert("저장되었습니다.");   
						functionSubmit();
		            }
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};
	});	
	
	function doDetailMem(memNo){
        location.href="<c:url value='/admin/member/membershipInfo'/>?memNo="+memNo;
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
					<jsp:param name="menuFlag" value="member"/>
					<jsp:param name="onChk" value="pointList"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents memberList">
					<!--[s] 검색목록 -->
					<div class="section a1">
						<h3><span class="icon1"></span>포인트 관리</h3>	
						<div class="tableType2">
							<p class="boxP"><span class="blue"></span> 다음은 포인트 회원목록 입니다.
 											<span class="p_right">※ 총 건수 : <fmt:formatNumber value="${searchForm.totalCnt }" groupingUsed="true"/>건 &nbsp;  / &nbsp; 전체포인트 합계 : <fmt:formatNumber value="${sumPoint }" groupingUsed="true"/>점</span></p>	
						</div>  
					</div>
					<!--[e] 검색목록 -->

					<!--[s] 검색결과 리스트 -->
					<div class="section a2">
						<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
						
						<form:hidden path="excel" id="excel"/>
   						<form:hidden path="page" id="page"/>
   						<form:hidden path="orderBy" id="orderBy"/>
   						<form:hidden path="orderFlag" id="orderFlag"/>
						
						<div class="tableTitle">				
							<div class="select2 ht24">
								<form:select path="searchGb" id="searchGb" style="margin-top:2px;height:20px;line-height:20px;border:1px solide #dedede;font-size:12px;color:#6b6b6b;vertical-align:middel;margin-right:3px;">
									<form:option value="">검색구분</form:option>
									<form:option value="EMAIL">email</form:option>
									<form:option value="NM">이름</form:option>
									<form:option value="CP_NO">핸드폰 번호</form:option>
									<form:option value="RSV_RSN_CD">포인트 내용</form:option>
								</form:select>
								<form:input path="searchText" id="searchText"/>
								<a href="javascript:void(0);" id="btn_search" class="btnType2 ml10">검색</a>
								<a href="javascript:void(0);" id="btn_search_all" class="btnType2 ml10" style="display:none;">전체보기</a>
							</div>
						</div>

						</form:form>
						
						<div class="tableType1">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="5%" />
								<col width="15%" />
								<col width="10%" />
								<col width="10%" />
								<col width="*" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />				
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th><!-- <input type="checkbox" id="allCheck" name="allCheck" /> --></th>
									<th>E-mail계정<a id="EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>이름<a id="NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>회원등급<a id="GRD_NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>일시<a id="REG_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>포인트 내용<a id="RSV_RSN_CD" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>사용포인트<a id="USE_POINT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>적립포인트<a id="CUR_POINT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>발행인<a id="RSV_CLS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>포인트 합<a id="TOT_POINT" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pointList}" var="point" varStatus="listCount">
								<tr>
									<td><input type="checkbox" id="selChk${listCount.count }" name="selChk" data-value="${point.memNo}"/></td>
									<td><a href="javascript:doDetailMem('${point.memNo}');">${point.email}</a></td>
									<td>${point.nm}</td>
									<td>${point.grdNm}</td>
									<td><fmt:formatDate value="${point.regDts}" pattern="yyyy-MM-dd" /><br /><fmt:formatDate value="${point.regDts}" pattern="HH:mm:SS" /></td>
									<td>${point.rsvRsnCd }</td>
									<td><fmt:formatNumber value="${point.usePoint }" groupingUsed="true"/></td>
									<td><fmt:formatNumber value="${point.curPoint }" groupingUsed="true"/></td>
									<td>${point.rsvCls }</td>
									<td><fmt:formatNumber value="${point.totPoint }" groupingUsed="true"/></td>
								</tr>
								</c:forEach>
								<c:if test="${empty pointList}">
									<tr>
										<td colspan="10">조회된 데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!--[e] 검색결과 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						<c:if test="${not empty pointList}">
						${pageHtml}
						</c:if>
<!-- 						<div class="right"> -->
<!-- 							<a href="javascript:void(0);" class="btnType2" id="btn_excel">엑셀출력</a> -->
<!-- 						</div> -->
						<div class="left">
								<!-- 기능 삭제 : 2015-04-23 -->
<!-- 							<a href="#" class="btnType2">선택삭제</a> -->
							<a href="javascript:doPointReg();" class="btnType2">선택회원 포인트 등록</a>
						</div>						
					</div>
					<!--[e] 페이징 -->
					
					<form:form id="regForm" name="regForm" method="post" modelAttribute="regForm" onsubmit="return check(form)">
					<form:hidden path="memNo" id="memNo"/>
					<form:hidden path="useYn" value="Y"/>
					<form:hidden path="rsvCls" value="CM01001"/>
					
					<!--[s] 포인트 직접등록 -->
					<div class="under_table tableType1" style="display:none">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="*" />
								<col width="30%" />
								<col width="15%" />										
							</colgroup>
							<thead>
								<tr>
									<th colspan="3" class="th_title">포인트 직접 등록</th>					
								</tr>
								<tr>
									<th>포인트내용</th>
									<th>포인트</th>
									<th>입력</th>
								</tr>
							</thead>
							<tbody>
								<tr>							
									<td>
										<form:select path="rsvRsnCd" id="rsvRsnCd" style="width:150px;">
											<form:option value="">선택</form:option>
											<form:options items="${rsvRsnList}" itemLabel="cdNm" itemValue="cdNo"/>
										</form:select>
									</td>
									<td><input type="text" class="ip_text wd_258" id="rsvPnt" name="rsvPnt" onkeyup="inputNumberFormat(this)" style="text-align:right;IME-MODE:disabled;"/></td>
									<td><a href="javascript:doPointSave();" class="btnType2">확인</a></td>
								</tr>										
							</tbody>
							</table>
						</div>
						</form:form>
					</div>
					<!--[e] 포인트 직접등록 -->
				</div>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

</body>
</html>