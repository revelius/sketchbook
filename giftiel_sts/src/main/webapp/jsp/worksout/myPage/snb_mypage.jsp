<%--
 * =============================================================================
 * 파일명 : /front/myPage/snb_mypage.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-19
 *
 * 파일 내용 : 마이페이지 left
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
	<head>
		
	</head>
	<!--<![endif]-->
	<div class="snb_fixed">
	<a href="<c:url value="/front/myPage/myPageHome"/>"><div class="snb_tit">MY PAGE</div></a>
	<!-- .snb_depth01클래스에 on 클래스 붙으면 .snb_depth02_area 영역 열림 -->
	<div class="snb_depth01 on" <c:if test="${loginYn eq 'N'}">style="display:none"</c:if>>
		<a href="#">ORDER LIST</a>
		<ul style="display:block;" class="snb_depth02_area">
			<li>
				<a href="<c:url value="/front/myPage/orderList"/>">주문 / 배송 내역</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/orderCancelList"/>">취소 / 반품 내역</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/orderChangeList"/>">교환내역</a>
			</li>
			<li>
				<a href="<c:url value='/front/myPage/orderAddPayList'/>">추가결제</a>
			</li>
		</ul>
	</div>
	
	<!-- .snb_depth01클래스에 on 클래스 붙으면 .snb_depth02_area 영역 열림 -->
	<div class="snb_depth01 on" <c:if test="${loginYn eq 'N'}">style="display:none"</c:if>>
		<a href="#">PROFILE</a>
		<ul style="display:block;" class="snb_depth02_area">
			<li>
				<a href="<c:url value="/front/myPage/memberInfo"/>">회원정보관리</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/managePassword"/>">비밀번호관리</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지 관리</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/managePoint"/>">포인트 현황</a>
			</li>
		</ul>
	</div>
	<div class="snb_depth01 on" <c:if test="${loginYn eq 'N'}">style="display:none"</c:if>>
		<a href="#">Q &amp; A</a>
		</br>
		<ul style="display:block;" class="snb_depth02_area">
			<li>
				<a href="<c:url value="/front/myPage/faq"/>">F A Q</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/qnaList"/>">1:1 문의내역</a>
			</li>
			<li>
				<a href="<c:url value="/front/myPage/qna"/>">1:1 문의하기</a>
			</li>
		</ul>
	</div>
</div>
<div class="snb_mobile_container" <c:if test="${loginYn eq 'N'}">style="display:none"</c:if>>
	<ul class="snb_mobile_menu">
		<li>
			<a href="#" class="on">
				<div class="txt">ORDER LIST</div>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="txt">PROFILE</div>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="txt">Q&amp;A</div>
			</a>
		</li>
	</ul>
	<div style="display:none;" class="snb_mobile_sub_menu">
		<div>
			<div>
				<div class="menu_link">
					<a href="<c:url value="/front/myPage/orderList"/>" class="on">주문 / 배송 내역</a>
					<a href="<c:url value="/front/myPage/orderCancelList"/>">취소 / 반품 내역</a>
					<a href="<c:url value="/front/myPage/orderChangeList"/>">교환내역</a>
					<a href="<c:url value="/front/myPage/orderAddPayList"/>">추가결제</a>
				</div>
				<div style="display:none;" class="menu_link">
					<a href="<c:url value="/front/myPage/memberInfo"/>" class="on">회원정보관리</a>
					<a href="<c:url value="/front/myPage/managePassword"/>">비밀번호관리</a>
					<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지 관리</a>
					<a href="<c:url value="/front/myPage/managePoint"/>">포인트 현황</a>
				</div>
				<div style="display:none;" class="menu_link">
					<a href="<c:url value="/front/myPage/faq"/>">F A Q</a>
					<a href="<c:url value="/front/myPage/qnaList"/>" class="on">1:1 문의내역</a>
					<a href="<c:url value="/front/myPage/qna"/>">1:1 문의하기</a>
				</div>
			</div>
		</div>
	</div>
</div>
</html>