<%--
 * =============================================================================
 * 파일명 :  /front/myPage/manageDelivery.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-23
 *
 * 파일 내용 : 배송지 관리
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
    			$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			$(document).on("blur", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
    			
    			var mydlvAddrList = ${mydlvAddrListJson};
    			
    			
    			//배송지 선택
    			selectDlv = function(index){
    				var tel = mydlvAddrList[index].tel.split("-");
    				var cpNo = mydlvAddrList[index].cpNo.split("-");
//     				var zipCd1 = mydlvAddrList[index].zipCd.substr(0,3);
//     				var zipCd2 = mydlvAddrList[index].zipCd.substr(3,3);
    				
					$("#addrBynm").val(mydlvAddrList[index].addrBynm);
					$("#nm").val(mydlvAddrList[index].nm);
					$("#tel1").val(tel[0]);
					$("#tel2").val(tel[1]);
					$("#tel3").val(tel[2]);
					$("#cpNo1").val(cpNo[0]);
					$("#cpNo2").val(cpNo[1]);
					$("#cpNo3").val(cpNo[2]);
					$("#zipCd").val(mydlvAddrList[index].zipCd);
// 					$("#zipCd1").val(zipCd1);
// 					$("#zipCd2").val(zipCd2);
					$("#bsAddr").val(mydlvAddrList[index].bsAddr);
					$("#dtlAddr").val(mydlvAddrList[index].dtlAddr);
					$("#dlvAddrSeq").val(mydlvAddrList[index].dlvAddrSeq);
					if(mydlvAddrList[index].baseValYn=="Y"){
						$("input[data-dlvy='baseValYn']").prop("checked", true);
						$("input[data-dlvy='baseValYn']").prop("disabled", true);
						$("#baseValYn").val("Y");
					}else{
						$("input[data-dlvy='baseValYn']").prop("checked", false);
						$("input[data-dlvy='baseValYn']").prop("disabled", false);
						$("#baseValYn").val("N");
					}
					
    			};
    			
    			for(var i=0;i<mydlvAddrList.length;i++){
    				if(mydlvAddrList[i].baseValYn=="Y"){
    					selectDlv(i);
    				};
    			};
    			
    			
    			//기본배송지 지정
    			$("input[data-dlvy='baseValYn']").on("click",function(e){
    				
    				var addrBynm = $("input[name='addrBynm']:checked").parent().next().text();
    				
    				if(!confirm(addrBynm+"를 기본배송지로 적용하시겠습니까?")) return false;
    				
    				$.ajax({
       	   		        url : "<c:url value='/front/myPage/setBaseValYnAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#dlvForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res != null) {
       	   		            	alert("기본 주소지가 변경되었습니다.");
	       	   		         	var data = jQuery.parseJSON(res);
	    	   		     		mydlvAddrList = data;
		    	   		     	for(var i=0;i<mydlvAddrList.length;i++){
		    	    				if(mydlvAddrList[i].baseValYn=="Y"){
		    	    					selectDlv(i);
		    	    				};
		    	    			};
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
    			});
    			
    			
    			
    			//배송지 삭제
				$("#delDlv").on("click",function(e){
    				
//     				var addrBynm = $("input[name='addrBynm']:checked").parent().next().text();
    				
    				if(!confirm("배송지 정보를 삭제하시겠습니까?")) return false;
    				
    				
    				if($("input[data-dlvy='baseValYn']").is(":checked") == true){
    					alert("기본배송지는 삭제 할수 없습니다.");
    					return false;
    				}
    				
    				
    				$.ajax({
       	   		        url : "<c:url value='/front/myPage/delMydlvAddrAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#dlvForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		      		if (res != null) {
       	   		            	alert("배송지 정보가 삭제되었습니다.");
	       	   		         	var data = jQuery.parseJSON(res);
	    	   		     		mydlvAddrList = data;
	    	   		     		
	    	   		     		$("td[data-area='myDlv']").text("");
		    	   		     	var html = "";
		    	   		     	for(var i=0;i<mydlvAddrList.length;i++){
		    	    				if(mydlvAddrList[i].baseValYn=="Y"){
		    	    					selectDlv(i);
		    	    					html += "<span class='input_radio'>";
					    	   		    html += "<input type=\"radio\" id=\"addrBynm"+i+"\" name=\"addrBynm\" value=\""+mydlvAddrList[i].addrBynm+"\" onclick=\"selectDlv("+i+")\" checked=\"checked\">";
					    	   		    html += "</span>";
					    	   		    html += "<label for=\"addrBynm"+i+"\"> "+mydlvAddrList[i].addrBynm+" </label>";
		    	    				}else{
		    	    					html += "<span class='input_radio'>";
					    	   		    html += "<input type=\"radio\" id=\"addrBynm"+i+"\" name=\"addrBynm\" value=\""+mydlvAddrList[i].addrBynm+"\" onclick=\"selectDlv("+i+")\">";
					    	   		    html += "</span>";
					    	   		    html += "<label for=\"addrBynm"+i+"\"> "+mydlvAddrList[i].addrBynm+" </label>";
		    	    					
		    	    				};
		    	    			};
	    	    				$("td[data-area='myDlv']").html(html);
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
    			});
    			
    			
    			
    			
    			//배송지 수정
				$("#modDlv").on("click",function(e){
					e.preventDefault();
    				if(!confirm("배송지 정보를 수정하시겠습니까?")) return false;
    				
    				if(!formCheck()) return false; 
    				
    				$.ajax({
       	   		        url : "<c:url value='/front/myPage/modMydlvAddrAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#dlvForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		      		if (res != null) {
       	   		            	alert("배송지 정보가 수정되었습니다.");
	       	   		         	var data = jQuery.parseJSON(res);
	    	   		     		mydlvAddrList = data;
 	    	   		     		location.href="/front/myPage/manageDelivery";
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
    			});
    			
				
    			//배송지 추가
				$("#addDlv").on("click",function(e){
					e.preventDefault();
    				if(!confirm("배송지 정보를 추가하시겠습니까?")) return false;
    				
    				if(mydlvAddrList.length > 2){
    					alert("배송지는 최대 3개까지 등록 가능합니다. \n등록된 배송지를 수정 또는 삭제해주세요"); 
    					return false;
    				}
    				
    				location.href="<c:url value='/front/myPage/addMydlvAddr'/>";
    			});
    			
    			
				//우편번호 찾기
// 				$('#openZipCd').click(function() {
// 					window.open("<c:url value='/front/popup/zipCode/selectSido'/>","popup","width=500px,height=500px,scrollbars=yes");
// 				});
    			
				
				function formCheck(){
					var flag = true;
					$("input[name=nm],input[name=tel],input[name=cpNo],input[name=zipCd],input[name=bsAddr],input[name=dtlAddr]").each(function(){
						if($(this).val()==""){
							alert("모두 입력 후 추가하시기 바랍니다.");
							flag = false;
							return false;
						};

					});
					return flag;
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
											<a href="<c:url value="/front/myPage/memberInfo"/>">회원정보관리</a>
											<a href="<c:url value="/front/myPage/managePassword"/>">비밀번호관리</a>
											<a href="<c:url value="/front/myPage/manageDelivery"/>" class="on">배송지관리</a>
											<a href="<c:url value="/front/myPage/managePoint"/>">포인트현황</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="mypage_top_tit">배송지관리</div>
									<div class="mypage_content_layout01 space01">
										<form id="dlvForm" name="dlvForm"   method="post">
											<input type="hidden" id="dlvAddrSeq" name="dlvAddrSeq" value=""/>
											<input type="hidden" id="baseValYn" name="baseValYn" value=""/>
										<table class="tbl_row02">
											<caption>배송지관리 테이블로 배송지, 이름, 전화번호, 휴대폰, 주소 를 확인 할 수 있습니다.</caption>
											<colgroup>
												<col width="128px">
													<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">
															<label for="address01">배송지</label>
															</span>
														</span>
													</th>
													<td class="txt_align02 input_space01" data-area="myDlv">
													<c:choose>
														<c:when test="${not empty mydlvAddrList}">
														<c:forEach var="mydlvAddr" items="${mydlvAddrList}" varStatus="stat">
															<span class="input_radio">
																<input type="radio" id="addrBynm${stat.count}" name="addrAlias" value="${mydlvAddr.addrBynm}" onclick="selectDlv(${stat.index})" <c:if test="${mydlvAddr.baseValYn eq 'Y'}">checked="checked"</c:if>>
															</span>
															<label for="addrBynm${stat.count}">${mydlvAddr.addrBynm}</label>
														</c:forEach>
														</c:when>
													</c:choose>
													</td>
												</tr>
												<tr>
													<th>
														<span class="tit_style01">
															<span class="underline">
																<label for="address01">배송지명</label>
															</span>
														</span>
													</th>
													<td class="txt_align01" data-dlvy="addrBynm">
														<div class="input_txt">
															<input type="text" id="addrBynm" name="addrBynm" value="" />
														</div>
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
															<input type="text" id="nm" name="nm" value="">
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
																		<input type="text" id="tel1" name="tel" maxlength="3" numberonly="true">
																	</span>
																</li>
																<li class="etd_child">
																	<span class="input_txt">
																		<input type="text" id="tel2" name="tel" maxlength="4" numberonly="true">
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		<input type="text" id="tel3" name="tel"  maxlength="4" numberonly="true">
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
																		<input type="text" id="cpNo1" name="cpNo" maxlength="3" numberonly="true">
																	</span>
																</li>
																<li class="etd_child">
																	<span class="input_txt">
																		<input type="text" id="cpNo2" name="cpNo" maxlength="4" numberonly="true">
																	</span>
																</li>
																<li class="last_child">
																	<span class="input_txt">
																		<input type="text" id="cpNo3" name="cpNo" maxlength="4" numberonly="true">
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
<!-- 																		<input type="text" id="zipCd1" name="zipCd" readonly="readonly"> -->
<!-- 																	</span> -->
<!-- 																	<span style="width:55px;" class="input_txt"> -->
<!-- 																		<input type="text" id="zipCd2" name="zipCd" readonly="readonly"> -->
<!-- 																	</span> -->
<!-- 																	<a href="#" data-template="ui_popup_post_search" data-callback="callback_test01" class="btn_white01 ui_btn_popup" id="openZipCd">우편번호검색</a> -->
																	<span style="width:57px;" class="input_txt">
																		<input type="text" id="zipCd" name="zipCd" readonly="readonly"/>
																	</span>
																	<a href="javascript:void(0)" onclick="javascript:execDaumPostcode();" class="btn_white03">우편번호검색</a>
																</li>
																<li class="form02">
																	<span class="input_txt">
																		<input type="text" id="bsAddr" name="bsAddr" readonly="readonly">
																	</span>
																</li>
																<li>
																	<span class="input_txt">
																		<input type="text" id="dtlAddr" name="dtlAddr">
																	</span>
																</li>
															</ul>
														</div>
													</td>
												</tr>
												<tr>
													<th>
														<span class="hide_txt">적용하기</span>
													</th>
													<td class="txt_align01">
														<span class="input_check">
															<input type="checkbox" id="base_address" name="base_address" data-dlvy="baseValYn">
															<label for="base_address" class="point01">기본 주소지로 적용</label>
														</span>
													</td>
												</tr>
											</tbody>
										</table>
										</form>
										<div class="btn_area05 clfix">
											<div class="btn01">
												<a href="#" class="btn_black01" id="addDlv">신규 배송지 추가</a>
											</div>
											<div class="btn02">
												<a href="#" class="btn_black01" id="modDlv">배송지 수정</a>
											</div>
											<div class="btn03">
												<a href="#" class="btn_gray01" id="delDlv">배송지 삭제</a>
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