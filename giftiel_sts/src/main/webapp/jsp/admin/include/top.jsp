<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 탑 메뉴 : 추후 기능화 할것임.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	Date dt = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
	String today = sf.format(dt);
%>  
<div id="header">
	<div class="headerWrap">
		<h1><a href="<c:url value='/admin/setting/index'/>">웍스아웃 관리자</a></h1>
		<div class="topArea">
			<ul>
				<li class="fir"><strong>${userNm}</strong> 님</li>
				<li>today : <span><%=today %></span></li>
			</ul>
		    <a href="<c:url value='/admin/logout'/>">로그아웃</a>
			<a href="<c:url value='/front/main' />" target="_blank">MALL</a>
		</div>      
		<div class="gnb">
			<ul>
				<li><a href="<c:url value='/admin/setting/index'/>">HOME</a></li>
				<li><a href="<c:url value='/admin/member/memberMain'/>">회원관리</a></li>
				<li><a href="<c:url value='/admin/goods/main'/>">상품관리</a></li>
				<li><a href="<c:url value='/admin/order/orderMain'/>">주문매출관리</a></li>
				<li><a href="<c:url value='/admin/manage/manage'/>">운영관리</a></li>
				<li><a href="<c:url value='/admin/statistics/statistics' />">통계분석</a></li>
				<li><a href="<c:url value='/admin/setting/index'/>">환경설정</a></li>
			</ul>
		</div>
	</div>
</div>
