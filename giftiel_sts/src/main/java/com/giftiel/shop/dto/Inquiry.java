package com.giftiel.shop.dto;

import java.util.List;


public class Inquiry {
	private Integer rnum;            //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;    //페이징 시작번호
	private Integer endListNum;      //페이징 끝번호
	private Integer cnslNo;          //상담번호 
	private Integer memNo;           //회원번호 
	private String cnslTpLcl;        //상담유형대분류 
	private String cnslTpMcl;        //상담유형중분류 
	private String cnslStat;         //상담상태 
	private String procCmplDts;      //처리완료일시 
	private Integer procCmplUsrno;   //처리완료자 
	private String memId;           //회원ID 
	private String memNm;            //회원이름 
	private String title;            //제목 
	private String cnslTxt;          //상담내용 
	private String procTxt;          //처리내용 
	private Integer ordNo;           //주문번호 
	private Integer ordGdsSeq;       //주문상품일련번호 
	private Integer gdsNo;           //상품번호 
	private String email;            //이메일 
	private String emailAnsReqYn;    //이메일답변요청여부 
	private String tel;              //전화번호 
	private String replyTelYn;       //전화답변요청여부 
	private Integer chgr;            //담당자 
	private Integer regrNo;          //등록자 
	private String regDts;           //등록일시 
	private Integer updrNo;          //수정자 
	private String updDts;           //수정일시 
	private String atchFile;         //첨부파일명 
	private String siteNo;           //사이트번호(브랜드)
	private String siteNm;           //사이트네임
	private String ubiGdsNo;         //ubi 상품번호
	private String maxQ;             //최근 질문일
	private String maxA;             //최근답변일
	
	
	private List<InquiryRepl> inqueryRepl;
	
	
	
	
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
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
	public Integer getCnslNo() {
		return cnslNo;
	}
	public void setCnslNo(Integer cnslNo) {
		this.cnslNo = cnslNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public String getCnslTpLcl() {
		return cnslTpLcl;
	}
	public void setCnslTpLcl(String cnslTpLcl) {
		this.cnslTpLcl = cnslTpLcl;
	}
	public String getCnslTpMcl() {
		return cnslTpMcl;
	}
	public void setCnslTpMcl(String cnslTpMcl) {
		this.cnslTpMcl = cnslTpMcl;
	}
	public String getCnslStat() {
		return cnslStat;
	}
	public void setCnslStat(String cnslStat) {
		this.cnslStat = cnslStat;
	}
	public String getProcCmplDts() {
		return procCmplDts;
	}
	public void setProcCmplDts(String procCmplDts) {
		this.procCmplDts = procCmplDts;
	}
	public Integer getProcCmplUsrno() {
		return procCmplUsrno;
	}
	public void setProcCmplUsrno(Integer procCmplUsrno) {
		this.procCmplUsrno = procCmplUsrno;
	}
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCnslTxt() {
		return cnslTxt;
	}
	public void setCnslTxt(String cnslTxt) {
		this.cnslTxt = cnslTxt;
	}
	public String getProcTxt() {
		return procTxt;
	}
	public void setProcTxt(String procTxt) {
		this.procTxt = procTxt;
	}
	public Integer getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(Integer ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getOrdGdsSeq() {
		return ordGdsSeq;
	}
	public void setOrdGdsSeq(Integer ordGdsSeq) {
		this.ordGdsSeq = ordGdsSeq;
	}
	public Integer getGdsNo() {
		return gdsNo;
	}
	public void setGdsNo(Integer gdsNo) {
		this.gdsNo = gdsNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailAnsReqYn() {
		return emailAnsReqYn;
	}
	public void setEmailAnsReqYn(String emailAnsReqYn) {
		this.emailAnsReqYn = emailAnsReqYn;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getReplyTelYn() {
		return replyTelYn;
	}
	public void setReplyTelYn(String replyTelYn) {
		this.replyTelYn = replyTelYn;
	}
	public Integer getChgr() {
		return chgr;
	}
	public void setChgr(Integer chgr) {
		this.chgr = chgr;
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
	public String getAtchFile() {
		return atchFile;
	}
	public void setAtchFile(String atchFile) {
		this.atchFile = atchFile;
	}
	public String getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(String siteNo) {
		this.siteNo = siteNo;
	}
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public List<InquiryRepl> getInqueryRepl() {
		return inqueryRepl;
	}
	public void setInqueryRepl(List<InquiryRepl> inqueryRepl) {
		this.inqueryRepl = inqueryRepl;
	}
	public String getMaxQ() {
		return maxQ;
	}
	public void setMaxQ(String maxQ) {
		this.maxQ = maxQ;
	}
	public String getMaxA() {
		return maxA;
	}
	public void setMaxA(String maxA) {
		this.maxA = maxA;
	}
	
	
	
	
	
	
	
	
	
	
}
