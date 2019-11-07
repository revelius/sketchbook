<%--
 * =============================================================================
 * 파일명 :  /front/myPage/withdraw.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-08
 *
 * 파일 내용 : 회원탈퇴화면
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
    			
    			$("#draw").on("click", function(e){ 
   	    			e.preventDefault();
   	    			if(!confirm("탙퇴하시겠습니까?")) return false;
   	    			
   	    			if(!formCheck()) return false; 
   	    			
    		    	$("#wdrwYn").val($("input[id='agree']").is(":checked") == true?"Y":"N");
	 	        	
	 	        	$.ajax({
       	   		        url : "<c:url value='/front/myPage/withdrawAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#memberForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   		          		location.href="<c:url value='/front/myPage/withdrawComplete'/>";
       	   					} else if (res == -1) {
       	   		          		alert("비밀번호를 확인해 주세요");
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
	 	        	
	 	        	
   	    		});
    			
				function formCheck(){
					
					if($("input[id='pwd']").val() == ""){
    	    			alert("비밀번호를 입력해 주세요");
    	    			return false;
    	    		}
					
					if($("input[id='wdrwDtlRsn']").val() == ""){
    	    			alert("탈퇴 상세사유를 입력해 주세요");
    	    			return false;
    	    		}
    	    		
    	    		if($("input[id='agree']").is(":checked") != true){
    	    			alert("안내 사항 확인에 동의해 주세요");
    	    			return false;
    	    		}
    				
    				return true;
    	    		
    	    	}
    			
    			
    			
    		});
   		</script>
		
		
	</head>
	<body>
		<form id="hiddenForm" name="hiddenForm" method="post" >
			<input type="hidden" name="cnslNo"  id="cnslNo"  value=""/>
			<input type="hidden" name="cnslTxt"  id="cnslTxt"  value=""/>
			<input type="hidden" name="memoNo"  id="memoNo"  value=""/>
			<input type="hidden" name="memoTxt"  id="memoTxt"  value=""/>
		</form>
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
					<form:form id="memberForm" name="memberForm" method="post" modelAttribute="memberForm" onsubmit="">
						<form:hidden path="wdrwYn" id="wdrwYn"/>
						<div class="content_wrap">
							<ul class="location_list clfix">
								<li class="home">
									<a href="<c:url value='/front/main'/>">HOME</a>
								</li>
								<li>
									<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
								</li>
								<li>
									<a href="#">회원탈퇴</a>
								</li>
							</ul>
							<div class="menu_section">
								<div id="snb_mypage_area">
									<!-- snbMain include -->
									<!-- snbMain include -->
								</div>
							</div>
							<div class="content_section">
								<div class="content_area">
									<div class="mypage_area">
										<div class="mypage_top_tit">회원탈퇴</div>
										<div class="mypage_content_layout01">
											<ul class="withdraw_info_list">
												<li class="info01">
													<div class="info_tit">탈퇴아이디</div>
													<div class="info_desc">${memberForm.email}</div>
												</li>
												<li>
													<label for="pwd_confirm" class="info_tit">비밀번호 재입력</label>
													<div class="info_desc">
														<span class="input_txt">
															<form:password path="pwd" id="pwd" showPassword="false"/>
														</span>
													</div>
												</li>
												<li>
													<label for="reason" class="info_tit">탈퇴사유</label>
													<div class="info_desc">
														<span class="input_select">
															<form:select path="wdrwRsnCd">
																<form:option value="ME00301">사이트이용불편</form:option>
																<form:option value="ME00302">다른사이트이용</form:option>
																<form:option value="ME00303">기타</form:option>
															</form:select>
														</span>
													</div>
												</li>
												<li>
													<div class="info_desc">
														<span class="input_txt">
															<form:input path="wdrwDtlRsn" id="wdrwDtlRsn"  placeholder="상세사유"/>
														</span>
													</div>
												</li>
												<li class="notice_txt">(탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.)</li>
											</ul>
											<ul class="withdraw_notice_list">
												<li class="tit">탈퇴 후 이용불가 혜택</li>
												<li class="desc">- 제품 구매 시마다 포인트가 적립됩니다.</li>
												<li class="desc">- 온라인 쇼핑몰 뿐만 아니라 오프라인 매장에서도 포인트 적립이 가능합니다.</li>
												<li class="desc">- 적립하신 포인트는 온라인 쇼핑몰에서 현금처럼 사용이 가능합니다.</li>
												<li class="check">
													<label for="agree" class="inputu_check_type01">
														<input type="checkbox" id="agree" name="agree">
														<span class="txt">안내 사항을 모두 확인하였으며, 이에 동의합니다.</span>
													</label>
												</li>
											</ul>
											<div class="btn_area02 clfix">
												<div class="btn01">
													<a href="#" class="btn_black01" id="draw">확인</a>
												</div>
												<div class="btn02">
													<a href="#" class="btn_gray01" onclick="javascript:window.history.back(-1); return false;">취소</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="etc_section"></div>
						</div>
					</form:form>
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