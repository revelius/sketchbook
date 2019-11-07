package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

public class Cart {
	private List<Cart> carts;
	private List<UBIGoods> goodsAddInfos;
	private List<CurrentGoodsSize> currentGoodsSizes;	 //상품보유사이즈
	
	private Integer rnum;			//번호
	private Integer totalCnt;			//총갯수

	private Integer memNo;         //회원번호 
	private Integer memGrdNo;         //회원등급번호 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private Date loginDts;       //접속일시
	private Integer cartNo;         //회원번호
	
	private Integer startListNum;    //페이징 시작번호
	private Integer endListNum;      //페이징 끝번호
	
	private String imgUrl;
	private String ubiGdsNo;
	private String sizeNm;
	private Integer expPnt;
	
	private String size1;
	private String size2;
	private String size3;
	private String size4;
	private String size5;
	private String size6;
	private String size7;
	private String size8;
	private String size9;
	private String size10;
	
	private String gdsNo;
	private String ubiSlPrc;
	private String ubiGdsNm;
	private String color;
	private String brand;
	
	private String id;
	private String ubiGdsSize;
	private String gdsSize;
	private Integer qty;
	private String ipAddr;
	private String memYn;
	private String email;
	
	private String ubiGdsColorCd;
	private String ubiGdsColorNm;
	
	private String mainImg;
	private String mainImg2;
	
	private boolean chkCart;
	
	private Integer stock;
	
	private Integer siteNo;
	public String getGdsSize() {
		return gdsSize;
	}
	public void setGdsSize(String gdsSize) {
		this.gdsSize = gdsSize;
	}
	public String getUbiGdsSize() {
		return ubiGdsSize;
	}
	public void setUbiGdsSize(String ubiGdsSize) {
		this.ubiGdsSize = ubiGdsSize;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<UBIGoods> getGoodsAddInfos() {
		return goodsAddInfos;
	}
	public void setGoodsAddInfos(List<UBIGoods> goodsAddInfos) {
		this.goodsAddInfos = goodsAddInfos;
	}
	public String getUbiGdsNm() {
		return ubiGdsNm;
	}
	public void setUbiGdsNm(String ubiGdsNm) {
		this.ubiGdsNm = ubiGdsNm;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public String getGdsNo() {
		return gdsNo;
	}
	public void setGdsNo(String gdsNo) {
		this.gdsNo = gdsNo;
	}
	public String getUbiSlPrc() {
		return ubiSlPrc;
	}
	public void setUbiSlPrc(String ubiSlPrc) {
		this.ubiSlPrc = ubiSlPrc;
	}
	public Date getLoginDts() {
		return loginDts;
	}
	public void setLoginDts(Date loginDts) {
		this.loginDts = loginDts;
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
	public String getSize1() {
		return size1;
	}
	public void setSize1(String size1) {
		this.size1 = size1;
	}
	public String getSize2() {
		return size2;
	}
	public void setSize2(String size2) {
		this.size2 = size2;
	}
	public String getSize3() {
		return size3;
	}
	public void setSize3(String size3) {
		this.size3 = size3;
	}
	public String getSize4() {
		return size4;
	}
	public void setSize4(String size4) {
		this.size4 = size4;
	}
	public String getSize5() {
		return size5;
	}
	public void setSize5(String size5) {
		this.size5 = size5;
	}
	public String getSize6() {
		return size6;
	}
	public void setSize6(String size6) {
		this.size6 = size6;
	}
	public String getSize7() {
		return size7;
	}
	public void setSize7(String size7) {
		this.size7 = size7;
	}
	public String getSize8() {
		return size8;
	}
	public void setSize8(String size8) {
		this.size8 = size8;
	}
	public String getSize9() {
		return size9;
	}
	public void setSize9(String size9) {
		this.size9 = size9;
	}
	public String getSize10() {
		return size10;
	}
	public void setSize10(String size10) {
		this.size10 = size10;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getSizeNm() {
		return sizeNm;
	}
	public void setSizeNm(String sizeNm) {
		this.sizeNm = sizeNm;
	}
	public Integer getExpPnt() {
		return expPnt;
	}
	public void setExpPnt(Integer expPnt) {
		this.expPnt = expPnt;
	}
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
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Integer getMemGrdNo() {
		return memGrdNo;
	}
	public void setMemGrdNo(Integer memGrdNo) {
		this.memGrdNo = memGrdNo;
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
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getMemYn() {
		return memYn;
	}
	public void setMemYn(String memYn) {
		this.memYn = memYn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUbiGdsColorCd() {
		return ubiGdsColorCd;
	}
	public void setUbiGdsColorCd(String ubiGdsColorCd) {
		this.ubiGdsColorCd = ubiGdsColorCd;
	}
	public String getUbiGdsColorNm() {
		return ubiGdsColorNm;
	}
	public void setUbiGdsColorNm(String ubiGdsColorNm) {
		this.ubiGdsColorNm = ubiGdsColorNm;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public List<CurrentGoodsSize> getCurrentGoodsSizes() {
		return currentGoodsSizes;
	}
	public void setCurrentGoodsSizes(List<CurrentGoodsSize> currentGoodsSizes) {
		this.currentGoodsSizes = currentGoodsSizes;
	}
	public boolean isChkCart() {
		return chkCart;
	}
	public void setChkCart(boolean chkCart) {
		this.chkCart = chkCart;
	}
	public List<Cart> getCarts() {
		return carts;
	}
	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}
	public Integer getCartNo() {
		return cartNo;
	}
	public void setCartNo(Integer cartNo) {
		this.cartNo = cartNo;
	}
	public String getMainImg2() {
		return mainImg2;
	}
	public void setMainImg2(String mainImg2) {
		this.mainImg2 = mainImg2;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
}
