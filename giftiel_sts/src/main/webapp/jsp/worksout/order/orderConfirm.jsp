<%--
 * =============================================================================
 * 파일명 : /front/order/orderConfirm.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-26
 *
 * 파일 내용 : order > 주문서 작성 확인
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%@ include file="/jsp/common/order/site_conf_inc.jsp" %>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		<script type="text/javascript" src="<%=g_conf_js_url%>"></script>
		<script type="text/javascript">
		$(function() {
			//주문데이터 init, pg호출
		    $("#orderPay").one("click",function(){
		    	$("#orderPay").text("Loading...");
// 		    	$("#orderPay").css("background-color","gray");
		    	
// 		    	$("#orderPay").hide();
		    	
		    	<c:if test="${isMobile}">
		    		$("#orderForm").attr("target", "_self");
		    		$("#orderForm").attr("action", "orderPay2");
		    	</c:if>
		    	<c:if test="${!isMobile}">
		    		$("#orderForm").attr("target", "order_pay");
		    		$("#orderForm").attr("action", "orderPay");
		    	</c:if>
		    	
				<c:if test="${order.orderPay[0].payAmt == order.orderPay[1].payAmt}">
		    		$("#orderForm").attr("target", "_self");
		    		$("#orderForm").attr("action", "orderPayOnlyPoint");
				</c:if>
		    	
 		    	$("#orderForm").submit(function(){
 		    		$("#order_pay").load(function() {
 	                	 console.log(this);
 	                });
 	            }).submit();		    	
	        });			
			
		});		
		</script>
		
		
    <script type="text/javascript">
    <c:if test="${!isMobile}">
	    StartSmartUpdate();
    </c:if>

    function  jsf__chk_plugin()
    {
        // IE 일경우 기존 로직을 타게끔
        if ((navigator.userAgent.indexOf('MSIE') > 0) || (navigator.userAgent.indexOf('Trident/7.0') > 0))
        {
            if ( document.Payplus.object != null )
            {
                //window.location = "order.jsp";
            }
        }
        // 그 외 브라우져에서는 체크로직이 변경됩니다.
        else
        {
            var inst = 0;
            for (var i = 0; i < navigator.plugins.length; i++)
            {
                if (navigator.plugins[i].name == "KCP")
                {
                    inst = 1;
                }
            }

            if (inst == 1)
            {
                //window.location = "order.jsp";
            }
            else
            {
                document.location.href=GetInstallFile();
            }
        }
    }
    </script>

    <script type="text/javascript">
	    <c:if test="${!isMobile}">
        	setTimeout("jsf__chk_plugin()","1000");
		</c:if>
    </script>		
	</head>
	<body>
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
								<a href="#">SHOPPING CART</a>
							</li>
							<li>
								<a href="#">ORDER</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_order_area">
								<!-- snbOrder include -->
								<!-- snbOrder include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">상품선택</span>
											</a>
											<a href="#">
												<span class="txt">주문/결제</span>
											</a>
											<a href="#" class="on">
												<span class="txt">주문확인</span>
											</a>
											<a href="#" class="last_child">
												<span class="txt">주문완료</span>
											</a>
										</span>
									</div>
								</div>
								<form:form id="orderForm" name="orderForm" method="post" modelAttribute="orderForm">
								<form:hidden path="mobile" value="${isMobile }"/>
								<form:hidden path="ordrNm"/>
								<form:hidden path="ordrTel01"/>
								<form:hidden path="ordrTel02"/>
								<form:hidden path="ordrTel03"/>
								<form:hidden path="ordrCp01"/>
								<form:hidden path="ordrCp02"/>
								<form:hidden path="ordrCp03"/>
								<form:hidden path="ordrZipCd"/>
								<form:hidden path="ordrZipCd01"/>
								<form:hidden path="ordrZipCd02"/>
								<form:hidden path="ordrBsAddr"/>
								<form:hidden path="ordrDtlAddr"/>
								<form:hidden path="dlvSvcMemo"/>
								<form:hidden path="orderPay[0].payWay"/>
								<form:hidden path="orderPay[0].payAmt"/>
								<form:hidden path="orderPay[1].payWay"/>
								<form:hidden path="orderPay[1].payAmt"/>
								
								<div class="cart_order_area">
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>주문확인 테이블로 체크박스, 상품, 가격, 적립포인트, 삭제 항목을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">상품</th>
												<th scope="col">쿠폰</th>
												<th scope="col">가격</th>
												<th scope="col">적립포인트</th>
											</tr>
										</thead>
										<tbody>
										<c:set var="gdsIdx" value="0"/>
										<c:set var="totalExpPnt" value="0"/>
										<c:forEach items="${order.orderGoods}" varStatus="listCount" var="goods">
										<form:hidden path="orderGoods[${gdsIdx}].ubiGdsNo"/>
										<form:hidden path="orderGoods[${gdsIdx}].ubiGdsSize"/>
										<form:hidden path="orderGoods[${gdsIdx}].ubiGdsColorNm"/>
										<form:hidden path="orderGoods[${gdsIdx}].brnd"/>
										<form:hidden path="orderGoods[${gdsIdx}].ubiGdsNm"/>
										<form:hidden path="orderGoods[${gdsIdx}].slPrc"/>
										<form:hidden path="orderGoods[${gdsIdx}].ordQty"/>
										<c:set var="totalExpPnt" value="${totalExpPnt + goods.expPnt}"/>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">상품</div>
													<div class="tbl_cont clfix">
														<span class="p_img">
															<img src="<c:url value='${uploadImage}${goods.mainImg}'/>" width="76px">
														</span>
														<ul class="p_info">
															<li>[${goods.brnd }] ${goods.ubiGdsNm }</li>
															<li>Color = ${goods.ubiGdsColorNm } / SIZE = ${goods.ubiGdsSize }</li>
															<li>${goods.ubiGdsNo }</li>
														</ul>
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">쿠폰</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price">
															<fmt:formatNumber type="currency" value="${goods.cpnPayAmt==null?0:goods.cpnPayAmt }" pattern="###,###" />
														</span>
														<form:hidden path="orderGoods[${gdsIdx}].cpnNo"/>
														<form:hidden path="orderGoods[${gdsIdx}].offCpnNo"/>
														<form:hidden path="orderGoods[${gdsIdx}].cpnPayAmt"/>			
													</div>
												</td>												
												<td class="tbl_layout02">
													<div class="mobile_th">가격</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price"><fmt:formatNumber type="currency" value="${goods.slPrc - (goods.cpnPayAmt==null?0:goods.cpnPayAmt)}" pattern="###,###" /></span>
													</div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">적립포인트</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${goods.expPnt }" pattern="###,###" /></div>
												</td>
											</tr>
											<c:set var="gdsIdx" value="${gdsIdx+1 }"/>
										</c:forEach>
										</tbody>
									</table>
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>주문 정보 테이블로 총 가격, 포인트사용액, 배송비, 적립 예정포인트, 총 결제금액을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">총 가격</th>
												<th scope="col">포인트사용액</th>
												<th scope="col">배송비</th>
												<th scope="col">쿠폰 사용액</th>
												<th scope="col">적립 예정포인트</th>
												<th scope="col">총 결제금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">총 가격</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${totalSlAmt }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">포인트사용액</div>
													<div class="tbl_cont clfix">-<fmt:formatNumber type="currency" value="${order.orderPay[1].payAmt }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">배송비</div>
													<div class="tbl_cont">+<fmt:formatNumber type="currency" value="${order.totalDlvCst }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">쿠폰 사용액</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${order.totalCoupAmt}" pattern="###,###" /></div>
												</td>															
												<td class="tbl_layout04">
													<div class="mobile_th">적립 예정포인트</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${totalExpPnt }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout05">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont">
														<span class="ico_price"><fmt:formatNumber type="currency" value="${totalSlAmt + deliveryCost - order.orderPay[1].payAmt - order.totalCoupAmt}" pattern="###,###" /></span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="mypage_tit clfix space01">
										<span class="txt01">배송지 정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info04 floating">
												<li>
													<div class="tit">이름</div>
													<div class="desc">${order.ordrNm }</div>
												</li>
												<li>
													<div class="tit">전화번호</div>
													<div class="desc">${order.ordrTel01 }-${order.ordrTel02 }-${order.ordrTel03 }</div>
												</li>
												<li>
													<div class="tit">휴대폰번호</div>
													<div class="desc">${order.ordrCp01 }-${order.ordrCp02 }-${order.ordrCp03 }</div>
												</li>
												<li class="">
													<div class="tit">주소</div>
													<div class="desc">${order.ordrBsAddr } ${order.ordrDtlAddr }</div>
												</li>
												<li class="last_child">
													<div class="tit">배송시 
													</br>요청사항
													</div>
													<div class="desc">
														${order.dlvSvcMemo }
													</div>
												</li>												
											</ul>
											<ul class="mypage_info04 floating">
											</ul>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">결제수단</span>
										
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04">
												<li class="last_child">
													<div class="tit">결제선택</div>
													<div class="desc">
													<c:if test="${order.orderPay[0].payWay == 'OR00801'}">
														신용카드
													</c:if>
													<c:if test="${order.orderPay[0].payWay == 'OR00802'}">
														실시간계좌이체
													</c:if>
													<c:if test="${order.orderPay[0].payWay == 'OR00803'}">
														가상계좌
													</c:if>
													
													<c:if test="${order.orderPay[1].payAmt > 0}">
														+ 적립금
													</c:if>											
													</div>
												</li>
											</ul>
										</div>
									</div>
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
									<div class="btn_area04 clfix">
										<div class="btn01">
											<a href="<c:url value="/front/order/cartList" />" class="btn_gray01">뒤로</a>
										</div>
										<div class="btn02">
											<a href="javascript:void(0);" class="btn_black01" id="orderPay">다음</a>
										</div>
									</div>
								</div>
								</form:form>
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