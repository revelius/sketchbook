package com.giftiel.shop.dto;

import java.util.Date;

public class OrderAddPay {
	
	/*[S]결제*/
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer payNo;         //결제번호 
	private String ordNo;         //주문번호 
	private Integer clmNo;         //클레임번호 
	private Integer cncltgPayno;         //취소대상결제번호 
	private Integer payAmt;         //결제금액 
	private Integer payAmtTot;         //결제금액 합
	private Integer cnclAmt;         //취소금액 
	private String payWay;         //결제수단 
	private String payTp;         //결제유형 
	private Date payDts;         //결제일시 
	private Date payCnclDts;         //결제취소일시 
	private String payStat;         //결제상태 
	private String payStatNm;         //결제상태명
	
	private String ordClmCls;         //주문/클레임 구분 
	private String etc;         //비고 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	/*[E]결제*/
	
	/*[S]추가결제*/
	private Integer addPayNo;         //추가결제번호 
	private String addPayRsn;         //추가결제사유 
	private Integer addPayAmt;         //추가결제금액 
	private Integer memNo;         //회원번호  
	private String nm;         //회원이름
	private String email;         //회원이메일
	
	/*[E]추가결제*/
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public Integer getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(Integer totalCnt) {
		this.totalCnt = totalCnt;
	}
	public Integer getStartListNum() {
		return startListNum;
	}
	public void setStartListNum(Integer startListNum) {
		this.startListNum = startListNum;
	}
	public Integer getEndListNum() {
		return endListNum;
	}
	public void setEndListNum(Integer endListNum) {
		this.endListNum = endListNum;
	}
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
	public Integer getAddPayNo() {
		return addPayNo;
	}
	public void setAddPayNo(Integer addPayNo) {
		this.addPayNo = addPayNo;
	}
	public String getAddPayRsn() {
		return addPayRsn;
	}
	public void setAddPayRsn(String addPayRsn) {
		this.addPayRsn = addPayRsn;
	}
	public Integer getAddPayAmt() {
		return addPayAmt;
	}
	public void setAddPayAmt(Integer addPayAmt) {
		this.addPayAmt = addPayAmt;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPayStatNm() {
		return payStatNm;
	}
	public void setPayStatNm(String payStatNm) {
		this.payStatNm = payStatNm;
	}
	@Override
	public String toString() {
		return "OrderAddPay [rnum=" + rnum + ", totalCnt=" + totalCnt
				+ ", startListNum=" + startListNum + ", endListNum="
				+ endListNum + ", payNo=" + payNo + ", ordNo=" + ordNo
				+ ", clmNo=" + clmNo + ", cncltgPayno=" + cncltgPayno
				+ ", payAmt=" + payAmt + ", payAmtTot=" + payAmtTot
				+ ", cnclAmt=" + cnclAmt + ", payWay=" + payWay + ", payTp="
				+ payTp + ", payDts=" + payDts + ", payCnclDts=" + payCnclDts
				+ ", payStat=" + payStat + ", payStatNm=" + payStatNm
				+ ", ordClmCls=" + ordClmCls + ", etc=" + etc + ", regrNo="
				+ regrNo + ", regDts=" + regDts + ", updrNo=" + updrNo
				+ ", updDts=" + updDts + ", addPayNo=" + addPayNo
				+ ", addPayRsn=" + addPayRsn + ", addPayAmt=" + addPayAmt
				+ ", memNo=" + memNo + ", nm=" + nm + ", email=" + email
				+ ", getRnum()=" + getRnum() + ", getTotalCnt()="
				+ getTotalCnt() + ", getStartListNum()=" + getStartListNum()
				+ ", getEndListNum()=" + getEndListNum() + ", getPayNo()="
				+ getPayNo() + ", getOrdNo()=" + getOrdNo() + ", getClmNo()="
				+ getClmNo() + ", getCncltgPayno()=" + getCncltgPayno()
				+ ", getPayAmt()=" + getPayAmt() + ", getPayAmtTot()="
				+ getPayAmtTot() + ", getCnclAmt()=" + getCnclAmt()
				+ ", getPayWay()=" + getPayWay() + ", getPayTp()=" + getPayTp()
				+ ", getPayDts()=" + getPayDts() + ", getPayCnclDts()="
				+ getPayCnclDts() + ", getPayStat()=" + getPayStat()
				+ ", getOrdClmCls()=" + getOrdClmCls() + ", getEtc()="
				+ getEtc() + ", getRegrNo()=" + getRegrNo() + ", getRegDts()="
				+ getRegDts() + ", getUpdrNo()=" + getUpdrNo()
				+ ", getUpdDts()=" + getUpdDts() + ", getAddPayNo()="
				+ getAddPayNo() + ", getAddPayRsn()=" + getAddPayRsn()
				+ ", getAddPayAmt()=" + getAddPayAmt() + ", getMemNo()="
				+ getMemNo() + ", getNm()=" + getNm() + ", getEmail()="
				+ getEmail() + ", getPayStatNm()=" + getPayStatNm()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
}
