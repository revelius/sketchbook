<%--
 * =============================================================================
 * 파일명 : /order/orderDetail.jsp
 * 작성자 : 박필종
 * 작성일자 : 2015-05-07
 *
 * 파일 내용 : 주문매출관리 > 전체주문 상세
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
			//상품상세 이동
		    gotoOrderPopup = function(ordNo) {
		    	
				var popUrl = "<c:url value='/admin/order/popupOrder'/>";	//팝업창에 출력될 페이지 URL
				var param = "?ordNo="+ordNo;
				var popOption = "width=900, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl+param,"",popOption);
					
		    };		
		    
	 	
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
					<jsp:param name="onChk" value="orderDetail"/>
				</jsp:include>
				<!--[e] lnb -->

			
				<!--[s] contents -->
				<div class="contents">
					<!--[s] 기본정보 -->
					<div class="section a1">
						<div class="tableTitle"><span class="icon2"></span>총 5건의 주문이 조회되었습니다. <span class="right"><a href="#" class="btnType2">상품추가</a></span></div>			
						<div class="tableType1">
							<table>
								<caption>주문내역상세</caption>
								<colgroup>
									<col width="5%" />
									<col width="8%" />
									<col width="*" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="8%" />
									<col width="17%" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>브랜드</th>
										<th>주문번호</th>
										<th>주문일시</th>
										<th>총판매가</th>
										<th>배송비</th>
										<th>포인트사용</th>
										<th>결제금액</th>
										<th>이름</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>nn</td>
										<td>브랜드</td>
										<td>ORDERNUMBER <br> <a href="#" class="btnType1">상세정보</a></td>
										<td>YYYY.MM.DD <br> HH:MM:SS</td>
										<td>#,###,### 원</td>
										<td>#,### 원</td>
										<td>#,### 원</td>
										<td>#,###,### 원</td>
										<td>주문자</td>
										<td>결제대기 <br><a href="#" class="btnType1">입금확인</a> <a href="#" class="btnType1">주문취소</a></td>
									</tr>
									<tr>
										<th colspan="2">결제정보</th>
										<td colspan="8" class="tl">[입금 확인], YYYY.MM.DD  HH:MM:SS,<strong>계좌이체</strong>, #,###,###원(할인명:#,###,###원)</td>
									</tr>
									<tr>
										<th colspan="2">수령인</th>
										<td colspan="8" class="tl">수령인명, 배송지 주소, [수령인 전화번호, 휴대폰번호], 배송시 요청사항</td>
									</tr>
								</tbody>
							</table>
							<div class="btn">
								<div class="right">
									<a href="#" class="btnType2">선택배송</a>
									<a href="#" class="btnType2">선택취소</a>
								</div>
							</div>
						</div>
						<div class="tableType1 first">
							<table>
								<caption>주문내역상세</caption>
								<colgroup>
									<col width="5%" />
									<col width="8%" />
									<col width="*" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="8%" />
									<col width="17%" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>브랜드</th>
										<th>주문번호</th>
										<th>주문일시</th>
										<th>총판매가</th>
										<th>배송비</th>
										<th>포인트사용</th>
										<th>결제금액</th>
										<th>이름</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>nn</td>
										<td>브랜드</td>
										<td>ORDERNUMBER <br> <a href="#" class="btnType1">상세정보</a></td>
										<td>YYYY.MM.DD <br> HH:MM:SS</td>
										<td>#,###,### 원</td>
										<td>#,### 원</td>
										<td>#,### 원</td>
										<td>#,###,### 원</td>
										<td>주문자</td>
										<td>결제대기 <br><a href="#" class="btnType1">배송준비</a> <a href="#" class="btnType1">주문취소</a></td>
									</tr>
									<tr>
										<th colspan="2">결제정보</th>
										<td colspan="8" class="tl">
											[입금 확인], YYYY.MM.DD  HH:MM:SS,<strong>계좌이체</strong>, #,###,###원(할인명:#,###,###원) <br>
											[입금 확인], YYYY.MM.DD  HH:MM:SS,<strong>가상계좌</strong>, [은행명], [계좌번호], [입금자명] #,###,###원 <br>
											[입금 확인], YYYY.MM.DD  HH:MM:SS, <strong>신용카드</strong>, [카드사], #,###,###원
										</td>
									</tr>
									<tr>
										<th colspan="2">수령인</th>
										<td colspan="8" class="tl">수령인명, 배송지 주소, [수령인 전화번호, 휴대폰번호], 배송시 요청사항</td>
									</tr>
								</tbody>
							</table>
							<div class="btn">
								<div class="right">
									<a href="#" class="btnType2">선택배송</a>
									<a href="#" class="btnType2">선택취소</a>
								</div>
							</div>
						</div>
						<div class="tableType1 first">
							<table>
								<caption>주문내역상세</caption>
								<colgroup>
									<col width="5%" />
									<col width="8%" />
									<col width="*" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="10%" />
									<col width="8%" />
									<col width="17%" />
								</colgroup>
								<thead>
									<tr>
										<th>NO</th>
										<th>브랜드</th>
										<th>주문번호</th>
										<th>주문일시</th>
										<th>총판매가</th>
										<th>배송비</th>
										<th>포인트사용</th>
										<th>결제금액</th>
										<th>이름</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>nn</td>
										<td>브랜드</td>
										<td>ORDERNUMBER <br> <a href="#" class="btnType1">상세정보</a></td>
										<td>YYYY.MM.DD <br> HH:MM:SS</td>
										<td>#,###,### 원</td>
										<td>#,### 원</td>
										<td>#,### 원</td>
										<td>#,###,### 원</td>
										<td>주문자</td>
										<td>
											배송준비 <br>
											출고지연 <br>
											취소진행 <br>
											주문취소 <br>
											배송중 <br>
											배송완료 <br>
											교환신청 <br>
											교환진행 <br>
											교환완료 <br>
											교환불가 <br>
											반품신청 <br>
											반품진행 <br>
											반품완료 <br>
											반품불가

										</td>
									</tr>
									<tr>
										<th colspan="2">결제정보</th>
										<td colspan="8" class="tl">
											[입금 확인], YYYY.MM.DD  HH:MM:SS,<strong>계좌이체</strong>, #,###,###원(할인명:#,###,###원) <br>
											[입금 확인], YYYY.MM.DD  HH:MM:SS,<strong>가상계좌</strong>, [은행명], [계좌번호], [입금자명] #,###,###원 <br>
											[입금 확인], YYYY.MM.DD  HH:MM:SS, <strong>신용카드</strong>, [카드사], #,###,###원
										</td>
									</tr>
									<tr>
										<th colspan="2">수령인</th>
										<td colspan="8" class="tl">수령인명, 배송지 주소, [수령인 전화번호, 휴대폰번호], 배송시 요청사항</td>
									</tr>
								</tbody>
							</table>
							<div class="btn">
								<div class="right">
									<a href="#" class="btnType2">선택배송</a>
									<a href="#" class="btnType2">선택취소</a>
								</div>
							</div>
						</div>
					</div>
					<!--[e] 기본정보 -->
					<!--[s] 주문정보 -->
					<div class="section a2">		
						<div class="tableType1">
							<table>
								<caption>주문내역상세</caption>
								<colgroup>
									<col width="5%" />
									<col width="*" />
									<col width="5%" />
									<col width="10%" />
									<col width="10%" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" /></th>
										<th>상품</th>
										<th>수량</th>
										<th>공급가</th>
										<th>판매가</th>
										<th>개별 상품상태</th>
										<th>배송상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>결제대기 <br> <a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>결제완료 <br> <a href="#" class="btnType1">배송준비</a><a href="#" class="btnType1">출고지연</a><a href="#" class="btnType1">배송중</a><a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>배송준비 <br> <a href="#" class="btnType1">출고지연</a><a href="#" class="btnType1">배송중</a><a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>출고지연 <br> <a href="#" class="btnType1">배송준비</a><a href="#" class="btnType1">배송중</a><a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>배송중 <br> <a href="#" class="btnType1">배송중</a><a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>배송완료 <br> <a href="#" class="btnType1">배송준비</a><a href="#" class="btnType1">출고지연</a><a href="#" class="btnType1">배송중</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>교환신청 <br> <a href="#" class="btnType1">상품변경</a><a href="#" class="btnType1">교환불가</a><a href="#" class="btnType1">교환신청</a></td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<!-- 상품변경 클릭시 나타남 -->
									<tr>
										<td></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td></td>
										<td></td>
										<td></td>
										<td>교환신청 <br> <a href="#" class="btnType1">상품변경</a><a href="#" class="btnType1">교환불가</a><a href="#" class="btnType1">교환신청</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<!-- //상품변경 클릭시 나타남 -->
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>교환진행 <br> <a href="#" class="btnType1">배송추적</a><a href="#" class="btnType1">교환완료</a></td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>교환완료 <br> <a href="#" class="btnType1">배송추적</a></td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>교환불가</td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>반품신청 <br> <a href="#" class="btnType1">반품처리</a><a href="#" class="btnType1">반품불가</a></td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>반품진행 <br> <a href="#" class="btnType1">환불처리</a></td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>반품완료</td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>반품불가</td>
										<td class="tl">
											<p>배송일자 : YYYY.MM.DD/HH:MM:SS</p>
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>주문취소</td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" disabled/></td>
										<td>
											<p>[브랜드] 상품명 / 컬러 / 사이즈 / 상품품번</p>
											<select disabled>
												<option value="0">------------- 상품변경 -------------</option>
											</select>
											<a href="#" class="btnType1">저장</a>
										</td>
										<td>1</td>
										<td>#,###,### 원</td>
										<td>#,###,### 원</td>
										<td>취소진행 <br> <a href="#" class="btnType1">주문취소</a></td>
										<td class="tl">
											<div class="float_con">
												<div class="leftbox">
													<select class="mb5">
														<option value="0">배송업체선택</option>
													</select> <br />
													<input type="text" value="8451572157721" />
												</div>
												<div class="leftbox ml10">
													<a href="#" class="btnType1 btnBig">저장</a>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!--[e] 주문정보 -->
				</div>
				<!--[e] contents -->
				
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>