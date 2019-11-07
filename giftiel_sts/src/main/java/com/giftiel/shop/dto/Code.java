package com.giftiel.shop.dto;

import java.util.Date;

public class Code {
	private String cdNo;			//코드번호 
	private String supCdNo;			//상위코드번호 
	private String cdNm;			//코드명 
	private String cdDesc;			//코드설명 
	private String cdTp;			//코드유형 
	private String wrkClsCd;		//업무분류코드 
	private Integer prir;			//우선순위 
	private String useYn;			//사용여부 
	private Integer regrNo;			//등록자 
	private Date regDts;			//등록일시 
	private Integer updrNo;			//수정자 
	private Date updDts;			//수정일시
	private String prevUseYn;		//이전시즌브랜드사용유무 
	private String outletUseYn;		//아웃렛브랜드사용유무
	private String sex;				//성별 

	public String getCdNo() {
		return cdNo;
	}
	public void setCdNo(String cdNo) {
		this.cdNo = cdNo;
	}
	public String getSupCdNo() {
		return supCdNo;
	}
	public void setSupCdNo(String supCdNo) {
		this.supCdNo = supCdNo;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public String getCdDesc() {
		return cdDesc;
	}
	public void setCdDesc(String cdDesc) {
		this.cdDesc = cdDesc;
	}
	public String getCdTp() {
		return cdTp;
	}
	public void setCdTp(String cdTp) {
		this.cdTp = cdTp;
	}
	public String getWrkClsCd() {
		return wrkClsCd;
	}
	public void setWrkClsCd(String wrkClsCd) {
		this.wrkClsCd = wrkClsCd;
	}
	public Integer getPrir() {
		return prir;
	}
	public void setPrir(Integer prir) {
		this.prir = prir;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
	public String getPrevUseYn() {
		return prevUseYn;
	}
	public void setPrevUseYn(String prevUseYn) {
		this.prevUseYn = prevUseYn;
	}
	public String getOutletUseYn() {
		return outletUseYn;
	}
	public void setOutletUseYn(String outletUseYn) {
		this.outletUseYn = outletUseYn;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
}
