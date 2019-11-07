package com.giftiel.shop.dto;


public class Menu {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer menuNo;         //메뉴번호 
	private Integer supMenuNo;         //상위메뉴번호 
	private String menuNm;         //메뉴명 
	private String menuTp;         //메뉴유형 
	private String pageUrl;         //페이지URL 
	private String useYn;         //사용여부 
	private Integer prir;         //우선순위 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	
	private String supMenuNM;         //상위메뉴명

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

	public Integer getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(Integer menuNo) {
		this.menuNo = menuNo;
	}

	public Integer getSupMenuNo() {
		return supMenuNo;
	}

	public void setSupMenuNo(Integer supMenuNo) {
		this.supMenuNo = supMenuNo;
	}

	public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

	public String getMenuTp() {
		return menuTp;
	}

	public void setMenuTp(String menuTp) {
		this.menuTp = menuTp;
	}

	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
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

	public void setUpdDts(String updDts) {
		this.updDts = updDts;
	}

	public String getSupMenuNM() {
		return supMenuNM;
	}

	public void setSupMenuNM(String supMenuNM) {
		this.supMenuNM = supMenuNM;
	}
	
	
	
	
	
}
