package com.giftiel.shop.dto;

import java.util.Date;

public class SiteSetting {

	private Integer site_no;
	private String site_nm;
	private String site_title;
	private String site_favicon;
	private String site_description;
	private String site_keyword;
	private String fabicon_nm;
	private String favicon_img;
	private Date reg_dts;
	private Date upd_dts;
	private String regr_no;
	
	
	public Integer getSite_no() {
		return site_no;
	}
	public void setSite_no(Integer site_no) {
		this.site_no = site_no;
	}
	public String getSite_nm() {
		return site_nm;
	}
	public void setSite_nm(String site_nm) {
		this.site_nm = site_nm;
	}
	public String getSite_title() {
		return site_title;
	}
	public void setSite_title(String site_title) {
		this.site_title = site_title;
	}
	public String getSite_favicon() {
		return site_favicon;
	}
	public void setSite_favicon(String site_favicon) {
		this.site_favicon = site_favicon;
	}
	public String getSite_description() {
		return site_description;
	}
	public void setSite_description(String site_description) {
		this.site_description = site_description;
	}
	public String getSite_keyword() {
		return site_keyword;
	}
	public void setSite_keyword(String site_keyword) {
		this.site_keyword = site_keyword;
	}
	public String getFabicon_nm() {
		return fabicon_nm;
	}
	public void setFabicon_nm(String fabicon_nm) {
		this.fabicon_nm = fabicon_nm;
	}
	public String getFavicon_img() {
		return favicon_img;
	}
	public void setFavicon_img(String favicon_img) {
		this.favicon_img = favicon_img;
	}
	public Date getReg_dts() {
		return reg_dts;
	}
	public void setReg_dts(Date reg_dts) {
		this.reg_dts = reg_dts;
	}
	public Date getUpd_dts() {
		return upd_dts;
	}
	public void setUpd_dts(Date upd_dts) {
		this.upd_dts = upd_dts;
	}
	public String getRegr_no() {
		return regr_no;
	}
	public void setRegr_no(String regr_no) {
		this.regr_no = regr_no;
	}
}
