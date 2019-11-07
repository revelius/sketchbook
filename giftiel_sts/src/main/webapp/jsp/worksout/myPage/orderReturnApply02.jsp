<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderReturnApply02.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-28
 *
 * 파일 내용 : 02.결제/환불 정보
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
    			
    			//반품신청 다음단계
	   			$("#nextStep").on("click",function(e) {
	   				e.preventDefault();
	   				
	   				if(!confirm("반품 신청 하시겠습니까?")) return false;
	   				
	   				var frm = document.clmForm;
	   				if(!formCheck(frm)) return false; 
	   				
	   			    $.ajax({
	   				url : "<c:url value='/front/myPage/${procPage}'/>",
	   				type: "post",
	   				data : $("form#clmForm").serialize(),
	   				async: true,
	   				success : function(res){
	   				    if (res > 0) {
	   				    		location.href="<c:url value='/front/myPage/${nextPage}'/>";
	   						} else {
	   							alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
	   						}
	   				},
	   				error:function(request,status,error){
	   				    alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	   				}
	   			    });
    		    });
    			
    			
    			
	   			function formCheck(frm){
	   				if($("#rfndAcctNo").val() == ""){
	   					alert("계좌번호를 입력해 주세요");
	   					//return false;
	   				}
	   				
	   				if($("#rfndAcctOwn").val() == ""){
	   					alert("예금주를 입력해 주세요");
	   					//return false;
	   				}
	   				
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
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">반품신청</a>
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
										<span class="cont_tit">반품신청</span>
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">반품정보 및 사유</span>
											</a>
											<a href="#" class="on">
												<span class="txt">결제/환불정보</span>
											</a>
											<a href="#" class="last_child">
												<span class="txt">신청완료</span>
											</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="mypage_tit clfix">
										<span class="txt01">결제정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00803'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">가상계좌 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">${order.orderPay[0].orderPayVrtl[0].bankname} ${order.orderPay[0].orderPayVrtl[0].account}</div>
												</li>
												<li>
													<div class="tit">예금주명</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00802'}">style="display: none;"</c:if>>
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">계좌이체 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">${order.orderPay[0].orderPayRtm[0].bankName}</div>
												</li>
												<li>
													<div class="tit">입금자명</div>
													<div class="desc">${order.ordrNm}</div>
												</li>
												<li>
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00801'}">style="display: none;"</c:if>>	
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">신용카드 <c:if test="${order.orderPay[1].payAmt > 0}">+ 적립금</c:if></div>
												</li>
												<li>
													<div class="tit">카드명</div>
													<div class="desc">${order.orderPay[0].orderPayCrd[0].cardName}</div>
												</li>
<!-- 												<li> -->
<!-- 													<div class="tit">카드번호</div> -->
<%-- 													<div class="desc">${order.orderPay[0].orderPayCrd[0].cardNo}</div> --%>
<!-- 												</li> -->
												<li class="last_child">
													<div class="tit">결제일</div>
													<div class="desc"><fmt:formatDate value="${order.payCmplDts}" pattern="yyyy-MM-dd HH:mm"/></div>
												</li>
											</ul>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">환불정보</span>
									</div>
									
									<form:form id="clmForm" name="clmForm" method="post" modelAttribute="clmForm" onsubmit="">
										<form:hidden path="ordNo" id="ordNo"/>
										<form:hidden path="clmTp" id="clmTp"/>
										<form:hidden path="clmStat" id="clmStat"/>
										
										<c:set var="count" value="-1"/>
										<c:forEach var="good" items="${clmForm.orderClmGds}" varStatus="goodIndex">
												<c:set var="count" value="${count+1 }"/>
												<form:hidden path="orderClmGds[${count}].ordGdsSeq"/>
												<form:hidden path="orderClmGds[${count}].clmGdsStat"/>
												<form:hidden path="orderClmGds[${count}].clmRsnCd"/>
												<form:hidden path="orderClmGds[${count}].clmTxt"/>
												<form:hidden path="orderClmGds[${count}].dlvCmpNo"/>
												<form:hidden path="orderClmGds[${count}].invNo"/>
										</c:forEach>
										
										
									<div class="box_gray01 clfix">
										<div class="box01 clfix">
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay !='OR00801'}">style="display: none;"</c:if>>
												<li class="last_child">
													<div class="tit">환불상태</div>
													<div class="desc">카드취소</div>
												</li>
											</ul>
											
											
											<ul class="mypage_info04" <c:if test="${order.orderPay[0].payWay =='OR00801'}">style="display: none;"</c:if>>
												<li class="last_child">
													<div class="tit">은행명</div>
													<div class="desc">
														<form:select path="rfndBnkCd" id="rfndBnkCd" items="${bankList}" itemLabel="cdNm" itemValue="cdNo">
														</form:select>
													</div>
												</li>
												<li class="last_child">
													<div class="tit">계좌번호</div>
													<div class="desc"><form:input path="rfndAcctNo" id="rfndAcctNo"/></div>
												</li>
												<li class="last_child">
													<div class="tit">예금주</div>
													<div class="desc"><form:input path="rfndAcctOwn" id="rfndAcctOwn"/></div>
												</li>
											</ul>
										</div>
									</div>
									</form:form>
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