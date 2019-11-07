package com.giftiel.shop.dto;

import java.util.List;

public class CategoryNew {
	public Integer cateNo;
	public Integer siteNo;
	public String brand;
	public String oneDepth;
	public String twoDepth;
	public String threeDepth;
	public String sex;
	public String newArvl;
	
	public List<CategoryNewGoods> categoryNewGoods;

	public Integer getCateNo() {
		return cateNo;
	}

	public void setCateNo(Integer cateNo) {
		this.cateNo = cateNo;
	}

	public Integer getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getOneDepth() {
		return oneDepth;
	}

	public void setOneDepth(String oneDepth) {
		this.oneDepth = oneDepth;
	}

	public String getTwoDepth() {
		return twoDepth;
	}

	public void setTwoDepth(String twoDepth) {
		this.twoDepth = twoDepth;
	}

	public String getThreeDepth() {
		return threeDepth;
	}

	public void setThreeDepth(String threeDepth) {
		this.threeDepth = threeDepth;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getNewArvl() {
		return newArvl;
	}

	public void setNewArvl(String newArvl) {
		this.newArvl = newArvl;
	}

	public List<CategoryNewGoods> getCategoryNewGoods() {
		return categoryNewGoods;
	}

	public void setCategoryNewGoods(List<CategoryNewGoods> categoryNewGoods) {
		this.categoryNewGoods = categoryNewGoods;
	}
	
	
}