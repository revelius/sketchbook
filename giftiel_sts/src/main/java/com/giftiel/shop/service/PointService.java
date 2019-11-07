package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.PointDao;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;

@Service
public class PointService {
	@Autowired
	private PointDao pointDao;
	
	public List<Point> selectPointList(SearchForm searchForm) {
	    List<Point> result = pointDao.selectPointList(searchForm);
	    return result;
	}  
	
	public int totalListPoint(SearchForm searchForm) {
	    int result = pointDao.totalListPoint(searchForm);
	    return result;
	}
	
	public int totalSumPoint(SearchForm searchForm) {
	    int result = pointDao.totalSumPoint(searchForm);
	    return result;
	}
	
	public int insertPoint(Point point) {
	    int result = pointDao.insertPoint(point);
	    return result;
	}
	
	/**
	 * 주문 적립된 포인트를 일괄 적립한다.
	 * @return
	 */
	@Transactional
	public int pointReservProcess() {
		int result = 0;
		
		List<Order> orderList = pointDao.getRsvPntOrdList();
		
		for (int i = 0; i < orderList.size(); i++) {
			Point point = new Point();
			point.setMemNo(orderList.get(i).getMemNo());
        	point.setRsvPnt(orderList.get(i).getExpPnt());
        	point.setRsvRsnCd("MT00201");
        	point.setRsvYn("Y");
        	point.setOrdNo(orderList.get(i).getOrdNo());
        	point.setRegrNo(0);
        	point.setRsvCls("CM01001");
			pointDao.insertPoint(point);
        	
        	Order order = new Order();
        	order.setOrdNo(orderList.get(i).getOrdNo());
        	order.setOrdGdsSeq(orderList.get(i).getOrdGdsSeq());
        	pointDao.updateOrdRsvPnt(order);
		}
		
		return result;
	}
}