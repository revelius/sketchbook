package com.giftiel.shop.dto;

import java.util.List;


public class MainManageForm {
	private Integer siteNo;         //사이트번호 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private List<MainManage> mainManage;

	
	
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

	public Integer getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}

	public List<MainManage> getMainManage() {
		return mainManage;
	}

	public void setMainManage(List<MainManage> mainManage) {
		this.mainManage = mainManage;
	}
	
	
	
	
	
	
}
