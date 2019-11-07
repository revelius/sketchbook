package com.giftiel.shop.dto;


public class UbiOrder {
	private String 판매일자;		private String ordDts;
	private String 매장코드;		private String sellerCode;
	private String 판매번호;		private String saleNo;
	private String 판매연번;		private String saleSeq;
	private String 작업구분;		private String ordGubun;
	private String 품번;			private String ubiGdsNo;
	private String 색상;			private String ubiGdsColor;
	private String 사이즈;			private String ubiGdsSize;
	private Integer 판매수량;		private Integer ordCnt;
	private Integer 실판매금액;		private Integer actlPrc;
	private String 온라인고객코드;	private String memNo;
	private Integer 적립율;			private Integer expPer;
	private Integer 적립포인트;		private Integer expPnt;
	private Integer 사용포인트;		private Integer usePnt;
	private String 수정여부;		private String updateYn;
	private String 처리여부;		private String confirmYn;
	private String 에러사유;		private String errorDesc;
	private String 입력일;			private String regDtm;
	private String 주문번호;		private String ordNo;
	private String 변경사이즈;
	
	public String get판매일자() {
		return 판매일자;
	}
	public void set판매일자(String 판매일자) {
		this.판매일자 = 판매일자;
	}
	public String get매장코드() {
		return 매장코드;
	}
	public void set매장코드(String 매장코드) {
		this.매장코드 = 매장코드;
	}
	public String get판매번호() {
		return 판매번호;
	}
	public void set판매번호(String 판매번호) {
		this.판매번호 = 판매번호;
	}
	public String get판매연번() {
		return 판매연번;
	}
	public void set판매연번(String 판매연번) {
		this.판매연번 = 판매연번;
	}
	public String get작업구분() {
		return 작업구분;
	}
	public void set작업구분(String 작업구분) {
		this.작업구분 = 작업구분;
	}
	public String get품번() {
		return 품번;
	}
	public void set품번(String 품번) {
		this.품번 = 품번;
	}
	public String get색상() {
		return 색상;
	}
	public void set색상(String 색상) {
		this.색상 = 색상;
	}
	public String get사이즈() {
		return 사이즈;
	}
	public void set사이즈(String 사이즈) {
		this.사이즈 = 사이즈;
	}
	public Integer get판매수량() {
		return 판매수량;
	}
	public void set판매수량(Integer 판매수량) {
		this.판매수량 = 판매수량;
	}
	public Integer get실판매금액() {
		return 실판매금액;
	}
	public void set실판매금액(Integer 실판매금액) {
		this.실판매금액 = 실판매금액;
	}
	public String get온라인고객코드() {
		return 온라인고객코드;
	}
	public void set온라인고객코드(String 온라인고객코드) {
		this.온라인고객코드 = 온라인고객코드;
	}
	public Integer get적립율() {
		return 적립율;
	}
	public void set적립율(Integer 적립율) {
		this.적립율 = 적립율;
	}
	public Integer get적립포인트() {
		return 적립포인트;
	}
	public void set적립포인트(Integer 적립포인트) {
		this.적립포인트 = 적립포인트;
	}
	public Integer get사용포인트() {
		return 사용포인트;
	}
	public void set사용포인트(Integer 사용포인트) {
		this.사용포인트 = 사용포인트;
	}
	public String get수정여부() {
		return 수정여부;
	}
	public void set수정여부(String 수정여부) {
		this.수정여부 = 수정여부;
	}
	public String get처리여부() {
		return 처리여부;
	}
	public void set처리여부(String 처리여부) {
		this.처리여부 = 처리여부;
	}
	public String get에러사유() {
		return 에러사유;
	}
	public void set에러사유(String 에러사유) {
		this.에러사유 = 에러사유;
	}
	public String get입력일() {
		return 입력일;
	}
	public void set입력일(String 입력일) {
		this.입력일 = 입력일;
	}
	public String get주문번호() {
		return 주문번호;
	}
	public void set주문번호(String 주문번호) {
		this.주문번호 = 주문번호;
	}
	public String getUbiGdsNo() {
		ubiGdsNo = 품번;
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public String get변경사이즈() {
		return 변경사이즈;
	}
	public void set변경사이즈(String 변경사이즈) {
		this.변경사이즈 = 변경사이즈;
	}
	public String getOrdDts() {
		return ordDts;
	}
	public void setOrdDts(String ordDts) {
		this.ordDts = ordDts;
	}
	public String getSellerCode() {
		return sellerCode;
	}
	public void setSellerCode(String sellerCode) {
		this.sellerCode = sellerCode;
	}
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	public String getSaleSeq() {
		return saleSeq;
	}
	public void setSaleSeq(String saleSeq) {
		this.saleSeq = saleSeq;
	}
	public String getOrdGubun() {
		return ordGubun;
	}
	public void setOrdGubun(String ordGubun) {
		this.ordGubun = ordGubun;
	}
	public String getUbiGdsColor() {
		return ubiGdsColor;
	}
	public void setUbiGdsColor(String ubiGdsColor) {
		this.ubiGdsColor = ubiGdsColor;
	}
	public String getUbiGdsSize() {
		return ubiGdsSize;
	}
	public void setUbiGdsSize(String ubiGdsSize) {
		this.ubiGdsSize = ubiGdsSize;
	}
	public Integer getOrdCnt() {
		return ordCnt;
	}
	public void setOrdCnt(Integer ordCnt) {
		this.ordCnt = ordCnt;
	}
	public Integer getActlPrc() {
		return actlPrc;
	}
	public void setActlPrc(Integer actlPrc) {
		this.actlPrc = actlPrc;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public Integer getExpPer() {
		return expPer;
	}
	public void setExpPer(Integer expPer) {
		this.expPer = expPer;
	}
	public Integer getExpPnt() {
		return expPnt;
	}
	public void setExpPnt(Integer expPnt) {
		this.expPnt = expPnt;
	}
	public Integer getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(Integer usePnt) {
		this.usePnt = usePnt;
	}
	public String getUpdateYn() {
		return updateYn;
	}
	public void setUpdateYn(String updateYn) {
		this.updateYn = updateYn;
	}
	public String getConfirmYn() {
		return confirmYn;
	}
	public void setConfirmYn(String confirmYn) {
		this.confirmYn = confirmYn;
	}
	public String getErrorDesc() {
		return errorDesc;
	}
	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
	}
	public String getRegDtm() {
		return regDtm;
	}
	public void setRegDtm(String regDtm) {
		this.regDtm = regDtm;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
}
