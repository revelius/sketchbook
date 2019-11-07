<%--
 * =============================================================================
 * 파일명 : /manage/siteSetting.jsp
 * 작성자 : 이현우
 * 작성일자 : 2015-12-02
 *
 * 파일 내용 : 사이트환경설정 
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="ko" lang="ko">
<head>  
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<jsp:include page="/jsp/admin/include/head.jsp"/>
<script>
$(function(){
	$("input[type=text]").attr("disabled",true);	
});

//저장
function doSave(){
	
// 	if($("input[name=works_par]").val() !=""){
// 		var icoStr = $("input[name=works_par]").val().substring($("input[name=works_par]").val().lastIndexOf(".")+1,$("input[name=works_par]").val().length);
// 		if( icoStr !="ico"){
// 			alert("WORKSOUT의 확장자 확인 바랍니다.");
// 			$("input[name=works_par]").focus();
// 			return;
// 		}
// 	}
//	fn_filterChk();
	
	$.ajax({
        url : "<c:url value='/admin/setting/settingSiteSave'/>",
        type: "post",
        data : $("form#setting").serialize(),
        async: false,
        success : function(res){
            if(res=="1"){  //저장 성공 
				alert("저장되었습니다.");
            	location.reload();
            }else{
            	alert("오류가 발생되었습니다. \n확인 후 다시 시도해 주시기 바랍니다.");
            }
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
        }
    });
}

</script>
</head>
<body>
	<div id="wrap">
		<!--[s] header -->
		<!-- 탑 메뉴 : 추후 메뉴 기능화 하기. -->
		<jsp:include page="/jsp/admin/include/top.jsp"></jsp:include>
		<!--[e] header -->
		
		<!--[s] container -->
		<div id="container">
		  <div class="subWrap">
			<!--[s] lnb -->
			<!-- 왼쪽 메뉴 : 추후 메뉴 기능화 하기. -->
			<jsp:include page="/jsp/admin/include/leftMenu.jsp">
					<jsp:param name="menuFlag" value="setting"/>
		    </jsp:include>
			<!--[e] lnb --> 
					
			<!--[s] contents -->
			<div class="contents">
				<h3><span class="icon1"></span>환경설정 &gt; 상점기본정보관리 &gt; 사이트환경설정</h3>
<!-- 				<a href="#" class="btnType2 advice">도움말</a> -->
<!-- 				<div class="helpBox"> -->
<!-- 					<ul class="boxLi"> -->
<!-- 						<li>- 사이트 별 필요 정보를 설정합니다.</li> -->
<!-- 						<li>- 브라우저 타이틀, 검색엔진키워드 설정, 파비콘, 구매확정기간 설정이 가능합니다.</li> -->
<!-- 						<li>- 사업자 정보는 홈페이지 하단 카피라이트부분에 노출됩니다</li> -->
<!-- 					</ul> -->
<!-- 					<a href="#" class="close">X</a> -->
<!-- 				</div> -->
				<!-- [s] 상점환경설정 컨텐츠 -->
				<form:form id="setting" name="setting" method="post" modelAttribute="setting" onsubmit="">
				<div class="tabCon_inner">
					<!-- [s] 브라우저 타이틀 설정 테이블 -->
					<div class="tableType2">
						<table>
							<caption>상점환결설정</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="2" class="row_tit">브라우저 타이틀 설정</th>
							    </tr>
							    
							    <c:forEach var="title" items="${siteList}" varStatus="status">
									<tr>
										<th scope="col">${title.siteNm }</th>
										<td>
										<input type="hidden" id="siteSetting[${status.index}].site_no" name="siteSetting[${status.index}].site_no" value="${title.siteNo }" />
										<input type="hidden" id="siteSetting[${status.index}].site_nm" name="siteSetting[${status.index}].site_nm" value="${title.siteNm }" />
										<input type="text" id="siteSetting[${status.index }].fabicon_nm" name="siteSetting[${status.index }].fabicon_nm" class="ip_tit" value="${title.fabiconNm }"/>
										</td>
									</tr>
							    </c:forEach>
							    
							</tbody>
						</table>
					</div>
					<!-- [e] 브라우저 타이틀 설정 테이블 -->
					<!-- [s] 파비콘설정 테이블 -->
					<div class="tableType2 pt20">
						<table>
							<caption>파비콘 설정</caption>
							<colgroup>
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="2" class="row_tit">파비콘 설정</th>
							    </tr>
							    
							    <c:forEach var="favicon" items="${siteList}" varStatus="status">
									<tr>
										<th scope="col">${favicon.siteNm }</th>
										<td>
											<c:if test="${favicon.fabiconImg ne null}">
											<img alt="" src="${uploadImage}${favicon.fabiconImg}" id="siteSetting[${status.index }].favicon_img" style="vertical-align: middle;width:25px;hiehgt:25px" />
											</c:if>
											<input id="faviconImg${favicon.siteNo }" name="siteSetting[${status.index }].favicon_img" type="text" class="wd_200"  value="${favicon.fabiconImg}"><a href="javascript:openFileUploadPop('image','faviconImg${favicon.siteNo }','favicon');" class="btnType2" style="vertical-align: middle;">파일첨부</a><br/>
										</td>
									</tr>
							    </c:forEach>
								<tr>
									<td colspan="2"><span class="highlight">※ 이미지 사이즈 16 x 16 의 아이콘(확장자 : ico)으로 등록해 주시기 바랍니다.</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 파비콘설정 테이블 -->
					<!-- [s] 검색엔진키워드설정 테이블 -->
					<div class="tableType2 pt20">
						<table>
							<caption>검색엔진키워드 설정</caption>
							<colgroup>
								<col width="132px" />
								<col width="132px" />
								<col width="*" />
							</colgroup>
							<tbody>
							    <tr>
							    	<th scope="row" colspan="3" class="row_tit">검색엔진키워드 설정</th>
							    </tr>
								
								<!-- [s] WORKSOUT -->
								<c:forEach var="kwdDesc" items="${siteList}" varStatus="status">
								<tr>
									<th scope="col" rowspan="2">${kwdDesc.siteNm }</th>
									<td>사이트 설명</td>
									<td><input type="text" class="ip_tit" id="siteSetting[${status.index }].site_description" name="siteSetting[${status.index }].site_description" value="${kwdDesc.siteDesc2}" /></td>
								</tr>
								<tr>
									<td>검색엔진 키워드</td>
									<td><input type="text" class="ip_tit" id="siteSetting[${status.index }].site_keyword" name="siteSetting[${status.index }].site_keyword" value="${kwdDesc.kwd}" /></td>
								</tr>
								</c:forEach>
								<tr>
									<td colspan="3">
										<p class="highlight">※ 사이트 설명 : 200자 이내의 문자(특수문자 제외)를 입력하시기 바랍니다.</p>
										<p class="highlight">※ 검색엔진 키워드 : 검색엔진에서 검색시 나타나게 할 검색키워드를 입력하시기 바랍니다.</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- [e] 검색엔진키워드설정 테이블 -->
<!-- 					<div class="section a2 btn"> -->
<!-- 						<a href="javascript:doSave();" class="btnType2">저장</a>  -->
<%-- 						<a href="<c:url value='/admin/setting/siteSetting'/>" class="btnType1">취소</a> --%>
<!-- 					</div> -->
				</div>
				</form:form>
				<!-- [e] 상점환경설정 컨텐츠 -->	
			</div>
			<!--[e] contents -->
		</div>
		<!--[e] container -->
	</div>
  </div>
</body>
</html>