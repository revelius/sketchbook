<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<div class="snb_fixed">

	<a href="<c:if test="${siteNo != 10002 }">/front/storeInfo/Ab.do</c:if><c:if test="${siteNo == 10002 }">/front/storeInfo/CaAb.do</c:if>"><div class="snb_tit space01">STORE INFO</div></a>

		<c:if test="${siteNo != '10002' }">
		<!-- .snb_depth01클래스에 on 클래스 붙으면 .snb_depth02_area 영역 열림 -->
		<div class="snb_depth01 on">
			<a href="#">WORKSOUT STORE</a>
			<ul style="display:block;" class="snb_depth02_area">
				<li id="Ab">
					<a href="<c:url value='/front/storeInfo/Ab' />">서울 압구정</a>
				</li>
				<li id="Wa">
					<a href="<c:url value='/front/storeInfo/Wa' />">서울 홍대와우산</a>
				</li>
				<li id="Sen">
					<a href="<c:url value='/front/storeInfo/Sen' />">부산 신세계백화점 센텀시티몰</a>
				</li>
			</ul>
		</div>
		</c:if>

		<c:if test="${siteNo == '10001' or siteNo == '10002'}">
		<!-- .snb_depth01클래스에 on 클래스 붙으면 .snb_depth02_area 영역 열림 -->
		<div class="snb_depth01 on">
			<a href="#">CARHARTT WIP STORE</a>
			<ul style="display:block;" class="snb_depth02_area">
				<li id="CaAb">
					<a href="<c:url value='/front/storeInfo/CaAb' />">서울 압구정</a>
				</li>
				<li id="CaWa">
					<a href="<c:url value='/front/storeInfo/CaWa' />">서울 홍대와우산</a>
				</li>
				<li id="CaCoex">
					<a href="<c:url value='/front/storeInfo/CaCoex' />">서울 코엑스몰</a>
				</li>
				<li id="Ti">
					<a href="<c:url value='/front/storeInfo/Ti' />">서울 타임스퀘어</a>
				</li>
				<!-- <li id="Myeong">
					<a href="<c:url value='/front/storeInfo/Myeong' />">서울 롯데백화점 명동</a>
				</li> -->
				<li id="Noon">
					<a href="<c:url value='/front/storeInfo/Noon' />">서울 눈스퀘어</a>
				</li>
				<li id="Gang">
					<a href="<c:url value='/front/storeInfo/Gang' />">서울 신세계백화점 강남</a>
				</li>
<!-- 				<li id="Bu"> -->
<%-- 					<a href="<c:url value='/front/storeInfo/Bu' />">부산 롯데백화점 본점</a> --%>
<!-- 				</li> -->
				<li id="CaSen">
					<a href="<c:url value='/front/storeInfo/CaSen' />">부산 신세계백화점 센텀시티몰</a>
				</li>
				<li id="CaDg">
					<a href="<c:url value='/front/storeInfo/CaDg' />">대구 신세계백화점</a>
				</li>				
			</ul>
		</div>
		</c:if>
<c:if test="${siteNo == '10001' }">		
		<div class="snb_depth01 on">
			<a href="#">ESTABLISHED</a>
			<ul style="display:block;" class="snb_depth02_area">
<!-- 				<li id="TERMINUS"> -->
<%-- 					<a href="<c:url value='/front/storeInfo/TERMINUS' />">터미너스</a> --%>
<!-- 				</li> -->
				<li id="ZINC">
					<a href="<c:url value='/front/storeInfo/ZINC' />">징크 / 코너델리</a>
				</li>
			</ul>
		</div>		
		
</c:if>		

	<c:if test="${siteNo != '10001'}">
	<div class="snb_depth01 on">
		<a href="<c:url value="/front/dealers" />">DEALERS</a>
	</div>
	</c:if>
</div>

<script type="text/javascript">
	var url = window.location.href;
	cutUrl = url.split("/");
	cnt = cutUrl.length;

	tmpUrl = cutUrl[cnt-1].split('.')[0];

// 	if(tmpUrl == "Ab" || tmpUrl == "Wa"){ 
// 		$("#worksout").addClass("on"); 
// 		$("#carhartt").removeClass("on"); 
// 		$("#snbWorksout").show(); 
// 		$("#snbCarhartt").hide(); 
// 		$("#snbDealers").hide(); 
// 	}else{
// 		$("#carhartt").addClass("on"); 
// 		$("#worksout").removeClass("on"); 
// 		$("#snbWorksout").hide(); 
// 		$("#snbCarhartt").show(); 
// 		$("#snbDealers").show(); 
// 	} 

	$("#"+tmpUrl).addClass("on");
</script>

<div class="snb_mobile_container">
	<ul class="snb_mobile_menu">
		<c:if test="${siteNo != '10002' }">
			<li>
				<a href="#" id="worksout">
					<div class="txt">WORKSOUT STORE</div>
				</a>
			</li>
		</c:if>
		<c:if test="${siteNo == '10001' or siteNo == '10002'}">
			<li>
				<a href="#" id="carhartt">
					<div class="txt">CARHARTT WIP STORE</div>
				</a>
			</li>
		</c:if>
		<c:if test="${siteNo != '10001' }">
			<li>
				<a href="#" id="dealers">
					<div class="txt">DEALERS</div>
				</a>
			</li>
		</c:if>
		<c:if test="${siteNo != '10002' }">
			<li>
				<a href="#" id="ESTABLISHED">
					<div class="txt">ESTABLISHED</div>
				</a>
			</li>	
		</c:if>		
		
	</ul>
	<div style="display:none;" class="snb_mobile_sub_menu">
		<div>
			<div>
<c:if test="${siteNo != '10002' }">
				<div class="menu_link" id="snbWorksout">
					<a href="<c:url value='/front/storeInfo/Wa' />" id="Wa">서울 홍대 와우산</a>
					<a href="<c:url value='/front/storeInfo/Ab' />" id="Ab">서울 압구정</a>
					<a href="<c:url value='/front/storeInfo/Sen' />" id="Sen">부산 신세계백화점 센텀시티몰</a>
				</div>
</c:if>
<c:if test="${siteNo == '10001' or siteNo == '10002'}">
				<div class="menu_link" id="snbCarhartt">
					<a href="<c:url value='/front/storeInfo/CaWa' />" id="CaWa">서울 홍대 와우산</a>
					<a href="<c:url value='/front/storeInfo/CaAb' />" id="CaAb">서울 압구정</a>
					<a href="<c:url value='/front/storeInfo/CaCoex' />" id="CaCoex">서울 코엑스몰</a>				
					<a href="<c:url value='/front/storeInfo/Ti' />" id="Ti">서울 타임스퀘어</a>
					<!-- <a href="<c:url value='/front/storeInfo/Myeong' />" id="Myeong">롯데백화점 영플라자 명동</a> -->
					<a href="<c:url value='/front/storeInfo/Noon' />" id="Noon">서울 눈스퀘어</a>
					<a href="<c:url value='/front/storeInfo/Gang' />" id="Gang">서울 신세계백화점 강남</a>
<%-- 					<a href="<c:url value='/front/storeInfo/Bu' />" id="Bu">롯데백화점 부산본점</a> --%>
					<a href="<c:url value='/front/storeInfo/CaSen' />" id="CaSen">신세계백화점 센텀시티</a>
					<a href="<c:url value='/front/storeInfo/CaDg'/>" id="CaDg">대구 신세계백화점</a>
				</div>
</c:if>
<c:if test="${siteNo != '10001' and siteNo != '10006' }">
				<div class="menu_link" id="snbDealers">
					<a href="<c:url value='/front/dealers' />">DEALERS</a>
				</div>
</c:if>
<c:if test="${siteNo == '10001' }">
				<div class="menu_link" id="snbESTABLISHED">
<%-- 					<a href="<c:url value='/front/storeInfo/TERMINUS' />" id="TERMINUS">터미너스</a> --%>
					<a href="<c:url value='/front/storeInfo/ZINC' />" id="ZINC">징크/코너델리</a>
				</div>
</c:if>
			</div>
		</div>
</div>
</div>