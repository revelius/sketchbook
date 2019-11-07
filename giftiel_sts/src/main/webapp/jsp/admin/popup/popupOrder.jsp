<%--
 * =============================================================================
 * 파일명 : /popup/popupOrder.jsp
 * 작성자 : 박필종
 * 작성일자 : 2015-05-08
 *
 * 파일 내용 : 주문관리 > 주문상세
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
		
		if("${alert}" !=""){
			alert("${alert}");			
		}
		
		//출력
		$('#btn_print').click(function() {
			window.print();
		});
		
		//수정
		$('#btn_uptOrdr').click(function() {
			
			var frm = document.frm;
			frm.ordrTel.value = frm.tel1.value +"-"+ frm.tel2.value +"-"+ frm.tel3.value; 
			frm.ordrCp.value = frm.cp1.value +"-"+ frm.cp2.value +"-"+ frm.cp3.value; 
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/updateOrdr'/>";
			
			if(!confirm("주문자 정보를 수정 하시겠습니까?")) return;
			frm.submit();
		});
		
		//우편번호 찾기
		$('#openZipCd').click(function() {
			execDaumPostcode();
		});
	

		
		//닫기
		$('#btn_close').click(function() {
			window.close();
		});	    
		
		//주문상품 size변경
	    ordGdsSizeChg = function(ordGdsSeq, el) {
	  
			$("input[name='ordGdsSeq']").val(ordGdsSeq);//주문상품일련번호
			$("input[name='chgUbiGdsSize']").val($(el).prev().val());//상품size
			
			var frm = document.frm;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/updateOrdGoods'/>";
			
			if(!confirm("상품변경정보를 수정 하시겠습니까?")) return;
			frm.submit();
	    	
	    };
	    
		//주문상품 배송상태변경
		ordGdsDlvChg = function(ordGdsSeq, el) {
		  	
		  	var div = $(el).parent().prev().children();//<div class='leftbox'>
		  	var dlvCmpNo = $(div.get(0)).val();
		  	var invNo = $(div.get(3)).val();
		  	
		  	$("input[name='ordGdsSeq']").val(ordGdsSeq);//주문상품일련번호
			$("input[name='chgInvNo']").val(invNo);//변경할송장번호
			$("input[name='chgDlvCmpNo']").val(dlvCmpNo);//변경할택배사번호
			
			var frm = document.frm;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/updateOrdGoods'/>";
			
			if(!confirm("배송상태를 변경 하시겠습니까?")) return;
			frm.submit();
			  	
		};
		
		
	/*[s] 추가결제정보 관련 스크립트*/
		//추가결제 입력창 보이기
		$('#btnShowAddPay').click(function() {
			$('#showAddPay2').show();
			$('#showAddPay1').hide();
			$('#txtAddPay').show();
			
		});
		//추가결제 입력창 숨기기
		$('#cancleAddPay').click(function() {
			$('#showAddPay1').show();
			$('#showAddPay2').hide();
			$('#txtAddPay').hide();
			$('#addPayRsn').val(""); 
			
		});
		//추가결제 상세글 보이고 숨기기
		detailAddPayShowHide = function(detailAddPay) {
		 	var detailAddPay = "#"+detailAddPay;
			
			if($(detailAddPay).attr("style").indexOf("none") > -1){
				$(detailAddPay).show();
			}else{
				$(detailAddPay).hide();
			}
		};
		//추가결제등록
		$('#regAddPay').click(function() {
			if(!confirm("추가결제정보를 저장하시겠습니까?")) return;
			var frm = document.frm;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/insertOrderAddPay'/>";
			frm.submit();
		});
		
		//추가결제 수정입력화면 보기, 취소
		updateAddPayShowHide = function(cnt) {
			
			var orgAddPay = $("#orgAddPay"+cnt);//기본 tr 엘레멘트
			var uptAddPay = $("#uptAddPay"+cnt);//수정 tr 엘레멘트
			
			var btnOrgAddPay = $("#btnOrgAddPay"+cnt);//기본(수정, 삭제) 버튼
			var btnUptAddPay = $("#btnUptAddPay"+cnt);//수정(확인, 취소) 버튼
			
			if($(uptAddPay).attr("style").indexOf("none") > -1){
				orgAddPay.hide();//기본 tr 엘레멘트 숨기기
				btnOrgAddPay.hide();//기본버튼 숨기기
				uptAddPay.show();//수정 tr 엘레멘트 보이기
				btnUptAddPay.show();//수정버튼 보이기
			}else{
				uptAddPay.hide();//수정 tr 엘레멘트 숨기기
				btnUptAddPay.hide();//수정버튼숨기기
				orgAddPay.show();//기본 tr 엘레멘트 보이기
				btnOrgAddPay.show();//기본버튼 보이기
			}
		};
		
		//추가결제 수정 실행
		updateAddPay = function(count, addPayNo) {
			var addPayRsn = $("#addPayRsn"+count).val();//수정할 추가결제사유
			var addPayAmt = $("#addPayAmt"+count).val();//수정할 추가결제금액
			
			$("#uptAddPayRsn").val(addPayRsn);//추가결제사유 hidden값에 추가
			$("#uptAddPayAmt").val(addPayAmt);//추가결제금액 hidden값에 추가
			$("#addPayNo").val(addPayNo);//추가결제번호
			
			if(!confirm("추가결제정보를 수정하시겠습니까?")) return;
			
			var frm = document.frm;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/updateOrderAddPay'/>";
			frm.submit();
		};
		
		//추가결제취소
		cancleAddPayProc = function(payNo) {
			if(!confirm("추가결제 취소하시겠습니까?")) return;
			var frm = document.frm;
			frm.payNo.value = payNo;
			frm.payStat.value = "OR00904";//결제상태:취소
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/cancleOrderAddPay'/>";
			frm.submit();
		};
	/*[e] 추가결제정보 관련 스크립트*/
	
	
	/*[s] 주문코멘트정보 관련 스크립트*/
		//메모입력창 보이기
		$('#btnShowRegMemo').click(function() {
			$('#showRegMemo2').show();
			$('#showRegMemo1').hide();
			$('#txtRegMemo').show();
			
		});
		//메모입력창 숨기기
		$('#cancleMemo').click(function() {
			$('#showRegMemo1').show();
			$('#showRegMemo2').hide();
			$('#txtRegMemo').hide();
			$('#memoTxt').val(""); 
		});
		//메모 보이고 숨기기
		detailMemoShowHide = function(detailMemo) {
		 	var detailMemo = "#"+detailMemo;
			
			if($(detailMemo).attr("style").indexOf("none") > -1){
				$(detailMemo).show();
			}else{
				$(detailMemo).hide();
			}
		};
		//메모등록
		$('#regMemo').click(function() {
			var frm = document.frm;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/insertOrderMemo'/>";
			frm.submit();
		});
		//메모삭제
		delMemo = function(memoNo) {
			var frm = document.frm;
			frm.memoNo.value = memoNo;
			frm.target = '_self';
			frm.action = "<c:url value='/admin/order/deleteOrderMemo'/>";
			frm.submit();
		};
	/*[e] 주문코멘트정보 관련 스크립트*/
		
		  //상품 전체체크
	    $("#allCheckOrdGdsSeq").on("click" ,function(){
			if($("#allCheckOrdGdsSeq").is(":checked")) {
				$("input[name=ordGdsSeqs]").prop("checked",true);
			} else {
				$("input[name=ordGdsSeqs]").prop("checked",false);
			}
		});
		  
	    //선택배송
	    $("#choiceDlv").on("click" ,function(){
	    	
	    	if(!$("input[name=ordGdsSeqs]").is(":checked")) {
				alert("변경할 항목을 체크해주세요!");
				return; 
			} 
	    	
	    	var frm = document.frm;
	    	frm.target = '_self';
	        frm.action = "<c:url value='/admin/order/updatePerOrdStat'/>";
	        frm.perOrdStat.value ="OR00504" ;//배송중
	    	if(!confirm("배송중 상태로 변경하시겠습니까?")) return;
	        frm.submit();
		});
	    
	 	//선택상품취소
	    $("#choiceCancle").on("click" ,function(){
	    	
	    	if(!$("input[name=ordGdsSeqs]").is(":checked")) {
				alert("변경할 항목을 체크해주세요!");
				return; 
			} 
	    	
	    	var frm = document.frm;
	        frm.target = '_self';
	        frm.action = "<c:url value='/admin/order/updatePerOrdStat'/>";
	        frm.perOrdStat.value ="OR00507" ;//주문취소
	        if(!confirm("주문취소 상태로 변경하시겠습니까?")) return;
	        frm.submit();
		});
	 	
	    
		//상품 개별진행상태 변경
	    updatePerOrdStat = function(ordGdsSeq, perOrdStat) {
	    	var frm = document.frm;
	    	frm.target = '_self';
	        frm.action = "<c:url value='/admin/order/updatePerOrdStat'/>";
	        frm.ordGdsSeq.value = ordGdsSeq ;//주문상품일련번호
	        frm.perOrdStat.value = perOrdStat ;//진행상태
	        if(!confirm("상태값을 변경하시겠습니까?")) return;
	        frm.submit();
	    };		
		
	});
	</script>
</head>
<body>
<!-- 쿠폰함 레이어 팝업 -->	
<div class="layerWrap">
	<div class="title">
		<h1 class="barcodIn"><div class="title">주문상세내역 – (주문일자 : <fmt:formatDate value="${order.ordDts}" pattern="yyyy.MM.dd" />주문번호 : ${order.ordNo})</div> <!-- <div class="barcode">바코드</div> --></h1>
		<a href="javascript:;" onclick="window.close()">Close</a>
	</div>
	<div class="wrap order">
		<form:form id="frm" name="frm" method="post" modelAttribute="order" onsubmit="return check(form)">
			
			<form:hidden path="ordNo" value="${ordNo}"/><!-- 주문번호 -->
			<form:hidden path="ordrTel" /><!-- 전화번호 -->
			<form:hidden path="ordrCp" /><!-- 핸드폰번호 -->
			
			<form:hidden path="ordGdsSeq" /><!--주문상품일련번호-->
			<form:hidden path="chgUbiGdsSize" /><!-- 변경할상품size -->
			<form:hidden path="chgDlvCmpNo" /><!-- 변경할택배사번호 -->
			<form:hidden path="chgInvNo" /><!-- 변경할송장번호 -->
			
			<form:hidden path="memoNo" /><!-- 메모번호 -->
			<form:hidden path="perOrdStat"/><!-- 개별주문상태 -->
			
			<form:hidden path="payNo" /><!-- 결제번호 -->
			<form:hidden path="addPayNo" /><!-- 추가결제번호 -->
			<form:hidden path="memNo" /><!-- 회원번호 -->
			
			<form:hidden path="uptAddPayRsn" /><!-- 추가결제사유 -->
			<form:hidden path="uptAddPayAmt" /><!-- 추가결제금액 -->
			
			<form:hidden path="payStat" /><!-- 결제상태 -->
			
			<div class="section a1">
				<div class="tableTitle"><span class="icon2"></span>주문정보</div>
				<!--[s]상품정보 리스트 -->
				<div class="tableType1">
					<table>
						<caption>상품 리스트</caption>
						<colgroup>
							<col width="*" />
							<col width="10%" />
							<col width="10%" />
							<col width="15%" />
							<col width="15%" />						
						</colgroup>
						<thead>
							<tr>
								<th>주문상품</th>
								<th>상품바코드</th>
								<th>판매가</th>
								<th>상태</th>
								<th>배송정보</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${order.orderGoods}" var="ordGoods" varStatus="listCount">
								<tr style="height:100px">
									<td class="imgBox">
										<c:if test="${ordGoods.mainImg == null}">
											<img src="${uploadImage }${pageContext.request.contextPath}/resources/common/images/noimages.png" alt="상품이미지" width="50px"/>
											
										</c:if>
										<c:if test="${ordGoods.mainImg != null}">
											<img src="${pageContext.request.contextPath}${uploadImage}${ordGoods.mainImg}" alt="상품이미지" width="50px"/>
										</c:if>	
										[${ordGoods.ubiGdsNo}]<br/>
										[${ordGoods.brand}] <br/>${ordGoods.ubiGdsNm} [${ordGoods.ubiGdsColorNm}] ${ordGoods.ubiGdsSize} <br/>
									</td>
									<td>${ordGoods.barcode}</td>
									<td><fmt:formatNumber type="currency" value="${ordGoods.slPrc}" pattern="###,###" />원</td>
									<td>${ordGoods.perOrdStatNm}</td>
									<td>
										<span class="block">${ordGoods.dlvCmpNm}<br />[${ordGoods.invNo}]</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--[s]상품정보 리스트 -->
				<br/><br/>
				<!--[s]추가결제정보 -->
				<div class="tableTitle"><span class="icon2"></span>추가결제정보</div>
				<div class="tableType1">
					<table class="mb_16">
					<caption>추가결제정보</caption>
					<colgroup>
						<col width="*" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th>사유</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${order.orderAddPay}" var="orderAddPay" varStatus="listCount">
							<tr id="uptAddPay${listCount.count}" style="display:none">
								<td><input type="text" class="ip_tit" id ="addPayRsn${listCount.count}" value="${orderAddPay.addPayRsn}" /></td>
								<td><input type="text" class="ip_tit" id ="addPayAmt${listCount.count}" value="${orderAddPay.addPayAmt}" /></td>
							</tr>
							<tr id="orgAddPay${listCount.count}">
								<td>
									<a href="#none" onclick="detailAddPayShowHide('detailAddPay${listCount.count}'); return false;">
										${fn:substring(orderAddPay.addPayRsn,0,30)} 
										<c:if test="${fn:length(orderAddPay.addPayRsn) > 30}">····</c:if>
									</a>
								</td>
								<td><fmt:formatNumber type="currency" value="${orderAddPay.addPayAmt}" pattern="###,###" />원</td>
							</tr>
							<tr id="detailAddPay${listCount.count}" style="display:none">
								<td colspan="2">
									<p class="coment">${orderAddPay.addPayRsn}</p>
									<div id="btnOrgAddPay${listCount.count}">
										<a href="#none" class="btnType1 comentDel" onclick="cancleAddPayProc('${orderAddPay.payNo}'); return false;">결제취소</a>
										<a href="#none" class="btnType1 comentDel" onclick="updateAddPayShowHide(${listCount.count}); return false;">수정</a>
									</div>
									<div id="btnUptAddPay${listCount.count}" style="display:none">
										<a href="#none" class="btnType1 comentDel" onclick="updateAddPayShowHide(${listCount.count}); return false;">취소</a>
										<a href="#none" class="btnType1 comentDel" onclick="updateAddPay(${listCount.count},${orderAddPay.addPayNo}); return false;">확인</a>
									</div>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(order.orderAddPay) == 0}">
							<tr>
								<td colspan="2">내용이 없습니다.</td>
							</tr>		
						</c:if>
						<tr id="txtAddPay" style="display:none">
							<td><form:input path="addPayRsn" cssClass="ip_tit"/></td>
							<td><form:input path="addPayAmt" cssClass="ip_tit"/>	</td>
						</tr>									
					</tbody>
					</table>
					<div class="btn">
						<div class="right" id="showAddPay1">
							<a href="#none" class="btnType2" id="btnShowAddPay">추가결제등록</a>
						</div>
						<div class="right" id="showAddPay2" style="display:none">
							<a href="#none" class="btnType2" id="regAddPay">등록</a>
							<a href="#none" class="btnType2" id="cancleAddPay">취소</a>
						</div>
					</div>
				</div>
				<!--[e]추가결제정보 -->
				
				<!--[s]결제 정보 -->
				<div class="tableType2 first">
					<table>
						<caption>주문금액</caption>
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<tbody>
							<tr>
								<th>주문금액</th>
								<td>
									<fmt:formatNumber type="currency" value="${order.orderGoods[0].slPrcTot}" pattern="###,###" />원
									<c:set var="varSlPrcTot" value="${order.orderGoods[0].slPrcTot}"/>
								</td>
								<th>배송비<!-- 배송비테이블(실배송비컬럼) 주문1:,주문배송:1,배송비:1--></th>
								<td>
									<fmt:formatNumber type="currency" value="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" pattern="###,###" />원
									<c:set var="varActlDlvCst" value="${order.orderDelivery[0].orderDlvCsts[0].actlDlvCst}" />
								</td>
							</tr>
							<tr>
								<th>합계금액</th>
								<td>
									<fmt:formatNumber type="currency" value="${varSlPrcTot + varActlDlvCst}" pattern="###,###" />원
									<c:set var="varSumAmt" value="${varSlPrcTot + varActlDlvCst}" />
								</td>
								<th>포인트사용<!-- 결제테이블에(결제수단이 적립금) --></th>
								<td>
								<c:forEach items="${order.orderPay}" var="orderPay" varStatus="listCount">
									<c:if test="${orderPay.payWay == 'OR00804'}">
										<fmt:formatNumber type="currency" value="${orderPay.payAmt}" pattern="###,###" />원
										<c:set var="varUsePoint" value="${orderPay.payAmt}" />
									</c:if>
								</c:forEach>
								</td>
							</tr>
							<tr>
								<th>총 결제금액<!-- (합계금액-포인트사용)--></th>
								<td>
									<fmt:formatNumber type="currency" value="${varSumAmt-varUsePoint}" pattern="###,###" />원
								</td>
								<th>적립금액<!-- 주문상품(적립예정포인트) --></th>
								<td>
									<fmt:formatNumber type="currency" value="${order.orderGoods[0].expPntTot}" pattern="###,###" />원
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="tableType2 first">
					<table>
						<caption>결제 정보</caption>
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<tbody>
							<tr>
								<th>E-mail계정</th>
								<td>${order.ordrEmail}</td>
								<th>주문일자</th>
								<td><fmt:formatDate value="${order.ordDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
							</tr>
							<tr>
								<th>결제 정보</th>
								<td colspan="3">
									<c:forEach items="${order.orderPay}" var="orderPay" varStatus="listCount">
										<!--[s] 실시간계좌이체 -->
										<c:forEach items="${orderPay.orderPayRtm}" var="payRtm" varStatus="rtmCount">
											<fmt:formatDate value="${payRtm.regDts}" pattern="yyyy.MM.dd HH:mm:SS" />, <b>계좌이체</b>, [${payRtm.bankName}], <fmt:formatNumber type="currency" value="${payRtm.amount}" pattern="###,###" />원 <br/>
										</c:forEach>
										<!--[e] 실시간계좌이체 -->
											
										<!--[s] 가상계좌 -->
										<c:forEach items="${orderPay.orderPayVrtl}" var="payVrtl" varStatus="vrtlCount">
											<fmt:formatDate value="${payVrtl.regDts}" pattern="yyyy.MM.dd HH:mm:SS" />, <b>가상계좌</b>, [${payVrtl.bankname}], [${payVrtl.account}], <fmt:formatNumber type="currency" value="${payVrtl.amount}" pattern="###,###" />원 <br/>
										</c:forEach>
										<!--[e] 가상계좌 -->
										
										<!--[s] 신용카드 -->
										<c:forEach items="${orderPay.orderPayCrd}" var="payCrd" varStatus="crdCount">
											<fmt:formatDate value="${payCrd.regDts}" pattern="yyyy.MM.dd HH:mm:SS" />, <b>신용카드</b>, ${payCrd.cardName}, <fmt:formatNumber type="currency" value="${payCrd.amount}" pattern="###,###" />원 <br/>
										</c:forEach>
										<!--[e] 신용카드 -->
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--[e]결제 정보 -->
			</div>
			
			<!--[s] 주문자 정보 수정 -->
			<div class="section a2">
				<div class="tableTitle"><span class="icon2"></span> 주문자정보</div>
				<div class="tableType2">
					<table>
						<caption>주문자정보</caption>
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td colspan="3"><form:input path="ordrNm" cssClass="txt_all" value="${order.ordrNm}"/></td>
							</tr>
							<tr>
								<th>전화</th>
								<td>
									<c:set var="varOrdrTel" value="${fn:replace(order.ordrTel,'-','')}"/>
									<input type="text" id="tel1" class="phone" value="${fn:substring(varOrdrTel, 0,  fn:length(varOrdrTel)-8)}" maxlength="3"/> - <input type="text" id="tel2" class="phone" value="${fn:substring(varOrdrTel, fn:length(varOrdrTel)-8,fn:length(varOrdrTel)-4)}" maxlength="4"/> - <input type="text" id="tel3" class="phone" value="${fn:substring(varOrdrTel, fn:length(varOrdrTel)-4,fn:length(varOrdrTel))}" maxlength="4"/>
								</td>
								<th>휴대폰</th>
								<td>
									<c:set var="varOrdrCp" value="${fn:replace(order.ordrCp,'-','')}"/>
									<input type="text" id="cp1" class="phone" value="${fn:substring(varOrdrCp, 0, 3)}" maxlength="3"/> - <input type="text" id="cp2" class="phone" value="${fn:substring(varOrdrCp, 3, 7)}" maxlength="4"/> - <input type="text" id="cp3" class="phone" value="${fn:substring(varOrdrCp, 7, 11)}" maxlength="4"/>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td colspan="3">
									<div class="mb5"><form:input path="post_no" value="${order.ordrZipCd}" id="post_no"/> <a href="#none" class="btnType1" id="openZipCd">우편번호 찾기</a></div>
									<form:input path="address" value="${order.ordrBsAddr}" cssClass="wd_300" id="address" /><form:input path="ordrDtlAddr" value="${order.ordrDtlAddr}" cssClass="wd_300 ml_5"  />
								</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td colspan="3">
									<form:textarea path="dlvSvcMemo" cssClass="txtareaAll" value="${order.dlvSvcMemo}" cols="30" rows="10"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="section btn">
				<a href="#none" class="btnType1" id="btn_uptOrdr">수정</a>
			</div>
			<!--[e] 주문자 정보 수정 -->
			
			<c:if test="${order.orderClm != null}">
			<div class="section a2">		
				<div class="tableTitle"><span class="icon2"></span>클레임 정보</div>
				<div class="tableType1">
					<table>
						<caption>클레임 정보</caption>
						<colgroup>
							<col width="10%">
							<col width="20%">
							<col width="20%">
							<col width="15%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>상품명</th>
								<th>사유</th>
								<th>신청일시</th>
<!-- 								<th>완료일시</th> -->
								<th>상세내용</th>
							</tr>
						</thead>
						<tbody>
								<c:forEach items="${order.orderClm}" var="orderClm" varStatus="listCount">
									<c:forEach items="${orderClm.orderClmGds}" var="orderClmGds" varStatus="listCount">
										<tr>
											<td>${orderClm.clmTpNm }</td>
											<td>${orderClmGds.clmGdsNm }</td>
											<td>${orderClmGds.clmRsnNm}</td>	
											<td><fmt:formatDate value="${orderClm.regDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
<%-- 											<td><fmt:formatDate value="${orderClm.procCmplDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td> --%>
											<td style="text-align:left">
											<c:if test="${orderClm.clmTp =='OR01602' }">
												환불계좌번호 : ${orderClm.rfndAcctNo} <br/>
												환불은행코드 : ${orderClm.rfndBnkNm}<br/>
												환불예금주 : ${orderClm.rfndAcctOwn}											
											</c:if>
											<br/><br/>
											${orderClmGds.clmTxt}
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			</c:if>				
		<%--	
 			<!-- [s]취소클라임 정보 -->
			<c:if test="${order.orderClm != null}">
				<div class="section a2">
					<div class="tableTitle"><span class="icon2"></span> 주문취소내역</div>
					<div class="tableType2">
						<table>
							<caption>주문취소내역</caption>
							<colgroup>
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
							</colgroup>
							<tbody>
								<c:forEach items="${order.orderClm.orderClmGds}" var="orderClm" varStatus="listCount">
								<tr>
									<th>취소상품</th>
									<td colspan="3"></td>
								</tr>
								<tr>
									<th>취소사유</th>
									<td colspan="3">${orderClm.clmRsnNm}</td>
								</tr>
								<tr>
									<th>취소신청</th>
									<td><fmt:formatDate value="${orderClm.regDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
									<th>취소완료</th>
									<td><fmt:formatDate value="${orderClm.procCmplDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			<!-- [e]주문클라임 정보 -->
			
			<!-- [s]교환클라임 정보-->
			<c:if test="${exchangeClm != null}">
				<div class="section a2">
					<div class="tableTitle"><span class="icon2"></span> 주문교환내역</div>
					<div class="tableType2">
						<table>
							<caption>주문교환내역</caption>
							<colgroup>
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
							</colgroup>
							<tbody>
								<c:forEach items="${exchangeClm}" var="orderClm" varStatus="listCount">
								<tr>
									<th>교환상품</th>
									<td colspan="3">[${orderClm.brand}]${orderClm.ubiGdsNm}/${orderClm.ubiGdsColorNm}/${orderClm.ubiGdsSize}/${orderClm.ubiGdsNo}</td>
								</tr>
								<tr>
									<th>교환사유</th>
									<td colspan="3">${orderClm.clmRsnNm}</td>
								</tr>
								<tr>
									<th>교환신청</th>
									<td><fmt:formatDate value="${orderClm.regDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
									<th>교환완료</th>
									<td><fmt:formatDate value="${orderClm.procCmplDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			<!-- [e]교환클라임 정보 -->
			
			<!-- [s]반품클라임 정보 -->
			<c:if test="${takeBackClm != null}">
				<div class="section a2">
					<div class="tableTitle"><span class="icon2"></span> 주문반품내역</div>
					<div class="tableType2">
						<table>
							<caption>주문반품내역</caption>
							<colgroup>
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
								<col width="25%" />
							</colgroup>
							<tbody>
								<c:forEach items="${takeBackClm}" var="orderClm" varStatus="listCount">
								<tr>
									<th>반품상품</th>
									<td colspan="3">[${orderClm.brand}]${orderClm.ubiGdsNm}/${orderClm.ubiGdsColorNm}/${orderClm.ubiGdsSize}/${orderClm.ubiGdsNo}</td>
								</tr>
								<tr>
									<th>반품사유</th>
									<td colspan="3">${orderClm.clmRsnNm}</td>
								</tr>
								<tr>
									<th>반품신청</th>
									<td><fmt:formatDate value="${orderClm.regDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
									<th>반품완료</th>
									<td><fmt:formatDate value="${orderClm.procCmplDts}" pattern="yyyy.MM.dd HH:mm:SS" /></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			<!--[e]반품클라임 정보--> --%>
			
			<!--[s]주문코메트-->
			<div class="section a2">
				<div class="tableType1">
					<table class="mb_16">
					<caption>주문코멘트</caption>
					<colgroup>
						<col width="5%" />
						<col width="*" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th colspan="4" class="th_title">주문코멘트</th>					
						</tr>
						<tr>
							<th>NO</th>
							<th>내용</th>
							<th>작성일</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${order.orderMemo}" var="orderMemo" varStatus="listCount">
							<tr>									
								<td>${listCount.count}</td>
								<td>
									<a href="#none" onclick="detailMemoShowHide('detailMemo${listCount.count}'); return false;">
										${fn:substring(orderMemo.memoTxt,0,30)} 
										<c:if test="${fn:length(orderMemo.memoTxt) > 30}">····</c:if>
									</a>
								</td>
								<td><fmt:formatDate value="${orderMemo.regDts}" pattern="yyyy.MM.dd" /></td>
								<td>${orderMemo.regrNm}</td>
							</tr>
							<tr id="detailMemo${listCount.count}" style="display:none">
								<td colspan="4">
									<p class="coment">${orderMemo.memoTxt}</p>
									<a href="#none" class="btnType1 comentDel" onclick="delMemo('${orderMemo.memoNo}'); return false;">삭제</a>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(order.orderMemo) == 0}">
							<tr>
								<td colspan="4">내용이 없습니다.</td>
							</tr>		
						</c:if>
						<tr id="txtRegMemo" style="display:none">
							<td colspan="4">
								<form:input path="memoTxt" cssClass="ip_tit" maxlength="100"/> 
							</td>
						</tr>									
					</tbody>
					</table>
					<div class="btn">
						<div class="right" id="showRegMemo1">
							<a href="#none" class="btnType2" id="btnShowRegMemo">글쓰기</a>
						</div>
						<div class="right" id="showRegMemo2" style="display:none">
							<a href="#none" class="btnType2" id="regMemo">등록</a>
							<a href="#none" class="btnType2" id="cancleMemo">취소</a>
						</div>
					</div>
				</div>
			</div>				
			<!--[e]주문코메트-->
			
<%-- 			<!--[s]주문상품 정보수정-->
			<div class="section a2">		
				<div class="tableType1">
					<table>
						<caption>주문내역상세</caption>
						<colgroup>
							<col width="3%">
							<!-- <col width="5%"> -->
							<col width="*">
							<col width="9%">
							<col width="18%">
							<col width="25%">
							<col width="7%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="allCheckOrdGdsSeq" name="allCheckOrdGdsSeq" ></th>
							<!-- 	<th>이미지</th> -->
								<th>상품</th>
								<th>판매가</th>
								<th>개별 상품상태</th>
								<th>배송상태</th>
								<th>바코드</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${order.orderGoods}" var="ordGds" varStatus="listCount">
								<tr>
									<c:choose>
										<c:when test="${ordGds.perOrdStat =='OR00501' or ordGds.perOrdStat =='OR00502' or ordGds.perOrdStat =='OR00503'}">
											<td><form:checkbox  path="ordGdsSeqs"  value="${ordGds.ordGdsSeq}" /></td>
										</c:when>
										<c:otherwise>
											<td><input type="checkbox" id="" name="" disabled="disabled"/></td>
										</c:otherwise>
									</c:choose>
									<td><form:checkbox  path="ordGdsSeqs"  value="${ordGds.ordGdsSeq}" /></td>
									<td>
										<c:if test="${ordGds.mainImg == null}">
											<img src="<c:url value='/resources/common/images/noimages.png'/>" alt="상품이미지" width="50px"/>
										</c:if>
										<c:if test="${ordGds.mainImg != null}">
											<img src="<c:url value='${ordGds.mainImg}'/>" alt="상품이미지" width="50px"/>
										</c:if>
									</td>
									<td>
										<p>[${ordGds.brand}]${ordGds.ubiGdsNm} /${ordGds.ubiGdsColorNm} / ${ordGds.ubiGdsSize} / ${ordGds.ubiGdsNo}</p>
										<form:select path="ubiGdsSize">
											<form:option value="">------------- 상품변경 -------------</form:option>
											<form:options items="${ordGds.goodsSizes}" itemLabel="sizeNm" itemValue="sizeNm"/>
										</form:select>
										<a href="#none" class="btnType1" onclick="ordGdsSizeChg(${ordGds.ordGdsSeq}, this); return false;">저장</a>
									</td>
									<td><fmt:formatNumber type="currency" value="${ordGds.slPrc}" pattern="###,###" />원</td>
									<td>
										${ordGds.perOrdStatNm}<br> 
										<c:if test="${ordGds.perOrdStat=='OR00501'}"><!-- 결제대기 -->
											<a href="#none" class="btnType1"  onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00507'); return false;">주문취소</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00502'}"><!-- 결제완료 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00503'); return false;">배송준비</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00506'); return false;">출고지연</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00504'); return false;">배송중</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00507'); return false;">주문취소</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00503'}"><!-- 배송준비 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00506'); return false;">출고지연</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00504'); return false;">배송중</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00507'); return false;">주문취소</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00504'}"><!-- 배송중 -->
											<a href="#none" class="btnType1" onclick="">배송추적</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00505'); return false;">배송완료</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00505'}"><!-- 배송완료 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00508'); return false;">교환신청</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00512'); return false;">반품신청</a>
											<a href="#none" class="btnType1" onclick="">배송추적</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00506'}"><!-- 줄고지연 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00503'); return false;">배송준비</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00504'); return false;">배송중</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00507'); return false;">주문취소</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00507'}"><!-- 주문취소 -->
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00508'}"><!-- 교환신청 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}',''); return false;">상품변경</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00511'); return false;">교환불가</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00509'); return false;">교환진행</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00509'}"><!-- 교환진행 -->
											<a href="#none" class="btnType1" onclick="">배송추적</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00510'); return false;">교환완료</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00510'}"><!-- 교환완료 -->
											<a href="#none" class="btnType1" onclick="">배송추적</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00511'}"><!-- 교환불가 -->
										
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00512'}"><!-- 반품신청 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00513'); return false;">반품처리</a>
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00515'); return false;">반품불가</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00513'}"><!-- 반품진행 -->
											<a href="#none" class="btnType1" onclick="updatePerOrdStat('${ordGds.ordGdsSeq}','OR00507'); return false;">환불처리</a>
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00514'}"><!-- 반품완료 -->
										</c:if>
										<c:if test="${ordGds.perOrdStat=='OR00515'}"><!-- 반품불가 -->
										</c:if>
									</td>
									<td class="tl">
										<div class="float_con">
											배송일자 : <fmt:formatDate value="${ordGds.sndCmplDts}" pattern="yyyy-MM-dd HH:mm:SS" /><br />
											<div class="leftbox">
												<form:select path="dlvCmpNo" cssClass="mb5" id="dlvCmpNo${listCount.count}">
													<form:option value="" >배송업체선택</form:option>
													<form:options items="${orderDlvCmp}" itemLabel="dlvCmpNm" itemValue="dlvCmpNo"/>
												</form:select>
												<script type="text/javascript">$("#dlvCmpNo${listCount.count}").val('${ordGds.dlvCmpNo}');</script>
												<br>
												<form:input path="invNo" value="${ordGds.invNo}" maxlength="20"/>
											</div>
											<div class="leftbox ml10">
												<a href="#none" class="btnType1 btnBig" onclick="ordGdsDlvChg(${ordGds.ordGdsSeq}, this); return false;">저장</a>
											</div>
										</div>
									</td>
									<td>${ordGds.barcode}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="btn">
					<div class="right">
						<!-- <a href="#none" class="btnType2" id="choiceDlv">선택배송</a>
						<a href="#none" class="btnType2" id="choiceCancle">선택취소</a> -->
					</div>
				</div>
			</div>
			<!--[e]주문상품 정보수정--> --%>
			
			<div class="section btn">
				<a href="#none" class="btnType2" id="btn_print">출력하기</a> 
				<a href="#none" class="btnType1" id="btn_close">닫기</a>
			</div>
		</form:form>
	</div>

</div>
<div id="zip_layer" style="display:none;position:absolute;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
	<script>
   // 우편번호 찾기 화면을 넣을 element
   var element_layer = document.getElementById('zip_layer');

   function closeDaumPostcode() {
       // iframe을 넣은 element를 안보이게 한다.
       element_layer.style.display = 'none';
   }

   function execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullAddr = data.address; // 최종 주소 변수
               var extraAddr = ''; // 조합형 주소 변수

               // 기본 주소가 도로명 타입일때 조합한다.
               if(data.addressType === 'R'){
                   //법정동명이 있을 경우 추가한다.
                   if(data.bname !== ''){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있을 경우 추가한다.
                   if(data.buildingName !== ''){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('post_no').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('address').value = fullAddr;
               //document.getElementById('sample2_addressEnglish').value = data.addressEnglish;

               // iframe을 넣은 element를 안보이게 한다.
               // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
               element_layer.style.display = 'none';
           },
           width : '100%',
           height : '100%'
       }).embed(element_layer);
       // iframe을 넣은 element를 보이게 한다.
       element_layer.style.display = 'block';

       // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
       initLayerPosition();
   }

   // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
   // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
   // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
   function initLayerPosition(){
       var width = 600; //우편번호서비스가 들어갈 element의 width
       var height = 220; //우편번호서비스가 들어갈 element의 height
       var borderWidth = 1; //샘플에서 사용하는 border의 두께

   	if(window.innerWidth < 640){
   		width = window.innerWidth - 10;
   	}

       // 위에서 선언한 값들을 실제 element에 넣는다.
       element_layer.style.width = width + 'px';
       element_layer.style.height = height + 'px';
       element_layer.style.border = borderWidth + 'px solid';
       // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
//        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
//        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
       
       element_layer.style.left = '249px';
       element_layer.style.top = '824px';

       /*       
       if(window.innerWidth < 640){
       	$('#zip_layer').css({top: $('#btnPost').offset().top});
       }
       */
   }

   $(window).resize(function(){
   	initLayerPosition();
  	}).resize();
</script>
<!--// 쿠폰함 레이어 팝업 -->
</body>
</html>