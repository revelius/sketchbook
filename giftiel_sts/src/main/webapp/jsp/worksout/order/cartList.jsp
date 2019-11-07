<%--
 * =============================================================================
 * 파일명 : /front/order/cartList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-22
 *
 * 파일 내용 : order > 장바구니
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
			//주문서 작성폼으로 이동
		    $("#btn_order").click(function() {
		    	<c:if test="${!isLogined}">
					<c:if test="${!isMobile}">
						$("#lo-ginBtn").trigger("click");
					</c:if>
					<c:if test="${isMobile}">
						$(".btn_all_menu02").trigger("click");
						setTimeout("$('a#lo-ginBtn').trigger('click');",300);
					</c:if>			    	
		    	
		    	    return false;
		    	</c:if>
		    	
		    	if($("#chkCart:checked").length == 0){
			        $('input[id="chkCart"]').each(function() {
		        		this.checked = true;
		        	});
		    	}
		    	
		    	if($("#chkCart:checked").length == 0){
			        alert("선택된 상품이 없습니다.");
			        return false;
		    	}		    	
		    	
		    	var frm = document.cartForm;
		        frm.target = '_self';
		        frm.action = 'orderForm';
		        frm.submit();
		    });
			
		    $("#btn_order_nomember").click(function() {
		    	if($("#chkCart:checked").length == 0){
			        $('input[id="chkCart"]').each(function() {
		        		this.checked = true;
		        	});
		    	}
		    	
		    	if($("#chkCart:checked").length == 0){
			        alert("선택된 상품이 없습니다.");
			        return false;
		    	}		    	
		    	
		    	var frm = document.cartForm;
		        frm.target = '_self';
		        frm.action = 'orderForm';
		        frm.submit();
		    });			
			
			deleteCartGoods = function(cartNo){
				if(!confirm("해당 상품을 삭제하시겠습니까?")){
					return;
				}
				$.ajax({
			        url : "<c:url value='/front/order/deleteGdsCart'/>",
			        type: "post",
			        data : {'cartNo' :  cartNo},
			        async: true,
			       // dataType: "json",
			       // contentType: "application/json", 
			        success : function(responseData){
			            var data = JSON.parse(responseData);
			            if(data == "1"){  //저장 성공 
						    $("tr#cart_"+cartNo).fadeOut( "slow", function() {
						    	$("tr#cart_"+cartNo).empty();
						    	
						    	setTotalAmt();
						    });
			            }              
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
			    });
			};
			
			//사이즈 변경
			modifySize = function(cartNo, gdsSize){
				var size = gdsSize.split("|")[0];
				var stock = gdsSize.split("|")[1];
				
				if(parseInt(stock) < 1){
					alert("재고가 없습니다.");
					return false;
				}
				
				$.ajax({
			        url : "<c:url value='/front/order/updateGdsSize'/>",
			        type: "post",
			        data : {'gdsSize' : size , 'cartNo' : cartNo},
			        async: true,
			        success : function(responseData){
			            var data = JSON.parse(responseData);
			            if(data == "1"){  //저장 성공 
			            	$("tr#cart_"+cartNo).fadeOut( "slow", function() {
						    });
			            	$("tr#cart_"+cartNo).fadeIn( "slow", function() {
						    });
			            }              
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
			    });
			};
			
			
		    $("#all_check").click(function(){
		        var chk = $(this).is(":checked");//.attr('checked');
		        console.log(chk);
		        
		        $('input[id="chkCart"]').each(function() {
		        		this.checked = chk;
		        });
		    });
		    
		    setTotalAmt = function(){
		    	var totalAmt = 0; 
		    	$('.tbl_col02.tbl_col02_mypage_order_detail .tbl_layout02 .tbl_cont .ico_price').each(function(index) {
			    	totalAmt = parseInt(totalAmt) + parseInt($(this).html().replace(',',''));
			    });
			    
		    	if(totalAmt < 100000){
		    		$("#totalDlvCost").html("+ 3,000");
		    		$("#totalAmt").html(comma(totalAmt));
		    		$("#totalAmt2").html(comma(totalAmt+3000));
		    	}else{
		    		$("#totalAmt").html(comma(totalAmt));
		    		$("#totalAmt2").html(comma(totalAmt));
		    	}
		    };
		});
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
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
								<a href="#">SHOPPING CART</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_cart_area">
								<!-- snbCart include -->
								<!-- snbCart include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#" class="on">
												<span class="txt">상품선택</span>
											</a>
											<a href="#">
												<span class="txt">주문/결제</span>
											</a>
											<a href="#">
												<span class="txt">주문확인</span>
											</a>
											<a href="#" class="last_child">
												<span class="txt">주문완료</span>
											</a>
										</span>
									</div>
								</div>
								<form:form id="cartForm" name="cartForm" method="post" onsubmit="return check(form)" modelAttribute="cartForm">
								<div class="cart_order_area" style="text-align:right;">
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>상품선택 테이블로 체크박스, 상품, 가격, 적립포인트, 삭제 항목을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">
													<span class="input_check">
														<input type="checkbox" id="all_check" name="all_check">
													</span>
												</th>
												<th scope="col">상품</th>
												<th scope="col">가격</th>
												<th scope="col">적립포인트</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(cartList) > 0}">
													<c:forEach items="${cartList}" varStatus="listCount" var="cart">
													<tr id="cart_${cart.cartNo }">
														<td class="tbl_layout_util01">
															<div class="tbl_cont">
																<span class="input_check">
																	<form:checkbox path="carts[${listCount.count-1 }].chkCart" id="chkCart"/>
																	<form:hidden path="carts[${listCount.count-1 }].ubiGdsNo" value="${cart.ubiGdsNo}"/>
																	<form:hidden path="carts[${listCount.count-1 }].gdsSize" value="${cart.gdsSize}"/>
																	<form:hidden path="carts[${listCount.count-1 }].ubiGdsColorNm" value="${cart.ubiGdsColorNm}"/>
																	<form:hidden path="carts[${listCount.count-1 }].mainImg" value="${cart.mainImg}"/>
																	<form:hidden path="carts[${listCount.count-1 }].brand" value="${cart.brand}"/>
																	<form:hidden path="carts[${listCount.count-1 }].ubiGdsNm" value="${cart.ubiGdsNm}"/>
																	<form:hidden path="carts[${listCount.count-1 }].ubiSlPrc" value="${cart.ubiSlPrc}"/>
																	<form:hidden path="carts[${listCount.count-1 }].qty" value="1"/>
																	<form:hidden path="carts[${listCount.count-1 }].expPnt" value="${cart.expPnt}"/>
																	<c:set var="gdsIdx" value="${gdsIdx+1 }"/>
																</span>
															</div>
														</td>
														<td class="tbl_layout01 product_in_img">
															<div class="mobile_th">상품</div>
															<div class="tbl_cont clfix">
																<span class="p_img">
																	<img src="<c:url value='${uploadImage}${cart.mainImg}'/>" width="76px">
																</span>
																<ul class="p_info">
																	<li>[${cart.brand}] ${cart.ubiGdsNm}</li>
																	<li>Color = ${cart.ubiGdsColorNm}</li>
																	<li>${cart.ubiGdsNo}</li>
																	<li>
																		<span class="txt_size">SIZE</span>
																		<span class="input_select">
																			<select onchange="javascript:modifySize('${cart.cartNo }',this.value);">
																				<c:forEach items="${cart.currentGoodsSizes}" varStatus="listCount" var="curSize">
																					<c:if test="${curSize.stock < 1}">
																						<option value="${curSize.ubiGdsSize }|${curSize.stock }" disabled="disabled">${curSize.ubiGdsSize }[SOLD OUT]</option>
																					</c:if>
																					<c:if test="${curSize.stock > 0}">
																						<option value="${curSize.ubiGdsSize }|${curSize.stock }" <c:if test="${cart.gdsSize == curSize.ubiGdsSize}">selected="selected"</c:if>>${curSize.ubiGdsSize }</option>
																					</c:if>																					
																				</c:forEach>
																			</select>
																		</span>
																		<!-- <a class="btn_white03">변경</a> -->
																	</li>
																</ul>
															</div>
														</td>
														<td class="tbl_layout02">
															<div class="mobile_th">가격</div>
															<div class="tbl_cont">
																<span href="#" class="ico_price">
																	<fmt:formatNumber type="currency" value="${cart.ubiSlPrc }" pattern="###,###" />
																</span>
															</div>
														</td>
														<td class="tbl_layout03">
															<div class="mobile_th">적립포인트</div>
															<div class="tbl_cont"><fmt:formatNumber type="currency" value="${cart.expPnt}" pattern="###,###" /></div>
														</td>
														<td class="tbl_layout04">
															<div class="mobile_th">삭제</div>
															<div class="tbl_cont">
																<a href="javascript:deleteCartGoods('${cart.cartNo }')">
																	<img src="/html/worksout/images/common/btn_del_product.png" alt="삭제">
																</a>
															</div>
														</td>
													</tr>
													</c:forEach>
												</c:when>
												<c:when test="${fn:length(cartList) == 0}">
													<tr>
														<td colspan="5" class="no_content">
															<img src="/html/worksout/images/common/img_no_cart_list.gif" alt="주문/배송내역이 없습니다.">
														</td>
													</tr>
												</c:when>
											</c:choose>											
										</tbody>
									</table>
									<ul class="cart_order_result clfix">
										<li class="result_unit01 clfix">
											<dl class="clfix">
												<dt>총 가격</dt>
												<dd id="totalAmt"><fmt:formatNumber type="currency" value="${totalSlAmt }" pattern="###,###" /></dd>
											</dl>
										</li>
										<li class="result_unit02 clfix">
											<dl class="clfix">
												<dt>배송비</dt>
												<dd id="totalDlvCost">+ <fmt:formatNumber type="currency" value="${deliveryCost }" pattern="###,###" /></dd>
											</dl>
										</li>
										<li class="result_unit03 clfix">
											<dl class="clfix">
												<dt>총 결제 예상금액</dt>
												<dd>
													<span class="ico_price" id="totalAmt2"><fmt:formatNumber type="currency" value="${totalSlAmt + deliveryCost}" pattern="###,###" /></span>
												</dd>
											</dl>
										</li>
									</ul>
									
									<span class="txt01"> ※ 10만원 이상 구입 시 배송비가 무료 입니다.</span>										

									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
									<div class="btn_area04 clfix">
									<c:if test="${!isLogined }">
										<div class="btn01">
											<a href="#" class="btn_gray01" id="btn_order_nomember">비회원으로 주문하기</a>
										</div> 
										<div class="btn02">
											<a href="#" class="btn_black01" id="btn_order">회원으로 주문하기</a>
										</div>									
									</c:if>
									<c:if test="${isLogined }">
										<div class="btn02">
											<a href="#" class="btn_black01" id="btn_order">주문하기</a>
										</div>									
									</c:if>
									</div>
								</div>
								</form:form>
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