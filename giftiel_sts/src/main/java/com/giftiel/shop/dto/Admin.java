package com.giftiel.shop.dto;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Admin {
	private Integer userNo;         //사용자번호 
	private String id;         //아이디 
	private String pwd;         //패스워드 
	private String userNm;         //사용자명 
	private String email;         //이메일 
	private String cpNo;         //휴대폰번호 
	private String useYn;         //사용여부 
	private String userCls;         //사용자구분 
	private String cmpNm;         //업체명 
	private String reprNm;         //대표자명 
	private String personInfoMngr;         //개인정보 관리자 
	private String personInfoMngrEmail;         //개인정보 관리자 이메일 
	private String zipCd;         //우편번호 
	private String addr;         //주소 
	private String dtlAddr;         //상세주소 
	private String tel;         //전화번호 
	private String faxNo;         //팩스번호 
	private String bizRegNo;         //사업자등록번호 
	private String teleSalesBizRegNo;         //통신판매사업자등록번호 
	private String bizSt;         //업태 
	private String event;         //종목 
	private Integer regrNo;         //등록자 
	private Date regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private Date updDts;         //수정일시 
	private String siteAuthNo; //사이트권한번호
}
