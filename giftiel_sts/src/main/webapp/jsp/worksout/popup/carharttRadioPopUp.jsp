<%--
 * =============================================================================
 * 파일명 : /storeInfo.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-08-17
 *
 * 파일 내용 : storeInfo
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
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta charset="utf-8">
		<meta name="keywords" content="">
		<meta name="description" content="">
		<title>Worksout Inc.</title>
		<link href="http://fonts.googleapis.com/css?family=Source+Code+Pro:400,700"	type="text/css" rel="stylesheet">
		<link href="<c:url value='/resources/worksout/css/reset.css'/>" type="text/css" rel="stylesheet">
		<link href="/html/carhartt/inc/css/jquery.mCustomScrollbar.min.css" type="text/css" rel="stylesheet">
		<link href="<c:url value='/resources/worksout/css/print.css'/>" type="text/css" rel="stylesheet">
		<link href="<c:url value='/resources/worksout/css/common.css'/>" type="text/css" rel="stylesheet">
		
		<link href="<c:url value='/resources/worksout/css/gray.css'/>" type="text/css" rel="stylesheet">
		<link href="<c:url value='/resources/worksout/css/swiper.css'/>" type="text/css" rel="stylesheet">
		
		<link rel="icon" href="/upload/image/favicon/${siteNm }.ico" type="image/x-icon" />
		<script src="<c:url value='/resources/worksout/js/modernizr.js'/>" type="text/javascript" charset="utf-8"></script>
		<script src="<c:url value='/resources/worksout/js/jquery.js'/>" type="text/javascript" charset="utf-8"></script>
		
		<script src="<c:url value='/resources/worksout/js/swipe.js'/>" type="text/javascript" charset="utf-8"></script>
		<script src="<c:url value='/resources/worksout/js/TweenMax.min.js'/>" type="text/javascript" charset="utf-8"></script>
		
		<script src="<c:url value='/resources/worksout/js/jquery.gray.js'/>" type="text/javascript" charset="utf-8"></script>		
		<script src="<c:url value='/resources/worksout/js/jquery.mCustomScrollbar.js'/>" type="text/javascript" charset="utf-8"></script>
		<script src="<c:url value='/resources/worksout/js/common.js'/>" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="<c:url value='/resources/common/frontUtils.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/common/jquery.cookie-1.4.1.min.js'/>"></script>
		<script src="<c:url value='/resources/worksout/js/swiper.jquery.min.js'/>" type="text/javascript" charset="utf-8"></script>
		<!-- 임시 스크립트 입니다. -->
		<script>
		$(function(){
			$(window).load(function()
			{
				$(".panel-body").mCustomScrollbar(
				{
					setHeight: 176
				});
				
				$('.pop_content').on('mouseover', function()
				{
					$('.pop_over_layer_wrap').show();
				});
				
				$('.pop_content').on('mouseleave', function()
				{
					$('.pop_over_layer_wrap').hide();
					$('.pop_over_layer_info_box').hide();
					
					$('.pop_over_layer_trackList_box').hide();
					$('.pop_over_layer_artistInfo_box').hide();
					
					$('.pop_over_layer_bottom').show();
					$('.pop_over_layer_music_ctr > a').removeClass('on');
				});
				
				$('.pop_over_layer_music_ctr > a').on('click', function()
				{
					$('.pop_over_layer_music_ctr > a').removeClass('on');
					if ($(this).hasClass('on'))
					{
						$().removeClass('on');
					}
					else
					{
						$(this).addClass('on');
					}
				});
				
				$('.ui_Info_show').on('click', function()
				{
					$('.pop_over_layer_info_box').show();
					
					$('.pop_over_layer_trackList_box').hide();
					$('.pop_over_layer_artistInfo_box').hide();
					
					$('.pop_over_layer_bottom').hide();
				});
				
				$('.ui_track_show').on('click', function()
				{
					$('.pop_over_layer_info_box').hide();
					
					$('.pop_over_layer_trackList_box').show();
					$('.pop_over_layer_artistInfo_box').hide();
					
					$('.pop_over_layer_bottom').hide();
				});
				
				$('.ui_artist_show').on('click', function()
				{
					$('.pop_over_layer_info_box').hide();
					
					$('.pop_over_layer_trackList_box').hide();
					$('.pop_over_layer_artistInfo_box').show();
					
					$('.pop_over_layer_bottom').hide();
				});
			});
			
		});
		</script>
	</head>
	<body>
		<!-- 사이즈 300 * 450 -->
		<div class="pop_wrap">
			<div class="pop_logo">
				<img src="/html/carhartt/images/common/pop_logo.png" alt="carhartt | radio">
			</div>
			<div class="pop_content">
<!-- 				<img src="/html/carhartt/images/common/pop_img_play.jpg" alt="carhartt | radio"> -->
				<iframe width="100%" height="390" src="${carharttRadioPopup.radioLink }" scrolling="no" frameborder="no" frameborder="0" allowfullscreen ></iframe>
				<a href="#" class="pop_btn_pause">
<!-- 					<img src="/html/carhartt/images/common/pop_btn_pause.png" alt="pause"> -->
				</a>
				<a href="#" style="display:none;" class="pop_btn_play">
					<img src="/html/carhartt/images/common/pop_btn_play.png" alt="play">
				</a>
				<!-- s: 마우스 오버시 나타나는 영역 -->
				<div class="pop_over_layer_wrap">
					<div class="pop_dimm">
						<img src="/html/carhartt/images/common/pop_dimm.png" alt="">
					</div>
					<div class="pop_over_layer_top">
						<div class="pop_over_layer_music_info">
							<span class="img_info">
								<img src="/html/carhartt/images/common/pop_img_thumb03.jpg" alt="">
							</span>
							<span class="txt_info">${carharttRadioPopup.radioTitle }</span>
						</div>
						<div class="pop_over_layer_music_ctr clfix">
							<!-- 버튼에 on 클래스 붙으면 활성화됨 -->
							<a href="#" class="btn ui_Info_show">INFO</a>
							<a href="#" class="btn ui_track_show">TRACKLIST</a>
							<a href="#" class="btn ui_artist_show">ARTIST</a>
							<span class="volume">
								<img src="/html/carhartt/images/common/pop_bu_volume.png" alt="">
							</span>
						</div>
						<div class="pop_over_layer_info_box clfix">
							<div class="panel-collapse">
								<div class="panel-body">
									<p>${carharttRadioPopup.radioInfo }</p>
								</div>
							</div>
						</div>
						<div class="pop_over_layer_trackList_box clfix">
							<div class="panel-collapse">
								<div class="panel-body">
									<p>${carharttRadioPopup.radioTrackList }</p>
								</div>
							</div>
						</div>
						<div class="pop_over_layer_artistInfo_box clfix">
							<div class="panel-collapse">
								<div class="panel-body">
									<p>${carharttRadioPopup.radioArtistInfo }</p>
								</div>
							</div>
						</div>
					</div>
<!-- 						<div class="pop_over_layer_info_box clfix"> -->
<!-- 							<div class="panel-collapse"> -->
<!-- 								<div class="panel-body"> -->
<!-- 									<p>Free spirited and groundbreaking, Carhartt WIP Radio brings you legendary -->
<!-- 										Strata Records, Detroit’s short lived, socially conscious Jazz, Fusion -->
<!-- 										and Funk label from the late 60's and early 70’s. Strata was independent, -->
<!-- 										run and owned by artists, released less than ten records and was established -->
<!-- 										an art gallery-come-live venue that started the first university Jazz -->
<!-- 										music program to educate and create awareness following the Detroit riots -->
<!-- 										of '67 and ’68. In 2010, DJ Amir Abdullah, known as one</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					<!-- 위 pop_over_layer_info_box 열리면 아래 bottom 영역 닫혀야함 -->
					<!-- 위 info box 닫히면 bottom 영역 다시 열려야 함 -->
<!-- 					<div class="pop_over_layer_bottom"> -->
<%-- 						<div class="pop_over_layer_tit">${carharttRadioPopup.radioTitle }</div> --%>
<!-- 						<div class="pop_over_layer_equalizer"> -->
<!-- 							<a href="#" class="pop_btn_pause02"> -->
<!-- 								<img src="/html/carhartt/images/common/pop_btn_pause02.png" alt="pause"> -->
<!-- 							</a> -->
<!-- 							<a href="#" style="display:none;" class="pop_btn_play02"> -->
<!-- 								<img src="/html/carhartt/images/common/pop_btn_play02.png" alt="play"> -->
<!-- 							</a> -->
<!-- 							<span class="equalizer_area"> -->
<!-- 								<img src="/html/carhartt/images/common/pop_img_e.png" alt="equalizer"> -->
<!-- 							</span> -->
<!-- 						</div> -->
<!-- 					</div> -->
				</div>
				<!-- e: 마우스 오버시 나타나는 영역 -->
			</div>
			<div class="pop_thumb_list_wrap">
				<div class="pop_thumb_list_container">
					<ul style="width:1000px;" class="pop_thumb_list clfix">
						<c:choose>
							<c:when test="${not empty carharttRadioList }">
								<c:forEach items="${carharttRadioList}" var="radio" varStatus="listCount">
									<li>
										<a href="<c:url value='/front/popup/carharttRadioPopup?radioNo=${radio.radioNo }' />">
											<span class="img_area">
												<img src="${uploadImage }${radio.banImgUrl }" alt="">
											</span>
											<span class="txt_area">
												<span class="txt01">${radio.radioTitle }</span>
											</span>
										</a>
									</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
<!-- 						<li> -->
<!-- 							<a href="#"> -->
<!-- 								<span class="img_area"> -->
<!-- 									<img src="/html/carhartt/images/common/pop_img_thumb01.jpg" alt=""> -->
<!-- 								</span> -->
<!-- 								<span class="txt_area"> -->
<!-- 									<span class="txt01">1000names</span> -->
<!-- 									<span class="txt02">Radio Show</span> -->
<!-- 								</span> -->
<!-- 							</a> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<a href="#"> -->
<!-- 								<span class="img_area"> -->
<!-- 									<img src="/html/carhartt/images/common/pop_img_thumb02.jpg" alt=""> -->
<!-- 								</span> -->
<!-- 								<span class="txt_area"> -->
<!-- 									<span class="txt01">1000names</span> -->
<!-- 									<span class="txt02">Radio Show</span> -->
<!-- 								</span> -->
<!-- 							</a> -->
<!-- 						</li> -->
					</ul>
				</div>
				<a href="#" class="pop_btn_prev">
					<img src="/html/carhartt/images/common/pop_btn_prev.png" alt="이전으로">
				</a>
				<a href="#" class="pop_btn_next">
					<img src="/html/carhartt/images/common/pop_btn_next.png" alt="다음으로">
				</a>
			</div>
		</div>
	</body>
</html>