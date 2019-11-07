package com.giftiel.shop.dto;

import java.util.Date;


public class AwnesCont {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer awnesNo;         //전시번호 
	private String contCls;         //컨텐츠구분 
	private String contUrl;         //컨텐츠URL 
	private Integer prir;         //우선순위 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private String imgUrl;         //이미지URL
	
	
	
	
	
	
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
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
	public Integer getAwnesNo() {
		return awnesNo;
	}
	public void setAwnesNo(Integer awnesNo) {
		this.awnesNo = awnesNo;
	}
	public String getContCls() {
		return contCls;
	}
	public void setContCls(String contCls) {
		this.contCls = contCls;
	}
	public String getContUrl() {
		return contUrl;
	}
	public void setContUrl(String contUrl) {
		this.contUrl = contUrl;
	}
	public Integer getPrir() {
		return prir;
	}
	public void setPrir(Integer prir) {
		this.prir = prir;
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
