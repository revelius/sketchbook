<%--
 * =============================================================================
 * 파일명 : /front/search/lookbookSearchResult.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-17
 *
 * 파일 내용 : SEARCH > 상품목록
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
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm">
	<form:hidden path="searchText" id="searchText"/>
</form:form>		
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
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">SEARCH</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_search_area">
								<!-- snbSearch include -->
								<!-- snbSearch include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="search_tit">
										<strong class="point">"${searchText}"</strong>에 대한 검색결과는 총
										<strong class="point">${totalCnt + goodsTotalCnt + newsTotalCnt + lookbookTotalCnt}건</strong>
										입니다.</div>
								</div>
								<div class="search_area">
									<div class="tab_type01">
										<ul class="tab01_list clfix">
											<li>
												<a href="javascript:SearchType('ONLIEN','${searchText}','${contextPath}');" class="first_child">ONLINE SHOP
													<span>(${goodsTotalCnt })</span>
												</a>
											</li>
											<li>
												<a href="javascript:SearchType('NEWS','${searchText}','${contextPath}');">NEWS
													<span>(${newsTotalCnt})</span>
												</a>
											</li>
											<li>
												<a href="javascript:SearchType('LOOKBOOK','${searchText}','${contextPath}');">LOOKBOOK
													<span>(${lookbookTotalCnt })</span>
												</a>
											</li>
											<li class="on">
												<a href="javascript:void();');">OTHER
													<span>(${totalCnt })</span>
												</a>
											</li>
										</ul>
									</div>
									<div class="other_search_list">
										<dl class="other_list">
											<dt class="tit">ABOUT (1)</dt>
											<dd class="address">
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO</span>
											</dd>
											<dd class="desc">
												<span class="desc_unit">-
													<span class="search_word">CARHARTT WIP</span>의 성공 스토리는1994년 유럽에서부터 시작되었지만, CARHARTT WIP 의 시작은
													1889년 아메리칸 워크웨어를 위해 창립되었던 브랜드로, 오랜 세월동안 산업 노동자들을 위한 아주 튼튼하고 핵심적인 워크웨어입니다..</span>
											</dd>
										</dl>
										<dl class="other_list">
											<dt class="tit">STORE INFO(25)</dt>
											<dd class="address">
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE SEOUL APGUJEONG</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE BUSAN CENTUM CITY</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE MYEONG-DONG</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE MOK-DONG</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE BUSAN SEOMYEON</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> STORE INFO
													<span class="bar">&gt;</span> CARHARTT WIP
													<span class="bar">&gt;</span> STORE HONGDAE WOWSAN</span>
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> DEALERS</span>
											</dd>
											<dd class="desc">
												<span class="desc_unit">BEAKER LAB INCHEON / 인천광역시 부평구 부평동 201-25 / 032 526 5652 / HTTP://WWW.BEAKERSTORE.COM
													/
													<span class="search_word">CARHARTT WIP</span>
												</span>
												<span class="desc_unit">BEAKER LAB INCHEON / 인천광역시 부평구 부평동 201-25 / 032 526 5652 / HTTP://WWW.BEAKERSTORE.COM
													/
													<span class="search_word">CARHARTT WIP</span>
												</span>
											</dd>
										</dl>
										<dl class="other_list">
											<dt class="tit">CUSTOMER CARE(0)</dt>
										</dl>
										<dl class="other_list">
											<dt class="tit">WORK WITH US(24)</dt>
											<dd class="address">
												<span class="address_unit">HOME
													<span class="bar">&gt;</span> WORK WITH US</span>
											</dd>
											<dd class="desc">
												<span class="desc_unit">- CARHARTT WIP 스토어 타임스퀘어점 직원 채용 공고</span>
												<span class="desc_unit">- CARHARTT WIP 스토어 타임스퀘어점 직원 채용 공고</span>
												<span class="desc_unit">- CARHARTT WIP 스토어 타임스퀘어점 직원 채용 공고</span>
											</dd>
										</dl>
									</div>
									<div class="btn_area space01">
										<a href="#">
											<img src="/html/worksout/images/common/btn_loadmore.png" alt="LOAD MORE">
										</a>
									</div>
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