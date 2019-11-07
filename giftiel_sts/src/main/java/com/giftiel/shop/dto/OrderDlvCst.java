package com.giftiel.shop.dto;

import java.util.Date;

public class OrderDlvCst {
	
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer dlvCstSeq;         //배송비일련번호 
	private Integer ordDlvNo;         //주문배송번호 
	private Integer clmNo;         //클레임번호 
	private String ordClmCls;         //주문/클레임구분 
	private String dlvCstTp;         //배송비유형 
	private String freeDlvrsnCd;         //무료배송사유코드 
	private Integer actlDlvCst;         //실배송비 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
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
	public Integer getDlvCstSeq() {
		return dlvCstSeq;
	}
	public void setDlvCstSeq(Integer dlvCstSeq) {
		this.dlvCstSeq = dlvCstSeq;
	}
	public Integer getOrdDlvNo() {
		return ordDlvNo;
	}
	public void setOrdDlvNo(Integer ordDlvNo) {
		this.ordDlvNo = ordDlvNo;
	}
	public Integer getClmNo() {
		return clmNo;
	}
	public void setClmNo(Integer clmNo) {
		this.clmNo = clmNo;
	}
	public String getOrdClmCls() {
		return ordClmCls;
	}
	public void setOrdClmCls(String ordClmCls) {
		this.ordClmCls = ordClmCls;
	}
	public String getDlvCstTp() {
		return dlvCstTp;
	}
	public void setDlvCstTp(String dlvCstTp) {
		this.dlvCstTp = dlvCstTp;
	}
	public String getFreeDlvrsnCd() {
		return freeDlvrsnCd;
	}
	public void setFreeDlvrsnCd(String freeDlvrsnCd) {
		this.freeDlvrsnCd = freeDlvrsnCd;
	}
	public Integer getActlDlvCst() {
		return actlDlvCst;
	}
	public void setActlDlvCst(Integer actlDlvCst) {
		this.actlDlvCst = actlDlvCst;
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
