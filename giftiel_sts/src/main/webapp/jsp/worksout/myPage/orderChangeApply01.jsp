<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderChangeApply01.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-28
 *
 * 파일 내용 : 01.교환정보 및 사유
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
			
			//전체선택
			$("#all_check").click(function(){
		        var chk = $(this).is(":checked");
		        if(chk) $("input[name$='ordGdsSeq']").prop('checked', true);
		        else  $("input[name$='ordGdsSeq']").prop('checked', false);
		    });
			
			
			
			//교환신청 다음단계
   			$("#nextStep").on("click",function(e) {
   				e.preventDefault();
   				
   				var frm = document.clmForm;
   				if(!formCheck(frm)) return false; 
   				
   				var form = document.clmForm;
   				form.action = "<c:url value='/front/myPage/${nextPage}'/>";
   				form.submit();
		    });
			
			
   			
   			//교환사유선택
   			$("input[id$='clmRsnCd']").val($("#reason option:selected").val());
   			$("#reason").on("change" , function(e){
   				var $target = $(e.currentTarget);
   				
   				$("input[id$='clmRsnCd']").val($target.val());
   			});
   			
   			//상세사유 입력 
   			$("#reason_detail").on("blur" , function(e){
   				var $target = $(e.currentTarget);
   				
   				$("input[id$='clmTxt']").val($target.val());
   			});
   			
   			
   			
   			//반품 여부 확인 선택
   			$("input[name='send']").on("click", function(e){
   				var $target = $(e.currentTarget);
   				var element = $(".info_cont02");
   				element.toggle();
   				if($("input[name='send']:checked").attr("id") == "yes" ){
   					$("input[id$='dlvCmpNo']").val($("#dlvCmp option:selected").val());
   				}else{
   					$("input[id$='dlvCmpNo']").val("");
   				}
   				
   			});
   			
   			
   			//택배사 선택
   			
   			$("#dlvCmp").on("change" , function(e){
   				var $target = $(e.currentTarget);
   				
   				$("input[id$='dlvCmpNo']").val($target.val());
   			});
   			
   			
   			
   			
   			//운송장 번호 입력
   			$("#delivery_num").on("blur" , function(e){
   				var $target = $(e.currentTarget);
   				
   				$("input[id$='invNo']").val($target.val());
   			});
   			
   			
   			function formCheck(frm){
   				if($("input[name$='ordGdsSeq']").is(":checked") == false){
   					alert("교환할 상품을 선택해 주세요");
   					return false;
   				}
   				
   				if($("#reason_detail").val() == ""){
   					alert("상세사유를 입력해 주세요");
   					return false;
   				}
   				
   				
/*    				if($("input[name='send']:checked").attr("id") == "yes" ){
   					if($("#delivery_num").val()==""){
   						alert("운송장번호를 입력하세요");
   						return false;
   					}
   				} */
   				
   				
   				return true;
   			}
   			
   			
			
   			
   			
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
					<form:form id="clmForm" name="clmForm" method="post" modelAttribute="clmForm" onsubmit="">
							<form:hidden path="ordNo" id="ordNo"/>
							<form:hidden path="clmTp" id="clmTp"/>
							<form:hidden path="clmStat" id="clmStat"/>
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">교환신청</a>
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
								<div class="content_top">
									<div class="content_menu03 clfix">
										<span class="cont_tit">교환신청</span>
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#" class="on">
												<span class="txt">교환정보 및 사유</span>
											</a>
											<a href="#">
												<span class="txt">배송자정보</span>
											</a>
											<a href="#" class="last_child">
												<span class="txt">신청완료</span>
											</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
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
										<span class="txt01">교환 정보</span>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>교환정보 테이블로 번호, 상품, 가격 을 확인 할 수 있습니다</caption>
										<thead>
											<tr>
												<th scope="col">
													<span class="input_check">
														<input type="checkbox" id="all_check" name="all_check">
													</span>
												</th>
												<th scope="col">상품</th>
												<th scope="col">가격</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="cnt" value="-1"/>
											<c:forEach var="good" items="${order.orderGoods}" varStatus="goodIndex">
												<c:if test="${good.perOrdStat eq 'OR00505'}"><!-- 배송완료 상품만 교환신청가능 -->
												<c:set var="cnt" value="${cnt+1}"/>
												<tr>
													<td class="tbl_layout_util01">
														<div class="tbl_cont">
															<span class="input_check">
																<form:checkbox path="orderClmGds[${cnt}].ordGdsSeq" value="${good.ordGdsSeq}"/>
																<form:hidden path="orderClmGds[${cnt}].clmGdsStat" value="OR01901"/>
																<form:hidden path="orderClmGds[${cnt}].clmRsnCd"/>
																<form:hidden path="orderClmGds[${cnt}].clmTxt"/>
																<form:hidden path="orderClmGds[${cnt}].dlvCmpNo"/>
																<form:hidden path="orderClmGds[${cnt}].invNo"/>
															</span>
														</div>
													</td>
													<td class="tbl_layout01 product_in_img">
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
												</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
									<div class="mypage_tit clfix space01">
										<span class="txt01">교환 사유</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info06 clfix">
												<li>
													<div class="tit">
														<label for="reason">교환사유 선택</label>
													</div>
													<div class="desc">
														<span class="input_select">
															<select id="reason">
															<c:forEach var="clmRsn" items="${clmRsnCdList}" varStatus="goodIndex">
																<option value="${clmRsn.cdNo}">${clmRsn.cdNm}</option>
															</c:forEach>
															</select>
														</span>
													</div>
												</li>
												<li>
													<div class="tit">
														<label for="reason_detail">상세사유 입력</label>
													</div>
													<div class="desc">
														<span class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="text" id="reason_detail" name="reason_detail" placeholder="상세사유 (최대 100자)" onkeyup="chkLen(this,100);">
														</span>
													</div>
												</li>
											</ul>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">반품 여부 확인</span>
									</div>
									<div class="box_gray01 clfix" style="display:none;">
										<div class="clfix">
											<ul class="mypage_info08 clfix">
												<li>
													<div class="info_cont01">
														<div class="select_txt">
															<label for="yes" class="bu_dot">상품을 판매자에게 보내셨습니까?</label>
														</div>
														<div class="select_form">
															<span class="input_radio">
																<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																<input type="radio" id="yes" name="send">
															</span>
															<label for="yes">예</label>
															<span class="input_radio last_radio">
																<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																<input type="radio" id="no" name="send" checked="checked">
															</span>
															<label for="no">아니오</label>
														</div>
														<div class="select_txt02">- 반품 수거의 경우 배송 받았언 택배사만 이용 가능합니다.</div>
													</div>
												</li>
												<li>
													
													<div class="info_cont02 clfix">
														<div class="select_txt">
															<label for="yes" class="bu_dot">반품수거정보</label>
														</div>
														<ul class="select_txt02">
															<li>${order.rcpnNm}</li>
															<li>${order.rcpnTelNo} / ${order.rcpnCpNo}</li>
															<li>${order.rcpnBsAddr} ${order.rcpnDtlAddr}</li>
															<li class="style01">- 주문시 입력한 배송지 주소로 택배기사님이 1~3일 이내 방문할 예정입니다.</li>
														</ul>
													</div>
													
													<div class="info_cont02" style="display: none;">
														<span class="input_select">
															<select id="dlvCmp">
															<c:forEach var="dlvCmp" items="${dlvCmpList}" varStatus="dlvIndex">
																<option value="${dlvCmp.dlvCmpNo}">${dlvCmp.dlvCmpNm}</option>
															</c:forEach>
															</select>
														</span>
														<span class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="text" id="delivery_num" name="delivery_num" placeholder="운송장 번호를 입력하세요">
														</span>
													</div>
													
													
												</li>
											</ul>
										</div>
									</div>
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>교환신청 테이블로 배송비, 총 결제금액 을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">배송비</th>
												<th scope="col">총 결제금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
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
												<td class="tbl_layout01">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${order.totalPayAmt}" pattern="###,###" /></div>
												</td>
											</tr>
										</tbody>
									</table>
									<!-- 상황 1 -->
<!-- 									<div class="mypage_content_layout02"> -->
<!-- 										<ul class="change_notice"> -->
<!-- 											<li class="notice_tit">왕복 배송비 6,000원을 박스에 동봉해 주세요.</li> -->
<!-- 											<li class="notice_txt">- 선불로 배송비를 결제했을 경우, 배송비 차감 없이 결제금액을 환불 해드립니다.</li> -->
<!-- 											<li class="notice_txt">- 다만 판매자 확인 후 환불금액 및 환불차감액이 변경될 수 있으니 꼭 확인 후 요청해 주세요.</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 									상황 2 -->
<!-- 									<div class="mypage_content_layout02"> -->
<!-- 										<ul class="change_notice"> -->
<!-- 											<li class="notice_tit">차감될 배송비가 없습니다.</li> -->
<!-- 											<li class="notice_txt">- 다만 판매자 확인 후 환불금액 및 환불차감액이 변경될 수 있으니 꼭 확인 후 요청해 주세요.</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
									<div class="btn_area04 clfix">
										<div class="btn01">
											<a href="#" class="btn_black01" id="nextStep">다음</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
					</form:form>
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