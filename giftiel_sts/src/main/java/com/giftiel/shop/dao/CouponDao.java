package com.giftiel.shop.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class CouponDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	public Coupon offCpnInfo(SearchForm searchForm) {
	    Coupon result = sqlSession.selectOne("coupon.offCpnInfo", searchForm);
	    return result;
	}
	
	public int updateOffCpn(Coupon coupon) {
	    int result = sqlSession.update("coupon.updateOffCpn", coupon);
	    return result;
	}	
	
}