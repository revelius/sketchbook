<%--
 * =============================================================================
 * 파일명 : /front/order/orderPayOnlyPoint.jsp
 * 작성자 : 권용재
 * 작성일자 : 2016-04-05
 *
 * 파일 내용 : order > 포인트결제
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0);
 
 String	res_cd = request.getAttribute("res_cd").toString();
 String	res_msg = request.getAttribute("res_msg").toString();
 String	ordr_idxx = request.getAttribute("ordr_idxx").toString();
%>
    <head>
        <script src="<c:url value='/resources/worksout/js/jquery.js'/>" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript">
            function goResult()
            {
            	//parent.document.pay_info.submit();
    			//주문데이터 init, pg호출
    		    	$("#pay_info").submit(function(){
    	            }).submit();
            }

            // 결제 중 새로고침 방지 샘플 스크립트
            function noRefresh()
            {
                /* CTRL + N키 막음. *///
                if ((event.keyCode == 78) && (event.ctrlKey == true))
                {
                    event.keyCode = 0;
                    return false;
                }
                /* F5 번키 막음. */
                if(event.keyCode == 116)
                {
                    event.keyCode = 0;
                    return false;
                }
            }
            document.onkeydown = noRefresh ;
            
            $(window).load(function() {
            	setTimeout("goResult();",1000);
            });             
        </script>
    </head>

    <body onload="" >
    <form name="pay_info" id="pay_info" method="post" action="/front/order/orderResult">
        <input type="hidden" name="res_cd"            value="<%=res_cd          %>">  <!-- 결과 코드 -->
        <input type="hidden" name="res_msg"           value="<%=res_msg         %>">  <!-- 결과 메세지 -->
        <input type="hidden" name="ordr_idxx"         value="<%=ordr_idxx       %>">  <!-- 주문번호 -->
    </form>
    </body>
    
</html>