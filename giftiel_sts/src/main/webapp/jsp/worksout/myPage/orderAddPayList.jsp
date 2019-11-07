<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderAddPayList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-13
 *
 * 파일 내용 : 추가 결재 리스트
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		
		<script type="text/javascript" src="<c:url value='/resources/worksout/js/jquery-ui.min.js'/>"></script>
		
		<link rel="stylesheet" href="<c:url value='/resources/worksout/css/jquery-ui.css'/>" type="text/css" />
		<link rel="stylesheet" href="<c:url value='/resources/worksout/css/contents.css'/>" type="text/css" />
		
		<script type="text/javascript">
    		$(function() { 
    			
    			//리스트 검색
    		    $('#btn_search').click(function() {
    				$("#page").val("1");
    		    	goSubmit();
    		    });
    			
    			//페이징 처리
    		    paging = function(page) {
    		        //var frm = document.schForm;
    		        document.getElementById("page").value = page;
    		        goSubmit();
    		    };	
    		    
    		    
    		  	//검색
    		    goSubmit = function(){
   			        var frm = document.searchForm;
   						frm.action = "<c:url value='/front/myPage/orderAddPayList'/>";
			 	        frm.submit();
    		    };
    		    
    		    
    		    
    		    
    		 	// datepicker 
    			$( ".datepicker1, .datepicker2" ).datepicker({
    				inline: true, 
    				dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
    				showOn: "both", 
    				buttonImage: "<c:url value='/resources/admin/images/common/icon_calender.gif'/>",
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
    		    
    		    
    		    
    		    //datepicker 위치조절
    		    $("img.ui-datepicker-trigger").attr("style", "margin-left:2px; vertical-align:middle; cursor: Pointer;");
    		    
    		    
    		    
    		    
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
    		    	}else if(gubun == 'year'){
    		    		today.setYear(today.getFullYear()+period);
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
    				    
    				    goSubmit();
    		    }
    		    
    		    function setSearchPeriod(pCode){
    		    	var gubun = "";
    		    	var period = 0;
    		    	if(pCode=="set1"){
    		    		gubun = "month";
    		    		period = -3;
    		    	}else if(pCode=="set2"){
    		    		gubun = "month";
    		    		period = -6;
    		    	}else if(pCode=="set3"){
    		    		gubun = "year";
    		    		period = -1;
    		    	}else if(pCode=="set4"){
    		    		gubun = "year";
    		    		period = -2;
    		    	}
    		    	setdate(gubun,period);
    		    }
    		    
    		    $("a[href=#]").attr("href", "javascript:void(0);");
    		    
    		    $('#set1').on('click', function(e){ setSearchPeriod("set1");  $target = $(e); $target.attr("class" , "on");});
    		    $('#set2').on('click', function(e){ setSearchPeriod("set2");  $target = $(e); $target.attr("class" , "on");});
    		    $('#set3').on('click', function(e){ setSearchPeriod("set3");  $target = $(e); $target.attr("class" , "on");});
    		    $('#set4').on('click', function(e){ setSearchPeriod("set4");  $target = $(e); $target.attr("class" , "on");});
    		    
    		    
    		    
    		    
    		    
    		    //상세 이동
    		    $("a[data-orderNo]").on("click",function(e){
    		    	e.preventDefault();
    		    	var $target = $(e.currentTarget);
    		    	
    		    	var frm = document.hiddenForm;
   		    		frm.hiddenOrderNo.value = $target.attr("data-orderNo");
					frm.action = "<c:url value='/front/myPage/orderAddPayDetail'/>";
	 	        	frm.submit();
    	    	
    	   		});
    		    
    		    
    		    
    		    
    		    //date 형변환 함수/////////////////////////////////////////////////////////////////////
    		    Date.prototype.format = function(f) {
    		        if (!this.valueOf()) return " ";
    		     
    		        var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    		        var d = this;
    		         
    		        return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
    		            switch ($1) {
    		                case "yyyy": return d.getFullYear();
    		                case "yy": return (d.getFullYear() % 1000).zf(2);
    		                case "MM": return (d.getMonth() + 1).zf(2);
    		                case "dd": return d.getDate().zf(2);
    		                case "E": return weekName[d.getDay()];
    		                case "HH": return d.getHours().zf(2);
    		                case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
    		                case "mm": return d.getMinutes().zf(2);
    		                case "ss": return d.getSeconds().zf(2);
    		                case "a/p": return d.getHours() < 12 ? "오전" : "오후";
    		                default: return $1;
    		            }
    		        });
    		    };
    		     
    		    String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
    		    String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
    		    Number.prototype.zf = function(len){return this.toString().zf(len);};
    		    ///////////////////////////////////////////////////////////////////////
    		    
    		    
    		    
    		    //load more
    			var isLoading = false;
    			loadMore = function() {
    				if (isLoading) {
    					alert('처리중');
    					return;
    				}
    				isLoading = true;
    				
    				$.ajax({
    			        url : "<c:url value='/front/myPage/orderAddPayListAjax'/>",
    			        type: "post",
    			        data : $('#searchForm').serialize(),
    			        async: true,
    			        success : function(responseData){
    			        	try{
    			        		
    			        		var data = jQuery.parseJSON(responseData);
    			        		
    			        		if (data.length > 0) {
    			        			var list = $('#list');
    			        			for(var i=0;i<data.length;i++) {
    			        				
    			        				
    			        				var ordDts = new Date(data[i].ordDts).format("yyyy-MM-dd");
    			        				var btnArea = "";
    			        				if( data[i].perOrdStat == "OR00505"){//배송완료
    			        					btnArea += "<a href=\"#\" class=\"btn_in_table\" id=\"btn_bring back\">반품</a>";
    			        					btnArea += "<a href=\"#\" class=\"btn_in_table\" id=\"btn_exchange\">교환</a>";
    			        				}else if( data[i].perOrdStat == "OR00504"){//배송중
    			        					btnArea += "<a href=\"#\" class=\"btn_in_table\" id=\"btn_cancel_order\">주문취소</a>";
    			        				}else if( data[i].perOrdStat == "OR00501"){//결재대기
    			        					btnArea += "<a href=\"#\" class=\"btn_in_table\" id=\"btn_cancel_order\">주문취소</a>";
    			        				}
    			        				
    			        				var html = 
    										
    										
    										"<tr>" +
    										"	<td class=\"tbl_layout02\">" +
    										"		<div class=\"mobile_th\">매장명</div>" +
    										"		<div class=\"tbl_cont\">" + data[i].siteNm +"</div>" +
    										"	</td>" +
    										"	<td class=\"tbl_layout03\">" +
    										"		<div class=\"mobile_th\">주문번호</div>" +
    										"		<div class=\"tbl_cont\">" +
    										"			<a href=\"#\" class=\"btn_order\" data-orderNo=\"" + data[i].ordNo +"\">" + data[i].ordNo +"</a>" +
    										"		</div>" +
    										"	</td>" +
    										"	<td class=\"tbl_layout04\">" +
    										"		<div class=\"mobile_th\">상품</div>" +
    										"		<div class=\"tbl_cont\">" +
    										"			<div class=\"p_tit\">[" + data[i].brand +"] " + data[i].ubiGdsNm +"</div>" +
    										"			<div class=\"info\">Color = " + data[i].ubiGdsColorNm +" / Size = " + data[i].ubiGdsSize +"</div>" +
    										"		</div>" +
    										"	</td>" +
    										"	<td class=\"tbl_layout05\">" +
    										"		<div class=\"mobile_th\">주문일시</div>" +
    										"		<div class=\"tbl_cont\">"+ordDts+"<p></div>" +
    										"	</td>" +
    										"	<td class=\"tbl_layout06\">" +
    										"		<div class=\"mobile_th\">가격</div>" +
    										"		<div class=\"tbl_cont\">" +
    										"			<span class=\"ico_price\">" + data[i].slPrc +"</span>" +
    										"		</div>" +
    										"	</td>" +
    										"	<td class=\"tbl_layout07\">" +
    										"		<div class=\"mobile_th\">상태</div>" +
    										"		<div class=\"tbl_cont clfix\">" +
    										"			<span class=\"state\">" + data[i].perOrdStatNm +"</span>" +
    										"			<span class=\"btn_state\">" +
    										btnArea +
    										"		</div>" +
    										"	</td>" +
    										"</tr>";
    										
    										
										list.append(html);
    			        			}
    			        			var currentPage = Number($('#page').val()) + 1;
    				        		$('#page').val(currentPage);
    			        		} else {
    			        			alert("리스트 끝");
    			        		}
    			        	}catch(e){
    			        		alert(e);
    			        	}
    			        },
    			        error:function(request,status,error){
    			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
    			        },
    			        complete:function(request,status){
    			        	isLoading = false;
    			        }
    			    });
    			};
    		});
    		
			//주문데이터 init, pg호출
		    function orderAddPay(ordNo){
				
				var payWay = $("#payway_"+ordNo+":checked").val();
				if($("#payway_"+ordNo+":checked").val() == undefined){
					alert("결제수단을 선택해 주세요");	
					return false;
				}else{
					$("input#payway").val(payWay);
				}
				
		    	<c:if test="${isMobile}">
		    		$("#orderForm").attr("target", "_self");
		    		$("#orderForm").attr("action", "/front/order/orderPayAdd2");
		    	</c:if>
		    	<c:if test="${!isMobile}">
		    		$("#orderForm").attr("target", "order_pay");
		    		$("#orderForm").attr("action", "/front/order/orderPayAdd");
		    	</c:if>
		    	
		    	$("input#ordNo").val(ordNo);
		    	
		    	$("#orderForm").submit(function(){
		    		$("#order_pay").load(function() {
	                	 console.log(this);
	                });
	            }).submit();
			}    		
			
			
			
			function goDetail(orderNo){
				document.hiddenForm.hiddenOrderNo.value = orderNo;
				document.hiddenForm.action = "<c:url value='/front/myPage/orderAddPayDetail'/>";
				document.hiddenForm.submit();
			}
			
			
			
   		</script>
		
		
	</head>
	<body>
		<form id="hiddenForm" name="hiddenForm" method="post" >
			<input type="hidden" name="hiddenOrderNo"  id="hiddenOrderNo"  value=""/>
		</form>
		<form:form id="orderForm" name="orderForm" method="post">
			<input type="hidden" id="ordNo" name="ordNo">
			<input type="hidden" id="payway" name="payway">
		</form:form>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap">
			<h2 class="hide_txt">주요 메뉴 영역</h2>
			<div id="header">
				<!-- header include -->
				<!-- header include -->
			</div>
			<h2 class="hide_txt">본문 영역</h2>
			<div id="container">
				<div id="content">
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">ORDER LIST</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_mypage_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="mypage_area">
									<div class="mypage_tit clfix">
										<span class="txt01">추가결제 내역</span>
									</div>
									
									<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm" onsubmit="">
			        					<form:hidden path="page" id="page"/>
										<div class="mypage_search_box">
											<ul class="search_box01 clfix">
												<li>
													<a href="#" id="set1">3개월</a>
												</li>
												<li>
													<a href="#" id="set2">6개월</a>
												</li>
												<li>
													<a href="#" id="set3">1년</a>
												</li>
												<li>
													<a href="#" id="set4">2년</a>
												</li>
											</ul>
											<div class="search_box02 clfix">
												<div class="search_select_area">
													<div class="calendar_input">
														<span class="input_txt">
															<form:input path="inqStrDtm" id="inqStrDtm" name="inqStrDtm" readonly="true" cssClass="datepicker1"/>
														</span>
													</div>
												</div>
												<div class="bu">~</div>
												<div class="search_select_area">
													<div class="calendar_input">
														<span class="input_txt">
															<form:input path="inqEndDtm" id="inqEndDtm" name="inqEndDtm" readonly="true" cssClass="datepicker2"/>
														</span>
													</div>
												</div>
												<div class="search_submit_area">
													<a href="#" id="btn_search" class="btn_black01">조회하기</a>
												</div>
											</div>
										</div>
									</form:form>
									
									
									
									<p class="mypage_txt_style02">- 주문번호를 누르시면 상세페이지로 이동됩니다.</p>
									<table class="tbl_col02 tbl_col02_mypage_order_list ui_reponsible_table_type01" id="orderTable">
										<caption>추가결제 내역 리스트 테이블로 구분, 주문번호, 결제수단, 결제일, 결제금액, 상태 에 대해 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">구분</th>
												<th scope="col">주문번호</th>
												<th scope="col">결제수단</th>
												<th scope="col">결제일</th>
												<th scope="col">결제금액</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody id="list">
										
											<c:choose>
												<c:when test="${not empty orderAddPayList}">
													<c:forEach var="orderAddPay" items="${orderAddPayList}" varStatus="orderIndex">
														<tr>
															<td class="tbl_layout09 tbl_first_child">
																<div class="mobile_th">구분</div>
																<div class="tbl_cont">${orderAddPay.addPayRsn}</div>
															</td>
															<td class="tbl_layout09">
																<div class="mobile_th">주문번호</div>
																<div class="tbl_cont">
																	<a href="javascript:goDetail('${orderAddPay.ordNo}');" class="btn_order">${orderAddPay.ordNo}</a>
																</div>
															</td>
															<td class="tbl_layout09">
																<div class="mobile_th">결제수단</div>
																<div class="tbl_cont">
																	<c:if test="${orderAddPay.payWay eq 'OR00801'}">신용카드</c:if>
																	<c:if test="${orderAddPay.payWay eq 'OR00802'}">실시간계좌이체</c:if>
 																<c:if test="${orderAddPay.payWay == null}">
 																	<input type="radio" id="payway_${orderAddPay.ordNo}" name="payWay" value="OR00801">신용카드<br/>
 																	<input type="radio" id="payway_${orderAddPay.ordNo}" name="payWay" value="OR00802">계좌이체<br/>
 																</c:if>
																</div>
															</td>
															<td class="tbl_layout09">
																<div class="mobile_th">결제일</div>
																<div class="tbl_cont"><fmt:formatDate value="${orderAddPay.payDts}" pattern="yyyy-MM-dd HH:mm"/></div>
															</td>
															<td class="tbl_layout09">
																<div class="mobile_th">결제금액</div>
																<div class="tbl_cont clfix"><fmt:formatNumber type="currency" value="${orderAddPay.addPayAmt }" pattern="###,###" /></div>
															</td>
															<td class="tbl_layout09">
																<div class="mobile_th">상태</div>
																<div class="tbl_cont">
																<c:if test="${orderAddPay.payStatNm == null}">
																	결제대기<br/>
																	<a href="#" onclick="javascript:orderAddPay('${orderAddPay.ordNo}')" class="btn_in_table" id="orderPay">결제하기</a>
																</c:if>
																	${orderAddPay.payStatNm}
																</div>
															</td>
														</tr>
														</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="7" class="no_content">
															<img src="/html/worksout/images/common/img_no_order_add_pay_list.gif" alt="추가결제 내역이 없습니다.">
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
											
										</tbody>
									</table>

									<!-- a태그에 on 붙으면 활성화 됨. -->
									<!-- 처음, 이전, 끝, 다음으로는 활성화 없음 -->
									<!-- 웹에서는 페이징 모바일에서는 아래 더보기 버튼 사용 -->
									<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
									<div class="pagenavi_loadmoer_select_ctr">
										<div class="pagenavi space01">
											<!--[s] 페이징 -->
											<div class="paging">
											<c:choose>
												<c:when test="${not empty orderAddPayList}">
												${pageHtml}
												</c:when>
											</c:choose>
											</div>
											<!--[e] 페이징 -->
										</div>
										<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
										<!-- 모바일에서는 아래 더보기 버튼 사용.  -->
										<div class="btn_area">
											<a href="javascript:loadMore();">
												<img src="/html/worksout/images/common/btn_loadmore.png" alt="LOAD MORE">
											</a>
										</div>
									</div>
<!-- 									<div class="mypage_tit clfix space01"> -->
<!-- 										<span class="txt01">주문/배송 절차안내</span> -->
<!-- 										<span class="link01"> -->
<!-- 											<a href="#" class="btn_mobile_active01 ui_expand_btn_mypage"></a> -->
<!-- 										</span> -->
<!-- 									</div> -->
<!-- 									<div class="mypage_step_info ui_expand_body_mypage"> -->
<!-- 										<div class="web_step"> -->
<!-- 											<img src="/html/worksout/images/common/txt_step01.gif" alt="주문/배송 절차안내"> -->
<!-- 										</div> -->
<!-- 										<div class="mobile_step"> -->
<!-- 											<img src="/html/worksout/images/common/txt_m_step01.gif" alt="주문/배송 절차안내"> -->
<!-- 										</div> -->
<!-- 										<p class="hide_txt">STEP1 결제대기 결제이전의 입금확인중인 상태입니다. 24시간 내 주문취소가 가능하며, 24시간 내 미입금 시 자동취소 됩니다.</p> -->
<!-- 										<p -->
<!-- 										class="hide_txt">STEP2 결제완료 결제가 확인된 상태이며 24시간 내 결제취소가 가능합니다.</p> -->
<!-- 											<p class="hide_txt">STEP3 배송준비 주문한 상품의 배송을 준비하는 과정입니다. * 출고지연 배송준비가 길어지거나 품절상태로 인해 배송이 지연되는 -->
<!-- 												상태입니다.</p> -->
<!-- 											<p class="hide_txt">STEP4 배송중 상품이 배송되어 배송중 인 상태입니다.</p> -->
<!-- 											<p class="hide_txt">STEP5 배송완료 상품이 전달되어 배송이 완료된 상태이며, 7일 내 교환/반품신청이 가능합니다. 배송완료 3일 후 포인트가 -->
<!-- 												적립됩니다. -->
<!-- 											</p> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			<iframe id="order_pay" name="order_pay" style="display:none">
			
			</iframe>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>