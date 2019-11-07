package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;


public class OrderGoods {
/*	private UBIGoods ubiGoods;	 //UBI상품정보
	private List<GoodsTag> goodsTags;	 //상품키워드정보
	private List<GoodsImage> goodsImages;	 //상품이미지정보
*/	
	private List<GoodsSize> goodsSizes;	 //상품사이즈차트
	private List<OrderDlvCmp> orderDlvCmp;//택배사
	
	private Integer rnum;        //번호
	private String ordNo;         //주문번호 
	private Integer ordGdsSeq;         //주문상품일련번호 
	private Integer ordDlvNo;         //주문배송번호 
	 
	private Integer expPnt;         //적립예정포인트
	private Integer usePnt;         //사용포인트
	private Integer expPntTot;         //적립예정포인트 합
	
	private String ubiGdsNo;         //UBI상품번호 
	private String ubiGdsNm;         //UBI상품명
	private String ubiGdsSize;         //UBI상품SIZE
	private String brnd;         //브랜드
	private String ubiGdsColorNm;         //색상
	private String ubiGdsColorCd;         //색상코드
	private String brand;         //색상코드
	
	
	private Integer ordQty;         //주문수량 
	private Integer slPrc;         //판매가 
	private Integer slPrcTot;         //판매가 합
	private Integer actlPayPrc;         //실결제가 
	private String perOrdStat;         //개별주문상태
	private String perOrdStatNm;         //개별주문상태명
	private Integer slFeeRt;         //판매수수료율 
	private Date sndExpDts;         //발송예정일시 
	private String gdsDlvCstPayway;         //상품배송비지불방식 
	private Integer cnclQty;         //취소수량 
	private Date sndPosbTm;         //발송가능시간 
	private Date sndCmplDts;         //발송완료일시 
	private Integer sndCplNo;         //발송완료처리자 
	private String invNo;         //송장번호 
	private Integer dlvCmpNo;         //택배사번호 
	private String dlvCmpNm;         //택배사명
	
	private String mngrMemo;         //관리자메모 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private String mainImg;         //메인 IMG 
	
	private Integer payAmt;         //결제금액 
	private String chgUbiGdsSize; // 변경할 상품사이즈
	private String siteNm; 				//매장명
	private Integer chgDlvCmpNo;//변경할 택배사 번호
	private String chgInvNo; //변경할 송장 번호
	
	private String seasongroupCode;         //카테고리1 
	private String category1Code;         //카테고리2 
	private String category2Code;         //카테고리3
	
	private String barcode;         //바코드 
	
	private String dlvRsPage;         //택배조회주소
	
	private String color; //색상
	
	//쿠폰관련
	private String cpnNo; //쿠폰번호
	private String offCpnNo; //오프라인쿠폰번호
	private Integer cpnPayAmt; //쿠폰적용금액
	
	private String mZone;
	private String cCode;
	private String location;
	
	public List<GoodsSize> getGoodsSizes() {
		return goodsSizes;
	}
	public void setGoodsSizes(List<GoodsSize> goodsSizes) {
		this.goodsSizes = goodsSizes;
	}
	public List<OrderDlvCmp> getOrderDlvCmp() {
		return orderDlvCmp;
	}
	public void setOrderDlvCmp(List<OrderDlvCmp> orderDlvCmp) {
		this.orderDlvCmp = orderDlvCmp;
	}
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getOrdGdsSeq() {
		return ordGdsSeq;
	}
	public void setOrdGdsSeq(Integer ordGdsSeq) {
		this.ordGdsSeq = ordGdsSeq;
	}
	public Integer getOrdDlvNo() {
		return ordDlvNo;
	}
	public void setOrdDlvNo(Integer ordDlvNo) {
		this.ordDlvNo = ordDlvNo;
	}
	public Integer getExpPnt() {
		return expPnt;
	}
	public void setExpPnt(Integer expPnt) {
		this.expPnt = expPnt;
	}
	public Integer getExpPntTot() {
		return expPntTot;
	}
	public void setExpPntTot(Integer expPntTot) {
		this.expPntTot = expPntTot;
	}
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public String getUbiGdsNm() {
		return ubiGdsNm;
	}
	public void setUbiGdsNm(String ubiGdsNm) {
		this.ubiGdsNm = ubiGdsNm;
	}
	public String getUbiGdsSize() {
		return ubiGdsSize;
	}
	public void setUbiGdsSize(String ubiGdsSize) {
		this.ubiGdsSize = ubiGdsSize;
	}

	public String getBrnd() {
		return brnd;
	}
	public void setBrnd(String brnd) {
		this.brnd = brnd;
	}
	public String getUbiGdsColorNm() {
		return ubiGdsColorNm;
	}
	public void setUbiGdsColorNm(String ubiGdsColorNm) {
		this.ubiGdsColorNm = ubiGdsColorNm;
	}
	public Integer getOrdQty() {
		return ordQty;
	}
	public void setOrdQty(Integer ordQty) {
		this.ordQty = ordQty;
	}
	public Integer getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(Integer slPrc) {
		this.slPrc = slPrc;
	}
	public Integer getSlPrcTot() {
		return slPrcTot;
	}
	public void setSlPrcTot(Integer slPrcTot) {
		this.slPrcTot = slPrcTot;
	}
	public Integer getActlPayPrc() {
		return actlPayPrc;
	}
	public void setActlPayPrc(Integer actlPayPrc) {
		this.actlPayPrc = actlPayPrc;
	}
	public String getPerOrdStat() {
		return perOrdStat;
	}
	public void setPerOrdStat(String perOrdStat) {
		this.perOrdStat = perOrdStat;
	}
	public String getPerOrdStatNm() {
		return perOrdStatNm;
	}
	public void setPerOrdStatNm(String perOrdStatNm) {
		this.perOrdStatNm = perOrdStatNm;
	}
	public Integer getSlFeeRt() {
		return slFeeRt;
	}
	public void setSlFeeRt(Integer slFeeRt) {
		this.slFeeRt = slFeeRt;
	}
	public Date getSndExpDts() {
		return sndExpDts;
	}
	public void setSndExpDts(Date sndExpDts) {
		this.sndExpDts = sndExpDts;
	}
	public String getGdsDlvCstPayway() {
		return gdsDlvCstPayway;
	}
	public void setGdsDlvCstPayway(String gdsDlvCstPayway) {
		this.gdsDlvCstPayway = gdsDlvCstPayway;
	}
	public Integer getCnclQty() {
		return cnclQty;
	}
	public void setCnclQty(Integer cnclQty) {
		this.cnclQty = cnclQty;
	}
	public Date getSndPosbTm() {
		return sndPosbTm;
	}
	public void setSndPosbTm(Date sndPosbTm) {
		this.sndPosbTm = sndPosbTm;
	}
	public Date getSndCmplDts() {
		return sndCmplDts;
	}
	public void setSndCmplDts(Date sndCmplDts) {
		this.sndCmplDts = sndCmplDts;
	}
	public Integer getSndCplNo() {
		return sndCplNo;
	}
	public void setSndCplNo(Integer sndCplNo) {
		this.sndCplNo = sndCplNo;
	}
	public String getInvNo() {
		return invNo;
	}
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}
	public Integer getDlvCmpNo() {
		return dlvCmpNo;
	}
	public void setDlvCmpNo(Integer dlvCmpNo) {
		this.dlvCmpNo = dlvCmpNo;
	}
	public String getDlvCmpNm() {
		return dlvCmpNm;
	}
	public void setDlvCmpNm(String dlvCmpNm) {
		this.dlvCmpNm = dlvCmpNm;
	}
	public String getMngrMemo() {
		return mngrMemo;
	}
	public void setMngrMemo(String mngrMemo) {
		this.mngrMemo = mngrMemo;
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
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public Integer getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(Integer payAmt) {
		this.payAmt = payAmt;
	}
	public String getChgUbiGdsSize() {
		return chgUbiGdsSize;
	}
	public void setChgUbiGdsSize(String chgUbiGdsSize) {
		this.chgUbiGdsSize = chgUbiGdsSize;
	}
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	public Integer getChgDlvCmpNo() {
		return chgDlvCmpNo;
	}
	public void setChgDlvCmpNo(Integer chgDlvCmpNo) {
		this.chgDlvCmpNo = chgDlvCmpNo;
	}
	public String getChgInvNo() {
		return chgInvNo;
	}
	public void setChgInvNo(String chgInvNo) {
		this.chgInvNo = chgInvNo;
	}
	public String getUbiGdsColorCd() {
		return ubiGdsColorCd;
	}
	public void setUbiGdsColorCd(String ubiGdsColorCd) {
		this.ubiGdsColorCd = ubiGdsColorCd;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSeasongroupCode() {
		return seasongroupCode;
	}
	public void setSeasongroupCode(String seasongroupCode) {
		this.seasongroupCode = seasongroupCode;
	}
	public String getCategory1Code() {
		return category1Code;
	}
	public void setCategory1Code(String category1Code) {
		this.category1Code = category1Code;
	}
	public String getCategory2Code() {
		return category2Code;
	}
	public void setCategory2Code(String category2Code) {
		this.category2Code = category2Code;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public Integer getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(Integer usePnt) {
		this.usePnt = usePnt;
	}
	public String getDlvRsPage() {
		return dlvRsPage;
	}
	public void setDlvRsPage(String dlvRsPage) {
		this.dlvRsPage = dlvRsPage;
	}
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getOffCpnNo() {
		return offCpnNo;
	}
	public void setOffCpnNo(String offCpnNo) {
		this.offCpnNo = offCpnNo;
	}
	public Integer getCpnPayAmt() {
		return cpnPayAmt;
	}
	public void setCpnPayAmt(Integer cpnPayAmt) {
		this.cpnPayAmt = cpnPayAmt;
	}
	public String getmZone() {
		return mZone;
	}
	public void setmZone(String mZone) {
		this.mZone = mZone;
	}
	public String getcCode() {
		return cCode;
	}
	public void setcCode(String cCode) {
		this.cCode = cCode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
}