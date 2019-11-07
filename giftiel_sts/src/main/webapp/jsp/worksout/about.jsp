<%--
 * =============================================================================
 * 파일명 : /about.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-08-17
 *
 * 파일 내용 : About
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
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<h1 class="hide_txt">${siteNm }</h1>
		<div class="dimm">
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
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
						<div class="location_list_wrap">
							<div class="location_list_container">
								<ul class="location_list clfix">
									<li class="home">
										<a href="<c:url value='/front/main'/>">HOME</a>
									</li>
									<li>
										<a href="#">ABOUT</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="menu_section">
							<div id="snb_about_us">
								<!-- snbAboutUs include -->
								<!-- snbAboutUs include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="work_with_us_area">
									<div class="work_with_us_visual">
										<img src="/resources/${siteNm }/images/common/img_about_us.jpg" alt="${siteNm }">
									</div>
									<c:if test="${siteNo == '10001' }">
										<dl class="about_us_txt clfix first_child">
											<dt>NAME</dt>
											<dd>WORKSOUT INC.</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>FOUNDED IN</dt>
											<dd>2003</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>HEADQUARTER</dt>
											<dd>SEOUL, KOREA</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>OWNED BY</dt>
											<dd>SEUNGHYUK KANG &amp; SUNYOUNG PARK</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>BUSINESS TYPE</dt>
											<dd>CLOTHING &gt; RETAIL | DISTRIBUTION | PRODUCTION</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>FIELD</dt>
											<dd>"CONTEMPORARY STREET CULTURE"</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>BRANDS PRODUCTION</dt>
											<dd>COUR.AGE</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>BRANDS DISTRIBUTION</dt>
											<dd>CARHARTT WIP | OBEY CLOTHING | BRIXTON | DEUS EX MACHINA |
												<br> NIXON | LEXDRAY | GOOD WORTH | DR.COLLECTORS | SATTA</dd>
										</dl>
										<dl class="about_us_txt clfix">
											<dt>MOTTO</dt>
											<dd>"GIRLS OVER FOOD - LIFE OVER MONEY."</dd>
										</dl>
									</c:if>
									
									
									<c:if test="${siteNo == '10002' }">
										<!-- carhartt -->
										<div class="about_us_txt02 first_child">Carhartt Work in Progress (이하 Carhartt WIP)는 Carhartt라는 브랜드가 가지고 있는 정체성을
											전위적이고 현대적인 방식으로 재해석한다.</div>
										<div class="about_us_txt02">Hamilton Carhartt는 1889년 디트로이트에서 Carhartt Company를 설립했다. 초기 제품들은 데님과 덕
											캔버스로 만들어진 작업복들이었고, 이 중에서 Carhartt만의 브라운 색으로 대표되는 덕 캔버스는 브랜드를 상징하는 원단으로
											자리 잡는다. 설립 이래 Carhartt는 “Best in Class”라는 모토 아래 최상의 완성도, 내구성, 그리고 안정감을
											추구하는 의류만을 공급하기 위해 헌신해오고 있다.</div>
										<div class="about_us_txt02">1994년에 설립된 Work in Progress는 유럽을 관통하는 유통망을 구축하며 Carhartt를 대표하는 클래식 제품들을
											유럽시장에 소개하기 시작했다. 결과는 즉각적인 성공이었다. Work in Progress를 통해 소개된 Carhartt 제품들은
											클래식한 미국식 의복에 열광하는 유럽인들과 막 싹이 트이고 있던 유럽의 도시 문화 향유집단을 단숨에 사로잡아 버린다.</div>
										<div class="about_us_txt02">Work in Progress가 독립적으로 디자인 한 유럽시장만을 위한 컬렉션은 1997년에 처음으로 소개됐다. 그 이후, 미국
											미시건 주, 디트로이트에 위치한 Carhartt와의 라이선스 및 적극적인 협력 관계를 토대로, Carhartt WIP는 현대적인
											도시 생활양식을 위해 재해석된 워크웨어 바탕의 컬렉션을 선보이고 있다. Carhartt의 핵심가치인 높은 완성도, 내구성,
											편안함을 지켜나가며, 전세계적인 인지도와 두터운 팬 층을 가지고 있는 브랜드가 오늘 우리가 접하고 있는 Carhartt WIP이다.
										</div>
									</c:if>
									<c:if test="${siteNo == '10003' }">
										<!-- obey -->
										<div class="about_us_txt02 first_child">Obey Clothing은 아티스트 Shepard Fairey에 의해 탄생했다.
										</div>
										<div class="about_us_txt02">1989 년 ‘오베이 자이언트’ 라는 아이콘을 창조한 Shepard Fairey는 레슬러 거인 앙드레의 얼굴로 아이콘을 만들어
											뉴욕에서 도쿄, 베를린까지 여러 도시에 아이콘을 설치하고, 수백만 명의 사람들이 무엇인지도 모른 채 지나치는 것을 현상학 캠페인의
											일환으로 삼았다. Shepard Fairey가 처음에 포스터를 붙였던 것은 대중적인 상업주의와 안일한 자기 만족감에 취해 표류하는
											세상에 맞서는 정치적인 행동이었다.
										</div>
										<div class="about_us_txt02">“사람들은 이미지를 간직하고 그 이미지를 통해 자기 자신을 정의한다.” Shepard Fairey는 패션이 이 정의의 대표적인
											예라 생각하고, 대부분의 사람들이 가지고 있는 것을 따라 소유하여 소속감을 느끼고자 하는 심리와 누구나 가지고 있는 것은 원하지
											않는다는 심리 사이의 역학 관계를 바탕으로 2001년 Obey Clothing을 본격적으로 진행한다.
										</div>
										<div class="about_us_txt02">현재 Obey Clothing은 Shepard Fairey의 예술적 철학이 담긴 약 24가지 핏의 그래픽 티셔츠와 팬츠, 악세사리,
											여성 제품까지 전 세계적으로 폭 넓은 사랑을 받고 있으며 아티스트, 글로벌 브랜드와의 협업으로 브랜드의 이미지를 굳건히 하고
											있다.
										</div>
									</c:if>
									<c:if test="${siteNo == '10004' }">
										<!-- Brixton -->
										<div class="about_us_txt03 first_child">INSPIRED BY MUSIC, CULTURE AND THE PEOPLE
										</div>
										<div class="about_us_txt03">브릭스톤은 유니크한 제품을 통해 그들의 라이프스타일을 보여주고 싶어하는 3명의 디렉터들에 의해 2004년 창립 되었습니다.
										</div>
										<div class="about_us_txt03">그들의 모토는 유행과 시대에 구애 받지 않는 심플한 디자인을 선보이는 것이었으며, 현재 California에 본거지를 두고 스케잇,
											음악, 사진, 바이크 등 자유롭게 살고 있는 모든 사람들과 그러한 문화 주변의 모든 것들을 지지하며 응원하고 있습니다.
										</div>
									</c:if>
									<c:if test="${siteNo == '10006' }">
										<!-- DEUS -->
										<div class="about_us_txt02 first_child">Deus는 2006년 호주에서 탄생하였습니다.
										</div>
										<div class="about_us_txt02">Deus는 하나의 브랜드 그 이상이자, 한 문화입니다. 단지 커스텀 부품들과 모터사이클을 파는 곳이 아니라, 창조적인 문화를 함께 즐기는 곳입니다.
										기계에 대한 진정성과 즐거움을 가지고 있다면, 그 어느 누구든 환영합니다. 포괄성, 진정성, 열정, 이 세 가지는 Deus가 전 세계와 함께 하는
										요소입니다.
										</div>
										<div class="about_us_txt02">Sydney의 'The House of Simple Pleasures' 매장을 첫 오픈 후, 전 세계에 독특한 Deus의 열정을 전파하고 있습니다. 모터사이클 커스텀을 베이스로
										현재는 서핑, 자전거 커스텀 사업으로 영역을 넓혔으며, 카페, 바버 샵의 문화까지 아우르는 라이프스타일 브랜드입니다.
										</div>
										<div class="about_us_txt02">Deus 의류는 이러한 다양한 문화를 바탕으로 만들어집니다. 베이직한 아이템들로 구성되어 있으며, 심플함 속에 화려한 프린팅과 센스 있는 컬러 구성,
										느낌을 자랑합니다.
										</div>
									</c:if>
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