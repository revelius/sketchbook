package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class CarharttRadioDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	public List<CarharttRadioForm> carharttRadioList(SearchForm searchForm) {
	    List<CarharttRadioForm> result = sqlSession.selectList("carharttRadio.carharttRadioList", searchForm);
	    return result;
	}
	
	public int carharttRadioTotalList(SearchForm searchForm) {
		int result = sqlSession.insert("carharttRadio.carharttRadioTotalList", searchForm);
		return result;
	}
	
	public CarharttRadioForm carharttRadioPopup(int radioNo) {
		CarharttRadioForm carharttRadioPopup = sqlSession.selectOne("carharttRadio.carharttRadioPopup", radioNo);
		return carharttRadioPopup;
	}
	
}
