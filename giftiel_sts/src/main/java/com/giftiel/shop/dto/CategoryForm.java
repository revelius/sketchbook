package com.giftiel.shop.dto;

import java.util.List;

public class CategoryForm {
	
	private int siteNo;
	
	private String seasonSeq;
	private String cateDepth1;
	private String search;
	private String depth;
	
	private String cateMenDepth2;
	private String cateMenDepth3;
	private String menNaDispYn;
	private String menNaDispNm;
	private String cateWomenDepth2;
	private String cateWomenDepth3;
	private String womenNaDispYn;
	private String womenNaDispNm;
	
	private String brandCd;
	private String brandCd2;
	
	private String brand;
	
	
	private int userNo;
	
	private List<SeasonForm> seasonFormList;

	private List<UbiCode> menList;
	private List<UbiCode> womenList;
	
	private String depthCode;			//조회 코드
	

	

	

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBrandCd() {
		return brandCd;
	}

	public void setBrandCd(String brandCd) {
		this.brandCd = brandCd;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getMenNaDispYn() {
		return menNaDispYn;
	}

	public void setMenNaDispYn(String menNaDispYn) {
		this.menNaDispYn = menNaDispYn;
	}

	public String getWomenNaDispYn() {
		return womenNaDispYn;
	}

	public void setWomenNaDispYn(String womenNaDispYn) {
		this.womenNaDispYn = womenNaDispYn;
	}

	public int getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(int siteNo) {
		this.siteNo = siteNo;
	}

	public String getDepth() {
		return depth;
	}

	public void setDepth(String depth) {
		this.depth = depth;
	}

	public String getCateMenDepth2() {
		return cateMenDepth2;
	}

	public void setCateMenDepth2(String cateMenDepth2) {
		this.cateMenDepth2 = cateMenDepth2;
	}

	public String getCateMenDepth3() {
		return cateMenDepth3;
	}

	public void setCateMenDepth3(String cateMenDepth3) {
		this.cateMenDepth3 = cateMenDepth3;
	}

	public String getCateWomenDepth2() {
		return cateWomenDepth2;
	}

	public void setCateWomenDepth2(String cateWomenDepth2) {
		this.cateWomenDepth2 = cateWomenDepth2;
	}

	public String getCateWomenDepth3() {
		return cateWomenDepth3;
	}

	public void setCateWomenDepth3(String cateWomenDepth3) {
		this.cateWomenDepth3 = cateWomenDepth3;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getSeasonSeq() {
		return seasonSeq;
	}

	public void setSeasonSeq(String seasonSeq) {
		this.seasonSeq = seasonSeq;
	}

	public String getCateDepth1() {
		return cateDepth1;
	}

	public void setCateDepth1(String cateDepth1) {
		this.cateDepth1 = cateDepth1;
	}

	public List<UbiCode> getMenList() {
		return menList;
	}

	public void setMenList(List<UbiCode> menList) {
		this.menList = menList;
	}

	public List<UbiCode> getWomenList() {
		return womenList;
	}

	public void setWomenList(List<UbiCode> womenList) {
		this.womenList = womenList;
	}

	public List<SeasonForm> getSeasonFormList() {
		return seasonFormList;
	}

	public void setSeasonFormList(List<SeasonForm> seasonFormList) {
		this.seasonFormList = seasonFormList;
	}

	public String getMenNaDispNm() {
		return menNaDispNm;
	}

	public void setMenNaDispNm(String menNaDispNm) {
		this.menNaDispNm = menNaDispNm;
	}

	public String getWomenNaDispNm() {
		return womenNaDispNm;
	}

	public void setWomenNaDispNm(String womenNaDispNm) {
		this.womenNaDispNm = womenNaDispNm;
	}

	public String getDepthCode() {
		return depthCode;
	}

	public void setDepthCode(String depthCode) {
		this.depthCode = depthCode;
	}

	public String getBrandCd2() {
		return brandCd2;
	}

	public void setBrandCd2(String brandCd2) {
		this.brandCd2 = brandCd2;
	}
	
}
