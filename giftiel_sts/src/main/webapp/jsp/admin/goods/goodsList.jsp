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
	        frm.action = 'goodsList';
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
		}
		
		//결과 갯수 셋팅
		doNumList = function() {
			$('#btn_search').click();
		}
		
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
		
		//상품상세 이동
	    gotoGoodsDetail = function(ubiGdsNo, ubiGdsSize) {
	    	$(location).attr('href','/admin/goods/goodsDetail?ubiGdsNo='+ubiGdsNo+'&ubiGdsSize='+ubiGdsSize);
	    };
	    
	    $('#goodsTable').rowspan(2);
    });
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
			<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
					<jsp:include page="/jsp/admin/include/leftMenu.jsp">
						<jsp:param name="menuFlag" value="goods"/>
						<jsp:param name="onChk" value="goodsList"/>
					</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
				<div class="contents productList">
					<form:hidden path="excel" id="excel"/>
					<form:hidden path="page" id="page"/>
					<form:hidden path="orderBy" id="orderBy"/>
					<form:hidden path="orderFlag" id="orderFlag"/>				
					<!--[s] 상품목록 -->
					<div class="section a1">
						<h3><span class="icon1"></span>상품목록</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 등록하신 상품들을 수정/관리 하실 수 있습니다.</li>
								<li>- [상품진열]버튼을 클릭하시면 상품을 숨길 수 있으며 [진열안함]버튼을 클릭하시면 상품을 전시하실 수 있습니다.</li>
							</ul>
							<div class="tableType2">
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
											<form:select path="brand">
												<form:option value="">브랜드 선택</form:option>
												<form:options items="${siteList}" itemLabel="siteDesc" itemValue="siteDesc"/>
											</form:select>										
											&nbsp;&nbsp;
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
										<th>기능체크</th>
										<td>
<%-- 											<form:checkbox path="stockZeroChk" label="재고수량유무"/> --%>
<%-- 											<form:checkbox path="imageUploadChk" label="이미지업로드유무"/> --%>
											
											<form:select path="stockZeroGubun">
												<form:option value="">재고전체</form:option>
												<form:option value="Y">재고수량있음</form:option>
												<form:option value="N">재고수량없음</form:option>
											</form:select>
											
											<form:select path="imageUploadGubun">
												<form:option value="">이미지업로드전체</form:option>
												<form:option value="Y">이미지업로드있음</form:option>
												<form:option value="N">이미지업로드없음</form:option>
											</form:select>
											
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
									<!-- <a href="javascript:goodsPopup();" id="goodsPopup" class="btnType2">테스트팝업</a> -->
									<script>
									goodsPopup = function() {
										var resultId = "tempGoods";
										var popUrl = "<c:url value='/admin/popup/goods/popupGoodsList'/>?resultId="+resultId;	//팝업창에 출력될 페이지 URL
										var popOption = "width=800, height=730, resizable=no, scrollbars=yes, status=no;";    //팝업창 옵션(optoin)
											window.open(popUrl,"",popOption);
									};
									</script>
									
									<input type="text" id="tempGoods">
								</div>
							</div>
						</div>
					</div>
					<!--[e] 상품목록 -->
					<!-- [s] 새상품 리스트 -->
					<div class="section a2">
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

						<div class="tableType1">
							<table id="goodsTable">
							<caption>회원목록 검색 결과 리스트</caption>
							<colgroup>
								<col width="3%" />
								<col width="8%" />
								<col width="10%" />
								<col width="10%" />
								<col width="31%" />
								<col width="8%" />
								<col width="8%" />
								<col width="6%" />
								<col width="6%" />
							</colgroup>
							<thead>
								<tr id="sortTr">
									<th><input type="checkbox" id="" name="" /></th>
									<th>썸네일</th>
									<th>상품코드<a id="UBI_GDS_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>브랜드<a id="BRAND" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>[카테고리]<br />[브랜드]상품명[컬러]</th>
									<th>최초판매가<a id="UBI_COST_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th>현판매가<a id="UBI_SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
									<th><span class="c_f00">재고<a id="STOCK" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></span></th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty goodsList}">
								<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
									<tr>
										<td><input type="checkbox" id="" name="" /></td>
										<td>
										<c:if test="${goods.mainImg == null}">
											<img src="<c:url value='/resources/common/images/noimages.png'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
										<c:if test="${goods.mainImg != null}">
											<img src="<c:url value='${uploadImage}${goods.mainImg}'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
											
										</td>
										<td class="p_line5" onclick="javascript:gotoGoodsDetail('${goods.ubiGoods.ubiGdsNo }','${goods.ubiGoods.ubiGdsSize }')" style="cursor:pointer">
											<p>${goods.ubiGoods.ubiGdsNo }</p>
										</td>
										<td class="p_line5">
											<p>${goods.ubiGoods.brand }</p>
										</td>
										<td class="p_line5 p_lineL">
											<c:if test="${goods.ubiGoods.category2 == 'NO CATEGORY' }">
											<p>${goods.ubiGoods.category2 }</p>
											</c:if>
											<c:if test="${goods.ubiGoods.category2 != 'NO CATEGORY' }">
											<p>${goods.ubiGoods.season } > ${goods.ubiGoods.category1 } > ${goods.ubiGoods.category2 }</p>
											</c:if>
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
											<p>${goods.ubiGoods.stock } 개</p>
										</td>
										<td class="p_line5">										
											<p>${goods.viewCnt==null?0:goods.viewCnt } 회</p>
										</td>
									</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty goodsList}">
									<tr>
										<td colspan="9">조회된 데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>
					</div>
					<!-- [e] 새상품 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">
						${pageHtml}
						<div class="right">
							<a href="javascript:void(0);" class="btnType2" id="btn_excel">엑셀출력</a>
						</div>
					</div>
					<!--[e] 페이징 -->
					
				</div>
				</form:form>
				<!--[e] contents -->
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

	</div>
</body>
</html>