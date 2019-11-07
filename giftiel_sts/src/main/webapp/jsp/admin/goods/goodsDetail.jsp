<%--
 * =============================================================================
 * 파일명 : /goods/goodsDeatail.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리 > 상품목록
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<jsp:include page="/jsp/admin/include/head.jsp"/>
	<jsp:include page="/jsp/common/froalaEditor2.3.2.jsp"/>
	<script type="text/javascript" src="<c:url value='/resources/common/__jquery.tablesorter/jquery.tablesorter.min.js'/>"></script>
	<script type="text/javascript">
	var currentEditorId = "0";
	
    $(function() {
    	
//     	$("textarea#bsDesc").editable({inlineMode: false, language: 'ko', theme: 'gray'});
// 		$("textarea#dtlDesc").editable({inlineMode: false, language: 'ko', theme: 'gray'});
// 		ver2.0
		$("textarea#bsDesc").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
		$("textarea#dtlDesc").froalaEditor({inlineMode: false, language: 'ko', theme: 'gray'});
    
		// datepicker 
		$( ".datepicker1, .datepicker2" ).datepicker({
			inline: true, 
			dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
			showOn: "both", 
			buttonImage: "${contextPath }/resources/admin/images/common/icon_calender.gif",
			buttonImageOnly: true, 
			minDate: '-30y', 
			showMonthAfterYear: true,   /* 년과 달의 위치 바꾸기 */ 
			/* 한글화 */ 
			monthNames : ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'], 
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
			showAnim: 'slideDown', 
			/* 날짜 유효성 체크 */ 
			onClose: function( selectedDate ) { 
			  $('#fromDate').datepicker("option","minDate", selectedDate); 
			} 
		});
		$('#ui-datepicker-div').addClass('dateCal');
		//이미지 추가
	   addimage = function() {
	    	var idx = $("tr#goodsImage").length;
	    	var id = "goodsImage" + idx; 
	    	var name = "goodsImages["+idx+"].imgUrl";
	    	
	    	var id2 = "goodsImagePrir" + idx;
	    	var name2 = "goodsImages["+idx+"].prir";
	    	
	    	var html = "<tr id='goodsImage'>";
	    		html += "<td><img src=\"<c:url value='/resources/common/images/noimages.png'/>\" id=\""+id+"\" width=\"60px\" height=\"64px\" style=\"vertical-align: bottom;\"></td>&nbsp;";
	    		html += "<td><input id=\""+id+"\" name=\""+name+"\" type=\"text\">&nbsp;";
	    		html += "<a href=\"javascript:openFileUploadPop('image','"+id+"','goods');\" class=\"btnType2\" style=\"vertical-align: middle;\">파일첨부</a><br/></td>";
	    		html += "<td><input id=\""+id2+"\" name=\""+name2+"\" type=\"text\" value=\""+parseInt(idx)+"\"></td>";
	    		html += "</tr>";
	    	$("table#goodsImages tbody").append(html);
	    };
	    
	    //상품정보고시 데이터 가져오기 AJAX
		getGoodsAddInfoData = function(gdsInfoNo) {
			var formdata = {};
			formdata = "gdsInfoNo=" + gdsInfoNo;
			
			$.ajax({
		        url : "<c:url value='/admin/goods/goodsAddInfoAjax'/>",
		        type: "post",
		        data : formdata,
		        async: false,
		        success : function(responseData){
		        	try{
		        		$("#addInfoTableDiv").show();
		        		
			            var data = jQuery.parseJSON(responseData);
			            $('#addInfoTable tbody').html('');
			            $('#addInfoTable tbody').html('<tr><th>제목</th><td id=\"title\"></td></tr><tr><th rowspan=\"10\">상품정보고시<br />항목</th></tr>');
			            
			            $("#title").html(data.gdsInfoNm);
			            $("#upd_btn").attr("href","javascript:openGoodsUpdInfo('"+data.gdsInfoNo+"');")
			            
			            for(var i=0;i<data.goodsAddInfos.length;i++){
				    	    	
			            	var html = "<tr>";
			    	    		html += "<td>"+data.goodsAddInfos[i].title+" : "+data.goodsAddInfos[i].txt+"</td>";
			    	    		html += "</tr>";
			    	    		
			    	    		$('#addInfoTable > tbody:last').append(html);	
			            }
		        	}catch(e){
		        		alert(e);
		        	}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};    
		
		//저장
	    $("#btn_save").click(function() {
	    	var frm = document.goodsForm;
	        frm.target = '_self';
	        frm.action = 'saveGoods';
	        
	        console.log(frm.bsDesc.value);
	        frm.submit();
	    });
		
		$("#btn_list").click(function(){
			location.href="goodsList";
		});
		
		//판매기간 설정
	    slTermSetting = function(status) {
			if(status == "GD00501"){
				$("#slStrDtm").val("2015-01-01");
				$("#slEndDtm").val("2099-12-31");
				$("#slDtmCal").hide();
			}else{
				$("#slStrDtm").val("");
				$("#slEndDtm").val("");				
				$("#slDtmCal").show();
			}
	    };
    });												
	
    //페이지 init
    $(window).load(function() {
    	//상품정보고시 view
    	if($("select#gdsInfoNo").val() != ""){
        	$("#addInfoTableDiv").show();
        	getGoodsAddInfoData($("select#gdsInfoNo").val());    		
    	}
    	
    	//판매 기간에 따른 날짜 셋팅
    	if($("input[name='slTermCls']:checked").val() == "GD00501"){
			$("#slStrDtm").val("2015-01-01");
			$("#slEndDtm").val("2099-12-31");    		
    		$("#slDtmCal").hide();
    	}else{
    		$("#slDtmCal").show();
    	}
    	
		//드래그앤 드롭 테이블 초기화
		$( "#goodsImages tbody" ).sortable({
        	placeholder: "ui-state-highlight",
        	update: function( event, ui ) {
				for ( var i = 0; i < $("#goodsImages tbody tr").size(); i++) {
					console.log("i=======" + i);
					$("input#goodsImagePrir").eq(i).val(i);
				}
        	}
       	});    	
    });    
    </script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
			<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
					<jsp:include page="/jsp/admin/include/leftMenu.jsp">
						<jsp:param name="menuFlag" value="goods"/>
						<jsp:param name="onChk" value="goodsList"/>
					</jsp:include>
				<!--[e] lnb -->
				<form:form id="goodsForm" name="goodsForm" method="post" modelAttribute="goodsForm" onsubmit="return check(form)">
				<form:hidden path="ubiGoods.ubiGdsNo"/>
				<form:hidden path="ubiGoods.ubiGdsSize"/>
				<form:hidden path="ubiGoods.seasonCode"/>
				<form:hidden path="ubiGoods.category1Code"/>
				<form:hidden path="ubiGoods.category2Code"/>
				<form:hidden path="ubiGoods.sex"/>
				<form:hidden path="ubiGoods.brandCode"/>
				<!--[s] contents -->
				<div class="contents">
					<!--[s] 카테고리관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>상품등록</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 가격과 상품이미지 설정하여 상품 등록합니다.</li>
								<li>- <span class="highlight">*</span>로 설정된 부분은 필수 입력하셔야 합니다.</li>
							</ul>
							<div class="tableType2">
								<table>
								<caption>상품등록 폼</caption>
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>상품코드[컬러]</th>
										<td>${goodsForm.ubiGoods.ubiGdsNo }[${goodsForm.ubiGoods.color }]</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 카테고리</th>
										<td>
											${goodsForm.ubiGoods.season } > ${goodsForm.ubiGoods.category1 } > ${goodsForm.ubiGoods.category2 }
										</td>
									</tr>
									<tr>
										<th>Brand Lael</th>
										<td>
											${goodsForm.ubiGoods.brand }
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 상품명</th>
										<td>${goodsForm.ubiGoods.ubiGdsNm }
									</tr>
									<tr>
										<th>상품키워드</th>
										<td>
											<form:input path="goodsTags[0].tagNm" id="goodsTags[0].tagNm" cssClass="mb5"/>&nbsp;
											<form:input path="goodsTags[1].tagNm" id="goodsTags[1].tagNm" cssClass="mb5"/>&nbsp;
											<form:input path="goodsTags[2].tagNm" id="goodsTags[2].tagNm" cssClass="mb5"/>
											<br/>
											<form:input path="goodsTags[3].tagNm" id="goodsTags[3].tagNm" cssClass="mb5"/>&nbsp;
											<form:input path="goodsTags[4].tagNm" id="goodsTags[4].tagNm" cssClass="mb5"/>&nbsp;
											<form:input path="goodsTags[5].tagNm" id="goodsTags[5].tagNm" cssClass="mb5"/>
											<p class="addtxt">* 최대 6개까지 키워드를 입력하실 수 있습니다.</p>
										</td>
									</tr>
									<tr>
										<th>상품정보고시</th>
										<td>상품정보고시 선택하기 &nbsp;
											<form:select path="gdsInfoNo" onchange="javascript:getGoodsAddInfoData(this.value)">
												<form:option value="">선택하세요</form:option>
												<form:options items="${addInfoList }" itemLabel="gdsInfoNm" itemValue="gdsInfoNo"/>
											</form:select>
											<div id="addInfoTableDiv" style="display:none;">
											<br/>
												<table class="chart" id="addInfoTable">
												<colgroup>
													<col width="120px" />
													<col width="300px" />
												</colgroup>
												<tbody>
													<tr>
														<th>제목</th>
														<td id="title"></td>
													</tr>
													<tr>
														<th rowspan="20">상품정보고시<br />항목</th>
													</tr>
												</tbody>
												</table>
											</div>
											<p class="addtxt"><a href="<c:url value='/admin/goods/goodsAddInfoGrpList'/>" class="btnType1 right2">상품고시정보 관리하기</a></p>										
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 전시여부</th>
										<td>
											<form:radiobutton path="dispYn" label="비전시" value="N"/>
											<form:radiobutton path="dispYn" label="전시" value="Y"/>
										</td>
									</tr>
									<tr>
										<th>판매기간</th>
										<td>
										<form:radiobuttons path="slTermCls" items="${slTermClsList}" itemLabel="cdNm" itemValue="cdNo" onchange="javascript:slTermSetting(this.value)"/>
										<div class="period" id="slDtmCal" style="display:none">
											<span class="dateinput"><form:input path="slStrDtm" id="slStrDtm" readonly="true" cssClass="datepicker1"/></span> ~
											<span class="dateinput"><form:input path="slEndDtm" id="slEndDtm" readonly="true" cssClass="datepicker2"/></span>											
										</div>
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 판매상태</th>
										<td>
											<form:radiobuttons path="gdsStat" items="${gdsStatList}" itemLabel="cdNm" itemValue="cdNo" />
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 가격 정보</th>
										<td class="p_line5">
											<p>최초판매가 : <fmt:formatNumber type="currency" value="${goodsForm.ubiGoods.ubiCostPrc }" pattern="###,###" /> 원</p>
											<p>현판매가 : <fmt:formatNumber type="currency" value="${goodsForm.ubiGoods.ubiSlPrc }" pattern="###,###" /> 원</p>
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 오프라인 구매 안내</th>
										<td class="p_line5">
											<form:checkbox path="offlineGoodsChk" label="(체크시 오프라인 구매 안내 문구 출력후 온라인 샵에서는 구매할 수 없습니다.)"/>${goodsForm.offGdsChk }
										</td>
									</tr>									
									<tr>
										<th><span class="highlight">*</span> INFORMATION</th>
										<td class="p_line5">
											<form:textarea path="bsDesc" id="bsDesc" />
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 상품설명</th>
										<td class="p_line5">										
											<form:textarea path="dtlDesc" id="dtlDesc" /></br>
											<table id="goodsImages" style="width:50%">
												<thead>
													<tr>
														<th>이미지</th>
														<th>경로</th>
														<th>우선순위</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${goodsForm.goodsImages}" varStatus="listCount" var="goodsImage">		
													<tr id="goodsImage">
														<td><img alt="" src="<c:url value='${uploadImage}${goodsImage.imgUrl}'/>" id="goodsImage${listCount.count-1 }" width="70px"  style="vertical-align: bottom;">
														</td>
														<td><form:input path="goodsImages[${listCount.count-1 }].imgUrl" id="goodsImage${listCount.count-1 }"/>
															<a href="javascript:openFileUploadPop('image','goodsImage${listCount.count-1 }','goods');" class="btnType2" style="vertical-align: middle;">파일첨부</a>
														</td>
														<td><form:input path="goodsImages[${listCount.count-1 }].prir" id="goodsImagePrir"/></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
											<p class="addtxt">※ 이미지파일은 GIF, JPG로 올려주시기 바랍니다. </p>
											<p class="addtxt">※ 이미지 순서는 DRAG & DROP 으로 변경하실 수 있습니다. </p>
											<p class="addtxt"><a href="javascript:addimage();" class="btnType1 right2">이미지 추가</a></p>			
										</td>
									</tr>
									<tr>
										<th><span class="highlight">*</span> 상품설명<br />(size chart)</th>
										<td>
											<p class="addtxt">
												<a href="javascript:openFileUploadPop('excel','sizeChart','sizeChart');" class="btnType1 right2">사이즈 차트 업로드(excel)</a>
												<a href="<c:url value="/resources/admin/download/sizeChart.xlsx"/>" class="btnType1 right2">샘플 다운로드</a>
											</p><br/>
											<p class="addtxt">※ 사이즈와 항목은 직접 입력으로 수정할 수 있습니다. </p>
											<table class="chart" id="sizeChart">
											<c:if test="${fn:length(goodsForm.goodsSizes) == 0}">
												<tr>
													<th>SIZE</th>
													<th>size1</th>
													<th>size2</th>
													<th>size3</th>
													<th>size4</th>
													<th>size5</th>
													<th>size6</th>
													<th>size7</th>
													<th>size8</th>
												</tr>
											</c:if>
												<c:forEach items="${goodsForm.goodsSizes}" varStatus="listCount" var="sizeList">
												<c:if test="${listCount.index == 0}">
												<tr>
													<th><form:input path="goodsSizes[${listCount.count-1 }].sizeNm" style="width:40px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size1" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size2" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size3" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size4" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size5" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size6" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size7" style="width:60px;"/></th>
													<th><form:input path="goodsSizes[${listCount.count-1 }].size8" style="width:60px;"/></th>
												</tr>												
												</c:if>
												<c:if test="${listCount.index != 0}">
												<tr>
													<td><form:input path="goodsSizes[${listCount.count-1 }].sizeNm" style="width:40px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size1" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size2" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size3" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size4" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size5" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size6" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size7" style="width:60px;"/></td>
													<td><form:input path="goodsSizes[${listCount.count-1 }].size8" style="width:60px;"/></td>
												</tr>												
												</c:if>												
												</c:forEach>
											</table>
										</td>
									</tr>
								</tbody>
								</table>
							</div>
							<div class="paging">
								<div class="right">
									<a href="javascript:void(0);" id="btn_list" class="btnType2">목록</a>
									<a href="javascript:void(0);" id="btn_save" class="btnType2">저장</a>
								</div>
							</div>
						</div>
					</div>
					<!--[e] 카테고리관리 -->
				</div>
				<!--[e] contents -->
				</form:form>
			</div>

		</div>
		<!--[e] container -->

		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

	</div>
</body>
</html>