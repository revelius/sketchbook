<%--
 * =============================================================================
 * 파일명 :  /front/myPage/orderChangeApply02.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-07-28
 *
 * 파일 내용 : 02. 배송지 정보
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
    			$(document).on("keyup", "input[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			$(document).on("blur", "input[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			
				var mydlvAddrList = ${mydlvAddrListJson};
    			
    			
    			//우편번호 찾기
// 				$('#openZipCd').click(function() {
// 					window.open("<c:url value='/front/popup/zipCode/selectSido'/>","popup","width=500px,height=500px,scrollbars=yes");
// 				});
    			
				
				function formCheck(){
					var flag = true;
					$("input[name=nm],input[name=tel],input[name=cpNo],input[name=zipCd],input[name=bsAddr],input[name=dtlAddr]").each(function(){
						if($(this).val()==""){
							alert("모두 입력해 주세요.");
							flag = false;
							return false;
						};

					});
					
					$("#rcpnNm").val($("input[name=nm]").val());
					$("#rcpnTelNo").val($("input[id=tel1]").val() + "-" + $("input[id=tel2]").val() + "-" + $("input[id=tel3]").val());
					$("#rcpnCpNo").val($("input[id=cpNo1]").val() + "-" + $("input[id=cpNo2]").val() + "-" + $("input[id=cpNo3]").val());
					$("#rcpnZipCd").val($("input[id=zipCd]").val());
					$("#rcpnBsAddr").val($("input[name=bsAddr]").val());
					$("#rcpnDtlAddr").val($("input[name=dtlAddr]").val());
					$("#dlvSvcMemo").val($("input[name=delivery_wish]").val());
					
					
					
					return flag;
				};
				
				
				
				//교환신청 다음단계
	   			$("#nextStep").on("click",function(e) {
	   				e.preventDefault();
	   				
	   				if(!confirm("교환 신청 하시겠습니까?")) return false;
	   				
	   				var frm = document.clmForm;
	   				if(!formCheck(frm)) return false; 
	   				
	   			    $.ajax({
		   				url : "<c:url value='/front/myPage/${procPage}'/>",
		   				type: "post",
		   				data : $("form#clmForm").serialize(),
		   				async: true,
		   				success : function(res){
		   					if (res > 0) {
       	   		       			location.href="<c:url value='/front/myPage/${nextPage}'/>";
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
		   				},
		   				error:function(request,status,error){
		   				    alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		   				}
	   			    });
    		    });
    			
    		});
    		
    		
   		</script>
		
		
	</head>
	
	<form:form id="clmForm" name="clmForm" method="post" modelAttribute="clmForm" onsubmit="">
		<form:hidden path="ordNo" id="ordNo"/>
		<form:hidden path="clmTp" id="clmTp"/>
		<form:hidden path="clmStat" id="clmStat"/>
		
		<form:hidden path="rcpnNm" id="rcpnNm"/>
		<form:hidden path="rcpnTelNo" id="rcpnTelNo"/>
		<form:hidden path="rcpnCpNo" id="rcpnCpNo"/>
		<form:hidden path="rcpnZipCd" id="rcpnZipCd"/>
		<form:hidden path="rcpnBsAddr" id="rcpnBsAddr"/>
		<form:hidden path="rcpnDtlAddr" id="rcpnDtlAddr"/>
		<form:hidden path="dlvSvcMemo" id="dlvSvcMemo"/>
		
		<c:set var="count" value="-1"/>
		<c:forEach var="good" items="${clmForm.orderClmGds}" varStatus="goodIndex">
				<c:set var="count" value="${count+1 }"/>
				<form:hidden path="orderClmGds[${count}].ordGdsSeq"/>
				<form:hidden path="orderClmGds[${count}].clmGdsStat"/>
				<form:hidden path="orderClmGds[${count}].clmRsnCd"/>
				<form:hidden path="orderClmGds[${count}].clmTxt"/>
				<form:hidden path="orderClmGds[${count}].dlvCmpNo"/>
				<form:hidden path="orderClmGds[${count}].invNo"/>
		</c:forEach>
	</form:form>
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
								<a href="#">교환신청</a>
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
									<div class="content_menu03 clfix">
										<span class="cont_tit">교환신청</span>
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">교환정보 및 사유</span>
											</a>
											<a href="#" class="on">
												<span class="txt">배송자정보</span>
											</a>
											<a href="#" class="last_child">
												<span class="txt">신청완료</span>
											</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="mypage_top_tit">교환 배송지주소 입력</div>
									<div class="mypage_content_layout01 space01">
										<form id="dlvForm" name="dlvForm"   method="post">
											<input type="hidden" id="baseValYn" name="baseValYn" value="Y"/>
										<table class="tbl_row02">
											<caption>교환 배송지주소 입력 테이블로 배송지, 이름, 전화번호, 휴대폰번호, 주소, 배송시 요청사항 을 확인 할 수 있습니다.</caption>
											<colgroup>
												<col width="128px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th class="vertical_top">
														<label for="delivery01" class="tit_style01">
															<span class="underline">배송지</span>
														</label>
													</th>
													<td>
														교환 상품 받을 배송지를 입력해주세요
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">이름</span>
														</span>
													</th>
													<td class="txt_align01" data-dlvy="nm">
														<div class="input_txt">
															<input type="text" id="nm" name="nm" value="" data-dlv>
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">전화번호</span>
														</span>
													</th>
													<td class="txt_align01" data-dlvy="tel">
														<div class="form_layout_style04 clfix">
															<ul class="form01 clfix">
																<li>
																	<span class="input_txt">
																		<input type="text" id="tel1" name="tel" maxlength="3" numberonly="true" data-dlv>
																	</span>
																</li>
																<li class="etd_child">
																	<span class="input_txt">
																		<input type="text" id="tel2" name="tel" maxlength="4" numberonly="true" data-dlv>
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		<input type="text" id="tel3" name="tel"  maxlength="4" numberonly="true" data-dlv>
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">휴대폰</span>
														</span>
													</th>
													<td class="txt_align01" data-dlvy="cpNo">
														<div class="form_layout_style04 clfix">
															<ul class="form01 clfix">
																<li>
																	<span class="input_txt">
																		<input type="text" id="cpNo1" name="cpNo" maxlength="3" numberonly="true" data-dlv>
																	</span>
																</li>
																<li class="etd_child">
																	<span class="input_txt">
																		<input type="text" id="cpNo2" name="cpNo" maxlength="4" numberonly="true" data-dlv>
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		<input type="text" id="cpNo3" name="cpNo" maxlength="4" numberonly="true" data-dlv>
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">주소</span>
														</span>
													</th>
													<td class="txt_align01" data-dlvy="addr">
														<div class="form_layout_style06 clfix">
															<ul>
																<li class="form01 clfix">
<!-- 																	<span style="width:55px;" class="input_txt"> -->
<!-- 																		<input type="text" id="zipCd1" name="zipCd" readonly="readonly" data-dlv> -->
<!-- 																	</span> -->
<!-- 																	<span style="width:55px;" class="input_txt"> -->
<!-- 																		<input type="text" id="zipCd2" name="zipCd" readonly="readonly" data-dlv> -->
<!-- 																	</span> -->
<!-- 																	<a href="#" data-template="ui_popup_post_search" data-callback="callback_test01" class="btn_white01 ui_btn_popup" id="openZipCd">우편번호검색</a> -->
																	<span style="width:57px;" class="input_txt">
																		<input type="text" id="zipCd" name="zipCd" readonly="readonly"/>
																	</span>
																	<a href="javascript:void(0)" onclick="javascript:execDaumPostcode();" class="btn_white03">우편번호검색</a>
																</li>
																<li class="form02">
																	<span class="input_txt">
																		<input type="text" id="bsAddr" name="bsAddr" readonly="readonly" data-dlv>
																	</span>
																</li>
																<li>
																	<span class="input_txt">
																		<input type="text" id="dtlAddr" name="dtlAddr" data-dlv>
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<label for="delivery_wish" class="tit_style01">
															<span class="underline">배송시 요청사항</span>
														</label>
													</th>
													<td>
														<div class="input_txt">
															<input type="text" id="delivery_wish" name="delivery_wish" placeholder="부재시 경비실에 맡겨주세요">
														</div>
													</td>
												</tr>
											</tbody>
										</table>
										</form>
										<div class="btn_area clfix space01">
											<div class="btn01">
												<a href="#" class="btn_black01" data-template="ui_popup_change_profile" data-callback="callback_test01" id="nextStep">다음</a>
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
			<div id="zip_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			
			<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>			
	 		<script>
		    // 우편번호 찾기 화면을 넣을 element
		    var element_layer = document.getElementById('zip_layer');
	
		    function closeDaumPostcode() {
		        // iframe을 넣은 element를 안보이게 한다.
		        element_layer.style.display = 'none';
		    }
	
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = data.address; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수
	
		                // 기본 주소가 도로명 타입일때 조합한다.
		                if(data.addressType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }
	
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('zipCd').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('bsAddr').value = fullAddr;
		                //document.getElementById('sample2_addressEnglish').value = data.addressEnglish;
	
		                // iframe을 넣은 element를 안보이게 한다.
		                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
		                element_layer.style.display = 'none';
		            },
		            width : '100%',
		            height : '100%'
		        }).embed(element_layer);
		        // iframe을 넣은 element를 보이게 한다.
		        element_layer.style.display = 'block';
	
		        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		        initLayerPosition();
		    }
	
		    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		    function initLayerPosition(){
		        var width = 600; //우편번호서비스가 들어갈 element의 width
		        var height = 220; //우편번호서비스가 들어갈 element의 height
		        var borderWidth = 1; //샘플에서 사용하는 border의 두께
		        
		    	if(window.innerWidth < 640){
		    		width = window.innerWidth;
		    	}
	
		        // 위에서 선언한 값들을 실제 element에 넣는다.
		        element_layer.style.width = width + 'px';
		        element_layer.style.height = height + 'px';
		        element_layer.style.border = borderWidth + 'px solid';
		        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
		        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
		    }
		    
		    $(window).resize(function(){
		    	initLayerPosition();
		   	}).resize();		    
			</script>
		</div>
	</body>
</html>