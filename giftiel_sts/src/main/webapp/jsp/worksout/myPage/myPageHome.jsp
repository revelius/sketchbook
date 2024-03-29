<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입 정보입력
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
		<script type="text/javascript">
    		$(function() { 
    			var mydlvAddrList = ${mydlvAddrListJson};	
    			
    			
    			//우체국 배송조회
   			 	$(document).on("click","a[data-btn='btn_delivery']",function(e){
	   				e.preventDefault();
	   				var $target = $(e.currentTarget);
	   				var invNo = $target.attr("data-invNo");
	    			openDlvPop(invNo);
    		    });
    			
				//배송지 선택
				selectDlv = function(index){
					$("div[data-area='nm']").text(mydlvAddrList[index].nm);
					$("div[data-area='tel']").text(mydlvAddrList[index].tel);
					$("div[data-area='cpNo']").text(mydlvAddrList[index].cpNo);
					$("div[data-area='addr']").text(mydlvAddrList[index].bsAddr +" "+mydlvAddrList[index].dtlAddr);
				}
				
				for(var i=0;i<mydlvAddrList.length;i++){
					if(mydlvAddrList[i].baseValYn=="Y"){
						selectDlv(i);
					};
				};
				
				
    		    
    		    
    		    //주문/배송상세 이동
    		    $(document).on("click","a[data-orderNo]",function(e){
    		    	e.preventDefault();
    		    	var $target = $(e.currentTarget);
    		    	
    		    	var frm = document.hiddenForm;
   		    		frm.orderNo.value = $target.attr("data-orderNo");
					frm.action = "<c:url value='/front/myPage/orderDetail'/>";
	 	        	frm.submit();
    	    	
    	   		});
    		    
    		  	//취소/반품/교환 상세 이동
    		    $(document).on("click","a[data-ordGdsSeq]",function(e){
    		    	e.preventDefault();
    		    	var $target = $(e.currentTarget);
    		    	
    		    	var frm = document.hiddenForm;
   		    		frm.hiddenOrderNo.value = $target.attr("data-orderNo");
   		    		frm.hiddenOrdGdsSeq.value = $target.attr("data-ordGdsSeq");
   		    		var action = $target.attr("data-action");
					frm.action = "<c:url value='/front/myPage/"+action+"'/>";
	 	        	frm.submit();
    	    	
    	   		});
    		  	
    		  	
    		  	//교환 상세 이동
//     		    $(document).on("click","a[data-ordGdsSeq]",function(e){
//     		    	e.preventDefault();
//     		    	var $target = $(e.currentTarget);
    		    	
//     		    	var frm = document.hiddenForm;
//    		    		frm.hiddenOrderNo.value = $target.attr("data-orderNo");
//    		    		frm.hiddenOrdGdsSeq.value = $target.attr("data-ordGdsSeq");
//    		    		frm.action = "<c:url value='/front/myPage/orderChangeDetail'/>";
// 	 	        	frm.submit();
    	    	
//     	   		});
    		    
    		    
    		  	//반품신청
	   			$("a[data-btn='btn_return']").on("click",function(e) {
	   				e.preventDefault();
	   				var $target = $(e.currentTarget);
	   				
	   				var frm = document.hiddenForm;
	   				frm.orderNo.value = $target.attr("data-ordNo");
	   				frm.action = "<c:url value='/front/myPage/orderReturnApply01'/>";
	   				frm.submit();
    		    });
	   			
	   			
	   			
	   			//교환신청
	   			$("a[data-btn='btn_change']").on("click",function(e) {
	   				e.preventDefault();
	   				var $target = $(e.currentTarget);
	   				
	   				var frm = document.hiddenForm;
	   				frm.orderNo.value = $target.attr("data-ordNo");
	   				frm.action = "<c:url value='/front/myPage/orderChangeApply01'/>";
	   				frm.submit();
    		    });
				
				
    		    $('#orderList').rowspan(1);
    		    $('#orderCancelList').rowspan(1);
    		    $('#orderChangeList').rowspan(1);
    		    $('#orderAddPayList').rowspan(1);
    		    
    		    
    		    //내역 리스트 종류별 보기
    		    viewTableKind = function(tableNm){
    		    	
    		    	var $target = $("#"+tableNm);
    		    	$("table[id$='List']").hide();
    		    	$target.show();
    		    	
    		    	
    		    	$("a[date-target]").removeClass("on");
    		    	$("a[date-target='"+tableNm+"']").addClass("on");
    		    	
    		    	var goList = "<c:url value='/front/myPage/"+tableNm+"'/>";
    		    	$("#goList").attr("href" ,goList);
    		    	
    		    	if(tableNm == "orderList"){
    		    		$("#detailTxtArea").text("주문번호를 누르시면 주문/배송 결과에 대한 상세내역을 보실 수 있습니다.");
    		    	}else if(tableNm == "orderCancelList"){
    		    		$("#detailTxtArea").text("상품명를 누르시면 취소/반품 결과에 대한 상세내역을 보실 수 있습니다.");
    		    	}else if(tableNm == "orderChangeList"){
    		    		$("#detailTxtArea").text("상품명를 누르시면 교환내역 결과에 대한 상세내역을 보실 수 있습니다.");
    		    	}else if(tableNm == "orderAddPayList"){
    		    		$("#detailTxtArea").text("상품명를 누르시면 추가결제 결과에 대한 상세내역을 보실 수 있습니다.");
    		    	}
    		    	
    		    };
    		    
    		    viewTableKind("orderList");
    			
    		});
    		
    		
    		function goDetail(orderNo){
				document.hiddenForm.hiddenOrderNo.value = orderNo;
				document.hiddenForm.action = "<c:url value='/front/myPage/orderAddPayDetail'/>";
				document.hiddenForm.submit();
			}
    		
   		</script>
		
		
		
	</head>
	<body>
		<form id="hiddenForm" name="hiddenForm" method="post" >
			<input type="hidden" name="orderNo"  id="orderNo"  value=""/>
			<input type="hidden" name="hiddenOrderNo"  id="hiddenOrderNo"  value=""/>
			<input type="hidden" name="hiddenOrdGdsSeq"  id="hiddenOrdGdsSeq"  value=""/>
		</form>
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
								<a href="#">MY PAGE</a></a>
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
										<span class="txt01">내정보</span>
										<span class="link01">
											<a href="<c:url value="/front/myPage/memberInfo"/>">변경하기</a>
											<a href="<c:url value="/front/myPage/withdraw"/>">회원탈퇴</a>
										</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 box_col01">
											<ul class="mypage_info01 clfix">
												<li>
													<span class="name">${member.nm}</span>
													<span class="sex"><c:if test="${member.sex eq 'M'}">남</c:if><c:if test="${member.sex eq 'W'}">여</c:if></span>
													<span class="bar">/</span>
												</li>
												<li>
													<span class="birth"><fmt:formatDate value="${member.birthDt}" pattern="yyyy.MM.dd"/></span>
													<span class="email">${member.email}</span>
												</li>
												<li>
													<span class="phone">${member.cpNo}</span>
												</li>
											</ul>
										</div>
										<div class="box01 box_col02">
											<div class="mypage_info02 clfix">
												<span class="point">포인트</span>
												<span class="point_num"><fmt:formatNumber value="${member.curPoint}" pattern="#,###P"/></span>
											</div>
										</div>
										<div class="box01 box_col03">
											<div class="mypage_info03 clfix">
												<a href="#" class="grade ui_btn_grade">회원등급
													<img src="/html/worksout/images/common/ico_question_mark.png" alt="회원등급 안내">
												</a>
												<span class="grade_num">    ${member.grdNm}</span>
											</div>
										</div>
									</div>
									<!-- 회원등급 안내 레이어 팝업 -->
									<div style="display:none;" class="layer_popup ui_layer_grade">
										<div class="layer_popup_container">
											<div class="layer_popup_content">
												<p class="layer_top_tit">회원등급 안내</p>
												<!-- <div class="layer_info">
													<div class="layer_tit">3등급</div>
													<div class="layer_desc">신규 회원 구매금액의 1% 적립</div>
												</div> -->
												<div class="layer_info">
													<div class="layer_tit">일반회원</div>
													<div class="layer_desc">신규 회원가입 시 부여되는 등급. 구매 금액의 1% 적립</div>
												</div>
												<div class="layer_info">
													<div class="layer_tit02">WHITE</div>
													<div class="layer_desc">30만원 이상 구매 고객. 구매 금액의 2% 적립</div>
												</div>
											</div>
										</div>
										<a href="#" class="layer_btn_close">
											<img src="/html/worksout/images/common/btn_close_all_menu.png" alt="닫기">
										</a>
									</div>
									<!-- 회원등급 안내 레이어 팝업 -->
								</div>
								<div class="web_mypage_show_area">
									<div class="content_menu content_menu02">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<a href="#" date-target="orderList"       onclick="viewTableKind('orderList');">주문/배송 내역</a>
										<a href="#" date-target="orderCancelList" onclick="viewTableKind('orderCancelList');">취소/반품 내역</a>
										<a href="#" date-target="orderChangeList" onclick="viewTableKind('orderChangeList');">교환내역</a>
										<a href="#" date-target="orderAddPayList" onclick="viewTableKind('orderAddPayList');" class="last_child">추가결제</a>
									</div>
								</div>
								<div class="mypage_area">
									<div class="mobile_mypage_show_aera">
										<div class="mypage_tit clfix space01">
											<span class="txt01">주문내역</span>
											<span class="link01">
												<a href="#" class="btn_plus">전체보기</a>
											</span>
										</div>
										<!-- 일정영역의 사이즈가 되면 나오는 링크 영역 입니다. -->
										<!-- 셀렉트 박스내의 링크 선택시 링크 이동 되도록 개발 필요 합니다. -->
										<!-- 화면 사이즈에 따른 보이고 안보이고는 CSS 에서 처리 합니다. -->
										<span class="input_select">
											<select onchange="location.href=this.value">
												<option value="<c:url value="/front/myPage/orderList"/>">주문/배송 내역</option>
												<option value="<c:url value="/front/myPage/orderCancelList"/>">취소/반품 내역</option>
												<option value="<c:url value="/front/myPage/orderChangeList"/>">교환내역</option>
												<option value="<c:url value="/front/myPage/orderAddPayList"/>">추가결제</option>
											</select>
										</span>
										<p class="mypage_txt_style01">- 주문번호를 누르시면 주문/배송 결과에 대한 상세내역을 보실 수 있습니다.</p>
									</div>
									
									
									
									<!-- 주문내역 -->
									<table class="tbl_col02 tbl_col02_mypage_order_list ui_reponsible_table_type01" id="orderList">
										<caption>주문/배송 내역 테이블로 브랜드, 매장명, 주문번호, 상품, 주문일시, 가격, 상태 에 대한 정보를 알 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">매장명</th>
												<th scope="col">주문번호</th>
												<th scope="col">상품</th>
												<th scope="col">주문일시</th>
												<th scope="col">가격</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											
											<!-- 주문 배송 내역 -->
											<c:choose>
												<c:when test="${not empty orderList}">
													<c:forEach var="order" items="${orderList}" varStatus="orderIndex">
														<tr>
															<td class="tbl_layout02">
																<div class="mobile_th">매장명</div>
																<div class="tbl_cont">${order.siteNm}</div>
															</td>
															<td class="tbl_layout03">
																<div class="mobile_th">주문번호</div>
																<div class="tbl_cont">
																	<a href="#" class="btn_order" data-orderNo="${order.ordNo}">${order.ordNo}</a>
																</div>
															</td>
															
															<td class="tbl_layout04">
																<div class="mobile_th">상품</div>
																<div class="tbl_cont">
																	<div class="p_tit">[${order.brand}] ${order.ubiGdsNm}</div>
																	<div class="info">Color = ${order.ubiGdsColorNm} / Size = ${order.ubiGdsSize}</div>
																</div>
															</td>
															<td class="tbl_layout05">
																<div class="mobile_th">주문일시</div>
																<div class="tbl_cont"><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd"/><p></div>
															</td>
															<td class="tbl_layout06">
																<div class="mobile_th">가격</div>
																<div class="tbl_cont">
																	<span class="ico_price">${order.slPrc}</span>
																</div>
															</td>
															<td class="tbl_layout07">
																<div class="mobile_th">상태</div>
																<div class="tbl_cont clfix">
																	<span class="state">${order.perOrdStatNm}</span>
																	<span class="btn_state">
																		
																		<c:if test="${order.perOrdStat eq 'OR00505'}"><!-- 배송완료 -->
																			<%-- <a href="#" class="btn_in_table" data-ordNo="${order.ordNo}" data-btn="btn_return">반품신청</a>
																			<a href="#" class="btn_in_table" data-ordNo="${order.ordNo}" data-btn="btn_change">교환신청</a> --%>
																		</c:if> 
																		<c:if test="${good.perOrdStat eq 'OR00504'  && order.dlvCmpNo eq 2}"><!-- 배송중 이고 택배사가 우체국일경우만 -->
																			<a href="#" class="btn_in_table" data-btn="btn_delivery" data-invNo="${order.invNo}">배송추적</a>
																		</c:if> 
																		<c:if test="${order.perOrdStat eq 'OR00501'}"><!-- 결재대기 -->
																			<!-- <a href="#" class="btn_in_table" data-btn="btn_cancel_order">주문취소</a> -->
																		</c:if> 
																		<c:if test="${order.perOrdStat eq 'OR00502'}"><!-- 결재완료 -->
																			<!-- <a href="#" class="btn_in_table" data-btn="btn_cancel_pay">결제취소</a> -->
																		</c:if> 
																		
<!-- 																		<a href="#" class="btn_in_table" data-btn="btn_bring back">반품</a> -->
<!-- 																		<a href="#" class="btn_in_table" data-btn="btn_exchange">교환</a> -->
<!-- 																		<a href="#" class="btn_in_table" data-btn="btn_delivery">배송추적</a> -->
<!-- 																		<a href="#" class="btn_in_table" data-btn="btn_cancel_order">주문취소</a> -->
<!-- 																		<a href="#" class="btn_in_table" data-btn="btn_cancel_pay">결제취소</a> -->
																	</span>
																</div>
															</td>
															
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="7" class="no_content">
															<img src="/html/worksout/images/common/img_no_order.gif" alt="주문/배송내역이 없습니다.">
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
											
										</tbody>
									</table>
									
									
									<!-- 취소/환불 내역 -->
									<table class="tbl_col02 tbl_col02_mypage_order_list ui_reponsible_table_type01" id="orderCancelList">
										<caption>주문/배송 내역 테이블로 브랜드, 매장명, 주문번호, 상품, 주문일시, 가격, 상태 에 대한 정보를 알 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">매장명</th>
												<th scope="col">주문번호</th>
												<th scope="col">상품</th>
												<th scope="col">취소/반품 일시</th>
												<th scope="col">총 환불금액</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<!-- 취소 반품 내역 -->
											<c:choose>
												<c:when test="${not empty cancelList}">
													<c:forEach var="order" items="${cancelList}" varStatus="orderIndex">
														<tr>
															<td class="tbl_layout02">
																<div class="mobile_th">매장명</div>
																<div class="tbl_cont">${order.siteNm}</div>
															</td>
															<td class="tbl_layout03">
																<div class="mobile_th">주문번호</div>
																<div class="tbl_cont">
																	${order.ordNo}
																</div>
															</td>
															<td class="tbl_layout04">
																<div class="mobile_th">상품</div>
																<div class="tbl_cont">
																	<div class="p_tit"><a href="#" class="btn_order" data-action="orderCancelDetail" data-orderNo="${order.ordNo}" data-ordGdsSeq="${order.ordGdsSeq}">[${order.brand}] ${order.ubiGdsNm}</a></div>
																	<div class="info">Color = ${order.ubiGdsColorNm} / Size = ${order.ubiGdsSize}</div>
																</div>
															</td>
															<td class="tbl_layout05">
																<div class="mobile_th">취소/반품 일시</div>
																<div class="tbl_cont"><fmt:formatDate value="${order.clmRegDts}" pattern="yyyy-MM-dd"/><p></div>
															</td>
															<td class="tbl_layout06">
																<div class="mobile_th">총 환불금액</div>
																<div class="tbl_cont">
																	<span class="ico_price">${order.orderGoods[0].actlPayPrc}</span>
																</div>
															</td>
															<td class="tbl_layout07">
																<div class="mobile_th">상태</div>
																<div class="tbl_cont clfix">
																	<span class="state">${order.perOrdStatNm}</span>
																</div>
															</td>
															
														</tr>
														</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="7" class="no_content">
															<img src="/html/worksout/images/common/img_no_order_cancel_list.gif" alt="취소/반품 내역이 없습니다.">
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
											
										</tbody>
									</table>
									
									
									
									
									
									<!-- 교환내역 -->
									<table class="tbl_col02 tbl_col02_mypage_order_list ui_reponsible_table_type01" id="orderChangeList">
										<caption>주문/배송 내역 테이블로 브랜드, 매장명, 주문번호, 상품, 주문일시, 가격, 상태 에 대한 정보를 알 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">매장명</th>
												<th scope="col">주문번호</th>
												<th scope="col">상품</th>
												<th scope="col">교환일시</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											
											<!-- 교환 내역 -->
											<c:choose>
												<c:when test="${not empty changeList}">
													<c:forEach var="order" items="${changeList}" varStatus="orderIndex">
														<tr>
															<td class="tbl_layout02">
																<div class="mobile_th">매장명</div>
																<div class="tbl_cont">${order.siteNm}</div>
															</td>
															<td class="tbl_layout03">
																<div class="mobile_th">주문번호</div>
																<div class="tbl_cont">
																	${order.ordNo}
																</div>
															</td>
															<td class="tbl_layout04">
																<div class="mobile_th">상품</div>
																<div class="tbl_cont">
																	<div class="p_tit"><a href="#" class="btn_order" data-action="orderChangeDetail" data-orderNo="${order.ordNo}" data-ordGdsSeq="${order.ordGdsSeq}">[${order.brand}] ${order.ubiGdsNm}</a></div>
																	<div class="info">Color = ${order.ubiGdsColorNm} / Size = ${order.ubiGdsSize}</div>
																</div>
															</td>
															<td class="tbl_layout05">
																<div class="mobile_th">교환일시</div>
																<div class="tbl_cont"><fmt:formatDate value="${order.clmRegDts}" pattern="yyyy-MM-dd"/><p></div>
															</td>
															<td class="tbl_layout07">
																<div class="mobile_th">상태</div>
																<div class="tbl_cont clfix">
																	<span class="state">${order.perOrdStatNm}</span>
																</div>
															</td>
															
														</tr>
														
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="6" class="no_content">
															<img src="/html/worksout/images/common/img_no_order_change_list.gif" alt="교환내역이 없습니다.">
														</td>
													</tr>
												</c:otherwise>
											</c:choose>
											
										</tbody>
									</table>
									
									
									
									
									
									
									
									<!-- 추가 결제 내역 -->
									<table class="tbl_col02 tbl_col02_mypage_order_list ui_reponsible_table_type01" id="orderAddPayList">
										<caption>주문/배송 내역 테이블로 브랜드, 매장명, 주문번호, 상품, 주문일시, 가격, 상태 에 대한 정보를 알 수 있습니다.</caption>
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
										<tbody>
											
											<!-- 추가 결제 내역 -->
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
																	${orderAddPay.payWay}
<%-- 																<c:if test="${orderAddPay.payWay == null}"> --%>
<!-- 																	<input type="radio" name="payWay" value="OR00801">신용카드<br/> -->
<!-- 																	<input type="radio" name="payWay" value="OR00802">실시간계좌이체<br/> -->
<!-- 																	<input type="radio" name="payWay" value="OR00803">가상계좌 -->
<%-- 																</c:if> --%>
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
																	<a href="#" class="btn_in_table">결제하기</a>
																</c:if>
																<c:if test="${orderAddPay.payStatNm == null}">
																	${orderAddPay.payStatNm}
																</c:if>																
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
									
									
									
									
									
									
									
									
									
									
									
									
									<div class="btn_area03 clfix">
										<div class="txt01">
											<p id="detailTxtArea"></p>
										</div>
										<div class="btn01">
											<a href="#" id="goList" class="btn_plus">전체보기</a>
										</div>
									</div>
									
									
									
									<div class="mypage_tit clfix space01">
										<span class="txt01">내 배송지</span>
										<span class="link01">
											<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지 관리</a>
										</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01">
											<c:choose>
												<c:when test="${not empty mydlvAddrList}">
													<ul class="mypage_info04">
														<li class="first_child">
															<div class="tit">
																<label for="delivery">배송지</label>
															</div>
															<div class="desc">
																<div class="radio_group02">
																	<c:choose>
																		<c:when test="${not empty mydlvAddrList}">
																		<c:forEach var="mydlvAddr" items="${mydlvAddrList}" varStatus="stat">
																			<span class="input_radio">
																				<input type="radio" id="addrBynm${stat.count}" name="addrBynm" value="${mydlvAddr.addrBynm}" onclick="selectDlv(${stat.index})" <c:if test="${mydlvAddr.baseValYn eq 'Y'}">checked="checked"</c:if>>
																			</span>
																			<label for="addrBynm${stat.count}">${mydlvAddr.addrBynm}</label>
																		</c:forEach>
																		</c:when>
																	</c:choose>
																</div>
															</div>
														</li>
														<li>
															<div class="tit">이름</div>
															<div class="desc" data-area="nm"></div>
														</li>
														<li>
															<div class="tit">연락처</div>
															<div class="desc" data-area="tel"></div>
														</li>
														<li>
															<div class="tit">휴대폰번호</div>
															<div class="desc" data-area="cpNo"></div>
														</li>
														<li class="last_child">
															<div class="tit">주소</div>
															<div class="desc" data-area="addr"></div>
														</li>
													</ul>
												</c:when>
												<c:otherwise>
													<ul class="mypage_info04">
														<li class="first_child">
															배송지가 없습니다. 새배송지를 등록해 주세요
														</li>
													</ul>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">Q&amp;A</span>
										<span class="link01">
											<a href="<c:url value="/front/myPage/qnaList"/>" class="btn_plus">전체보기</a>
										</span>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_qna_list ui_reponsible_table_type01">
										<caption>Q &amp; A 게시판으로 제목, 답변여부 를 확인 할 수 있습니다.</caption>
										<thead>
											<!-- th에서 빠지는 항목이 발생시 th 삭제하면됨. 밑에 td도 같이 삭제함. -->
											<tr>
												<th scope="col">NO</th>
												<th scope="col">제목</th>
												<th scope="col">최근 문의일</th>
												<th scope="col">최근 답변일</th>
												<th scope="col">답변여부</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${not empty inquiryList}">
													<c:forEach items="${inquiryList}" var="inquiry" varStatus="inquiryCount">
														<tr data-cnslNo="${inquiry.cnslNo}">
															<td class="tbl_layout01">
																<div class="mobile_th">NO</div>
																<div class="tbl_cont">${inquiry.rnum}</div>
															</td>
															<td class="tbl_layout02">
																<div class="mobile_th">제목</div>
																<div class="tbl_cont">
																	<a href="<c:url value="/front/myPage/qnaList"/>" class="ui_title">${inquiry.title}</a>
																	<c:if test="${inquiryCount.first}">
																		<img src="/html/worksout/images/common/ico_new.gif" alt="NEW" class="ico_new">
																	</c:if>
																</div>
															</td>
															<td class="tbl_layout03">
																<div class="mobile_th">최근 문의일</div>
																<div class="tbl_cont">${inquiry.maxQ}</div>
															</td>
															<td class="tbl_layout04">
																<div class="mobile_th">최근 답변일</div>
																<div class="tbl_cont">${inquiry.maxA}</div>
															</td>
															<td class="tbl_layout05">
																<div class="mobile_th">답변여부</div>
																<div class="tbl_cont">${inquiry.cnslStat}</div>
															</td>
														</tr>
														
														
															<!-- 기본 질문 -->
															<tr class="reply_section" style="display: none;">
																<td colspan="5">
																<div class="qna_reply_area">
																	<c:choose>
																		<c:when test="${empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중')}">
																			<div class="qna_add_top">
																				<a href="#" class="btn_del_reply" data-btn="btn_del_reply">
																					<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
																				</a>
																			</div>
																		</c:when>
																	</c:choose>
																	
																	<div class="qna_q clfix" data-gubun="main">
																		<span class="ico_q">Q</span>
																		<span class="txt_q">${inquiry.cnslTxt}</span>
																		<span class="date_q">${inquiry.regDts}</span>
																	</div>
																	<c:if test="${inquiry.atchFile ne null}">
																		<div class="qna_file">
																			<a href="#" class="ico_file" onclick="javascript:fileExport(this);" data-file="<c:out value='${inquiry.atchFile}'/>">
																				<span class="line">${inquiry.atchFile}</span>
																			</a>
																		</div>
																	</c:if>
																	
																	<c:choose>
																		<c:when test="${empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중')}">
																			<div class="qna_add_bottom" data-area="mod_default">
																				<a href="#" class="btn_modify_reply">수정하기</a>
																			</div>

																			<div class="qna_add_top" data-area="mod_input" style="display: none;">
																				<a href="#" class="btn_del_reply" data-btn="mod_return_default">
																					<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
																				</a>
																			</div>
																			<div class="qna_add_input" data-area="mod_input" style="display: none;">
																				<span class="input_txt">
																					<input type="text" id="add_qna" name="add_qna" placeholder="">
																				</span>
																				<div class="btn_add_reply">
																					<a href="#" class="btn_black01"  data-btn="mod_modify">문의 수정하기</a>
																				</div>
																			</div>
																		</c:when>
																	</c:choose>
																	
																	<c:forEach items="${inquiry.inqueryRepl}" var="inqueryRepl" varStatus="inqueryReplCount">
																		<c:if test="${inqueryRepl.wrtrCls == 'CM01002'}">
																		
																			<c:choose>
																				<c:when test="${not empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중') && inqueryReplCount.last}">
																					<div class="qna_add_top">
																						<a href="#" class="btn_del_reply" data-btn="btn_del_reply">
																							<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
																						</a>
																					</div>
																				</c:when>
																			</c:choose>
																		
																			<div class="qna_q clfix"  data-gubun="reply" data-memoNo="${inqueryRepl.memoNo}">
																				<span class="ico_q">Q</span>
																				<span class="txt_q">${inqueryRepl.memoTxt}</span>
																				<span class="date_q">${inqueryRepl.updDts}</span>
																			</div>
																			
																			<c:choose>
																				<c:when test="${not empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중') && inqueryReplCount.last}">
																					<div class="qna_add_bottom" data-area="mod_default">
																						<a href="#" class="btn_modify_reply">수정하기</a>
																					</div>
		
																					<div class="qna_add_top" data-area="mod_input" style="display: none;">
																						<a href="#" class="btn_del_reply" data-btn="mod_return_default">
																							<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
																						</a>
																					</div>
																					<div class="qna_add_input" data-area="mod_input" style="display: none;">
																						<span class="input_txt">
																							<input type="text" id="add_qna" name="add_qna" placeholder="">
																						</span>
																						<div class="btn_add_reply">
																							<a href="#" class="btn_black01" data-btn="mod_modify">문의 수정하기</a>
																						</div>
																					</div>
																				</c:when>
																			</c:choose>
																			
																			
																			
																			
																		</c:if>
																		<c:if test="${inqueryRepl.wrtrCls == 'CM01001'}">
																			<div class="qna_a clfix">
																				<span class="ico_a">A</span>
																				<span class="txt_a">${inqueryRepl.memoTxt}</span>
																				<span class="date_a">${inqueryRepl.updDts}</span>
																			</div>
																		</c:if>
																		<c:if test="${inqueryReplCount.last && inquiry.cnslStat eq '처리완료'}">
																			<div class="qna_replay_add_btn" data-area="add_reply">
																				<a href="#" class="btn_add_reply_show ui_add_reply_btn" data-btn="add_reply">+ 추가문의</a>
																			</div>
																			
																			<div class="qna_add_top" data-area="add_input" style="display: none;">
																				<a href="#" class="btn_del_reply" data-btn="add_return_default">
																					<img src="/html/worksout/images/common/btn_del_reply.png" alt="닫기">
																				</a>
																			</div>
																			<div class="qna_add_input" data-area="add_input" style="display: none;">
																				<span class="input_txt">
																					<input type="text" id="add_qna" name="add_qna" placeholder="">
																				</span>
																				<div class="btn_add_reply">
																					<a href="#" class="btn_black01" data-btn="add_reply_proc">추가 문의하기</a>
																				</div>
																			</div>
																		
																		</c:if>
																	</c:forEach>
																</div>
																</td>
															</tr>
															<!-- 기본 질문 -->
														
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="5" align="center">문의내역이 없습니다.</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>