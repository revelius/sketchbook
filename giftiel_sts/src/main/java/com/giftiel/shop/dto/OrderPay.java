package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

public class OrderPay {
	
	private List<OrderPayCrd> orderPayCrd;	 //신용카드
	private List<OrderPayRtm> orderPayRtm;	 //실시간계좌이체
	private List<OrderPayVrtl> orderPayVrtl;	 //가상계좌
	
	private Integer payNo;       //결제번호 
	private String ordNo;        //주문번호 
	private Integer clmNo;       //클레임번호 
	private Integer cncltgPayno; //취소대상결제번호 
	private Integer payAmt;      //결제금액 
	private Integer payAmtTot;   //결제금액 합
	private Integer cnclAmt;     //취소금액 
	private String payWay;       //결제수단 
	private String payTp;        //결제유형 
	private Date payDts;         //결제일시 
	private Date payCnclDts;     //결제취소일시 
	private String payStat;      //결제상태 
	private String ordClmCls;    //주문/클레임 구분 
	private String etc;          //비고 
	private Integer regrNo;      //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;      //수정자 
	private Date updDts;         //수정일시
	
	public Integer getPayNo() {
		return payNo;
	}
	public void setPayNo(Integer payNo) {
		this.payNo = payNo;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getClmNo() {
		return clmNo;
	}
	public void setClmNo(Integer clmNo) {
		this.clmNo = clmNo;
	}
	public Integer getCncltgPayno() {
		return cncltgPayno;
	}
	public void setCncltgPayno(Integer cncltgPayno) {
		this.cncltgPayno = cncltgPayno;
	}
	public Integer getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(Integer payAmt) {
		this.payAmt = payAmt;
	}
	public Integer getPayAmtTot() {
		return payAmtTot;
	}
	public void setPayAmtTot(Integer payAmtTot) {
		this.payAmtTot = payAmtTot;
	}
	public Integer getCnclAmt() {
		return cnclAmt;
	}
	public void setCnclAmt(Integer cnclAmt) {
		this.cnclAmt = cnclAmt;
	}
	public String getPayWay() {
		return payWay;
	}
	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	public String getPayTp() {
		return payTp;
	}
	public void setPayTp(String payTp) {
		this.payTp = payTp;
	}
	public Date getPayDts() {
		return payDts;
	}
	public void setPayDts(Date payDts) {
		this.payDts = payDts;
	}
	public Date getPayCnclDts() {
		return payCnclDts;
	}
	public void setPayCnclDts(Date payCnclDts) {
		this.payCnclDts = payCnclDts;
	}
	public String getPayStat() {
		return payStat;
	}
	public void setPayStat(String payStat) {
		this.payStat = payStat;
	}
	public String getOrdClmCls() {
		return ordClmCls;
	}
	public void setOrdClmCls(String ordClmCls) {
		this.ordClmCls = ordClmCls;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
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
	public List<OrderPayCrd> getOrderPayCrd() {
		return orderPayCrd;
	}
	public void setOrderPayCrd(List<OrderPayCrd> orderPayCrd) {
		this.orderPayCrd = orderPayCrd;
	}
	public List<OrderPayRtm> getOrderPayRtm() {
		return orderPayRtm;
	}
	public void setOrderPayRtm(List<OrderPayRtm> orderPayRtm) {
		this.orderPayRtm = orderPayRtm;
	}
	public List<OrderPayVrtl> getOrderPayVrtl() {
		return orderPayVrtl;
	}
	public void setOrderPayVrtl(List<OrderPayVrtl> orderPayVrtl) {
		this.orderPayVrtl = orderPayVrtl;
	}

}
