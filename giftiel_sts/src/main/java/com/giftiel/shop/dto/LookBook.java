package com.giftiel.shop.dto;

import java.util.List;

public class LookBook {
	private List<LookBookImage> images; //이미지
	
	private Integer rnum;        	//번호
	private Integer totalCnt;       //총 갯수
	private Integer startListNum;   //페이징 시작번호
	private Integer endListNum;     //페이징 끝번호
	
	private Integer txtNo;			//게시물번호
	private String title; 			//제목(시즌명)
	private String imgUrl;			//이미지URL(썸네일)
	private Integer siteNo;			//사이트번호
	private String siteNm;			//사이트명
	
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
	public Integer getTxtNo() {
		return txtNo;
	}
	public void setTxtNo(Integer txtNo) {
		this.txtNo = txtNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	public List<LookBookImage> getImages() {
		return images;
	}
	public void setImages(List<LookBookImage> images) {
		this.images = images;
	}
	
}