package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;


public class Order {
	private List<OrderGoods> orderGoods;	 //주문상품정보
	private List<OrderPay> orderPay;	 //결제
	private List<OrderDelivery> orderDelivery;	 //주문배송
	private List<OrderClm> orderClm;	 //클라임
	private List<OrderMemo> orderMemo;	 //주문메모
	private List<OrderAddPay> orderAddPay;	 //추가결제
	private List<KcpHist> kcpHist;	 //kcp이력
	private List<CurrentGoodsSize> currentGoodsSizes;	 //상품보유사이즈
	
	//
	private Integer totalSlAmt;        //총 상품판매금액
	private Integer totalDlvCst;       //총 상품판매금액(?)
	private Integer totalExpPnt;       //총적립금액
	private Integer totalPayAmt;       //총 상품결제금액
	
	/*order start*/
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private String ordNo;         //주문번호 
	private Integer memNo;         //회원번호 
	private Date ordDts;         //주문일시 
	private String ordrNm;         //주문자명 
	private String ordrTel;         //주문자전화번호 
	private String ordrCp;         //주문자휴대폰번호 
	private String ordrEmail;         //주문자 이메일 
	
	private String post_no;         //주문자우편번호(수정용)
	private String address;         //주문자기본주소(수정용)
	
	private String ordrZipCd;         //주문자우편번호(조회용) 
	private String ordrBsAddr;         //주문자기본주소(조회용)
	 
	
	private String ordrDtlAddr;         //주문자상세주소 
	private String ordStat;         //주문상태 
	private String ordStatNm;         //주문상태명
	private String rcpnNm;         //수령자명 
	private String rcpnTelNo;         //수령자전화번호 
	private String rcpnCpNo;         //수령자휴대폰번호 
	private String rcpnZipCd;         //수령자우편번호 
	private String rcpnBsAddr;         //수령자기본주소 
	private String rcpnDtlAddr;         //수령자상세주소 
	private String dlvSvcMemo;         //택배메모 
	private Date payCmplDts;         //결제완료일시 
	private String memId;         //회원ID 
	private String brwsCls;         //브라우저구분 
	private Integer siteNo;         //사이트번호 
	private String regIp;         //등록IP 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private String escrowDlvYn; //에스크로배송여부
	/*order end*/
	
	/*추가필요변수 start*/
	private Integer payAmt;         //결제금액 
	private Integer ordGdsSeq; //주문상품일련번호
	private String ubiGdsNm; 				//상품명
	private String ubiGdsNo; 				//상품번호
	private String ubiGdsSize; 				//상품사이즈
	private String chgUbiGdsSize; // 변경할 상품사이즈
	private Integer slPrc; 				//판매가
	private String perOrdStat;			 //개별진행상태
	private String perOrdStatNm;			 //개별진행상태명
	private Date clmRegDts;               //개별 클래임 등록일
	private String siteNm; 				//매장명
	private String brand; 				//브렌드
	private String ubiGdsColorNm; 		//상품컬러
	private Integer ordQty;//주문수량
	private Integer dlvCmpNo;//택배사 번호
	private Integer chgDlvCmpNo;//변경할 택배사 번호
	private String invNo;//송장 번호
	private String chgInvNo; //변경할 송장 번호
	private Integer memoNo; //주문코멘트 번호
	private String memoTxt; //주문코멘트 내용
	private Date sndCmplDts; //발송완료일시
	
	private Integer payNo; //결제번호
	private Integer addPayNo; //추가결제번호
	private String addPayRsn; //추가결제사유
	private Integer addPayAmt; //추가결제금액
	private String uptAddPayRsn; //수정될 추가결제사유
	private Integer uptAddPayAmt; //수정될 추가결제금액
	private Integer cnclQty; //취소수량
	
	private String payStat;//결제상태
	
	private String barcode;//barcode
	
	private String[] ordGdsSeqs; //주문상품일련번호
	
	private Integer actlPayPrc; 				//실결제금액
	private Integer expPnt; //적립예정액
	private Integer usePnt; //사용포인트
	
	private String ubiSaleNo;
	/*추가필요변수 end*/
	
	//주문서작성폼
	private String ordrTel01;	//주문자전화번호
	private String ordrTel02;	//주문자전화번호
	private String ordrTel03;	//주문자전화번호
	
	private String ordrCp01;	//주문자휴대전화
	private String ordrCp02;	//주문자휴대전화
	private String ordrCp03;	//주문자휴대전화
	
	private String rcpnTel01;	//수령자전화번호
	private String rcpnTel02;	//수령자전화번호
	private String rcpnTel03;	//수령자전화번호
	
	private String rcpnCp01;	//수령자휴대전화
	private String rcpnCp02;	//수령자휴대전화
	private String rcpnCp03;	//수령자휴대전화
	
	private String ordrZipCd01;	//주문자 우편번호
	private String ordrZipCd02;	//주문자 우편번호
	
	private String rcpnZipCd01;	//수령자 우편번호
	private String rcpnZipCd02;	//수령자 우편번호
	
	private boolean mobile;
	
	private Integer totalCoupAmt; //총 쿠폰적용금액
	
	private String mZone;
	private String cCode;
	private String location;
	
	public List<OrderGoods> getOrderGoods() {
		return orderGoods;
	}
	public void setOrderGoods(List<OrderGoods> orderGoods) {
		this.orderGoods = orderGoods;
	}
	public List<OrderPay> getOrderPay() {
		return orderPay;
	}
	public void setOrderPay(List<OrderPay> orderPay) {
		this.orderPay = orderPay;
	}
	public List<OrderDelivery> getOrderDelivery() {
		return orderDelivery;
	}
	public void setOrderDelivery(List<OrderDelivery> orderDelivery) {
		this.orderDelivery = orderDelivery;
	}
	public List<OrderClm> getOrderClm() {
		return orderClm;
	}
	public void setOrderClm(List<OrderClm> orderClm) {
		this.orderClm = orderClm;
	}
	public List<OrderMemo> getOrderMemo() {
		return orderMemo;
	}
	public void setOrderMemo(List<OrderMemo> orderMemo) {
		this.orderMemo = orderMemo;
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
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	public Date getOrdDts() {
		return ordDts;
	}
	public void setOrdDts(Date ordDts) {
		this.ordDts = ordDts;
	}
	public String getOrdrNm() {
		return ordrNm;
	}
	public void setOrdrNm(String ordrNm) {
		this.ordrNm = ordrNm;
	}
	public String getOrdrTel() {
		return ordrTel;
	}
	public void setOrdrTel(String ordrTel) {
		this.ordrTel = ordrTel;
	}
	public String getOrdrCp() {
		return ordrCp;
	}
	public void setOrdrCp(String ordrCp) {
		this.ordrCp = ordrCp;
	}
	public String getOrdrEmail() {
		return ordrEmail;
	}
	public void setOrdrEmail(String ordrEmail) {
		this.ordrEmail = ordrEmail;
	}
	public String getOrdrZipCd() {
		return ordrZipCd;
	}
	public void setOrdrZipCd(String ordrZipCd) {
		this.ordrZipCd = ordrZipCd;
	}
	public String getOrdrBsAddr() {
		return ordrBsAddr;
	}
	public void setOrdrBsAddr(String ordrBsAddr) {
		this.ordrBsAddr = ordrBsAddr;
	}
	public String getOrdrDtlAddr() {
		return ordrDtlAddr;
	}
	public void setOrdrDtlAddr(String ordrDtlAddr) {
		this.ordrDtlAddr = ordrDtlAddr;
	}
	public String getOrdStat() {
		return ordStat;
	}
	public void setOrdStat(String ordStat) {
		this.ordStat = ordStat;
	}
	public String getOrdStatNm() {
		return ordStatNm;
	}
	public void setOrdStatNm(String ordStatNm) {
		this.ordStatNm = ordStatNm;
	}
	public String getRcpnNm() {
		return rcpnNm;
	}
	public void setRcpnNm(String rcpnNm) {
		this.rcpnNm = rcpnNm;
	}
	public String getRcpnTelNo() {
		return rcpnTelNo;
	}
	public void setRcpnTelNo(String rcpnTelNo) {
		this.rcpnTelNo = rcpnTelNo;
	}
	public String getRcpnCpNo() {
		return rcpnCpNo;
	}
	public void setRcpnCpNo(String rcpnCpNo) {
		this.rcpnCpNo = rcpnCpNo;
	}
	public String getRcpnZipCd() {
		return rcpnZipCd;
	}
	public void setRcpnZipCd(String rcpnZipCd) {
		this.rcpnZipCd = rcpnZipCd;
	}
	public String getRcpnBsAddr() {
		return rcpnBsAddr;
	}
	public void setRcpnBsAddr(String rcpnBsAddr) {
		this.rcpnBsAddr = rcpnBsAddr;
	}
	public String getRcpnDtlAddr() {
		return rcpnDtlAddr;
	}
	public void setRcpnDtlAddr(String rcpnDtlAddr) {
		this.rcpnDtlAddr = rcpnDtlAddr;
	}
	public String getDlvSvcMemo() {
		return dlvSvcMemo;
	}
	public void setDlvSvcMemo(String dlvSvcMemo) {
		this.dlvSvcMemo = dlvSvcMemo;
	}
	public Date getPayCmplDts() {
		return payCmplDts;
	}
	public void setPayCmplDts(Date payCmplDts) {
		this.payCmplDts = payCmplDts;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getBrwsCls() {
		return brwsCls;
	}
	public void setBrwsCls(String brwsCls) {
		this.brwsCls = brwsCls;
	}
	public Integer getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(Integer siteNo) {
		this.siteNo = siteNo;
	}
	public String getRegIp() {
		return regIp;
	}
	public void setRegIp(String regIp) {
		this.regIp = regIp;
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
	public Integer getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(Integer payAmt) {
		this.payAmt = payAmt;
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
	public String getChgUbiGdsSize() {
		return chgUbiGdsSize;
	}
	public void setChgUbiGdsSize(String chgUbiGdsSize) {
		this.chgUbiGdsSize = chgUbiGdsSize;
	}
	public Integer getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(Integer slPrc) {
		this.slPrc = slPrc;
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
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
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
	public Integer getDlvCmpNo() {
		return dlvCmpNo;
	}
	public void setDlvCmpNo(Integer dlvCmpNo) {
		this.dlvCmpNo = dlvCmpNo;
	}
	public Integer getChgDlvCmpNo() {
		return chgDlvCmpNo;
	}
	public void setChgDlvCmpNo(Integer chgDlvCmpNo) {
		this.chgDlvCmpNo = chgDlvCmpNo;
	}
	public String getInvNo() {
		return invNo;
	}
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}
	public String getChgInvNo() {
		return chgInvNo;
	}
	public void setChgInvNo(String chgInvNo) {
		this.chgInvNo = chgInvNo;
	}
	public Integer getMemoNo() {
		return memoNo;
	}
	public void setMemoNo(Integer memoNo) {
		this.memoNo = memoNo;
	}
	public String getMemoTxt() {
		return memoTxt;
	}
	public void setMemoTxt(String memoTxt) {
		this.memoTxt = memoTxt;
	}
	public Integer getOrdGdsSeq() {
		return ordGdsSeq;
	}
	public void setOrdGdsSeq(Integer ordGdsSeq) {
		this.ordGdsSeq = ordGdsSeq;
	}
	public String[] getOrdGdsSeqs() {
		return ordGdsSeqs;
	}
	public void setOrdGdsSeqs(String[] ordGdsSeqs) {
		this.ordGdsSeqs = ordGdsSeqs;
	}
	public Date getSndCmplDts() {
		return sndCmplDts;
	}
	public void setSndCmplDts(Date sndCmplDts) {
		this.sndCmplDts = sndCmplDts;
	}
	public String getAddPayRsn() {
		return addPayRsn;
	}
	public void setAddPayRsn(String addPayRsn) {
		this.addPayRsn = addPayRsn;
	}
	public Integer getPayNo() {
		return payNo;
	}
	public void setPayNo(Integer payNo) {
		this.payNo = payNo;
	}
	public Integer getAddPayNo() {
		return addPayNo;
	}
	public void setAddPayNo(Integer addPayNo) {
		this.addPayNo = addPayNo;
	}
	public List<OrderAddPay> getOrderAddPay() {
		return orderAddPay;
	}
	public void setOrderAddPay(List<OrderAddPay> orderAddPay) {
		this.orderAddPay = orderAddPay;
	}
	public Integer getAddPayAmt() {
		return addPayAmt;
	}
	public void setAddPayAmt(Integer addPayAmt) {
		this.addPayAmt = addPayAmt;
	}
	public String getUptAddPayRsn() {
		return uptAddPayRsn;
	}
	public void setUptAddPayRsn(String uptAddPayRsn) {
		this.uptAddPayRsn = uptAddPayRsn;
	}
	public Integer getUptAddPayAmt() {
		return uptAddPayAmt;
	}
	public void setUptAddPayAmt(Integer uptAddPayAmt) {
		this.uptAddPayAmt = uptAddPayAmt;
	}
	public String getPayStat() {
		return payStat;
	}
	public void setPayStat(String payStat) {
		this.payStat = payStat;
	}
	public String getPost_no() {
		return post_no;
	}
	public void setPost_no(String post_no) {
		this.post_no = post_no;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOrdrTel01() {
		return ordrTel01;
	}
	public void setOrdrTel01(String ordrTel01) {
		this.ordrTel01 = ordrTel01;
	}
	public String getOrdrTel02() {
		return ordrTel02;
	}
	public void setOrdrTel02(String ordrTel02) {
		this.ordrTel02 = ordrTel02;
	}
	public String getOrdrTel03() {
		return ordrTel03;
	}
	public void setOrdrTel03(String ordrTel03) {
		this.ordrTel03 = ordrTel03;
	}
	public String getOrdrCp01() {
		return ordrCp01;
	}
	public void setOrdrCp01(String ordrCp01) {
		this.ordrCp01 = ordrCp01;
	}
	public String getOrdrCp02() {
		return ordrCp02;
	}
	public void setOrdrCp02(String ordrCp02) {
		this.ordrCp02 = ordrCp02;
	}
	public String getOrdrCp03() {
		return ordrCp03;
	}
	public void setOrdrCp03(String ordrCp03) {
		this.ordrCp03 = ordrCp03;
	}
	public String getRcpnTel01() {
		return rcpnTel01;
	}
	public void setRcpnTel01(String rcpnTel01) {
		this.rcpnTel01 = rcpnTel01;
	}
	public String getRcpnTel02() {
		return rcpnTel02;
	}
	public void setRcpnTel02(String rcpnTel02) {
		this.rcpnTel02 = rcpnTel02;
	}
	public String getRcpnTel03() {
		return rcpnTel03;
	}
	public void setRcpnTel03(String rcpnTel03) {
		this.rcpnTel03 = rcpnTel03;
	}
	public String getRcpnCp01() {
		return rcpnCp01;
	}
	public void setRcpnCp01(String rcpnCp01) {
		this.rcpnCp01 = rcpnCp01;
	}
	public String getRcpnCp02() {
		return rcpnCp02;
	}
	public void setRcpnCp02(String rcpnCp02) {
		this.rcpnCp02 = rcpnCp02;
	}
	public String getRcpnCp03() {
		return rcpnCp03;
	}
	public void setRcpnCp03(String rcpnCp03) {
		this.rcpnCp03 = rcpnCp03;
	}
	public String getRcpnZipCd01() {
		return rcpnZipCd01;
	}
	public void setRcpnZipCd01(String rcpnZipCd01) {
		this.rcpnZipCd01 = rcpnZipCd01;
	}
	public String getRcpnZipCd02() {
		
		return rcpnZipCd02;
	}
	public void setRcpnZipCd02(String rcpnZipCd02) {
		this.rcpnZipCd02 = rcpnZipCd02;
	}
	public boolean isMobile() {
		return mobile;
	}
	public void setMobile(boolean mobile) {
		this.mobile = mobile;
	}
	public String getOrdrZipCd01() {
		return ordrZipCd01;
	}
	public void setOrdrZipCd01(String ordrZipCd01) {
		this.ordrZipCd01 = ordrZipCd01;
	}
	public String getOrdrZipCd02() {
		return ordrZipCd02;
	}
	public void setOrdrZipCd02(String ordrZipCd02) {
		this.ordrZipCd02 = ordrZipCd02;
	}
	public Integer getTotalSlAmt() {
		return totalSlAmt;
	}
	public void setTotalSlAmt(Integer totalSlAmt) {
		this.totalSlAmt = totalSlAmt;
	}
	public Integer getTotalDlvCst() {
		return totalDlvCst;
	}
	public void setTotalDlvCst(Integer totalDlvCst) {
		this.totalDlvCst = totalDlvCst;
	}
	public Integer getTotalExpPnt() {
		return totalExpPnt;
	}
	public void setTotalExpPnt(Integer totalExpPnt) {
		this.totalExpPnt = totalExpPnt;
	}
	public List<KcpHist> getKcpHist() {
		return kcpHist;
	}
	public void setKcpHist(List<KcpHist> kcpHist) {
		this.kcpHist = kcpHist;
	}
	public String getEscrowDlvYn() {
		return escrowDlvYn;
	}
	public void setEscrowDlvYn(String escrowDlvYn) {
		this.escrowDlvYn = escrowDlvYn;
	}
	public Integer getCnclQty() {
		return cnclQty;
	}
	public void setCnclQty(Integer cnclQty) {
		this.cnclQty = cnclQty;
	}
	public Date getClmRegDts() {
		return clmRegDts;
	}
	public void setClmRegDts(Date clmRegDts) {
		this.clmRegDts = clmRegDts;
	}
	public Integer getTotalPayAmt() {
		return totalPayAmt;
	}
	public void setTotalPayAmt(Integer totalPayAmt) {
		this.totalPayAmt = totalPayAmt;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public List<CurrentGoodsSize> getCurrentGoodsSizes() {
		return currentGoodsSizes;
	}
	public void setCurrentGoodsSizes(List<CurrentGoodsSize> currentGoodsSizes) {
		this.currentGoodsSizes = currentGoodsSizes;
	}
	public Integer getActlPayPrc() {
		return actlPayPrc;
	}
	public void setActlPayPrc(Integer actlPayPrc) {
		this.actlPayPrc = actlPayPrc;
	}
	public Integer getExpPnt() {
		return expPnt;
	}
	public void setExpPnt(Integer expPnt) {
		this.expPnt = expPnt;
	}
	public Integer getTotalCoupAmt() {
		totalCoupAmt = 0;
		for (int i = 0; i < orderGoods.size(); i++) {
			if(orderGoods.get(i).getCpnPayAmt() != null){
				totalCoupAmt = totalCoupAmt + orderGoods.get(i).getCpnPayAmt();
			}
		}
		
		return totalCoupAmt;
	}
	public void setTotalCoupAmt(Integer totalCoupAmt) {
		this.totalCoupAmt = totalCoupAmt;
	}
	public Integer getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(Integer usePnt) {
		this.usePnt = usePnt;
	}
	public String getUbiSaleNo() {
		return ubiSaleNo;
	}
	public void setUbiSaleNo(String ubiSaleNo) {
		this.ubiSaleNo = ubiSaleNo;
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