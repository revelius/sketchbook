package com.giftiel.shop.dto;

import java.util.List;

public class LookBookImage {
	private List<LookBookGoods> goodss;
	
	private String imgSeq;    	//이미지일련번호
	private String imgUrl;   	//이미지 URL 
	private String dtlImgUrl;   //디테일이미지 URL 
	private String frontImgUrl;   	//이미지 URL 
	private String frontDtlImgUrl;   //디테일이미지 URL 	
	
	
	
	public String getDtlImgUrl() {
		return dtlImgUrl;
	}
	public void setDtlImgUrl(String dtlImgUrl) {
		this.dtlImgUrl = dtlImgUrl;
	}
	public String getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(String imgSeq) {
		this.imgSeq = imgSeq;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public List<LookBookGoods> getGoodss() {
		return goodss;
	}
	public void setGoodss(List<LookBookGoods> goodss) {
		this.goodss = goodss;
	}
	public String getFrontImgUrl() {
		return frontImgUrl;
	}
	public void setFrontImgUrl(String frontImgUrl) {
		this.frontImgUrl = frontImgUrl;
	}
	public String getFrontDtlImgUrl() {
		return frontDtlImgUrl;
	}
	public void setFrontDtlImgUrl(String frontDtlImgUrl) {
		this.frontDtlImgUrl = frontDtlImgUrl;
	}
	
}