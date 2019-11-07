package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

public class UbiCode {
	private String gubun;			//구분 
	private String cateCd;			//코드 
	private String cateNm;			//코드명 
	private String gubunCd;			//구분코드 
	
	private String grpTot;         //권한그룹별총갯수 
	
	private int tot;           //총갯수
	
	private List<UbiCode> subUbiCode; //하위코드
	
	
	
	
	public int getTot() {
		return tot;
	}
	public void setTot(int tot) {
		this.tot = tot;
	}
	public String getGrpTot() {
		return grpTot;
	}
	public void setGrpTot(String grpTot) {
		this.grpTot = grpTot;
	}
	public List<UbiCode> getSubUbiCode() {
		return subUbiCode;
	}
	public void setSubUbiCode(List<UbiCode> subUbiCode) {
		this.subUbiCode = subUbiCode;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getCateCd() {
		return cateCd;
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getCateNm() {
		return cateNm;
	}
	public void setCateNm(String cateNm) {
		this.cateNm = cateNm;
	}
	public String getGubunCd() {
		return gubunCd;
	}
	public void setGubunCd(String gubunCd) {
		this.gubunCd = gubunCd;
	}
	
	
}
