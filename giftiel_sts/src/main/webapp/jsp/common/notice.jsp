<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<%
if(request.getServerName().toString().indexOf("loc") == -1){
    if(request.getServerName().toString().indexOf("www.") == -1){
		response.sendRedirect(request.getScheme()+"://www."+request.getServerName());
    }
}
%>
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
			var date;
			date = new Date();
			date.setHours(0);
			date.setMinutes(0);
			date.setSeconds(0);
			var time1 = date.getTime(); // 오늘 0시 0분 으로 설정
		
			date.setDate(date.getDate() + 1);
			//var time2 = date.getTime(); // 내일 0시 0분 으로 설정
			var time2 = new Date(2015,9,06,13,00,00);
			
		
			// 오늘과 내일을 미리 구하기 때문에 자정을 넘어갈 경우 이 소스는 오작동 할 수 있습니다.
			// 위 날짜 구하는 부분이 계속 호출되도록 하면됩니다.
		
			// 지난 시간 카운터
			function later(){
				var now = new Date();
				var gap = Math.round((now.getTime() - time1) / 1000);
		
				var D = Math.floor(gap / 86400);
				var H = Math.floor((gap - D * 86400) / 3600 % 3600);
				var M = Math.floor((gap - H * 3600) / 60 % 60);
				var S = Math.floor((gap - M * 60) % 60);
				$("div#text1").html('오늘이 ' + D + '일 ' + H + '시간 ' + M + '분 ' + S + '초 지나갔습니다.');
			}
		
			// 남은 시간 카운터
			function remain(){
				var now = new Date();
				var gap = Math.round((time2 - now.getTime()) / 1000);
		
				var D = Math.floor(gap / 86400);
				var H = Math.floor((gap - D * 86400) / 3600 % 3600);
				var M = Math.floor((gap - H * 3600) / 60 % 60);
				var S = Math.floor((gap - M * 60) % 60);
				$("div#text2").html('오픈까지 ' + D + '일 ' + H + '시간 ' + M + '분 ' + S + '초 남았습니다.');
			}
			//later();
			//remain();
			//setInterval(later, 1000);
			//setInterval(remain, 1000);
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div id="wrap">
			<c:if test="${pageContext.request.serverName == 'www.carhartt-wip.co.kr' || pageContext.request.serverName == 'carhartt-wip.co.kr'}">
				<img src="/resources/worksout/images/seasonoff/CARHARTTWIP_NOTICE.jpg" width="100%">
			</c:if>
			<c:if test="${pageContext.request.serverName != 'www.carhartt-wip.co.kr' && pageContext.request.serverName != 'carhartt-wip.co.kr'}">
				<img src="/resources/worksout/images/seasonoff/WORKSOUT_BRANDS_NOTICE.jpg" width="100%">
			</c:if>			
		</div>
	</body>
</html>