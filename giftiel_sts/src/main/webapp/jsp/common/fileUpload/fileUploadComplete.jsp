<%--
 * =============================================================================
 * 파일명 : /common/fileUpload/fileUploadComplete.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-04-13
 *
 * 파일 내용 : 공통 > 파일업로드 팝업
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

<!DOCTYPE>
<html lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<jsp:include page="/jsp/admin/include/head.jsp"/>
	<script type="text/javascript">
 	$(window).load(function(){
		$("input#${param.target}",opener.document).val("${fileNm}");
		$("img#${param.target}",opener.document).attr("src","<spring:eval expression="@file['upload.image']"/>${fileNm}"); 
		
		//사이즈차트 업로드
		<c:if test="${goodsSizes!=null}">
		$("table#sizeChart tr",opener.document).remove();
		var html = "";
			<c:forEach items="${goodsSizes}" var="sizeList" varStatus="listCount">
				<c:if test="${listCount.index == 0}">
					html = "<tr>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].sizeNm' name='goodsSizes[${listCount.count-1}].sizeNm' value='${sizeList.sizeNm}' style='width:50px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size1' name='goodsSizes[${listCount.count-1}].size1' value='${sizeList.size1}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size2' name='goodsSizes[${listCount.count-1}].size2' value='${sizeList.size2}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size3' name='goodsSizes[${listCount.count-1}].size3' value='${sizeList.size3}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size4' name='goodsSizes[${listCount.count-1}].size4' value='${sizeList.size4}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size5' name='goodsSizes[${listCount.count-1}].size5' value='${sizeList.size5}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size6' name='goodsSizes[${listCount.count-1}].size6' value='${sizeList.size6}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size7' name='goodsSizes[${listCount.count-1}].size7' value='${sizeList.size7}' style='width:60px;'> </th>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].size8' name='goodsSizes[${listCount.count-1}].size8' value='${sizeList.size8}' style='width:60px;'> </th>";
					html += "</tr>";				
				</c:if>
				<c:if test="${listCount.index != 0}">
					html = "<tr>";
					html += "<th> <input type='text' id='goodsSizes[${listCount.count-1}].sizeNm' name='goodsSizes[${listCount.count-1}].sizeNm' value='${sizeList.sizeNm}' style='width:50px;'> </th>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size1' name='goodsSizes[${listCount.count-1}].size1' value='${sizeList.size1}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size2' name='goodsSizes[${listCount.count-1}].size2' value='${sizeList.size2}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size3' name='goodsSizes[${listCount.count-1}].size3' value='${sizeList.size3}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size4' name='goodsSizes[${listCount.count-1}].size4' value='${sizeList.size4}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size5' name='goodsSizes[${listCount.count-1}].size5' value='${sizeList.size5}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size6' name='goodsSizes[${listCount.count-1}].size6' value='${sizeList.size6}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size7' name='goodsSizes[${listCount.count-1}].size7' value='${sizeList.size7}' style='width:60px;'> </td>";
					html += "<td> <input type='text' id='goodsSizes[${listCount.count-1}].size8' name='goodsSizes[${listCount.count-1}].size8' value='${sizeList.size8}' style='width:60px;'> </td>";
					html += "</tr>";				
				</c:if>
				$("table#sizeChart",opener.document).append(html);
			</c:forEach>
		</c:if>
		
		//상품대량등록
		<c:if test="${goodss!=null}">
		var html = "";
			<c:forEach items="${goodss}" var="goodsList" varStatus="listCount">
				html = "<tr>";
				html += "<td> <input type='hidden' id='goodss[${listCount.count-1}].ubiGoods.ubiGdsNo' name='goodss[${listCount.count-1}].ubiGoods.ubiGdsNo' value='${goodsList.ubiGoods.ubiGdsNo}' style='width:100px;'>${goodsList.ubiGoods.ubiGdsNo} </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[0].tagNm' name='goodss[${listCount.count-1}].goodsTags[0].tagNm' value='${goodsList.goodsTags[0].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[1].tagNm' name='goodss[${listCount.count-1}].goodsTags[1].tagNm' value='${goodsList.goodsTags[1].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[2].tagNm' name='goodss[${listCount.count-1}].goodsTags[2].tagNm' value='${goodsList.goodsTags[2].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[3].tagNm' name='goodss[${listCount.count-1}].goodsTags[3].tagNm' value='${goodsList.goodsTags[3].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[4].tagNm' name='goodss[${listCount.count-1}].goodsTags[4].tagNm' value='${goodsList.goodsTags[4].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsTags[5].tagNm' name='goodss[${listCount.count-1}].goodsTags[5].tagNm' value='${goodsList.goodsTags[5].tagNm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].gdsInfoNo' name='goodss[${listCount.count-1}].gdsInfoNo' value='${goodsList.gdsInfoNo}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].dispYn' name='goodss[${listCount.count-1}].dispYn' value='${goodsList.dispYn}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].slTermCls' name='goodss[${listCount.count-1}].slTermCls' value='${goodsList.slTermCls}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].slStrDtm' name='goodss[${listCount.count-1}].slStrDtm' value='${goodsList.slStrDtm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].slEndDtm' name='goodss[${listCount.count-1}].slEndDtm' value='${goodsList.slEndDtm}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].gdsStat' name='goodss[${listCount.count-1}].gdsStat' value='${goodsList.gdsStat}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].bsDesc' name='goodss[${listCount.count-1}].bsDesc' value='${goodsList.bsDesc}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].dtlDesc' name='goodss[${listCount.count-1}].dtlDesc' value='${goodsList.dtlDesc}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[0].imgUrl' name='goodss[${listCount.count-1}].goodsImages[0].imgUrl' value='${goodsList.goodsImages[0].imgUrl}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[1].imgUrl' name='goodss[${listCount.count-1}].goodsImages[1].imgUrl' value='${goodsList.goodsImages[1].imgUrl}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[2].imgUrl' name='goodss[${listCount.count-1}].goodsImages[2].imgUrl' value='${goodsList.goodsImages[2].imgUrl}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[3].imgUrl' name='goodss[${listCount.count-1}].goodsImages[3].imgUrl' value='${goodsList.goodsImages[3].imgUrl}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[4].imgUrl' name='goodss[${listCount.count-1}].goodsImages[4].imgUrl' value='${goodsList.goodsImages[4].imgUrl}' style='width:100px;'> </td>";
				html += "<td> <input type='text' id='goodss[${listCount.count-1}].goodsImages[5].imgUrl' name='goodss[${listCount.count-1}].goodsImages[5].imgUrl' value='${goodsList.goodsImages[5].imgUrl}' style='width:100px;'> </td>";
				
				html += "</tr>";
				$("table#goodsExcel",opener.document).append(html);
			</c:forEach>
		</c:if>
		
		<c:if test="${goodsAddInfoGrp != null}">
		var html = "";
			<c:forEach items="${goodsAddInfoGrp}" var="goodsAddInfoGrpList" varStatus="listCount">
				html += "<tr>";
				
				html += "<td>";
				html += "<input type='hidden' name='gdsInfoNm' id='gdsInfoNm' value='${goodsAddInfoGrpList.gdsInfoNm}' />";
				html += "<input type='hidden' name='goodsAddInfos[${listCount.index}].gdsInfoNm' id='goodsAddInfos[${listCount.index}].gdsInfoNm' value='${goodsAddInfoGrpList.gdsInfoNm}' />";
				html += "${goodsAddInfoGrpList.gdsInfoNm}</td>";
				html += "<td><input type='hidden' name='goodsAddInfos[${listCount.index}].title' id='goodsAddInfos[${listCount.index}].title' value='${goodsAddInfoGrpList.goodsAddInfos[listCount.index].title}' />";
				html += "${goodsAddInfoGrpList.goodsAddInfos[listCount.index].title}</td>";
				html += "<td><input type='hidden' name='goodsAddInfos[${listCount.index}].txt' id='goodsAddInfos[${listCount.index}].txt' value='${goodsAddInfoGrpList.goodsAddInfos[listCount.index].txt}' />";
				html += "${goodsAddInfoGrpList.goodsAddInfos[listCount.index].txt}</td>";
				
				html += "</tr>";
			</c:forEach>			
			$("table#goodsAddInfoExcel", opener.document).append(html);
			$("#excelYN", opener.document).val("Y");
		</c:if>
		
		<c:if test="${orderGoods != null}">
		var html = "";
			<c:forEach items="${orderGoods}" var="orderGoodsList" varStatus="listCount">
				html = "<tr>";
				html += "<td><input type='text' name='orderGoods[${listCount.count-1}].ordNo' id='orderGoods[${listCount.count-1}].ordNo' value='${orderGoodsList.ordNo}' style='width:40%' /></td>";
				html += "<td><input type='text' name='orderGoods[${listCount.count-1}].chgInvNo' id='orderGoods[${listCount.count-1}].chgInvNo' value='${orderGoodsList.chgInvNo}' style='width:40%'/></td>";
				html += "<td><input type='text' name='orderGoods[${listCount.count-1}].dlvCmpNo' id='orderGoods[${listCount.count-1}].dlvCmpNo' value='${orderGoodsList.dlvCmpNo}' style='width:40%'/></td>";
				html += "<input type='text' name='orderGoods[${listCount.count-1}].chgDlvCmpNo' id='orderGoods[${listCount.count-1}].chgDlvCmpNo' value=${orderGoodsList.dlvCmpNo} /> ";
				
				html += "</tr>";
				$("table#invNoExcel", opener.document).append(html);
				$("#isExcel",opener.document).val(true);
			</c:forEach>
		</c:if>
		
		window.close();
	});  
	</script>
</head>
<body>
<!-- 대 카테고리 추가 -->
<div class="layerWrap" style="height:140px;">
	<div class="title">
		<h1><span class="icon1"></span>파일첨부</h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
	<div class="wrap">
		<div class="section a1">
			<div class="srchMember zipcode_sel mb_16">
				<c:if test="${resultCode == '0' }">
					파일 업로드가 성공적으로 완료되었습니다.
				</c:if>
				<c:if test="${resultCode == '1' }">
					파일 업로드에 문제가 생겼습니다.
				</c:if>
			</div>
		</div>
	</div>
</div>
<!-- //대 카테고리 추가 -->
</body>
</html>
