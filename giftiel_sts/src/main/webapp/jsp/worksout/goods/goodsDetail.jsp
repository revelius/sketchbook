<%--
 * =============================================================================
 * 파일명 : /front/goods/goodsDetail.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-05-19
 *
 * 파일 내용 : onlineShop > 상품상세
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
	    //상품정보고시 데이터 가져오기 AJAX
		getGoodsAddInfoData = function(ubiGdsNo) {
			var formdata = {};
			formdata = "ubiGdsNo=" + ubiGdsNo;
			
			$.ajax({
		        url : "<c:url value='/front/onlineShop/goodsAddInfoAjax'/>",
		        type: "post",
		        data : formdata,
		        success : function(responseData){
		        	try{
			            var data = jQuery.parseJSON(responseData);
			            
			            if(responseData != 'null'){
				            $('#addInfoTable tbody').html('');
				            $("#title").html(data.gdsInfoNm);
				            $("#upd_btn").attr("href","javascript:openGoodsUpdInfo('"+data.gdsInfoNo+"');");
				            
				            for(var i=0;i<data.goodsAddInfos.length;i++){
				    	    	if(data.goodsAddInfos[i].title == "KC_YN"){
				    	    		if(data.goodsAddInfos[i].txt == "Y"){
					            	var html2 = "<tr>";
				    	    			html2 += "<th>안전품질표시</th>";
				    	    			html2 += "<td><img src=\"/resources/worksout/images/kc/KC-003_MODIFIED.jpg\" style=\"margin-bottom: 0px;max-width: 100%;\"></td>";
					    	    		html2 += "</tr>";
				    	    		}
				    	    	}else{
					            	var html = "<tr>";
				    	    		html += "<th>"+data.goodsAddInfos[i].title+"</th>";
				    	    		html += "<td>"+data.goodsAddInfos[i].txt+"</td>";
				    	    		html += "</tr>";
				    	    		$('#addInfoTable > tbody:last').append(html);
				    	    	}
				            }
				            $('#addInfoTable > tbody:last').append(html2);
			            }
		        	}catch(e){
		        		alert(e);
		        	}
		        },
		        error:function(request,status,error){
		            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};
		
	    //페이지 init
	    $(window).load(function() {
	    	// modify 151109 
	    	setEvent();

    		//상품정보고시 view
	    	getGoodsAddInfoData("${goodsForm.ubiGoods.ubiGdsNo}");
	    });		
	    
			
	    //상품 카트에 담기
		insertCart = function() {
			var carharttSeasonOffStrTime = new Date("2017-01-19 14:00:00");
			var carharttSeasonOffEndTime = new Date("2017-01-22 12:00:00");
			var nowDate = new Date();

			//시즌오프
			<c:if test="${siteNo == 10002 }">
				if(carharttSeasonOffStrTime < nowDate && carharttSeasonOffEndTime > nowDate){
					alert("시즌 오프로 인하여 22일 낮 12시부터 구매가 가능합니다. " );
					return false;
				}
			</c:if>
	    	
			var ubiGdsNo = $("#cartData").val();
			var ubiGdsSize = $("select[name=ubiGoods\\.ubiGdsSize]").val();

			var size = ubiGdsSize.split("|")[0];
			var stock = ubiGdsSize.split("|")[1];					
			
	  		if(ubiGdsSize == ""){
	  			alert("사이즈를 선택해주세요.");
	  			return;
	  		}

	  		if(ubiGdsSize == "OFFLINE"){
	  			alert("오프라인 매장에서만 구매 가능합니다.");
	  			return;
	  		}
	  		
			
			var formdata = {};
			formdata = "ubiGdsNo=" + ubiGdsNo + "&ubiGdsSize=" + size;
			$.ajax({
		        url : "<c:url value='/front/order/cartInsert'/>",
		        type: "post",
		        data : formdata,
		        success : function(responseData){
		        	try{
						resultCode = responseData;
						if(resultCode == "0"){
							<c:if test="${!isMobile}">
								$("div#cartListWeb").html("");
								getCartDataWeb();
								
								if(confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?")){
									location.href="/front/order/cartList";
								}								
							</c:if>
							<c:if test="${isMobile}">
								$("div#cartList_mobile").html("");
								getCartData();

								$(".btn_all_menu02").trigger("click");
								setTimeout("$('a#cartCntMobile').trigger('click');",300);
							</c:if>
						}else if(resultCode == "1"){
							alert("이미 카트에 담은 상품입니다.");
						}
		        	}catch(e){
		        		alert(e);
		        	}
		        },
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });
		};   	    
		
		function checkStock(){
			var ubiGdsSize = $("select[name=ubiGoods\\.ubiGdsSize]").val();
			
			var size = ubiGdsSize.split("|")[0];
			var stock = ubiGdsSize.split("|")[1];			
			
			if(parseInt(stock) < 1){
				alert("오프라인 매장 재고 확인을 원하실 경우 고객센터(02-541-0856)로 문의 바랍니다");
				$("select[name=ubiGoods\\.ubiGdsSize]").val("");
				return false;
			}			
		}

		//modify 151109
		function setEvent(){
		    // 아이폰에서 장바구니 스크롤 문제 제거
		    var iosCh = wUtils.agent.deviceOsCheck().ios;
		    if (iosCh) {
		        $("select[name=ubiGoods\\.ubiGdsSize]").on('focus', function(e){
		            var curScroll = wUtils.scroll.nowScrollTop();
		            $('html, body').scrollTop(curScroll);
		        })
		    }
		}
		</script>
	</head>
	<body>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap" class="goodslist_height">
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
								<a href="#">HOME</a>
							</li>
							<li>
								<a href="#">ONLINESHOP</a>
							</li>
							<!-- <li>
								<a href="#">PRODUCT DETAIL</a>
							</li> -->
						</ul>
						<div class="menu_section">
							<div id="snb_shop_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="product_detail_area clfix">
									<div class="product_detail_info">
										<div class="product_info_fixed">
										<form:form id="goodsForm" name="goodsForm" method="post" modelAttribute="goodsForm" onsubmit="return check(form)">
											<input type="hidden" id="cartData" value="${goodsForm.ubiGoods.ubiGdsNo}">
											<div class="product_detail_info_content">
												<div class="product_detail_tit">
													<div class="txt01"><c:if test="${siteNo != 10004 }">${goodsForm.ubiGoods.brand }</c:if></div>
													<div class="txt02">${goodsForm.ubiGoods.ubiGdsNm }</div>
													<div class="txt03">${goodsForm.ubiGoods.color }</div>
													<div class="txt04">${goodsForm.ubiGoods.ubiGdsNo }</div>
												</div>
												<div class="product_detail_price">
													<span class="ico_price"><fmt:formatNumber type="currency" value="${goodsForm.ubiGoods.ubiSlPrc }" pattern="###,###" /></span>
												</div>
												<div class="product_position_ctr">
													<div class="product_space">
														<div class="product_detail_size">
															<span class="input_select">
																<form:select path="ubiGoods.ubiGdsSize" onchange="javascript:checkStock(this.value);">
																	<c:choose>
																		<c:when test="${goodsForm.offlineGoodsChk}"><form:option value="OFFLINE" disabled="">오프라인 매장에서만 구매 가능</form:option></c:when>
																		<c:otherwise>
																		<form:option value="">SIZE</form:option>
																		<c:forEach items="${goodsForm.currentGoodsSizes }" var="curSizes">
																			<c:if test="${currentSeason == goodsForm.ubiGoods.seasonCode}">
																				<c:if test="${curSizes.stock < 1 || goodsForm.gdsStat == 'GD00404'}">
																					<form:option value="${curSizes.ubiGdsSize }|${curSizes.stock }" disabled="true">${curSizes.ubiGdsSize }[SOLD OUT]</form:option>
																				</c:if>
																				<c:if test="${curSizes.stock > 0 && goodsForm.gdsStat == 'GD00402'}">
																					<form:option value="${curSizes.ubiGdsSize }|${curSizes.stock }" >${curSizes.ubiGdsSize }</form:option>
																				</c:if>																			
																			</c:if>
																			<c:if test="${currentSeason != goodsForm.ubiGoods.seasonCode}">
																				<c:if test="${curSizes.stock < 1 || goodsForm.gdsStat == 'GD00404'}">
																					<form:option value="${curSizes.ubiGdsSize }" disabled="true">${curSizes.ubiGdsSize }[SOLD OUT]</form:option>
																				</c:if>
																				<c:if test="${curSizes.stock > 0 && goodsForm.gdsStat == 'GD00402'}">
																					<form:option value="${curSizes.ubiGdsSize }">${curSizes.ubiGdsSize }</form:option>
																				</c:if>
																			</c:if>
																			</c:forEach>																				
																		</c:otherwise>
																	</c:choose>																	
																	
																	<%-- <form:options items="${goodsForm.currentGoodsSizes }" itemLabel="ubiGdsSize" itemValue="ubiGdsSize"/> --%>
																</form:select>															
															</span>
														</div>
														<div class="product_detail_cart">
															<a href="javascript:insertCart();" class="btn_add_cart">ADD TO CART</a>
														</div>
														<div class="product_detail_type">
															<a href="#" class="btn_information on">INFORMATION</a>
															<div class="product_detail_information nano-pane">
															${goodsForm.bsDesc }
															</div>
															<a href="#" class="btn_colors">OTHER COLORS</a>
																<ul style="display:none;" class="product_detail_colors clfix">
																	<c:forEach items="${currentGoodsColors }" varStatus="idx" var="colors">
																		<li>
																			<a href="<c:url value='/front/onlineShop/goodsDetail?ubiGdsNo=${colors.ubiGdsNo}'/>">
																				<img src="<c:url value='${uploadImage}${colors.mainImg}'/>" alt="">
																			</a>
																		</li>
																	</c:forEach>
																</ul>
														</div>
													</div>
												</div>
											</div>
											</form:form>
										</div>
									</div>
									<div class="product_detail_img">
										<c:forEach items="${goodsForm.goodsImages}" varStatus="listCount" var="goodsImage" begin="1">
											<img alt="상품이미지" src="<c:url value='${goodsImage.frontImgUrl}'/>" class="thumbnail" />
										</c:forEach>
											<%-- <table class="tbl_col01">
												<caption>상품 설명 테이블 입니다.</caption>
												<thead>
													<tr>
														<th scope="col">상품 설명</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="style01">${goodsForm.dtlDesc }</td>
													</tr>
												</tbody>
											</table> --%>
											<table class="tbl_col01 tbl_space01" style="margin-top:0px;">										
											<caption>상품 사이즈 테이블로 S,M,L,XL 사이즈에 대한 가슴너비, 어깨너비, 소매길이, 총 기장의 정보를 알 수 있습니다.</caption>
											<thead>
												<c:forEach items="${goodsForm.goodsSizes}" varStatus="listCount" var="sizeList">
													<c:if test="${listCount.index == 0}">
														<tr>
															<th scope="col">${sizeList.sizeNm }</th>
															<c:if test="${sizeList.size1 !=null}">
																<th scope="col">${sizeList.size1 }</th>
															</c:if>
															<c:if test="${sizeList.size2 !=null}">
																<th scope="col">${sizeList.size2 }</th>
															</c:if>
															<c:if test="${sizeList.size3 !=null}">
																<th scope="col">${sizeList.size3 }</th>
															</c:if>
															<c:if test="${sizeList.size4 !=null}">
																<th scope="col">${sizeList.size4 }</th>
															</c:if>
															<c:if test="${sizeList.size5 !=null}">
																<th scope="col">${sizeList.size5 }</th>
															</c:if>
															<c:if test="${sizeList.size6 !=null}">
																<th scope="col">${sizeList.size6 }</th>
															</c:if>
															<c:if test="${sizeList.size7 !=null}">
																<th scope="col">${sizeList.size7 }</th>
															</c:if>
															<c:if test="${sizeList.size8 !=null}">
																<th scope="col">${sizeList.size8 }</th>
															</c:if>
														</tr>
													</c:if>
												</c:forEach>												
											</thead>
											<tbody>
											<c:forEach items="${goodsForm.goodsSizes}" varStatus="listCount" var="sizeList">
												<c:if test="${listCount.index != 0}">
													<tr>
														<td>${sizeList.sizeNm }</td>
														<c:if test="${sizeList.size1 !=null}">
															<td>${sizeList.size1 }</td>
														</c:if>
														<c:if test="${sizeList.size2 !=null}">
															<td>${sizeList.size2 }</td>
														</c:if>
														<c:if test="${sizeList.size3 !=null}">
															<td>${sizeList.size3 }</td>
														</c:if>
														<c:if test="${sizeList.size4 !=null}">
															<td>${sizeList.size4 }</td>
														</c:if>
														<c:if test="${sizeList.size5 !=null}">
															<td>${sizeList.size5 }</td>
														</c:if>
														<c:if test="${sizeList.size6 !=null}">
															<td>${sizeList.size6 }</td>
														</c:if>
														<c:if test="${sizeList.size7 !=null}">
															<td>${sizeList.size7 }</td>
														</c:if>
														<c:if test="${sizeList.size8 !=null}">
															<td>${sizeList.size8 }</td>
														</c:if>
													</tr>
												</c:if>
											</c:forEach>
											</tbody>
										</table>
										<table class="tbl_row01 tbl_space01" id="addInfoTable" style="margin-top:15px;">
											<caption>제품 상세 정보로 제품소재, 색상, 치수, 원산지, 제조년월, 세탁방법 및 주의사항, 품질보증기준, 수입자, AS 책임자와
												전화번호 에 대해 확인 할 수 있습니다</caption>
											<colgroup>
												<col width="40%">
													<col width="60%">
											</colgroup>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
						<input type="hidden" id="oneDepth" value="${param.oneDepth=='undefined'? goodsForm.ubiGoods.seasonCode : param.oneDepth}">
						<input type="hidden" id="twoDepth" value="${goodsForm.ubiGoods.category1Code }">
						<input type="hidden" id="threeDepth" value="${goodsForm.ubiGoods.category1Code }">
						<input type="hidden" id="brand" value="<%-- ${goodsForm.ubiGoods.brand } --%>">
						<input type="hidden" id="sex" value="${goodsForm.ubiGoods.sex }">
						<input type="hidden" id="ubiGdsSize" value="${goodsForm.ubiGoods.ubiGdsSize }">			
						<input type="hidden" id="clbltnNm" value="${param.clbltnNm }">
						<input type="hidden" id="orderFlag" value="${param.orderFlag }">
						<input type="hidden" id="orderBy" value="${param.orderBy }">	
						<input type="hidden" id="viewType" value="${param.viewType }">					
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>