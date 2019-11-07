package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class NewsDao {
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
	public List<News> newsList(SearchForm searchForm) {
	    List<News> result = sqlSession.selectList("news.newsList", searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListNews(SearchForm searchForm) {
	    int result = sqlSession.selectOne("news.totalListNews", searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 정보
	 * @param txtNo
	 * @return
	 */
	public News detail(int txtNo) {
		News result = sqlSession.selectOne("news.newsDetail", txtNo);
	    return result;
	}

}