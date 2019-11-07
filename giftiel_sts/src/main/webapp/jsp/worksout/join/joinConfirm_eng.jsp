<%--
 * =============================================================================
 * 파일명 : /front/join/joinConfirm_eng.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-05-28
 *
 * 파일 내용 : 회원가입약관동의및 본인인증_외국인
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
    	    	/* 
   	    		$(document).on("click","a[data-btn='next']",function(e){ 
   	    			e.preventDefault();
   	    			
   	    			var frm = document.joinForm;
    		    	frm.mySlfCertYn.value = "Y";
					frm.action = "<c:url value='/front/join/joinInfo'/>";
	 	        	frm.submit();
   	    		});
   	    		 */
   	    		
   	    		
   	    		
    			$(document).on("click","a[data-btn='auth']",function(e){ 
   	    			e.preventDefault();
   	    			
    		    	
    		    	$.ajax({
    		    		url : "<c:url value='/front/auth/getAuth'/>",
    		    		type: "post",
    		    		data : "",
    		    		async: false,
    		    		success : function(res){
    		    			var data = jQuery.parseJSON(res);
    		    			
    		    			
    		    			setCookie("reqNum", data.reqNum, 1);
    		    			
    		    			
    		    			var frm = document.reqDRMOKForm;
    		    			frm.req_info.value = data.encReqInfo;
    		    			frm.rtn_url.value  = data.rtn_url;
    		    			frm.cpid.value     = data.cpId;
    		    			
    		    				
	       	    			var name = 'DRMOKWindow';
	       	    			var options = 'width=420, height=576, resizable=0, scrollbars=no, status=no, titlebar=no, toolbar=no, left=435, top=250';
	       	    			
	       	    			DRMOK_window = window.open("", name, options);
	       	    			
	       	    			if(DRMOK_window == null){
	       	   					alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	       	   		        }
	       	    			document.reqDRMOKForm.action = data.authPath;
	       	   		        document.reqDRMOKForm.target = 'DRMOKWindow';
	       	   		  		document.reqDRMOKForm.submit();
    		    		},
    		    		error:function(request,status,error){
    		    		    alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
    		    		}
    		    	});
    		    	
					
   	    		});
   	    		 
   	    		 
    			//인증 skip테스트 코드 추후 삭제 
   	    		$(document).on("click","a[data-btn='authTest']",function(e){ 
   	    			e.preventDefault();
	       	    			var name = 'DRMOKWindow';
	       	    			var options = 'width=420, height=576, resizable=0, scrollbars=no, status=no, titlebar=no, toolbar=no, left=435, top=250';
	       	    			
	       	    			DRMOK_window = window.open("", name, options);
	       	    			
	       	    			if(DRMOK_window == null){
	       	   					alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	       	   		        }
	       	    			document.reqDRMOKForm.action = "<c:url value='/front/auth/testPopUp'/>";
	       	   		        document.reqDRMOKForm.target = 'DRMOKWindow';
	       	   		  		document.reqDRMOKForm.submit();
   	    		});
    		    	
					
   	    	});
    		
    		
    		
    		
   	    		
   	    		
   	    	// 쿠키 생성
   	    		function setCookie(cName, cValue, cDay){
   	    			var expire = new Date();
   	    			expire.setDate(expire.getDate() + cDay);
   	    			cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
   	    			if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
   	    			document.cookie = cookies;
   	    		}

   	    		// 쿠키 가져오기
   	    		function getCookie(cName) {
   	    			cName = cName + '=';
   	    			var cookieData = document.cookie;
   	    			var start = cookieData.indexOf(cName);
   	    			var cValue = '';
   	    			if(start != -1){
   	    				start += cName.length;
   	    				var end = cookieData.indexOf(';', start);
   	    				if(end == -1)end = cookieData.length;
   	    				cValue = cookieData.substring(start, end);
   	    			}
   	    			return unescape(cValue);
   	    		}
   	    		
   	    		
   	    		
   	    		
   	    		
   	    		
   	    		//인증 성공시 호출 함수
   	    		function nextStep(nm,sex,birthDt,reqNum,cpNo,nation){
   	    			var frm = document.joinForm;
   	    			var errorFrm = document.hiddenForm;
   	    			
   	    			var flag = true;
   	    			//핸드폰 번호 중복 체크
   	    			$.ajax({
   			    		url : "<c:url value='/front/join/cpDuplChkAjax'/>",
   			    		type: "post",
   			    		data : "cpNo="+cpNo,
   			    		async: false,
   			    		success : function(res){
   			    			if (res > 0) {
//   	 			            	alert("이미 사용중인 휴대폰 번호 입니다.");
   								errorFrm.errorTxt.value = "이미 사용중인 휴대폰 번호 입니다.";
   								errorFrm.action = "<c:url value='/front/join/joinError'/>";
   								errorFrm.submit();
   				            	flag = false;
   							} else {
//   	 							alert("인증성공");
   							}
   			    		},
   			    		error:function(request,status,error){
   			    		    //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   			    		}
   			    	});
   	    			if(!flag) return false;
   	    			
   	    			
   	    			
   	    			if(getCookie("reqNum") != reqNum){
//    	    				alert(getCookie("reqNum") +"/////////"+reqNum);
   	    				errorFrm.errorTxt.value = "요청한 인증값과 반환된값이 같지 않습니다.";
						errorFrm.action = "<c:url value='/front/join/joinError'/>";
						errorFrm.submit();
   	    				return false;
   	    			}
   	    			
   	    			
   	    			//쿠키삭제
   	    			setCookie('reqNum', '', -1);
   	    			
   	    			if(frm.countryCd.value != nation){
//    	    				alert(frm.countryCd.value +"/////////"+nation);
   	    				errorFrm.errorTxt.value = "국적코드 불일치";
						errorFrm.action = "<c:url value='/front/join/joinError'/>";
						errorFrm.submit();
   	    				return false;
   	    			}
   	    			
   			    	
   			    	
   			    	frm.nm.value      = nm;
   		    		frm.sex.value     = sex;
   		    		frm.birthDt.value = birthDt;
   		    		frm.cpNo.value    = autoHypenPhone(cpNo);
   			    	
   			    	
   			    	frm.action = "<c:url value='/front/join/joinInfo'/>";
   			    	frm.submit();
   		    		}
   	    		
   	    		
   	    			//휴대폰 번호 하이픈 추가
   		    		function autoHypenPhone(str){
   		    			str = str.replace(/[^0-9]/g, '');
   		    			var tmp = '';
   		    			if( str.length < 4){
   		    				return str;
   		    			}else if(str.length < 7){
   		    				tmp += str.substr(0, 3);
   		    				tmp += '-';
   		    				tmp += str.substr(3);
   		    				return tmp;
   		    			}else if(str.length < 11){
   		    				tmp += str.substr(0, 3);
   		    				tmp += '-';
   		    				tmp += str.substr(3, 3);
   		    				tmp += '-';
   		    				tmp += str.substr(6);
   		    				return tmp;
   		    			}else{				
   		    				tmp += str.substr(0, 3);
   		    				tmp += '-';
   		    				tmp += str.substr(3, 4);
   		    				tmp += '-';
   		    				tmp += str.substr(7);
   		    				return tmp;
   		    			}
   		    			return str;
   		    		}
   	    			
   	    			
   		    		function joinErrorTest(){
   	    				var errorFrm = document.hiddenForm;
   	    				errorFrm.errorTxt.value = "외국인회원 가입 오류 테스트 입니다.";
   						errorFrm.action = "<c:url value='/front/join/joinError'/>";
   						errorFrm.submit();
   	    			}
   	    		
    		
		</script>
	</head>
	<body>
		<form name="reqDRMOKForm" method="post" action="#">
		    <input type="hidden" name="req_info"     value = ""/>
		    <input type="hidden" name="rtn_url"      value = ""/>
		    <input type="hidden" name="cpid"         value = ""/>
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
				<form id="hiddenForm" name="hiddenForm"  method="post">
					<input type="hidden" id="errorTxt" name="errorTxt" value="">
				</form>
				<form:form id="joinForm" name="joinForm" method="post" modelAttribute="joinForm" onsubmit="">
					<form:hidden path="siteNo"/>
					<form:hidden path="countryCd"/>
					<form:hidden path="mySlfCertYn"/>
					<form:hidden path="mailSndYn"/>
					<form:hidden path="smsSndYn"/>
					<form:hidden path="cpNo"/>
					
					<form:hidden path="nm" value=""/>
					<form:hidden path="sex" value=""/>
					<form:hidden path="birthDt" value=""/>
				</form:form>
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="#">JOIN</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_join_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<a href="#" class="on">
											<span class="txt">CERTIFICATION</span>
										</a>
										<a href="#">
											<span class="txt">PROFILE</span>
										</a>
										<a href="#" class="last_child">
											<span class="txt">COMPLETION</span>
										</a>
									</div>
								</div>
								<div class="join_area">
									<div class="join_agree_area02 space02">
										<div class="join_agree_tit">CERTIFICATION</div>
									</div>
									<!-- 
									<div class="join_mobile_certify">
										<table class="tbl_row02 tbl_space02">
											<caption>휴대폰 본인인증 테이블로 이름, 성별, 생년월일, 통신사, 휴대폰번호, 인증번호 를 확인 합니다.</caption>
											<colgroup>
												<col width="152px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>
														<label for="name" class="tit_style01">
															<span class="underline eng">NAME</span>
														</label>
													</th>
													<td>
														<div class="input_txt">
															id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
															<input type="text" id="name" name="name">
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<label for="alien_number01" class="tit_style01">
															<span class="underline eng">NUMBER</span>
														</label>
													</th>
													<td>
														<div class="form_layout_style05 clfix">
															<ul class="form01 clfix">
																<li>
																	<span class="input_txt">
																		id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																		<input type="text" id="alien_number01" name="alien_number">
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																		<input type="text" id="alien_number02" name="alien_number">
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									 -->
									
									
									<div class="btn_area">
										<a href="#" class="btn_black01" data-btn="auth">CONFIRM</a>
									</div>
<!--  									<div class="btn_area"> -->
<!-- 										<a href="#" class="btn_black01" data-btn="authTest">CONFIRM Test</a> -->
<!-- 									</div> -->
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