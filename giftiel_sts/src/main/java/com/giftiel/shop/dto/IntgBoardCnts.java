package com.giftiel.shop.dto;

import java.util.List;


public class IntgBoardCnts {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer imgSeq;         //이미지일련번호 
	private Integer txtNo;         //게시물번호 
	private String imgCls;         //이미지구분 
	private String imgUrl;         //이미지 URL 
	private String dtlImgUrl;       //상세이미지 URL 
	private Integer prir;         //우선순위 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private List<BoardGds> boardGds; //추가 컨텐츠 상품
	
	
	
	
	
	public String getDtlImgUrl() {
		return dtlImgUrl;
	}
	public void setDtlImgUrl(String dtlImgUrl) {
		this.dtlImgUrl = dtlImgUrl;
	}
	public List<BoardGds> getBoardGds() {
		return boardGds;
	}
	public void setBoardGds(List<BoardGds> boardGds) {
		this.boardGds = boardGds;
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
	public Integer getTxtNo() {
		return txtNo;
	}
	public void setTxtNo(Integer txtNo) {
		this.txtNo = txtNo;
	}
	public String getImgCls() {
		return imgCls;
	}
	public void setImgCls(String imgCls) {
		this.imgCls = imgCls;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
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
