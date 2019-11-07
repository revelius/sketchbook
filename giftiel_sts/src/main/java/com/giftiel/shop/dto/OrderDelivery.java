package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

public class OrderDelivery {
	private Integer rnum;
	private Integer ordDlvNo;         //주문배송번호 
	private String ordNo;         //주문번호 
	private Integer plcyDlvCst;         //정책배송비 
	private String dlvCstEtc;         //배송비비고 
	private String dlvCstPayway;         //배송비지불방식 
	private Integer minOrdAmt;         //기준주문금액 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	
	private OrderDlvCst orderDlvCst; //배송비
	private List<OrderDlvCst> orderDlvCsts; //배송비
	
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public Integer getOrdDlvNo() {
		return ordDlvNo;
	}
	public void setOrdDlvNo(Integer ordDlvNo) {
		this.ordDlvNo = ordDlvNo;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getPlcyDlvCst() {
		return plcyDlvCst;
	}
	public void setPlcyDlvCst(Integer plcyDlvCst) {
		this.plcyDlvCst = plcyDlvCst;
	}
	public String getDlvCstEtc() {
		return dlvCstEtc;
	}
	public void setDlvCstEtc(String dlvCstEtc) {
		this.dlvCstEtc = dlvCstEtc;
	}
	public String getDlvCstPayway() {
		return dlvCstPayway;
	}
	public void setDlvCstPayway(String dlvCstPayway) {
		this.dlvCstPayway = dlvCstPayway;
	}
	public Integer getMinOrdAmt() {
		return minOrdAmt;
	}
	public void setMinOrdAmt(Integer minOrdAmt) {
		this.minOrdAmt = minOrdAmt;
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
	public OrderDlvCst getOrderDlvCst() {
		return orderDlvCst;
	}
	public void setOrderDlvCst(OrderDlvCst orderDlvCst) {
		this.orderDlvCst = orderDlvCst;
	}
	public List<OrderDlvCst> getOrderDlvCsts() {
		return orderDlvCsts;
	}
	public void setOrderDlvCsts(List<OrderDlvCst> orderDlvCsts) {
		this.orderDlvCsts = orderDlvCsts;
	}
}
