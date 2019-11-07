<%--
 * =============================================================================
 * 파일명 : /contactUs.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-06-25
 *
 * 파일 내용 : Contact US
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
		<script type="text/javascript">
		    //상세페이지 이동
		    goDetail = function(e,path){
		    	var $target = $(e);
		    	var withusSeq = $target.attr('data-withusSeq');
		    	
		    	$("#txtNo").val(withusSeq);
		    	$("#schForm").attr("action",path);
		    	$("#schForm").submit();
		    };
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
		</div>
<form:form id="schForm" name="schForm" method="GET" modelAttribute="searchForm" onsubmit="">
	<form:hidden path="page" id="page"/>
	<form:hidden path="txtNo" id="txtNo"/>
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
								<a href="#">WORK WITH US</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_work_with_us_area">
								<!-- snbWorkWithUs include -->
								<!-- snbWorkWithUs include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="work_with_us_area">
									<!-- 
									<div class="work_with_us_visual">
										<img src="/html/worksout/images/common/img_work_with_us01.jpg" alt="worksout">
									</div>
									<dl class="work_with_us_txt">
										<dt>COMPANY INFO</dt>
										<dd>CARHARTT WIP의 성공 스토리는1994년 유럽에서부터 시작되었지만, CARHARTT WIP 의 시작은 1889년 아메리칸
											워크웨어를 위해 창립되었던 브랜드로, 오랜 세월 동안 산업 노동자들을 위한 아주 튼튼하고 핵심적인 워크웨어 제품들을 생산
											및 공급 하였으며 현재에 이르러 세계 최고의 WORK WEAR 로서 이름을 날린다.</dd>
										<dd>CARHARTT WIP 의 초대 대표 Hamilton Carhartt 는 “CARHARTT WIP 는 사람들을 위한 옷을 생산함에
											있어 훌륭한 직원들이 있는 제조업체이기에 소비자는 분명 매우 큰 긍지를 느낄 것으로 믿는다.” 처럼, 스스로 매우 긍지를
											가지고 탄탄한 양질의 옷을 공급해 왔다. 현재의 CARHARTT WIP 는 1994년부터 STREET-WEAR 를 유럽에
											전파하면서 유럽 최고의 STREET-WEAR 로 재탄생하게 되었으며, SKATE , BMX , ARTIST 까지 모든 영역에서
											최고의 입지를 다지게 되었다. 최근에는 CARHARTT STREET-WEAR 에서 CARHARTT WIP 로 브랜드의 이미지
											변신을 하고 있으며, STREET-WEAR 그리고 CASUAL 을 지향하는 세계적인 브랜드로의 항해를 시작하고 있다.</dd>
									</dl>
									-->
									<p class="work_with_us_tit">OPEN POSITIONS</p>
									<table class="tbl_col03">
										<caption>open positions 테이블로 구분, 지역, 모집분야, 기간에 대해 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col" class="first_child">구분</th>
												<th scope="col">지역</th>
												<th scope="col">모집분야</th>
												<th scope="col" class="last_child">기간</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${not empty workwithUsList }">
													<c:forEach items="${workwithUsList}" var="workwithUs" varStatus="listCount">
													<tr>
														<td class="first_child tbl_layout01">
															<div class="mobile_th">구분</div>
															<div class="tbl_cont">
																<a href="#" onclick="javascript:goDetail(this,'<c:url value='/front/workWithUsDetail' />');" data-withusSeq="<c:out value='${workwithUs.withusSeq}'/>">${workwithUs.withusCls}</a>
															</div>
														</td>
														<td class="tbl_layout02">
															<div class="mobile_th">지역</div>
															<div class="tbl_cont">${workwithUs.withusArea}</div>
														</td>
														<td class="tbl_layout03">
															<div class="mobile_th">모집분야</div>
															<div class="tbl_cont">${workwithUs.withusCl}</div>
														</td>
														<td class="tbl_layout04">
															<div class="mobile_th">기간</div>
															<div class="tbl_cont">${workwithUs.strDts} ~ ${workwithUs.endDts}</div>
														</td>
													</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
													<td colspan="4">
														<div class="tbl_cont">조회 결회가 없습니다.</div>
													</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
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