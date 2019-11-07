package com.giftiel.shop.dto;

import java.util.List;


public class SupMenu {
	private String supMenuNm;   //상위메뉴명
	
	private List<Menu> menu; //메뉴

	public String getSupMenuNm() {
		return supMenuNm;
	}

	public void setSupMenuNm(String supMenuNm) {
		this.supMenuNm = supMenuNm;
	}

	public List<Menu> getMenu() {
		return menu;
	}

	public void setMenu(List<Menu> menu) {
		this.menu = menu;
	}

	

	
	
	
	
}
