package com.giftiel.shop.common;

/**
 * 업무별 코드 상수로 지정.
 * 
 * @author kwon yong jae
 *
 */
public class Constants {
	//카테고리
	public static String CATE_GUBUN_BRDDEPTH = "BRAND"; // 카테고리 코드 구분 브랜드
	public static String CATE_GUBUN_1DEPTH = "SEASON"; // 카테고리 코드 구분 1depth
	public static String CATE_GUBUN_2DEPTH = "CATEGORY1"; // 카테고리 코드 구분 2depth
	public static String CATE_GUBUN_3DEPTH = "CATEGORY2"; // 카테고리 코드 구분 3depth

	public static String BRWS_CLS = "CM009"; // 브라우저구분 PC, MOBILE
	public static String BRWS_CLS_PC = "CM00901"; // PC
	public static String BRWS_CLS_MOBILE = "CM00902"; // MOBILE

	//상품
	public static String GDS_STAT = "GD004"; // 상품상태
	public static String GDS_STAT_CONFRIM_STANDBY = "GD00401"; //승인대기
	//public static String GDS_STAT_CONFIRM_RETURN = "GD00402";	//승인반려
	public static String GDS_STAT_SALE = "GD00402"; //판매중
	public static String GDS_STAT_SALE_CLOSE = "GD00403"; //판매중지
	public static String GDS_STAT_SOLD_OUT = "GD00404"; //품절
	public static String GDS_STAT_DELETE = "GD00405"; //삭제

	public static String SL_TERM_CLS = "GD005"; // 판매기간구분
	public static String SL_TERM_CLS_ALL = "GD00501"; // 판매기간구분
	public static String SL_TERM_CLS_PERIOD = "GD00502"; // 판매기간구분

	//적립금 사유
	public static String RSV_RSN_CODE = "MT002";
	public static String RSV_RSN_CODE_ORDER = "MT00201"; //상품 구매
	public static String RSV_RSN_CODE_AD_PAY = "MT00202"; //관리자 지급
	public static String RSV_RSN_CODE_EVENT = "MT00203"; //이벤트
	public static String RSV_RSN_CODE_BIRTHDAY = "MT00204"; //생일

	//주문
	public static String ORD_STAT = "OR002";// 주문상태
	public static String ORD_STAT_TEMP = "OR00201";// 결제전
	public static String ORD_STAT_STAND = "OR00202";// 입금대기중
	public static String ORD_STAT_COMPLETE = "OR00203";// 결제완료
	public static String ORD_STAT_CANCEL = "OR00204";// 주문취소

	public static String PER_ORD_STAT = "OR005";// 개별주문상태
	public static String PER_ORD_STAT_PAYSTAY = "OR00501";// 결제대기
	public static String PER_ORD_STAT_PAY_COMPL = "OR00502";// 결제완료
	public static String PER_ORD_STAT_PREPAR_PROD = "OR00503";// 상품준비중
	public static String PER_ORD_STAT_SEND_COMPL = "OR00504";// 발송완료
	public static String PER_ORD_STAT_SHIPP_COMPL = "OR00505";// 배송완료
	public static String PER_ORD_STAT_DELIV_DELAY = "OR00506";// 출고지연
	public static String PER_ORD_STAT_ORDER_CANCEL = "OR00507";// 주문취소
	public static String PER_ORD_STAT_CHANGE_APPLY = "OR00508";// 교환신청
	public static String PER_ORD_STAT_CHANGE_GOING = "OR00509";// 교환진행
	public static String PER_ORD_STAT_CHANGE_COMPL = "OR00510";// 교환완료
	public static String PER_ORD_STAT_CHANGE_DONOT = "OR00511";// 교환불가
	public static String PER_ORD_STAT_RETURN_APPLY = "OR00512";// 반품신청
	public static String PER_ORD_STAT_RETURN_GOING = "OR00513";// 반품진행
	public static String PER_ORD_STAT_RETURN_COMPL = "OR00514";// 반품완료
	public static String PER_ORD_STAT_RETURN_DONOT = "OR00515";// 반품불가

	public static String ORD_CLM_CLS = "OR006";// 주문/클레임 구분
	public static String PAY_TP = "OR007";// 결제유형
	public static String PAY_WAY = "OR008"; //결제수단
	public static String PAY_WAY_ONLY_POINT = "OR00800"; //포인트로만 결제
	public static String PAY_WAY_RTM = "OR00802"; //실시간계좌이체
	public static String PAY_WAY_CARD = "OR00801"; //신용카드
	public static String PAY_WAY_VTM = "OR00803"; //가상계좌
	public static String PAY_WAY_RSV = "OR00804"; //적립금
	public static String PAY_WAY_COUPON = "OR00805"; //쿠폰

	public static String PAY_STAT = "OR009";// 결제상태
	public static String DLV_CST_PAYWAY = "OR011"; // 배송비 지불 방식
	public static String DLV_CST_PAYWAY_FREE = "OR01101"; // 무료
	public static String DLV_CST_PAYWAY_CASE = "OR01102"; // 조건
	public static String DLV_CST_PAYWAY_FIX = "OR01103"; // 고정

	public static String DLV_CST_TP = "OR013";// 배송비유형
	public static String FREE_DLVRSN_CD = "OR014"; //무료배송비사유코드
	public static String CLM_TP = "OR016";//클레임유형
	public static String CLM_TP_DEPO_BEFORECANCEL = "OR01601";//클레임유형:입금전취소
	public static String CLM_TP_RETURN = "OR01602";//클레임유형:반품
	public static String CLM_TP_RESHIPP = "OR01603";//클레임유형:재배송
	public static String CLM_TP_CHANGE = "OR01604";//클레임유형:교환
	public static String CLM_TP_DEPO_AFTERCANCEL = "OR01605";//클레임유형:입금후 취소

	public static String CLM_STAT = "OR017";//클레임상태
	public static String CLM_STAT_APPLY = "OR01701";//클레임상태:접수
	public static String CLM_STAT_COMPL = "OR01702";//클레임상태:완료
	public static String CLM_STAT_CANCEL = "OR01703";//클레임상태:취소

	public static String CLM_RSN_CD = "OR018";//클레임사유코드
	public static String CLM_RSN_CD_CHANGE_MIND = "OR01801";//클레임사유코드 : 고객변심
	public static String CLM_RSN_CD_DEFECTIVE_PROD = "OR01802";//클레임사유코드 : 상품불량
	public static String CLM_RSN_CD_INFO_DIFF = "OR01803";//클레임사유코드 : 정보상이
	public static String CLM_RSN_CD_SHIPPING = "OR01804";//클레임사유코드 : 오배송
	public static String CLM_RSN_CD_ETC = "OR01805";//클레임사유코드 : 기타
	public static String CLM_GDS_STAT = "OR019";//클레임상품상태
	public static String CLM_GDS_STAT_APPLY = "OR01901"; //클레임 상품 상태 : 접수
	public static String CLM_GDS_STAT_check = "OR01902"; //클레임 상품 상태 : 접수확인
	public static String CLM_GDS_STAT_WAREHOUSING = "OR01903"; //클레임 상품 상태 : 교환입고/맞교환출고
	public static String CLM_GDS_STAT_COMP = "OR01904"; //클레임 상품 상태 : 완료
	public static String CLM_GDS_STAT_CANCEL = "OR01905"; //클레임 상품 상태 : 취소
	public static String CLM_FLT_CD = "OR020";//클레임귀책코드

	//뉴스-게시물 유형
	public static String NEWS_TYPE_CODE = "CM004"; //뉴스-게시물 유형
	public static String NEWS_TYPE_CODE_NOTICE = "CM00401"; //NOTICE
	public static String NEWS_TYPE_CODE_JOURNAL = "CM00402"; //JOURNAL
	public static String NEWS_TYPE_CODE_FEATURE = "CM00403"; //FEATURE
	public static String NEWS_TYPE_CODE_SNAPSHOT = "CM00404"; //SNAPSHOT

	//뉴스-게시물 구분
	public static String NEWS_CLS_CODE = "CM005"; //뉴스-게시물 구분
	public static String NEWS_CLS_CODE_IMG = "CM00501"; //이미지
	public static String NEWS_CLS_CODE_VIDEO = "CM00502"; //동영상

	public static String PNT_RSV_CLS = "MT001"; //포인트 지급 정책
	public static String PNT_RSV_CLS_NONE = "MT00101"; // 지급안함
	public static String PNT_RSV_CLS_MEMLV = "MT00102"; // 회원등급
	public static String PNT_RSV_CLS_SLPRC = "MT00103"; // 판매가%
	public static String PNT_RSV_CLS_PAYAMT = "MT00104"; // 결제가%

	public static String NOT_PG_MODULES = "OR00503, OR00505, OR00506, OR00508, OR00509, OR00510, OR00511, OR00512, OR00513, OR00515"; //PG모듈 안태우는 상태코드

	public static String BANK_CODE = "CM003";//은행코드

	public static String WORKSOUT_SITE_CODE = "10001";
	public static String CARHARTT_SITE_CODE = "10002";
	public static String OBEY_SITE_CODE = "10003";
	public static String BRIXTON_SITE_CODE = "10004";
	public static String LEXDRAY_SITE_CODE = "10005";
	public static String DEUS_SITE_CODE = "10006";
	public static String B2B_SITE_CODE = "10006";

	public static String[] interceptorEgnoreUrl = { "/header", "/snbShop", "/snbShop", "ajax", "Ajax", "Login", "login" };

	public static String BRAND = "CM013";

	public static String CATE_SEASON_GUBUN_CODE = "CM014";
	public static String CATE_SEASON_GUBUN_CODE_1 = "CM01401"; // 시즌1
	public static String CATE_SEASON_GUBUN_CODE_2 = "CM01402"; // 시즌2
	public static String CATE_SEASON_GUBUN_CODE_OUTLET = "CM01403"; // OUTLET

	public static String CATE1_GUBUN_CODE = "CM015";
	public static String CATE1_GUBUN_CODE_MEN = "CM01501"; // MEN
	public static String CATE1_GUBUN_CODE_WOMEN = "CM01502"; // WOMEN
	public static String CATE1_GUBUN_CODE_BRAND = "CM01503"; // BRAND

	public static String DC_WAY = "CM002";
	public static String DC_WAY_FIX = "CM00201";
	public static String DC_WAY_PER = "CM00202";

	public static String CPN_KND = "MT003"; //쿠폰종류
	public static String CPN_KND_GOODS = "MT00301"; // 상품할인쿠폰
	public static String CPN_KND_CART = "MT00302"; // 장바구니할인쿠폰
	public static String CPN_KND_SHIPPING = "MT00303"; // 배송비무료쿠폰

	public static String ISS_WAY = "MT007"; //발급방식
	public static String ISS_WAY_ACCOUNT = "MT00701"; // 계정발급
	public static String ISS_WAY_DOWNLOAD = "MT00702"; // 다운로드
	public static String ISS_WAY_OFFLINE = "MT00703"; // 오프라인쿠폰

	//	public static String  DC_WAY  = "CM002"; //할인방식
	//		public static String  DC_WAY_AMT  = "CM00201"; // 정액
	//		public static String  DC_WAY_PERCENT  = "CM00202"; // 정률

	public static String VLD_TERM_CLS = "MT004"; //유효기간구분
	public static String VLD_TERM_CLS_1 = "MT00401"; // 기간
	public static String VLD_TERM_CLS_2 = "MT00402"; // 발급일 + 일수

	public static String CPN_STAT = "MT005"; //쿠폰상태
	public static String CPN_STAT_STAND_BY = "MT00501"; // 대기
	public static String CPN_STAT_PROCEED = "MT00502"; // 진행
	public static String CPN_STAT_ISS_STOP = "MT00503"; // 발급중단
	public static String CPN_STAT_USE_STOP = "MT00504"; // 발급사용중단
	public static String CPN_STAT_DELETE = "MT00505"; // 삭제

	public static String MODE_ADMIN = ""; // "_bootstrap" or ""
}
