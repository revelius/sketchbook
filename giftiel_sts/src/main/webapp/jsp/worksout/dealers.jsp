<%--
 * =============================================================================
 * 파일명 : /storeInfoAb.jsp(WORKSOUT 압구정)
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
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<h1 class="hide_txt">CARHARTT WIP</h1>
		<div class="dimm">
			<img src="/html/carhartt/images/common/blank_size_100.png" alt="">
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
										<a href="#">STORE INFO</a>
									</li>
									<li>
										<a href="#">DEALERS</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="menu_section">
							<div id="snb_store_info_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">

								<div class="dealers_list_wrap">
									<ul class="dealers_list clfix">

									<c:if test="${siteNo == '10002' }">
										<li>
											<div class="dealers_tit"><span>BEAKER IFC MALL</span></div>
											<div class="dealers_location">- 서울특별시 영등포구 여의도동23 IFC몰</div>
											<div class="dealers_phone">
												<a href="tel:0261375450">- 02-6137-5450</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.beakerstore.com" target="_blank">- www.beakerstore.com</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>BEAKER LIFE PANGYO <br>HYUNDAI DEPARTMENT</span></div>
											<div class="dealers_location">- 경기도 성남시 분당구 판교역로146번길 20 현대백화점</div>
											<div class="dealers_phone">
												<a href="tel:03151701568">- 031-5170-1568</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.beakerstore.com" target="_blank">- www.beakerstore.com</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>BEAKER TIMESQUARE<br>MALL</span></div>
											<div class="dealers_location">- 서울특별시 영등포구 영등포동4가 442 타임스퀘어</div>
											<div class="dealers_phone">
												<a href="tel:0226382436"> - 02-2638-2436</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.beakerstore.com" target="_blank">- www.beakerstore.com</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>CASUALLY</span></div>
											<div class="dealers_location">- 광주광역시 동구 서석로7번길 10-2</div>
											<div class="dealers_phone">
												<a href="tel:06218009710">- 062-1800-9710</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.casually.co.kr" target="_blank">- www.casually.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>ELKARTEL</span></div>
											<div class="dealers_location">- 서울특별시 중구 소공로6길 25 </div>
											<div class="dealers_phone">
												<a href="tel:027530926"> - 02-753-0926</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.elkartel.co.kr" target="_blank">- www.elkartel.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>EZESHOP</span></div>
											<div class="dealers_location">- 경기도 수원시 팔달구 매산로 51</div>
											<div class="dealers_phone">
												<a href="tel:0312509909">- 031-250-9909</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.ezeshop.co.kr" target="_blank">- www.ezeshop.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>FLY TO YOU</span></div>
											<div class="dealers_location">- 대구 중구 동성로2길 49-10</div>
											<div class="dealers_phone">
												<a href="tel:0312509909">- 070-7672-7552</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.flytoyou.co.kr" target="_blank">- www.flytoyou.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>GOOD LUCK</span></div>
											<div class="dealers_location">- 충북 청주시 상당구 상당로59번길 12-10</div>
											<div class="dealers_phone">
												<a href="tel:0312509909">- 043-221-2015</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.goodluckstore.co.kr" target="_blank">- www.goodluckstore.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>PREPARE</span></div>
											<div class="dealers_location">- 제주특별자치도 제주시 서광로32길 21</div>
											<div class="dealers_phone">
												<a href="tel:07042255949">- 070-4225-5949</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.prepare.kr" target="_blank">- www.prepare.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>SOPOOOM</span></div>
											<div class="dealers_location">- 서울특별시 마포구 와우산로 134</div>
											<div class="dealers_phone">
												<a href="tel:07042325324">- 070-4232-5324</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.sopooom.com" target="_blank">- www.sopooom.com</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>SPELLING</span></div>
											<div class="dealers_location">- 서울특별시 마포구 독막로7길 51</div>
											<div class="dealers_phone">
												<a href="tel:023375844">- 02-337-5844</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.spelling.co.kr" target="_blank">- www.spelling.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>THE BOUNCE</span></div>
											<div class="dealers_location">- 서울시 마포구 독막로 92</div>
											<div class="dealers_phone">
												<a href="tel:023224573">- 02 322 2296</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.thebounce.co.kr" target="_blank">- www.thebounce.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>THE X SHOP 1</span></div>
											<div class="dealers_location">- 전라북도 전주시 완산구 전주객사4길 57</div>
											<div class="dealers_phone">
												<a href="tel:0632833177">- 063-283-3177</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.thexshop.co.kr" target="_blank">- www.thexshop.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>THE X SHOP 2</span></div>
											<div class="dealers_location">- 전라북도 전주시 덕진구 명륜4길 11-2</div>
											<div class="dealers_phone">
												<a href="tel:0632763177">- 063-276-3177</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.thexshop.co.kr" target="_blank">- www.thexshop.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>THE X SHOP 3</span></div>
											<div class="dealers_location">- 대전광역시 중구 대종로488번길 39</div>
											<div class="dealers_phone">
												<a href="tel:07077203177">- 070-7720-3177</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.thexshop.co.kr" target="_blank">- www.thexshop.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>TRIPLE STORE</span></div>
											<div class="dealers_location">- 제주특별자치도 제주시 관덕로15길 15</div>
											<div class="dealers_phone">
												<a href="tel:07042005545">- 070-4200-5545</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.triplestore.co.kr" target="_blank">- www.triplestore.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>LUMB STORE</span></div>
											<div class="dealers_location">- 충청남도 천안시 동남구 먹거리10길 32</div>
											<div class="dealers_phone">
												<a href="tel:07075662114">- 070-7566-2114</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.lumbstore.com" target="_blank">- www.lumbstore.com</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>MSK SHOP</span></div>
											<div class="dealers_location">- 서울특별시 강남구 논현로161길 10</div>
											<div class="dealers_phone">
												<a href="tel:07082333107"> - 070-8233-3107</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.mskshop.net" target="_blank">- www.mskshop.net</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>WORKSOUT STORE<br>SEOUL APGUJEONG</span></div>
											<div class="dealers_location">- 서울특별시 강남구 선릉로 157길 20-4</div>
											<div class="dealers_phone">
												<a href="tel:0314661793">- 02-541-0840</a>
											</div>
											<div class="dealers_url">
												<a href="http://www.worksout.co.kr" target="_blank">- www.worksout.co.kr</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>1984</span></div>
											<div class="dealers_location">- 서울특별시 마포구 동교로 194 </div>
											<div class="dealers_phone">
												<a href="tel:023251984">- 02-325-1984</a>
											</div>
										</li>
										<li>
											<div class="dealers_tit"><span>VINYL & PLASTIC</span></div>
											<div class="dealers_location">- 서울 용산구 이태원로 248</div>
											<div class="dealers_phone">
												<a href="tel:023251984">- 02-2014-7800</a>
											</div>
											<div class="dealers_url">
												<a href="http://vinylandplastic.hyundaicard.com" target="_blank">- vinylandplastic.hyundaicard.com</a>
											</div>
										</li>
										</c:if>


























										<c:if test="${siteNo == '10003' }">
          <li>
           <div class='dealers_tit'><span>AROUND THE CORNER</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로12길 24</div>
           <div class='dealers_phone'>
            <a href='tel:025455325'>- 02-545-5325</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.lfmall.co.kr/p2/products/brandGroup?id=3073' target='_blank'>- www.lfmall.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BARUSURF</span></div>
           <div class='dealers_location'>- 강원도 양양군 현남면 동해대로 260</div>
           <div class='dealers_phone'>
            <a href='tel:07044092288'>- 070-4409-2288</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.barusurfyy.com' target='_blank'>- www.barusurfyy.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BOASTFUL</span></div>
           <div class='dealers_location'>- 부산광역시 중구 광복중앙로24번길 4-2</div>
           <div class='dealers_phone'>
            <a href='tel:0512426444'>- 051-242-6444</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.boastful.co.kr' target='_blank'>- www.boastful.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>DAMP</span></div>
           <div class='dealers_location'>- 울산광역시 중구 중앙길 107-1</div>
           <div class='dealers_phone'>
            <a href='tel:07041325173'>- 070-4132-5173</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.dontaskmyplan.com' target='_blank'>- www.dontaskmyplan.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>ELKARTEL</span></div>
           <div class='dealers_location'>- 서울특별시 중구 소공로6길 25</div>
           <div class='dealers_phone'>
            <a href='tel:027530926'>- 02-753-0926</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.elkartel.co.kr' target='_blank'>- www.elkartel.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>ETC SEOUL</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로10길 11, 지하1층</div>
           <div class='dealers_phone'>
            <a href='tel:07075209801'>- 070-7520-9801</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.etcseoul.com' target='_blank'>- www.etcseoul.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>EZE SHOP</span></div>
           <div class='dealers_location'>- 경기도 수원시 팔달구 매산로 51, 동인트루빌 오피스텔 110호</div>
           <div class='dealers_phone'>
            <a href='tel:0312509909'>- 031-250-9909</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.ezeshop.co.kr' target='_blank'>- www.ezeshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>FOLDER</span></div>
           <div class='dealers_location'>- 서울특별시 중구 명동10길 38</div>
           <div class='dealers_phone'>
            <a href='tel:07042203200'>- 070-4220-3200</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.folderstyle.com' target='_blank'>- www.folderstyle.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>GOOD LUCK</span></div>
           <div class='dealers_location'>- 충청북도 청주시 상당구 상당로59번길 12-10</div>
           <div class='dealers_phone'>
            <a href='tel:0432212015'>- 043-221-2015</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.goodluckstore.co.kr' target='_blank'>- www.goodluckstore.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>LUMB STORE</span></div>
           <div class='dealers_location'>- 충청남도 천안시 동남구 먹거리10길 32</div>
           <div class='dealers_phone'>
            <a href='tel:07075662114'>- 070-7566-2114</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.lumbstore.com' target='_blank'>- www.lumbstore.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>MODE MAN</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 양화로23길 42</div>
           <div class='dealers_phone'>
            <a href='tel:07082885258'>- 070-8288-5258</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.mode-man.com' target='_blank'>- www.mode-man.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>PLANET B</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 강남대로 410</div>
           <div class='dealers_phone'>
            <a href='tel:0234535944'>- 02-3453-5944</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.planetboaz.com' target='_blank'>- www.planetboaz.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SOPOOOM</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 와우산로 134</div>
           <div class='dealers_phone'>
            <a href='tel:07042325324'>- 070-4232-5324</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.sopooom.com' target='_blank'>- www.sopooom.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SPELLING</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 독막로7길 51</div>
           <div class='dealers_phone'>
            <a href='tel:023235844'>- 02-323-5844</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.spelling.co.kr' target='_blank'>- www.spelling.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TAKE A STREET</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 양화로 45, 메세나폴리스 106호</div>
           <div class='dealers_phone'>
            <a href='tel:023372090'>- 02-337-2090</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.takeastreet.com' target='_blank'>- www.takeastreet.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE BOUNCE</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 독막로 92</div>
           <div class='dealers_phone'>
            <a href='tel:023222296'>- 02-322-2296</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thebounce.co.kr' target='_blank'>- www.thebounce.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE X SHOP JEON-JU</span></div>
           <div class='dealers_location'>- 전라북도 전주시 완산구 전주객사4길 57,</div>
           <div class='dealers_phone'>
            <a href='tel:0632833177'>- 063-283-3177</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thexshop.co.kr' target='_blank'>- www.thexshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE X SHOP DAE-JEON</span></div>
           <div class='dealers_location'>- 대전광역시 중구 대종로488번길 39
           </div>
           <div class='dealers_phone'>
            <a href='tel:07077203177'>- 070-7720-3177</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thexshop.co.kr' target='_blank'>- www.thexshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TRIPLE STORE</span></div>
           <div class='dealers_location'>- 제주특별자치도 제주시 관덕로15길 15</div>
           <div class='dealers_phone'>
            <a href='tel:07042005545'>- 070-4200-5545</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.triplestore.co.kr' target='_blank'>- www.triplestore.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TRIPLE X</span></div>
           <div class='dealers_location'>- 광주광역시 동구 충장로안길 7</div>
           <div class='dealers_phone'>
            <a href='tel:0622365559'>- 062-236-5559</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.stlive.co.kr' target='_blank'>- www.stlive.co.kr</a>
           </div>
          </li>


										</c:if>






















										<c:if test="${siteNo == '10004' }">
          <li>
           <div class='dealers_tit'><span>8DIVISION</span></div>
           <div class='dealers_location'>- 서울특별시 중구 퇴계로18길 49</div>
           <div class='dealers_phone'>
            <a href='tel:07041350038'>- 070-4135-0038</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.8division.com' target='_blank'>- www.8division.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BESLOW</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 도산대로15길 42</div>
           <div class='dealers_phone'>
            <a href='tel:0234787250'>- 02-3478-7250</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.beslow.co.kr' target='_blank'>- www.beslow.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BOASTFUL</span></div>
           <div class='dealers_location'>- 부산광역시 중구 광복중앙로24번길 4-2</div>
           <div class='dealers_phone'>
            <a href='tel:0512426444'>- 051-242-6444</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.boastful.co.kr' target='_blank'>- www.boastful.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>DAMP</span></div>
           <div class='dealers_location'>- 울산광역시 중구 중앙길 107-1</div>
           <div class='dealers_phone'>
            <a href='tel:07041325173'>- 070-4132-5173</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.dontaskmyplan.com' target='_blank'>- www.dontaskmyplan.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>EZE SHOP</span></div>
           <div class='dealers_location'>- 경기도 수원시 팔달구 매산로 51, 동인트루빌 오피스텔 110호</div>
           <div class='dealers_phone'>
            <a href='tel:0312509909'>- 031-250-9909</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.ezeshop.co.kr' target='_blank'>- www.ezeshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>GOOD LUCK</span></div>
           <div class='dealers_location'>- 충청북도 청주시 상당구 상당로59번길 12-10</div>
           <div class='dealers_phone'>
            <a href='tel:0432212015'>- 043-221-2015</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.goodluckstore.co.kr' target='_blank'>- www.goodluckstore.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>LUMB STORE</span></div>
           <div class='dealers_location'>- 충청남도 천안시 동남구 먹거리10길 32</div>
           <div class='dealers_phone'>
            <a href='tel:07075662114'>- 070-7566-2114</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.lumbstore.com' target='_blank'>- www.lumbstore.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>MODE MAN</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 동교동 150-19</div>
           <div class='dealers_phone'>
            <a href='tel:07082885258'>- 070-8288-5258</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.mode-man.com' target='_blank'>- www.mode-man.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>PENNY ROYAL</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로 72길 10</div>
           <div class='dealers_phone'>
            <a href='tel:0264266446'>- 02-6426-6446</a>
           </div>
           <div class='dealers_url'>
            <a href='http://-' target='_blank'>--</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SOPOOOM</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 와우산로 134</div>
           <div class='dealers_phone'>
            <a href='tel:07042325324'>- 070-4232-5324</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.sopooom.com' target='_blank'>- www.sopooom.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SPELLING</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 독막로7길 51</div>
           <div class='dealers_phone'>
            <a href='tel:023235844'>- 02-323-5844</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.spelling.co.kr' target='_blank'>- www.spelling.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TAKE A STREET</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 양화로 45, 메세나폴리스 106호</div>
           <div class='dealers_phone'>
            <a href='tel:023372090'>- 02-337-2090</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.takeastreet.com' target='_blank'>- www.takeastreet.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE BOUNCE</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 독막로 92</div>
           <div class='dealers_phone'>
            <a href='tel:023222296'>- 02-322-2296</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thebounce.co.kr' target='_blank'>- www.thebounce.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TRIPLE STORE</span></div>
           <div class='dealers_location'>- 제주특별자치도 제주시 관덕로15길 15</div>
           <div class='dealers_phone'>
            <a href='tel:07042005545'>- 070-4200-5545</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.triplestore.co.kr' target='_blank'>- www.triplestore.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>TRIPLE X</span></div>
           <div class='dealers_location'>- 광주광역시 동구 충장로안길 7</div>
           <div class='dealers_phone'>
            <a href='tel:0622365559'>- 062-236-5559</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.stlive.co.kr' target='_blank'>- www.stlive.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>VASKA</span></div>
           <div class='dealers_location'>- 대구광역시 중구 중앙대로 432-1</div>
           <div class='dealers_phone'>
            <a href='tel:0532566222'>- 053-256-6222</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.vaska.kr' target='_blank'>- www.vaska.kr</a>
           </div>
          </li>

										</c:if>
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										<c:if test="${siteNo == '10006' }">
          <li>
           <div class='dealers_tit'><span>AROUND THE CORNER</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로12길 24</div>
           <div class='dealers_phone'>
            <a href='tel:025455325'>- 02-545-5325</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.lfmall.co.kr/p2/products/brandGroup?id=3073' target='_blank'>- www.lfmall.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BARUSURF</span></div>
           <div class='dealers_location'>- 강원도 양양군 현남면 동해대로 260</div>
           <div class='dealers_phone'>
            <a href='tel:07044092288'>- 070-4409-2288</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.barusurfyy.com/' target='_blank'>- www.barusurfyy.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BESLOW</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 도산대로15길 42</div>
           <div class='dealers_phone'>
            <a href='tel:0234787250'>- 02-3478-7250</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.beslow.co.kr/' target='_blank'>- www.beslow.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>BOASTFUL</span></div>
           <div class='dealers_location'>- 부산광역시 중구 광복중앙로24번길 4-2</div>
           <div class='dealers_phone'>
            <a href='tel:0512426444'>- 051-242-6444</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.boastful.co.kr/' target='_blank'>- www.boastful.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>EZE SHOP</span></div>
           <div class='dealers_location'>- 경기도 수원시 팔달구 매산로 51, 동인트루빌 오피스텔 110호</div>
           <div class='dealers_phone'>
            <a href='tel:0312509909'>- 031-250-9909</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.ezeshop.co.kr/' target='_blank'>- www.ezeshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>GOOD LUCK</span></div>
           <div class='dealers_location'>- 충청북도 청주시 상당구 상당로59번길 12-10</div>
           <div class='dealers_phone'>
            <a href='tel:0432212015'>- 043-221-2015</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.goodluckstore.co.kr/' target='_blank'>- www.goodluckstore.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>LUMB STORE</span></div>
           <div class='dealers_location'>- 충청남도 천안시 동남구 먹거리10길 32</div>
           <div class='dealers_phone'>
            <a href='tel:07075662114'>- 070-7566-2114</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.lumbstore.com/' target='_blank'>- www.lumbstore.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>MODE MAN</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 양화로23길 42, 2층</div>
           <div class='dealers_phone'>
            <a href='tel:07082885258'>- 070-8288-5258</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.mode-man.com/' target='_blank'>- www.mode-man.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>MSK SHOP</span></div>
           <div class='dealers_location'>- 서울특별시 종로구 자하문로8길 23, 1층</div>
           <div class='dealers_phone'>
            <a href='tel:07082333107'>- 070-8233-3107</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.mskshop.net/' target='_blank'>- www.mskshop.net</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>OFFICIAL HOLIDAY</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로12길 33</div>
           <div class='dealers_phone'>
            <a href='tel:0234434507 '>- 02-3443-4507 </a>
           </div>
           <div class='dealers_url'>
            <a href='-' target='_blank'>-</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>OHKOOS</span></div>
           <div class='dealers_location'>- 서울특별시 강남구 압구정로46길 31</div>
           <div class='dealers_phone'>
            <a href='tel:025120269'>- 02-512-0269</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.ohkoos.com/' target='_blank'>- www.ohkoos.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SHOPSTAIRS</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 와우산로29라길 19</div>
           <div class='dealers_phone'>
            <a href='tel:07043794149 '>- 070-4379-4149 </a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.shopstairs.com/' target='_blank'>- www.shopstairs.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>SOPOOOM</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 와우산로 134</div>
           <div class='dealers_phone'>
            <a href='tel:07042325324'>- 070-4232-5324</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.sopooom.com/' target='_blank'>- www.sopooom.com</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE BOUNCE</span></div>
           <div class='dealers_location'>- 서울특별시 마포구 독막로 92</div>
           <div class='dealers_phone'>
            <a href='tel:023222296'>- 02-322-2296</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thebounce.co.kr/' target='_blank'>- www.thebounce.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE X SHOP JEON-JU</span></div>
           <div class='dealers_location'>- 전라북도 전주시 완산구 전주객사4길 57,</div>
           <div class='dealers_phone'>
            <a href='tel:0632833177'>- 063-283-3177</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thexshop.co.kr' target='_blank'>- www.thexshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>THE X SHOP DAE-JEON</span></div>
           <div class='dealers_location'>- 대전광역시 중구 대종로488번길 39
           </div>
           <div class='dealers_phone'>
            <a href='tel:07077203177'>- 070-7720-3177</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.thexshop.co.kr' target='_blank'>- www.thexshop.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>UNKNOWN PEOPLE</span></div>
           <div class='dealers_location'>- 서울특별시 용산구 녹사평대로 168-14</div>
           <div class='dealers_phone'>
            <a href='tel:07086352512'>- 070-8635-2512</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.unknown-people.co.kr/' target='_blank'>- www.unknown-people.co.kr</a>
           </div>
          </li>
          <li>
           <div class='dealers_tit'><span>VASKA</span></div>
           <div class='dealers_location'>- 대구광역시 중구 중앙대로 432-1</div>
           <div class='dealers_phone'>
            <a href='tel:0532566222'>- 053-256-6222</a>
           </div>
           <div class='dealers_url'>
            <a href='http://www.vaska.kr/' target='_blank'>- www.vaska.kr</a>
           </div>
          </li>

										</c:if>
										
										
										
									</ul>
								</div>
<!-- 								<div class="btn_area"> -->
<!-- 									<a href="#"> -->
<!-- 										<img src="/html/carhartt/images/common/btn_loadmore.png" alt="LOAD MORE"> -->
<!-- 									</a> -->
<!-- 								</div> -->
							</div>
						</div>
						<div class="etc_section">

						</div>
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