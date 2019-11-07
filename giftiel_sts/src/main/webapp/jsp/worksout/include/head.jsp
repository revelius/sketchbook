<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta charset="utf-8">
		<meta name="keywords" content="${siteKeyWords }">
		<meta name="description" content="${siteDesc2 }">
		<c:choose>
			<c:when test="${siteNo == '10004' }">
				<link href="/resources/worksout/css/fontBrixton.css" type="text/css" rel="stylesheet">
				<link href="/resources/worksout/css/resetBrixton.css" type="text/css" rel="stylesheet">
				<link href="/resources/worksout/css/commonBrixton.css" type="text/css" rel="stylesheet">				
			</c:when>
			<c:otherwise>
				<link href="http://fonts.googleapis.com/css?family=Source+Code+Pro:400,700"	type="text/css" rel="stylesheet">
				<link href="/resources/worksout/css/reset.css" type="text/css" rel="stylesheet">
				<link href="/resources/worksout/css/common.css" type="text/css" rel="stylesheet">
			</c:otherwise>
		</c:choose>
		<link href="/resources/worksout/css/print.css" type="text/css" rel="stylesheet">
		<!-- grayscale 관련 resource remove 151124 -->
		<!--<link href="/resources/worksout/css/gray.css" type="text/css" rel="stylesheet">-->
		<link href="/resources/worksout/css/swiper.css" type="text/css" rel="stylesheet">
		
		<script src="/resources/worksout/js/modernizr.js" type="text/javascript" charset="utf-8"></script>
		<script src="/resources/worksout/js/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="/resources/worksout/js/jquery.mousewheel.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="/resources/worksout/js/swipe.js" type="text/javascript" charset="utf-8"></script>
		<script src="/resources/worksout/js/TweenMax.min.js" type="text/javascript" charset="utf-8"></script>
		
		<!-- grayscale 관련 resource remove 151124 -->
		<!--<script src="/resources/worksout/js/jquery.gray.js" type="text/javascript" charset="utf-8"></script>-->	
		<script src="/resources/worksout/js/jquery.mCustomScrollbar.js" type="text/javascript" charset="utf-8"></script>
		<c:choose>
			<c:when test="${siteNo == '10004' }">
				<script src="/resources/worksout/js/commonBrixton.js" type="text/javascript" charset="utf-8"></script>
		</c:when>
			<c:otherwise>
				<script src="/resources/worksout/js/common.js" type="text/javascript" charset="utf-8"></script>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript" src="/resources/common/frontUtils.js"></script>
		<script type="text/javascript" src="/resources/common/jquery.cookie-1.4.1.min.js"></script>
		<script src="/resources/worksout/js/swiper.jquery.min.js" type="text/javascript" charset="utf-8"></script>		
		<link rel="icon" href="/resources/worksout/images/favicon/${siteNm }.ico" type="image/x-icon" />

		<title>
			<c:if test="${siteNo == '10001' }">WORKSOUT INC.</c:if>
			<c:if test="${siteNo == '10002' }">CARHARTT WIP KOREA</c:if>
			<c:if test="${siteNo == '10003' }">OBEY KOREA</c:if>
			<c:if test="${siteNo == '10004' }">BRIXTON KOREA</c:if>
			<c:if test="${siteNo == '10006' }">DEUS KOREA </c:if>
		</title>

		<c:if test="${siteNo == '10001' }">
			<meta name="naver-site-verification" content="f111555c1f373cd22b877d2233257a85c53986ea"/>
			<meta property="og:title" content="웍스아웃">
		</c:if>

		<c:if test="${siteNo == '10003' }">
			<meta property="og:title" content="오베이">
		</c:if>
		
		<c:if test="${siteNo == '10004' }">
			<meta property="og:title" content="브릭스톤">
		</c:if>

		<c:if test="${siteNo == '10006' }">
			<meta name="naver-site-verification" content="d0a8c4d5521757a3a0d07c5dcc477f4148b05a14"/>
			<meta property="og:title" content="데우스">
		</c:if>
		
		<meta property="og:type" content="website">
		<meta property="og:description" content="${siteDesc2 }">
		
		<link href="/resources/common/loading/loading.css" type="text/css" rel="stylesheet">
		
		<!-- 아이폰 -->
		<link rel="apple-touch-icon-precomposed" href="/resources/worksout/images/logo/${siteNm }.jpg" />
		<!-- 아이패드 -->
		<link rel="apple-touch-icon-precomposed" href="/resources/worksout/images/logo/${siteNm }.jpg" sizes="72*72" />
		<!-- 안드로이드 -->
		<link rel="shortcut icon" href="/resources/worksout/images/logo/${siteNm }.jpg" />
		
	<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
	<script>
		<c:if test="${siteNo == '10004' }">
			$(function() {		 	
				$("body").addClass("brixton_theme");
			});
		</c:if>
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
			naverScriptKey = "s_33102b7a54cc";
		</c:if>
		
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		 })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		 ga('create', googleId, 'auto');
		 ga('send', 'pageview');
		 
		 //네이버
		if (!wcs_add) var wcs_add={};
		wcs_add["wa"] = naverScriptKey;
		if (!_nasa) var _nasa={};
		wcs.inflow();
		wcs_do(_nasa);
	</script>
	<c:if test="${'10002' == siteNo}">
		<!-- carhartt Facebook Pixel Code -->
		<script>
			!function(f,b,e,v,n,t,s)
			{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
			n.callMethod.apply(n,arguments):n.queue.push(arguments)};
			if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
			n.queue=[];t=b.createElement(e);t.async=!0;
			t.src=v;s=b.getElementsByTagName(e)[0];
			s.parentNode.insertBefore(t,s)}(window,document,'script',
			'https://connect.facebook.net/en_US/fbevents.js');
			fbq('init', '769844253127154');
			fbq('track', 'PageView');
		</script>
		<noscript>
			<img height="1" width="1"
			src="https://www.facebook.com/tr?id=769844253127154&ev=PageView
			&noscript=1"/>
		</noscript>
		<!-- End carhartt Facebook Pixel Code -->	
	</c:if>				