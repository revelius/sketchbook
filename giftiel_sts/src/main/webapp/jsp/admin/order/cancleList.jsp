<%--
 * =============================================================================
 * 파일명 : /order/cancleList.jsp
 * 작성자 : 박필종
 * 작성일자 : 2015-05-07
 *
 * 파일 내용 : 주문매출관리 > 취소관리 리스트
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
			
			if("${alert}" !=""){
				alert("${alert}");			
			}
			
			//리스트 검색 공통
		    $('#btn_search').click(function() {
		        var frm = document.schForm;
		        frm.target = '_self';
		        frm.action = "<c:url value='/admin/order/orderList'/>";
		        frm.submit();
		    });
			
			//검색 초기화 버튼
		    $('#btn_reset').click(function() {
		    	$("input[type='checkbox']").attr("checked", false);//checkbox초기화
		    	$("input[type='text']").val("");//textbox초기화
	            setSearchPeriod("set1");//달력 초기화
	            $("input[name='payWay']")[0].checked=true;//radio버튼 초기화
	            $('select').find('option:first').attr('selected', 'selected');//selectbox초기화
		    });		
			
			// datepicker 
			$( ".datepicker1, .datepicker2" ).datepicker({
				inline: true, 
				dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
				showOn: "both", 
				buttonImage: "${pageContext.request.contextPath}/resources/admin/images/common/icon_calender.gif", 
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
				$('#page').val(page);
		        $('#btn_search').trigger('click');
			}
			
			//결과 갯수 셋팅
			doNumList = function() {
				$('#btn_search').click();
			}
			
			//매장명 전체체크
		    $("#allCheckSite").on("click" ,function(){
				if($("#allCheckSite").is(":checked")) {
					$("input[name=siteNos]").prop("checked",true);
				} else {
					$("input[name=siteNos]").prop("checked",false);
				}
			});
			
		    //상품브랜드 전체체크
		    $("#allCheckBrand").on("click" ,function(){
				if($("#allCheckBrand").is(":checked")) {
					$("input[name=brands]").prop("checked",true);
				} else {
					$("input[name=brands]").prop("checked",false);
				}
			});
		 	
			//상품상세 이동
		    gotoOrderPopup = function(ordNo) {
		    	var popUrl = "<c:url value='/admin/order/popupOrder'/>";	//팝업창에 출력될 페이지 URL
				var param = "?ordNo="+ordNo;
				var popOption = "width=1300, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl+param,"",popOption);
		    };		
		    
		    /*★★★★★ 기간 검색조건 START ★★★★★*/
		    if($("#inqStrDtm").val() == ""){//default기간 셋팅
		    	setSearchPeriod("set1");
		    }
		    
		    //기간검색 이벤트 추가
		    $("a[href=#]").attr("href", "javascript:void(0);");
		    $('#set1').on('click', function(e){ setSearchPeriod("set1"); });
		    $('#set2').on('click', function(e){ setSearchPeriod("set2"); });
		    $('#set3').on('click', function(e){ setSearchPeriod("set3"); });
		    $('#set4').on('click', function(e){ setSearchPeriod("set4"); });
		    $('#set5').on('click', function(e){ setSearchPeriod("set5"); });
		    $('#set6').on('click', function(e){ setSearchPeriod("set6"); });
		    $('#set7').on('click', function(e){ setSearchPeriod("set7"); });
		    
		    //기간설정
		    function setSearchPeriod(pCode){
		    	var gubun = "";
		    	var period = 0;
		    	if(pCode=="set1"){
		    		gubun = "day";
		    	}else if(pCode=="set2"){
		    		gubun = "day";
		    		period = -1;
		    	}else if(pCode=="set3"){
		    		gubun = "thisMonth";
		    	}else if(pCode=="set4"){
		    		gubun = "day";
		    		period = -7;
		    	}else if(pCode=="set5"){
		    		gubun = "day";
		    		period = -15;
		    	}else if(pCode=="set6"){
		    		gubun = "month";
		    		period = -1;
		    	}else if(pCode=="set7"){
		    		gubun = "month";
		    		period = -2;
		    	}
		    	setdate(gubun,period);
		    }
		    
		    //기간 실행
		    function setdate(gubun,period){
		    	var today = new Date();
			    var start_month = (today.getMonth() + 1);
			    var start_day = today.getDate();
				    start_month = (start_month < 10) ? "0"+start_month : start_month;
				    start_day = (start_day < 10) ? "0"+start_day : start_day;
			    var start_date = today.getFullYear() + "-" + start_month + "-" + start_day;
		    	
			    if(gubun == 'day'){
		    		today.setDate(today.getDate()+period);
		    	}else if(gubun == 'month'){
		    		today.setMonth(today.getMonth()+period);
		    	}else if(gubun == 'thisMonth'){
		    		today.setDate(1);
		    	}
			    	
			    var end_month = (today.getMonth() + 1);
			    var end_day = today.getDate();
				    end_month = (end_month < 10) ? "0"+end_month : end_month;
				    end_day = (end_day < 10) ? "0"+end_day : end_day;
			    var end_date = today.getFullYear() + "-" + end_month + "-" + end_day;
				    $("#inqStrDtm").val(end_date);
				    $("#inqEndDtm").val(start_date);
		    }
		    /*★★★★★ 기간 검색조건 END ★★★★★*/
		    
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
		  
		    $('#orderTable').rowspan(2);
		    
		  //엑셀 다운로드
		    $('#btn_excel').click(function() {
		    	$("#excel").val("true");
		    	$('#btn_search').click();
		    	$("#excel").val("false");
		    });	
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
					<jsp:param name="menuFlag" value="order"/>
					<jsp:param name="onChk" value="cancleList"/>
				</jsp:include>
				<!--[e] lnb -->
				
				<!--[s] contents -->
				<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
					<form:hidden path="page"/>
					<form:hidden path="ordKnd"/>
					<form:hidden path="excel" id="excel"/>
					<form:hidden path="orderBy" id="orderBy"/>
					<form:hidden path="orderFlag" id="orderFlag"/>
					<div class="contents">
						<!--[s] 검색목록 -->
						<div class="section a1">
							<h3><span class="icon1"></span>취소관리</h3>						
							<div class="tableType2">
								<p class="boxP">
									주문 취소한 내역을 보여주는 곳입니다. <br />
									결제대기 중이거나 결제 완료/배송준비/출고지연된 상품에 대해서 고객이 주문취소한 경우 환불처리한다. <br />
									이미 배송중인 상품은 취소 할 수 없음
								</p>
								<!-- [s] 검색조건 -->
								<table>
									<caption>취소관리</caption>
									<colgroup>
										<col width="56px" />
										<col width="132px" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th><input type="checkbox" id="allCheckSite" name="allCheckSite" /></th>
											<th>매장명</th>
											<td>
												<c:forEach items="${siteList}" var="site" varStatus="siteCount">
													
													<form:checkbox path="siteNos" value="${site.siteNo}"/><label for="siteNo${siteCount.count}">${site.siteNm}</label>
													<c:if test="${siteCount.count%8 == 0}"><br /></c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" id="" name="" disabled="disabled"/></th>
											<th>결제수단</th>
											<td>
												<div class="wrap">
													<form:radiobutton path="payWay" value="" checked="checked" /><label for="payWay1">전체</label>
													<c:forEach items="${payWayList}" var="payWay" varStatus="payWayCount">
														<form:radiobutton path="payWay" value="${payWay.cdNo}"/><label for="payWay${payWayCount.count+1}">${payWay.cdNm}</label>
													</c:forEach>
												</div>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" id="" name="" disabled="disabled" /></th>
											<th>기간</th>
											<td >
												<a href="#" id="set1" class="btnType1">당일</a>
												<a href="#" id="set2" class="btnType1">전일</a>
												<a href="#" id="set3" class="btnType1">당월</a>
												<a href="#" id="set4" class="btnType1">1주</a>
												<a href="#" id="set5" class="btnType1">15일</a>
												<a href="#" id="set6" class="btnType1">한달</a>
												<a href="#" id="set7" class="btnType1">두달</a>
												<div class="wrap">
													<span class="dateinput"><form:input path="inqStrDtm" id="inqStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
													<span class="dateinput"><form:input path="inqEndDtm" id="inqEndDtm" readonly="true" cssClass="datepicker2"/></span>									
												</div>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" id="allCheckBrand" name="allCheckBrand" /></th>
											<th>상품브랜드</th>
											<td>
												<c:forEach items="${brandList}" var="brand" varStatus="brandCount">
													<form:checkbox path="brands" value="${brand.cdNo}"/><label for="brand${brandCount.count}">${brand.cdNm}</label>
													<c:if test="${brandCount.count%8 == 0}"><br /></c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" id="" name="" disabled="disabled"/></th>
											<th>판매가</th>
											<td><form:input path="ubiSlStrPrc" id="ubiSlStrPrc"/> &nbsp;원 ~ <form:input path="ubiSlEndPrc" id="ubiSlEndPrc"/> &nbsp;원 </td>
										</tr>
										<tr>
											<th><input type="checkbox" id="" name="" disabled="disabled"/></th>
											<th>카테고리</th>
											<td>
												<form:select path="categoryGb">
													<form:option value="CATEGORY1코드">카테고리코드</form:option>
													<form:option value="CATEGORY1">카테고리명</form:option>
												</form:select>
												<form:input path="categoryText" cssClass="categoryText"/>
												<p class="c_f00 pt_14">카테고리 코드 / 명 : UBI 기준 카테고리 코드(숫자)와 카테고리 명으로 중복 검색가능합니다.<br>Ex) 20, 15, 30 / cap, pants, shirt</p>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" id="" name="" disabled="disabled"/></th>
											<th>직접검색</th>
											<td>
												<form:select path="searchGb">
<%-- 													<form:option value="">검색구분</form:option> --%>
													<form:option value="ORDR_NM">주문자명</form:option>
													<form:option value="ORDR_EMAIL">이메일</form:option>
													<form:option value="UBI_GDS_NM">상품명</form:option>
													<form:option value="ORD_NO">주문번호</form:option>
													<form:option value="UBI_GDS_NO">상품코드</form:option>
													<form:option value="ORDR_CP">핸드폰번호</form:option>		
													<form:option value="MEM_NM">회원명</form:option>										
												</form:select>
												<form:input path="searchText" cssClass="wd_270"/>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- [e] 검색조건 -->
							</div>
							<div class="btn">
								<a href="javascript:void(0);" id="btn_search" class="btnType2">검색</a>
								<a href="javascript:void(0);" id="btn_reset" class="btnType2">초기화</a>
							</div>
							
							<!--[s] 검색결과리스트 -->
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
									<table id="orderTable">
										<caption>주문목록 검색 결과 리스트</caption>
										<colgroup>
											<col width="8%" />
											<col width="8%" />
											<col width="10%" />
											<col width="*" />
											<col width="8%" />
											<col width="8%" />
											<col width="5%" />
											<col width="5%" />
											<col width="7%" />
											<col width="7%" />
										</colgroup>
										<thead>
											<tr id="sortTr">
												<th>개별진행<br/>상태</th>
												<th>매장명<a id="SITE_NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>주문번호<a id="ORD_NO" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>상품</th>
												<th>주문일시<a id="ORD_DTS" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>판매가<a id="SL_PRC" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>수량<a id="ORD_QTY" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>E-mail계정<a id="ORDR_EMAIL" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>이름<a id="ORDR_NM" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
												<th>상품바코드<a id="BARCODE" href="#" onclick="javascript:setOrderBy(this);" class="down">▼</a></th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${not empty orderList}">
													<c:forEach items="${orderList}" var="order" varStatus="listCount">
														<tr>
															<td>${order.perOrdStatNm}<%-- <br />(${order.ordStatNm}) --%></td>
															<td>${order.siteNm}</td>
															<td onclick="javascript:gotoOrderPopup('${order.ordNo }')" style="cursor:pointer">${order.ordNo}</td>
															<td>[${order.brand}]${order.ubiGdsNm}/${order.ubiGdsColorNm}/${order.ubiGdsSize}</td>
															<td><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd HH:mm:SS" /></td>
															<td><fmt:formatNumber type="currency" value="${order.slPrc}" pattern="###,###" />원</td>
															<td>${order.ordQty}개</td>
															<td>${order.ordrEmail}</td>
															<td>${order.ordrNm}</td>
															<td>${order.barcode }</td> 
														</tr>
													</c:forEach>	
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="10">
															조회할 항목이 없습니다.
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
							<!--[s] 페이징 -->
						
							<div class="paging">
								<c:choose>
									<c:when test="${not empty orderList}">
									${pageHtml}
									<div class="right">
										<a href="#" class="btnType2" id="btn_excel">엑셀출력</a>
									</div>
									</c:when>
								</c:choose>
							</div>
							
							<!--[e] 페이징 -->
						</div>
						<!--[e] 검색결과리스트 -->
					</div>
					<!--[e] contents -->
				</form:form>
			</div>
		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>