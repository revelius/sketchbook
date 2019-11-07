package com.giftiel.shop.dto;

import java.util.List;


public class News {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer txtNo;         //게시물번호 
	private String title;         //제목 
	private String txt;         //내용 
	private String txtTp;         //게시물유형 
	private String txtCls;         //게시물구분 
	private String movUrl;         //동영상주소 
	private String imgUrl;         //이미지 URL 
	private String dispYn;         //전시여부 
	private Integer readCnt;         //조회수 
	private Integer prir;         //우선순위 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	private String etc1;         //기타1 
	private String etc2;         //기타2 	
	private String sldDispYn;         //슬라이드사용여부 
	private String thmbUrl;         //썸네일 
	private String preview;         //프리뷰 
	
	private String regUserNm; //작성자 명
	private Integer[] siteNo;   //사이트번호
	
	
	private List<NewsSite> newsSite; 
	
	
	private List<NewsCont> newsCont;    //추가컨텐츠

	private String topBnnrDispYn;         //상단배너 노출여부 

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


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getTxt() {
		return txt;
	}


	public void setTxt(String txt) {
		this.txt = txt;
	}


	public String getTxtTp() {
		return txtTp;
	}


	public void setTxtTp(String txtTp) {
		this.txtTp = txtTp;
	}


	public String getTxtCls() {
		return txtCls;
	}


	public void setTxtCls(String txtCls) {
		this.txtCls = txtCls;
	}


	public String getMovUrl() {
		return movUrl;
	}


	public void setMovUrl(String movUrl) {
		this.movUrl = movUrl;
	}


	public String getImgUrl() {
		return imgUrl;
	}


	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}


	public String getDispYn() {
		return dispYn;
	}


	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}


	public Integer getReadCnt() {
		return readCnt;
	}


	public void setReadCnt(Integer readCnt) {
		this.readCnt = readCnt;
	}


	public Integer getPrir() {
		return prir;
	}


	public void setPrir(Integer prir) {
		this.prir = prir;
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

	public String getEtc1() {
		return etc1;
	}


	public void setEtc1(String etc1) {
		this.etc1 = etc1;
	}


	public String getEtc2() {
		return etc2;
	}


	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}

	public String getSldDispYn() {
		return sldDispYn;
	}


	public void setSldDispYn(String sldDispYn) {
		this.sldDispYn = sldDispYn;
	}


	public String getThmbUrl() {
		return thmbUrl;
	}


	public void setThmbUrl(String thmbUrl) {
		this.thmbUrl = thmbUrl;
	}

	public String getPreview() {
		return preview;
	}


	public void setPreview(String preview) {
		this.preview = preview;
	}


	public void setUpdDts(String updDts) {
		this.updDts = updDts;
	}


	public String getRegUserNm() {
		return regUserNm;
	}


	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}


	public Integer[] getSiteNo() {
		return siteNo;
	}


	public void setSiteNo(Integer[] siteNo) {
		this.siteNo = siteNo;
	}


	public List<NewsSite> getNewsSite() {
		return newsSite;
	}


	public void setNewsSite(List<NewsSite> newsSite) {
		this.newsSite = newsSite;
	}


	public List<NewsCont> getNewsCont() {
		return newsCont;
	}


	public void setNewsCont(List<NewsCont> newsCont) {
		this.newsCont = newsCont;
	}


	public String getTopBnnrDispYn() {
		return topBnnrDispYn;
	}


	public void setTopBnnrDispYn(String topBnnrDispYn) {
		this.topBnnrDispYn = topBnnrDispYn;
	} 
	
}
