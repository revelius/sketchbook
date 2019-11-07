package com.giftiel.shop.dto;

import java.util.Date;

public class CouponMemIss {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer cpnIssSeq;         //쿠폰발급일련번호 
	private Integer cpnNo;         //쿠폰번호 
	private Integer memNo;         //회원번호 
	private String cpnUseOrdNo;         //쿠폰사용주문번호 
	private String cpnIssStat;         //쿠폰발급상태 
	private Date vldStrDts;         //유효시작일시 
	private Date vldEndDts;         //등록자 
	private Date issDts;         //발급일시 
	private Date useDts;         //사용일시 
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
	public Integer getCpnIssSeq() {
		return cpnIssSeq;
	}
	public void setCpnIssSeq(Integer cpnIssSeq) {
		this.cpnIssSeq = cpnIssSeq;
	}
	public Integer getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(Integer cpnNo) {
		this.cpnNo = cpnNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getCpnUseOrdNo() {
		return cpnUseOrdNo;
	}
	public void setCpnUseOrdNo(String cpnUseOrdNo) {
		this.cpnUseOrdNo = cpnUseOrdNo;
	}
	public String getCpnIssStat() {
		return cpnIssStat;
	}
	public void setCpnIssStat(String cpnIssStat) {
		this.cpnIssStat = cpnIssStat;
	}
	public Date getVldStrDts() {
		return vldStrDts;
	}
	public void setVldStrDts(Date vldStrDts) {
		this.vldStrDts = vldStrDts;
	}
	public Date getVldEndDts() {
		return vldEndDts;
	}
	public void setVldEndDts(Date vldEndDts) {
		this.vldEndDts = vldEndDts;
	}
	public Date getIssDts() {
		return issDts;
	}
	public void setIssDts(Date issDts) {
		this.issDts = issDts;
	}
	public Date getUseDts() {
		return useDts;
	}
	public void setUseDts(Date useDts) {
		this.useDts = useDts;
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
