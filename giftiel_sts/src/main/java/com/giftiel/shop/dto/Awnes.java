package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;


public class Awnes {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer awnesNo;         //전시번호 
	private String dispYn;         //전시여부 
	private String title;         //제목 
	private String dtlTxt;         //상세내용 
	private Integer regrNo;         //등록자 
	private String regUserNm;         //작성자명
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updrUserNm;         //수정자명
	private Date updDts;         //수정일시 
	
	private String userNm;         //작성자명
	
	
	List<AwnesCont> awnesCont;   //Awareness 컨텐츠
	
	
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	public String getUpdrUserNm() {
		return updrUserNm;
	}
	public void setUpdrUserNm(String updrUserNm) {
		this.updrUserNm = updrUserNm;
	}
	public List<AwnesCont> getAwnesCont() {
		return awnesCont;
	}
	public void setAwnesCont(List<AwnesCont> awnesCont) {
		this.awnesCont = awnesCont;
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
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getDtlTxt() {
		return dtlTxt;
	}
	public void setDtlTxt(String dtlTxt) {
		this.dtlTxt = dtlTxt;
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
