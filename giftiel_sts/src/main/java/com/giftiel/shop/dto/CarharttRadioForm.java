package com.giftiel.shop.dto;


public class CarharttRadioForm {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer radioNo;         //라디오번호 
	private String dispYn;         //전시여부 
	private String banImgUrl;         //배너이미지 URL 
	private String cvImgUrl;         //커버이미지 URL 
	private String bgImgUrl;         //배경이미지 URL 
	private String radioLink;         //라디오링크 
	private String radioTitle;         //제목 
	private String radioArtist;         //아티스트 
	private String radioInfo;         //정보 
	private String radioTrackList;         //트랙리스트 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	private String radioArtistInfo;		//아티스트정보
	private String regUserNm;		//작성자이름
	
	private String type;		//페이지 타입
	
	private String frontBgImgUrl;		
	
	
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
	public Integer getRadioNo() {
		return radioNo;
	}
	public void setRadioNo(Integer radioNo) {
		this.radioNo = radioNo;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getBanImgUrl() {
		return banImgUrl;
	}
	public void setBanImgUrl(String banImgUrl) {
		this.banImgUrl = banImgUrl;
	}
	public String getCvImgUrl() {
		return cvImgUrl;
	}
	public void setCvImgUrl(String cvImgUrl) {
		this.cvImgUrl = cvImgUrl;
	}
	public String getBgImgUrl() {
		return bgImgUrl;
	}
	public void setBgImgUrl(String bgImgUrl) {
		this.bgImgUrl = bgImgUrl;
	}
	public String getRadioLink() {
		return radioLink;
	}
	public void setRadioLink(String radioLink) {
		this.radioLink = radioLink;
	}
	public String getRadioTitle() {
		return radioTitle;
	}
	public void setRadioTitle(String radioTitle) {
		this.radioTitle = radioTitle;
	}
	public String getRadioArtist() {
		return radioArtist;
	}
	public void setRadioArtist(String radioArtist) {
		this.radioArtist = radioArtist;
	}
	public String getRadioInfo() {
		return radioInfo;
	}
	public void setRadioInfo(String radioInfo) {
		this.radioInfo = radioInfo;
	}
	public String getRadioTrackList() {
		return radioTrackList;
	}
	public void setRadioTrackList(String radioTrackList) {
		this.radioTrackList = radioTrackList;
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
	public String getRadioArtistInfo() {
		return radioArtistInfo;
	}
	public void setRadioArtistInfo(String radioArtistInfo) {
		this.radioArtistInfo = radioArtistInfo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	public String getFrontBgImgUrl() {
		return frontBgImgUrl;
	}
	public void setFrontBgImgUrl(String frontBgImgUrl) {
		this.frontBgImgUrl = frontBgImgUrl;
	}
}