<%--
 * =============================================================================
 * 파일명 : /front/order/orderForm.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-25
 *
 * 파일 내용 : order > 주문서작성
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
			
			var mydlvAddrList = "";
			var jsonList = '${mydlvAddrListJson}';
			
			//배송지 선택
			selectDlv = function(index){

				$("input:radio[name='delivery']").removeAttr("checked");

				var tel1 = mydlvAddrList[index].tel.split("-")[0];
				var tel2 = mydlvAddrList[index].tel.split("-")[1];
				var tel3 = mydlvAddrList[index].tel.split("-")[2];

				var cpNo1 = mydlvAddrList[index].cpNo.split("-")[0];
				var cpNo2 = mydlvAddrList[index].cpNo.split("-")[1];
				var cpNo3 = mydlvAddrList[index].cpNo.split("-")[2];
				
				var zipCd1 = mydlvAddrList[index].zipCd;

				$("#ordrNm").val(mydlvAddrList[index].nm);
				$("#ordrTel01").val(tel1);
				$("#ordrTel02").val(tel2);
				$("#ordrTel03").val(tel3);
				$("#ordrCp01").val(cpNo1);
				$("#ordrCp02").val(cpNo2);
				$("#ordrCp03").val(cpNo3);
				$("#ordrZipCd").val(zipCd1);
				
				$("#ordrBsAddr").val(mydlvAddrList[index].bsAddr);
				$("#ordrDtlAddr").val(mydlvAddrList[index].dtlAddr);
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
			
			if(jsonList.length > 0){
	 			mydlvAddrList = jQuery.parseJSON(jsonList);
				for(var i=0;i<mydlvAddrList.length;i++){
					if(mydlvAddrList[i].baseValYn=="Y"){
						selectDlv(i);
					};
				};
			}
			

		    $("#btn_order").click(function() {


		    	if($("#ordrNm").val()==""){
		    		alert("주문자명을 입력해 주세요.");
		    		$("#ordrNm").focus();
		    		return false;
		    	}

		    	if($("#ordrTel01").val()==""){
		    		alert("전화번호를 입력해 주세요.");
		    		$("#ordrTel01").focus();
		    		return false;
		    	}

		    	if($("#ordrTel02").val()==""){
		    		alert("전화번호를 입력해 주세요.");
		    		$("#ordrTel02").focus();
		    		return false;
		    	}

		    	if($("#ordrTel03").val()==""){
		    		alert("전화번호를 입력해 주세요.");
		    		$("#ordrTel03").focus();
		    		return false;
		    	}

		    	if($("#ordrCp01").val()==""){
		    		alert("휴대폰 번호를 입력해 주세요");
		    		$("#ordrCp01").focus();
		    		return false;
		    	}

		    	if($("#ordrCp02").val()==""){
		    		alert("휴대폰 번호를 입력해 주세요");
		    		$("#ordrCp02").focus();
		    		return false;
		    	}

		    	if($("#ordrCp03").val()==""){
		    		alert("휴대폰 번호를 입력해 주세요");
		    		$("#ordrCp03").focus();
		    		return false;
		    	}

		    	if($("#ordrZipCd").val()==""){
		    		alert("배송 주소를 입력해 주세요.");
		    		$("#ordrZipCd").focus();
		    		return false;
		    	}

		    	if($("#ordrBsAddr").val()==""){
		    		$("#ordrBsAddr").focus();
		    		return false;
		    	}

		    	if($("#ordrDtlAddr").val()==""){
		    		alert("배송 상세주소를 입력해 주세요.");
		    		$("#ordrDtlAddr").focus();
		    		return false;
		    	}
		    	
		    	
		    	<c:if test="${member.curPoint == 0 }">
	    		if($("#payAmt").val() != 0){
	    			alert("적립금이 없어 사용할 수 없습니다.");
	    			return false;
	    		}
		    	</c:if>
		    	
		    	<c:if test="${member.curPoint > 0 }">

	    		if($("#payAmt").val() > ${member.curPoint}){
	    			alert("${member.curPoint}" + "점 이상 사용 할 수 없습니다.");
	    			return false;
	    		}

		    	</c:if>

		    	
		    	//포인트 전액 결제의 경우 pg를 타지 않게 다른페이지로 넘긴다
				if(parseInt($("#payAmt").val()) == parseInt(${totalSlAmt + deliveryCost})){
					
				}else{
			    	if($("input[name='orderPay[0].payWay']:checked").length == 0){
			    		alert("결제 수단을 입력해 주세요.")
// 			    		$("input[name='orderPay[0].payWay']").focus();
			    		$("#pay_type01").focus();
			    		return false;
			    	}
				}		    			    	
		    	


		    	if(!$("#agree").is(":checked")){
		    		alert("주문정보제공 동의 약관에 동의하여야 주문이 가능합니다..");
		    		$("#agree").focus();
		    		return false;
		    	}

		    	var frm = document.orderForm;
		        frm.target = '_self';
		        frm.action = 'orderConfirm';
		        frm.submit();
		    });
		    
		 	// 기본배송지
			$("#delivery01").click(function(){
				$("input:radio[name='addrBynm']").removeAttr("checked");
				
				$.ajax({
			        url : "<c:url value='/front/order/orderFormDefaultAddrAjax'/>",
			        type: "post",
			        data : $('form#orderForm').serialize(),
			        async: true,
			        success : function(responseData){
 			        	try{
 			        		var data = jQuery.parseJSON(responseData);
 			        		if (data.length >= 1) {

 			        			$("#ordrNm").val(data[0].nm);
 			        			$("#ordrTel01").val(data[0].tel.split("-")[0]);
 			        			$("#ordrTel02").val(data[0].tel.split("-")[1]);
 			        			$("#ordrTel03").val(data[0].tel.split("-")[2]);
 			        			$("#ordrCp01").val(data[0].cpNo.split("-")[0]);
 			        			$("#ordrCp02").val(data[0].cpNo.split("-")[1]);
 			        			$("#ordrCp03").val(data[0].cpNo.split("-")[2]);
 			        			$("#ordrZipCd").val(data[0].zipCd);
 			        			$("#ordrBsAddr").val(data[0].bsAddr);
 			        			$("#ordrDtlAddr").val(data[0].dtlAddr);

 			        		} 			        			
 			        	}catch(e){
 			        		alert(e);
 			        	}
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
// 			        ,complete:function(request,status){ 
// 			        	isLoading = false; 
// 			        } 
			    });
		    });
			
		 	// 이전배송지
			$("#delivery02").click(function(){
				$("input:radio[name='addrBynm']").removeAttr("checked");
				
				$.ajax({
			        url : "<c:url value='/front/order/orderFormRecentAddrAjax'/>",
			        type: "post",
			        data : $('form#orderForm').serialize(),
			        async: true,
			        success : function(responseData){
 			        	try{
 			        		var data = jQuery.parseJSON(responseData);
 			        		if (data != null) {
 			        			$("#ordrNm").val(data.nm);
 			        			$("#ordrTel01").val(data.tel.split("-")[0]);
 			        			$("#ordrTel02").val(data.tel.split("-")[1]);
 			        			$("#ordrTel03").val(data.tel.split("-")[2]);
 			        			$("#ordrCp01").val(data.cpNo.split("-")[0]);
 			        			$("#ordrCp02").val(data.cpNo.split("-")[1]);
 			        			$("#ordrCp03").val(data.cpNo.split("-")[2]);
 			        			$("#ordrZipCd").val(data.zipCd);
 			        			$("#ordrBsAddr").val(data.bsAddr);
 			        			$("#ordrDtlAddr").val(data.dtlAddr);
 			        		}else{
 			        			$("#ordrNm").val("");
 			        			$("#ordrTel01").val("");
 			        			$("#ordrTel02").val("");
 			        			$("#ordrTel03").val("");
 			        			$("#ordrCp01").val("");
 			        			$("#ordrCp02").val("");
 			        			$("#ordrCp03").val("");
 			        			$("#ordrZipCd").val("");
 			        			$("#ordrBsAddr").val("");
 			        			$("#ordrDtlAddr").val("");
 			        		}
 			        	}catch(e){
 			        		alert(e);
 			        	}
			        },
			        error:function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
// 			        ,complete:function(request,status){ 
// 			        	isLoading = false; 
// 			        }
			    });
			});
			
			// 신규배송지
			$("#delivery03").click(function(){
				
				$("input:radio[name='addrBynm']").removeAttr("checked");
				
 				$("#ordrNm").val("");
     			$("#ordrTel01").val("");
     			$("#ordrTel02").val("");
     			$("#ordrTel03").val("");
     			$("#ordrCp01").val("");
     			$("#ordrCp02").val("");
     			$("#ordrCp03").val("");
     			$("#ordrZipCd").val("");
     			$("#ordrBsAddr").val("");
     			$("#ordrDtlAddr").val("");
			});
			
			
			//쿠폰적용 상품 SEQ
			var ordGoodsIdx = 0;
			
		 	// 쿠폰레이어 호출
		 	btnCpnPopup = function(index){
				$("#coup_apply_layer").show();
				ordGoodsIdx = index;
		    };	 			
			
		 	// 쿠폰 확인 AJAX
		 	
		 	var coupon_data = "";
		 	var couponCheck = false;
			$("#sch_offCpnInfo").click(function(){
				var offCpnNo = $("#sch_offCpnNo").val();
				var ubiGdsNo = $("#orderGoods"+ordGoodsIdx+"\\.ubiGdsNo").val();
				if(offCpnNo == ''){
					alert("쿠폰번호를 입력해주세요.");
					return false;
				}
				$.ajax({
			        url : "<c:url value='/front/coupon/offCpnInfoAjax'/>",
			        type: "post",
			        data : "offCpnNo="+offCpnNo+"&ubiGdsNo="+ubiGdsNo,
			        async: true,
			        success : function(responseData){
 			        	try{
 			        		coupon_data = jQuery.parseJSON(responseData);
 			        		
 			        		if(coupon_data == null){
 			        			alert("존재하지 않는 쿠폰입니다.");
 			        		}else{
 			        			if(coupon_data.cpnVldChk == 'N'){
 			        				alert("사용기간이 만료된 쿠폰입니다..");
 			        				$("#sch_offCpnNo").val("");
 			        				coupon_data = null;
 			   						return false;
 			        			}
 			        			
 			        			if(coupon_data.resultCode == '1'){
 			        				alert("이미 사용되거나 사용횟수가 초과된 쿠폰입니다.");
 			        				$("#sch_offCpnNo").val("");
 			        				coupon_data = null;
 			   						return false;
 			        			}else if(coupon_data.resultCode == '2'){
 			        				alert("이 상품에는 사용할 수 없습니다.");
 			        				$("#sch_offCpnNo").val("");
 			        				coupon_data = null;
 			   						return false; 			        				
 			        			}
 			        			
		        				$("#sch_coup_result").html("<strong>"+coupon_data.cpnNm+"</strong>");
			        			if(coupon_data.dcWay =='CM00202'){
 			        				$("#sch_coup_result").append(" : "+coupon_data.dcAmt+"% Discount");	
 			        			}else if(coupon_data.dcWay =='CM00201'){
 			        				$("#sch_coup_result").append(" : "+coupon_data.dcAmt+"원 Discount");
 			        			}
			        			
			        			couponCheck = true;
 			        		}
 			        	}catch(e){
 			        		alert(e);
 			        	}
			        },
			        error:function(request,status,error){
			            console.log("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
// 			        ,complete:function(request,status){ 
// 			        	isLoading = false; 
// 			        } 
			    });
		    });	
		 	
		 	var coupTotalAmt = 0;
			$("#couponApplyBtn").click(function(){
				if(!couponCheck){
					alert("쿠폰확인 버튼을 눌러주세요");
					return false;
				}
				
				if($("#sch_offCpnNo").val() == ''){
					alert("쿠폰번호를 입력해주세요.");
					return false;
				}
				
				for ( var i = 0; i < ${fn:length(cartList.carts)}; i++) {
					if($("#sch_offCpnNo").val() == $("#orderGoods"+i+"\\.offCpnNo").val()){
						alert("다른상품에 이미 적용된 쿠폰입니다.");
						$("#sch_offCpnNo").val("");
						$("#sch_coup_result").html("<strong>쿠폰번호</strong>를 기재해주세요.</p>");						
						return false;
					}
				}
				
				var goodsAmt = $("#orderGoods"+ordGoodsIdx+"\\.slPrc").val();
				var dicAmt = 0;
				if(coupon_data.dcWay =='CM00202'){
					dicAmt = parseInt(goodsAmt * coupon_data.dcAmt / 100);
     			}else if(coupon_data.dcWay =='CM00201'){
     				dicAmt = coupon_data.dcAmt;
     			}
				
				if(parseInt(dicAmt) > parseInt(coupon_data.maxDcAmt)){
					dicAmt = coupon_data.maxDcAmt;
				}
				
				
				$("#orderGoods"+ordGoodsIdx+"\\.cpnNo").val(coupon_data.cpnNo);
				$("#orderGoods"+ordGoodsIdx+"\\.offCpnNo").val($("#sch_offCpnNo").val());
				$("#orderGoods"+ordGoodsIdx+"\\.cpnPayAmt").val(dicAmt);
				$("#cpnPayAmt_span_"+ordGoodsIdx).html(comma(dicAmt));

				//쿠폰적용총합금액 합산
				coupTotalAmt = coupTotalAmt + dicAmt;
				

				//GADKWB7BQ2WN
				
				//상품금액 - 쿠폰할인금액
				$("#orderGoodsAmt_"+ordGoodsIdx).html(comma(parseInt($("#orderGoods"+ordGoodsIdx+"\\.slPrc").val() - dicAmt)));
				
				//토탈주문금액 변경
				$("#total_pay_amt").html(comma(parseInt($("#orderPay0\\.payAmt").val() - coupTotalAmt)));
				$("#coupTotalAmt").html(comma(coupTotalAmt));

				$("#coup_apply_layer").hide();
				$("#sch_offCpnNo").val("");
				$("#sch_coup_result").html("<strong>쿠폰번호</strong>를 기재해주세요.</p>");
				$("#coup_btn_"+ordGoodsIdx).hide();
		    });
		    
			$("#coup_cancel").click(function(){
				$("#coup_apply_layer").hide();
				$("#sch_offCpnNo").val("");
				$("#sch_coup_result").html("<strong>쿠폰번호</strong>를 기재해주세요.</p>");
		    });			
		 	
		});
		
		 function pointUse(total,memPoint){
			var pointIn = $("#payAmt").val();	// 입력포인트
			var numCheck = /^[,0-9]*$/;
			if(pointIn.length > 0){
				if(isNaN(pointIn) == true){
					if(!numCheck.test(pointIn)){
						alert("숫자만 입력하세요");
						$("#payAmt").val("");
						$("#point_out").html("0");
					};
				};
				if(pointIn > total){
					alert("결제금액을 초과 합니다.");
					
					if(parseInt($("#orderPay0\\.payAmt").val()) < parseInt("${member.curPoint }")){
						$("#payAmt").val($("#orderPay0\\.payAmt").val());
						$("#point_out").html(comma($("#orderPay0\\.payAmt").val()));
					}else{
						$("#payAmt").val(${member.curPoint });
						$("#point_out").html(comma(${member.curPoint }));
					};
				}else{
					$("#point_out").html(comma(pointIn));					
				}
			}else{
				$("#point_out").html(comma(pointIn));
			};
			
			if(parseInt($("#payAmt").val()) == parseInt(${totalSlAmt + deliveryCost})){
				$("input:radio[name='orderPay[0]\\.payWay']").removeAttr("checked");
				$("#pay_way_select").hide();
			}else{
				$("#pay_way_select").show();
			};
		 }

		 function pointAll(){
	
			  var pointall = 0;
			    if( $("input:checkbox[id='all_pay']").is(":checked") ) {
			    	pointall = "${member.curPoint }";
			    }
			    
				if(parseInt($("#orderPay0\\.payAmt").val()) < pointall){
					$("#payAmt").val($("#orderPay0\\.payAmt").val());
				}else{
					$("#payAmt").val(pointall);
				}

			    var pointIn = document.getElementById("payAmt").value;
				document.getElementById("point_out").innerHTML = comma(pointIn);

				pointUse(parseInt(${totalSlAmt + deliveryCost}),"${member.curPoint }");

		}
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/resources/worksout/images/common/blank_size_100.png" alt="">
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
								<a href="#">SHOPPING CART</a>
							</li>
							<li>
								<a href="#">ORDER</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_order_area">
								<!-- snbOrder include -->
								<!-- snbOrder include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu_step clfix">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="#">
												<span class="txt">상품선택</span>
											</a>
											<a href="#" class="on">
												<span class="txt">주문/결제</span>
											</a>
											<a href="#">
												<span class="txt">주문확인</span>
											</a>

											<a href="#" class="last_child">
												<span class="txt">주문완료</span>
											</a>
										</span>
									</div>
								</div>
								<form:form id="orderForm" name="orderForm" method="post" onsubmit="return check(form)" modelAttribute="orderForm">
								<form:hidden path="orderPay[0].payAmt" value="${totalSlAmt + deliveryCost}"/>

								<div class="cart_order_area">
									<table class="tbl_col02 tbl_col02_mypage_order_detail ui_reponsible_table_type01">
										<caption>상품선택 테이블로 체크박스, 상품, 가격, 적립포인트, 삭제 항목을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">상품</th>
												<th scope="col">쿠폰</th>
												<th scope="col">가격</th>
												<th scope="col">적립포인트</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="gdsIdx" value="0"/>
											<c:set var="totalExpPnt" value="0"/>
											<c:forEach items="${cartList.carts}" varStatus="listCount" var="cart">
											<c:if test="${cart.chkCart }">
											<form:hidden path="orderGoods[${gdsIdx}].ubiGdsNo" value="${cart.ubiGdsNo}"/>
											<form:hidden path="orderGoods[${gdsIdx}].ubiGdsSize" value="${cart.gdsSize}"/>
											<form:hidden path="orderGoods[${gdsIdx}].ubiGdsColorNm" value="${cart.ubiGdsColorNm}"/>
											<form:hidden path="orderGoods[${gdsIdx}].brnd" value="${cart.brand}"/>
											<form:hidden path="orderGoods[${gdsIdx}].ubiGdsNm" value="${cart.ubiGdsNm}"/>
											<form:hidden path="orderGoods[${gdsIdx}].slPrc" value="${cart.ubiSlPrc}"/>
											<form:hidden path="orderGoods[${gdsIdx}].mainImg" value="${cart.mainImg}"/>
											<form:hidden path="orderGoods[${gdsIdx}].ordQty" value="1"/>
											<form:hidden path="orderGoods[${gdsIdx}].expPnt" value="${cart.expPnt}"/>
											<c:set var="totalExpPnt" value="${totalExpPnt + cart.expPnt}"/>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">상품</div>
													<div class="tbl_cont clfix">
														<span class="p_img">
															<img src="<c:url value='${uploadImage}${cart.mainImg}'/>" width="76px">
														</span>
														<ul class="p_info">
															<li>[${cart.brand}] ${cart.ubiGdsNm}</li>
															<li>Color = ${cart.ubiGdsColorNm} / SIZE = ${cart.gdsSize}</li>
															<li>${cart.ubiGdsNo}</li>
														</ul>
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">쿠폰</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price" id="cpnPayAmt_span_${gdsIdx}">
															0
														</span>
															<form:hidden path="orderGoods[${gdsIdx}].cpnNo" value=""/>
															<form:hidden path="orderGoods[${gdsIdx}].offCpnNo" value=""/>
															<form:hidden path="orderGoods[${gdsIdx}].cpnPayAmt" value=""/>			
														<br/><a href="javascript:void(0)" onclick="javascript:btnCpnPopup(${gdsIdx});" class="btn_white03" id="coup_btn_${gdsIdx}">쿠폰적용</a>											
													</div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">가격</div>
													<div class="tbl_cont">
														<span href="#" class="ico_price" id="orderGoodsAmt_${gdsIdx}"><fmt:formatNumber type="currency" value="${cart.ubiSlPrc }" pattern="###,###" /></span>
													</div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">적립포인트</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${cart.expPnt}" pattern="###,###" /></div>
												</td>
											</tr>
											<c:set var="gdsIdx" value="${gdsIdx+1 }"/>
											</c:if>
											</c:forEach>
										</tbody>
									</table>
									<div class="layer_popup_wrap ui_popup_cancel_confirm" id="coup_apply_layer" style="display:none;">
										<div class="layer_popup layer_popup_center">
											<div class="layer_popup_container">
												<div class="layer_popup_content">
													<p class="layer_top_tit">쿠폰 사용</p>
													<p class="layer_info_txt01">
														<div class="post_input_area">
														<span class="input_txt">
															<input type="text" id="sch_offCpnNo" name="sch_offCpnNo" placeholder="프로모션 쿠폰 번호">
														</span>
														<a href="javascript:void(0)" id="sch_offCpnInfo" class="btn_gray01">확인</a>
													</div>
													<div id="sch_coup_result">
														<strong>쿠폰번호</strong>를 기재해주세요.</p>
													</div>
													<div class="btn_area04 clfix">
														<div class="btn01">
															<a href="#" class="btn_black01" id="couponApplyBtn">쿠폰적용</a>
														</div>
													</div>
												</div>
											</div>
											<a href="javascript:void(0)" onclick="$('#coup_apply_layer').hide();" class="layer_btn_close" id="coup_cancel">
												<img src="/resources/worksout/images/common/btn_close_all_menu.png" alt="닫기">
											</a>
										</div>
									</div>									
									<div class="mypage_tit clfix space01">
										<span class="txt01">주문자정보</span>
									</div>
									<div class="box_gray01 clfix">
										<ul class="cart_order_info01">
											<c:if test="${isLogined }">
											<li class="clfix">
												<div class="tit">
													<label for="delivery01">배송지</label>
												</div>
												<div class="desc">
													<div class="radio_group01">
														<span class="input_radio">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="radio" id="delivery01" name="delivery">
														</span>
														<label for="delivery01">기본배송지</label>
														<span class="input_radio">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="radio" id="delivery02" name="delivery">
														</span>
														<label for="delivery02">이전배송지</label>
														<span class="input_radio">
															<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
															<input type="radio" id="delivery03" name="delivery">
														</span>
														<label for="delivery03">신규배송지</label>
													</div>
													<div class="radio_group02" data-area="myDlv">
													<c:choose>
														<c:when test="${not empty mydlvAddrList}">
														<c:forEach var="mydlvAddr" items="${mydlvAddrList}" varStatus="stat">
															<span class="input_radio">
																<input type="radio" id="addrBynm${stat.count}" name="addrBynm" value="${mydlvAddr.addrBynm}" onclick="selectDlv(${stat.index})" <c:if test="${mydlvAddr.baseValYn eq 'Y'}">checked="checked"</c:if>>
															</span>
															<label for="addrBynm${stat.count}">${mydlvAddr.addrBynm}</label>
														</c:forEach>
														</c:when>
													</c:choose>
													</div>
												</div>
											</li>
											</c:if>
											<li class="clfix">
												<div class="tit02">
													<label for="user_name">이름</label>
												</div>
												<div class="desc" data-dlvy="ordrNm">
													<span class="input_txt">
													<form:input path="ordrNm" id="ordrNm" value="${member.nm }"/>
													</span>
												</div>
											</li>
											<li class="clfix">
												<div class="tit02">
													<label for="tel_number01">전화번호</label>
												</div>
												<div class="desc" data-dlvy="ordrTel">
													<div class="input_area02 clfix">
														<span class="input_txt">
															<%-- <form:input path="ordrTel01" id="ordrTel01" value="${fn:split(member.cpNo,'-')[0] }" numberonly="true" /> --%>
															<input type="number" id="ordrTel01" name="ordrTel01" value="${fn:split(member.cpNo,'-')[0] }">
														</span>
														<span class="input_txt">
															<%-- <form:input path="ordrTel02" id="ordrTel02" value="${fn:split(member.cpNo,'-')[1] }" maxlength="4" numberonly="true"/> --%>
															<input type="number" id="ordrTel02" name="ordrTel02" value="${fn:split(member.cpNo,'-')[1] }">
														</span>
														<span class="input_txt last_child">
															<%-- <form:input path="ordrTel03" id="ordrTel03" value="${fn:split(member.cpNo,'-')[2] }" maxlength="4" numberonly="true"/> --%>
															<input type="number" id="ordrTel03" name="ordrTel03" value="${fn:split(member.cpNo,'-')[2] }">
														</span>
													</div>
												</div>
											</li>
											<li class="clfix">
												<div class="tit02">
													<label for="phone_number01">휴대폰번호</label>
												</div>
												<div class="desc">
													<div class="input_area02 clfix" data-dlvy="ordrCp">
																	<span class="input_txt">
																		<%-- <form:input path="ordrCp01" id="ordrCp01" value="${fn:split(member.cpNo,'-')[0] }" maxlength="3" numberonly="true"/> --%>
																		<input type="number" id="ordrCp01" name="ordrCp01" value="${fn:split(member.cpNo,'-')[0] }">
																	</span>
																	<span class="input_txt">
																		<%-- <form:input path="ordrCp02" id="ordrCp02" value="${fn:split(member.cpNo,'-')[1] }" maxlength="4" numberonly="true"/> --%>
																		<input type="number" id="ordrCp02" name="ordrCp02" value="${fn:split(member.cpNo,'-')[1] }">
																	</span>
																	<span class="input_txt last_child">
																		<%-- <form:input path="ordrCp03" id="ordrCp03" value="${fn:split(member.cpNo,'-')[2] }" maxlength="4" numberonly="true"/> --%>
																		<input type="number" id="ordrCp03" name="ordrCp03" value="${fn:split(member.cpNo,'-')[2] }">
																	</span>
													</div>
												</div>
											</li>
										</ul>
										<ul class="cart_order_info01">
											<li class="clfix">
												<div class="tit02">
													<label for="post01">주소</label>
												</div>
												<div class="desc" data-dlvy="addr">
													<div class="input_area01 clfix">
														<span style="width:57px;" class="input_txt">
															<form:input path="ordrZipCd" id="ordrZipCd" readonly="true"/>
														</span>
														<%-- <span style="width:57px;" class="input_txt">
															<form:input path="ordrZipCd02" id="ordrZipCd02" readonly="readonly"/>
														</span> --%>
														<a href="javascript:void(0)" onclick="javascript:execDaumPostcode();" class="btn_white03" id="btnPost">우편번호검색</a>
													</div>
													<span class="input_txt etc_input_txt01">
														<form:input path="ordrBsAddr" id="ordrBsAddr" readonly="true"/>
													</span>
													<span class="input_txt etc_input_txt02">
														<form:input path="ordrDtlAddr" id="ordrDtlAddr"/>
													</span>
												</div>
											</li>
											<li class="clfix">
												<div class="tit">
													<label fot="delivery_wish">배송시
														<br> 요청사항
													</label>
												</div>
												<div class="desc">
													<div class="input_textarea input_textarea_type01">
														<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
														<form:textarea path="dlvSvcMemo" placeholder="부재시 경비실에 맡겨주세요"/>
													</div>
												</div>
											</li>
										</ul>
									</div>
									<div class="mypage_tit clfix space01">
										<span class="txt01">결제정보</span>
									</div>
									<div class="box_gray01 clfix">
										<div class="clfix">
											<ul class="mypage_info05 clfix mypage_position">
												<li class="size03" <c:if test="${!isLogined }">style="display:none;"</c:if> >
													<div class="bg_container">
														<div class="tit">포인트</div>
														<div class="desc">
															<dl class="clfix">
																<dt>보유포인트 :
																	<strong><fmt:formatNumber type="currency" value="${member.curPoint }" pattern="###,###" /></strong>
																</dt>
																<dd class="point_check">
																	<span class="input_check">
																		<input type="checkbox" id="all_pay" name="all_pay" onclick="pointAll();" >
																		<!-- id값 변경시 아래 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																	</span>
																	<label for="all_pay">모두사용</label>
																</dd>
															</dl>
															<dl class="point_area clfix">
																<dt class="point_input">
																	<span class="input_txt" onchange="pointUse(${totalSlAmt + deliveryCost}, ${member.curPoint });">
																		<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																		<form:input path="orderPay[1].payAmt" value="0" id="payAmt" pattern="###,###" onkeyup=""/>
																		<form:hidden path="orderPay[1].payWay" value="OR00804"/>
																	</span>
																</dt>
																<dd class="point_txt">
																	<label for="point_num">Point</label>
																	</dd>
															</dl>
<!-- 															<p class="notice_txt">* 3천점 이상, 1천단위로 사용 가능합니다.</p> -->
														</div>
													</div>
													<div class="line_bg"></div>
												</li>
												<li class="size03_2" id="pay_way_select">
													<div class="bg_container">
														<div class="tit">
															<label for="pay_type01">결제수단</label>
														</div>
														<div class="desc clfix" >
															<div class="pay_area first_child">
																<span class="input_radio">
																	<form:radiobutton path="orderPay[0].payWay" id="pay_type01" value="OR00801"/>
																</span>
																<label for="pay_type01">신용카드</label>
															</div>
															<div class="pay_area">
																<span class="input_radio">
																	<form:radiobutton path="orderPay[0].payWay" id="pay_type02" value="OR00802"/>
																</span>
																<label for="pay_type02">계좌이체</label>
															</div>
 															<div class="pay_area">
																<span class="input_radio">
																	<form:radiobutton path="orderPay[0].payWay" id="pay_type03" value="OR00803"/>
																</span>
																<label for="pay_type03">가상계좌</label>
															</div>
														</div>
													</div>
													<!-- <div class="line_bg02"></div> -->
												</li>
												<%-- <li class="size03_2" id="coupon_select">
													<div class="bg_container">
														<div class="tit">
															<label for="pay_type01">쿠폰사용</label>
														</div>
														<dl class="point_area clfix">
															<dt class="point_input">
																<span class="input_txt">
																	<!-- id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함. -->
																	<form:hidden path="orderPay[2].payAmt" value="0" id="coupon_pay_amt"/>
																	<form:hidden path="orderPay[2].payWay" value="OR00805"/>
																</span>
															</dt>
															<dd class="point_txt">
																<label for="point_num">Point</label>
																</dd>
														</dl>
													</div>
													<!-- <div class="line_bg02"></div> -->
												</li>	 --%>											
												<!-- <li class="size03">
													<div class="bg_container">
														<div class="tit clfix">
															<span class="tit_cell01">
																<label for="pay_receipt01">현금영수증</label>
															</span>
															<span class="tit_cell02">
																<span class="input_check">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="checkbox" id="no_receipt" name="no_receipt">
																</span>
																<label for="no_receipt">신청안함</label>
															</span>
														</div>
														<div class="desc clfix">
															<div class="pay_area first_child">
																<span class="input_radio">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="radio" id="pay_receipt01" name="pay_receipt">
																</span>
																<label for="pay_receipt01">소득공제용 (개인)</label>
															</div>
															<div class="pay_area">
																<span class="input_radio">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="radio" id="pay_receipt02" name="pay_receipt">
																</span>
																<label for="pay_receipt02">지출증빙용 (사업자)</label>
															</div>
															소득공제용(개인) 선택시 노출
															<div class="select_show_area clfix">
																<div class="s_tit">
																	<label for="receipt_phone01">휴대폰번호</label>
																</div>
																<span class="input_select">
																	<select id="receipt_phone01">
																		<option>010</option>
																	</select>
																</span>
																<span class="input_txt first_child">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="text" id="receipt_phone02" name="receipt_phone">
																</span>
																<span class="input_txt">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="text" id="receipt_phone03" name="receipt_phone">
																</span>
															</div>
															소득공제용(개인) 선택시 노출
															지출증빙용(사업자) 선택시 노출
															<div class="select_show_area clfix">
																<div class="s_tit">
																	<label for="receipt_biz01">사업자등록번호</label>
																</div>
																<span class="input_txt receipt_biz01">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="text" id="receipt_biz01" name="receipt_biz">
																</span>
																<span class="input_txt receipt_biz02">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="text" id="receipt_biz02" name="receipt_biz">
																</span>
																<span class="input_txt receipt_biz03">
																	id값 변경시 위에 <label> 태그내 for="" 값도 같이 변경 해야함.
																	<input type="text" id="receipt_biz03" name="receipt_biz">
																</span>
															</div>
															지출증빙용(사업자) 선택시 노출
														</div>
													</div>
												</li> -->
											</ul>
										</div>
									</div>

									<table class="tbl_col02 space01 tbl_col02_mypage_order_list02 ui_reponsible_table_type01">
										<caption>주문 정보 테이블로 총 가격, 포인트사용액, 배송비, 적립 예정포인트, 총 결제금액을 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">총 가격</th>
												<th scope="col">포인트사용액</th>
												<th scope="col">배송비</th>
												<th scope="col">쿠폰 사용액</th>
												<th scope="col">적립 예정포인트</th>
												<th scope="col">총 결제금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="tbl_layout01">
													<div class="mobile_th">총 가격</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${totalSlAmt }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout02">
													<div class="mobile_th">포인트사용액</div>
													<div class="tbl_cont" id="point_out" >0</div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">배송비</div>
													<div class="tbl_cont">+<fmt:formatNumber type="currency" value="${deliveryCost }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout03">
													<div class="mobile_th">쿠폰 사용액</div>
													<div class="tbl_cont" id="coupTotalAmt">0</div>
												</td>												
												<td class="tbl_layout04">
													<div class="mobile_th">총 적립 예정포인트</div>
													<div class="tbl_cont"><fmt:formatNumber type="currency" value="${totalExpPnt }" pattern="###,###" /></div>
												</td>
												<td class="tbl_layout05">
													<div class="mobile_th">총 결제금액</div>
													<div class="tbl_cont">
														<span class="ico_price" id="total_pay_amt"><fmt:formatNumber type="currency" value="${totalSlAmt + deliveryCost}" pattern="###,###" /></span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									
									<span class="txt01"> ※ 10만원 이상 구매 시 무료 배송 입니다. </span>
									
									<div class="mypage_tit clfix space04">
										<span class="txt01">주문정보 및 개인정보 제3자 제공 동의</span>
									</div>
									<div id="join_agreement_load03" class="join_agreement"></div>
									<!-- /inc/layout/agreement03.html -->
									<div class="join_agree_check02">
										<label for="agree" class="inputu_check_type01">
											<input type="checkbox" id="agree" name="agree">
											<span class="txt">위 내용을 확인하였으며, 동의합니다.</span>
										</label>
									</div>
									<!-- 상황에 맞게 아래 btn01, btn02 영역을 삭제 할 수 있습니다. -->
									<div class="btn_area04 clfix">
										<div class="btn01">
											<a href="#" class="btn_gray01">뒤로</a>
										</div>
										<div class="btn02">
											<a href="#" class="btn_black01" id="btn_order">다음</a>
										</div>
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
			<div id="zip_layer" style="display:none;position:absolute;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
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
		                document.getElementById('ordrZipCd').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('ordrBsAddr').value = fullAddr;
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
			    //alert('indow.innerWidth : '+window.innerWidth);
			    //alert('indow.inner : '+wUtils.stage.inner().w);
			    var width = 600; //우편번호서비스가 들어갈 element의 width
			    var height = 220; //우편번호서비스가 들어갈 element의 height
			    var borderWidth = 1; //샘플에서 사용하는 border의 두께
			    var activating = ($(element_layer).css('display') != 'none');   // 현재 팝업 활성화 여부 
			    var iosCh = wUtils.agent.deviceOsCheck().ios;
			
			    if (!activating) return;
			    //console.log('[initLayerPosition]',wUtils.stage.inner().w, $(window).width());
			
			    var widthSize = (iosCh)?$(window).width():wUtils.stage.inner().w;
			
			    if(widthSize < 640){
			        width = widthSize - 10;
			    }
			    
			
			    // 위에서 선언한 값들을 실제 element에 넣는다.
			    element_layer.style.width = width + 'px';
			    element_layer.style.height = height + 'px';
			    element_layer.style.border = borderWidth + 'px solid';
			
			    // IOS가 아니라면 
			    if (!iosCh) {
			        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
			        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
			        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
			    } else {
			        var _stage = wUtils.stage.inner();
			        $(element_layer).css({
			            'left': parseInt(($(window).width() - width -(borderWidth*2))/2)+'px',
			            'top': wUtils.scroll.nowScrollTop() + parseInt(($(window).height() - height)/2)+'px'
			        });
			    }
			}
		    
			$(function(){
			    if (wUtils.agent.deviceOsCheck().ios){
			        $(window).on('scroll', function(e){
			            wUtils.agent.deviceOsCheck().ios && initLayerPosition();
			        });
			    }
			})		    

		    $(window).resize(function(){
		    	initLayerPosition();
		   	}).resize();
			</script>
		</div>
	</body>
</html>