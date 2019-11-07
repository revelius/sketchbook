package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dao.LookBookDao;
import com.giftiel.shop.dto.LookBook;
import com.giftiel.shop.dto.SearchForm;

@Service
public class LookBookService {
	@Autowired
	private LookBookDao lookbookDao;
	@Autowired
	private CommonDao commonDao;	
	
	/**
	 * Lookbook 리스트
	 * @param searchForm
	 * @return
	 */
	public List<LookBook> list(SearchForm searchForm) {
	    List<LookBook> result = lookbookDao.list(searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListCount(SearchForm searchForm) {
	    int result = lookbookDao.totalListCount(searchForm);
	    return result;
	}
	
	/**
	 * Lookbook 정보
	 * @param searchForm
	 * @return
	 */
	public LookBook detail(int txtNo) {
	    LookBook result = lookbookDao.detail(txtNo);
	    return result;
	}
}