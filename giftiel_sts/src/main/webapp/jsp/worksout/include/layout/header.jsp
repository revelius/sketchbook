<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	
<script src="/resources/common/jquery.cookie-1.4.1.min.js"></script>
<ul class="skipnav">
	<li>
		<a href="#content">컨텐츠 바로가기</a>
	</li>
</ul>
<script>
$(function()
{

	//파일다운로드
    fileExport= function(e){
    	var $target = $(e);
    	var fileName = $target.attr('data-file');

    	//alert(fileName);
    	var option = $("#option").val();

    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"&option="+option+"'/>");
    };


	//- $('.login_menu_area').hide();
	$('.find_id_area').hide();
	$('.find_pwd_area').hide();
	$('.non_members_order_info_area').hide();
	$('.login_menu_area a.btn_ico_arrow').click(function()
	{
		$('.login_menu_area').hide();
		$('.find_id_area').hide();
		$('.find_pwd_area').hide();
		$('.non_members_order_info_area').show();
		utilMenu.refresh();
	});
	$('.login_menu_area ul li:nth-child(1)').click(function()
	{
		$('.login_menu_area').hide();
		$('.find_id_area').show();
		$('.find_pwd_area').hide();
		$('.non_members_order_info_area').hide();
		utilMenu.refresh();
		allMenu02.utilRefresh();
	});
	$('.login_menu_area ul li:nth-child(2)').click(function()
	{
		$('.login_menu_area').hide();
		$('.find_id_area').hide();
		$('.find_pwd_area').show();
		$('.non_members_order_info_area').hide();
		utilMenu.refresh();
		allMenu02.utilRefresh();
	});
	$('.ui_notice_banner_ctr > a').on('click', function()
	{
		$('.top_notice_banner').hide();
	});


	

	$("#srcTxt").keydown(function(e){
		if (e.keyCode == 13) {
			$("#searchText").val($(this).val());
			$("#schForm").attr("method","GET");
			$("#schForm").attr("action","<c:url value='/front/search/search' />");
			$("#schForm").submit();
		}
	});

	$("#srcTxtM").keydown(function(e){
		if (e.keyCode == 13) {
			$("#searchText").val($(this).val());
			$("#schForm").attr("method","GET");
			$("#schForm").attr("action","<c:url value='/front/search/search' />");
			$("#schForm").submit();
		}
	});

	$("#email").keydown(function(e){
		if (e.keyCode == 13) {
			$("#pwd").focus();
		}
	});	
	
	$("#pwd").keydown(function(e){
		if (e.keyCode == 13) {
			loginAction();
		}
	});

	$("[data-id='btn_nMemInquiry']").on("click",function(e){
		e.preventDefault();
		var $target = $(e.currentTarget);
		var flag = false;
		$target.parents("div[class='non_members_order_info_area']").find("input[id^=nMem]").each(function(){
			if($(this).val()==""){
				alert("모두 입력 후 추가하시기 바랍니다.");
				flag = true;
				return false;
			}

		});

		if(flag) return false;

		var nMemNm = $("#nMemNm").val();
		var nMemPhone = $("#nMemPhone01").val() + "-" + $("#nMemPhone02").val() + "-" + $("#nMemPhone03").val();
		var nMemOrderNo = $("#nMemOrderNo").val();

			$.ajax({
  		        url : "<c:url value='/front/myPage/confirmAjax'/>",
  		        type: "post",
  		        data : "&nMemNm="+nMemNm+"&nMemPhone="+nMemPhone+"&nMemOrderNo="+nMemOrderNo,
  		        async: true,
  		        success : function(res){
  		        	console.log("res====" +res);
  		        	
  		            if (parseInt(res) > 0) {
  						location.href="<c:url value='/front/myPage/nMemMyPageHome'/>";
  					} else {
  						alert("입력정보를 확인하세요");
  					}
  		        },
  		        error:function(request,status,error){
  		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
  		        }
  		    });
	});


    //카트 정보 가져오기
    var cartMobileCount = 0;
    var cartData = "";
	getCartData = function() {
		$.ajax({
	        url : "<c:url value='/front/cartListAjax'/>",
	        type: "post",
	        data : "",
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = jQuery.parseJSON(responseData);
		            cartData = data;
		            var totalAmt = 0;
		            for(var i=0;i<data.length;i++){
			            var html = "<div class=\"silde_item clfix\" id=\"cart_"+data[i].cartNo+"\">";
		    	    		html += "<a href=/front/onlineShop/goodsDetail?ubiGdsNo="+data[i].ubiGdsNo+" class=\"p_img\">";
		    	    		html += "<img src=\"${uploadImage}"+data[i].mainImg2+"\" width=\"70px\" height=\"72px\" />";
		    	    		html += "</a>";
		    	    		html += "<div class=\"p_info\">";
		    	    		html += "<div class=\"p_name\">"+data[i].ubiGdsNm+"</div>";
		    	    		html += "<div class=\"p_size\">SIZE "+data[i].ubiGdsSize+"</div>";
		    	    		html += "<div class=\"ico_price\">"+comma(data[i].ubiSlPrc)+"</div>";
		    	    		html += "</div>";
		    	    		html += "<a href=\"javascript:deleteCartGoodsHeader('"+data[i].cartNo+"');\" class=\"btn_del\">";
		    	    		html += "<img src=\"/resources/worksout/images/common/btn_del_reply.png\" alt=\"삭제\" />";
		    	    		html += "</a>";
		    	    		html += "</div>";		    	    		
		    	    		
		    	    		$('#cartList_mobile').append(html);
		    	    		
		    	    		totalAmt = totalAmt + parseInt(data[i].ubiSlPrc);
		            }
		            cartMobileCount = data.length;
		            $('#cartCntMobile').html("CART (" + data.length + ")");
		            $('#totalCartAmtMobile').html(comma(totalAmt));		            
	        	}catch(e){
	        		//alert(e);
	        	}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};

    //카트 정보 가져오기
    var cartWebCount = 0;
	getCartDataWeb = function() {
		$.ajax({
	        url : "<c:url value='/front/cartListAjax'/>",
	        type: "post",
	        data : "",
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = jQuery.parseJSON(responseData);
		            cartData = data;
		            var totalAmt = 0;
		            for(var i=0;i<data.length;i++){
		            	var html = "<div class=\"silde_item clfix\" id=\"cart_"+data[i].cartNo+"\">";
		    	    		html += "<a href=/front/onlineShop/goodsDetail?ubiGdsNo="+data[i].ubiGdsNo+" class=\"p_img\">";
		    	    		html += "<img src=\"${uploadImage}"+data[i].mainImg2+"\" width=\"70px\" height=\"72px\" />";
		    	    		html += "</a>";
		    	    		html += "<div class=\"p_info\">";
		    	    		html += "<div class=\"p_name\">"+data[i].ubiGdsNm+"</div>";
		    	    		html += "<div class=\"p_size\">SIZE "+data[i].ubiGdsSize+"</div>";
		    	    		html += "<div class=\"ico_price\">"+comma(data[i].ubiSlPrc)+"</div>";
		    	    		html += "</div>";
		    	    		html += "<a href=\"javascript:deleteCartGoodsHeader('"+data[i].cartNo+"');\" class=\"btn_del\">";
		    	    		html += "<img src=\"/resources/worksout/images/common/btn_del_reply.png\" alt=\"삭제\" />";
		    	    		html += "</a>";
		    	    		html += "</div>";
		    	    		$('#cartListWeb').append(html);
		    	    		totalAmt = totalAmt + parseInt(data[i].ubiSlPrc);
		            }
		            cartWebCount = data.length;
		            $('#cartCntWeb').html("CART (" + data.length + ")");
		            $('#totalCartAmtWeb').html(comma(totalAmt));

		            refreshScroll();
	        	}catch(e){
	        		//console.log(e);
	        	}
	        },
	        error:function(request,status,error){
	            //console.log("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};

	deleteCartGoodsHeader = function(cartNo){
		$.ajax({
	        url : "<c:url value='/front/order/deleteGdsCart'/>",
	        type: "post",
	        data : {'cartNo' :  cartNo},
	        async: true,
	       // dataType: "json",
	       // contentType: "application/json",
	        success : function(responseData){
	            var data = JSON.parse(responseData);
	            if(data == "1"){  //저장 성공
	            	$('#cartCntWeb').html("CART (" + parseInt(cartWebCount-1) + ")");

				    $("div#cart_"+cartNo).fadeOut( "slow", function() {
					    $("div#cart_"+cartNo).empty();
					    cartWebCount = cartWebCount-1;
					    setTotalAmtHeader();				    	
				    });


	            }
	        },
	        error:function(request,status,error){
// 	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};

	popUpRadio = function(radioNo){
		var popUrl = "/front/popup/carharttRadioPopup?radioNo="+radioNo;
		var popOption = "width=302, height=545, resizable=no, scrollbars=no, status=no";

		window.open(popUrl,"radioPopup",popOption);
	};
	
	var certKey = "";
	var memberEmail = "";
	idChecking = function() {
    	var nm = $("input#nm01").val();
    	var cpNo = $("input#phone01").val() + "-" + $("input#phone02").val()+ "-" + $("input#phone03").val();

	   	if(nm==null || nm==""){
    		alert("이름을 입력하세요.");
    		return;
    	}
    	if(cpNo==null || cpNo==""){
    		alert("휴대폰 번호를 입력하세요.");
    		return;
    	}

		$.ajax({
	        url : "<c:url value='/front/idChecking'/>",
	        type: "post",
	        data : "nm="+nm+"&cpNo="+cpNo,
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = responseData;
		            var result = data.split(",")[0];
		            certKey = data.split(",")[1];
		            memberEmail = data.split(",")[2];
	                if(result=="0"){  //
	                	alert("고객님의 휴대폰으로 인증키가 발송 되었습니다.");
	                }else if(result=="1"){ //존재하지 않는 정보
	                	alert("등록된 정보가 없습니다.");
	                }
	        	}catch(e){
	        		//alert(e);
	        	}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};	
	
	idCheckingNext = function() {

		if(certKey !=""){
			
			if($("input#certNumber01").val() == certKey){
				$(".find_info_form_input").fadeOut( "slow", function() {
					$(".find_info_form_result").fadeIn( "slow", function() {
						$(".find_result_txt").html("ID : " + memberEmail);
					});
				});
			}else{
				alert("인증번호가 올바르지 않습니다.");
			}
			
		}else{
			alert("필요 정보를 입력하세요.");
		}
	};		

	var changeEmail = "";
	passChecking = function() {
    	var nm = $("input#nm02").val();
    	var email = $("input#email01").val();
    	var cpNo = $("input#phone04").val() + "-" + $("input#phone05").val()+ "-" + $("input#phone06").val();

    	changeEmail = email;
	   	if(nm==null || nm==""){
    		alert("이름을 입력하세요.");
    		return;
    	}
    	if(cpNo==null || cpNo==""){
    		alert("휴대폰 번호를 입력하세요.");
    		return;
    	}
    	if(email==null || email==""){
    		alert("이메일을 입력하세요.");
    		return;
    	}    	

		$.ajax({
	        url : "<c:url value='/front/passChecking'/>",
	        type: "post",
	        data : "nm="+nm+"&cpNo="+cpNo+"&email="+email,
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = responseData;
		            var result = data.split(",")[0];
		            certKey = data.split(",")[1];
	                if(result=="0"){  //
	                	alert("고객님의 휴대폰으로 인증키가 발송 되었습니다.");
	                }else if(result=="1"){ //존재하지 않는 정보
	                	alert("등록된 정보가 없습니다.");
	                }
	        	}catch(e){
	        		//alert(e);
	        	}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};	
	
	passCheckingNext = function() {
		if(certKey != ""){
			if($("input#certNumber02").val() == certKey){
				$(".find_info_form_input").fadeOut( "slow", function() {
					$(".find_info_form_new").fadeIn( "slow", function() {
						
					});
				});
			}else{
				alert("인증번호가 올바르지 않습니다.");
			}
			
		}else{
			alert("필요 정보를 입력하세요.");
		}
	};	
	
	changePass = function() {
    	var pass01 = $("input#pass01").val();
    	var pass02 = $("input#pass02").val();

	   	if(pass01!=pass02){
    		alert("비밀번호를 정확히 입력해주세요");
    		return;
    	}
	   	
	   	if(pass01.length < 6){
    		alert("비밀번호는 여섯자리 이상으로만 설정할 수 있습니다.");
    		return;	   		
	   	}

		$.ajax({
	        url : "<c:url value='/front/changePass'/>",
	        type: "post",
	        data : "pass="+pass01+"&email="+changeEmail,
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = responseData;
	                if(data=="0"){  //
	                	alert("비밀번호가 변경되었습니다. 다시 로그인 해주시기 바랍니다.");
	                	$('#lo-ginBtn').trigger('click');
	                }else if(data=="1"){ //존재하지 않는 정보
	                	alert("비밀번호 변경을 실패하였습니다.");
	                }
	        	}catch(e){
	        		//alert(e);
	        	}
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};		
	
	
    setTotalAmtHeader = function(){
    	var totalAmt = 0; 
    	$('.util_menu .cart_slide_container .silde_item .p_info .ico_price, .util_menu02 .cart_slide_container .silde_item .p_info .ico_price').each(function(index) {
	    	totalAmt = parseInt(totalAmt) + parseInt($(this).html().replace(',',''));
	    });
   		<c:if test="${!isMobile}">
    		$("#totalCartAmtWeb").html(comma(totalAmt));
    	</c:if>
    	<c:if test="${isMobile}">
    		$("#totalCartAmtMobile").html(comma(totalAmt));
    	</c:if>	
    };	
    
    
	//로그인시 비회원 장바구니 회원 장바구니로 이동
	loginCartImport = function() {
		for(var i=0;i<cartData.length;i++){
			deleteCartGoodsHeader(cartData[i].cartNo);
			
			var formdata = {};
			formdata = "ubiGdsNo=" + cartData[i].ubiGdsNo + "&ubiGdsSize=" + cartData[i].ubiGdsSize;
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
							</c:if>
							<c:if test="${isMobile}">
								$("div#cartList_mobile").html("");
								getCartData();
							</c:if>
						}else if(resultCode == "1"){
							
						}
		        	}catch(e){
		        		console.log(e);
		        	}
		        },
		        error:function(request,status,error){
		        	console.log("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
		        }
		    });			
			
		}
	};    
	
	
    //로그인
	loginAction = function() {
		loadingBarShow();
    	
    	var email = $("input#email").val();
    	var pwd = $("input#pwd").val();

	   	if(email==null || email==""){
    		alert("아이디를 입력하세요.");
    		$("input#email").focus();
    		return;
    	}
    	if(pwd==null || pwd==""){
    		alert("비밀번호를 입력하세요.");
    		$("input#pwd").focus();
    		return;
    	}

		$.ajax({
	        url : "<c:url value='/front/login'/>",
	        type: "post",
	        data : "email="+email+"&pwd="+pwd,
	        async: true,
	        success : function(responseData){
	        	try{
		            var data = jQuery.parseJSON(responseData);
	                if(data=="0"){  //로그인 성공
	                	loginCartImport();
	                	setTimeout("reloadPage();",300);
	                }else if(data=="1"){ //존재하지 않는 정보
	                	loadingBarHide();
	                	alert("가입한 email과 비밀번호를 다시한번 확인해주세요.");
	                	return;
	                }else if(data=="2"){ //탈퇴
	                	loadingBarHide();
	                	alert("탈퇴처리 된 계정입니다.");
	                	return;
	                }
	        	}catch(e){
// 	        		alert(e);
	        	}
	        },
	        error:function(request,status,error){
// 	            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
	        }
	    });
	};	
	
	reloadPage = function() {
    	if("${reqURL}" !="" && "${reqURL}" != null){
    		document.location.href="${reqURL}";
		}else{
			document.location.reload();
		}
	};	
		
});

	//장바구니 상품 로딩시간 길기 때문에 타이머로 아닌척함
	<c:if test="${!isMobile}">
		setTimeout("getCartDataWeb();",300);
	</c:if>
	<c:if test="${isMobile}">
		setTimeout("getCartData();",300);
	</c:if>	
	

	//탑배너 공지사항 노출여부
	var chkDispCookie = $.cookie('topBnnrDispYn');
	if(chkDispCookie == 'N'){
		$("div#topBnnr").hide();
	}
	
	$(function(){
	    // modify 151209
	    // 스크롤 이동시에도 잘 보일 수 있게
	    var touchMode = 'ontouchmove' in window,    // device인지 아닌지 확인
	        $topBanner = $('#topBnnr'),             // banner element
	        $body = $('body'),                      // body element
	        headBannerPos = $topBanner.height() + (parseInt($topBanner.css('paddingTop')) * 2), // banner height
	        SCROLL_EVENT = (touchMode)?'touchmove':'scroll';                                    // event

	    $(window).bind(SCROLL_EVENT, function(e){
	        ($topBanner.css('display') != 'none') && checkScroll();
	    });

	    function checkScroll(){
	        if ($(window).scrollTop() >= headBannerPos) {
	            headerBannerFixed( true );
	        } else {
	            headerBannerFixed( false );
	        }
	    }

	    function headerBannerFixed( ch ){
	        if( ch ){
	            $topBanner.css({
	                'position':'fixed',
	                'top':0,
	                'width':'100%',
	                'z-index':'16'
	            });
	            $body.css('margin-top', headBannerPos+'px');
	        }else{
	            $topBanner.css({
	                'position':'relative',
	                'top':''
	            });
	            $body.css('margin-top', '');
	        }
	    }

	    setTimeout(function(){
	        checkScroll();
	    }, 250);
	});	
</script>
<!-- 임시 스크립트 개발시 삭제 바람. -->
<form:form id="schForm" name="schForm" method="POST" modelAttribute="searchForm">
	<form:hidden path="searchText" id="searchText" />
</form:form>
<c:if test="${fn:length(newsList) != 0}">
	<div class="top_notice_banner ui_notice_banner_ctr" id="topBnnr">
		<script>
		$(function(){
			var	totalCnt = "${fn:length(newsList)}";
			var curIdx = 1;

			setInterval("slideNews();",4000);

			//파일다운로드
		    slideNews= function(){
				if(curIdx == parseInt(totalCnt)){
					$("div#news_"+curIdx).fadeOut( "slow", function() {
						curIdx = 1;
						$("div#news_"+curIdx).fadeIn( "slow", function() {

						});
					});
				}else{
					$("div#news_"+curIdx).fadeOut( "slow", function() {
						$("div#news_"+parseInt(curIdx+1)).fadeIn( "slow", function() {
							curIdx++;
						});
					});
				}
		    };
		});
		</script>
		<c:forEach items="${newsList }" var="news" varStatus="index">
			<c:if test="${index.count == 1}">
				<div id="news_${index.count }" class="txt" onclick="javascript:location.href='/front/news/newsDetail?txtNo=${news.txtNo }';" style="cursor:pointer">${news.title }</div>
			</c:if>
			<c:if test="${index.count > 1}">
				<div id="news_${index.count }" class="txt" onclick="javascript:location.href='/front/news/newsDetail?txtNo=${news.txtNo }';" style="display:none;cursor:pointer;">${news.title }</div>
			</c:if>
		</c:forEach>
		<a href="#" class="btn" onclick="$.cookie('topBnnrDispYn', 'N', { expires: 1, path: '/'});">
			<img src="/resources/worksout/images/common/btn_top_notice_close.png" alt="닫기" />
		</a>
	</div>
</c:if>
<div class="header_content">
	<a href="<c:url value='/front/main'/>" class="txt_logo_${siteDir }">
		<img src="/resources/worksout/images/logo/${siteDir }_web.png" alt="${siteDesc }"/>
	</a>
	<div class="menu_area clfix">
		<div class="util_menu_area">
			<ul class="util_menu clfix">
				<li class="first_child">
					<a href="#" class="util_item" onmouseup="$('input#srcTxt').focus();">SEARCH</a>
					<div class="util_add">
						<div class="add_content">
							<span class="input_txt input_btn_search">
								<input type="text" id="srcTxt" name="srcTxt" placeholder="SEARCH" />
							</span>
						</div>
					</div>
				</li>
				<li>
					<a href="#" class="util_item">HELP</a>
					<div class="util_add">
						<div class="add_content">
							<dl class="util_help_info clfix">
								<dt>
									<span class="bu">PHONE</span>
								</dt>
								<dd>02-541-0854</dd>
								<dt>
									<span class="bu">MON~FRI</span>
								</dt>
								<dd>9:30 ~ 18:30</dd>
								<dt>
									<span class="bu">BREAK</span>
								</dt>
								<dd>12:30 ~ 13:30</dd>
							</dl>
							<div class="btn_area">
								<a href="<c:url value="/front/contactUs" />" class="btn_ico_arrow color01">MORE INFORMATION</a>
							</div>
						</div>
					</div>
				</li>
			<c:choose>
			<c:when test="${!isMobile}">
				<c:choose>
					<c:when test="${!isLogined}">
					<!-- 로그인 전 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					<li>
						<a href="#" class="util_item" id="lo-ginBtn" onmouseup="$('input#email').focus();">LOG-IN</a>
						<div class="util_add">
							<div class="add_content">
								<!-- 로그인 메뉴 영역 -->
								<div class="login_menu_area">
									<div class="login_menu">
										<span class="input_txt">
											<input type="text" name="email" id="email" placeholder="ID(email)" />
										</span>
										<span class="input_txt">
											<input type="password" name="pwd" id="pwd" placeholder="PASSWORD" />
										</span>
										<a href="javascript:loginAction();" id="loginBtn" data-btn="loginBtn" class="btn_black01">LOGIN</a>
										<ul>
											<li class="first_child">
												<a href="#">아이디찾기</a>
											</li>
											<li>
												<a href="#">비밀번호변경</a>
											</li>
											<li>
												<a href="<c:url value='/front/join/joinHome'/>">회원가입</a>
											</li>
										</ul>
									</div>
									<div class="btn_area">
										<a href="#" class="btn_ico_arrow color01">비회원주문확인</a>
									</div>
								</div>
								<!-- 로그인 메뉴 영역 -->
								<!-- 아이디 찾기 영역 -->
								<div class="find_id_area">
									<div class="find_info_menu">
										<div class="cont_tit">아이디 찾기</div>
										<!-- 아이디 찾기 - 입력 -->
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="nm01" id="nm01" placeholder="이름" />
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone01" placeholder="010" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone02" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone03" />
													</span>
												</div>
												<div class="layout layout_ctr02">
													<a href="javascript:idChecking();" class="btn_gray01">인증</a>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="certNumber01" id="certNumber01" placeholder="인증번호" />
											</span>
											<a href="javascript:idCheckingNext();" class="btn_black01">다음</a>
										</div>
										<!-- 아이디 찾기 - 입력 -->
										<!-- 아이디 찾기 - 결과 -->
										<div class="find_info_form_result" style="display:none">
											<div class="find_result_txt"></div>
											<a href="javascript:$('.util_item').trigger('click');" class="btn_black01">로그인</a>
										</div>
										<!-- 아이디 찾기 - 결과 -->
									</div>
								</div>
								<!-- 아이디 찾기 영역 -->
								<!-- 비밀번호 변경 영역 -->
								<div class="find_pwd_area">
									<div class="find_info_menu">
										<div class="cont_tit">비밀번호 변경</div>
										<!-- 비밀번호 변경 - 입력 -->
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="email01" id="email01" placeholder="아이디 (이메일)" />
											</span>
											<span class="input_txt">
												<input type="text" name="nm02" id="nm02" placeholder="이름" />
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone04" placeholder="010" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone05" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone06" />
													</span>
												</div>
												<div class="layout layout_ctr02">
													<a href="javascript:passChecking();" class="btn_gray01">인증</a>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="certNumber02" id="certNumber02" placeholder="인증번호" />
											</span>
											<a href="javascript:passCheckingNext();" class="btn_black01">다음</a>
										</div>
										<!-- 비밀번호 변경 - 입력 -->
										<!-- 비밀번호 변경 - 새비밀번호입력 -->
										<div class="find_info_form_new" style="display:none">
											<span class="input_txt">
												<input type="password" name="pass01" id="pass01" placeholder="새비밀번호" />
											</span>
											<span class="input_txt">
												<input type="password" name="pass02" id="pass02" placeholder="비밀번호확인" />
											</span>
											<div class="notice_txt">6~15자 이내의 영,숫자,특수문자 입력 가능</div>
											<div class="find_result_txt02">사용가능</div>
											<a href="javascript:changePass();" class="btn_black01">변경</a>
										</div>
										<!-- 비밀번호 변경 - 새비밀번호입력 -->
										<!-- 비밀번호 변경 - 결과 -->
										<div class="find_info_form_result" style="display:none">
											<div class="find_result_txt txt_left">비밀번호가 재설정되었습니다.
												<br> MYPAGE&gt; PROFILE&gt; 비밀번호 관리에서
												<br> 변경이 가능합니다.
												<br>
											</div>
											<a href="javascript:$('.util_item').trigger('click');" class="btn_black01">로그인</a>
										</div>
										<!-- 비밀번호 변경 - 결과 -->
									</div>
								</div>
								<!-- 비밀번호 변경 영역 -->
								<!-- 비회원 주문확인 영역 -->
								<div class="non_members_order_info_area">
									<div class="find_info_menu add_info_menu">
										<div class="cont_tit">비회원 주문확인</div>
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="nMemNm" id="nMemNm" placeholder="이름" value=""/>
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr03">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone01" placeholder="010" value=""/>
													</span>
												</div>
												<div class="layout layout_ctr03">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone02" value=""/>
													</span>
												</div>
												<div class="layout layout_ctr04">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone03" value=""/>
													</span>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="nMemOrderNo" id="nMemOrderNo" placeholder="주문번호" value=""/>
											</span>
											<a href="javascript:void(0);" class="btn_black01" id="btn_nMemInquiry" data-id="btn_nMemInquiry">조회</a>
										</div>
										<div class="add_info_txt">
											<div class="txt01">주문번호를 분실 시 아래로 문의주세요.</div>
											<dl class="util_help_info02 clfix">
												<dt>PHONE</dt>
												<dd>02-541-0854</dd>
												<dt>MON~FRI</dt>
												<dd>9:30 ~ 18:30</dd>
												<dt>BREAK</dt>
												<dd>12:30 ~ 13:30</dd>
											</dl>
										</div>
									</div>
								</div>
								<!-- 비회원 주문확인 영역 -->
							</div>
						</div>
					</li>
					<!-- 로그인 전 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					</c:when>
					<c:when test="${isLogined}">
					<!-- 로그인 후 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					<li>
						<a href="#" class="util_item">ACCOUNT</a>
						<div class="util_add">
							<div class="add_content">
								<dl class="util_help_info03 clfix">
									<dt>ID(email)</dt>
									<dd>${member.email}</dd>
									<dt>POINT</dt>
									<dd>${member.curPoint} P</dd>
								</dl>
								<div class="btn_area">
									<a href="<c:url value="/front/logout"/>" class="btn_ico_arrow color01 interval01">LOGOUT</a>
									<a href="<c:url value="/front/myPage/myPageHome"/>" class="btn_ico_arrow color01">MYPAGE</a>
								</div>
							</div>
						</div>
					</li>
					<!-- 로그인 후 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					</c:when>
				</c:choose>

				<li>
					<a href="<c:url value="/front/order/cartList"/>" class="util_item" id="cartCntWeb">CART (0)</a>
					<div class="util_add">
						<div class="add_content">
							<div class="cart_slide_area">
								<div style="" class="cart_slide_container nano">
									<div class="cart_slide nano-content" id="cartListWeb">

									</div>
								</div>
								<!-- <div class="cart_ctr">
									<a href="#" class="btn_cart_up"></a>
									<a href="#" class="btn_cart_down"></a>
								</div> -->
							</div>
							<div class="cart_total_price clfix">
								<div class="txt">TOTAL:</div>
								<div class="ico_price" id="totalCartAmtWeb">0</div>
							</div>
							<div class="btn_area">
								<a href="<c:url value="/front/order/cartList"/>" class="btn_black01">BUY NOW</a>
							</div>
						</div>
					</div>
				</li>
			</c:when>
			</c:choose>
		</ul>
	</div>
	<a href="javascript:void(0)" class="btn_all_menu">
		<span class="btn_arrow" style="display:none;">
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 5)" style="transform: matrix(1, 0, 0, 1, 0, 5);"></rect>
			</svg>
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 45)" style="transform: matrix(1, 0, 0, 1, 0, 45);"></rect>
			</svg>
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 85)" style="transform: matrix(1, 0, 0, 1, 0, 85);"></rect>
			</svg>
		</span>
	</a>
<c:if test="${'10002' == siteNo}">
	<a href="javascript:void(0)" class="btn_radio">
		<img src="/resources/carhartt/images/common/btn_radio.png" alt="RADIO" />
	</a>
</c:if>
<c:if test="${'10003' == siteNo}">
<!-- 	<a href="javascript:void(0)" class="btn_awareness"> -->
<!-- 		<img src="/resources/obey/images/common/btn_obey_awareness.png" alt="obey awareness" /> -->
<!-- 	</a> -->
</c:if>
 	<a href="#" class="btn_all_menu02">
		<span class="btn_arrow" style="display:none;">
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 5)" style="transform: matrix(1, 0, 0, 1, 0, 5);"></rect>
			</svg>
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 45)" style="transform: matrix(1, 0, 0, 1, 0, 45);"></rect>
			</svg>
			<svg x="0px" y="0px" width="20px" viewBox="0 0 100 100" style="position:absolute;left:0;top:0;fill:#000" enable-background="new 0 0 100 100">
				<rect width="100" height="12" x="0" y="0" class="gh-svg-rect gh-svg-rect-top" data-svg-origin="0 0" transform="matrix(1 0 0 1 0 85)" style="transform: matrix(1, 0, 0, 1, 0, 85);"></rect>
			</svg>
		</span>
		<!-- <span class="m_cart_count">${fn:length(cartList) }</span> -->
	</a>
</div>
</div>
<!-- 웹 버전 전체메뉴 -->



<div style="display:none" class="all_menu_wrap">
<%-- 	<p href="<c:url value='/front/main'/>" class="txt_logo">
		<img src="/resources/${siteDir }/images/logo/worksout_web.png" alt="WORKSOUT" />
	</p> --%>
	<ul class="all_menu_list01">
		<li>
			<a href="<c:url value='/front/onlineShop/feature'/>">ONLINE SHOP</a>
		</li>
		<li>
			<c:if test="${siteNo == '10002' }">
			<a href="<c:url value='/front/storeInfo/CaDg'/>">STORE INFO</a>
			</c:if>
			<c:if test="${siteNo != '10002' }">
			<a href="<c:url value='/front/storeInfo/Ab'/>">STORE INFO</a>
			</c:if>
		</li>
		<li>
			<a href="<c:url value='/front/news/newsList'/>">NEWS</a>
		</li>
		<li>
			<a href="<c:url value='/front/lookbook/list'/>">LOOKBOOK</a>
		</li>
		<li>
			<a href="<c:url value='/front/about'/>">ABOUT</a>
		</li>
		<li>
			<a href="<c:url value='/front/contactUs' />">CUSTOMER CARE</a>
		</li>
	</ul>
<!-- 	<a href="javascript:void(0);" class="btn_all_menu close">
		<img src="/resources/worksout/images/common/btn_close_all_menu.png" alt="전체 메뉴 닫기"
		/>
	</a> -->
</div>
<!-- 웹 버전 전체메뉴 -->
<!-- 모바일, 태블릿 버전 전체메뉴 -->
<div style="display:none" class="all_menu_wrap02">
<div class="scroll_wrap">
	<div class="util_menu_area02">
		<ul class="util_menu02 clfix">
			<li class="first_child">
				<a href="javascript:void(0);" class="util_item">SEARCH</a>
				<div class="util_add">
					<div class="add_content">
						<span class="input_txt input_btn_search">
							<input type="text" name="srcTxt" id="srcTxtM" placeholder="SEARCH" />
						</span>
					</div>
				</div>
			</li>
			<li>
				<a href="javascript:void(0);" class="util_item">HELP</a>
				<div class="util_add">
					<div class="add_content">
						<dl class="util_help_info clfix">
							<dt>PHONE</dt>
							<dd>02-541-0854</dd>
							<dt>MON~FRI</dt>
							<dd>9:30 ~ 18:30</dd>
							<dt>BREAK</dt>
							<dd>12:30 ~ 13:30</dd>
						</dl>
						<div class="btn_area">
							<a href="<c:url value="/front/contactUs" />" class="btn_ico_arrow color01">MORE INFORMATION</a>
						</div>
					</div>
				</div>
			</li>
			<c:choose>
				<c:when test="${!isLogined}">
					<!-- 로그인 전 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					<li>
						<a href="javascript:void(0);" id="lo-ginBtn" class="util_item">LOG-IN</a>
						<div class="util_add">
							<div class="add_content">
								<!-- 로그인 메뉴 영역 -->
								<div class="login_menu_area">
									<div class="login_menu">
										<span class="input_txt">
											<input type="text" name="email" id="email" placeholder="ID(email)"/>
										</span>
										<span class="input_txt">
											<input type="password" name="pwd" id="pwd" placeholder="PASSWORD"/>
										</span>
										<a href="javascript:loginAction()" id="loginBtn" data-btn="loginBtn" class="btn_black01">LOGIN</a>

										<ul>
											<li class="first_child">
												<a href="javascript:void(0);">아이디찾기</a>
											</li>
											<li>
												<a href="javascript:void(0);">비밀번호변경</a>
											</li>
											<li>
												<a href="<c:url value='/front/join/joinHome'/>">회원가입</a>
											</li>
										</ul>
									</div>
									<div class="btn_area">
										<a href="javascript:void(0);" class="btn_ico_arrow color01">비회원주문확인</a>
									</div>
								</div>
								<!-- 로그인 메뉴 영역 -->
								<!-- 아이디 찾기 영역 -->
								<div class="find_id_area">
									<div class="find_info_menu">
										<div class="cont_tit">아이디 찾기</div>
										<!-- 아이디 찾기 - 입력 -->
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="nm01" id="nm01" placeholder="이름" />
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone01" placeholder="010" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone02" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone03" />
													</span>
												</div>
												<div class="layout layout_ctr02">
													<a href="javascript:idChecking();" class="btn_gray01">인증</a>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="certNumber01" id="certNumber01" placeholder="인증번호" />
											</span>
											<a href="javascript:idCheckingNext();" class="btn_black01">다음</a>
										</div>
										<!-- 아이디 찾기 - 입력 -->
										<!-- 아이디 찾기 - 결과 -->
										<div class="find_info_form_result" style="display:none;">
											<div class="find_result_txt"></div>
											<a href="javascript:$('#lo-ginBtn').trigger('click');" class="btn_black01">로그인</a>
										</div>
										<!-- 아이디 찾기 - 결과 -->
									</div>
								</div>
								<!-- 아이디 찾기 영역 -->
								<!-- 비밀번호 변경 영역 -->
								<div class="find_pwd_area">
									<div class="find_info_menu">
										<div class="cont_tit">비밀번호 변경</div>
										<!-- 비밀번호 변경 - 입력 -->
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="email01" id="email01" placeholder="아이디 (이메일)" />
											</span>
											<span class="input_txt">
												<input type="text" name="nm02" id="nm02" placeholder="이름" />
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone04" placeholder="010" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone05" />
													</span>
												</div>
												<div class="layout layout_ctr01">
													<span class="input_txt">
														<input type="text" name="phone" id="phone06" />
													</span>
												</div>
												<div class="layout layout_ctr02">
													<a href="javascript:passChecking();" class="btn_gray01">인증</a>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="certNumber02" id="certNumber02" placeholder="인증번호" />
											</span>
											<a href="javascript:passCheckingNext();" class="btn_black01">다음</a>
										</div>
										<!-- 비밀번호 변경 - 입력 -->
										<!-- 비밀번호 변경 - 새비밀번호입력 -->
										<div class="find_info_form_new" style="display:none">
											<span class="input_txt">
												<input type="password" name="pass01" id="pass01" placeholder="새비밀번호" />
											</span>
											<span class="input_txt">
												<input type="password" name="pass02" id="pass02" placeholder="비밀번호확인" />
											</span>
											<div class="notice_txt">6~15자 이내의 영,숫자,특수문자 입력 가능</div>
											<div class="find_result_txt02">사용가능</div>
											<a href="javascript:changePass();" class="btn_black01">변경</a>
										</div>
										<!-- 비밀번호 변경 - 새비밀번호입력 -->
										<!-- 비밀번호 변경 - 결과 -->
										<div class="find_info_form_result" style="display:none">
											<div class="find_result_txt txt_left">비밀번호가 재설정되었습니다.
												<br> MYPAGE&gt; PROFILE&gt; 비밀번호 관리에서
												<br> 변경이 가능합니다.
												<br>
											</div>
											<a href="javascript:$('#lo-ginBtn').trigger('click');" class="btn_black01">로그인</a>
										</div>
										<!-- 비밀번호 변경 - 결과 -->
									</div>
								</div>
								<!-- 비밀번호 변경 영역 -->
								<!-- 비회원 주문확인 영역 -->
								<div class="non_members_order_info_area">
									<div class="find_info_menu add_info_menu">
										<div class="cont_tit">비회원 주문확인</div>
										<div class="find_info_form_input">
											<span class="input_txt">
												<input type="text" name="nMemNm" id="nMemNm" placeholder="이름" value=""/>
											</span>
											<div class="input_layout01 clfix">
												<div class="layout layout_ctr03">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone01" placeholder="010" value=""/>
													</span>
												</div>
												<div class="layout layout_ctr03">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone02" value=""/>
													</span>
												</div>
												<div class="layout layout_ctr04">
													<span class="input_txt">
														<input type="text" name="nMemPhone" id="nMemPhone03" value=""/>
													</span>
												</div>
											</div>
											<span class="input_txt">
												<input type="text" name="nMemOrderNo" id="nMemOrderNo" placeholder="주문번호" value=""/>
											</span>
											<a href="javascript:void(0);" class="btn_black01" id="btn_nMemInquiry" data-id="btn_nMemInquiry">조회</a>
										</div>
										<div class="add_info_txt">
											<div class="txt01">주문번호를 분실 시 아래로 문의주세요.</div>
											<dl class="util_help_info02 clfix">
												<dt>PHONE</dt>
												<dd>02-541-0854</dd>
												<dt>MON~FRI</dt>
												<dd>9:30 ~ 18:30</dd>
												<dt>BREAK</dt>
												<dd>12:30 ~ 13:30</dd>
											</dl>
										</div>
									</div>
								</div>
								<!-- 비회원 주문확인 영역 -->
							</div>
						</div>
					</li>
					<!-- 로그인 전 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
				</c:when>
				<c:when test="${isLogined}">
					<!-- 로그인 후 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
					<li>
						<a href="javascript:void(0);" class="util_item">ACCOUNT</a>
						<div class="util_add">
							<div class="add_content">
								<dl class="util_help_info03 clfix">
									<dt>ID(email)</dt>
									<dd>${member.email}</dd>
									<dt>POINT</dt>
									<dd>${member.curPoint} P</dd>
								</dl>
								<div class="btn_area">
									<a href="<c:url value="/front/logout"/>" class="btn_ico_arrow color01 interval01">LOGOUT</a>
									<a href="<c:url value="/front/myPage/myPageHome"/>" class="btn_ico_arrow color01">MYPAGE</a>
								</div>
							</div>
						</div>
					</li>
					<!-- 로그인 후 노출 - 아래 내용들은 상황에 맞게 개발 처리 해주세요. -->
				</c:when>
			</c:choose>
			<li>
				<a href="<c:url value="/front/order/cartList"/>" class="util_item" id="cartCntMobile">CART (0)</a>
				<div class="util_add">
					<div class="add_content">
						<div class="cart_slide_area">
							<div class="cart_slide_container">
								<div class="cart_slide" id="cartList_mobile">
								</div>
							</div>
						<div class="cart_ctr">
							<a href="javascript:void(0);" class="btn_cart_up"></a>
							<a href="javascript:void(0);" class="btn_cart_down"></a>
						</div>
					</div>
					<div class="cart_total_price clfix">
						<div class="txt">TOTAL:</div>
						<div class="ico_price" id="totalCartAmtMobile">0</div>
					</div>
					<div class="btn_area">
						<a href="<c:url value="/front/order/cartList"/>" class="btn_black01">BUY NOW</a>
					</div>
				</div>
	</div>
	</li>
	</ul>
</div>
<ul class="all_menu_list02">
	<li>
		<a href="<c:url value='/front/onlineShop/feature'/> ">ONLINE SHOP</a>
		<div class="sub_list">
			<c:if test="${preDispYn eq 'Y'}">
				<a href="<c:url value='/front/onlineShop/feature?oneDepth=${preSeason}&nowSeq=${preSeq}'/>" id="${preSeason}Mob" data-season="${preSeason}">${preSeasonName }</a>
			</c:if>
			<c:if test="${currentDispYn eq 'Y'}">
				<a href="<c:url value='/front/onlineShop/feature?oneDepth=${currentSeason}&nowSeq=${currentSeq}'/>" id="${currentSeason}Mob" data-season="${currentSeason}">${currentSeasonName }</a>
			</c:if>
			<a href="/front/onlineShop/goodsList?oneDepth=OUTLET&nowSeq=${outletSeq}" id="noSeasonMob" data-season="noSeason">SALE</a>
<%-- 			<a href="<c:url value='/front/onlineShop/feature'/>" id="season">${currentSeasonName }</a> --%>
<!-- 			<a href="/front/onlineShop/goodsList?oneDepth=OUTLET">OUTLET</a> -->
<%-- 			<a href="<c:url value="/front/onlineShop/collaboration" />">COLLABORATION</a> --%>
			<c:if test="${siteNo == '10001' }">
					<a href="${contextPath }/front/onlineShop/goodsList?brand=CD,GX,HS,SJ,SZ,GB,QS" id="BRAND_CD">CORNER DELI</a>
			</c:if>
			<c:if test="${siteNo != '10001' }">
					<a href="${contextPath }/front/onlineShop/collaboration" id="collaboration">COLLABORATION</a>
			</c:if>
		</div>
	</li>
	<li>
		<c:if test="${siteNo == '10002' }">
		<a href="<c:url value='/front/storeInfo/CaDg'/>">STORE INFO</a>
		</c:if>
		<c:if test="${siteNo != '10002' }">
		<a href="<c:url value='/front/storeInfo/Ab'/>">STORE INFO</a>
		</c:if>	
	</li>
	
	<li>
		<a href="<c:url value="/front/news/newsList" />">NEWS</a>
	</li>
	<li>
		<a href="<c:url value="/front/lookbook/list" />">LOOKBOOK</a>
	</li>
	<li>
		<a href="<c:url value='/front/about'/>">ABOUT</a>
	</li>
	<li>
		<a href="<c:url value='/front/contactUs' />">CUSTOMER CARE</a>
	</li>
</ul>
</div>
</div>
<!-- 모바일, 태블릿 버전 전체메뉴 -->


<!-- 칼하트 뮤직 -->
<c:if test="${'10002' == siteNo}">
	<!-- 웹 버전 뮤직 -->
	<div style="display:none;" class="music_area">
		<!-- 비주얼 영역 -->
		<div class="music_wrap">
			<div class="music_logo">
				<img src="/html/carhartt/images/common/txt_carhartt_radio.png" alt="CARHARTT WORK IN PROGRESS | RADIO" />
			</div>
			<div class="music_container swiper-container">
				<div style="width:7200px" class="music_list clfix swiper-wrapper">
				<c:choose>
					<c:when test="${not empty carharttRadioList}">
						<c:forEach items="${carharttRadioList}" var="radio" varStatus="listCount">
							<div class="music_item swiper-slide">
								<div class="txt_info">
									<a href="javascript:popUpRadio('${radio.radioNo }');" class="btn_turn_in">TURN IN</a>
								</div>
								<c:choose>
									<c:when test="${!isMobile}">
										<img src="${radio.frontBgImgUrl }" alt="라디오 배경이미지" class="img_visual" />
									</c:when>
									<c:otherwise>
										<img src="${uploadImage }${radio.cvImgUrl }" alt="라디오 배경이미지" class="img_visual" />
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="music_item">
							<div class="txt_info">등록된 음악이 없습니다.</div>
						</div>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			<a href="#" class="btn_music_prev">
				<span class="hide_txt">이전 컨텐츠</span>
			</a>
			<a href="#" class="btn_music_next">
				<span class="hide_txt">다음 컨텐츠</span>
			</a>
			<div class="radio_app_area clfix">
				<div class="type01">
					<div class="txt01">CARHARTT</div>
					<div class="txt02">RADIO APP</div>
				</div>
				<a href="https://play.google.com/store/apps/details?id=com.warptec.carhartt" class="type02">
					<div class="txt01">GOOGLE</div>
					<div class="txt02">PLAY</div>
				</a>
				<a href="https://itunes.apple.com/kr/app/carhartt-wip-radio/id412853240?mt=8" class="type03">
					<div class="txt01">APP</div>
					<div class="txt02">STORE</div>
				</a>
			</div>
			<a href="#" class="btn_music_close">
				<img src="/html/carhartt/images/common/btn_close_radio.png" alt="닫기" />
			</a>
		</div>


		<!-- 썸네일 리스트 영역 -->
		<div class="music_thumb_wrap">
			<div class="music_thumb_container swiper-container">
				<div style="width:1700px" class="music_thumb_list clfix swiper-wrapper">
				<c:choose>
					<c:when test="${not empty carharttRadioList}">
						<c:forEach items="${carharttRadioList}" var="radio" varStatus="listCount">
							<a href="#" class="music_thumb_item swiper-slide">
								<img src="${uploadImage }${radio.banImgUrl }" alt="배너이미지" class="img_thumb" />
							</a>
						</c:forEach>
					</c:when>
				</c:choose>
				</div>
			</div>
			<span class="line_red">
				<img src="/html/carhartt/images/common/line_red.png" alt="" />
			</span>
		</div>
	</div>
	<!-- 웹 버전 뮤직 -->
</c:if>

<!-- obey aw -->
<c:if test="${'10003' == siteNo}">
	<!-- 모바일, 태블릿 버전 전체메뉴 -->
	<!-- s: 20150908 obey awareness 추가 -->

	<div class="awareness_area"  style="display: none;">
		<div class="awareness_wrap">
			<div class="awareness_logo">
				<img src="/html/obey/images/common/txt_obey_radio.png" alt="OBEY AWARENESS" />
			</div>
			<div id="mySwipe" class="awareness_container">
				<div class="awareness_list clfix">
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${not empty awnes.get(0).awnesCont }"> --%>
<%-- 						<c:forEach var="awnesCont" items="${awnes.get(0).awnesCont}" varStatus="stat"> --%>
<!-- 							<div class="awareness_item"> -->
<%-- 							<input type="hidden" id="contCls" value="${awnesCont.contCls}"> --%>
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${awnesCont.contCls eq 'CM00501'}"><!-- 이미지 --> --%>
<!-- 									<a href="#"> -->
<%-- 										<img src="<spring:eval expression="@file['upload.image']"/>${awnesCont.imgUrl}" alt="" data-imgUrl="${awnesCont.imgUrl}"/> --%>
<!-- 										<span class="hide_txt">제목 뿌리기1</span> -->
<!-- 										<span class="hide_txt">설명 뿌리기1</span> -->
<!-- 									</a> -->
<%-- 								</c:when> --%>
<%-- 								<c:when test="${awnesCont.contCls eq 'CM00502'}"><!-- 동영상 --> --%>
<%-- 									<iframe width="100%" height="540" src="${awnesCont.contUrl}" frameborder="0" allowfullscreen ></iframe> --%>
<%-- 								</c:when> --%>
<%-- 								<c:when test="${awnesCont.contCls eq 'CM00503'}"><!-- 상품 --> --%>
<!-- 									<a href="#"> -->
<%-- 										<img src="<spring:eval expression="@file['upload.image']"/>${awnesCont.imgUrl}" alt="" data-contUrl="${awnesCont.contUrl}"/> --%>
<!-- 										<span class="hide_txt">제목 뿌리기1</span> -->
<!-- 										<span class="hide_txt">설명 뿌리기1</span> -->
<!-- 									</a> -->
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<!-- 							</div> -->
<%-- 						</c:forEach> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>

				</div>
			</div>
			<div class="awareness_util clfix">
				<span class="util01">
					<span>3/20</span>
				</span>
				<span class="util02">
					<select id="option" name="option" style="background-color: black;" data-view="CM00501">
	<!-- 						<option>SELECT DEVICE</option> -->
						<option value="2560">PC(2560*1440)</option>
						<option value="1920">MOBILE(1920*1080)</option>
						<option value="2048">TABLET(2048*1536)</option>
					</select>
					<a href="#" class="btn_download" onclick="javascript:fileExport(this);" data-file="C:\Users\Administrator\Desktop\Stunning-sunset_2560x1440.jpg"  data-view="CM00501">
						<span>DOWNLOAD</span>
					</a>
					<a href="${awnesCont.contUrl}" class="btn_download"  data-view="CM00503">
						<span>BUY NOW</span>
					</a>
				</span>
			</div>
			<!-- 위 슬라이드되면 아래 내용 바뀌기 -->
			<!-- 위 슬라이드에서 hide_txt 에 뿌려지는 내용들을 아래에 넣기 -->
			<!-- 룩북과 동일함 -->
			<dl class="awareness_txt_info">
<%-- 				<dt>${awnes.get(0).title}</dt> --%>
<%-- 				<dd>${awnes.get(0).dtlTxt}</dd> --%>
			</dl>
			<a href="#" class="btn_awareness_prev">
				<span class="hide_txt">이전으로</span>
			</a>
			<a href="#" class="btn_awareness_next">
				<span class="hide_txt">다음으로</span>
			</a>

		</div>
		<a href="#" class="btn_close_obey_awareness">
			<img src="/html/carhartt/images/common/btn_close_radio.png" alt="닫기" />
		</a>
	</div>
</c:if>



<script>
var conIndex = 0;
setcont();

var elem = document.getElementById('mySwipe');
window.mySwipe = Swipe(elem,
{
	// startSlide: 4, 
	// auto: 3000, 
	// continuous: true, 
	// disableScroll: true, 
	// stopPropagation: true, 
// 	callback: function(index, element) { 
// 		alert(index); 
// 	}, 

// 	transitionEnd: function(index, element) { 
// 		conIndex = index; 
// 		setcont(); 
// 	} 

});


function setcont(){

	var total = $("div[class='awareness_item']").length;
	$("span[class='util01']").children().text((conIndex+1)+"/"+total);
	var contCls = $("div[class='awareness_item']").eq(conIndex).find("#contCls").val();
	
	if(contCls == "CM00501"){//이미지
		$("a[class='btn_download']").attr("data-file",$("div[class='awareness_item']").eq(conIndex).find("img").attr("data-imgUrl"));
		$("[data-view]").hide();
		$("[data-view='CM00501']").show();
	}else if(contCls == "CM00502"){//동영상
		$("[data-view]").hide();
		$("[data-view='CM00502']").show();
	}else if(contCls == "CM00503"){//상품
		$("[data-view='CM00503']").attr("href",$("div[class='awareness_item']").eq(conIndex).find("img").attr("data-contUrl"));
		$("[data-view]").hide();
		$("[data-view='CM00503']").show();
	}
	
}
</script>

<!-- e: 20150908 obey awareness 추가 -->
