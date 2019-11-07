<%--
 * =============================================================================
 * 파일명 :  /front/myPage/managePoint.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-03
 *
 * 파일 내용 : 포인트 현황
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
    			
    			//페이징 처리
    		    paging = function(page) {
    		        //var frm = document.schForm;
    		        document.getElementById("page").value = page;
    		        goSubmit();
    		    };	
    		    
    		    //검색
    		    goSubmit = function(){
   			        var frm = document.searchForm;
   						frm.action = "<c:url value='/front/myPage/managePoint'/>";
			 	        frm.submit();
    		    };
    			
    			
    			
    			
    		});
   		</script>
		
		
	</head>
	<body>
		<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm" onsubmit="">
			<form:hidden path="page" id="page"/>
		</form:form>
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
								<a href="#">PROFILE</a>
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
									<div class="content_menu clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="<c:url value="/front/myPage/memberInfo"/>">회원정보관리</a>
											<a href="<c:url value="/front/myPage/managePassword"/>">비밀번호관리</a>
											<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지관리</a>
											<a href="<c:url value="/front/myPage/managePoint"/>" class="on last_child">포인트현황</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="box_gray01 clfix space01">
										<div class="box01 box_col04">
											<span class="txt01">${member.nm}</span>
											님의 총 보유 포인트</div>
										<div class="box01 box_col05">
											<span class="txt02"><fmt:formatNumber value="${member.curPoint}" pattern="#,###P"/></span>
										</div>
									</div>
									
									* 적립된 포인트는 지급일로부터 15일 후 사용가능합니다.
									<table class="tbl_col02 tbl_col02_mypage_qna_list ui_reponsible_table_type01">
										<caption>포인트현황 게시판으로 NO, 상품, 일시, 지급포인트, 사용포인트 를 확인 할 수 있습니다.</caption>
										<thead>
											<!-- th에서 빠지는 항목이 발생시 th 삭제하면됨. 밑에 td도 같이 삭제함. -->
											<tr>
												<th scope="col">NO</th>
												<th scope="col">내용</th>
												<th scope="col">일시</th>
												<th scope="col">지급포인트</th>
												<th scope="col">사용포인트</th>
											</tr>
										</thead>
										<tbody>
										<c:choose>
											<c:when test="${not empty reserveList}">
												<c:forEach var="reserve" items="${reserveList}" varStatus="stat">
													<tr>
														<td class="tbl_layout01">
															<div class="mobile_th">NO</div>
															<div class="tbl_cont">${reserve.rnum}</div>
														</td>
														<td class="tbl_layout02">
															<div class="mobile_th">내용</div>
															<div class="tbl_cont">
																<a href="#">${reserve.rsvRsnCd}</a>
															</div>
														</td>
														<td class="tbl_layout03">
															<div class="mobile_th">일시</div>
															<div class="tbl_cont">${reserve.regDts}</div>
														</td>
														<td class="tbl_layout04">
															<div class="mobile_th">지급포인트</div>
															<div class="tbl_cont"><c:if test="${reserve.rsvYn=='Y'}">+ ${reserve.rsvPnt}</c:if></div>
														</td>
														<td class="tbl_layout05">
															<div class="mobile_th">사용포인트</div>
															<div class="tbl_cont"><c:if test="${reserve.rsvYn=='N'}">- ${reserve.rsvPnt}</c:if></div>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
<!-- 												<tr> -->
<!-- 													<td colspan="5" class="no_content"> -->
<!-- 														<img src="/html/worksout/images/common/img_no_order.gif" alt="주문/배송내역이 없습니다."> -->
<!-- 													</td> -->
<!-- 												</tr> -->
											</c:otherwise>
										</c:choose>
										
											
										</tbody>
									</table>
									<!-- a태그에 on 붙으면 활성화 됨. -->
									<!-- 처음, 이전, 끝, 다음으로는 활성화 없음 -->
									<!-- 웹에서는 페이징 모바일에서는 아래 더보기 버튼 사용 -->
									<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
									<div class="pagenavi_loadmoer_select_ctr">
										<div class="pagenavi space01">
											<!--[s] 페이징 -->
											<div class="paging">
											<c:choose>
												<c:when test="${not empty reserveList}">
												${pageHtml}
												</c:when>
											</c:choose>
											</div>
											<!--[e] 페이징 -->
										</div>
										<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
										<!-- 모바일에서는 아래 더보기 버튼 사용.  -->
										<div class="btn_area">
											<a href="#">
												<img src="/html/worksout/images/common/btn_loadmore.png" alt="LOAD MORE">
											</a>
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