<%--
 * =============================================================================
 * 파일명 :  /front/myPage/memberInfo.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-30
 *
 * 파일 내용 : 회원정보관리
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
    			
    			var cpNo = "${memberForm.cpNo}".split("-"); 
    			$("#phone_number01").val(cpNo[0]);
    			$("#phone_number02").val(cpNo[1]);
    			$("#phone_number03").val(cpNo[2]);
    			/* 
    			$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			$(document).on("blur", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			 */
    			
    			
    			//저장
    			/* 
		    	$("#saveBtnttttttttttttttttttttttttttttttt").on("click",function(){
			    	var frm = document.memberForm;
			    	
			    	if(!confirm("해당정보로 변경하시겠습니까?")) return false;
			    	
			    	if(!formCheck()) return false; 
			    	
			    	$("input[id='cpNo']").val(frm.phone_number[0].value+"-"+frm.phone_number[1].value+"-"+frm.phone_number[2].value);
					
			    	$.ajax({
       	   		        url : "<c:url value='/front/myPage/changeMemberInfoAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#memberForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   						alert("정보가 변경되었습니다."); 
//        	   						var frm = document.hiddenForm;
//        	   						frm.action = "<c:url value='/front/myPage/changeMemberInfo'/>";
//        				 	        frm.submit();
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
			    });
    			 */
    			/* 
		    	function formCheck(){
		    		var flag = true;
		    		$("input[name=phone_number]").each(function(){
		    			if($(this).val()==""){
		    				alert("핸드폰 번호를 입력하세요");
		    				flag = false;
		    				return false;
		    			}
		    		});

		    		return flag;
		    	}
		    	 */
		    	
		    	
		    	//본인인증하기
		    	$(document).on("click","a[data-btn='auth']",function(e){ 
   	    			e.preventDefault();
   	    			
    		    	$.ajax({
    		    		url : "<c:url value='/front/auth/getAuth'/>",
    		    		type: "post",
    		    		data : "urlCode=01002",
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
    			var frm = document.memberForm;
    			
    			if(getCookie("reqNum") != reqNum){
//     				alert(getCookie("reqNum") +"/////////"+reqNum);
    				alert("인증실패 : 요청한 인증값과 반환된값이 같지 않습니다.");
    				return false;
    			}
    			
    			//쿠키삭제
    			setCookie('reqNum', '', -1);
    			
    			
				if(frm.nm.value != nm || frm.sex.value != sex || frm.birthDt.value != birthDt){
					alert("인증실패 : 인증된 개인정보가 기존 정보와 같지 않습니다.");
					return false;
				}else{
					frm.cpNo.value    = autoHypenPhone(cpNo);
				}  		
		    	
		    	
		    
	    		
		    	
		    	
				$.ajax({
   	   		        url : "<c:url value='/front/myPage/changeMemberInfoAjax'/>",
   	   		        type: "post",
   	   		        data : $("form#memberForm").serialize(),
   	   		        async: true,
   	   		        success : function(res){
   	   		            if (res > 0) {
   	   						alert("정보가 변경되었습니다."); 
   	   					var tempCpNo = frm.cpNo.value.split("-"); 
		   	     			$("#phone_number01").val(tempCpNo[0]);
		   	     			$("#phone_number02").val(tempCpNo[1]);
		   	     			$("#phone_number03").val(tempCpNo[2]);
   	   					} else {
   	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
   	   					}
   	   		        },
   	   		        error:function(request,status,error){
   	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
   	   		        }
   	   		    });
				
				
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
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">PROFILE</a>
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
											<a href="<c:url value="/front/myPage/memberInfo"/>"class="on">회원정보관리</a>
											<a href="<c:url value="/front/myPage/managePassword"/>">비밀번호관리</a>
											<a href="<c:url value="/front/myPage/manageDelivery"/>">배송지관리</a>
											<a href="<c:url value="/front/myPage/managePoint"/>">포인트현황</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="mypage_top_tit">회원정보관리</div>
									<div class="mypage_content_layout01 space01">
									<form:form id="memberForm" name="memberForm" method="post" modelAttribute="memberForm" onsubmit="">
			        					<form:hidden path="memNo" id="memNo"/>
			        					<form:hidden path="cpNo" id="cpNo"/>
			        					<form:hidden path="email" id="email"/>
			        					<form:hidden path="nm" id="nm"/>
			        					<form:hidden path="sex" id="sex"/>
			        					<form:hidden path="birthDt" id="birthDt"/>
										<table class="tbl_row02">
											<caption>회원정보관리 테이블로 아이디(이메일), 이름, 성명, 생년월일, 휴대폰번호 를 확인 할 수 있습니다.</caption>
											<colgroup>
												<col width="128px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">아이디(이메일)</span>
														</span>
													</th>
													<td>${memberForm.email}</td>
												</tr>
												<tr>
													<th>
														<label for="name" class="tit_style01">
															<span class="underline">이름</span>
														</label>
													</th>
													<td>${memberForm.nm}</td>
												</tr>
												<tr>
													<th>
														<label for="male" class="tit_style01">
															<span class="underline">성별</span>
														</label>
													</th>
													<td><c:if test="${memberForm.sex eq 'M'}">남</c:if><c:if test="${memberForm.sex eq 'F'}">여</c:if></td>
												</tr>
												<tr>
													<th>
														<label for="birthday" class="tit_style01">
															<span class="underline">생년월일</span>
														</label>
													</th>
													<td>${memberForm.birthDt}</td>
												</tr>
												<tr>
													<th>
														<label for="phone_number01" class="tit_style01">
															<span class="underline">휴대폰번호</span>
														</label>
													</th>
													<td>
														<div class="form_layout_style04 clfix">
															<ul class="form01 clfix">
																<li>
																	<span class="input_txt">
																		<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																		<input type="text" id="phone_number01" name="phone_number" numberonly="true" maxlength="3" readonly="readonly">
																	</span>
																</li>
																<li class="etd_child">
																	<span class="input_txt">
																		<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																		<input type="text" id="phone_number02" name="phone_number" numberonly="true" maxlength="4" readonly="readonly">
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																		<input type="text" id="phone_number03" name="phone_number" numberonly="true" maxlength="4" readonly="readonly">
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
										</form:form>
										<div class="btn_area clfix space01">
											<div class="btn01">
												<a href="#" data-template="ui_popup_change_profile" data-callback="callback_test01" class="btn_black01 ui_btn_popup" id="saveBtn" data-btn="auth">변경</a>
											</div>
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