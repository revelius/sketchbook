package com.giftiel.shop.dto;

public class Event {

	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer evtApplNo;         //이벤트응모번호 
	private Integer evtNo;         //이벤트번호 
	private String evtNm;         //이벤트명 
	private Integer memNo;         //회원번호 
	private String email;         //이메일 
	private String emailRcpYn;         //이메일수신여부 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시
	private Integer siteNo;         //사이트번호 
	
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
	public Integer getEvtApplNo() {
		return evtApplNo;
	}
	public void setEvtApplNo(Integer evtApplNo) {
		this.evtApplNo = evtApplNo;
	}
	public Integer getEvtNo() {
		return evtNo;
	}
	public void setEvtNo(Integer evtNo) {
		this.evtNo = evtNo;
	}
	public String getEvtNm() {
		return evtNm;
	}
	public void setEvtNm(String evtNm) {
		this.evtNm = evtNm;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailRcpYn() {
		return emailRcpYn;
	}
	public void setEmailRcpYn(String emailRcpYn) {
		this.emailRcpYn = emailRcpYn;
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
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
}
