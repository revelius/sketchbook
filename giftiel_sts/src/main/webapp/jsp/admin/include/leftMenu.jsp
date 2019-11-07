<%-- 
 작성자 : jhr
 작성일 : 2015-04-08
 화면명 : 관리자 환경설정 왼쪽 메뉴 : 추후 기능화 할것임.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


<div class="lnb">
	<c:choose>
		<c:when test="${param.menuFlag == 'setting'}">
			<h3>환경설정</h3>
			<ul class="lnb_ul">
				<li><a href="<c:url value='/admin/setting/storeSetting'/>">상점기본정보관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/setting/storeSetting'/>">상점환경설정</a></li>
					</ul>
				</li>
				<li><a href="<c:url value='/admin/setting/siteSetting'/>">사이트정보관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/setting/siteSetting'/>">사이트환경설정</a></li>
					</ul>
				</li>
				<li><a href="<c:url value='/admin/setting/deliverySetting'/>">전체운영설정</a>
					<ul>
						<li>- <a href="<c:url value='/admin/setting/deliverySetting'/>">배송설정</a></li>
						<li>- <a href="<c:url value='/admin/setting/memberSetting'/>">회원등급관리</a></li>
						<li>- <a href="<c:url value='/admin/setting/pointSetting'/>">포인트설정</a></li>
					</ul>
				</li>
<!-- 				<li><a href="#">상점운영정책</a> -->
<!-- 					<ul> -->
<%-- 						<li>- <a href="<c:url value='/admin/setting/storeManage'/>">상점운영정책</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
			</ul>
		</c:when>
		<c:when test="${param.menuFlag == 'member'}">
			<h3>회원관리</h3>
			<ul class="lnb_ul">
				<li><a href="<c:url value='/admin/member/memberList'/>">회원관리</a>
					<ul>
						<li <c:if test="${param.onChk eq 'memberList' }"> class="on" </c:if> >- <a href="<c:url value='/admin/member/memberList'/>">회원목록</a></li>
						<li  <c:if test="${param.onChk eq 'pointList' }"> class="on" </c:if>  class="last">- <a href="<c:url value='/admin/member/pointList'/>">포인트관리</a></li>
					</ul>
				</li>						
			</ul>
		</c:when>
		<c:when test="${param.menuFlag == 'manage'}">
			<h3>운영관리</h3>
			<ul class="lnb_ul">
				<li><a href="#">고객운영관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/inquiryList'/>">1:1문의관리</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul" <c:if test="${admin_userNo ne '100001'}">style="display: none;"</c:if>>
				<li><a href="#">권한관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/operatorList'/>">부운영자</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">SMS관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/smsManage'/>">문구관리</a></li>
						<li>- <a href="<c:url value='/admin/manage/smsSend'/>">SMS발송</a></li>
						<li>- <a href="<c:url value='/admin/manage/smsSendList'/>">발송내역</a></li>
					</ul>
				</li>						
			</ul>
			
			<ul class="lnb_ul">
				<li><a href="#">메일발송관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/mailSend'/>">메일발송</a></li>
						<li>- <a href="<c:url value='/admin/manage/mailSendList'/>">발송내역</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">메인관리</a>
					<ul>
						<li data-siteNo="10001" style="display: none;">- <a href="<c:url value='/admin/manage/mainManage/10001'/>">WORKSOUT</a></li>
						<li data-siteNo="10002" style="display: none;">- <a href="<c:url value='/admin/manage/mainManage/10002'/>">CARHARTT</a></li>
						<li data-siteNo="10003" style="display: none;">- <a href="<c:url value='/admin/manage/mainManage/10003'/>">OBEY</a></li>
						<li data-siteNo="10004" style="display: none;">- <a href="<c:url value='/admin/manage/mainManage/10004'/>">BRIXTON</a></li>
						<li data-siteNo="10006" style="display: none;">- <a href="<c:url value='/admin/manage/mainManage/10006'/>">DEUS</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">FEATURE관리</a>
					<ul>
						<li data-siteNo="10001" style="display: none;">- <a href="<c:url value='/admin/manage/featureManage/10001'/>">WORKSOUT</a></li>
						<li data-siteNo="10002" style="display: none;">- <a href="<c:url value='/admin/manage/featureManage/10002'/>">CARHARTT</a></li>
						<li data-siteNo="10003" style="display: none;">- <a href="<c:url value='/admin/manage/featureManage/10003'/>">OBEY</a></li>
						<li data-siteNo="10004" style="display: none;">- <a href="<c:url value='/admin/manage/featureManage/10004'/>">BRIXTON</a></li>
						<li data-siteNo="10006" style="display: none;">- <a href="<c:url value='/admin/manage/featureManage/10006'/>">DEUS</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">OnlineShop 전시관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/collaborationList'/>">COLLABORATION</a></li>
						<li>- <a href="<c:url value='/admin/manage/specialList'/>">SPECIAL PRODUCT</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">게시판 관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/newsList'/>">News</a></li>
						<li>- <a href="<c:url value='/admin/manage/lookbookList'/>">Lookbook</a></li>
						<li>- <a href="<c:url value='/admin/manage/workWithUsList'/>">WORK WITH US</a></li>
					</ul>
				</li>						
			</ul>
			<ul class="lnb_ul">
				<li><a href="#">특화메뉴 관리</a>
					<ul>
						<li>- <a href="<c:url value='/admin/manage/carharttRadioList'/>">CARHARTT Radio</a></li>
						<li>- <a href="<c:url value='/admin/manage/obeyAwarenessList'/>">OBEY Awareness</a></li>
					</ul>
				</li>
			</ul>
			
			
			
		</c:when>
		<c:when test="${param.menuFlag == 'goods'}">
			<h3>상품관리</h3>
			<ul class="lnb_ul">
<!-- 				<li><a href="#">카테고리관리</a> -->
<!-- 					<ul> -->
<%-- 						<li <c:if test="${param.onChk == 'goodsCate'}"> class=on</c:if>>- <a href="#">상품카테고리관리</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
				<li><a href="#">시즌 설정관리</a>
					<ul>
						<li <c:if test="${param.onChk == 'seasonConfig'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/seasonConfig'/>">시즌 설정</a></li>
					</ul>
				</li>
				<li><a href="#">카테고리관리</a>
					<ul>
						<li <c:if test="${param.onChk == 'categoryConfig'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/categoryConfig'/>">상품카테고리관리</a></li>
					</ul>
				</li>
				<li><a href="#">상품관리</a>
					<ul>
						<!-- <li>- <a href="#">상품등록</a></li> -->
						<%-- <li <c:if test="${param.onChk == 'goodsIcon'}"> class=on</c:if>>- <a href="#">상품 아이콘 관리</a></li> --%>
						<li <c:if test="${param.onChk == 'goodsList'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/goodsList'/>">상품목록</a></li>
						<li <c:if test="${param.onChk == 'goodsDisplay'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/goodsDisplay'/>">상품진열설정</a></li>
<%-- 						<li <c:if test="${param.onChk == 'goodsDisplayNew'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/goodsDisplayNew'/>">상품진열설정[NEW]</a></li> --%>
						<%-- <li <c:if test="${param.onChk == 'goodsGarbage'}"> class=on</c:if>>- <a href="#">상품휴지통</a></li> --%>
						<li <c:if test="${param.onChk == 'saveGoodsExcel'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/saveGoodsExcel'/>">상품 엑셀 일괄 등록</a></li>
					</ul>
				</li>
				<li><a href="#">상품정보고시 관리</a>
					<ul>
						<li <c:if test="${param.onChk == 'goodsAddInfo'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/goodsAddInfoGrpList'/>">상품정보고시 관리</a></li>
						<li <c:if test="${param.onChk == 'goodsAddInfoExcel'}"> class=on</c:if>>- <a href="<c:url value='/admin/goods/goodsAddInfoGrpExcel'/>">상품정보고시 일괄 등록</a></li>
					</ul>
				</li>
<!-- 				<li><a href="#">쿠폰 관리</a> -->
<!-- 					<ul> -->
<%-- 						<li >- <a href="<c:url value='/admin/goods/couponConfig'/>">쿠폰 관리</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
			</ul>
		</c:when>		
		<c:when test="${param.menuFlag == 'order'}">
			<h3>주문매출관리</h3>
				<ul class="lnb_ul">
					<li><a href="#">전체주문</a>
						<ul>
							<li <c:if test="${param.onChk == 'orderList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=order'/>">전체주문</a></li>
						</ul>
					</li>		
					<li><a href="#">주문관리</a>
						<ul>
<%-- 							<li <c:if test="${param.onChk == 'shipList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=wait'/>">결제대기</a></li> --%>
							<li <c:if test="${param.onChk == 'shipList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=ship'/>">배송관리</a></li>
							<li <c:if test="${param.onChk == 'invNoList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=invNo'/>">송장등록</a></li>
							<!-- <li <c:if test="${param.onChk == 'buyList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=buy'/>">구매확정</a></li> -->
						</ul>
					</li>		
					<li><a href="#">취소/교환/반품신청관리</a>
						<ul>
							<li <c:if test="${param.onChk == 'cancleList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=cancle'/>">취소관리</a></li>
							<li <c:if test="${param.onChk == 'exchangeList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=exchange'/>">교환관리</a></li>
							<li <c:if test="${param.onChk == 'takeBackList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=takeBack'/>">반품관리</a></li>
						</ul>			
					</li>	
					<li><a href="#">추가결제관리</a>
						<ul>
							<li <c:if test="${param.onChk == 'addBuyList'}"> class=on</c:if>>- <a href="<c:url value='/admin/order/orderList?ordKnd=addBuy'/>">추가결제관리</a></li>
						</ul>
					</li>					
				</ul>
		</c:when>
		<c:when test="${param.menuFlag == 'static' }">
			<h3>통계/분석</h3>
			<ul class="lnb_ul">
				<li><a href="#">매출통계</a>
					<ul>
						<li>- <a href="<c:url value='/admin/statistics/salesGraphStatistics'/>">전체매출통계</a></li>
						<li>- <a href="<c:url value='/admin/statistics/salesProductStatistics'/>">상품별매출통계</a></li>
						<li>- <a href="<c:url value='/admin/statistics/memStatistics'/>">회원별매출통계</a></li>
					</ul>
				</li>
				<li><a href="#">회원통계</a>
					<ul>
						<li>- <a href="<c:url value='/admin/statistics/genderStatistics'/>">남녀비율통계</a></li>
						<li>- <a href="<c:url value='/admin/statistics/ageStatistics'/>">연령대별통계</a></li>
						<li>- <a href="<c:url value='/admin/statistics/residenceStatistics'/>">거주지별통계</a></li>
					</ul>
				</li>
				<li><a href="#">접속통계</a>
					<ul>
						<li>- <a href="<c:url value='/admin/statistics/visitantStatistics'/>">방문자접속통계</a></li>
						<li>- <a href="<c:url value='/admin/statistics/contactStatistics/All'/>">접속방향통계</a></li>
					</ul>
				</li>
				<li><a href="#">상품통계</a>
					<ul>
						<li>- <a href="<c:url value='/admin/statistics/goodsProductStatistics'/>">상품별통계</a></li>
					</ul>
				</li>
				<li><a href="#">마케팅통계</a>
					<ul>
						<li>- <a href="<c:url value='/admin/statistics/savingStatistics'/>">적립금사용통계</a></li>
					</ul>
				</li>
			</ul>
		</c:when>	
	</c:choose>
</div>
<script type="text/javascript">
    	
    	//가지고 있는 권한의 브랜드만 보여줌
	    var authSite = "${admin_siteAuthNo}";
	    var authSiteList = authSite.split(",");
	    for(var i=0;i<authSiteList.length;i++){
	    	$("[data-siteNo="+authSiteList[i]+"]").show();
	    }
</script>
