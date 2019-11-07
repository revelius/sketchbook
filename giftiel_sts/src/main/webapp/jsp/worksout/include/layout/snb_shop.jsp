<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
   $(function() { 

	    depthMenu = function(id) {
			if($("#"+id).css("display") == "none"){
				$("#"+id).show();
			} else {
				$("#"+id).hide();
			}
	    };
		//
	    $(".snb_depth02_area a,.snb_depth02_fix_area li a").css("color","#A1A1A1");
	    $(".snb_depth02_fix_area.color03 li a").css("color","#000");
	    
	    
// 	    if("${curOneDepth}" != "16SS" || "${curOneDepth}" == "OUTLET"){
// 	    	alert("현재 OUTLET상품은 이용할 수 없습니다.");
// 	    	location.href = "/front/onlineShop/feature";
// 	    }
	    
	    if("${curOneDepth}" != "OUTLET"){
    		$('#${curOneDepth}').css("color","#000000");
    		$('#${curOneDepth}').css("font-weight","bold");
    		$('#${curOneDepth}').css("text-decoration","underline");
    		
    		$('#${curOneDepth}Mob').css("color","#000000");
    		$('#${curOneDepth}Mob').css("font-weight","bold");
    		$('#${curOneDepth}Mob').css("text-decoration","underline");  
    		
    		//상품상세화면에서 OUTLET 상품은 시즌상관없이 OUTLET 처리 해줌
    		if ( $("#${curOneDepth}").length == 0 ) { //1뎁스 시즌코드값의 ELEMENT가 없으면 == 현재 설정되어 있는 시즌이 아니면
    			$('#noSeason').css("color","#000000");
        		$('#noSeason').css("font-weight","bold");
        		$('#noSeason').css("text-decoration","underline");
        		
        		$('#noSeasonMob').css("color","#000000");
        		$('#noSeasonMob').css("font-weight","bold");
        		$('#noSeasonMob').css("text-decoration","underline"); 
			}
    		
    	}else{
    		$('#noSeason').css("color","#000000");
    		$('#noSeason').css("font-weight","bold");
    		$('#noSeason').css("text-decoration","underline");
    		
    		$('#noSeasonMob').css("color","#000000");
    		$('#noSeasonMob').css("font-weight","bold");
    		$('#noSeasonMob').css("text-decoration","underline");    		
    	}
	    
	    
	    openMenu = function(id) {
	    	if( "${curSex}" == ""){
	    		//$('#newArvl').trigger('click');
	    		
	    	}else if("${curSex}" == "M"){
	    		$('#menCategory').trigger('click');
	    		$('#MEN_${curTwoDepth}').show();

	    		$("a#MEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").addClass('on');

	    		$("a#MEN_${curOneDepth}${curTwoDepth}").css("color","#000000");
	    		$("a#MEN_${curOneDepth}${curTwoDepth}").css("font-weight","bold");
	    		$("a#MEN_${curOneDepth}${curTwoDepth}").css("font-size","14px");
	    		$("ul#MEN_${curTwoDepth}").children().children().css("color","#000000");
	    		$("a#MEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").css("color","#000000");
	    		$("a#MEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").css("text-decoration","underline");
	    		
	    		$("div#mobile_cate").html($("a#MEN_${curOneDepth}${curTwoDepth}").html());
	    	}else if("${curSex}" == "W"){
	    		$('#womenCategory').trigger('click');
	    		$('#WOMEN_${curTwoDepth}').show();

	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").addClass('on');

	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}").css("color","#000000");
	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}").css("font-weight","bold");
	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}").css("font-size","14px");
	    		$("ul#WOMEN_${curTwoDepth}").children().children().css("color","#000000");
	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").css("color","#000000");
	    		$("a#WOMEN_${curOneDepth}${curTwoDepth}${curThreeDepth}").css("text-decoration","underline");
	    		
	    		$("div#mobile_cate").html($("a#WOMEN_${curOneDepth}${curTwoDepth}").html());
	    	}

	    	if("${param.brand}" == ""){
	    		$("a#BRAND_ALL").css("color","#000000");
	    		$("a#BRAND_ALL").css("font-weight","bold");
	    		$("a#BRAND_ALL").css("text-decoration","underline");
	    	}else{
	    		$("a#BRAND_${param.brand}").css("color","#000000");
	    		$("a#BRAND_${param.brand}").css("font-weight","bold");
	    		$("a#BRAND_${param.brand}").css("text-decoration","underline");
	    		
	    		$("div#mobile_brand").html($("a#BRAND_${param.brand}").html());
	    	}
	    	
	    	
	    	$("div#mobile_filter").html($("a#${param.orderFlag}_${param.orderBy}").html());

	    	if("${newArvl}" == "Y"){
	    		$('#newArvl').trigger('click');
	    		
	    		$("div#mobile_cate").html("${menNaDispNm}");
	    		
	    		$('#${curSex}_newArvl').css("color","#000000");
	    		$('#${curSex}_newArvl').css("font-weight","bold");
	    		$('#${curSex}_newArvl').css("text-decoration","underline");
	    	}
	    	
	    	$("a#${param.orderFlag}_${param.orderBy}").addClass('on');
	    };

    	setTimeout('openMenu()',200);
	    
		getBrandListAjax = function(nowSeq,depthCode) {
			<c:if test="${siteNo == '10001' }">
			$.ajax({
		        url:"/front/onlineShop/brandListAjax?nowSeq="+nowSeq+"&depthCode="+depthCode,
		        success:function(data){
					//브랜드 전부 삭제
					$("li#brandsList").remove();
					$("li#brandsListMobile").remove();
					for ( var i = 0; i < data.length; i++) {
						var html = "";
						var html2 = "";
						var curSex = "M";
							if(data[i].sex == "CM01504"){
								curSex = "W";
							}
							if(depthCode == "\'CM01504\'"){
								curSex = "W";				
							}							
						
							<c:if test="${curSex == 'M' || curSex == ''}">
								html = "<li id='brandsList'><a href='goodsList?sex="+curSex+"&brand="+data[i].cdNm+"&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}' id='BRAND_${brand.cdNm }' style='padding-left: 10px;''>"+data[i].cdDesc+"</a></li>";
							</c:if>
							<c:if test="${curSex == 'W'}">
								html = "<li id='brandsList'><a href='goodsList?sex="+curSex+"&brand="+data[i].cdNm+"&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}' id='BRAND_${brand.cdNm }' style='padding-left: 10px;''>"+data[i].cdDesc+"</a></li>";
							</c:if>					
						
							<c:if test="${curSex == 'M' || curSex == ''}">
								html2 = "<a href='goodsList?sex="+curSex+"&brand="+data[i].cdNm+"&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}' id='BRAND_${brand.cdNm }' style='padding-left: 10px;''>"+data[i].cdDesc+"</a>";
							</c:if>
							<c:if test="${curSex == 'W'}">
								html2 = "<a href='goodsList?sex="+curSex+"&brand="+data[i].cdNm+"&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}' id='BRAND_${brand.cdNm }' style='padding-left: 10px;''>"+data[i].cdDesc+"</a>";
							</c:if>
						if("CD,GX,HS,SJ,SZ,GB,QS".indexOf(data[i].cdNm) == -1){
								$("#pc_brand_list").append(html);
								$("#mobile_brand_list").append(html2);
						}
					}
		         },
		         cache: false
		     });
			 </c:if>
	   };
   });
   
   $(document).ready(function() {
	   <c:if test="${curSex == ''}">
	   	getBrandListAjax('${nowSeq}',"'CM01503','CM01504'");
	   </c:if>
   });
</script>
<c:set var="fixed" value="no_fixed"/>
<c:if test="${siteNo != '10001' }">
	<c:set var="fixed" value=""/>
</c:if>
<div class="snb_fixed ui_snb_shop ${fixed }">
	<!-- a 태그에 on 붙으면 활성화 됨 -->
	<c:set var="season" value="${currentSeason }"/>
	<ul class="snb_shop clfix">
		<c:if test="${preDispYn eq 'Y'}">
			<li>
				<a href="<c:url value='/front/onlineShop/feature?oneDepth=${preSeason}&nowSeq=${preSeq}'/>" id="${preSeason}" data-season="${preSeason}">${preSeasonName }</a>
			</li>
		</c:if>
		<c:if test="${currentDispYn eq 'Y'}">
			<li>
				<a href="<c:url value='/front/onlineShop/feature?oneDepth=${currentSeason}&nowSeq=${currentSeq}'/>" id="${currentSeason}" data-season="${currentSeason}">${currentSeasonName }</a>
			</li>
		</c:if>
		<li>
			<a href="goodsList?oneDepth=OUTLET&nowSeq=${outletSeq}" id="noSeason" data-season="noSeason">SALE</a>
		</li>
	</ul>
	
	
	<c:if test="${param.oneDepth!='OUTLET' }">
		<div class="snb_depth01">
			<c:if test="${menNaDispYn eq 'Y'}">
				<a href="goodsList?oneDepth=${currentSeason }&newArvl=Y" class="ico_arrow" id="newArvl">${menNaDispNm}</a>
			</c:if>
			<ul style="display:none;" class="snb_depth02_area">
				<li style="padding-left: 10px;"><a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=M" id="M_newArvl">MEN</a></li>
				<li style="padding-left: 10px;"><a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=W" id="W_newArvl">WOMEN</a></li>
			</ul>		
		</div>
	</c:if>
	<div class="snb_depth01" id="snb_depth01">
		<a href="#" class="ico_arrow" id="menCategory" onclick="getBrandListAjax(${nowSeq},'\'CM01503\'');">MEN</a>
		<ul style="display:none;" class="snb_depth02_area">
<%-- 			<c:if test="${param.oneDepth!='OUTLET' }"> --%>
<%-- 			<c:if test="${menNaDispYn eq 'Y'}"> --%>
<!-- 				<li> -->
<%-- 					<a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=M" id="M_newArvl">${menNaDispNm}</a> --%>
<!-- 				</li> -->
<%-- 			</c:if> --%>
			<c:if test="${curBrand !='' && curBrand !=null}">
				<li>
					<a href="goodsList?sex=M&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }">ALL CATEGORIES</a>
				</li>
			</c:if>
			
			<c:if test="${siteNo != '10001' }">
				<li>
					<a href="goodsList?sex=M&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }">ALL CATEGORIES</a>
				</li>			
			</c:if>
			<c:forEach items="${twoDepthMen}" var="cate1" varStatus="listCount">
			<c:if test="${cate1.cateCd != '00' && cate1.cateCd != 'DR'}">
				<li>
					<a href="goodsList?sex=M&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }${cate1.cateCd }">${cate1.cateNm }</a>
					<ul class="snb_depth03_area" style="display:none;" id="MEN_${cate1.cateCd }">
					<c:forEach items="${threeDepthMen}" var="cate2" varStatus="listCount">
						<c:if test="${cate1.cateCd == fn:substring(cate2.cateCd,0,2) }">
							<c:if test="${cate2.cateCd != 'SMBI'}">
								<li>
									<a href="goodsList?sex=M&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&threeDepth=${cate2.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }${cate1.cateCd }${cate2.cateCd }">${cate2.cateNm }</a>
								</li>									
							</c:if>
						</c:if>
					</c:forEach>
					</ul>				
				</li>
			</c:if>			
			</c:forEach>
		</ul>
	</div>
	<!-- .snb_depth01클래스에 on 클래스 붙으면 .snb_depth02_area 영역 열림 -->
	<div class="snb_depth01">
		<a href="#" class="ico_arrow" id="womenCategory" onclick="getBrandListAjax(${nowSeq},'\'CM01504\'');">WOMEN</a>
		<ul style="display:none;" class="snb_depth02_area last_child">
<%-- 			<c:if test="${param.oneDepth!='OUTLET' }"> --%>
<%-- 			<c:if test="${womenNaDispYn eq 'Y'}"> --%>
<!-- 				<li> -->
<%-- 					<a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=W" id="W_newArvl">${womenNaDispNm}</a> --%>
<!-- 				</li> -->
<%-- 			</c:if> --%>
			<c:if test="${curBrand !='' && curBrand !=null}">
				<li>
					<a href="goodsList?sex=W&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }">ALL CATEGORIES</a>
				</li>		
			</c:if>
			
			<c:if test="${siteNo == '10002' }">
				<li>
					<a href="goodsList?sex=W&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }">ALL CATEGORIES</a>
				</li>			
			</c:if>
						
			<c:forEach items="${twoDepthWomen}" var="cate1" varStatus="listCount">
			<c:if test="${cate1.cateCd != '00'}">
				<li>
					<a href="goodsList?sex=W&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }${cate1.cateCd }">${cate1.cateNm }</a>
					<ul class="snb_depth03_area" style="display:none;" id="WOMEN_${cate1.cateCd }">
					<c:forEach items="${threeDepthWomen}" var="cate2" varStatus="listCount">
						<c:if test="${cate1.cateCd == fn:substring(cate2.cateCd,0,2) }">
							<li>
								<a href="goodsList?sex=W&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&threeDepth=${cate2.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }${cate1.cateCd }${cate2.cateCd }">${cate2.cateNm }</a>
							</li>
						</c:if>
					</c:forEach>
					</ul>
				</li>
			</c:if>
			</c:forEach>
		</ul>
	</div>
	<ul class="snb_depth02_fix_area color02">
		<c:if test="${currentSiteNo == '10001' }">
			<li>
				<a href="${contextPath }/front/onlineShop/goodsList?sex=&brand=CD,GX,HS,SJ,SZ,GB,QS&oneDepth=${curOneDepth }&orderFlag=&orderBy=" id="BRAND_CD">CORNER DELI</a>
			</li>
		</c:if>
		<c:if test="${currentSiteNo != '10001' }">
			<li>
				<a href="${contextPath }/front/onlineShop/collaboration" id="collaboration">COLLABORATION</a>
			</li>
		</c:if>	
	</ul>
	<ul class="snb_depth02_fix_area color03" id="pc_brand_list">
		 <c:if test="${currentSiteNo == '10001' }">
			<li>
				<a href="goodsList?sex=${curSex }&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" id="BRAND_ALL">BRAND</a>
			</li>
		 	<c:forEach items="${brandCode}" var="brand" varStatus="listCount">
		 		<c:if test="${fn:indexOf('CD,GX,HS,SJ,SZ,GB,QS', brand.cdNm) == -1 }">
					<li id="brandsList">
<%-- 						<a href="goodsList?sex=${curSex }&brand=${brand.cdNm }&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" id="BRAND_${brand.cdNm }" style="padding-left: 10px;">${brand.cdDesc }</a> --%>
					</li>
				</c:if>		 		
		 	</c:forEach>		 
		</c:if>	
	</ul>
</div>
<div class="snb_mobile_container">
	<ul class="snb_mobile_menu">
		<li>
			<a href="#" class="on">
				<div class="txt">
					<c:if test="${param.sex =='M' or param.sex ==''}">
						MEN
					</c:if>
					<c:if test="${param.sex =='W' }">
						WOMEN
					</c:if>
				</div>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="txt" id="mobile_cate">
				<c:if test="${param.sex =='M'  or param.sex ==''}">
					<c:if test="${menNaDispYn eq 'Y'}">
						${menNaDispNm}
					</c:if>
					
					<c:if test="${menNaDispYn eq 'N'}">
						ALL CATEGORIES
					</c:if>					
				</c:if>
				<c:if test="${param.sex =='W' }">
					<c:if test="${womenNaDispYn eq 'Y'}">
						${womenNaDispNm}
					</c:if>
					
					<c:if test="${womenNaDispYn eq 'N'}">
						ALL CATEGORIES
					</c:if>								
				</c:if>

				</div>
			</a>
		</li>
		<c:if test="${currentSiteNo == '10001' }">
		<li>
			<a href="#">
				<div class="txt" id="mobile_brand">ALL BRANDS</div>
			</a>
		</li>
		</c:if>
		<li>
			<a href="#">
				<div class="txt" id="mobile_filter">FILTER</div>
			</a>
		</li>
	</ul>
	<div style="display:none;" class="snb_mobile_sub_menu">
		<div>
			<div>
				<div class="menu_link">
					<a href="goodsList?sex=M&brand=${sites.siteNo }&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" class="on">MEN</a>
					<a href="goodsList?sex=W&brand=${sites.siteNo }&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" style="z-index:9999">WOMEN</a>
				</div>
				<div style="display:none;" class="menu_link">
					<c:if test="${param.sex =='M'  or param.sex ==''}">
<%-- 						<c:if test="${param.oneDepth!='OUTLET' }"> --%>
						<c:if test="${menNaDispYn eq 'Y'}">
							<a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=M" id="newArvl">${menNaDispNm}</a>
						</c:if>						
						<a href="goodsList?sex=M&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }">ALL CATEGORIES</a>
						<c:forEach items="${twoDepthMen}" var="cate1" varStatus="listCount">
							<c:if test="${cate1.cateCd != '00' && cate1.cateCd != 'DR'}">
								<a href="goodsList?sex=M&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="MEN_${curOneDepth }${cate1.cateCd }">${cate1.cateNm }</a>
							</c:if>			
						</c:forEach>	
					</c:if>
					<c:if test="${param.sex =='W' }">
<%-- 						<c:if test="${param.oneDepth!='OUTLET' }"> --%>
						<c:if test="${womenNaDispYn eq 'Y'}">
							<a href="goodsList?oneDepth=${curOneDepth }&newArvl=Y&sex=W" id="newArvl">${womenNaDispNm}</a>
						</c:if>						
						<a href="goodsList?sex=W&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }">ALL CATEGORIES</a>
						<c:forEach items="${twoDepthWomen}" var="cate1" varStatus="listCount">
							<c:if test="${cate1.cateCd != '00'}">
								<a href="goodsList?sex=W&oneDepth=${curOneDepth }&twoDepth=${cate1.cateCd }&orderFlag=${orderFlag }&orderBy=${orderBy}&brand=${curBrand}" id="WOMEN_${curOneDepth }${cate1.cateCd }">${cate1.cateNm }</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
					 <c:if test="${currentSiteNo == '10001' }">
				<div style="display:none;" class="menu_link" id="mobile_brand_list">
					 	<a href="goodsList?sex=${curSex }&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" id="BRAND_ALL">ALL BRANDS</a>
					 	<c:forEach items="${brandCode}" var="brand" varStatus="listCount">
						 	<c:if test="${fn:indexOf('CD,GX,HS,SJ,SZ,GB,QS', brand.cdNm) == -1 }">
	<%-- 					 		<a href="goodsList?sex=${curSex }&brand=${brand.cdNm }&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" id="BRAND_${brand.cdNm }">${brand.cdDesc }</a> --%>
<%-- 						 		<a href="goodsList?sex=${curSex }&brand=${brand.cdNm }&oneDepth=${curOneDepth }&orderFlag=${orderFlag }&orderBy=${orderBy}" id="BRAND_${brand.cdNm }">${brand.cdDesc }</a> --%>
						 	</c:if>
					 	</c:forEach>
				</div>
					</c:if>	
				<div style="display:none;" class="menu_link">
<!-- 					<span class="tit first_child">SIZE</span>
					<a href="#" class="on">All Size</a>
					<a href="#">XS</a>
					<a href="#">S</a>
					<a href="#">M</a>
					<a href="#">L</a>
					<a href="#">XL</a>
					<a href="#">XXL</a> -->
					<span class="tit">SORT BY</span>
					<a href="goodsList?sex=${curSex }&brand=${curBrand}&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=DESC&orderBy=REG_DTS" id="DESC_REG_DTS">Latest Arrivals</a>
					<a href="goodsList?sex=${curSex }&brand=${curBrand}&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=ASC&orderBy=UBI_SL_PRC" id="ASC_UBI_SL_PRC">Price : low to high</a>
					<a href="goodsList?sex=${curSex }&brand=${curBrand}&oneDepth=${curOneDepth }&twoDepth=${curTwoDepth }&threeDepth=${curThreeDepth }&orderFlag=DESC&orderBy=UBI_SL_PRC" id="DESC_UBI_SL_PRC">Price : high to low</a>					
				</div>
			</div>
		</div>
	</div>
</div>