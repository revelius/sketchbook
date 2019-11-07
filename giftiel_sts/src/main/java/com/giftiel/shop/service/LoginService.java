package com.giftiel.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.giftiel.shop.dao.LoginDao;
import com.giftiel.shop.dto.Admin;

@Service
public class LoginService {
	@Autowired
	private LoginDao loginDao;
 
	/**
	 * 관리자 로그인 
	 **/
	public Admin selectAdmin(Model model) {
		Admin admin = loginDao.selectAdmin(model);
		return admin;
	}
}