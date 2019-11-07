<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderCancelDetail.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-15
 *
 * 파일 내용 : 취소/반품 상세
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
    			
    			
    			//반품취소
    			$("#returnCancel").on("click",function(e){
    				e.preventDefault();
    				
    				if(!confirm("반품신청을 취소하시겠습니까?")) return false;
    				
    				$.ajax({
    	   		        url : "<c:url value='/front/myPage/claimCancelAjax'/>",
    	   		        type: "post",
    	   		        data : $("form#hiddenForm").serialize(),
    	   		    	async: true,
    	   		        success : function(res){
    	   		            if (res > 0) {
    	   		            	alert("반품 신청이 취소 되었습니다.");
    	   		            	location.href="<c:url value='/front/myPage/orderCancelList'/>";
    	   					} else {
    	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
    	   					}
    	   		        },
    	   		        error:function(request,status,error){
    	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
    	   		        }
    	   		    });
    			});
    			
    			
    			
    		});
   		</script>
		
		
	</head>
	<form id="hiddenForm" name="hiddenForm" method="post" >
		<input type="hidden" name="hiddenOrderNo"    id="hiddenOrderNo"    value="${orderclm.ordNo}"/>
		<input type="hidden" name="hiddenOrdGdsSeq"  id="hiddenOrdGdsSeq"  value="${orderclm.orderClmGds[0].ordGdsSeq}"/>
		<input type="hidden" name="hiddenClmNo"      id="hiddenClmNo"      value="${orderclm.clmNo}"/>
		<input type="hidden" name="hiddenClmGdsSeq"  id="hiddenClmGdsSeq"  value="${orderclm.orderClmGds[0].clmGdsSeq}"/>
	</form>
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
										<span class="txt01">취소/반품 내역</span>
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
									<div class="mypage_tit clfix space02">
										<span class="txt01">주문정보</span>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>주문정보 테이블로 상품, 가격, 적립포인트, 상태를 확인 할 수 있습니다</caption>
										<thead>
											<tr>
												<th scope="col">NO</th>
												<th scope="col">상품</th>
												<th scope="col">가격</th>
												<th scope="col">적립포인트</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="cnt" value="0"/>
											<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
												<c:if test="${good.ordGdsSeq eq ordGdsSeq}">
												<c:set var="cnt" value="${cnt+1}"/>
												<tr>
													<td class="tbl_layout_no">
														<div class="mobile_th">NO</div>
														<div class="tbl_cont">${cnt}</div>
													</td>
													<td class="tbl_layout01 product_in_img02">
														<div class="mobile_th">상품</div>
														<div class="tbl_cont clfix">
															<a href="#" class="p_img">
																<img src="<c:url value="${uploadImage}${good.mainImg}"/>" alt="관리자에서 등록될 수 있도록 개발필요." style="width: 50px;height: 50px;">
															</a>
															<ul class="p_info">
																<li>[${good.brand}] ${good.ubiGdsNm}</li>
																<li>Color = ${good.ubiGdsColorNm} / Size = ${good.ubiGdsSize}</li>
																<li>${good.ubiGdsNo}</li>
															</ul>
														</div>
													</td>
													<td class="tbl_layout02">
														<div class="mobile_th">가격</div>
														<div class="tbl_cont">
															<span class="ico_price">${good.slPrc}</span>
														</div>
													</td>
													<td class="tbl_layout03">
														<div class="mobile_th">적립포인트</div>
														<div class="tbl_cont">${good.expPnt}</div>
													</td>
													<td class="tbl_layout04">
														<div class="mobile_th">상태</div>
														<div class="tbl_cont">
															<span class="state">${good.perOrdStatNm}</span>
														</div>
													</td>
												</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
									
									
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>주문 정보 테이블로 총 가격, 포인트사용액, 배송비, 적립 예정포인트, 총 결제금액을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">총 결제금액</th>
												<th scope="col">환불예정금액</th>
												<th scope="col">사용 포인트 반환</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${order.totalSlAmt + order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout05">
													<div class="mobile_th">환불예정금액</div>
													<div class="tbl_cont">
													<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
														<c:if test="${good.ordGdsSeq eq ordGdsSeq}">
															<span class="ico_price"><fmt:formatNumber type="currency" value="${good.actlPayPrc + order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" /></span>
														</c:if>
													</c:forEach>
													</div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">사용 포인트 반환</div>
													<div class="tbl_cont">
													<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
														<c:if test="${good.ordGdsSeq eq ordGdsSeq}">
															<fmt:formatNumber type="currency" value="${good.slPrc - good.actlPayPrc}" pattern="###,###" />
														</c:if>
													</c:forEach>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<p class="mypage_txt_style02">- 포인트 적립율 변동 시, 기간별 적립 포인트가 상이할 수 있습니다.</p>
									<div class="mypage_tit clfix space01">
										<span class="txt01">주문자정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info04 floating">
												<li>
													<div class="tit">이름</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">전화번호</div>
													<div class="desc">${order.ordrTel}</div>
												</li>
												<li>
													<div class="tit">휴대폰번호</div>
													<div class="desc">${order.ordrCp}</div>
												</li>
												<li class="last_child">
													<div class="tit">주소</div>
													<div class="desc">${order.ordrBsAddr} ${order.ordrDtlAddr}</div>
												</li>
											</ul>
											<ul class="mypage_info04 floating">
												<li class="last_child">
													<div class="tit">배송시
														<br> 요청사항
													</div>
													<div class="desc">${order.dlvSvcMemo}
													</div>
												</li>
											</ul>
										</div>
									</div>
									
									
<!-- 									<div class="mypage_tit clfix space01"> -->
<!-- 										<span class="txt01">반품사유</span> -->
<!-- 									</div> -->
									
<!-- 									<div class="box_gray01 clfix"> -->
<!-- 										<div class="box01 clfix"> -->
<!-- 											<ul class="mypage_info04"> -->
<!-- 												<li class="etc_style01"> -->
<%-- 													<div class="tit02">${orderclm.orderClmGds[0].clmRsnNm} /${orderclm.orderClmGds[0].clmTxt}</div> --%>
<!-- 												</li> -->
<!-- 											</ul> -->
<!-- 										</div> -->
<!-- 									</div> -->
									
									
<!-- 									<div class="mypage_tit clfix space01"> -->
<!-- 										<span class="txt01">반품여부 확인</span> -->
<!-- 									</div> -->
									
<%-- 									<c:choose> --%>
<%-- 									<c:when test="${orderclm.orderClmGds[0].invNo ne null}"> --%>
<!-- 										<div class="box_gray01 clfix"> -->
<!-- 											<div class="box01 clfix"> -->
<!-- 												<ul class="mypage_info04"> -->
<!-- 													<li class="last_child"> -->
<!-- 														<div class="tit">직접반송</div> -->
<%-- 														<div class="desc">${orderclm.orderClmGds[0].dlvCmpNm} / ${orderclm.orderClmGds[0].invNo}</div> --%>
<!-- 													</li> -->
<!-- 												</ul> -->
<!-- 											</div> -->
<!-- 										</div> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<div class="box_gray01 clfix"> -->
<!-- 											<div class="box01 clfix"> -->
<!-- 												<ul class="mypage_info04"> -->
<!-- 													<li class="etc_style01"> -->
<!-- 														<div class="tit02 point">지정업체수거</div> -->
<!-- 													</li> -->
<!-- 													<li class="last_child etc_style02"> -->
<!-- 														<div class="tit">반품수거정보</div> -->
<%-- 														<div class="desc">${order.rcpnNm} / ${order.rcpnTelNo} / ${order.rcpnCpNo} --%>
<%-- 															<br> ${order.rcpnBsAddr} ${order.rcpnDtlAddr}</div> --%>
<!-- 													</li> -->
<!-- 												</ul> -->
<!-- 											</div> -->
<!-- 										</div> -->
<%-- 									</c:otherwise> --%>
<%-- 									</c:choose> --%>
									
										
<!-- 									배송비 자동 차감 기능은 협의중 -->
<!-- 									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01"> -->
<!-- 										<caption>취소/반품내역 테이블로 총 결제금액, 환불차감예정금액, 환불예정금액, 사용 포인트 반환 을 확인 할 수 있습니다.</caption> -->
<!-- 										<thead> -->
<!-- 											<tr> -->
<!-- 												<th scope="col">총 결제금액</th> -->
<!-- 												<th scope="col">환불차감예정급액</th> -->
<!-- 												<th scope="col">환불예정금액</th> -->
<!-- 												<th scope="col">사용 포인트 반환</th> -->
<!-- 											</tr> -->
<!-- 										</thead> -->
<!-- 										<tbody> -->
<!-- 											<tr> -->
<!-- 												<td class="tbl_layout06"> -->
<!-- 													<div class="mobile_th">총 결제금액</div> -->
<!-- 													<div class="tbl_cont">95,000</div> -->
<!-- 												</td> -->
<!-- 												<td class="tbl_layout06"> -->
<!-- 													<div class="mobile_th">환불차감예정급액</div> -->
<!-- 													<div class="tbl_cont"> -->
<!-- 														<span class="ico_price">180,000</span> -->
<!-- 													</div> -->
<!-- 												</td> -->
<!-- 												<td class="tbl_layout06"> -->
<!-- 													<div class="mobile_th"> -->
<!-- 														<span class="ico_price">환불예정금액</span> -->
<!-- 													</div> -->
<!-- 													<div class="tbl_cont"> -->
<!-- 														<span class="ico_price">180,000</span> -->
<!-- 													</div> -->
<!-- 												</td> -->
<!-- 												<td class="tbl_layout06"> -->
<!-- 													<div class="mobile_th">사용 포인트 반환</div> -->
<!-- 													<div class="tbl_cont"> -->
<!-- 														<span class="point">0</span> -->
<!-- 													</div> -->
<!-- 												</td> -->
<!-- 											</tr> -->
<!-- 										</tbody> -->
<!-- 									</table> -->
									
									
									<div class="mypage_tit clfix space01">
										<span class="txt01">결제정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00803'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">&nbsp;가상계좌 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">${order.orderPay[0].orderPayVrtl[0].bankname} ${order.orderPay[0].orderPayVrtl[0].account}</div>
												</li>
												<li>
													<div class="tit">예금주명</div>
													<div class="desc">&nbsp;${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc">&nbsp;<fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00802'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">&nbsp;계좌이체 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">${order.orderPay[0].orderPayRtm[0].bankName} </div>
												</li>
												<li>
													<div class="tit">입금자명</div>
													<div class="desc">&nbsp;${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc">&nbsp;<fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00801'}">style="display: none;"</c:if>>	
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">&nbsp;신용카드 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">카드명</div>
													<div class="desc">&nbsp;${order.orderPay[0].orderPayCrd[0].cardName}</div>
												</li>
<!-- 												<li> -->
<!-- 													<div class="tit">카드번호</div> -->
<%-- 													<div class="desc">${order.orderPay[0].orderPayCrd[0].cardNo}</div> --%>
<!-- 												</li> -->
												<li class="last_child">
													<div class="tit">결제일</div>
													<div class="desc">&nbsp;<fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
										</div>
									</div>
									
									
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>취소/반품내역 테이블로 총 가격, 포인트사용액, 배송비, 적립 예정포인트, 총 결제금액을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">총 가격</th>
												<th scope="col">배송비</th>
												<th scope="col">포인트사용액</th>
												<th scope="col">총 결제금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">총 가격</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${order.totalSlAmt}" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">배송비</div>
													<div class="tbl_cont">
														<c:choose>
														<c:when test="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst != ''}">
															+
															<fmt:formatNumber type="currency" value="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" />
														</c:when>
														<c:otherwise>
															+ 0
														</c:otherwise>	
														</c:choose>		
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">포인트사용액</div>
													<div class="tbl_cont clfix"><c:if test="${fn:length(order.orderPay) > 0}"><fmt:formatNumber type="currency" value="${order.totalPayAmt - order.totalSlAmt}" pattern="###,###" /></c:if></div>
												</td>
												<td class="tbl_layout05">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont">
														<span class="ico_price"><fmt:formatNumber type="currency" value="${order.totalSlAmt + order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" /></span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="mypage_tit clfix space01">
										<span class="txt01">환불정보</span>
									</div>
									
									
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04">
												<li>
													<div class="tit">은행명</div>
													<div class="desc">&nbsp;${orderclm.rfndBnkNm}</div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">&nbsp;${orderclm.rfndAcctNo}</div>
												</li>
												<li class="last_child">
													<div class="tit">예금주</div>
													<div class="desc">&nbsp;${orderclm.rfndAcctOwn}</div>
												</li>
											</ul>
										</div>
									</div>
									
									
									<div class="btn_area04 clfix">
										<div class="btn01" <c:if test="${orderclm.clmStat ne 'OR01701'}">style="display: none;"</c:if>>
											<a href="#" data-template="ui_popup_cancel_confirm" data-callback="callback_test01" class="btn_black01 ui_btn_popup" id="returnCancel">반품취소</a>
										</div>
										<div class="btn02">
											<a href="<c:url value="/front/myPage/orderCancelList"/>" class="btn_gray01">목록보기</a>
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