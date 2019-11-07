package com.giftiel.shop.dto;

import java.util.Date;

public class OrderDlvCmp {
	
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer dlvCmpNo;         //택배사번호 
	private String useYn;         //사용여부 
	private String dtlAddr;         //상세주소 
	private String dlvSrchUrl;         //배송조회페이지 
	private String zipCd;         //우편번호 
	private String dlvRsPage;         //배송결과페이지 
	private String chgrNm;         //담당자명 
	private String faxNo;         //팩스번호 
	private String tel;         //전화번호 
	private String addr;         //주소 
	private String dlvCmpNm;         //택배사명 
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
	public Integer getDlvCmpNo() {
		return dlvCmpNo;
	}
	public void setDlvCmpNo(Integer dlvCmpNo) {
		this.dlvCmpNo = dlvCmpNo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getDtlAddr() {
		return dtlAddr;
	}
	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}
	public String getDlvSrchUrl() {
		return dlvSrchUrl;
	}
	public void setDlvSrchUrl(String dlvSrchUrl) {
		this.dlvSrchUrl = dlvSrchUrl;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getDlvRsPage() {
		return dlvRsPage;
	}
	public void setDlvRsPage(String dlvRsPage) {
		this.dlvRsPage = dlvRsPage;
	}
	public String getChgrNm() {
		return chgrNm;
	}
	public void setChgrNm(String chgrNm) {
		this.chgrNm = chgrNm;
	}
	public String getFaxNo() {
		return faxNo;
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDlvCmpNm() {
		return dlvCmpNm;
	}
	public void setDlvCmpNm(String dlvCmpNm) {
		this.dlvCmpNm = dlvCmpNm;
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
