package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.Site;

@Repository
public class CodeDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public List<Code> listCd(String supCdNo) {
	    List<Code> result = sqlSession.selectList("code.listCd", supCdNo);
	    return result;
	}
	
	public List<Code> listUbiBrand() {
	    List<Code> result = sqlSession.selectList("code.listUbiBrand");
	    return result;
	}	

	public int insertCd(Code code) {
	    int result = sqlSession.insert("code.insertCd", code);
	    return result;
	}
	
	
	
	public List<Site> getSiteList() {
		List<Site> site = sqlSession.selectList("code.getSiteList");
		return site;
	}
}