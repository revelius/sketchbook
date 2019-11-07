package com.giftiel.shop.dto;

import java.util.List;


public class IntgBoard {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer txtNo;         //게시물번호 
	private String boardClcd;         //게시판분류코드 
	private Integer siteNo;         //사이트번호 
	private String dispYn;         //전시여부 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	private String title;         //제목 
	private String lnkUrl;         //연결URL 
	
	private String regUserNm; //작성자 명
	private String imgUrl; //이미지 URL
	private Integer imgSeq; //이미지 URL
	
	private String seasonCd; //시즌코드
	private String clbltnNm; //콜라보레이션 명
	
	
	private List<IntgBoardCnts> intgBoardCnts; //추가 이미지
	
	
	
	
	public String getSeasonCd() {
		return seasonCd;
	}
	public void setSeasonCd(String seasonCd) {
		this.seasonCd = seasonCd;
	}
	public String getClbltnNm() {
		return clbltnNm;
	}
	public void setClbltnNm(String clbltnNm) {
		this.clbltnNm = clbltnNm;
	}
	public List<IntgBoardCnts> getIntgBoardCnts() {
		return intgBoardCnts;
	}
	public void setIntgBoardCnts(List<IntgBoardCnts> intgBoardCnts) {
		this.intgBoardCnts = intgBoardCnts;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
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
	public Integer getTxtNo() {
		return txtNo;
	}
	public void setTxtNo(Integer txtNo) {
		this.txtNo = txtNo;
	}
	public String getBoardClcd() {
		return boardClcd;
	}
	public void setBoardClcd(String boardClcd) {
		this.boardClcd = boardClcd;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLnkUrl() {
		return lnkUrl;
	}
	public void setLnkUrl(String lnkUrl) {
		this.lnkUrl = lnkUrl;
	}
	public Integer getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(Integer imgSeq) {
		this.imgSeq = imgSeq;
	}
}
