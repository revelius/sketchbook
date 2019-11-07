package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.ZipCode;

@Repository
public class ZipCodeDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public List<ZipCode> selectSido() {
		List<ZipCode> result = sqlSession.selectList("zipCode.selectSido");
		return result;
	}
	
	public List<ZipCode> selectSiGungu(String sidoNm) {
		List<ZipCode> result = sqlSession.selectList("zipCode.selectSiGungu",sidoNm);
		return result;
	}
	
	public List<SearchForm> selectAddressList(SearchForm searchForm) {
		List<SearchForm> result = sqlSession.selectList("zipCode.selectAddressList",searchForm);
		return result;
	}	
}
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		