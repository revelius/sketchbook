package com.giftiel.shop.dto;


public class InquiryRepl {
	
	
	private Integer rnum;          //번호
	private Integer cnslNo;        //상담번호
	private Integer memoNo;        //덧글번호
	private String memoTxt;        //덧글내용
	private Integer regrNo;         //등록자
	private String regDts;         //등록일시
	private Integer updrNo;         //수정자
	private String updrNm;         //수정자이름
	private String updDts;         //수정일시
	private String wrtrCls;        //작성자구분
	
	private String memNm; 
	private String tel; 
	
	
	
	public String getUpdrNm() {
		return updrNm;
	}
	public void setUpdrNm(String updrNm) {
		this.updrNm = updrNm;
	}
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public Integer getCnslNo() {
		return cnslNo;
	}
	public void setCnslNo(Integer cnslNo) {
		this.cnslNo = cnslNo;
	}
	public Integer getMemoNo() {
		return memoNo;
	}
	public void setMemoNo(Integer memoNo) {
		this.memoNo = memoNo;
	}
	public String getMemoTxt() {
		return memoTxt;
	}
	public void setMemoTxt(String memoTxt) {
		this.memoTxt = memoTxt;
	}
	public String getRegDts() {
		return regDts;
	}
	public void setRegDts(String regDts) {
		this.regDts = regDts;
	}
	public String getUpdDts() {
		return updDts;
	}
	public void setUpdDts(String updDts) {
		this.updDts = updDts;
	}
	public String getWrtrCls() {
		return wrtrCls;
	}
	public void setWrtrCls(String wrtrCls) {
		this.wrtrCls = wrtrCls;
	}
	public Integer getRegrNo() {
		return regrNo;
	}
	public void setRegrNo(Integer regrNo) {
		this.regrNo = regrNo;
	}
	public Integer getUpdrNo() {
		return updrNo;
	}
	public void setUpdrNo(Integer updrNo) {
		this.updrNo = updrNo;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	

	
}
