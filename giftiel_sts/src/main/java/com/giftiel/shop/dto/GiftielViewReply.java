package com.giftiel.shop.dto;

import java.util.List;

public class GiftielViewReply {
	
	// 쿠폰 View 정보조회 회신 데이터
	String ResultCode;	//Api 처리 결과 코드
	String ResultMsg;	//Api 처리 결과 메시지
	String CouponImageUrl;	//쿠폰이미지 경로( Url )
	String CiName;	//브랜드명
	String DayEnd;	//효기간 종료일( format : yyyy-MM-dd )
	String CnPrice;	//비자가격
	String CcLimit;	//이용안내
	String CcArea;	//사용장소
	String CiCsTel;	//객센터번호
	String AddMsg;	//추가 안내 메시지
	String CcSelPrice;	//판매가격
	String CnName;	//상품명
	String MemoRefund;	//환불조건
	String CnNote;	//상품설명
	String CcTerm;	//상품의 유효기간 일자( ex. 60의 경우 발급일로부터 60일 )
	String MemoEndday;	//상품의 유효기간( 상품고시정보 )
	String DayStart;	//유효기간 시작일( yyyy-MM-dd )
	String CcAdjPrice;	//제공단가
	String CiImageUrl;	//상세화면 상품이미지 경로(Url)
	
	// 단일,다중 쿠폰 상태값 조회 시 추가되는 회신 데이터
	String CouponNum;	//쿠폰번호
	String AccountYn;	//쿠폰의 발급상태 ( Y – 정상발급, C – 발급취소 )
	String SendGubun;	//쿠폰의 발급구분 ( B – BtoB, C – BtoC, O – 온라인몰)
	String UseYn;	//쿠폰의 사용상태 ( Y – 사용, N – 미사용)
	String UseDate;	//사용일자 format( yyyy-MM-dd HH:mm:ss )
	String BiName;	//사용매장명
	String IsCancel;	//쿠폰취소 가능여부( Y – 가능, N – 불가능 )
	String CouponType;	//00:교환권,할인권 -02 : 금액권
	String CouponBalance;	//쿠폰잔액
	String BalChkUrl;	//잔액조회 URL

	// 단일 쿠폰 승인 이력 조회 시 추가되는 회신 데이터
	String ListCount;	//이력건수
	List AuthList;	//승인이력 리스트
	
	// 발송 쿠폰 조회 시 추가되는 회신 데이터
	String Count;	//핸드폰 번호로 발송한 쿠폰개수
	List CouponList;	//사용 가능한 쿠폰 정보 리스트
	
	
	public String getResultCode() {
		return ResultCode;
	}
	public void setResultCode(String resultCode) {
		ResultCode = resultCode;
	}
	public String getResultMsg() {
		return ResultMsg;
	}
	public void setResultMsg(String resultMsg) {
		ResultMsg = resultMsg;
	}
	public String getCouponImageUrl() {
		return CouponImageUrl;
	}
	public void setCouponImageUrl(String couponImageUrl) {
		CouponImageUrl = couponImageUrl;
	}
	public String getCiName() {
		return CiName;
	}
	public void setCiName(String ciName) {
		CiName = ciName;
	}
	public String getDayEnd() {
		return DayEnd;
	}
	public void setDayEnd(String dayEnd) {
		DayEnd = dayEnd;
	}
	public String getCnPrice() {
		return CnPrice;
	}
	public void setCnPrice(String cnPrice) {
		CnPrice = cnPrice;
	}
	public String getCcLimit() {
		return CcLimit;
	}
	public void setCcLimit(String ccLimit) {
		CcLimit = ccLimit;
	}
	public String getCcArea() {
		return CcArea;
	}
	public void setCcArea(String ccArea) {
		CcArea = ccArea;
	}
	public String getCiCsTel() {
		return CiCsTel;
	}
	public void setCiCsTel(String ciCsTel) {
		CiCsTel = ciCsTel;
	}
	public String getAddMsg() {
		return AddMsg;
	}
	public void setAddMsg(String addMsg) {
		AddMsg = addMsg;
	}
	public String getCcSelPrice() {
		return CcSelPrice;
	}
	public void setCcSelPrice(String ccSelPrice) {
		CcSelPrice = ccSelPrice;
	}
	public String getCnName() {
		return CnName;
	}
	public void setCnName(String cnName) {
		CnName = cnName;
	}
	public String getMemoRefund() {
		return MemoRefund;
	}
	public void setMemoRefund(String memoRefund) {
		MemoRefund = memoRefund;
	}
	public String getCnNote() {
		return CnNote;
	}
	public void setCnNote(String cnNote) {
		CnNote = cnNote;
	}
	public String getCcTerm() {
		return CcTerm;
	}
	public void setCcTerm(String ccTerm) {
		CcTerm = ccTerm;
	}
	public String getMemoEndday() {
		return MemoEndday;
	}
	public void setMemoEndday(String memoEndday) {
		MemoEndday = memoEndday;
	}
	public String getDayStart() {
		return DayStart;
	}
	public void setDayStart(String dayStart) {
		DayStart = dayStart;
	}
	public String getCcAdjPrice() {
		return CcAdjPrice;
	}
	public void setCcAdjPrice(String ccAdjPrice) {
		CcAdjPrice = ccAdjPrice;
	}
	public String getCiImageUrl() {
		return CiImageUrl;
	}
	public void setCiImageUrl(String ciImageUrl) {
		CiImageUrl = ciImageUrl;
	}
	public String getCouponNum() {
		return CouponNum;
	}
	public void setCouponNum(String couponNum) {
		CouponNum = couponNum;
	}
	public String getAccountYn() {
		return AccountYn;
	}
	public void setAccountYn(String accountYn) {
		AccountYn = accountYn;
	}
	public String getSendGubun() {
		return SendGubun;
	}
	public void setSendGubun(String sendGubun) {
		SendGubun = sendGubun;
	}
	public String getUseYn() {
		return UseYn;
	}
	public void setUseYn(String useYn) {
		UseYn = useYn;
	}
	public String getUseDate() {
		return UseDate;
	}
	public void setUseDate(String useDate) {
		UseDate = useDate;
	}
	public String getBiName() {
		return BiName;
	}
	public void setBiName(String biName) {
		BiName = biName;
	}
	public String getIsCancel() {
		return IsCancel;
	}
	public void setIsCancel(String isCancel) {
		IsCancel = isCancel;
	}
	public String getCouponType() {
		return CouponType;
	}
	public void setCouponType(String couponType) {
		CouponType = couponType;
	}
	public String getCouponBalance() {
		return CouponBalance;
	}
	public void setCouponBalance(String couponBalance) {
		CouponBalance = couponBalance;
	}
	public String getBalChkUrl() {
		return BalChkUrl;
	}
	public void setBalChkUrl(String balChkUrl) {
		BalChkUrl = balChkUrl;
	}
	public String getListCount() {
		return ListCount;
	}
	public void setListCount(String listCount) {
		ListCount = listCount;
	}
	public List getAuthList() {
		return AuthList;
	}
	public void setAuthList(List authList) {
		AuthList = authList;
	}
	public String getCount() {
		return Count;
	}
	public void setCount(String count) {
		Count = count;
	}
	public List getCouponList() {
		return CouponList;
	}
	public void setCouponList(List couponList) {
		CouponList = couponList;
	}
}
