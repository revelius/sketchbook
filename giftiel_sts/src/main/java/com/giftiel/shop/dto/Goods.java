package com.giftiel.shop.dto;

import java.util.List;


public class Goods {
	private List<Goods> goodss;	 //상품
	private UBIGoods ubiGoods;	 //UBI상품정보
	private List<GoodsTag> goodsTags;	 //상품키워드정보
	private List<GoodsImage> goodsImages;	 //상품이미지정보
	private List<GoodsSize> goodsSizes;	 //상품사이즈차트
	private List<CurrentGoodsSize> currentGoodsSizes;	 //상품보유사이즈
	private List<CurrentGoodsColors> currentGoodsColors;	 //상품보유컬러
	
	
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private String ubiGdsNo;         //관리상품명 
	private Integer gdsInfoNo;         //상품정보번호 
	private String dispGdsNm;         //전시상품명 
	private String gdsStat;         //상품상태 
	private String bsDesc;         //기본설명 
	private String dtlDesc;         //상세설명 
	private String dispYn;         //전시여부 
	private String slTermCls;         //판매기간구분 
	private String slStrDtm;         //판매시작일시 
	private String slEndDtm;         //판매종료일시 
	private String oosDts;         //품절일시 
	private Integer sortNo;         //기본정렬값 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private String mainImg;         //대표이미지
	
	private String barcode;         //바코드
	private Integer totalStock;         //총재고수량 
	
	private Integer cllbSortNo;         //콜라보전시순서
	private String newArvl;         //신상품유무
	private String sortNo2;         //기본정렬값
	private boolean newArrivalChk;         //기본정렬값
	
	private boolean offlineGoodsChk;         //오프라인구매설정
	private String offGdsChk;         //오프라인구매설정
	
	private Integer siteNo;
	private Integer viewCnt;
	
	public List<Goods> getGoodss() {
		return goodss;
	}
	public void setGoodss(List<Goods> goodss) {
		this.goodss = goodss;
	}
	public UBIGoods getUbiGoods() {
		return ubiGoods;
	}
	public void setUbiGoods(UBIGoods ubiGoods) {
		this.ubiGoods = ubiGoods;
	}
	public List<GoodsTag> getGoodsTags() {
		return goodsTags;
	}
	public void setGoodsTags(List<GoodsTag> goodsTags) {
		this.goodsTags = goodsTags;
	}
	public List<GoodsImage> getGoodsImages() {
		return goodsImages;
	}
	public void setGoodsImages(List<GoodsImage> goodsImages) {
		this.goodsImages = goodsImages;
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
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public Integer getGdsInfoNo() {
		return gdsInfoNo;
	}
	public void setGdsInfoNo(Integer gdsInfoNo) {
		this.gdsInfoNo = gdsInfoNo;
	}
	public String getDispGdsNm() {
		return dispGdsNm;
	}
	public void setDispGdsNm(String dispGdsNm) {
		this.dispGdsNm = dispGdsNm;
	}
	public String getGdsStat() {
		return gdsStat;
	}
	public void setGdsStat(String gdsStat) {
		this.gdsStat = gdsStat;
	}
	public String getBsDesc() {
		return bsDesc;
	}
	public void setBsDesc(String bsDesc) {
		this.bsDesc = bsDesc;
	}
	public String getDtlDesc() {
		return dtlDesc;
	}
	public void setDtlDesc(String dtlDesc) {
		this.dtlDesc = dtlDesc;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getSlTermCls() {
		return slTermCls;
	}
	public void setSlTermCls(String slTermCls) {
		this.slTermCls = slTermCls;
	}
	public String getSlStrDtm() {
		return slStrDtm;
	}
	public void setSlStrDtm(String slStrDtm) {
		this.slStrDtm = slStrDtm;
	}
	public String getSlEndDtm() {
		return slEndDtm;
	}
	public void setSlEndDtm(String slEndDtm) {
		this.slEndDtm = slEndDtm;
	}
	public String getOosDts() {
		return oosDts;
	}
	public void setOosDts(String oosDts) {
		this.oosDts = oosDts;
	}
	public Integer getSortNo() {
		return sortNo;
	}
	public void setSortNo(Integer sortNo) {
		this.sortNo = sortNo;
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
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public List<GoodsSize> getGoodsSizes() {
		return goodsSizes;
	}
	public void setGoodsSizes(List<GoodsSize> goodsSizes) {
		this.goodsSizes = goodsSizes;
	}
	public List<CurrentGoodsSize> getCurrentGoodsSizes() {
		return currentGoodsSizes;
	}
	public void setCurrentGoodsSizes(List<CurrentGoodsSize> currentGoodsSizes) {
		this.currentGoodsSizes = currentGoodsSizes;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public List<CurrentGoodsColors> getCurrentGoodsColors() {
		return currentGoodsColors;
	}
	public void setCurrentGoodsColors(List<CurrentGoodsColors> currentGoodsColors) {
		this.currentGoodsColors = currentGoodsColors;
	}
	public Integer getTotalStock() {
		return totalStock;
	}
	public void setTotalStock(Integer totalStock) {
		this.totalStock = totalStock;
	}
	public Integer getCllbSortNo() {
		return cllbSortNo;
	}
	public void setCllbSortNo(Integer cllbSortNo) {
		this.cllbSortNo = cllbSortNo;
	}
	public String getNewArvl() {
		return newArvl;
	}
	public void setNewArvl(String newArvl) {
		this.newArvl = newArvl;
	}
	public String getSortNo2() {
		return sortNo2;
	}
	public void setSortNo2(String sortNo2) {
		this.sortNo2 = sortNo2;
	}
	public boolean isNewArrivalChk() {
		return newArrivalChk;
	}
	public void setNewArrivalChk(boolean newArrivalChk) {
		this.newArrivalChk = newArrivalChk;
	}
	public boolean isOfflineGoodsChk() {
		return offlineGoodsChk;
	}
	public void setOfflineGoodsChk(boolean offlineGoodsChk) {
		this.offlineGoodsChk = offlineGoodsChk;
	}
	public String getOffGdsChk() {
		return offGdsChk;
	}
	public void setOffGdsChk(String offGdsChk) {
		this.offGdsChk = offGdsChk;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
	public Integer getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(Integer viewCnt) {
		this.viewCnt = viewCnt;
	}
	
}