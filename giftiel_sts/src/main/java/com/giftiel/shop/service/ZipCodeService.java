package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.ZipCodeDao;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.ZipCode;

@Service
@Transactional
public class ZipCodeService {
	@Autowired
	private ZipCodeDao zipCodeDao;
	
	public List<ZipCode> selectSido() {
		List<ZipCode> table = zipCodeDao.selectSido();
		return table;
	}
	
	public List<ZipCode> selectSiGungu(String sidoNm) {
		List<ZipCode> table = zipCodeDao.selectSiGungu(sidoNm);
		return table;
	}
	
	public List<SearchForm> selectAddressList(SearchForm searchForm) {
		List<SearchForm> table = zipCodeDao.selectAddressList(searchForm);
		return table;
	}
}