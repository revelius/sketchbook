package com.giftiel.shop.dto;

import java.util.List;

public class GiftielViewInput {
	// 쿠폰 View 정보조회 입력 Parameter	
	String CiCode;	//판매사 코드
	String CiPwd;	//판매사 암호
	String CouponCode;	//상품코드
	String CouponNum;	//쿠폰번호
	
	// 다수 쿠폰 상태값 조회 시 추가되는 입력 Parameter
	List CouponList;	//쿠폰 정보 리스트
	
	// 발송 쿠폰 조회 시 추가되는 입력 Parameter
	String HpNum;	//조회할 핸드폰 번호

	
	public String getCiCode() {
		return CiCode;
	}

	public void setCiCode(String ciCode) {
		CiCode = ciCode;
	}

	public String getCiPwd() {
		return CiPwd;
	}

	public void setCiPwd(String ciPwd) {
		CiPwd = ciPwd;
	}

	public String getCouponCode() {
		return CouponCode;
	}

	public void setCouponCode(String couponCode) {
		CouponCode = couponCode;
	}

	public String getCouponNum() {
		return CouponNum;
	}

	public void setCouponNum(String couponNum) {
		CouponNum = couponNum;
	}

	public List getCouponList() {
		return CouponList;
	}

	public void setCouponList(List couponList) {
		CouponList = couponList;
	}

	public String getHpNum() {
		return HpNum;
	}

	public void setHpNum(String hpNum) {
		HpNum = hpNum;
	}
}
