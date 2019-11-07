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
		
		$(function() {
			// footer의 개인정보취급방침 click으로 이동해 왔을 시 policy 화면 활성화 
			var param = getUrlParams();// frontUtils.js에 있음

			if(param.policy == "open"){
				$(".contact_us_tit:last").trigger("click");
			};
			
			//
			//formSubmit 이벤트
			//
			formSubmit = function(){
			
	    		if($("#type").val() == ""){
		    		alert("문의 타입을 선택하세요.");
		    		$("#type").focus();
		    		return false;
		    	}
	    		
	    		if($("#title").val() == ""){
		    		alert($("#title").attr("title"));
		    		$("#title").focus();
		    		return false;
		    	}
	    			    		
	    		if($("#userName").val() == ""){
		    		alert($("#userName").attr("title"));
		    		$("#userName").focus();
		    		return false;
		    	}
	    		
	    		if($("#userEmail").val() == ""){
		    		alert($("#userEmail").attr("title"));
		    		$("#userEmail").focus();
		    		return false;
		    	}

	    		if(!regEmail($("#userEmail"))){
		    		alert("이메일 형식에 맞지 않습니다.");
		    		$("#userEmail").val("");
		    		$("#userEmail").focus();
		    		return false;
		    	}
	    		
	    		if ($("#txt").val() == "") {
	    			alert($("#txt").attr("title"));
	    			$("#txt").focus();
	    			return false;
				}
	    		
		    	if(!$("#agree").is(":checked")){
		    		alert("개인정보 수집 및 이용에 대한 동의 약관에 동의하여야 발송이 가능합니다.");
		    		$("#agree").focus();
		    		return false;
		    	}	    		
				
	    		if(!confirm("메일을 보내시겠습니까?")) return false;

		    	$.ajax({
			        url : "<c:url value='/mail/contactUsMail' />",
			        type: "post",
			        data : $("form#mailManage").serialize(),
			        async: false,
			        success : function(res){
			            if (res > 0) {
							alert("메일이 정상적으로 발송되었습니다.."); 
						} else {
							alert("메일발송에 실패 하였습니다.");
						}
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        },
			        complete : function() {
			        	$("form#mailManage")[0].reset();			        	
			        }
			   	});
			};
			
			
			//
			// 파일업로드 팝업 이벤트
			//
			fileUpload = function (num){
				openFileUploadPop("image", 'fileName'+num, "customer");
			};
			
			
			//
			// 파일추가 버튼 이벤트
			//
			addInputFile = function(){
				
				var cnt = $(".input_file_add").length;
				var idNum = Number(cnt)+1;				
				
				var fileDiv = $('#fileDiv');
				var html = "";
				
				if (cnt< 5) {
	 				html =
	 					
		 				"<div class='input_file_area_add'>" +
		 				"	<input id='fileName" + idNum + "' name='imgUrl' class='input_file_name wd_200' style='width:100%' readonly type='text' checked='checked'>" +
		 				"	<div class='input_file'>" +
		 				"		<a href='javascript:;' id='btn_file" + idNum + "' class='txt_file' onclick='fileUpload(" + idNum + ")'>FILE</a>" +
		 				"	</div>" +
		 				"	<a href='javascript:;' onclick='addInputFile()' class='input_file_add' id='add" + idNum + "'></a>" +
		 				"</div>";
					fileDiv.append(html);
				}else{
					var stat = false;
					
					if(!stat){
						$("#nonAdd").html("<span style='color:red;'>최대 5개까지만 추가 가능합니다.</span>");
						stat = true;
						
						if(stat){
							$("#nonAdd").animate({opacity: 0}, 1800, function(e){
								$("#nonAdd").html("");
								$("#nonAdd").removeAttr("style");
								stat = false;
							});											
						}
					}
				}
			};
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
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">CUSTOMER CARE</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_contact_us_area">
								<!-- snbContactUs include -->
								<!-- snbContactUs include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="contact_us_area">
									<div class="contact_us_unit">
										<div class="contact_us_tit">${CONTACTUS.plcy_nm}</div>
										<div class="contact_us_content">
											${CONTACTUS.plcy_txt}
											<div class="cu_title">REQUEST</div>
											<form:form id="mailManage" name="mailManage" method="post" modelAttribute="mailManage" onsubmit="">
											<ul class="qna_form">
												<li class="qan_form_item">
													<span class="input_select">
														<form:select path="rcvrEmail" id="type" cssClass="space01">
<%-- 															<form:option value="minoos11@naver.com">MARKETING</form:option> --%>
<%-- 															<form:option value="minoos11@naver.com">PARTNERSHIP</form:option> --%>
<%-- 															<form:option value="minoos11@naver.com">WEBSITE &amp; ONLINE SHOP</form:option> --%>
<%-- 															<form:option value="minoos11@naver.com">RECRUITING</form:option> --%>
															<form:option value="customer@worksout.co.kr">WEBSITE &amp; ONLINE SHOP</form:option>
															<form:option value="marketing@worksout.co.kr">MARKETING</form:option>
															<form:option value="partner@worksout.co.kr">PARTNERSHIP</form:option>
															<form:option value="jobs@worksout.co.kr">RECRUITING</form:option>
														</form:select>
													</span>
												</li>
												<li class="qan_form_item">
													<span class="input_txt">
														<form:input path="title" id="title" placeholder="title" title="제목을 입력해주세요." maxlength="50"/>
<!-- 														<input type="text" id="title" name="title" title="제목을 입력해주세요." placeholder="Title" maxlength="50"> -->
													</span>
												</li>
												<li class="qan_form_item">
													<span class="input_txt">
<!-- 														<input type="text" id="userName" name="userName" title="이름을 입력해주세요." placeholder="Your Name" maxlength="20"> -->
														<form:input path="sndrName" id="userName" title="이름을 입력해주세요." placeholder="Your Name" manxlength="20"/>
													</span>
												</li>
												<li class="qan_form_item">
													<span class="input_txt">
<!-- 														<input type="text" id="userEmail" name="userEmail" title="이메일을 입력해주세요." placeholder="Your e-Mail" maxlength="50"> -->
														<form:input path="sndrEmail" id="userEmail" title="이메일을 입력해주세요." placeholder="Your e-Mail" maxlength="50"/>
													</span>
												</li>
												<li class="qan_form_item">
													<div class="input_textarea">
<!-- 														<textarea rows="17" placeholder="Message" id="txt" name="txt" title="내용을 입력해주세요."></textarea> -->
														<form:textarea path="txtHtml" rows="17" placeholder="Message" id="txt" title="내용을 입력해주세요."/>
													</div>
												</li>
												<li class="qan_form_item" id="fileDiv">
													<div class="input_file_area_add">
<!-- 														<input id="fileName1" name="imgUrl" class="input_file_name wd_200" style="width:100%" readonly type="text" checked="checked"> -->
														<form:input path="atchFile" cssClass="input_file_name wd_200" id="fileName1" style="width:100%" checked="checked"/>
														<div class="input_file">
															<a href="javascript:;" id="btn_file1" class="txt_file" onclick="fileUpload(1)">FILE</a>
														</div>
														<a href="javascript:;" onclick="addInputFile()" class="input_file_add" id="add1"></a>
													</div>
													<div class="input_file_area_add">
<!-- 														<input id="fileName2" name="imgUrl" class="input_file_name" style="width:100%" readonly type="text" checked="checked"> -->
														<form:input path="atchFile" cssClass="input_file_name wd_200" id="fileName2" style="width:100%" checked="checked"/>
														<div class="input_file">
															<a href="javascript:void()" id="btn_file1" class="txt_file" onclick="fileUpload(2)">FILE</a>
														</div>
														<a href="javascript:void()" onclick="addInputFile()"class="input_file_add" id="add2"></a>
													</div>
												</li>
												<li class="qan_form_item">
													<p class="notice_txt">- Image Format (*.gif, *.jpg, *.jpeg, *.png) / 최대 5MB</p>
												</li>												
												<li id="nonAdd"></li>
												
												<div class="mypage_tit clfix space04" style="margin-top:15px;">
													<span class="txt01">${CONTACT_US_SEND_MAIL.plcy_nm }</span>
												</div>
												<div class="join_agreement">${CONTACT_US_SEND_MAIL.plcy_txt }</div>
												<!-- /inc/layout/agreement03.html -->
												<div class="join_agree_check02">
													<label for="agree" class="inputu_check_type01">
														<input type="checkbox" id="agree" name="agree">
														<span class="txt">위 내용을 확인하였으며, 동의합니다.</span>
													</label>
												</div>												
												
												<li class="qan_form_item" style="margin-top:15px;">
													<a href="#" data-template="ui_popup_qna_reg" data-callback="callback_test01" class="btn_black01 ui_btn_popup" onclick="formSubmit()">SEND</a>
												</li>
											</ul>
											</form:form>
										</div>
										<div class="contact_us_tit">${ORDER.plcy_nm }</div>
										<div class="contact_us_content">
											${ORDER.plcy_txt }
										</div>
											
										<div class="contact_us_tit">${SHIPPING.plcy_nm }</div>
										<div class="contact_us_content">
											${SHIPPING.plcy_txt }
										</div>
										
										<div class="contact_us_tit">${EXCHANGE.plcy_nm }</div>
										<div class="contact_us_content">
											${EXCHANGE.plcy_txt }
										</div>
										
										<div class="contact_us_tit">${POINT.plcy_nm }</div>
										<div class="contact_us_content">
											${POINT.plcy_txt }
										</div>
										
										<div class="contact_us_tit">${AS.plcy_nm }</div>
										<div class="contact_us_content">
											${AS.plcy_txt }
										</div>
										
										<div class="contact_us_tit">${USE_AGREEMENT.plcy_nm }</div>
										<div class="contact_us_content">
											${USE_AGREEMENT.plcy_txt }
										</div>										
										
										<div class="contact_us_tit">${POLICY.plcy_nm }</div>
										<div class="contact_us_content">
											${POLICY.plcy_txt }
										</div>
										
										<div class="contact_us_tit">FAQ</div>
										<div class="contact_us_content">
											<p class="agree_tit01">
												Q :  교환 & 환불 시 반품 주소를 알고 싶습니다.
											</p>
											<div>
												A :  반품 주소는 서울시 마포구 잔다리로 59 더 마크(the mark) 웍스아웃 4층 고객지지원팀 입니다. <br/>
	                    						* 전화번호 : 02 – 541 – 0854  * 우편번호 : 04034
	                    					</div>
	                    					<p class="agree_tit01">
										Q : 포인트 적립은 언제 & 어떻게 진행 되는지 알고 싶습니다.
										</p>
											A : 포인트 적립은 제품 구입 일 (배송완료)로부터 15일 뒤에 적립이 되며,<br/>
											 그 기한 안에 교환 또는 환불이 진행 될 경우에는 교환 및 환불이 완료 된 날로부터 15일 후에 자동으로 적립이 됩니다. 
										<p class="agree_tit01">Q : 상품 환불은 얼마나 & 어떻게 진행 되는지 알고 싶습니다.</p>
											A : 환불 진행은 총 2 - 3일 정도 소요 되며, 본사에 제품 도착 후 제품 검수가 완료 되면 환불 처리(취소 및 부분취소)가 
											   완료됩니다.<br/>
											   하지만 결제수단 (신용카드, 계좌이체, 가상계좌) 및 금융회사에 따라 대금지급은 2-5일정도 더 소요 될 수 
											   있습니다.
										<p class="agree_tit01">Q : 상품 교환은 얼마나 & 어떻게 진행 되는지 알고 싶습니다. </p>
											A : 사이즈 교환을 원하실 경우에는 교환신청을 통해 원하시는 사이즈로 교환 진행이 가능하시며, <br/>다른 색상 혹은 다른 
											 제품으로 교환을 원하시는 경우에는 기존 구매 제품을 반품 하신 후에 재 구매를 해주셔야 합니다. <br/>교환 신청을 하신 
											 제품은 본사 도착 후 검수가 완료 되면 교환 된 제품이 발송 되며 1-3일 정도 소요 됩니다. 
										<p class="agree_tit01">Q : 교환 & 환불 진행 방법을 알고 싶습니다.</p>
											A : (1) My Page > 주문내역 > 주문서 상세 페이지 조회 > 교환/환불 신청  <br/>
											- 제품, 교환/환불 여부, 환불 사유 기재 (가상 계좌로 결제했을 경우 환불 받을 계좌 정보 기재)<br/> 
											- 신청 후 택배 기사님은 따로 방문하시지 않으며, 고객님께서 직접 택배를 보내주셔야 합니다. <br/>
											(2) 상품과 함께 3,000원 동봉 후 원하시는 택배 회사를 통해 선불 발송 <br/>
											- 택배 상자에 상품과 함께 택배 비용 3,000원을 동봉해주셔야 처리가 가능합니다<br/>
											① 교환: 교환 상품 발송 비용 3,000 원 <br/>
											② 환불: 무료배송 비용 3,000원 (택배 비용 지불 구매 건은 동봉하지 않으셔도 됩니다.)<br/> 
											
										</div>										
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