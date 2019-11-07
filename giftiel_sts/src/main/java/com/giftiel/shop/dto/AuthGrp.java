package com.giftiel.shop.dto;

import java.util.HashMap;
import java.util.List;


public class AuthGrp {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer authGrpNo;         //권한그룹번호 
	private String authGrpNm;         //권한그룹명 
	private String useYn;         //사용여부 
	private String authGrpDesc;         //권한그룹설명 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private List<SupMenu> supMenu; //상위메뉴
	
	private String grpTot;         //권한그룹별총갯수 
	
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
	public Integer getAuthGrpNo() {
		return authGrpNo;
	}
	public void setAuthGrpNo(Integer authGrpNo) {
		this.authGrpNo = authGrpNo;
	}
	public String getAuthGrpNm() {
		return authGrpNm;
	}
	public void setAuthGrpNm(String authGrpNm) {
		this.authGrpNm = authGrpNm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getAuthGrpDesc() {
		return authGrpDesc;
	}
	public void setAuthGrpDesc(String authGrpDesc) {
		this.authGrpDesc = authGrpDesc;
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
	public List<SupMenu> getSupMenu() {
		return supMenu;
	}
	public void setSupMenu(List<SupMenu> supMenu) {
		this.supMenu = supMenu;
	}
	public String getGrpTot() {
		return grpTot;
	}
	public void setGrpTot(String grpTot) {
		this.grpTot = grpTot;
	}
	
	
	
	
	
}
