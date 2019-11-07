package com.giftiel.shop.dto;

import java.util.Date;

public class Member {
	private Integer rnum;			//번호
	private Integer totalCnt;			//총갯수

	private Integer memNo;         //회원번호 
	private Integer memGrdNo;         //회원등급번호 
	private String pwd;         //비밀번호 
	private String nm;         //이름 
	private String email;         //이메일 
	private Date birthDt;         //생년월일 
	private String sex;         //성별 
	private String mySlfCertYn;         //본인인증유무 
	private String cpNo;         //휴대폰번호 
	private String mailSndYn;         //메일발송여부 
	private String smsSndYn;         //SMS발송여부 
	private String countryCd;         //국가코드 
	private String joinPathCd;         //가입경로코드 
	private Integer regrNo;         //등록자 
	private String regrNm;         //등록자이름
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private Date loginDts;       //접속일시 
	private Integer age;         //나이 
	private Integer curPoint;         //보유포인트
	private Integer loginCnt;         //로그인횟수
	private Integer orderCnt;         //주문건수
	private Integer orderAmt;         //구매금액
	private String bsAddr;            //주소
	private String bsAddr1;            //주소1
	private String bsAddr2;            //주소2
	private String bsAddr3;            //주소3
	private String dtlAddr1;            //상세주소1
	private String dtlAddr2;            //상세주소2
	private String dtlAddr3;            //상세주소3
	private String countOrd;          //구매횟수
	private String slPrc;             //구매 총금액
	private String grdNm;             //등급명
	private String siteDesc;          //사이트 
	private Integer cmtCnt;			  //코멘트갯수
	private String wdrwYn;            //탈퇴 여부 
	private String wdrwRsnCd;         //탈퇴 사유 코드
	private String wdrwDtlRsn;        //탈퇴 상세 사유 
	
	private Integer curDcPer;         //회원등급할인율
	private Integer curRsvPer;         //회원등급적립률
	
	public String getWdrwRsnCd() {
		return wdrwRsnCd;
	}
	public void setWdrwRsnCd(String wdrwRsnCd) {
		this.wdrwRsnCd = wdrwRsnCd;
	}
	public String getWdrwDtlRsn() {
		return wdrwDtlRsn;
	}
	public void setWdrwDtlRsn(String wdrwDtlRsn) {
		this.wdrwDtlRsn = wdrwDtlRsn;
	}
	public String getWdrwYn() {
		return wdrwYn;
	}
	public void setWdrwYn(String wdrwYn) {
		this.wdrwYn = wdrwYn;
	}
	public Integer getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(Integer cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	public String getSiteDesc() {
		return siteDesc;
	}
	public void setSiteDesc(String siteDesc) {
		this.siteDesc = siteDesc;
	}
	public String getGrdNm() {
		return grdNm;
	}
	public void setGrdNm(String grdNm) {
		this.grdNm = grdNm;
	}
	public Date getLoginDts() {
		return loginDts;
	}
	public void setLoginDts(Date loginDts) {
		this.loginDts = loginDts;
	}
	public String getCountOrd() {
		return countOrd;
	}
	public void setCountOrd(String countOrd) {
		this.countOrd = countOrd;
	}
	public String getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(String slPrc) {
		this.slPrc = slPrc;
	}
	public String getBsAddr() {
		return bsAddr;
	}
	public void setBsAddr(String bsAddr) {
		this.bsAddr = bsAddr;
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
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Integer getMemGrdNo() {
		return memGrdNo;
	}
	public void setMemGrdNo(Integer memGrdNo) {
		this.memGrdNo = memGrdNo;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(Date birthDt) {
		this.birthDt = birthDt;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMySlfCertYn() {
		return mySlfCertYn;
	}
	public void setMySlfCertYn(String mySlfCertYn) {
		this.mySlfCertYn = mySlfCertYn;
	}
	public String getCpNo() {
		return cpNo;
	}
	public void setCpNo(String cpNo) {
		this.cpNo = cpNo;
	}
	public String getMailSndYn() {
		return mailSndYn;
	}
	public void setMailSndYn(String mailSndYn) {
		this.mailSndYn = mailSndYn;
	}
	public String getSmsSndYn() {
		return smsSndYn;
	}
	public void setSmsSndYn(String smsSndYn) {
		this.smsSndYn = smsSndYn;
	}
	public String getCountryCd() {
		return countryCd;
	}
	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}
	public String getJoinPathCd() {
		return joinPathCd;
	}
	public void setJoinPathCd(String joinPathCd) {
		this.joinPathCd = joinPathCd;
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
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Integer getCurPoint() {
		if(curPoint < 0){
			curPoint = 0;
		}
		return curPoint;
	}
	public void setCurPoint(Integer curPoint) {
		this.curPoint = curPoint;
	}
	public Integer getLoginCnt() {
		return loginCnt;
	}
	public void setLoginCnt(Integer loginCnt) {
		this.loginCnt = loginCnt;
	}
	public Integer getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(Integer orderCnt) {
		this.orderCnt = orderCnt;
	}
	public Integer getOrderAmt() {
		return orderAmt;
	}
	public void setOrderAmt(Integer orderAmt) {
		this.orderAmt = orderAmt;
	}
	public Integer getCurDcPer() {
		return curDcPer;
	}
	public void setCurDcPer(Integer curDcPer) {
		this.curDcPer = curDcPer;
	}
	public Integer getCurRsvPer() {
		return curRsvPer;
	}
	public void setCurRsvPer(Integer curRsvPer) {
		this.curRsvPer = curRsvPer;
	}
	public String getBsAddr1() {
		return bsAddr1;
	}
	public void setBsAddr1(String bsAddr1) {
		this.bsAddr1 = bsAddr1;
	}
	public String getBsAddr2() {
		return bsAddr2;
	}
	public void setBsAddr2(String bsAddr2) {
		this.bsAddr2 = bsAddr2;
	}
	public String getBsAddr3() {
		return bsAddr3;
	}
	public void setBsAddr3(String bsAddr3) {
		this.bsAddr3 = bsAddr3;
	}
	public String getDtlAddr1() {
		return dtlAddr1;
	}
	public void setDtlAddr1(String dtlAddr1) {
		this.dtlAddr1 = dtlAddr1;
	}
	public String getDtlAddr2() {
		return dtlAddr2;
	}
	public void setDtlAddr2(String dtlAddr2) {
		this.dtlAddr2 = dtlAddr2;
	}
	public String getDtlAddr3() {
		return dtlAddr3;
	}
	public void setDtlAddr3(String dtlAddr3) {
		this.dtlAddr3 = dtlAddr3;
	}
	public String getRegrNm() {
		return regrNm;
	}
	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}
	
	
}
