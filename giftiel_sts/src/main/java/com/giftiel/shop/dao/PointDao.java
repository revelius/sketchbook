package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderAddPay;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;

/**
 * 회원관련 업무 수행
 * @author kwonYj
 *
 */
@Repository
public class PointDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	public List<Point> selectPointList(SearchForm searchForm) {
	    List<Point> result = sqlSession.selectList("point.selectPointList", searchForm);
	    return result;
	}
	public int totalListPoint(SearchForm searchForm) {
	    int result = sqlSession.selectOne("point.totalListPoint", searchForm);
	    return result;
	}	
	
	public int totalSumPoint(SearchForm searchForm) {
	    int result = sqlSession.selectOne("point.totalSumPoint", searchForm);
	    return result;
	}
	
	public int insertPoint(Point point) {
		int result = 0;
		if(point.getRsvPnt() > 0){
			result = sqlSession.insert("point.insertPoint", point);
		}
	    
		return result;
	}
	
	public List<Order> getRsvPntOrdList() {
	    List<Order> result = sqlSession.selectList("scheduler.getRsvPntOrdList");
	    return result;
	}
	
	public int updateOrdRsvPnt(Order order) {
	    int result = sqlSession.update("scheduler.updateOrdRsvPnt", order);
	    return result;
	}
	
	
	
}