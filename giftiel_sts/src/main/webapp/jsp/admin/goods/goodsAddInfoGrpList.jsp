<%--
 * =============================================================================
 * 파일명 : /goods/goodsAddInfoList.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-09
 *
 * 파일 내용 : 상품관리 > 상품목록
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
	<script type="text/javascript">
	$(function() {
	    openGoodsAddInfo = function() {
			var popUrl = "<c:url value='/admin/popup/goods/popupGoodsAddInfo'/>";	//팝업창에 출력될 페이지 URL
			var popOption = "width=470, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		};
		
	    openGoodsUpdInfo = function(gdsInfoNo) {
			var popUrl = "<c:url value='/admin/popup/goods/popupGoodsUpdInfo?gdsInfoNo='/>"+gdsInfoNo;	//팝업창에 출력될 페이지 URL
			var popOption = "width=470, height=730, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		};
		
		getGoodsAddInfoData = function(gdsInfoNo) {
			var formdata = {};
			formdata = "gdsInfoNo=" + gdsInfoNo;
			
			$.ajax({
		        url : "<c:url value='/admin/goods/goodsAddInfoAjax'/>",
		        type: "post",
		        data : formdata,
		        async: false,
		        success : function(responseData){
		        	try{
			            var data = jQuery.parseJSON(responseData);
			            $('#addInfoTable tbody').html('');
			            $('#addInfoTable tbody').html("<tr><th>제목</th><td id=\"title\"></td></tr><tr><th rowspan=" + (data.goodsAddInfos.length+1) + ">상품정보고시<br />항목</th></tr>");
			            
			            $("#title").html(data.gdsInfoNm);
			            $("#upd_btn").attr("href","javascript:openGoodsUpdInfo('"+data.gdsInfoNo+"');")
			            
			            for(var i=0;i<data.goodsAddInfos.length;i++){
				    	    	
			            	var html = "<tr>";
			    	    		html += "<td>"+data.goodsAddInfos[i].title+" : "+data.goodsAddInfos[i].txt+"</td>";
			    	    		html += "</tr>";
			    	    		
			    	    		$('#addInfoTable > tbody:last').append(html);	
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
	});
	</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
			<jsp:include page="/jsp/admin/include/top.jsp"/>
		<!--[e] header -->

		<!--[s] container -->
		<div id="container">
			<h2 class="blind">컨텐츠</h2>
			<div class="subWrap">
				<!--[s] lnb -->
					<jsp:include page="/jsp/admin/include/leftMenu.jsp">
						<jsp:param name="menuFlag" value="goods"/>
						<jsp:param name="onChk" value="goodsAddInfo"/>
					</jsp:include>
				<!--[e] lnb -->

				<!--[s] contents -->
				<div class="contents productList">
					<!--[s] 상품정보고시 관리 -->
					<div class="section a1">
						<h3><span class="icon1"></span>상품정보고시 관리</h3>
						<div class="tableType2">
							<ul class="boxLi">
								<li>- 상품정보고시를 등록 및 관리합니다.</li>
							</ul>
							<!-- [s] leftbox -->
							<div class="leftbox">
								<div class="cateOpen">
									<span class="tit">전체 펼쳐보기</span>
									<div class="scroll">
										<ul>
											<c:forEach items="${addInfoList}" var="addInfoList" varStatus="listCount">
												<li><a href="javascript:getGoodsAddInfoData('${addInfoList.gdsInfoNo }');" >- ${addInfoList.gdsInfoNm }</a></li>	
											</c:forEach>
										</ul>
									</div>
									<a href="javascript:openGoodsAddInfo();" class="btnType2">추가</a>
								</div>
							</div>
							<!-- [e] leftbox -->
							<!-- [s] rightbox -->
							<div class="rightbox">								
								<table class="cateinfo" id="addInfoTable">
								<colgroup>
									<col width="132px" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>제목</th>
										<td id="title"></td>
									</tr>
									<tr>
										<th rowspan="100">상품정보고시<br />항목</th>
									</tr>
								</tbody>
								</table>
								<div>
									<a href="javascript:void(0);" class="btnType2 right" id="upd_btn">수정</a>
								</div>
							<!-- [e] rightbox -->
							<div style="clear:both;"></div>

							</div>
						</div>
					<!--[e] 상품정보고시 관리 -->
					</div>
				<!--[e] contents -->
				</div>

			</div>
		<!--[e] container -->

		<!--[s] footer -->
		<div id="footer">
			<p class="copyright">copyright(c) worksout co. republic of korea. all rights reserved.</p>
		</div>
		<!--[e] footer -->

		</div>
	</div>
</body>
</html>