package com.giftiel.shop.dto;

public class CateConfig {

	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer seasonSeq;         //시즌 시퀀스 
	private String cateDepth1;         //카테고리 1뎁스 
	private String cateDepth2;         //카테고리 2뎁스 
	private String cateDepth3;         //카테고리 3뎁스 
	private String dispYn;         //노출여부
	private String useYn;         //사용여부 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	
	
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
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
	public Integer getSeasonSeq() {
		return seasonSeq;
	}
	public void setSeasonSeq(Integer seasonSeq) {
		this.seasonSeq = seasonSeq;
	}
	public String getCateDepth1() {
		return cateDepth1;
	}
	public void setCateDepth1(String cateDepth1) {
		this.cateDepth1 = cateDepth1;
	}
	public String getCateDepth2() {
		return cateDepth2;
	}
	public void setCateDepth2(String cateDepth2) {
		this.cateDepth2 = cateDepth2;
	}
	public String getCateDepth3() {
		return cateDepth3;
	}
	public void setCateDepth3(String cateDepth3) {
		this.cateDepth3 = cateDepth3;
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
	
	
}
