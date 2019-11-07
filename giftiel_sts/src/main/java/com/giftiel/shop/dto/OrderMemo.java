package com.giftiel.shop.dto;

import java.util.Date;

public class OrderMemo {
	
	private String ordNo; //주문번호
	private Integer memoNo; //덧글번호
	private String memoTxt; //덧글내용
	private String wrtrCls; //작성자구분
	private Integer regrNo; //등록자번호
	private String regrNm; //등록자명
	private Date regDts; //등록일시
	private Integer updrNo; //수정자
	private Date updDts; //수정일시
	
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getMemoNo() {
		return memoNo;
	}
	public void setMemoNo(Integer memoNo) {
		this.memoNo = memoNo;
	}
	public String getMemoTxt() {
		return memoTxt;
	}
	public void setMemoTxt(String memoTxt) {
		this.memoTxt = memoTxt;
	}
	public String getWrtrCls() {
		return wrtrCls;
	}
	public void setWrtrCls(String wrtrCls) {
		this.wrtrCls = wrtrCls;
	}
	public Integer getRegrNo() {
		return regrNo;
	}
	public void setRegrNo(Integer regrNo) {
		this.regrNo = regrNo;
	}
	public String getRegrNm() {
		return regrNm;
	}
	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
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
