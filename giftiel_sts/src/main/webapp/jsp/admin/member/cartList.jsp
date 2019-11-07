<%--
 * =============================================================================
 * 파일명 : /member/cart.jsp
 * 작성자 : 정해란
 * 작성일자 : 2015-04-21
 *
 * 파일 내용 : 회원관리 > Cart 
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	
	<script>
	doGoMove = function(gubun){
		if(gubun== "1"){ //회원정보
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/membershipInfo'/>";
	        frm.submit();
		}else if(gubun== "2"){ //주문내역
			var frm = document.schForm;
	        frm.action = "<c:url value=' /admin/member/memberOrderList'/>";
	        frm.submit();
		}else if(gubun== "3"){ //1:1문의 
			var frm = document.schForm;
	        frm.action = "<c:url value='/admin/member/inquire'/>";
	        frm.submit();
		}	
	};
	
	
	doCartReg = function(){
		$("#gdsNo").val("");
		$(".sectionCartReg").fadeToggle();
	};
	
	var chkFlag = false;
	doGdSearch = function(){
		
		if($("#gdsNo").val() == ""){
			alert("검색할 상품번호를 입력하세요.");
			$("#gdsNo").focus();
			return;
		}
		
	 	$.ajax({
	        url : "<c:url value='/admin/member/selectGdsNo'/>",
	        type: "post",
	        data : {gdsNo :  $("#gdsNo").val()},
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data=="1"){  //저장 성공 
					alert("상품이 검색되었습니다. 등록하세요."); 
					doAddSize($("#gdsNo").val());
					chkFlag = true;
					return;
					
	            }else if(data=="2"){  //저장 성공 
					alert("존재하지 않는 상품입니다.");
					$("#gdsNo").val("");
					$("#sizeNm").html("");
		            $("#sizeNm").append("<option value=''>상품을 검색하세요.</option>");
					chkFlag = false;
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};
	
	
	doAddSize = function(gdsNo){
		$.ajax({
	        url : "<c:url value='/admin/cart/sizeList'/>",
	        type: "post",
	        data : {ubiGdsNo : gdsNo},
	        async: false,
	        success : function(responseData){
	        	try{
		            var data = jQuery.parseJSON(responseData);
		            $("#sizeNm").html("");
		            $("#sizeNm").append("<option value=''>선택하세요.</option>");
		            for(var i=0;i<data.length;i++){
						$("#sizeNm").append("<option value='"+data[i].ubiGdsSize+"'>"+data[i].ubiGdsSize+"</option>");
		            }
		            
		            if(data.length == 0){
		            	$("#sizeNm").html("");
			            $("#sizeNm").append("<option value=''>사이즈 없음</option>");
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
	
	doRegisterGds = function(){
		if(chkFlag == false){
			alert("상품을 검색한 후 등록하세요.");
			return;
		}
		if($("#sizeNm option").size() > 1 && $("#sizeNm").val()==""){
			alert("상품 사이즈를 선택하세요.");
			return;
		}
		
		if(!confirm("상품을 장바구니에 담으시겠습니까?")){
			return;
		}
		$.ajax({
	        url : "<c:url value='/admin/member/insertGdsCart'/>",
	        type: "post",
	        data : {gdsNo :  $("#gdsNo").val() , memNo : $("#memNo").val() ,gdsSize : $("#sizeNm").val() },
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data=="1"){  //저장 성공 
					alert("등록 되었습니다.");
					var frm = document.schForm;
			        frm.action = "<c:url value='/admin/member/cartList'/>";
			        frm.submit();
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};
	
	deleteCartGoods = function(cartNo){
		if(!confirm("해당 상품을 삭제하시겠습니까?")){
			return;
		}
		$.ajax({
	        url : "<c:url value='/admin/member/deleteGdsCart'/>",
	        type: "post",
	        data : {'cartNo' :  cartNo},
	        async: true,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data == "1"){  //저장 성공 
				    $("tr#cart_"+cartNo).fadeOut( "slow", function() {
				    });							
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};			
	
	//사이즈 조회하기 
	addSizeList = function(ubiGdsNo, count){
		
		if($("#size"+count+" option").size() > 1){
			return;
		}
		
		$.ajax({
	        url : "<c:url value='/admin/cart/sizeList'/>",
	        type: "post",
	        data : {ubiGdsNo : ubiGdsNo},
	        async: false,
	        success : function(responseData){
	        	try{
		            var data = jQuery.parseJSON(responseData);
		            $("#size"+count).html("");
		            $("#size"+count).append("<option value=''>선택하세요.</option>");
		            for(var i=0;i<data.length;i++){
						$("#size"+count).append("<option value='"+data[i].ubiGdsSize+"'>"+data[i].ubiGdsSize+"</option>");
		            }
		            
		            if(data.length == 0){
		            	$("#size"+count).html("");
		            	$("#size"+count).append("<option value=''>사이즈 없음</option>");
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
	
	//사이즈 변경
	doModifySize = function(cartNo, obj){
		var $target =  $(obj);
		var gdsSize = $target.parent().find("select").val();
		//alert($target.parent().find("select").val());
		/* 
		if($("#size"+count+" option").size() == 1){
			alert("변경할 상품 사이즈가 없습니다.");
			return;
		}
		
		if($("#size"+count+" option").size() > 1 && $("#size"+count).val()==""){
			alert("상품 사이즈를 선택하세요.");
			return;
		}
		 */
		if(!confirm("해당 상품의 사이즈를 변경하시겠습니까?")){
			return;
		}
		
		$.ajax({
	        url : "<c:url value='/admin/member/updateGdsSize'/>",
	        type: "post",
// 	        data : {ubiGdsNo :  ubiGdsNo , memNo : $("#memNo").val() , sizeNm : oriSizenm , gdsSize : $("#size"+count).val() },
	        data : {'gdsSize' : gdsSize , 'cartNo' : cartNo},
	        async: false,
	       // dataType: "json",
	       // contentType: "application/json", 
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data == "1"){  //저장 성공 
					alert("변경 되었습니다.");
					var frm = document.schForm;
			        frm.action = "<c:url value='/admin/member/cartList'/>";
			        frm.submit();
	            }              
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};
	
	
	//페이징 처리
    paging = function(page) {
        var frm = document.schForm;
        document.getElementById("page").value = page;
        goSubmit();
    };	
	
	//페이지 검색
    goSubmit = function(){
    	 var frm = document.schForm;
	        frm.target = '_self';
	        frm.action = "<c:url value='/admin/member/cartList'/>";
	        frm.submit();
    };
    
    
    
	</script>
</head> 
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">			
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
				<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="member"/>
				</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents memberList">				
					<h3><span class="icon1"></span>회원정보</h3>	
					<p class="pt_14">${searchForm.nm}(${searchForm.email}) 님의 정보<span>최종로그인 :
					<c:if test="${empty logingHist.regDts}">
						로그인 이력 없음
					</c:if>
					<fmt:formatDate value="${logingHist.regDts}" pattern="yyyy-MM-dd HH:mm:SS" /></span></p>

					<div class="tabType1">
						<ul>
							<li><a href="javascript:doGoMove('1');">회원정보</a></li>
							<li><a href="javascript:doGoMove('2');">주문내역</a></li>
							<li><a href="javascript:doGoMove('3');">1:1 문의</a></li>
							<li class="on"><a href="#">Cart</a></li>
						</ul>
					</div>
					<div class="section a2">
						<div class="tableType1">
							<table>
								<caption>상품 리스트</caption>
								<colgroup>
									<col width="5%" />
									<col width="*" />
									<col width="15%" />
									<col width="12%" />
									<col width="12%" />
								</colgroup>
								<thead>
									<tr>
<!-- 										<th><input type="checkbox" /></th> -->
										<th>상품</th>
										<th>가격</th>
										<th>적립포인트</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cartList}" var="list" varStatus="listCount">
									<tr id="cart_${list.cartNo }">
<!-- 										<td><input type="checkbox" /></td> -->
										<td class="imgBox">
											<img src="<c:url value='${uploadImage}${list.mainImg}'/>" alt="" style="width:50px;height:50px;"/>
											<div class="productText" style="width:400px;">
												<a href="#">[${list.brand }]<br/>${list.ubiGdsNm }<br/>${list.color }</a>
												<div>
													<span class="sectionSizeArea">Size : ${list.sizeNm} </span>
													<span class="input_select">
														<select>
															<c:forEach items="${list.currentGoodsSizes}" varStatus="subListCount" var="curSize">
																<option value="${curSize.ubiGdsSize}" <c:if test="${curSize.ubiGdsSize eq list.gdsSize}">selected="selected"</c:if>>${curSize.ubiGdsSize}</option>
															</c:forEach>
														</select>
													</span>
<%-- 													<select id="size${listCount.count}" name="size" onclick="javascript:addSizeList('${list.ubiGdsNo }','${listCount.count}');"> --%>
<!-- 														<option value="">여기를 클릭하세요.</option> -->
<!-- 													</select> -->
<%-- 													<a href="javascript:doModifySize('${list.ubiGdsNo }','${listCount.count}','${list.sizeNm}');" class="btnType1">변경</a> --%>
													<a href="#" class="btnType1" onclick="doModifySize('${list.cartNo}',this)">변경</a>
												</div>
											</div>
										</td>
										<td><fmt:formatNumber value="${list.ubiSlPrc}" groupingUsed="true"/>원</td>
										<td><fmt:formatNumber type="currency" value="${list.expPnt}" pattern="###,###" /></td>
										<td><a href="javascript:deleteCartGoods('${list.cartNo}');"><img src="<c:url value='/resources/admin/images/popup/closeBtn2.gif'/>" alt="주문삭제" /></a></td>
									</tr>
									</c:forEach>
									<c:if test="${empty cartList}">
										<tr>
											<td colspan="4">장바구니에 담은 상품이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
						<div class="btn">
							<a href="<c:url value='/admin/member/memberList'/>" class="btnType2 left">회원목록</a>
							<a href="javascript:doCartReg();" class="btnType2 right">주문추가</a>
						</div>
						<!--[s] 페이징 -->
						<div class="paging">
							<c:if test="${not empty cartList}">
							${pageHtml}
							</c:if>
						</div>
						<!--[e] 페이징 -->				
					</div>
					
					<form:form id="schForm" name="schForm" method="post" modelAttribute="searchForm" onsubmit="return check(form)">
								<form:hidden path="page" id="page"/>
								<form:hidden path="nm" id="nm"/>
        						<form:hidden path="email" id="email"/>
        						<form:hidden path="memNo" id="memNo"/>
        						<form:hidden path="orderFlag" id="orderFlag"/>
        						
					<div class="section a2 sectionCartReg" style="display:none;">
						<div class="tableType1">
							<table>
								<caption>주문추가</caption>
								<colgroup>
									<col width="*" />
									<col width="12%" />
									<col width="15%" />
									<col width="12%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="4">주문추가</th>
									</tr>
									<tr>
										<th>상품검색</th>
										<th>Size</th>
										<th>추가 주문일</th>
										<th>작성자</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="text" name="gdsNo" id="gdsNo" onkeypress="if(event.keyCode == 13) { doGdSearch();return false;}"/> <a href="javascript:doGdSearch();" class="btnType1">검색</a></td>
										<td>
											<select id="sizeNm" name="sizeNm">
												<option value="">상품을 검색하세요.</option>
											</select>
										</td>
										<%
										Date today = new Date();
										SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
										String dt = sf.format(today);
										%>
										<td><%=dt %></td>
										<td>${adminNm}</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="btn">
												<p class="left">※ 상품검색은 상품품번으로 검색하시기 바랍니다.</p>
												<span class="right"><a href="javascript:doRegisterGds();" class="btnType1">등록</a></span>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					</form:form>
					
				</div>
				<!--[e] contents -->
			</div>
			<!--[e] subWrap -->
		</div>
		<!--[e] container -->

		<!--[s] footer -->
			<jsp:include page="/jsp/admin/include/footer.jsp"/>
		<!--[e] footer -->

	</div>
</body>
</html>