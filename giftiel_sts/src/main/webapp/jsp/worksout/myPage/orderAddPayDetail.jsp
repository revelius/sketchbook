<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderAddPayDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-15
 *
 * 파일 내용 : 추가결제 상세
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
    			
    			//우체국 배송조회
	   			$("a[data-btn='btn_delivery']").on("click",function(e) {
	   				e.preventDefault();
	   				var $target = $(e.currentTarget);
	   				var invNo = $target.attr("data-invNo");
    				openDlvPop(invNo);
    		    });
    			
    			
    			//주문서 출력
    			openOrderPrint = function() {
    				var popUrl = "<c:url value='/front/myPage/popUpOrderPrint?orderNo=${order.ordNo}'/>";	//팝업창에 출력될 페이지 URL
    				var popOption = "width=1270, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
    					window.open(popUrl,"",popOption);
    			};
    			
    			
    			
    		});
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
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">ORDER DETAIL</a>
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
									<div class="mypage_tit clfix space03">
										<span class="txt01">추가결제 내역</span>
									</div>
									<div class="order_detail_info01 clfix">
										<dl class="info_item01 clfix">
											<dt>주문번호
												<span class="bu">:</span>
											</dt>
											<dd>${order.ordNo}</dd>
										</dl>
										<dl class="info_item02 clfix">
											<dt>주문일시
												<span class="bu">:</span>
											</dt>
											<dd><fmt:formatDate value="${order.ordDts}" pattern="yyyy-MM-dd HH:mm"/></dd>
										</dl>
									</div>
									
									
									
									
									
									
									
									<div class="mypage_tit clfix space01">
										<span class="txt01">추가결제</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04">
												<li>
													<div class="tit">상품</div>
													<div class="desc">[${orderGoods.brand}]  ${orderGoods.ubiGdsNm}</div>
												</li>
												<li>
													<div class="tit">구분</div>
													<div class="desc">${order.orderAddPay[0].addPayRsn}</div>
												</li>
												<li>
													<div class="tit">금액</div>
													<div class="desc"><fmt:formatNumber type="currency" value="${order.orderAddPay[0].addPayAmt }" pattern="###,###" /></div>
												</li>
												<li class="last_child">
													<div class="tit">결제수단</div>
													<div class="desc">계좌이체</div>
												</li>
												<li class="last_child">
													<div class="tit">입금자명</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
											</ul>
										</div>
									</div>
									
									
									
									
									
									
									
									
									
									
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
									<div class="btn_area04 clfix">
										<div class="btn02">
											<a href="<c:url value="/front/myPage/orderAddPayList"/>" class="btn_gray01">목록보기</a>
										</div>
									</div>
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
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