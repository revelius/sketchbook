package com.giftiel.shop.dto;

public class LookBookGoods {
	private String gdsNo;		//상품번호
	private String gdsNm; 	//상품명
	private int slPrc;		//판매가
	private String linkUrl;	//연결 URL
	
	
	public String getGdsNo() {
		return gdsNo;
	}
	public void setGdsNo(String gdsNo) {
		this.gdsNo = gdsNo;
	}
	public String getGdsNm() {
		return gdsNm;
	}
	public void setGdsNm(String gdsNm) {
		this.gdsNm = gdsNm;
	}
	public int getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(int slPrc) {
		this.slPrc = slPrc;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	
}
