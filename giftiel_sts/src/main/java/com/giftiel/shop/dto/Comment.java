package com.giftiel.shop.dto;

import java.util.Date;

public class Comment {
	private Integer rnum;			//번호
	private Integer totalCnt;			//총갯수

	private Integer memNo;         //회원번호 
	private Integer memGrdNo;         //회원등급번호 
	private Integer regrNo;         //등록자 
	private String regrNm;         //등록자명 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private Date loginDts;       //접속일시 
	
	private String comment;           //회원 코멘트 
	private Integer cmntNo;			  //코멘트 번호
	private String cmntTxt;		      //코멘트 내용 
	private String cmtCnt;           //코멘트 건수 
	
	private Integer startListNum;    //페이징 시작번호
	private Integer endListNum;      //페이징 끝번호
	
	
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
	public String getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(String cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	public Integer getCmntNo() {
		return cmntNo;
	}
	public void setCmntNo(Integer cmntNo) {
		this.cmntNo = cmntNo;
	}
	public String getCmntTxt() {
		return cmntTxt;
	}
	public void setCmntTxt(String cmntTxt) {
		this.cmntTxt = cmntTxt;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getLoginDts() {
		return loginDts;
	}
	public void setLoginDts(Date loginDts) {
		this.loginDts = loginDts;
	}
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
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Integer getMemGrdNo() {
		return memGrdNo;
	}
	public void setMemGrdNo(Integer memGrdNo) {
		this.memGrdNo = memGrdNo;
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
	public String getRegrNm() {
		return regrNm;
	}
	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}
	
}
