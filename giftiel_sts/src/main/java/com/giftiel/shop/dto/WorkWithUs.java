package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

public class WorkWithUs {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer withusSeq;         //공고번호 
	private String withusStat;         //상태 
	private String withusCls;         //구분 
	private String withusArea;         //지역 
	private String withusCl;         //모집분야 
	private String strDts;         //시작일시 
	private String endDts;         //종료일시 
	private String dtlDesc;         //상세설명 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시
	
	private String regUserNm; //작성자 명
	
	private Integer[] siteNo;   //사이트번호
	
	private List<WorkWithUsSite> workWithUsSite;
	
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
	public Integer getWithusSeq() {
		return withusSeq;
	}
	public void setWithusSeq(Integer withusSeq) {
		this.withusSeq = withusSeq;
	}
	public String getWithusStat() {
		return withusStat;
	}
	public void setWithusStat(String withusStat) {
		this.withusStat = withusStat;
	}
	public String getWithusCls() {
		return withusCls;
	}
	public void setWithusCls(String withusCls) {
		this.withusCls = withusCls;
	}
	public String getWithusArea() {
		return withusArea;
	}
	public void setWithusArea(String withusArea) {
		this.withusArea = withusArea;
	}
	public String getWithusCl() {
		return withusCl;
	}
	public void setWithusCl(String withusCl) {
		this.withusCl = withusCl;
	}

	public String getStrDts() {
		return strDts;
	}
	public void setStrDts(String strDts) {
		this.strDts = strDts;
	}
	public String getEndDts() {
		return endDts;
	}
	public void setEndDts(String endDts) {
		this.endDts = endDts;
	}
	public String getDtlDesc() {
		return dtlDesc;
	}
	public void setDtlDesc(String dtlDesc) {
		this.dtlDesc = dtlDesc;
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
	public List<WorkWithUsSite> getWorkWithUsSite() {
		return workWithUsSite;
	}
	public void setWorkWithUsSite(List<WorkWithUsSite> workWithUsSite) {
		this.workWithUsSite = workWithUsSite;
	}
	public Integer[] getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer[] siteNo) {
		this.siteNo = siteNo;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
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
	
}
