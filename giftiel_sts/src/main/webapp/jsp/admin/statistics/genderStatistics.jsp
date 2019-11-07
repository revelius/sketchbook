<%--
 * =============================================================================
 * 파일명 : /statistics/genderStatistics.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-07-10
 *
 * 파일 내용 : 통계 남녀비율
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<jsp:include page="/jsp/admin/include/head.jsp" />
<script type="text/javascript">
	$(function() {

		$("a[href=#]").attr("href", "javascript:void(0);");

		// datepicker 
		$(".datepicker1, .datepicker2")
				.datepicker(
						{
							inline : true,
							dateFormat : "yy-mm-dd", /* 날짜 포맷 */
							showOn : "both",
							buttonImage : "${pageContext.request.contextPath}/resources/admin/images/common/icon2.gif",
							buttonImageOnly : true,
							minDate : '-30y',
							showMonthAfterYear : true, /* 년과 달의 위치 바꾸기 */
							/* 한글화 */
							monthNames : [ '.01', '.02', '.03', '.04', '.05',
									'.06', '.07', '.08', '.09', '.10', '.11',
									'.12' ],
							monthNamesShort : [ '1월', '2월', '3월', '4월', '5월',
									'6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
							dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
							dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
							showAnim : 'slideDown',
							/* 날짜 유효성 체크 */
							onClose : function(selectedDate) {
								$('#fromDate').datepicker("option", "minDate",
										selectedDate);
							}
						});
		$('#ui-datepicker-div').addClass('dateCal');

		/*★★★★★ 기간 검색조건 START ★★★★★*/
		if ($("#searchStrDtm").val() == "") {//default기간 셋팅
			setSearchPeriod("set1");
		}

		//기간검색 이벤트 추가
		$("a[href=#]").attr("href", "javascript:void(0);");
		$('#set1').on('click', function(e) {
			setSearchPeriod("set1");
		});
		$('#set2').on('click', function(e) {
			setSearchPeriod("set2");
		});
		$('#set3').on('click', function(e) {
			setSearchPeriod("set3");
		});
		$('#set4').on('click', function(e) {
			setSearchPeriod("set4");
		});
		$('#set5').on('click', function(e) {
			setSearchPeriod("set5");
		});
		$('#set6').on('click', function(e) {
			setSearchPeriod("set6");
		});
		$('#set7').on('click', function(e) {
			setSearchPeriod("set7");
		});

		//기간설정
		function setSearchPeriod(pCode) {
			var gubun = "";
			var period = 0;
			if (pCode == "set1") {
				gubun = "day";
			} else if (pCode == "set2") {
				gubun = "day";
				period = -1;
			} else if (pCode == "set3") {
				gubun = "thisMonth";
			} else if (pCode == "set4") {
				gubun = "day";
				period = -7;
			} else if (pCode == "set5") {
				gubun = "day";
				period = -15;
			} else if (pCode == "set6") {
				gubun = "month";
				period = -1;
			} else if (pCode == "set7") {
				gubun = "month";
				period = -2;
			}
			setdate(gubun, period);
		}

		//기간 실행
		function setdate(gubun, period) {
			var today = new Date();
			var start_month = (today.getMonth() + 1);
			var start_day = today.getDate();
			start_month = (start_month < 10) ? "0" + start_month : start_month;
			start_day = (start_day < 10) ? "0" + start_day : start_day;
			var start_date = today.getFullYear() + "-" + start_month + "-"
					+ start_day;

			if (gubun == 'day') {
				today.setDate(today.getDate() + period);
			} else if (gubun == 'month') {
				today.setMonth(today.getMonth() + period);
			} else if (gubun == 'thisMonth') {
				today.setDate(1);
			}

			var end_month = (today.getMonth() + 1);
			var end_day = today.getDate();
			end_month = (end_month < 10) ? "0" + end_month : end_month;
			end_day = (end_day < 10) ? "0" + end_day : end_day;
			var end_date = today.getFullYear() + "-" + end_month + "-"
					+ end_day;
			$("#searchStrDtm").val(end_date);
			$("#searchEndDtm").val(start_date);
		}
		;
		/*★★★★★ 기간 검색조건 END ★★★★★*/

		//타입 이동
		selectType = function(str, col) {
			$("#dateType").val(str);
			if (str != "All") {
				$("#orderBy").val(col);
			}
			$("form#schForm").submit();
		};
		//페이징 처리
		paging = function(page) {
			document.getElementById("page").value = page;
			$('#btn_search').click();
		};
		//결과 갯수 셋팅
		doNumList = function() {
			$('#btn_search').click();
		};
		
		//리스트 검색 공통
		$('#btn_search')
				.click(
						function() {
							var frm = document.schForm;
							frm.target = '_self';
							frm.action = "<c:url value='/admin/statistics/genderStatistics'/>";
							frm.submit();
						});

		//검색 초기화 버튼
		$('#btn_reset').click(function() {
			$(':input').each(function(index) {
				if ($(this).attr('type') == "text") {
					$(this).val("");
				}
			});
			// 당일로 셋팅 후 시작일을 그달에 1일로 변경
			setSearchPeriod("set3");
		});
		
	    //엑셀 다운로드
	    $('#btn_excel').click(function() {
	    	$("#excel").val("true");
	    	$('#btn_search').click();
	    	$("#excel").val("false");
	    });	
	});
</script>

</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp" />
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="static" />
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<form:form id="schForm" name="schForm" method="post"
					modelAttribute="searchForm" onsubmit="">
					<form:hidden path="excel" id="excel"/>
					<div class="contents">
						<h3><span class="icon1"></span>통계/분석 &gt; 회원통계 &gt; 남여비율통계</h3>
<!-- 						<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 						<div class="helpBox"> -->
<!-- 							<ul class="boxLi"> -->
<!-- 								<li>- 사용자 문의사항을 확인하실 수 있습니다.</li> -->
<!-- 								<li>- 기간검색은 작성일 기준으로 검색됩니다.</li> -->
<!-- 								<li>- 첫번째 문의사항은 ‘문의’로 표시되며 답변에 대한 문의사항 입력시 ‘재문의’로 표시됩니다.</li> -->
<!-- 								<li>- 첨부파일 선택시 다운로드 됩니다.</li> -->
<!-- 							</ul> -->
<!-- 							<a href="#" class="close">X</a> -->
<!-- 						</div> -->
						<div class="first">
							<div class="tableType2">
								<table>
									<caption>배송검색</caption>
									<colgroup>
										<col width="100px">
										<col width="*">
										<col width="120px">
									</colgroup>
									<tbody>
										<tr>
											<th scope="col">기간</th>
											<td colspan="5"><a href="#" id="set1" class="btnType1">당일</a>
												<a href="#" id="set2" class="btnType1">전일</a> <a href="#"
												id="set3" class="btnType1">당월</a> <a href="#" id="set4"
												class="btnType1">1주</a> <a href="#" id="set5"
												class="btnType1">15일</a> <a href="#" id="set6"
												class="btnType1">한달</a> <a href="#" id="set7"
												class="btnType1">두달</a> <br />
											<br />
												<div class="wrap">
													<form:input path="searchStrDtm" id="searchStrDtm"
														name="searchStrDtm" readonly="true" cssClass="datepicker1" />
													~
													<form:input path="searchEndDtm" id="searchEndDtm"
														name="searchEndDtm" readonly="true" cssClass="datepicker2" />
												</div></td>
											<td rowspan="5" class="bd_left"><a href="#"
												class="btnType2" id="btn_search">검색</a> <br />
											<br /> <a href="#" class="btnType1" id="btn_reset">초기화</a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- section -->
						<div class="section a2">
							<div class="tableTitle">
								<div class="left">${dateText }</div>
							</div>
							<div class="tableType1">
								<table>
									<caption>남여비율통게 그래프</caption>
									<colgroup>
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="*" />
									</colgroup>
									<thead>
										<tr>
											<th scope="row">구분</th>
											<th scope="row">회원수</th>
											<th scope="row">신규가입</th>
											<th scope="row">탈퇴</th>
											<th scope="row">비율</th>
											<th scope="row">그래프</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>${genderVisit[0].firstColumn}</td>
											<td>${genderVisit[0].sexCnt }</td>
											<td>${genderVisit[0].newSex }</td>
											<td>${genderVisit[0].benSex }</td>
											<td>${genderVisit[0].totAvg }%</td>
											<td><span class="graphArea"><span class="barRed"
													style="width: ${genderVisit[0].totAvg }%">${genderVisit[0].totAvg
														}%</span></span></td>
										</tr>
										<tr>
											<td>${genderVisit[1].firstColumn}</td>
											<td>${genderVisit[1].sexCnt }</td>
											<td>${genderVisit[1].newSex }</td>
											<td>${genderVisit[1].benSex }</td>
											<td>${genderVisit[1].totAvg }%</td>
											<td><span class="graphArea"><span class="barBlue"
													style="width: ${genderVisit[1].totAvg }%">${genderVisit[1].totAvg
														}%</span></span></td>
										</tr>
										<tr>
											<td>${genderVisit[2].firstColumn}</td>
											<td>${genderVisit[2].sexCnt }</td>
											<td>${genderVisit[2].newSex }</td>
											<td>${genderVisit[2].benSex }</td>
											<td>${genderVisit[2].totAvg }%</td>
											<td><span class="graphArea"><span class="barGreen"
													style="width: ${genderVisit[2].totAvg }%">${genderVisit[2].totAvg
														}%</span></span></td>
										</tr>
									</tbody>
									<tfoot>
										<tr class="txtBold">
											<th scope="col">${genderVisit[3].firstColumn}</th>
											<td class="tdBg">${genderVisit[3].sexCnt }</td>
											<td class="tdBg">${genderVisit[3].newSex }</td>
											<td class="tdBg">${genderVisit[3].benSex }</td>
											<td class="tdBg">${genderVisit[3].totAvg }%</td>
											<td class="tdBg"></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						<!-- //section -->
						
						<!--[s] 엑셀 다운로드 -->
						<div class="paging">
							<div class="right">
								<a href="#" class="btnType2" id="btn_excel">엑셀다운로드</a>
							</div>
						</div>
						<!--[e] 엑셀 다운로드 -->
							
					</div>
				</form:form>
				<!--[e] contents -->
		</div>
		<!--[e] container -->
		<!--[s] footer -->
		<jsp:include page="/jsp/admin/include/footer.jsp" />
		<!--[e] footer -->
		</div>
	</div>
</body>
</html>