<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	$("a[href=#]").attr("href", "javascript:void(0);");
    $("li[data-brand='brand'][id='"+$("#newsType").val()+"']").attr("class", "on");
    $("a[data-brand='brand'][id='"+$("#newsType").val()+"']").attr("class", "on");
    
  	//News 타입 선택
    setType= function(e){
    	var $target = $(e);
    	var newsType = $target.attr('id');
    	$("#newsType").val(newsType);
        $("#schForm").attr("action","<c:url value='/front/news/newsList'/>");
        $("#schForm").submit();
    };
    
});
</script>
<div class="snb_fixed">
	<!-- NEW 타이틀에 링크 추가 2015-09-29 이현우 -->
	<a href="<c:url value="/front/news/newsList"/>"><div class="snb_tit">NEWS</div></a>
	<!-- li 에 on 클래스 붙으면 글씨 굵어 짐 -->
	<ul class="snb_depth02_fix_area space01">
	<c:choose>
		<c:when test="${not empty newsTypeList}">
			<c:forEach items="${newsTypeList}" var="newsType" varStatus="listCount">
				<c:choose>
					<c:when test="${siteNo == '10003' or siteNo == '10004' or siteNo == '10006'}">
						<c:if test="${newsType.cdNo != 'CM00404'}">
							<li data-brand="brand" id="${newsType.cdNo}">
								<a href="#" onclick="setType(this);" id="${newsType.cdNo}">${newsType.cdNm}</a>
							</li>						
						</c:if>
					</c:when>
					<c:otherwise>
						<li data-brand="brand" id="${newsType.cdNo}">
							<a href="#" onclick="setType(this);" id="${newsType.cdNo}">${newsType.cdNm}</a>
						</li>
					</c:otherwise>
				</c:choose>					
			</c:forEach>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	</ul>
</div>
<div class="snb_mobile_container">
	<ul class="snb_mobile_menu">
	<c:choose>
		<c:when test="${not empty newsTypeList}">
			<c:forEach items="${newsTypeList}" var="newsType" varStatus="listCount">
				<c:choose>
					<c:when test="${siteNo == '10003' or siteNo == '10004' or siteNo == '10006'}">
						<c:if test="${newsType.cdNo != 'CM00404'}">
						<li>
							<a href="#" onclick="setType(this);" data-brand="brand" id="${newsType.cdNo}">
								<div class="txt">${newsType.cdNm}</div>
							</a>
						</li>					
						</c:if>
					</c:when>
					<c:otherwise>
						<li>
							<a href="#" onclick="setType(this);" data-brand="brand" id="${newsType.cdNo}">
								<div class="txt">${newsType.cdNm}</div>
							</a>
						</li>
					</c:otherwise>
				</c:choose>					
			</c:forEach>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>		
	</ul>
</div>