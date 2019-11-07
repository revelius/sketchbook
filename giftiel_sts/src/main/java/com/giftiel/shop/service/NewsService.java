package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dao.NewsDao;
import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.SearchForm;

@Service
public class NewsService {
	@Autowired
	private NewsDao newsDao;
	@Autowired
	private CommonDao commonDao;	
	
	/**
	 * Lookbook 리스트
	 * @param searchForm
	 * @return
	 */
	public List<News> newsList(SearchForm searchForm) {
	    List<News> result = newsDao.newsList(searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListNews(SearchForm searchForm) {
	    int result = newsDao.totalListNews(searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 정보
	 * @param searchForm
	 * @return
	 */
	public News detail(int txtNo) {
		News result = newsDao.detail(txtNo);
	    return result;
	}
}