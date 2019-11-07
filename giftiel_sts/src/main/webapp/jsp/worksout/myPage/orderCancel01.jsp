<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderCancel01.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-28
 *
 * 파일 내용 : 01.취소정보 및 사유
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
								<a href="#">결제취소 신청</a>
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
										<span class="cont_tit">결제취소 신청</span>
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#" class="on">
												<span class="txt">취소정보 및 사유</span>
											</a>
											<a href="#">
												<span class="txt">결제/환불정보</span>
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
											<dd>1412260003</dd>
										</dl>
										<dl class="info_item02 clfix">
											<dt>주문일시
												<span class="bu">:</span>
											</dt>
											<dd>2014-12-21 13:47</dd>
										</dl>
									</div>
									<div class="mypage_tit clfix space02">
										<span class="txt01">결제취소 정보</span>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>결제취소 정보에 관한 테이블로 상품, 가격 에 대한 내용을 확인 할 수 있습니다.</caption>
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
											<tr>
												<td class="tbl_layout_util01">
													<div class="tbl_cont">
														<span class="input_check">
															<input type="checkbox" id="order_check01" name="order_check">
														</span>
													</div>
												</td>
												<td class="tbl_layout01 product_in_img">
													<div class="mobile_th">상품</div>
													<div class="tbl_cont clfix">
														<a href="#" class="p_img">
															<img src="/html/worksout/images/onlineshop/img_mypage01.jpg" alt="관리자에서 등록될 수 있도록 개발필요.">
														</a>
														<ul class="p_info">
															<li>[OBEY] obey Surveillance Eye</li>
															<li>Color = Black / SIZE = S</li>
															<li>DE15SPJALL00002001</li>
														</ul>
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">가격</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price">95,000</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tbl_layout_util01">
													<div class="tbl_cont">
														<span class="input_check">
															<input type="checkbox" id="order_check01" name="order_check">
														</span>
													</div>
												</td>
												<td class="tbl_layout01 product_in_img">
													<div class="mobile_th">상품</div>
													<div class="tbl_cont clfix">
														<a href="#" class="p_img">
															<img src="/html/worksout/images/onlineshop/img_mypage01.jpg" alt="관리자에서 등록될 수 있도록 개발필요.">
														</a>
														<ul class="p_info">
															<li>[OBEY] obey Surveillance Eye</li>
															<li>Color = Black / SIZE = S</li>
															<li>DE15SPJALL00002001</li>
														</ul>
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">가격</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price">95,000</span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>결제취소 내역 테이블로 배송비, 총 결제금액, 총 환불금액, 사용 포인트 반환에 관하여 확인할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">배송비</th>
												<th scope="col">총 결제금액</th>
												<th scope="col">환불예정금액</th>
												<th scope="col">사용 포인트 반환</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout06">
													<div class="mobile_th">배송비</div>
													<div class="tbl_cont">5,000</div>
												</td>
												<td class="tbl_layout06">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont">95,000</div>
												</td>
												<td class="tbl_layout06">
													<div class="mobile_th">환불예정금액</div>
													<div class="tbl_cont">
														<span class="ico_price">97,000</span>
													</div>
												</td>
												<td class="tbl_layout06">
													<div class="mobile_th">사용 포인트 반환</div>
													<div class="tbl_cont">1,000</div>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="btn_area04 clfix">
										<div class="btn01">
											<a href="#" class="btn_black01">다음</a>
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