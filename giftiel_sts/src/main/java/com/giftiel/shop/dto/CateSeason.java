package com.giftiel.shop.dto;

public class CateSeason {

	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer seasonSeq;         //시즌 시퀀스 
	private Integer siteNo;         //사이트 번호 
	private String seasonCd;         //시즌코드 
	private String seasonGubun;         //시즌구분 코드 
	private String seasonCdDisp;         //시즌코드명 별칭 
	private String seasonStart;         //시즌 시작시간 
	private String seasonEnd;         //시즌 종료시간 
	private String dispYn;         //노출여부
	private String useYn;         //사용여부 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	private String topYn;         //우선노출여부
	
	
	private boolean test;         //수정일시
	
	
	
	
	public String getTopYn() {
		return topYn;
	}
	public void setTopYn(String topYn) {
		this.topYn = topYn;
	}
	public boolean isTest() {
		return test;
	}
	public void setTest(boolean test) {
		this.test = test;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
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
	public Integer getSeasonSeq() {
		return seasonSeq;
	}
	public void setSeasonSeq(Integer seasonSeq) {
		this.seasonSeq = seasonSeq;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
	public String getSeasonCd() {
		return seasonCd;
	}
	public void setSeasonCd(String seasonCd) {
		this.seasonCd = seasonCd;
	}
	public String getSeasonGubun() {
		return seasonGubun;
	}
	public void setSeasonGubun(String seasonGubun) {
		this.seasonGubun = seasonGubun;
	}
	public String getSeasonCdDisp() {
		return seasonCdDisp;
	}
	public void setSeasonCdDisp(String seasonCdDisp) {
		this.seasonCdDisp = seasonCdDisp;
	}
	public String getSeasonStart() {
		return seasonStart;
	}
	public void setSeasonStart(String seasonStart) {
		this.seasonStart = seasonStart;
	}
	public String getSeasonEnd() {
		return seasonEnd;
	}
	public void setSeasonEnd(String seasonEnd) {
		this.seasonEnd = seasonEnd;
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
	
	
	
	
	
	}
