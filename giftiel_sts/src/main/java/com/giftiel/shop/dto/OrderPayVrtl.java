package com.giftiel.shop.dto;

import java.util.Date;

public class OrderPayVrtl {
	
	private Integer payNo;         //결제번호 
	private Integer amount;         //가상계좌결제금액 
	private String bankcode;         //은행코드 
	private String bankname;         //은행명 
	private String account;         //가상계좌번호 
	private String vaDate;         //입금마감일 
	private String appTime;         //계좌발급시간
	private String ordNo;         //주문번호 
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
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getBankcode() {
		return bankcode;
	}
	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getVaDate() {
		return vaDate;
	}
	public void setVaDate(String vaDate) {
		this.vaDate = vaDate;
	}
	public String getAppTime() {
		return appTime;
	}
	public void setAppTime(String appTime) {
		this.appTime = appTime;
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
		return "OrderPayVrtl [payNo=" + payNo + ", amount=" + amount
				+ ", bankcode=" + bankcode + ", bankname=" + bankname
				+ ", account=" + account + ", vaDate=" + vaDate + ", appTime="
				+ appTime + ", regrNo=" + regrNo + ", regDts=" + regDts
				+ ", updrNo=" + updrNo + ", updDts=" + updDts + "]";
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
}
