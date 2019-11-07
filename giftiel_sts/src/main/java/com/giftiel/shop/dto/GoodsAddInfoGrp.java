package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;


public class GoodsAddInfoGrp {
	private List<GoodsAddInfo> goodsAddInfos; //그룹정보리스트 
	
	private Integer gdsInfoNo;         //상품정보번호 
	private String gdsInfoNm;         //상품정보명 
	private String useYn;         //사용여부 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	public List<GoodsAddInfo> getGoodsAddInfos() {
		return goodsAddInfos;
	}
	public void setGoodsAddInfos(List<GoodsAddInfo> goodsAddInfos) {
		this.goodsAddInfos = goodsAddInfos;
	}
	public Integer getGdsInfoNo() {
		return gdsInfoNo;
	}
	public void setGdsInfoNo(Integer gdsInfoNo) {
		this.gdsInfoNo = gdsInfoNo;
	}
	public String getGdsInfoNm() {
		return gdsInfoNm;
	}
	public void setGdsInfoNm(String gdsInfoNm) {
		this.gdsInfoNm = gdsInfoNm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
}