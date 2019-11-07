<%--
 * =============================================================================
 * 파일명 : /goods/goodsList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리 > 상품목록
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
	        var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = 'popupGoodsList?resultId=${param.resultId}';
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
		
		// datepicker 
		$( ".datepicker1, .datepicker2" ).datepicker({
			inline: true, 
			dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
			showOn: "both", 
			buttonImage: "${contextPath }/resources/admin/images/common/icon_calender.gif",
			buttonImageOnly: true, 
			minDate: '-30y', 
			showMonthAfterYear: true,   /* 년과 달의 위치 바꾸기 */ 
			/* 한글화 */ 
			monthNames : ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'], 
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
			showAnim: 'slideDown', 
			/* 날짜 유효성 체크 */ 
			onClose: function( selectedDate ) { 
			  $('#fromDate').datepicker("option","minDate", selectedDate); 
			} 
		});
		$('#ui-datepicker-div').addClass('dateCal');
	    
		//페이징처리
		paging = function(page) {
	        var frm = document.schForm;
	        document.getElementById("page").value = page;
	        $('#btn_search').trigger('click');
		};
		
		//결과 갯수 셋팅
		doNumList = function() {
			$('#btn_search').click();
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
		
		//엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$('#btn_search').click();
	    	$("#excel").val("false");
	    });
		
		//체크데이터 객체로 부모창으로 전달
	    $('#btn_addData').click(function() {
	    	//var goodsList = new Array($("input[name=chkGoods]:checked").length);
	    	var goodsData = "";
            $("input[name=chkGoods]:checked").each(function(index) {
            	
            	goodsData += $(this).val();
            	if($("input[name=chkGoods]:checked").length-1 != index){
            		goodsData += "|";	
            	}
            	//var goods = new Object();
            	//goods.ubiGdsNo = $(this).val().split(':')[0];
            	//goods.ubiGdsNm = $(this).val().split(':')[1];
            	//goodsList[index] = goods;
            	
            	//$(opener.location).attr("href","javascript:selectedGoods('"+goodsList+"');");
            });
            $("#${param.resultId}",opener.document).val(goodsData);
            if(typeof opener.parent.callback_setGoods != "undefined"){
            	 opener.parent.callback_setGoods(goodsData,"${param.resultId}");
            }
            
            window.close();
	    });		
    });
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] container -->
		<div id="container">
			<div class="subWrap">
				<!--[s] contents -->
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
				<div class="contents productList" style="margin-left:0px; width:700px;">
					<form:hidden path="excel" id="excel"/>
					<form:hidden path="page" id="page"/>
					<form:hidden path="orderBy" id="orderBy"/>
					<form:hidden path="orderFlag" id="orderFlag"/>				
					<!--[s] 상품목록 -->
					<div class="section a1" style="width:700px;">
						<h3><span class="icon1"></span>상품목록</h3>
						<div class="tableType2"  style="width:700px;">
							<div class="tableType2"  style="width:700px;">
								<table>
								<caption>상품등록 폼</caption>
								<colgroup>
									<col width="12%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>상품분류</th>
										<td>
											<form:select path="oneDepth">
												<form:option value="">대 카테고리</form:option>
												<form:options items="${oneDepth}" itemLabel="cateNm" itemValue="cateCd"/>
											</form:select>
											<form:select path="twoDepth">
												<form:option value="">중 카테고리</form:option>
												<form:options items="${twoDepth}" itemLabel="cateNm" itemValue="cateCd"/>
											</form:select>
											<form:select path="threeDepth">
												<form:option value="">소 카테고리</form:option>
												<form:options items="${threeDepth}" itemLabel="cateNm" itemValue="cateCd"/>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th>상품등록일</th>
										<td class="p_line5">
											<div class="period2">
												<span class="dateinput"><form:input path="regStrDtm" id="regStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
												<span class="dateinput"><form:input path="regEndDtm" id="regEndDtm" readonly="true" cssClass="datepicker2"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>상품수정일</th>
										<td class="p_line5">
											<div class="period2">
												<span class="dateinput"><form:input path="updStrDtm" id="updStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
												<span class="dateinput"><form:input path="updEndDtm" id="updEndDtm" readonly="true" cssClass="datepicker2"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>판매상태</th>
										<td>
											<form:radiobutton path="gdsStat" label="전체"/>
											<form:radiobuttons path="gdsStat" items="${gdsStatList}" itemLabel="cdNm" itemValue="cdNo"/>
										</td>
									</tr>
									<tr>
										<th>전시여부</th>
										<td>
											<form:radiobutton path="dispYn" label="전체"/>
											<form:radiobutton path="dispYn" label="전시" value="Y"/>
											<form:radiobutton path="dispYn" label="비전시" value="N"/>
										</td>
									</tr>
									<tr>
										<th>상품가격</th>
										<td>
											<form:input path="ubiSlStrPrc" id="ubiSlStrPrc"/> 원 ~ <form:input path="ubiSlEndPrc" id="ubiSlEndPrc"/> 원 
										</td>
									</tr>
									<tr>
										<th>직접검색</th>
										<td>
											<form:select path="searchGb">
												<form:option value="">검색구분</form:option>
												<form:option value="품명">상품명</form:option>
												<form:option value="품번">상품코드</form:option>
												<form:option value="BARND">브랜드</form:option>
											</form:select>
											<form:input path="searchText" id="searchText" cssClass="wd_270"/>
										</td>
									</tr>
								</tbody>
								</table>
							</div>
							<div class="paging">
								<div class="center">
									<a href="javascript:void(0);" id="btn_search" class="btnType2">검색</a>
									<a href="javascript:void(0);" id="btn_reset" class="btnType2">초기화</a>
								</div>
							</div>
						</div>
					</div>
					<!--[e] 상품목록 -->
					<!-- [s] 새상품 리스트 -->
					<div class="section a2"  style="width:700px;">
						<div class="tableTitle">
							<div class="left"><span class="icon2"></span>검색된 상품은 <span class="blue">${totalCnt }</span> 개 입니다.</div>					
							<div class="select2">								
								<form:select path="searchCount" onchange="javascript:doNumList();">
									<form:option value="">선택</form:option>
									<form:option value="10">10개 보기</form:option>
									<form:option value="30">30개 보기</form:option>
									<form:option value="50">50개 보기</form:option>
									<form:option value="100">100개 보기</form:option>
									<form:option value="200">200개 보기</form:option>
								</form:select>
							</div>
						</div>

						<div class="tableType1"  style="width:700px;">
							<table>
							<caption>회원목록 검색 결과 리스트</caption>
							<thead>
								<tr>
									<th><input type="checkbox" id="" name="" /></th>
									<th>썸네일</th>
									<th>브랜드</th>
									<th>[카테고리]<br />[브랜드]상품명[컬러]</th>
									<th>최초판매가</th>
									<th>현판매가</th>
									<th><span class="c_f00">재고</span></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
									<tr>
										<td><input type="checkbox" id="chkGoods" name="chkGoods" value="${goods.ubiGoods.ubiGdsNo }:${goods.ubiGoods.ubiGdsNm }:${goods.ubiGoods.ubiSlPrc }:${goods.ubiGoods.stock }:${goods.mainImg}"/></td>
										<td>
										<c:if test="${goods.mainImg == null}">
											<img src="<c:url value='/resources/common/images/noimages.png'/>" alt="상품이미지" class="prd_img" width="40px"/>
										</c:if>
										<c:if test="${goods.mainImg != null}">
											<img src="<c:url value='${uploadImage}${goods.mainImg}'/>" alt="상품이미지" class="prd_img" width="40px"/>
										</c:if>
											
										</td>
										<td class="p_line5">
											<p>${goods.ubiGoods.brand }</p>
										</td>
										<td class="p_line5 p_lineL">
											<p>${goods.ubiGoods.season } > ${goods.ubiGoods.category1 } > ${goods.ubiGoods.category2 }</p>
											<p>${goods.ubiGoods.ubiGdsNm }[${goods.ubiGoods.color }] ${goods.ubiGoods.ubiGdsSize }</p>
											<!-- <p class="btn"><img src="" alt="상품아이콘" /> <img src="" alt="무료배송" /> </p> -->
										</td>
										<td class="p_line5">
											<p><fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiCostPrc }" pattern="###,###" />원</p>
										</td>
										<td class="p_line5">
											<p><fmt:formatNumber type="currency" value="${goods.ubiGoods.ubiSlPrc }" pattern="###,###" />원</p>
										</td>
										<td class="p_line5">
											<p></p>
											<p>${goods.ubiGoods.stock }개</p>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					<!-- [e] 새상품 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						${pageHtml}
						
						<div class="right">
							<a href="javascript:void(0);" id="btn_addData" class="btnType2">선택완료</a>
						</div>						
					</div>
					<!--[e] 페이징 -->
					
				</div>
				</form:form>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->
	</div>
</body>
</html>