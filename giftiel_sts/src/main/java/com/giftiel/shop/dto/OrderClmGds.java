package com.giftiel.shop.dto;

import java.util.Date;


public class OrderClmGds {
	private Integer clmGdsSeq;         //클레임상품일련번호
	private Integer clmNo;         //클레임번호 
	private String ordNo;         //주문번호 
	private Integer ordGdsSeq;         //주문상품일련번호 
	private Integer ordDlvNo;         //주문배송번호 
	private Integer clmQty;         //클레임수량 
	private String clmRsnCd;         //클레임사유코드 
	private String clmTxt;         //클레임내용 
	private Date inCmplDt;         //입고완료일자 
	private String invNo;         //송장번호 
	private Date sndCplDt;         //발송완료일자 
	private String clmGdsStat;         //클레임상품상태 
	private Integer dlvCmpNo;         //택배사번호 
	private Date acptDts;         //접수확인일시 
	private Integer acptUsrNo;         //접수확인자 
	private String mngrMemo;         //관리자메모 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	private String clmRsnNm;         //클레임사유명
	private String dlvCmpNm;         //택배사명
	
	private String clmGdsNm;         //클레임상품명
	
	
	
	public String getDlvCmpNm() {
		return dlvCmpNm;
	}
	public void setDlvCmpNm(String dlvCmpNm) {
		this.dlvCmpNm = dlvCmpNm;
	}
	public String getClmRsnNm() {
		return clmRsnNm;
	}
	public void setClmRsnNm(String clmRsnNm) {
		this.clmRsnNm = clmRsnNm;
	}
	public Integer getClmGdsSeq() {
		return clmGdsSeq;
	}
	public void setClmGdsSeq(Integer clmGdsSeq) {
		this.clmGdsSeq = clmGdsSeq;
	}
	public Integer getClmNo() {
		return clmNo;
	}
	public void setClmNo(Integer clmNo) {
		this.clmNo = clmNo;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getOrdGdsSeq() {
		return ordGdsSeq;
	}
	public void setOrdGdsSeq(Integer ordGdsSeq) {
		this.ordGdsSeq = ordGdsSeq;
	}
	public Integer getOrdDlvNo() {
		return ordDlvNo;
	}
	public void setOrdDlvNo(Integer ordDlvNo) {
		this.ordDlvNo = ordDlvNo;
	}
	public Integer getClmQty() {
		return clmQty;
	}
	public void setClmQty(Integer clmQty) {
		this.clmQty = clmQty;
	}
	public String getClmRsnCd() {
		return clmRsnCd;
	}
	public void setClmRsnCd(String clmRsnCd) {
		this.clmRsnCd = clmRsnCd;
	}
	public String getClmTxt() {
		return clmTxt;
	}
	public void setClmTxt(String clmTxt) {
		this.clmTxt = clmTxt;
	}
	public Date getInCmplDt() {
		return inCmplDt;
	}
	public void setInCmplDt(Date inCmplDt) {
		this.inCmplDt = inCmplDt;
	}
	public String getInvNo() {
		return invNo;
	}
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}
	public Date getSndCplDt() {
		return sndCplDt;
	}
	public void setSndCplDt(Date sndCplDt) {
		this.sndCplDt = sndCplDt;
	}
	public String getClmGdsStat() {
		return clmGdsStat;
	}
	public void setClmGdsStat(String clmGdsStat) {
		this.clmGdsStat = clmGdsStat;
	}
	public Integer getDlvCmpNo() {
		return dlvCmpNo;
	}
	public void setDlvCmpNo(Integer dlvCmpNo) {
		this.dlvCmpNo = dlvCmpNo;
	}
	public Date getAcptDts() {
		return acptDts;
	}
	public void setAcptDts(Date acptDts) {
		this.acptDts = acptDts;
	}
	public Integer getAcptUsrNo() {
		return acptUsrNo;
	}
	public void setAcptUsrNo(Integer acptUsrNo) {
		this.acptUsrNo = acptUsrNo;
	}
	public String getMngrMemo() {
		return mngrMemo;
	}
	public void setMngrMemo(String mngrMemo) {
		this.mngrMemo = mngrMemo;
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
	public String getClmGdsNm() {
		return clmGdsNm;
	}
	public void setClmGdsNm(String clmGdsNm) {
		this.clmGdsNm = clmGdsNm;
	}
	
}
