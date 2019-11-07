<%@ page contentType="text/html; charset=utf-8" %>
	<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
	<script>
		//구글 analytics 시작
		var googleId = "";
		var naverScriptKey = "";
		<c:if test="${'10001' == siteNo}">
			googleId = "UA-23866041-4";
			naverScriptKey = "s_3df903410f87";
		</c:if>
		<c:if test="${'10002' == siteNo}">
			googleId = "UA-23866041-2";
			naverScriptKey = "s_47f9e9953ff1";
		</c:if>
		<c:if test="${'10003' == siteNo}">
			googleId = "UA-23866041-8";
			naverScriptKey = "s_20de6e8ef507";
		</c:if>
		<c:if test="${'10004' == siteNo}">
			googleId = "UA-23866041-7";
			naverScriptKey = "s_67e57dc1cb5";
		</c:if>
		<c:if test="${'10006' == siteNo}">
			googleId = "UA-23866041-9";
		</c:if>
		
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		 })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		 //ga('create', googleId, 'auto');
		 //ga('send', 'pageview');
		 
		 //네이버
		if (!wcs_add) var wcs_add={};
		wcs_add["wa"] = naverScriptKey;
		if (!_nasa) var _nasa={};
		wcs.inflow();
		wcs_do(_nasa);		 
	</script>	

<%
String qs =  "?"+request.getQueryString();
if("?null".equals(qs)){
	qs = "";
}
response.sendRedirect("/front/main"+qs);
%>