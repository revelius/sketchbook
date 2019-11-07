<%--
 * =============================================================================
 * 파일명 : /goods/goodsDisplay.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-05-08
 *
 * 파일 내용 : 상품관리 > 상품정렬순서
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
	<script type="text/javascript" src="<c:url value='/resources/common/__jquery.tablesorter/jquery.tablesorter.min.js'/>"></script>
	<script type="text/javascript">
	$(function() { 
		//리스트 검색 공통
	    $('#btn_search').click(function() {
	        var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = 'goodsDisplay';
	        frm.submit();
	    });		
		
		//검색 초기화 버튼
	    $('#btn_reset').click(function() {
            $(':input').each(function(index) {
            	if($(this.id)!="sortNo"){
            	}else if($(this).attr('type')=="text"){
            		$(this).val("");
            	}
            	
            	if($(this).attr('type')=="checkbox"){
            		$(this).attr("checked",false);
            	}
            });
            $('select').find('option:first').attr('selected', 'selected');
	    });		
		
		//저장
	    $('#btn_save').click(function() {
	        var frm = document.saveForm;
	        frm.target = '_self';
	        frm.action = 'saveGoodsDisplay';
	        frm.submit();
	    });		
		
		newArrivalCheck = function(param) {
			var ubiGdsNo = param.value;
			var newArvlChk = "N";
				if(param.checked == true){
					newArvlChk = "Y";
				}
			
			var siteNo = $('#brand').val();
			
			var formdata = {};
			formdata = "ubiGdsNo=" + ubiGdsNo + "&newArvlChk=" + newArvlChk + "&siteNo=" + siteNo;
			
			console.log(formdata);
			
			$.ajax({
		        url : "<c:url value='/admin/goods/newArrivalCheck'/>",
		        type: "post",
		        data : formdata,
		        success : function(responseData){
		        	try{
			            var data = jQuery.parseJSON(responseData);
			            console.log("data====" + data);
		        	}catch(e){
		        		alert(e);
		        	}
		        },
		        error:function(request,status,error){
		            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};
		
		
		dispYnChk = function(param) {
			if(param == true){
				$("#dispYn").val("Y");
			}else{
				$("#dispYn").val("N");
			}
		}
		
	});

    //페이지 init
    $(document).ready(function() {
		//드래그앤 드롭 테이블 초기화
		$( "#sortTable tbody" ).sortable({
        	placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
				for ( var i = 0; i < $("#sortTable tbody tr").size(); i++) {
					$("input#sortNo").eq(i).val(i+1);
				}
        	}
       	});
		
    	$( "#sortTable tbody" ).disableSelection();
    	
		$( "#sortTable2 thead tr" ).sortable({
        	placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
				for ( var i = 0; i < $("#sortTable2 thead tr th").size(); i++) {
					$("input#brandSortNo").eq(i).val(i+1+"0");
					
 					for ( var j = 0; j < $("td#"+$("input#brandSortNo").eq(i).attr('name')).size(); j++) {
// 						//moveRowUp($("tr#"+$("input#brandSortNo").eq(i).attr('name')));
// 						$("tr#"+$("input#brandSortNo").eq(i).attr('name')+" td input sortNo").val(parseInt(i+1+"000") + j);

						$("td#"+$("input#brandSortNo").eq(i).attr('name')).eq(j).html(i+1+"0");
 					}
				}
			$("#sortTable").tablesorter( {sortList: [[9,0]]} );
			
			for ( var i = 0; i < $("#sortTable tbody tr").size(); i++) {
				$("input#sortNo").eq(i).val(i+1);
			}			
        	}
		
       	});
		
		$( "#sortTable3 thead tr" ).sortable({
        	placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
				for ( var i = 0; i < $("#sortTable3 thead tr th").size(); i++) {
					$("input#cate2SortNo").eq(i).val(i+1+"00");
					
					
 					for ( var j = 0; j < $("td[name='"+$("input#cate2SortNo").eq(i).attr('name')+"']").size(); j++) {
// 						//moveRowUp($("tr#"+$("input#brandSortNo").eq(i).attr('name')));
// 						$("tr#"+$("input#brandSortNo").eq(i).attr('name')+" td input sortNo").val(parseInt(i+1+"000") + j);

						var cate2Name = $("input#cate2SortNo").eq(i).attr('name');
						
						if($("td[name='"+cate2Name+"']").eq(j).html().trim() == ""){
							$("td[name='"+cate2Name+"']").eq(j).html(parseInt(i+1) + "00");	
						}else{
							$("td[name='"+cate2Name+"']").eq(j).html(parseInt($("td[name='"+cate2Name+"']").eq(j).html()) + parseInt(i+1) + "00");	
						}
 						
 					}
				}
				$("#sortTable").tablesorter( {sortList: [[9,0]]} );
				
				for ( var i = 0; i < $("#sortTable tbody tr").size(); i++) {
					$("input#sortNo").eq(i).val(i+1);
				}				
        	}
       	});		
    	$( "#sortTable2 tbody" ).disableSelection();
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
						<jsp:param name="onChk" value="goodsDiplay"/>
					</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 상품목록 -->
					<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
					<form:hidden path="dispYn"/>
					<div class="section a1">
						<h3><span class="icon1"></span>상품진열설정</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 상품 진열순서를 설정하실 수 있습니다. </li>
								<li>- 순서를 변경하신 후에는 반드시 "저장"버튼을 누르셔야만 설정하신 순서가 실제 반영됩니다. </li>
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
											<form:select path="brand" onchange="$('#siteNo').val(this.value)">
												<form:options items="${siteList}" itemLabel="siteDesc" itemValue="siteNo"/>
											</form:select>
											&nbsp;													
											<form:select path="oneDepth">
												<form:option value="">시즌</form:option>
												<form:option value="OUTLET">OUTLET</form:option>
												<form:options items="${oneDepth}" itemLabel="cateNm" itemValue="cateCd"/>
											</form:select>
											<form:select path="twoDepth">
												<form:option value="">카테고리</form:option>
												<form:options items="${twoDepth}" itemLabel="cateNm" itemValue="cateCd"/>
											</form:select>
<%-- 									 		<form:select path="threeDepth"> --%>
<%-- 												<form:option value="">소 카테고리</form:option> --%>
<%-- 												<form:options items="${threeDepth}" itemLabel="cateNm" itemValue="cateCd"/> --%>
<%-- 											</form:select>							 --%>
											<form:select path="sex">
												<form:option value="">성별</form:option>
												<form:option value="M">MALE</form:option>
												<form:option value="W">WOMEN</form:option>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th>선택필터</th>
										<td>
											<span class="pr26"><form:checkbox path="dispYn2" label="미진열 상품 제외" onclick="dispYnChk(this.checked)"/></span>
											<span class="pr26"><form:checkbox path="soldoutYn" label="품절 상품 제외"/></span>
											<span class="pr26"><form:checkbox path="newArrival" label="newArrival"/></span>
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
					</form:form>
					<!--[e] 상품목록 -->
					
					<div class="section a2">
						<div class="tableType1">
							<table id="sortTable2">
							<thead>
								<tr>
								 	<c:forEach items="${brandList}" var="brand" varStatus="listCount">
										<th class="p_line5" id="${brand.ubiGoods.brandCode }">
											${brand.ubiGoods.brand }
											<p><input type="text" name="${brand.ubiGoods.brandCode }" id="brandSortNo" value="" style="width:40px;"></p>
										</th>
								 	</c:forEach>
								</tr>
							</thead>
							</table>
						</div>
					</div>			
					
<!-- 					<div class="section a2"> -->
<!-- 						<div class="tableType1"> -->
<!-- 							<table id="sortTable3"> -->
<!-- 							<thead> -->
<!-- 								<tr> -->
<%-- 								 	<c:forEach items="${threeDepth}" var="threeDepth" varStatus="listCount"> --%>
<%-- 										<th class="p_line5" id="${threeDepth.ubiGoods.category2Code }"> --%>
<%-- 											${threeDepth.ubiGoods.category2 } --%>
<%-- 											<p><input type="text" name="${threeDepth.ubiGoods.category2Code }" id="cate2SortNo" value="" style="width:40px;"></p> --%>
<!-- 										</th> -->
<%-- 								 	</c:forEach> --%>
<!-- 								</tr> -->
<!-- 							</thead> -->
<!-- 							</table> -->
<!-- 						</div> -->
<!-- 					</div>										 -->
					
	 					
					
					<!-- [s] 새상품 리스트 -->
					<form:form id="saveForm" name="saveForm" method="post" onsubmit="return check(form)">
					<input type="hidden" id="newArrivalChk" name="newArrivalChk" value="${param.newArrival }" style="width:40px;">
					<input type="hidden" id="siteNo" name="siteNo" value="${param.brand }" style="width:40px;">
					<div class="result_area">
<!-- 						<ul class="table_result"> -->
<!-- 							<li class="on"><a href="#">판매인기순</a> |</li>				 -->
<!-- 							<li><a href="#">신상품순</a> |</li> -->
<!-- 							<li><a href="#">낮은가격순</a></li> -->
<!-- 						</ul> -->
						</div>
					<div class="section a2">
						<div class="tableType1">
							<table id="sortTable">
							<caption>회원목록 검색 결과 리스트</caption>
<!-- 							<colgroup>
								<col width="8%" />
								<col width="10%" />
								<col width="10%" />
								<col width="29%" />
								<col width="8%" />
								<col width="8%" />
								<col width="6%" />
								<col width="6%" />
							</colgroup> -->
							<thead>
								<tr>
									<th>썸네일</th>
									<th>상품코드</th>
									<th>브랜드</th>
									<th>[카테고리]<br />[브랜드]상품명[컬러]</th>
									<th>최초판매가</th>
									<th>현판매가</th>
									<th><span class="c_f00">재고</span></th>
									<th>정렬</th>
									<th>new <br/> Arrival</th>
									<th>임시정렬</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${goodsList}" var="goods" varStatus="listCount">
									<tr>
										<td>
										<c:if test="${goods.mainImg == null}">
											<img src="<c:url value='/resources/common/images/noimages.png'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
										<c:if test="${goods.mainImg != null}">
											<img src="<c:url value='${uploadImage}${goods.mainImg}'/>" alt="상품이미지" class="prd_img" width="70px"/>
										</c:if>
											
										</td>
										<td class="p_line5">
											<p>${goods.ubiGoods.ubiGdsNo }</p>
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
										<td class="p_line5">
											<input type="hidden" id="ubiGdsNo" name="ubiGdsNo" value="${goods.ubiGoods.ubiGdsNo }" style="width:40px;">
											
											<c:if test="${param.newArrival == 'true'}">
												<input type="text" id="sortNo" name="sortNo" value="${goods.sortNo2 }" style="width:40px;">
											</c:if>
											<c:if test="${param.newArrival != 'true'}">
												<input type="text" id="sortNo" name="sortNo" value="${goods.sortNo }" style="width:40px;">
											</c:if>											
										</td>
										<td class="p_line5">
											<c:if test="${goods.newArvl eq 'Y'}">
												<input type="checkbox" id="newArrival" name="newArrival" value="${goods.ubiGoods.ubiGdsNo }" style="width:40px;" onchange="javascript:newArrivalCheck(this);" checked="checked">
											</c:if>
											<c:if test="${goods.newArvl eq 'N'}">
												<input type="checkbox" id="newArrival" name="newArrival" value="${goods.ubiGoods.ubiGdsNo }" style="width:40px;" onchange="javascript:newArrivalCheck(this);">
											</c:if>
										</td>
										<td class="p_line5" id="${goods.ubiGoods.brandCode }" name="${goods.ubiGoods.category2Code }">
										
										</td>			
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
					</div>
					</form:form>
					<!-- [e] 새상품 리스트 -->

					<!--[s] 페이징 -->
					<div class="paging">					
						<div class="right">
							<a href="javascript:void(0);" id="btn_save" class="btnType2">저장</a>
						</div>
					</div>
					<!--[e] 페이징 -->
				</div>
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