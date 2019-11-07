package com.giftiel.shop.dto;

import java.util.Date;

public class GoodsAddInfo {
	private Integer gdsInfoNo;         //상품정보번호
	private String gdsInfoNm;	//상품정보명
	private String title;         //제목 
	private String txt;         //내용 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	
	public Integer getGdsInfoNo() {
		return gdsInfoNo;
	}
	public void setGdsInfoNo(Integer gdsInfoNo) {
		this.gdsInfoNo = gdsInfoNo;
	}
	public String getGdsInfoNm() {
		return gdsInfoNm;
	}
	public void setGdsInfoNm(String gdsInfoNm) {
		this.gdsInfoNm = gdsInfoNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
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