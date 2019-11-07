<%--
 * =============================================================================
 * 파일명 : /front/myPage/qna.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-22
 *
 * 파일 내용 : 1:1 문의하기
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
    			
    			//파일선택
    		    $('#btn_file').click(function() {
    		    	openFileUploadPop("image", "atchFile", "qna");
    		    });	
    			
    			
    		
    		
    		
    		
	    		//등록
	        	$("#btn_reg").on("click",function(){
	        		if(!confirm("저장하시겠습니까?")) return false;
	        		
	    	    	var frm = document.qnaForm;
	    	    	
	    		    if(!formCheck(frm)) return false;
	    		    
	    	    	$.ajax({
	    		        url : "<c:url value='/front/myPage/regInquiryAjax'/>",
	    		        type: "post",
	    		        data : $("form#qnaForm").serialize(),
	    		        async: true,
	    		        success : function(res){
	    		            if (res > 0) {
	    						alert("저장하였습니다."); 
	    						var frm = document.qnaForm;
       	   						frm.action = "<c:url value='/front/myPage/qnaList'/>";
       				 	        frm.submit();
	    					} else {
	    						alert("저장에 실패 하였습니다.");
	    					}
	    		        },
	    		        error:function(request,status,error){
	    		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	    		        }
	    		   	});
	        	
	       		});
	    		
	    		
	    		
	        	function formCheck(frm){
	    	    	
	        		if($("#title").val()==""){
	    	    		alert("제목을 입력 하세요.");
	    	    		return false;
	    	    	}
	        		
	        		
	        		if($("#cnslTxt").val()==""){
	    	    		alert("내용을 입력 하세요.");
	    	    		return false;
	    	    	}
	        		
	        		
	        		
	    	    	return true;
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
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">Q&amp;A</a>
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
								<div class="content_top">
									<div class="content_menu clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="<c:url value="/front/myPage/qnaList"/>">1:1 문의내역</a>
											<a href="<c:url value="/front/myPage/qna"/>" class="on last_child">1:1 문의하기</a>
										</span>
									</div>
								</div>
								<form:form id="qnaForm" name="qnaForm" method="post" modelAttribute="qnaForm" onsubmit="">
									<form:hidden path="memNo" id="memNo" name="memNo"/>
									<div class="mypage_area">
										<div class="mypage_content_layout03">
											<ul class="qna_form">
												<li class="qan_form_item">
													<span class="input_txt">
														<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
<!-- 														<input type="text" id="title" name="title" title="제목을 입력해주세요." placeholder="제목"> -->
														<form:input path="title" id="title"  title="제목을 입력해주세요." placeholder="제목" maxlength="100"/>
													</span>
												</li>
												<li class="qan_form_item">
													<div class="input_textarea">
<!-- 														<textarea rows="17" placeholder="내용"></textarea> -->
														<form:textarea path="cnslTxt" id="cnslTxt" rows="17" placeholder="내용"></form:textarea>
													</div>
												</li>
												<li class="qan_form_item">
													<div class="input_file_area">
														<ul>
															<li><span class="input_txt"><form:input path="atchFile" id="atchFile" readonly="true"/></span></li>
														</ul>
														<!-- 만약 파일이 어려개 등록 되어야 한다면 li 태그 하나당 파일 1개임. -->
														<!-- li 안에 첨부한 파일이름이 들어가도록 개발이 필요함 -->
														<div class="input_file">
<!-- 															<span class="txt_file">FILE</span> -->
<!-- 															<input type="file"> -->
															<a href="#" id="btn_file" class="txt_file">FILE</a> <br /><br />
														</div>
													</div>
													<p class="notice_txt">- Image Format (*.gif, *.jpg, *.jpeg, *.png) / 최대 5MB</p>
												</li>
												<li class="qan_form_item">
													<a href="#" id="btn_reg" data-template="ui_popup_qna_reg" data-callback="callback_test01"
													class="btn_black01 ui_btn_popup">문의하기</a>
												</li>
											</ul>
										</div>
									</div>
								</form:form>
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