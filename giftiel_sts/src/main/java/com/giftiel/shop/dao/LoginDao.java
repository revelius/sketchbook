package com.giftiel.shop.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.giftiel.shop.controller.admin.LoginController;
import com.giftiel.shop.dto.Admin;

@Repository
public class LoginDao {
	protected Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	/**
	 * 관리자 정보 호출 
	 **/
	public Admin selectAdmin(Model model) {
		Admin admin = sqlSession.selectOne("login.selectAdmin",model);
		return admin;
	}	
}
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		