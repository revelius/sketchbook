package com.giftiel.shop.dto;

import java.util.Date;

public class Point {
	private Integer rnum;		//번호
	private Integer totalCnt;	//총갯수

	private Integer memNo;       //회원번호 
	private Integer memGrdNo;    //회원등급번호 
	private String nm;           //이름 
	private String email;        //이메일 
	private String cpNo;         //휴대폰번호 
	private Integer regrNo;      //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;      //수정자 
	private Date updDts;         //수정일시 
    private String ordNo;
    private String rsvRsnCd;
    private String grdNm;        //회원등급명 
    private String rsvYn;        //적립 : Y 사용 : N 
    private Integer usePoint;         //사용포인트
	private Integer curPoint;         //보유포인트
	private double totPoint;         //포인트 합
	
	private Integer startListNum;    //페이징 시작번호
	private Integer endListNum;      //페이징 끝번호
	
	private Integer rsvPnt;      //적립포인트
	
	private String rsvCls;		//작성주체	
	
	public Integer getRsvPnt() {
		return rsvPnt;
	}
	public void setRsvPnt(Integer rsvPnt) {
		this.rsvPnt = rsvPnt;
	}
	public String getGrdNm() {
		return grdNm;
	}
	public void setGrdNm(String grdNm) {
		this.grdNm = grdNm;
	}
	public double getTotPoint() {
		return totPoint;
	}
	public void setTotPoint(double totPoint) {
		this.totPoint = totPoint;
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
	public String getCpNo() {
		return cpNo;
	}
	public void setCpNo(String cpNo) {
		this.cpNo = cpNo;
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
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getRsvRsnCd() {
		return rsvRsnCd;
	}
	public void setRsvRsnCd(String rsvRsnCd) {
		this.rsvRsnCd = rsvRsnCd;
	}
	public Integer getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(Integer usePoint) {
		this.usePoint = usePoint;
	}
	public Integer getCurPoint() {
		return curPoint;
	}
	public void setCurPoint(Integer curPoint) {
		this.curPoint = curPoint;
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
	public String getRsvYn() {
		return rsvYn;
	}
	public void setRsvYn(String rsvYn) {
		this.rsvYn = rsvYn;
	}
	public String getRsvCls() {
		return rsvCls;
	}
	public void setRsvCls(String rsvCls) {
		this.rsvCls = rsvCls;
	}
	
}