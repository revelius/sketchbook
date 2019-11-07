<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderCancel02.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-28
 *
 * 파일 내용 : 02.결제/환불정보
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
											<a href="#">
												<span class="txt">취소정보 및 사유</span>
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
											<ul class="mypage_info04">
												<li>
													<div class="tit">결제수단</div>
													<div class="desc">가상계좌</div>
												</li>
												<li>
													<div class="tit">계좌번호</div>
													<div class="desc">기업은행 123-1231231-123123-123</div>
												</li>
												<li>
													<div class="tit">예금주명</div>
													<div class="desc">홍길동</div>
												</li>
												<li class="last_child">
													<div class="tit">결제일</div>
													<div class="desc">2015.12.21 14:00</div>
												</li>
											</ul>
										</div>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">환불정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info05 clfix mypage_info05_space01">
												<li>
													<div class="tit">
														<label for="info01">결제수단</label>
													</div>
													<div class="desc">
														<span class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="text" id="info01" name="info01">
														</span>
													</div>
												</li>
												<li class="second_child">
													<div class="tit">
														<label for="info01">계좌번호</label>
													</div>
													<div class="desc">
														<span class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="text" id="info01" name="info01">
														</span>
													</div>
												</li>
												<li>
													<div class="tit">
														<label for="info01">결제일</label>
													</div>
													<div class="desc">
														<span class="input_txt">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="text" id="info01" name="info01">
														</span>
													</div>
												</li>
											</ul>
										</div>
									</div>
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