package com.giftiel.shop.dto;

import java.util.Date;

public class CouponGoods {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer lmtSeq;         //제약일련번호 
	private Integer cpnNo;         //쿠폰번호 
	private String lCtgCd;         //대카테고리코드 
	private String mCtgCd;         //중카테고리코드 
	private String ctgCd;         //카테고리코드 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
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
	public Integer getLmtSeq() {
		return lmtSeq;
	}
	public void setLmtSeq(Integer lmtSeq) {
		this.lmtSeq = lmtSeq;
	}
	public Integer getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(Integer cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getlCtgCd() {
		return lCtgCd;
	}
	public void setlCtgCd(String lCtgCd) {
		this.lCtgCd = lCtgCd;
	}
	public String getmCtgCd() {
		return mCtgCd;
	}
	public void setmCtgCd(String mCtgCd) {
		this.mCtgCd = mCtgCd;
	}
	public String getCtgCd() {
		return ctgCd;
	}
	public void setCtgCd(String ctgCd) {
		this.ctgCd = ctgCd;
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
