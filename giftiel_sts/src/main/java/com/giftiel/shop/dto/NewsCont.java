package com.giftiel.shop.dto;


public class NewsCont {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer addContNo;         //추가컨텐츠번호 
	private Integer txtNo;         //게시물번호 
	private String addContType;         //추가컨텐츠타입 
	private String addContAddr;         //추가컨텐츠주소 
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
	public Integer getAddContNo() {
		return addContNo;
	}
	public void setAddContNo(Integer addContNo) {
		this.addContNo = addContNo;
	}
	public Integer getTxtNo() {
		return txtNo;
	}
	public void setTxtNo(Integer txtNo) {
		this.txtNo = txtNo;
	}
	public String getAddContType() {
		return addContType;
	}
	public void setAddContType(String addContType) {
		this.addContType = addContType;
	}
	public String getAddContAddr() {
		return addContAddr;
	}
	public void setAddContAddr(String addContAddr) {
		this.addContAddr = addContAddr;
	}
	
	
	
}