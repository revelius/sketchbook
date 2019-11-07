package com.giftiel.shop.dto;

import java.util.List;


public class FeatureManageForm {
	private Integer siteNo;         //사이트번호 
	private String sex;         //성별 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private List<FeatureManage>  featureManage;

	public Integer getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getRegrNo() {
		return regrNo;
	}

	public void setRegrNo(Integer regrNo) {
		this.regrNo = regrNo;
	}

	public String getRegDts() {
		return regDts;
	}

	public void setRegDts(String regDts) {
		this.regDts = regDts;
	}

	public Integer getUpdrNo() {
		return updrNo;
	}

	public void setUpdrNo(Integer updrNo) {
		this.updrNo = updrNo;
	}

	public String getUpdDts() {
		return updDts;
	}

	public void setUpdDts(String updDts) {
		this.updDts = updDts;
	}

	public List<FeatureManage> getFeatureManage() {
		return featureManage;
	}

	public void setFeatureManage(List<FeatureManage> featureManage) {
		this.featureManage = featureManage;
	}
	
	
	
}
