package com.giftiel.shop.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Setting {
	public String admin_id;
	public String pwd;
	public String pwd_confirm;
	public String user_name;  //관리자명
	public String email;      //이메일
	public String com_name;   //회사명
	public String repre_name; //대표자명
	public String info_name;  //개인정보관리자 이름
	public String info_email; //개인정보관리자 이메일
	public String post_no;    //우편번호
	public String address;    //회사주소
	public String dtl_address;//회사 상세주소
	public String com_email;  //회사 이메일

	public String tel_no;     //대표전화
	public String fax_no;     //팩스번호
	public String com_no;     //사업자등록번호
	public String biz_reg_no; //통신판매업신고번호
	public String biz_st;     //업태
	public String event;      //종목

	public String cp_no;      //휴대폰 번호

	public String works_title; //웍스아웃 타이틀 설정
	public String car_title;   //칼하트 타이틀 설정
	public String obey_title;  //obey 타이틀 설정
	public String brixton_title;  //brixton 타이틀 설정
	public String deus_title;      //lex 타이틀 설정

	public String works_fav; //웍스아웃 파비콘 설정
	public String car_fav;   //칼하트 파비콘 설정
	public String obey_fav;  //obey 파비콘 설정
	public String brixton_fav;  //brixton 파비콘 설정
	public String deus_fav;      //deu 파비콘 설정

	public String site_works;   //웍스아웃  설정
	public String site_car;     //칼하트  설정
	public String site_obey;    //obey  설정
	public String site_brixton; //brixton  설정
	public String site_deus;     //deu  설정

	public String keyword_works;   //웍스아웃  설정
	public String keyword_car;     //칼하트  설정
	public String keyword_obey;    //obey  설정
	public String keyword_brixton; //brixton  설정
	public String keyword_deus;     //deu  설정

	public String site_nm;
	public String site_desc;
	public double cnd_free_dlv_amt;  //조건부 무료 배송금액
	public double dlv_cst;           //배송비

	public String regFlag;
	public String grd_no;
	public String grd_nm;
	public double dc_amt;
	public double pnt_rsv_rt;
	public String regr_no;

	public double use_min_pnt;
	public double min_paypnt;
	public double max_paypnt;
	public String exp_pnt;
	public String pnt_rsv_cls;
	public double mem_join_rsv_pnt;

	public Date reg_dts;
	public Date upd_dts;
	/*
	 * 상점 운영 정책
	 * */
	public String site_no;
	public String plcy_no;
	public String plcy_nm;
	public String plcy_desc;
	public String plcy_txt;

	private List<SiteSetting> siteSetting;
}

