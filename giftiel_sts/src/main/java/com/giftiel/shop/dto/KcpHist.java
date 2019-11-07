package com.giftiel.shop.dto;

import java.util.Date;

public class KcpHist {
	private Integer kpcHistNo;         //전문이력번호 
	private String ordNo;         //주문번호 
	private String tno;         //KCP거래번호 
	private Integer clmNo;         //클레임번호 
	private String resCd;         //결과코드 
	private String resMsg;         //결과메세지 
	private String bsucc;         //자동취소 구분 
	private String escwYn;         //에스크로결제여부
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	public Integer getKpcHistNo() {
		return kpcHistNo;
	}
	public void setKpcHistNo(Integer kpcHistNo) {
		this.kpcHistNo = kpcHistNo;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}
	public Integer getClmNo() {
		return clmNo;
	}
	public void setClmNo(Integer clmNo) {
		this.clmNo = clmNo;
	}
	public String getResCd() {
		return resCd;
	}
	public void setResCd(String resCd) {
		this.resCd = resCd;
	}
	public String getResMsg() {
		return resMsg;
	}
	public void setResMsg(String resMsg) {
		this.resMsg = resMsg;
	}
	public String getBsucc() {
		return bsucc;
	}
	public void setBsucc(String bsucc) {
		this.bsucc = bsucc;
	}
	public String getEscwYn() {
		return escwYn;
	}
	public void setEscwYn(String escwYn) {
		this.escwYn = escwYn;
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