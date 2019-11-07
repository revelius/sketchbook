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
// 			//파일다운로드
// 		    fileExport= function(e){
// 		    	var $target = $(e);
// 		    	var fileName = $target.attr('data-file');
		    	
// 		    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"'/>");
// 		    };
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
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
<!-- 									<div class="work_with_us_visual"> -->
<!-- 										<img src="/html/worksout/images/common/img_work_with_us_view01.jpg" alt="worksout"> -->
<!-- 									</div> -->
									<dl class="work_with_us_info">
<%-- 										<dt class="main_tit">${workWithUs.withusCls}</dt> --%>
										<dd>${workWithUs.dtlDesc }</dd>
<!-- 										<dd class="main_copy">칼하트WIP 코리아와 함께새로운 미래를 개척해나갈 인재를 모집 합니다.</dd> -->
<!-- 										<dt>모집분야 &amp; 모집인원</dt> -->
<!-- 										<dd class="last_child">칼하트WIP 스토어 영등포 타임스퀘어점 1명</dd> -->
<!-- 										<dt>지원자격</dt> -->
<!-- 										<dd class="last_child">20세이상의 남, 여 누구나 지원 가능합니다. (남성의 경우 군필자 지원가능)</dd> -->
<!-- 										<dt>내용</dt> -->
<!-- 										<dd> -->
<!-- 											<span class="sentence01">서류접수기간: 2014년 12월 04일부터 2014년 12월 17일까지</span> -->
<!-- 											<span class="sentence01">서류접수 후 1차합격자에 한해 개별면접 후 최종선발</span> -->
<!-- 										</dd> -->
<!-- 										<dd> -->
<!-- 											<span class="sentence01">1차합격발표: 2014년 12월 18일</span> -->
<!-- 											<span class="sentence01">2차심층면접: 2014년 12월 19일</span> -->
<!-- 										</dd> -->
<!-- 										<dd> -->
<!-- 											<span class="sentence01">임금: 상담 후 결정 / 휴무: 월 7회 휴무</span> -->
<!-- 										</dd> -->
<!-- 										<dd class="last_child"> -->
<!-- 											<span class="sentence01">반드시 아래 첨부된 입사지원서를 다운받은 후 작성하여</span> -->
<!-- 											<span class="sentence01">jobs@carhartt-wip.co.kr 로 첨부하여 보내주시기 바랍니다.</span> -->
<!-- 											<span class="sentence01">이력서 작성 시 사진첨부는 필수사항이니 참고하시기 바랍니다.</span> -->
<!-- 											<span class="sentence01">감사합니다.</span> -->
<!-- 										</dd> -->
									</dl>
								</div>
								<div class="btn_area04 clfix space01">
									<div class="btn01">
										<a href="http://worksout60.cafe24.com/upload/file/20151015/workswithus.doc" class="btn_black01">입사지원서 다운로드</a>
									</div>
								</div>
								
								<div class="btn_area">
									<a href="<c:url value='/front/workWithUsList' />" class="btn_animate01" data-id="btnArrowAnimate" data-btn-type="horizon">
										<span class="txt color_gray">LIST</span>
										<span class="animate" style="display:none;">
											<!-- <img src="/resources/worksout/images/common/bu_arrow_top02.png" alt=""> -->
										</span>
									</a>
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