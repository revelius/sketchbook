package com.giftiel.shop.dto;

public class ZipCode {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private String lawDongCd;         //법정동코드 
	private String sidoNm;         //시도명 
	private String sigunguNm;         //시군구명 
	private String lawEmdNm;         //법정읍면동명 
	private String lawLiNm;         //법정리명 
	private String sanYn;         //산여부 0:토지,1:산 
	private Integer jibunBon;         //지번본번 
	private Integer jibunBu;         //지번부번 
	private String loadCd;         //도로명코드 시군구(5)+도로명번호(7) 
	private String loadNm;         //도로명 
	private String underYn;         //지하여부 0:지상, 1:지하, 2:공중 
	private Integer buildBon;         //건물본번 
	private Integer buildBu;         //건물부번 
	private String buildNm;         //건축물대장 건물명 
	private String buildNmDetail;         //상세건물명 
	private String buildNo;         //건물관리번호 고유식별컬럼 
	private String emdNo;         //읍면동일련번호 
	private String admDongCd;         //행정동코드 
	private String admDongNm;         //행정동명 
	private String zipCd;         //우편번호 
	private String zipNo;         //우편일련번호 
	private String muchDeliveNm;         //다량배달처명 
	private String reasonMoveCd;         //이동사유코드 
	private String changeDate;         //변경일자 
	private String preChangeLoad;         //변경전도로명주소 
	private String sigunguBuildNm;         //시군구용 건물명 참고용 
	private String apartYn;         //공동주택여부 0:비공동주택, 1:공동주택 
	private String address;
	
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
	public String getLawDongCd() {
		return lawDongCd;
	}
	public void setLawDongCd(String lawDongCd) {
		this.lawDongCd = lawDongCd;
	}
	public String getSidoNm() {
		return sidoNm;
	}
	public void setSidoNm(String sidoNm) {
		this.sidoNm = sidoNm;
	}
	public String getSigunguNm() {
		return sigunguNm;
	}
	public void setSigunguNm(String sigunguNm) {
		this.sigunguNm = sigunguNm;
	}
	public String getLawEmdNm() {
		return lawEmdNm;
	}
	public void setLawEmdNm(String lawEmdNm) {
		this.lawEmdNm = lawEmdNm;
	}
	public String getLawLiNm() {
		return lawLiNm;
	}
	public void setLawLiNm(String lawLiNm) {
		this.lawLiNm = lawLiNm;
	}
	public String getSanYn() {
		return sanYn;
	}
	public void setSanYn(String sanYn) {
		this.sanYn = sanYn;
	}
	public Integer getJibunBon() {
		return jibunBon;
	}
	public void setJibunBon(Integer jibunBon) {
		this.jibunBon = jibunBon;
	}
	public Integer getJibunBu() {
		return jibunBu;
	}
	public void setJibunBu(Integer jibunBu) {
		this.jibunBu = jibunBu;
	}
	public String getLoadCd() {
		return loadCd;
	}
	public void setLoadCd(String loadCd) {
		this.loadCd = loadCd;
	}
	public String getLoadNm() {
		return loadNm;
	}
	public void setLoadNm(String loadNm) {
		this.loadNm = loadNm;
	}
	public String getUnderYn() {
		return underYn;
	}
	public void setUnderYn(String underYn) {
		this.underYn = underYn;
	}
	public Integer getBuildBon() {
		return buildBon;
	}
	public void setBuildBon(Integer buildBon) {
		this.buildBon = buildBon;
	}
	public Integer getBuildBu() {
		return buildBu;
	}
	public void setBuildBu(Integer buildBu) {
		this.buildBu = buildBu;
	}
	public String getBuildNm() {
		return buildNm;
	}
	public void setBuildNm(String buildNm) {
		this.buildNm = buildNm;
	}
	public String getBuildNmDetail() {
		return buildNmDetail;
	}
	public void setBuildNmDetail(String buildNmDetail) {
		this.buildNmDetail = buildNmDetail;
	}
	public String getBuildNo() {
		return buildNo;
	}
	public void setBuildNo(String buildNo) {
		this.buildNo = buildNo;
	}
	public String getEmdNo() {
		return emdNo;
	}
	public void setEmdNo(String emdNo) {
		this.emdNo = emdNo;
	}
	public String getAdmDongCd() {
		return admDongCd;
	}
	public void setAdmDongCd(String admDongCd) {
		this.admDongCd = admDongCd;
	}
	public String getAdmDongNm() {
		return admDongNm;
	}
	public void setAdmDongNm(String admDongNm) {
		this.admDongNm = admDongNm;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getZipNo() {
		return zipNo;
	}
	public void setZipNo(String zipNo) {
		this.zipNo = zipNo;
	}
	public String getMuchDeliveNm() {
		return muchDeliveNm;
	}
	public void setMuchDeliveNm(String muchDeliveNm) {
		this.muchDeliveNm = muchDeliveNm;
	}
	public String getReasonMoveCd() {
		return reasonMoveCd;
	}
	public void setReasonMoveCd(String reasonMoveCd) {
		this.reasonMoveCd = reasonMoveCd;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
	public String getPreChangeLoad() {
		return preChangeLoad;
	}
	public void setPreChangeLoad(String preChangeLoad) {
		this.preChangeLoad = preChangeLoad;
	}
	public String getSigunguBuildNm() {
		return sigunguBuildNm;
	}
	public void setSigunguBuildNm(String sigunguBuildNm) {
		this.sigunguBuildNm = sigunguBuildNm;
	}
	public String getApartYn() {
		return apartYn;
	}
	public void setApartYn(String apartYn) {
		this.apartYn = apartYn;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}