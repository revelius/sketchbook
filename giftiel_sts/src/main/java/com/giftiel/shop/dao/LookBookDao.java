package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.LookBook;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class LookBookDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	/**
	 * Lookbook 리스트
	 * @param searchForm
	 * @return
	 */
	public List<LookBook> list(SearchForm searchForm) {
	    List<LookBook> result = sqlSession.selectList("lookbook.list", searchForm);
	    return result;
	}

	/**
	 * Lookbook 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListCount(SearchForm searchForm) {
	    int result = sqlSession.selectOne("lookbook.totalListCount", searchForm);
	    return result;
	}

	/**
	 * Lookbook 정보
	 * @param txtNo
	 * @return
	 */
	public LookBook detail(int txtNo) {
	    LookBook result = sqlSession.selectOne("lookbook.detail", txtNo);
	    return result;
	}

}