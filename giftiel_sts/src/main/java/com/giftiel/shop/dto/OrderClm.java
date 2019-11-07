package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;


public class OrderClm {
	private List<OrderClmGds> orderClmGds;	 //상품
	
	/*[s] 클라임*/
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer clmNo;         //클레임번호 
	private String clmStat;         //클레임상태 
	private Date procCmplDts;         //처리완료일시 
	private String ordNo;         //주문번호 
	private String clmTp;         //클레임유형
	private String clmTpNm;         //클레임유형 
	private String rcpnNm;         //수령자명 
	private String rcpnTelNo;         //수령자전화번호 
	private String rcpnCpNo;         //수령자휴대폰번호 
	private String rcpnZipCd;         //수령자우편번호 
	private String rcpnBsAddr;         //수령자기본주소 
	private String rcpnDtlAddr;         //수령자상세주소 
	private String dlvSvcMemo;         //택배메모 
	private String rfndAcctNo;         //환불계좌번호 
	private String rfndBnkCd;         //환불은행코드 
	private String rfndAcctOwn;         //환불예금주 	
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시
	
	
	private String rfndBnkNm;         //환불은행명
	
	/*[e] 클라임*/
	
	
	
	
	
	
	public Integer getRnum() {
		return rnum;
	}
	public String getRfndBnkNm() {
		return rfndBnkNm;
	}
	public void setRfndBnkNm(String rfndBnkNm) {
		this.rfndBnkNm = rfndBnkNm;
	}
	public List<OrderClmGds> getOrderClmGds() {
		return orderClmGds;
	}
	public void setOrderClmGds(List<OrderClmGds> orderClmGds) {
		this.orderClmGds = orderClmGds;
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
	public Integer getClmNo() {
		return clmNo;
	}
	public void setClmNo(Integer clmNo) {
		this.clmNo = clmNo;
	}
	public String getClmStat() {
		return clmStat;
	}
	public void setClmStat(String clmStat) {
		this.clmStat = clmStat;
	}
	public Date getProcCmplDts() {
		return procCmplDts;
	}
	public void setProcCmplDts(Date procCmplDts) {
		this.procCmplDts = procCmplDts;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getClmTp() {
		return clmTp;
	}
	public void setClmTp(String clmTp) {
		this.clmTp = clmTp;
	}
	public String getRcpnNm() {
		return rcpnNm;
	}
	public void setRcpnNm(String rcpnNm) {
		this.rcpnNm = rcpnNm;
	}
	public String getRcpnTelNo() {
		return rcpnTelNo;
	}
	public void setRcpnTelNo(String rcpnTelNo) {
		this.rcpnTelNo = rcpnTelNo;
	}
	public String getRcpnCpNo() {
		return rcpnCpNo;
	}
	public void setRcpnCpNo(String rcpnCpNo) {
		this.rcpnCpNo = rcpnCpNo;
	}
	public String getRcpnZipCd() {
		return rcpnZipCd;
	}
	public void setRcpnZipCd(String rcpnZipCd) {
		this.rcpnZipCd = rcpnZipCd;
	}
	public String getRcpnBsAddr() {
		return rcpnBsAddr;
	}
	public void setRcpnBsAddr(String rcpnBsAddr) {
		this.rcpnBsAddr = rcpnBsAddr;
	}
	public String getRcpnDtlAddr() {
		return rcpnDtlAddr;
	}
	public void setRcpnDtlAddr(String rcpnDtlAddr) {
		this.rcpnDtlAddr = rcpnDtlAddr;
	}
	public String getDlvSvcMemo() {
		return dlvSvcMemo;
	}
	public void setDlvSvcMemo(String dlvSvcMemo) {
		this.dlvSvcMemo = dlvSvcMemo;
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
	public String getRfndAcctNo() {
		return rfndAcctNo;
	}
	public void setRfndAcctNo(String rfndAcctNo) {
		this.rfndAcctNo = rfndAcctNo;
	}
	public String getRfndBnkCd() {
		return rfndBnkCd;
	}
	public void setRfndBnkCd(String rfndBnkCd) {
		this.rfndBnkCd = rfndBnkCd;
	}
	public String getRfndAcctOwn() {
		return rfndAcctOwn;
	}
	public void setRfndAcctOwn(String rfndAcctOwn) {
		this.rfndAcctOwn = rfndAcctOwn;
	}
	public String getClmTpNm() {
		return clmTpNm;
	}
	public void setClmTpNm(String clmTpNm) {
		this.clmTpNm = clmTpNm;
	}
}
