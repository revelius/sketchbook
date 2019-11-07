<%--
 * =============================================================================
 * 파일명 : /statistics/salesStatistics.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 통계 메인
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

</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">
			<!--[s] lnb -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
				<jsp:param name="menuFlag" value="static"/>
			</jsp:include>
			<!--[e] lnb -->
				
			<!--[s] contents -->
			<div class="contents productList">
				<h3><span class="icon1"></span>통계/분석 &gt; 매출통계 &gt; 전체매출통계 </h3>
				<a href="#" class="btnType2 advice">도움말</a>
				<div class="helpBox">
					<ul class="boxLi">
						<li>- 매출 통계는 배송완료 기준입니다.</li>
						<li>- 전체 현황과 각 브랜드 별 매출에 대한 상세 검색이 가능합니다.</li>
						<li>- 결제건수는 소비자 입금(신용카드, 핸드폰, 계좌이체, 가상계좌)한 입금일자 기준의 합계입니다.</li>
						<li>- 취소건수는 소비자 또는 관리자에 의해 주문 취소된 합계입니다.</li>
						<li>- 포인트적립은 상품 주문 결제시 발생된 포인트를 배송완료시점의 합계입니다.</li>
						<li>- 포인트사용은 상품 주문 결제시 사용한 포인트 합계입니다.</li>
						<li>- 결제금액은 결제 완료된 주문의 주문금액[(판매가+옵션가)x수량)-회원할인금-포인트사용+선배송비]으로 주문완료일자 기준의 총합계 금액입니다.</li>
						<li>- 총매출은 배송 완료된 주문의 주문금액 [((판매가+옵션가)×수량)-회원할인금-포인트사용+선배송비]으로 배송완료일자 기준의 총합계 금액입니다.</li>
					</ul>
					<a href="#" class="close">X</a>
				</div>
				<!-- tabWrap -->
				<div class="tabWrap">
					<ul class="tabList">
						<li><a href="#" class="current">전체</a></li>
						<li><a href="#">WORKSOUT</a></li>
						<li><a href="#">CARHARTT</a></li>
						<li><a href="#">OBEY</a></li>
						<li><a href="#">BRIXTON</a></li>
					</ul>
					<div class="tabConWrap">
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="130px">
										<col width="*">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th scope="col">결제수단</th>
											<td>
												<a href="#" class="btnType1">당일</a>
												<a href="#" class="btnType1">전일</a>
												<a href="#" class="btnType1">당월</a>
												<a href="#" class="btnType1">1주</a>
												<a href="#" class="btnType1">15일</a>
												<a href="#" class="btnType1">한달</a>
												<a href="#" class="btnType1">두달</a>
												<br /><br />
												<div class="wrap">
													<a href="#" class="btnType1">직접검색</a>
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a> ~
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a>				
												</div>
											</td>
											<td rowspan="2" class="bd_left">
												<a href="#" class="btnType2">검색</a> <br /><br />
												<a href="#" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th scope="col">기간</th>
											<td>
												<div class="wrap">
													<input type="checkbox" id="ch_pay1" checked="checked">
													<label for="ch_pay1">전체</label>
													<input type="checkbox" id="ch_pay2">
													<label for="ch_pay2">신용카드</label>
													<input type="checkbox" id="ch_pay3">
													<label for="ch_pay3">무통장</label>
													<input type="checkbox" id="ch_pay4">
													<label for="ch_pay4">계좌이체</label>
													<input type="checkbox" id="ch_pay5">
													<label for="ch_pay5">포인트</label>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="section a2">
								<div class="tableTitle">
									<div class="left"><span class="icon2"></span><span>2015년 05월 05일</span>부터 <span>2015년 05월 05일</span>까지의 검색 결과입니다.</div>
									<div class="right">
										<a href="#" class="btnType2">Graph</a>
										<a href="#" class="btnType2">List</a>
										<select class="ml_5">
											<option>15개</option>
										</select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">일자 <a href="#" class="down">▼</a></th>
													<th scope="row">주문건수 <a href="#" class="down">▼</a></th>
													<th scope="row">결제건수 <a href="#" class="down">▼</a></th>
													<th scope="row">취소건수 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트적립 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트사용 <a href="#" class="down">▼</a></th>
													<th scope="row">배송비 <a href="#" class="down">▼</a></th>
													<th scope="row">결제금액 <a href="#" class="down">▼</a></th>
													<th scope="row">총매출 <a href="#" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>
														<a href="#" class="btnLayer">3</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">WORKSOUT :</span> <span class="right">1건</span></li>
																<li><span class="left">CARHARTT :</span> <span class="right">1건</span></li>
																<li><span class="left">OBEY :</span> <span class="right">1건</span></li>
															</ul>
														</div>
													</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!--[s] 페이징 -->
									<div class="paging">
										<a href="#" class="firstBtn"><img src="../static/images/common/firstBtn.gif" alt="처음으로"></a>
										<a href="#" class="prevBtn"><img src="../static/images/common/prevBtn.gif" alt="이전으로"></a>
										<span class="num">
											<a href="#" class="on">1</a>
											<a href="#">2</a>
											<a href="#">3</a>
											<a href="#">4</a>
											<a href="#">5</a>
											<a href="#">6</a>
											<a href="#">7</a>
											<a href="#">8</a>
											<a href="#">9</a>
											<a href="#">10</a>
										</span>
										<a href="#" class="nextBtn"><img src="../static/images/common/nextBtn.gif" alt="다음으로"></a>
										<a href="#" class="lastBtn"><img src="../static/images/common/lastBtn.gif" alt="마지막으로"></a>
										<div class="right">
											<a href="#" class="btnType2">엑셀다운로드</a>
										</div>
									</div>
									<!--[e] 페이징 -->
								</div>
								<!-- //list -->
								<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
							</div>
						</div>
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
										<col width="100px">
										<col width="150px">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th>기간</th>
											<td>
												<a href="#" class="btnType1">당일</a>
												<a href="#" class="btnType1">전일</a>
												<a href="#" class="btnType1">당월</a>
												<a href="#" class="btnType1">1주</a>
												<a href="#" class="btnType1">15일</a>
												<a href="#" class="btnType1">한달</a>
												<a href="#" class="btnType1">두달</a>
												<br /><br />
												<div class="wrap">
													<a href="#" class="btnType1">직접검색</a>
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a> ~
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a>				
												</div>
											</td>
											<th>브랜드</th>
											<td>
												<select>
													<option value="0">전체</option>
												</select>
											</td>
											<td rowspan="4" class="bd_left">
												<a href="#" class="btnType2">검색</a> <br /><br />
												<a href="#" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>결제</th>
											<td colspan="3">
												<div class="wrap">
													<input type="checkbox" id="ch_pay3_1" checked="checked">
													<label for="ch_pay3_1">전체</label>
													<input type="checkbox" id="ch_pay3_2">
													<label for="ch_pay3_2">신용카드</label>
													<input type="checkbox" id="ch_pay3_3">
													<label for="ch_pay3_3">핸드폰</label>
													<input type="checkbox" id="ch_pay3_4">
													<label for="ch_pay3_4">계좌이체</label>
													<input type="checkbox" id="ch_pay3_5">
													<label for="ch_pay3_5">가상계좌</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td colspan="3">
												<select>
													<option value="0">1차분류</option>
												</select>
												<select>
													<option value="0">2차분류</option>
												</select>
												<select>
													<option value="0">3차분류</option>
												</select>
												<select>
													<option value="0">4차분류</option>
												</select>
												<input type="checkbox" id="ch_group">
												<label for="ch_group">하위포함</label>
											</td>
										</tr>
										<tr>
											<th>상품</th>
											<td colspan="3"><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="section a2">
								<div class="tableTitle">
									<div class="left"><span class="icon2"></span><span>2015년 05월 05일</span>부터 <span>2015년 05월 05일</span>까지의 검색 결과입니다.</div>
									<div class="right">
										<a href="#" class="btnType2">Graph</a>
										<a href="#" class="btnType2">List</a>
										<select class="ml_5">
											<option>15개</option>
										</select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">일자 <a href="#" class="down">▼</a></th>
													<th scope="row">주문건수 <a href="#" class="down">▼</a></th>
													<th scope="row">결제건수 <a href="#" class="down">▼</a></th>
													<th scope="row">취소건수 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트적립 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트사용 <a href="#" class="down">▼</a></th>
													<th scope="row">배송비 <a href="#" class="down">▼</a></th>
													<th scope="row">결제금액 <a href="#" class="down">▼</a></th>
													<th scope="row">총매출 <a href="#" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>
														<a href="#" class="btnLayer">3</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">WORKSOUT :</span> <span class="right">1건</span></li>
																<li><span class="left">CARHARTT :</span> <span class="right">1건</span></li>
																<li><span class="left">OBEY :</span> <span class="right">1건</span></li>
															</ul>
														</div>
													</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!--[s] 페이징 -->
									<div class="paging">
										<a href="#" class="firstBtn"><img src="../static/images/common/firstBtn.gif" alt="처음으로"></a>
										<a href="#" class="prevBtn"><img src="../static/images/common/prevBtn.gif" alt="이전으로"></a>
										<span class="num">
											<a href="#" class="on">1</a>
											<a href="#">2</a>
											<a href="#">3</a>
											<a href="#">4</a>
											<a href="#">5</a>
											<a href="#">6</a>
											<a href="#">7</a>
											<a href="#">8</a>
											<a href="#">9</a>
											<a href="#">10</a>
										</span>
										<a href="#" class="nextBtn"><img src="../static/images/common/nextBtn.gif" alt="다음으로"></a>
										<a href="#" class="lastBtn"><img src="../static/images/common/lastBtn.gif" alt="마지막으로"></a>
										<div class="right">
											<a href="#" class="btnType2">엑셀다운로드</a>
										</div>
									</div>
									<!--[e] 페이징 -->
								</div>
								<!-- //list -->
								<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
							</div>
						</div>
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th>기간</th>
											<td>
												<a href="#" class="btnType1">당일</a>
												<a href="#" class="btnType1">전일</a>
												<a href="#" class="btnType1">당월</a>
												<a href="#" class="btnType1">1주</a>
												<a href="#" class="btnType1">15일</a>
												<a href="#" class="btnType1">한달</a>
												<a href="#" class="btnType1">두달</a>
												<br /><br />
												<div class="wrap">
													<a href="#" class="btnType1">직접검색</a>
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a> ~
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a>				
												</div>
											</td>
											<td rowspan="4" class="bd_left">
												<a href="#" class="btnType2">검색</a> <br /><br />
												<a href="#" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>결제</th>
											<td>
												<div class="wrap">
													<input type="checkbox" id="ch_pay4_1" checked="checked">
													<label for="ch_pay4_1">전체</label>
													<input type="checkbox" id="ch_pay4_2">
													<label for="ch_pay4_2">신용카드</label>
													<input type="checkbox" id="ch_pay4_3">
													<label for="ch_pay4_3">핸드폰</label>
													<input type="checkbox" id="ch_pay4_4">
													<label for="ch_pay4_4">계좌이체</label>
													<input type="checkbox" id="ch_pay4_5">
													<label for="ch_pay4_5">가상계좌</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td>
												<select>
													<option value="0">1차분류</option>
												</select>
												<select>
													<option value="0">2차분류</option>
												</select>
												<select>
													<option value="0">3차분류</option>
												</select>
												<select>
													<option value="0">4차분류</option>
												</select>
												<input type="checkbox" id="ch_group">
												<label for="ch_group">하위포함</label>
											</td>
										</tr>
										<tr>
											<th>상품</th>
											<td><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="section a2">
								<div class="tableTitle">
									<div class="left"><span class="icon2"></span><span>2015년 05월 05일</span>부터 <span>2015년 05월 05일</span>까지의 검색 결과입니다.</div>
									<div class="right">
										<a href="#" class="btnType2">Graph</a>
										<a href="#" class="btnType2">List</a>
										<select class="ml_5">
											<option>15개</option>
										</select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">일자 <a href="#" class="down">▼</a></th>
													<th scope="row">주문건수 <a href="#" class="down">▼</a></th>
													<th scope="row">결제건수 <a href="#" class="down">▼</a></th>
													<th scope="row">취소건수 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트적립 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트사용 <a href="#" class="down">▼</a></th>
													<th scope="row">배송비 <a href="#" class="down">▼</a></th>
													<th scope="row">결제금액 <a href="#" class="down">▼</a></th>
													<th scope="row">총매출 <a href="#" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>
														<a href="#" class="btnLayer">3</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">WORKSOUT :</span> <span class="right">1건</span></li>
																<li><span class="left">CARHARTT :</span> <span class="right">1건</span></li>
																<li><span class="left">OBEY :</span> <span class="right">1건</span></li>
															</ul>
														</div>
													</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!--[s] 페이징 -->
									<div class="paging">
										<a href="#" class="firstBtn"><img src="../static/images/common/firstBtn.gif" alt="처음으로"></a>
										<a href="#" class="prevBtn"><img src="../static/images/common/prevBtn.gif" alt="이전으로"></a>
										<span class="num">
											<a href="#" class="on">1</a>
											<a href="#">2</a>
											<a href="#">3</a>
											<a href="#">4</a>
											<a href="#">5</a>
											<a href="#">6</a>
											<a href="#">7</a>
											<a href="#">8</a>
											<a href="#">9</a>
											<a href="#">10</a>
										</span>
										<a href="#" class="nextBtn"><img src="../static/images/common/nextBtn.gif" alt="다음으로"></a>
										<a href="#" class="lastBtn"><img src="../static/images/common/lastBtn.gif" alt="마지막으로"></a>
										<div class="right">
											<a href="#" class="btnType2">엑셀다운로드</a>
										</div>
									</div>
									<!--[e] 페이징 -->
								</div>
								<!-- //list -->
								<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
							</div>
						</div>
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th>기간</th>
											<td>
												<a href="#" class="btnType1">당일</a>
												<a href="#" class="btnType1">전일</a>
												<a href="#" class="btnType1">당월</a>
												<a href="#" class="btnType1">1주</a>
												<a href="#" class="btnType1">15일</a>
												<a href="#" class="btnType1">한달</a>
												<a href="#" class="btnType1">두달</a>
												<br /><br />
												<div class="wrap">
													<a href="#" class="btnType1">직접검색</a>
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a> ~
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a>				
												</div>
											</td>
											<td rowspan="4" class="bd_left">
												<a href="#" class="btnType2">검색</a> <br /><br />
												<a href="#" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>결제</th>
											<td>
												<div class="wrap">
													<input type="checkbox" id="ch_pay5_1" checked="checked">
													<label for="ch_pay5_1">전체</label>
													<input type="checkbox" id="ch_pay5_2">
													<label for="ch_pay5_2">신용카드</label>
													<input type="checkbox" id="ch_pay5_3">
													<label for="ch_pay5_3">핸드폰</label>
													<input type="checkbox" id="ch_pay5_4">
													<label for="ch_pay5_4">계좌이체</label>
													<input type="checkbox" id="ch_pay5_5">
													<label for="ch_pay5_5">가상계좌</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td>
												<select>
													<option value="0">1차분류</option>
												</select>
												<select>
													<option value="0">2차분류</option>
												</select>
												<select>
													<option value="0">3차분류</option>
												</select>
												<select>
													<option value="0">4차분류</option>
												</select>
												<input type="checkbox" id="ch_group">
												<label for="ch_group">하위포함</label>
											</td>
										</tr>
										<tr>
											<th>상품</th>
											<td><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="section a2">
								<div class="tableTitle">
									<div class="left"><span class="icon2"></span><span>2015년 05월 05일</span>부터 <span>2015년 05월 05일</span>까지의 검색 결과입니다.</div>
									<div class="right">
										<a href="#" class="btnType2">Graph</a>
										<a href="#" class="btnType2">List</a>
										<select class="ml_5">
											<option>15개</option>
										</select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">일자 <a href="#" class="down">▼</a></th>
													<th scope="row">주문건수 <a href="#" class="down">▼</a></th>
													<th scope="row">결제건수 <a href="#" class="down">▼</a></th>
													<th scope="row">취소건수 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트적립 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트사용 <a href="#" class="down">▼</a></th>
													<th scope="row">배송비 <a href="#" class="down">▼</a></th>
													<th scope="row">결제금액 <a href="#" class="down">▼</a></th>
													<th scope="row">총매출 <a href="#" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>
														<a href="#" class="btnLayer">3</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">WORKSOUT :</span> <span class="right">1건</span></li>
																<li><span class="left">CARHARTT :</span> <span class="right">1건</span></li>
																<li><span class="left">OBEY :</span> <span class="right">1건</span></li>
															</ul>
														</div>
													</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!--[s] 페이징 -->
									<div class="paging">
										<a href="#" class="firstBtn"><img src="../static/images/common/firstBtn.gif" alt="처음으로"></a>
										<a href="#" class="prevBtn"><img src="../static/images/common/prevBtn.gif" alt="이전으로"></a>
										<span class="num">
											<a href="#" class="on">1</a>
											<a href="#">2</a>
											<a href="#">3</a>
											<a href="#">4</a>
											<a href="#">5</a>
											<a href="#">6</a>
											<a href="#">7</a>
											<a href="#">8</a>
											<a href="#">9</a>
											<a href="#">10</a>
										</span>
										<a href="#" class="nextBtn"><img src="../static/images/common/nextBtn.gif" alt="다음으로"></a>
										<a href="#" class="lastBtn"><img src="../static/images/common/lastBtn.gif" alt="마지막으로"></a>
										<div class="right">
											<a href="#" class="btnType2">엑셀다운로드</a>
										</div>
									</div>
									<!--[e] 페이징 -->
								</div>
								<!-- //list -->
								<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
							</div>
						</div>
						<div class="tabCon">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th>기간</th>
											<td>
												<a href="#" class="btnType1">당일</a>
												<a href="#" class="btnType1">전일</a>
												<a href="#" class="btnType1">당월</a>
												<a href="#" class="btnType1">1주</a>
												<a href="#" class="btnType1">15일</a>
												<a href="#" class="btnType1">한달</a>
												<a href="#" class="btnType1">두달</a>
												<br /><br />
												<div class="wrap">
													<a href="#" class="btnType1">직접검색</a>
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a> ~
													<input type="text" id="" name="">
													<a href="#" class="btnCal"><img src="../static/images/common/icon2.gif" alt="달력"></a>				
												</div>
											</td>
											<td rowspan="4" class="bd_left">
												<a href="#" class="btnType2">검색</a> <br /><br />
												<a href="#" class="btnType1">초기화</a>
											</td>
										</tr>
										<tr>
											<th>결제</th>
											<td>
												<div class="wrap">
													<input type="checkbox" id="ch_pay2_1" checked="checked">
													<label for="ch_pay2_1">전체</label>
													<input type="checkbox" id="ch_pay2_2">
													<label for="ch_pay2_2">신용카드</label>
													<input type="checkbox" id="ch_pay2_3">
													<label for="ch_pay2_3">핸드폰</label>
													<input type="checkbox" id="ch_pay2_4">
													<label for="ch_pay2_4">계좌이체</label>
													<input type="checkbox" id="ch_pay2_5">
													<label for="ch_pay2_5">가상계좌</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td>
												<select>
													<option value="0">1차분류</option>
												</select>
												<select>
													<option value="0">2차분류</option>
												</select>
												<select>
													<option value="0">3차분류</option>
												</select>
												<select>
													<option value="0">4차분류</option>
												</select>
												<input type="checkbox" id="ch_group">
												<label for="ch_group">하위포함</label>
											</td>
										</tr>
										<tr>
											<th>상품</th>
											<td><a href="#" class="btnType1">찾기</a> <span>Rival Snap Backnders</span> <a href="#">X</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="section a2">
								<div class="tableTitle">
									<div class="left"><span class="icon2"></span><span>2015년 05월 05일</span>부터 <span>2015년 05월 05일</span>까지의 검색 결과입니다.</div>
									<div class="right">
										<a href="#" class="btnType2">Graph</a>
										<a href="#" class="btnType2">List</a>
										<select class="ml_5">
											<option>15개</option>
										</select>
									</div>
								</div>
								<!-- list -->
								<div class="listWrap">
									<div class="tableType1 tblStats">
										<table>
											<caption>전체매출통계</caption>
											<colgroup>
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: 11%" />
												<col style="width: *" />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">일자 <a href="#" class="down">▼</a></th>
													<th scope="row">주문건수 <a href="#" class="down">▼</a></th>
													<th scope="row">결제건수 <a href="#" class="down">▼</a></th>
													<th scope="row">취소건수 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트적립 <a href="#" class="down">▼</a></th>
													<th scope="row">포인트사용 <a href="#" class="down">▼</a></th>
													<th scope="row">배송비 <a href="#" class="down">▼</a></th>
													<th scope="row">결제금액 <a href="#" class="down">▼</a></th>
													<th scope="row">총매출 <a href="#" class="down">▼</a></th>
												</tr>
											</thead>
											<tbody>	
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>
														<a href="#" class="btnLayer">3</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">WORKSOUT :</span> <span class="right">1건</span></li>
																<li><span class="left">CARHARTT :</span> <span class="right">1건</span></li>
																<li><span class="left">OBEY :</span> <span class="right">1건</span></li>
															</ul>
														</div>
													</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
													<td>
														<a href="#" class="btnLayer">50,000</a>
														<div class="listLayer">
															<ul>
																<li><span class="left">신용카드 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">핸드폰 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">계좌이체 :</span> <span class="right">20,000원</span></li>
																<li><span class="left">가상이체 :</span> <span class="right">20,000원</span></li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
												<tr>	
													<td>2015.05.05</td>
													<td>3</td>
													<td>3</td>
													<td>0</td>
													<td>100</td>
													<td>0</td>
													<td>0</td>
													<td>50,000</td>
													<td>50,000</td>
												</tr>
											</tbody>
										</table>
									</div>
									<!--[s] 페이징 -->
									<div class="paging">
										<a href="#" class="firstBtn"><img src="../static/images/common/firstBtn.gif" alt="처음으로"></a>
										<a href="#" class="prevBtn"><img src="../static/images/common/prevBtn.gif" alt="이전으로"></a>
										<span class="num">
											<a href="#" class="on">1</a>
											<a href="#">2</a>
											<a href="#">3</a>
											<a href="#">4</a>
											<a href="#">5</a>
											<a href="#">6</a>
											<a href="#">7</a>
											<a href="#">8</a>
											<a href="#">9</a>
											<a href="#">10</a>
										</span>
										<a href="#" class="nextBtn"><img src="../static/images/common/nextBtn.gif" alt="다음으로"></a>
										<a href="#" class="lastBtn"><img src="../static/images/common/lastBtn.gif" alt="마지막으로"></a>
										<div class="right">
											<a href="#" class="btnType2">엑셀다운로드</a>
										</div>
									</div>
									<!--[e] 페이징 -->
								</div>
								<!-- //list -->
								<!-- grap none 시켜놓았음 style은 영역을 확인하기 위해 임시로 넣어 놓왔음 -->
								<div class="graphWrap" style="display: none; width: 1000px; padding: 100px 0; border: 1px solid #e5e5e5; text-align: center;">
									그래프 영역~~~~~ :)
								</div>
								<!-- //grap -->
							</div>
						</div>
					</div>
				</div>
				<!-- //tabWrap -->
			</div>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
	</div>
</body>
</html>