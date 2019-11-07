package com.giftiel.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CouponDao;
import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.SearchForm;

@Service
@Transactional
public class CouponService {
	@Autowired
	private CouponDao couponDao;
	
	public Coupon offCpnInfo(SearchForm searchForm) {
		Coupon result = couponDao.offCpnInfo(searchForm);
	    return result;
	}
	
	
}