<%--
 * =============================================================================
 * 파일명 : /mailSendCancel.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-12-22
 *
 * 파일 내용 : 메일수신거부
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
			$(function(){
				
				
				closeFunction = function(num){
					
					
					if(num == 1){
						
						if(statEmailChk($("#cancelEmail"))){
							
							var cncleEmail = $("#cancelEmail").val();
							
							$("#email").val(cncleEmail);
							
							$.ajax({
						        url : "<c:url value='/front/mailSendCancelAjax'/>",
						        data : $('form#searchForm').serialize(),
						        type: "POST",
						        async: false,
						        success : function(res){
						        	try{
						        		if(res > 0){
						        			alert("구독 취소 신청이 완료되었습니다.");
						        			if(confirm("창을 닫으시겠습니까?")){
												window.open('','_self').close();
						        			}
						        		}else{
						        			alert("이메일이 존재하지 않습니다.");
//						 					window.open('','_self').close();
						        		}
						        	}catch(e){
						        		alert(e);
						        	}
						        }
						        ,error:function(request,status,error){
						        	alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
						        	if(confirm("창을 닫으시겠습니까?")){
										window.open('','_self').close();
				        			}
						        }
						    });
						}else{
							alert("메일형식에 맞지 않습니다.");
							return false;
						}
					}else{
						if(confirm("창을 닫으시겠습니까?")){
							window.open('','_self').close();
	        			}
					}

				}; 
			});
			
			function statEmailChk(obj){
				if(obj.val() != ""){
					if(regEmail(obj)){
						return true;
					}else{
						return false;
					}
				}else{
					return false;
				}
			}			
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<h1 class="hide_txt">${siteNm }</h1>
		<div class="dimm">
			<img src="/resources/worksout/images/obey/images/common/blank_size_100.png" alt="">
		</div>
		
		<form:form id="searchForm" modelAttribute="searchForm">
			<form:hidden path="email" id="email" />
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
						<div class="menu_section"></div>
						<div class="content_section">
							<div class="content_area">
								<div class="error_content">
									<p class="txt01">e-Mail 구독 취소 신청 페이지 입니다.</p>
									<p class="txt02">
										<span class="style02">
											<input type="text" name="cancelEmail" id="cancelEmail" autocomplete="off" placeHolder="E-MAIL주소 입력"/>
										</span>의 e-Mail 구독을
										<span class="style02">취소</span>하시겠습니까?</p>
									<p class="txt03">
										To unsubscribe from ${siteNm } emails, click on the<span class="style02"> 예</span> button
									</p>
									<div class="error_btn_area">
										<a href="#" class="btn01" onclick="closeFunction(1);">예</a>
										<a href="#" class="btn02" onclick="closeFunction(2);">아니오</a>
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