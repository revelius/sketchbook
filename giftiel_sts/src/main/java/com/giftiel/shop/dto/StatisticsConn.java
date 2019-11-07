package com.giftiel.shop.dto;

import java.util.List;


public class StatisticsConn {
	private String period;			//기간값 
	private int StatisticsTot;			//통계 총합 

	
	public int getStatisticsTot() {
		return StatisticsTot;
	}


	public void setStatisticsTot(int statisticsTot) {
		StatisticsTot = statisticsTot;
	}


	private List<StatisticsBrand> brand;


	public String getPeriod() {
		return period;
	}


	public void setPeriod(String period) {
		this.period = period;
	}


	public List<StatisticsBrand> getBrand() {
		return brand;
	}


	public void setBrand(List<StatisticsBrand> brand) {
		this.brand = brand;
	}
	
}