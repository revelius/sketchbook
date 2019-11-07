package com.giftiel.shop.dto;

import java.util.Date;

public class MemberGrade {
	private Integer memGrdNo;         //회원등급번호 
	private String grdNm;         //등급명 
	private Integer dcAmt;         //할인금액/할인율 
	private Integer pntRsvRt;         //포인트적립율 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	public Integer getMemGrdNo() {
		return memGrdNo;
	}
	public void setMemGrdNo(Integer memGrdNo) {
		this.memGrdNo = memGrdNo;
	}
	public String getGrdNm() {
		return grdNm;
	}
	public void setGrdNm(String grdNm) {
		this.grdNm = grdNm;
	}
	public Integer getDcAmt() {
		return dcAmt;
	}
	public void setDcAmt(Integer dcAmt) {
		this.dcAmt = dcAmt;
	}
	public Integer getPntRsvRt() {
		return pntRsvRt;
	}
	public void setPntRsvRt(Integer pntRsvRt) {
		this.pntRsvRt = pntRsvRt;
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
}
