package com.giftiel.shop.dto;


public class BoardGds {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer imgSeq;         //이미지일련번호 
	private String ubiGdsNo;         //상품번호 
	private String gdsNm;         //상품명 
	private Integer slPrc;         //판매가 
	private String imgUrl;         //이미지 URL 
	private String linkUrl;         //연결 URL 
	
	private String prir;         //우선순위
	
	
	private String gubun;         //입력구분
	
	
	
	
	
	
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getPrir() {
		return prir;
	}
	public void setPrir(String prir) {
		this.prir = prir;
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
	public Integer getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(Integer imgSeq) {
		this.imgSeq = imgSeq;
	}
	public String getGdsNm() {
		return gdsNm;
	}
	public void setGdsNm(String gdsNm) {
		this.gdsNm = gdsNm;
	}
	public Integer getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(Integer slPrc) {
		this.slPrc = slPrc;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	
	
	
	
	
}
