<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입 정보입력
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
<jsp:include page="/jsp/worksout/include/head.jsp" />
<script type="text/javascript">
$(document).ready(function() {
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
	// 사업자등록번호 input 자동 focus
	$("input[id^='cbNo']").keydown(function() {
		var idx = $("input[id^='cbNo']").index(this);
		var checkLength = $(this).val().length;
		var maxLength = $(this).attr("maxlength");

		if(checkLength >= maxLength) {
			$("input[id^='cbNo']").eq(idx+1).focus();
		} else if(checkLength <= 0 && idx > 0) {
			$("input[id^='cbNo']").eq(idx-1).focus();
		}
	});

	// 사업자등록번호 인증하기
	sendBusinessCertNo = function() {
    	var cbNo = $("input#cbNo01").val() + $("input#cbNo02").val() + $("input#cbNo03").val();
    	
    	if($("input#cbNo01").val() == "" || $("input#cbNo02").val() == "" || $("input#cbNo03").val() == ""){
    		alert("사업자등록번호를 입력해주세요.");
    		return;
    	} 
// 		$.ajax({
//     		url : "<c:url value='/front/join/cpDuplChkAjax'/>",
//     		type: "post",
//     		data : "cpNo="+cpNo,
//     		async: false,
//     		success : function(res){
    			
//     			console.log(res);
//     			if (res > 0) {
// 		            	alert("이미 사용중인 휴대폰 번호 입니다.");
// 		            	return false();
// 				} else {
// //						alert("인증성공");
// 				}
//     		},
//     		error:function(request,status,error){
//     		    //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
//     		}
//     	});			    	
    	

		$.ajax({
	        url : "<c:url value='/front/join/sendBusinessCertNo'/>",
	        type: "post",
	        data : "cbNo="+cbNo,
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = responseData;
		            var result = data;
// 	                if(result != null){  //
// 	                	alert(result);
// 	                }else if(result!=cbNo)
// 	                	alert("등록된 정보가 없습니다.");
// 	                }
	        	alert("ajax 결과 :" + result);
	        	}catch(e){
	        		//alert(e);
	        	}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	}
});
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
<!-- 						<li class="home"> -->
<%-- 							<a href="<c:url value='/front/main'/>">HOME</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<a href="#">JOIN</a> -->
<!-- 						</li> -->
					</ul>
					<div class="menu_section">
						<div id="snb_join_area">
							<!-- snbMain include -->
							<!-- snbMain include -->
						</div>
					</div>
					<div class="content_section">
						<div class="content_area">
							<div class="join_area">
								<div class="join_agree_area02 space02">
									<div class="join_agree_tit">사업자인증</div>
								</div>
								<div class="join_mobile_certify">
									<table class="tbl_row02 tbl_space02">
										<caption>사업자등록번호를 확인합니다.</caption>
										<colgroup>
											<col width="128px">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th><span class="tit_style01"> <span
														class="underline">사업자등록번호</span>
												</span></th>
												<td>
													<div class="form_layout_style04 clfix">
														<ul class="form01 clfix">
															<li style="width: 20%;">
																<span class="input_txt">
																	<form:input path="cbNo01" id="cbNo01" numberonly="true" maxlength="3" />
																</span>
															</li>
															<li class="etd_child" style="width: 25%;">
															<span class="input_txt"> 
																	<form:input path="cbNo02" id="cbNo02" numberonly="true" maxlength="2" />
															</span></li>
															<li class="last_child" style="width: 25%;">
																<span class="input_txt">
																	<form:input path="cbNo03" id="cbNo03" numberonly="true" maxlength="5" />
																</span>
															</li>
															<div class="btn_area" style="width: 27%; float: right; padding: 0 0;">
																<a href="#" class="btn_black01" onclick="sendBusinessCertNo();">인증하기</a>
															</div>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
												<th class="vertical_top"><label for="id_emal"
													class="tit_style01"> <span class="underline">사업자등록증사본</span>
												</label></th>
												<td>
													<ul class="input_file_name">
														<li></li>
													</ul>
													<div class="input_file_area_add">
<%-- 														<form:form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data"> --%>
														<input type="file" name="uploadFile" id="uploadFile"
															onchange="submit();">
<%-- 																<input type="hidden" name="folderNm" id="folderNm" value="${param.folderNm }"> --%>
<%-- 																<input type="hidden" name="type" id="type" value="${param.type }"> --%>
<%-- 																<input type="hidden" name="target" id="target" value="${param.target }"> --%>
<%-- 															</form:form> --%>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<div>
														<div>* 사업자등록증 사본 파일은 pdf,jpg,png 형식의 2MB 이하의 사이즈로 등록하시기 바랍니다.</div>
														<div>* 사업자등록번호를 도용하는 경우 형사처벌의 대상이 됩니다.</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>