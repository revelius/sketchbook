package com.giftiel.shop.dto;

public class MailManage {
	private Integer rnum;        	//번호
	private Integer totalCnt;       //총 갯수
	private Integer startListNum;   //페이징 시작번호
	private Integer endListNum;     //페이징 끝번호
	private Integer sndHistNo;      //발송이력번호 
	private String sndrEmail;       //발송자이메일 
	private String rcvrEmail;       //수신자이메일 
	private String tmplUrl;         //템플릿URL 
	private String title;         	//제목 
	private String txtHtml;         //내용HTML 
	private String sndDts;         	//발송일시 
	private String atchFile;        //첨부파일 
	private Integer regrNo;         //등록자 
	private String regDts;         	//등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         	//수정일시
	private String rsvTgGb;         //수신대상구분
	private String rsvTg;         	//수신대상
	private String sndrName;         //발신자명
	
	private String getBrnd;			// 브랜드명
	private String getMember;			// 등급명
	private String regUserNm;		//작성자 명
	
	
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
	public Integer getSndHistNo() {
		return sndHistNo;
	}
	public void setSndHistNo(Integer sndHistNo) {
		this.sndHistNo = sndHistNo;
	}
	public String getSndrEmail() {
		return sndrEmail;
	}
	public void setSndrEmail(String sndrEmail) {
		this.sndrEmail = sndrEmail;
	}
	public String getRcvrEmail() {
		return rcvrEmail;
	}
	public void setRcvrEmail(String rcvrEmail) {
		this.rcvrEmail = rcvrEmail;
	}
	public String getTmplUrl() {
		return tmplUrl;
	}
	public void setTmplUrl(String tmplUrl) {
		this.tmplUrl = tmplUrl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTxtHtml() {
		return txtHtml;
	}
	public void setTxtHtml(String txtHtml) {
		this.txtHtml = txtHtml;
	}
	public String getSndDts() {
		return sndDts;
	}
	public void setSndDts(String sndDts) {
		this.sndDts = sndDts;
	}
	public String getAtchFile() {
		return atchFile;
	}
	public void setAtchFile(String atchFile) {
		this.atchFile = atchFile;
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
	public String getRsvTgGb() {
		return rsvTgGb;
	}
	public void setRsvTgGb(String rsvTgGb) {
		this.rsvTgGb = rsvTgGb;
	}
	public String getRsvTg() {
		return rsvTg;
	}
	public void setRsvTg(String rsvTg) {
		this.rsvTg = rsvTg;
	}
	public String getGetBrnd() {
		return getBrnd;
	}
	public void setGetBrnd(String getBrnd) {
		this.getBrnd = getBrnd;
	}
	public String getSndrName() {
		return sndrName;
	}
	public void setSndrName(String sndrName) {
		this.sndrName = sndrName;
	}
	
	public String getGetMember() {
		return getMember;
	}
	public void setGetMember(String getMember) {
		this.getMember = getMember;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	
	
}
