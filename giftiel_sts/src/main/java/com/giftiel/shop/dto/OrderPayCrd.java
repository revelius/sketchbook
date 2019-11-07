package com.giftiel.shop.dto;

import java.util.Date;

public class OrderPayCrd {
	
	private Integer payNo;         //결제번호 
	private String cardCd;         //카드발급사코드 
	private String cardName;         //카드발급사명 
	private String cardNo;         //카드번호 
	private String appNo;         //승인번호 
	private String appTime;         //승인시간 
	private String noinf;         //무이자여부 
	private String quota;         //할부기간 
	private Integer amount;         //카드결제금액 
	private String partcancYn;         //부분취소가능여부 
	private String cardBinType01;         //카드구분정보1 
	private String cardBinType02;         //카드구분정보2
	private String ordNo;         //카드구분정보2
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
	public String getCardCd() {
		return cardCd;
	}
	public void setCardCd(String cardCd) {
		this.cardCd = cardCd;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getAppNo() {
		return appNo;
	}
	public void setAppNo(String appNo) {
		this.appNo = appNo;
	}
	public String getAppTime() {
		return appTime;
	}
	public void setAppTime(String appTime) {
		this.appTime = appTime;
	}
	public String getNoinf() {
		return noinf;
	}
	public void setNoinf(String noinf) {
		this.noinf = noinf;
	}
	public String getQuota() {
		return quota;
	}
	public void setQuota(String quota) {
		this.quota = quota;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getPartcancYn() {
		return partcancYn;
	}
	public void setPartcancYn(String partcancYn) {
		this.partcancYn = partcancYn;
	}
	public String getCardBinType01() {
		return cardBinType01;
	}
	public void setCardBinType01(String cardBinType01) {
		this.cardBinType01 = cardBinType01;
	}
	public String getCardBinType02() {
		return cardBinType02;
	}
	public void setCardBinType02(String cardBinType02) {
		this.cardBinType02 = cardBinType02;
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
		return "OrderPayCrd [payNo=" + payNo + ", cardCd=" + cardCd
				+ ", cardName=" + cardName + ", cardNo=" + cardNo + ", appNo="
				+ appNo + ", appTime=" + appTime + ", noinf=" + noinf
				+ ", quota=" + quota + ", amount=" + amount + ", partcancYn="
				+ partcancYn + ", cardBinType01=" + cardBinType01
				+ ", cardBinType02=" + cardBinType02 + ", regrNo=" + regrNo
				+ ", regDts=" + regDts + ", updrNo=" + updrNo + ", updDts="
				+ updDts + ", getPayNo()=" + getPayNo() + ", getCardCd()="
				+ getCardCd() + ", getCardName()=" + getCardName()
				+ ", getCardNo()=" + getCardNo() + ", getAppNo()=" + getAppNo()
				+ ", getAppTime()=" + getAppTime() + ", getNoinf()="
				+ getNoinf() + ", getQuota()=" + getQuota() + ", getAmount()="
				+ getAmount() + ", getPartcancYn()=" + getPartcancYn()
				+ ", getCardBinType01()=" + getCardBinType01()
				+ ", getCardBinType02()=" + getCardBinType02()
				+ ", getRegrNo()=" + getRegrNo() + ", getRegDts()="
				+ getRegDts() + ", getUpdrNo()=" + getUpdrNo()
				+ ", getUpdDts()=" + getUpdDts() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
}
