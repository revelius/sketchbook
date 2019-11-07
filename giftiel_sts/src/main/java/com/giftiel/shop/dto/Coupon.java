package com.giftiel.shop.dto;

import java.util.Date;

public class Coupon {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer cpnNo;         //쿠폰번호 
	private String cpnNm;         //쿠폰명 
	private String cpnKnd;         //쿠폰종류 
	private String issWay;         //발급방식 
	private String cpnDesc;         //쿠폰설명 
	private String dcWay;         //할인방식 
	private Integer dcAmt;         //할인금액/할인율 
	private String vldTermCls;         //유효기간구분 
	private Date vldStrDts;         //유효시작일시 
	private Date vldEndDts;         //유효종료일시 
	private Integer vldDayCnt;         //유효기간일수 
	private String vldWkdy;         //유효요일 
	private String vldStrTm;         //유효시작시간 
	private String vldEndTm;         //유효종료시간 
	private Date issStrDts;         //발급시작일시 
	private Date issEndDts;         //발급종료일시 
	private String cpnStat;         //쿠폰상태 
	private String cpnImgUrl;         //쿠폰이미지URL 
	private Integer maxDcAmt;         //최대할인금액 
	private Integer minOrdAmt;         //최저주문금액 
	private Integer allIssLmtCnt;         //전체발급제한건수 
	private String dupIssYn;         //복수발급여부 
	private Integer issTms;         //발급횟수 
	private String issWkdy;         //발급요일 
	private String issStrTm;         //발급시작시간 
	private String issEndTm;         //발급종료시간 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private String resultCode;
	private String cpnVldChk;
	private Integer useCnt;
	
	//오프라인 쿠폰
	private String offCpnNo;
	private Integer memNo;
	

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
	public Integer getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(Integer cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getCpnNm() {
		return cpnNm;
	}
	public void setCpnNm(String cpnNm) {
		this.cpnNm = cpnNm;
	}
	public String getCpnKnd() {
		return cpnKnd;
	}
	public void setCpnKnd(String cpnKnd) {
		this.cpnKnd = cpnKnd;
	}
	public String getIssWay() {
		return issWay;
	}
	public void setIssWay(String issWay) {
		this.issWay = issWay;
	}
	public String getCpnDesc() {
		return cpnDesc;
	}
	public void setCpnDesc(String cpnDesc) {
		this.cpnDesc = cpnDesc;
	}
	public String getDcWay() {
		return dcWay;
	}
	public void setDcWay(String dcWay) {
		this.dcWay = dcWay;
	}
	public Integer getDcAmt() {
		return dcAmt;
	}
	public void setDcAmt(Integer dcAmt) {
		this.dcAmt = dcAmt;
	}
	public String getVldTermCls() {
		return vldTermCls;
	}
	public void setVldTermCls(String vldTermCls) {
		this.vldTermCls = vldTermCls;
	}
	public Date getVldStrDts() {
		return vldStrDts;
	}
	public void setVldStrDts(Date vldStrDts) {
		this.vldStrDts = vldStrDts;
	}
	public Date getVldEndDts() {
		return vldEndDts;
	}
	public void setVldEndDts(Date vldEndDts) {
		this.vldEndDts = vldEndDts;
	}
	public Integer getVldDayCnt() {
		return vldDayCnt;
	}
	public void setVldDayCnt(Integer vldDayCnt) {
		this.vldDayCnt = vldDayCnt;
	}
	public String getVldWkdy() {
		return vldWkdy;
	}
	public void setVldWkdy(String vldWkdy) {
		this.vldWkdy = vldWkdy;
	}
	public String getVldStrTm() {
		return vldStrTm;
	}
	public void setVldStrTm(String vldStrTm) {
		this.vldStrTm = vldStrTm;
	}
	public String getVldEndTm() {
		return vldEndTm;
	}
	public void setVldEndTm(String vldEndTm) {
		this.vldEndTm = vldEndTm;
	}
	public Date getIssStrDts() {
		return issStrDts;
	}
	public void setIssStrDts(Date issStrDts) {
		this.issStrDts = issStrDts;
	}
	public Date getIssEndDts() {
		return issEndDts;
	}
	public void setIssEndDts(Date issEndDts) {
		this.issEndDts = issEndDts;
	}
	public String getCpnStat() {
		return cpnStat;
	}
	public void setCpnStat(String cpnStat) {
		this.cpnStat = cpnStat;
	}
	public String getCpnImgUrl() {
		return cpnImgUrl;
	}
	public void setCpnImgUrl(String cpnImgUrl) {
		this.cpnImgUrl = cpnImgUrl;
	}
	public Integer getMaxDcAmt() {
		return maxDcAmt;
	}
	public void setMaxDcAmt(Integer maxDcAmt) {
		this.maxDcAmt = maxDcAmt;
	}
	public Integer getMinOrdAmt() {
		return minOrdAmt;
	}
	public void setMinOrdAmt(Integer minOrdAmt) {
		this.minOrdAmt = minOrdAmt;
	}
	public Integer getAllIssLmtCnt() {
		return allIssLmtCnt;
	}
	public void setAllIssLmtCnt(Integer allIssLmtCnt) {
		this.allIssLmtCnt = allIssLmtCnt;
	}
	public String getDupIssYn() {
		return dupIssYn;
	}
	public void setDupIssYn(String dupIssYn) {
		this.dupIssYn = dupIssYn;
	}
	public Integer getIssTms() {
		return issTms;
	}
	public void setIssTms(Integer issTms) {
		this.issTms = issTms;
	}
	public String getIssWkdy() {
		return issWkdy;
	}
	public void setIssWkdy(String issWkdy) {
		this.issWkdy = issWkdy;
	}
	public String getIssStrTm() {
		return issStrTm;
	}
	public void setIssStrTm(String issStrTm) {
		this.issStrTm = issStrTm;
	}
	public String getIssEndTm() {
		return issEndTm;
	}
	public void setIssEndTm(String issEndTm) {
		this.issEndTm = issEndTm;
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
	public String getOffCpnNo() {
		return offCpnNo;
	}
	public void setOffCpnNo(String offCpnNo) {
		this.offCpnNo = offCpnNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getCpnVldChk() {
		return cpnVldChk;
	}
	public void setCpnVldChk(String cpnVldChk) {
		this.cpnVldChk = cpnVldChk;
	}
	public Integer getUseCnt() {
		return useCnt;
	}
	public void setUseCnt(Integer useCnt) {
		this.useCnt = useCnt;
	}
}
