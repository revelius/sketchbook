package com.giftiel.shop.dto;

import java.util.Date;

public class OrderPayRtm {
	
	private Integer payNo;         //결제번호 
	private String bankCode;         //은행코드 
	private String bankName;         //은행명 
	private String appTime;         //결제시각 
	private String cashAuthno;         //현금영수증승인번호 
	private Integer amount;         //계좌이체결제금액
	private String ordNo;         //결제시각
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	public Integer getPayNo() {
		return payNo;
	}
	public void setPayNo(Integer payNo) {
		this.payNo = payNo;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAppTime() {
		return appTime;
	}
	public void setAppTime(String appTime) {
		this.appTime = appTime;
	}
	public String getCashAuthno() {
		return cashAuthno;
	}
	public void setCashAuthno(String cashAuthno) {
		this.cashAuthno = cashAuthno;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getRegrNo() {
		return regrNo;
	}
	public void setRegrNo(Integer regrNo) {
		this.regrNo = regrNo;
	}
	public Date getRegDts() {
		return regDts;
	}
	public void setRegDts(Date regDts) {
		this.regDts = regDts;
	}
	public Integer getUpdrNo() {
		return updrNo;
	}
	public void setUpdrNo(Integer updrNo) {
		this.updrNo = updrNo;
	}
	public Date getUpdDts() {
		return updDts;
	}
	public void setUpdDts(Date updDts) {
		this.updDts = updDts;
	}
	@Override
	public String toString() {
		return "OrderPayAcct [payNo=" + payNo + ", bankCode=" + bankCode
				+ ", bankName=" + bankName + ", appTime=" + appTime
				+ ", cashAuthno=" + cashAuthno + ", amount=" + amount
				+ ", regrNo=" + regrNo + ", regDts=" + regDts + ", updrNo="
				+ updrNo + ", updDts=" + updDts + "]";
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	
}
