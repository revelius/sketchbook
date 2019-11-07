<%--
 * =============================================================================
 * 파일명 : /front/layout/footer.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-05-19
 *
 * 파일 내용 : layout > footer
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!-- <script type="text/javascript" src="/resources/common/frontUtils.js"></script> -->
<script type="text/javascript">
	$(function(){
		$("a[href=#]").attr("href", "javascript:void(0);");
		
		$(".btn_subscribe").on("click",function(){

			var isChecked = false;
			
			if($("#YN").val() == "Y"){
				isChecked = true;
			}else{
				$("#YN").val("N");
			}
			
			if(isChecked){
				$.ajax({
			        url : "<c:url value='/front/footerAjax'/>",
			        data : $('form#event').serialize(),
			        type: "POST",
			        async: false,
			        success : function(res){
			        	try{
			        		if(res > 0){
			        			alert("E-mail 등록이 완료되었습니다.");
				        		$("#valid").css("display","block");
				        		$("#valid span").css("color","#06BBB4");
								$("#valid span").text("THANK YOU FOR YOUR SUBSCRIPTION!");
								$("input#email").val("");
			        		}else{
				        		$("#valid").css("display","block");
				        		$("#valid span").css("color","red");
								$("#valid span").text("ALREADY ASSIGNED TO ANOTHER USER");		        			
			        		}
			        	}catch(e){
			        		alert(e);
			        	}
			        }
			        ,error:function(request,status,error){
			        	alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
			        }
			    });
			}
		});
	});
	
	function statEmailChk(obj){
		if(obj.val() != ""){
			if(regEmail(obj)){
				$("#valid").css("display","block");
				$("#valid span").css("color","#06BBB4");
				$("#valid span").text("AVAILABLE-MAIL.");
				$("#YN").val('Y');
				return true;
			}else{
				$("#valid").css("display","block");
				$("#valid span").css("color","red");
				$("#valid span").text("THE EMAIL NEEDS TO BE VALID.");
				$("#YN").val('N');
				return false;
			}
		}else{
			$("#valid").css("display","none");
			$("#YN").val('N');
		}
	}
	$("#policy").click(function(){
		location.href = "/front/contactUs?policy=open";
	});

	//에스크로 팝업호출
	$("#escrowPop").on("click", function(e){
		window.open("http://www.worksout.co.kr/front/escrowPop","POP","width=500, height=450,left=100, top=100, scrollbars=yes");
	});
	
</script>
<div class="footer_content">
	<form:form id="event" modelAttribute="event" onsubmit="return(false)">
	<input type="hidden" id="YN" name="YN" />
	<div class="footer_menu_area clfix">
		<ul class="footer_menu01">
			<li>
				<a href="${contextPath}/front/about">ABOUT</a>
			</li>
			<li>
				<a href="${contextPath}/front/contactUs">CUSTOMER CARE</a>
			</li>
			<li>
				<a href="${contextPath}/front/workWithUsList">WORK WITH US</a>
			</li>
			<li>
				<a href="${contextPath}/front/contactUs">CONTACT US</a>
			</li>
		</ul>

		<ul class="footer_menu02">
			<!-- worksout -->
			<c:if test="${siteNo == '10001' }">
				<li>
					<a target="" href="http://blog.naver.com/worksout_official ">${siteNm } BLOG</a>
				</li>
				<li>
					<a target="" href="https://www.facebook.com/worksoutinc">${siteNm } FACEBOOK</a>
				</li>
				<li>
					<a target="" href="https://instagram.com/worksout_official">${siteNm } INSTAGRAM</a>
				</li>
			</c:if>
			<!-- carhartt -->
			<c:if test="${siteNo == '10002' }">
				<li>
					<a target="" href="http://blog.naver.com/carharttwip_kr">${siteNm } BLOG</a>
				</li>			
				<li>
					<a target="" href="https://www.facebook.com/carharttwip">${siteNm } FACEBOOK</a>
				</li>
				<li>
					<a target="" href="https://instagram.com/carharttwip_kr">${siteNm } INSTAGRAM</a>
				</li>
			</c:if>
			<!-- obey -->
			<c:if test="${siteNo == '10003' }">
				<li>
					<a target="" href="http://blog.naver.com/obeykorea">${siteNm } BLOG</a>
				</li>
				<li>
					<a target="" href="https://www.facebook.com/OBEYKOREA/">${siteNm } FACEBOOK</a>
				</li>
				<li>
					<a target="" href="https://instagram.com/Obeykorea">${siteNm } INSTAGRAM</a>
				</li>
			</c:if>
			<!-- brixton -->
			<c:if test="${siteNo == '10004' }">
				<li>
					<a target="" href="http://blog.naver.com/brixtonkorea">${siteNm } BLOG</a>
				</li>
				<li>
					<a target="" href="https://www.facebook.com/BrixtonKorea/">${siteNm } FACEBOOK</a>
				</li>
				<li>
					<a target="" href="https://instagram.com/brixton_kr">${siteNm } INSTAGRAM</a>
				</li>
			</c:if>
			<!-- deus -->
			<c:if test="${siteNo == '10006' }">
				<li>
					<a target="" href="http://blog.naver.com/deuskorea">${siteNm } BLOG</a>
				</li>
				<li>
					<a target="" href="https://www.facebook.com/deuskorea">${siteNm } FACEBOOK</a>
				</li>
				<li>
					<a target="" href="https://instagram.com/deuskorea/">${siteNm } INSTAGRAM</a>
				</li>
			</c:if>
			<li>
				<!-- 기본 뉴스레터 버튼 -->
				<a href="#" class="ui_btn_news_letter">${siteNm } NEWSLETTER</a>
			</li>
			<li class="footer_newsletter_area">
				<div class="newsletter_hidden_area">
					<!-- 클릭스 노출 영역 -->
					<div class="newsletter_input_area">
						<span class="input_newsletter">
<!-- 							<input type="text" id="email" name="email" placeHolder="E-MAIL" /> -->
							<form:input path="email" placeholder="E-MAIL" onkeyUp="statEmailChk($(this));" autocomplete="Off"/>
						</span>
						<a href="#" class="btn_subscribe">SUBSCRIBE</a>

					</div>
					<!-- 상황에 따른 메세지 1 -->
					<div class="newsletter_alert_area" id="valid" style="display:none;">
						<span class="ico_alert alert01"><!-- THE EMAIL NEEDS TO BE VALID. --></span>
					</div>
					
<!-- 					상황에 따른 메세지 2 -->
<!-- 					<div class="newsletter_alert_area" id="anotherUser" style="display:none;"> -->
<!-- 						<span class="ico_alert alert01">ALREADY ASSIGNED TO ANOTHER USER</span> -->
<!-- 					</div> -->
<!-- 					상황에 따른 메세지 3 -->
<!-- 					<div class="newsletter_alert_area" id="thanks" style="display:none;"> -->
<!-- 						<span class="alert01">THANK YOU FOR YOUR SUBSCRIPTION!</span> -->
<!-- 					</div> -->
<!-- 					<div class="newsletter_alert_area" id="thanks" style="display:none;"> -->
<!-- 						<span class="alert01">AVAILABLE-MAIL.</span> -->
<!-- 					</div> -->
					
				</div>
			</li>
		</ul>
	</div>
	</form:form>
	<ul class="footer_copyright clfix">
		<li class="txt01">© 2003-2016 WORKSOUT Inc.</li>
		<li class="txt02">
			<span>상호명: (주)웍스아웃 | 주소: 서울시 마포구 잔다리로 59 |</span>
			<span>사업자등록번호: 106-86-85373 |</span>
			<span>통신판매업신고: 2014-서울마포-0219 |</span>
			<span>대표: 강승혁, 박선영 |</span>
			<span class="tel_fax">
				<span class="tel">전화: 02-541-0854 |</span>
				<!-- <span class="fax">팩스 : 02-540-0851</span> -->
			</span>
			<span id="policy" style="cursor:pointer;">개인정보취급방침</span>
		</li>
		<li class="txt03"><a href="javascript:return void(0)" id="escrowPop">구매안전 (에스크로) 서비스 가입사실 확인</a></li>
	</ul>
</div>