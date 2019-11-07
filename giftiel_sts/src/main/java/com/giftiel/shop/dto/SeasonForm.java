package com.giftiel.shop.dto;

import java.util.List;

public class SeasonForm {

	int siteNo;
	String SiteNm;
	
	CateSeason cate1Season;
	CateSeason cate2Season;
	CateSeason cateOutlet;
	
	
	
	
	
	
	public int getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(int siteNo) {
		this.siteNo = siteNo;
	}
	public String getSiteNm() {
		return SiteNm;
	}
	public void setSiteNm(String siteNm) {
		SiteNm = siteNm;
	}
	public CateSeason getCate1Season() {
		return cate1Season;
	}
	public void setCate1Season(CateSeason cate1Season) {
		this.cate1Season = cate1Season;
	}
	public CateSeason getCate2Season() {
		return cate2Season;
	}
	public void setCate2Season(CateSeason cate2Season) {
		this.cate2Season = cate2Season;
	}
	public CateSeason getCateOutlet() {
		return cateOutlet;
	}
	public void setCateOutlet(CateSeason cateOutlet) {
		this.cateOutlet = cateOutlet;
	}
	
	
	
	
	
	
	
	
	
	
}
