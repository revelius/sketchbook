<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="snb_fixed">
	<ul class="snb_main">
	<c:if test="${siteNo == '10001' }">
		<li>
			<a href="${contextPath }/front/onlineShop/goodsList?sex=&brand=CD,GX,HS,SJ,SZ,GB,QS&orderFlag=&orderBy=" id="BRAND_CD">CORNER DELI</a>
		</li>
	</c:if>

		<li>
			<a href="<c:url value="/front/onlineShop/feature"/>">ONLINE SHOP</a>
		</li>
		<li>
		<c:choose>
			<c:when test="${siteNo == '10002' }">
				<a href="<c:url value="/front/storeInfo/CaDg"/>">STORE INFO</a>			
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/front/storeInfo/Ab"/>">STORE INFO</a>			
			</c:otherwise>
		</c:choose>		
		</li>
		<li>
			<a href="<c:url value="/front/news/newsList"/>">NEWS</a>
		</li>
		<li>
			<a href="<c:url value="/front/lookbook/list"/>">LOOKBOOK</a>
		</li>
	</ul>
</div>
<div class="snb_mobile_container">
	<ul class="snb_main_mobile">
	<c:if test="${siteNo == '10001' }">
		<li>
			<a href="${contextPath }/front/onlineShop/goodsList?sex=&brand=CD,GX,HS,SJ,SZ,GB,QS&orderFlag=&orderBy=" id="BRAND_CD">CORNER DELI</a>
		</li>
	</c:if>
		<li>
			<a href="<c:url value="/front/onlineShop/feature"/>">ONLINE SHOP</a>
		</li>
		<li>
		<c:choose>
			<c:when test="${siteNo == '10002' }">
				<a href="<c:url value="/front/storeInfo/CaDg"/>">STORE INFO</a>			
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/front/storeInfo/Ab"/>">STORE INFO</a>			
			</c:otherwise>
		</c:choose>
		</li>
		<li>
			<a href="<c:url value="/front/news/newsList"/>">NEWS</a>
		</li>
		<li>
			<a href="<c:url value="/front/lookbook/list"/>">LOOKBOOK</a>
		</li>
	</ul>
</div>