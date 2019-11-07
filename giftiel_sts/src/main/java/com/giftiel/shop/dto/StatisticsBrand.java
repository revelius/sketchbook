package com.giftiel.shop.dto;


public class StatisticsBrand {
	private String period;			//기간값 
	private String tot;			    //기간별 합계 
	private String wTot;			//Worksout 접속수
	private String cTot;			//Carhart 접속수
	private String oTot;			//Obey 접속수
	private String bTot;			//Brixton 접속수
	
	
	private String connBrnd;    //siteNo
	private String brandTot;    //브랜드 합
	

	private String brandNm;		
	private int detailTot;
	private int cartTot;
	private int ordTot;
	private int ordGdTot;
	private int payTot;
	
	
	public String getConnBrnd() {
		return connBrnd;
	}
	public void setConnBrnd(String connBrnd) {
		this.connBrnd = connBrnd;
	}
	public String getBrandTot() {
		return brandTot;
	}
	public void setBrandTot(String brandTot) {
		this.brandTot = brandTot;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getTot() {
		return tot;
	}
	public void setTot(String tot) {
		this.tot = tot;
	}
	public String getwTot() {
		return wTot;
	}
	public void setwTot(String wTot) {
		this.wTot = wTot;
	}
	public String getcTot() {
		return cTot;
	}
	public void setcTot(String cTot) {
		this.cTot = cTot;
	}
	public String getoTot() {
		return oTot;
	}
	public void setoTot(String oTot) {
		this.oTot = oTot;
	}
	public String getbTot() {
		return bTot;
	}
	public void setbTot(String bTot) {
		this.bTot = bTot;
	}
	public String getBrandNm() {
		return brandNm;
	}
	public void setBrandNm(String brandNm) {
		this.brandNm = brandNm;
	}
	public int getDetailTot() {
		return detailTot;
	}
	public void setDetailTot(int detailTot) {
		this.detailTot = detailTot;
	}
	public int getCartTot() {
		return cartTot;
	}
	public void setCartTot(int cartTot) {
		this.cartTot = cartTot;
	}
	public int getOrdTot() {
		return ordTot;
	}
	public void setOrdTot(int ordTot) {
		this.ordTot = ordTot;
	}
	public int getOrdGdTot() {
		return ordGdTot;
	}
	public void setOrdGdTot(int ordGdTot) {
		this.ordGdTot = ordGdTot;
	}
	public int getPayTot() {
		return payTot;
	}
	public void setPayTot(int payTot) {
		this.payTot = payTot;
	}
	
	
}