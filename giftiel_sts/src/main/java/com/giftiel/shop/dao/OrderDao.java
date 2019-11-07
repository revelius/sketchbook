package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.KcpHist;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderAddPay;
import com.giftiel.shop.dto.OrderClm;
import com.giftiel.shop.dto.OrderClmGds;
import com.giftiel.shop.dto.OrderDelivery;
import com.giftiel.shop.dto.OrderDlvCmp;
import com.giftiel.shop.dto.OrderDlvCst;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.dto.OrderMemo;
import com.giftiel.shop.dto.OrderPay;
import com.giftiel.shop.dto.OrderPayCrd;
import com.giftiel.shop.dto.OrderPayRtm;
import com.giftiel.shop.dto.OrderPayVrtl;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.UbiOrder;

@Repository
public class OrderDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	/**
	 * 주문 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Order> listOrder(SearchForm searchForm) {
	    List<Order> result = sqlSession.selectList("order.listOrder", searchForm);
	    return result;
	}
	
	/**
	 * 주문 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListOrder(SearchForm searchForm) {
	    int result = sqlSession.selectOne("order.totalListOrder", searchForm);
	    return result;
	}
			
	/**
	 * 주문 상세
	 * @param searchForm
	 * @return
	 */
	public Order selectOrder(SearchForm searchForm) {
		Order result = sqlSession.selectOne("order.selectOrder", searchForm);
		
		int totalSlAmt = 0 ;	//총상품금액
		int totalExpPnt = 0; 	//총적립금액
		int totalPayAmt = 0; 	//총결제금액
		for (int i = 0; i < result.getOrderGoods().size(); i++) {
			totalSlAmt  += result.getOrderGoods().get(i).getSlPrc();
			totalExpPnt += result.getOrderGoods().get(i).getExpPnt();
			totalPayAmt += result.getOrderGoods().get(i).getActlPayPrc();
		}
		result.setTotalSlAmt(totalSlAmt);
		result.setTotalExpPnt(totalExpPnt);
		result.setTotalPayAmt(totalPayAmt);
		
	    return result;
	}
	
	/**
	 * 주문자정보  UPDATE 
	 * @param orderForm
	 * @return
	 */
	public int updateOrdr(Order orderForm) {
	    int result = sqlSession.update("order.updateOrdr", orderForm);
	    return result;
	}
	
	/**
	 * 주문상품 개별진행상태  UPDATE 
	 * @param searchForm
	 * @return
	 */
	public int updateOrdStat(Order order) {
	    int result = sqlSession.update("order.updateOrdStat", order);
	    return result;
	}
	
	/**
	 * 주문상품 개별진행상태2  UPDATE 
	 * @param searchForm
	 * @return
	 */
	public int updateOrdStat2(Order order) {
	    int result = sqlSession.update("order.updateOrdStat2", order);
	    return result;
	}	

	/**
	 * 주문품 SIZE  UPDATE 
	 * @param orderForm
	 * @return
	 */
	public int updateOrdGoods(Order orderForm) {
	    int result = sqlSession.update("order.updateOrdGoods", orderForm);
	    return result;
	}
	
	/**
	 * 주문 코멘트등록
	 * @param OrderMemo
	 * @return
	 */
	public int insertOrdMemo(OrderMemo orderMemo) {
	    int result = sqlSession.insert("order.insertOrdMemo", orderMemo);
	    return result;
	}
	
	/**
	 * 주문 코멘트삭제
	 * @param OrderMemo
	 * @return
	 */
	public int deleteOrdMemo(OrderMemo orderMemo) {
	    int result = sqlSession.delete("order.deleteOrdMemo", orderMemo);
	    return result;
	}

	/**
	 * 택배사조회
	 * @param 
	 * @return
	 */
	public List<OrderDlvCmp> listDlvCmp() {
	    List<OrderDlvCmp> result = sqlSession.selectList("order.listDlvCmp");
	    return result;
	}
	
	/**
	 * 택배사조회 - 택배사 코드로 조회시
	 * @param searchForm
	 * @return
	 */
	public OrderDlvCmp dlvCmp(int invNo) {
	    OrderDlvCmp result = sqlSession.selectOne("order.dlvCmp", invNo);
	    return result;
	}
	
	/**
	 * 추가결제 조회
	 * @param searchForm
	 * @return
	 */
	public List<OrderAddPay> listAddPay(SearchForm searchForm) {
	    List<OrderAddPay> result = sqlSession.selectList("order.listAddPay", searchForm);
	    return result;
	}
	
	/**
	 * 추가결제 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListAddPay(SearchForm searchForm) {
	    int result = sqlSession.selectOne("order.totalListAddPay", searchForm);
	    return result;
	}
	

	/**
	 * 주문 결제 등록
	 * @param OrderMemo
	 * @return
	 */
	public int insertOrdPay(OrderPay orderPay) {
	    int result = sqlSession.insert("order.insertPay", orderPay);
	    return result;
	}
	
	/**
	 * 주문 추가결제 등록
	 * @param OrderMemo
	 * @return
	 */
	public int insertOrdAddPay(OrderAddPay orderAddPay) {
	    int result = sqlSession.insert("order.insertOrdAddPay", orderAddPay);
	    return result;
	}
	
	/**
	 * 주문 추가결제 수정
	 * @param orderForm
	 * @return
	 */
	public int updateOrdAddPay(OrderAddPay orderAddPay) {
	    int result = sqlSession.update("order.updateOrdAddPay", orderAddPay);
	    return result;
	}
	
	/**
	 * 주문 결제 수정
	 * @param OrderMemo
	 * @return
	 */
	public int updateOrdPay(OrderPay orderPay) {
	    int result = sqlSession.delete("order.updateOrdPay", orderPay);
	    return result;
	}
	
	public String createOrdNo() {
		String result = sqlSession.selectOne("order.createOrdNo");
	    return result;
	}
	

	public int insertOrd(Order order) {
	    int result = sqlSession.insert("order.insertOrd", order);
	    return result;
	}
	
	public int insertOrdGds(OrderGoods orderGoods) {
	    int result = sqlSession.insert("order.insertOrdGds", orderGoods);
	    return result;
	}		
	
	public int insertOrddvl(OrderDelivery orderDelivery) {
	    int result = sqlSession.insert("order.insertOrddvl", orderDelivery);
	    return result;
	}
	
	public int insertDlvCst(OrderDlvCst orderDlvCst) {
	    int result = sqlSession.insert("order.insertDlvCst", orderDlvCst);
	    return result;
	}	
	
	public int insertRtmAcctPay(OrderPayRtm orderPayRtm) {
	    int result = sqlSession.insert("order.insertRtmAcctPay", orderPayRtm);
	    return result;
	}
	
	public int insertCrcdCrdPay(OrderPayCrd orderPayCrd) {
	    int result = sqlSession.insert("order.insertCrcdCrdPay", orderPayCrd);
	    return result;
	}
	
	public int insertVrtlAcctPay(OrderPayVrtl orderPayVrtl) {
	    int result = sqlSession.insert("order.insertVrtlAcctPay", orderPayVrtl);
	    return result;
	}	
	
	public int insertKpcHist(KcpHist kcpHist) {
	    int result = sqlSession.insert("order.insertKpcHist", kcpHist);
	    return result;
	}	
	
	public int insertClm(OrderClm orderClm) {
	    int result = sqlSession.insert("order.insertClm", orderClm);
	    return result;
	}
	
	public int insertClmGds(OrderClmGds orderClmGds) {
	    int result = sqlSession.insert("order.insertClmGds", orderClmGds);
	    return result;
	}
	
	
	/**
	 * 주문번호
	 * @param searchForm
	 * @return
	 */
	public HashMap<String,Integer> getClmNo(SearchForm searchForm){
		HashMap<String,Integer> result = sqlSession.selectOne("order.getClmNo", searchForm);
	    return result;
	}	
	
	
	public int updateClm(OrderClm orderClm) {
	    int result = sqlSession.update("order.updateClm", orderClm);
	    return result;
	}
	
	
	public int updateClmGds(OrderClmGds orderClmGds) {
	    int result = sqlSession.update("order.updateClmGds", orderClmGds);
	    return result;
	}
	
	
	//클래임 상태값 변경전 클래임 상품 모두 취소 상태인지 체크
	public int clmGdsStatChk(OrderClmGds orderClmGds) {
	    int result = sqlSession.selectOne("order.clmGdsStatChk", orderClmGds);
	    return result;
	}
	
	/**
	 * UBI판매정보 입력
	 * @param ubiOrder
	 * @return
	 */
	public int insertUbiOrder(UbiOrder ubiOrder) {
	    int result = sqlSession.insert("order.insertUbiOrder", ubiOrder);
	    return result;
	}
	
	/**
	 * UBI판매정보 입력[반품]
	 * @param ubiOrder
	 * @return
	 */
	public int insertUbiOrderCancel(UbiOrder ubiOrder) {
	    int result = sqlSession.insert("order.insertUbiOrderCancel", ubiOrder);
	    return result;
	}
	
	/**
	 * UBI판매정보 입력[취소]
	 * @param ubiOrder
	 * @return
	 */
	public int insertUbiOrderCancel2(UbiOrder ubiOrder) {
	    int result = sqlSession.insert("order.insertUbiOrderCancel2", ubiOrder);
	    return result;
	}	
	
	public int insertUbiOrderExchange(UbiOrder ubiOrder) {
	    int result = sqlSession.insert("order.insertUbiOrderExchange", ubiOrder);
	    return result;
	}		
	
	
	/**
	 * UBI판매정보 수정
	 * @param ubiOrder
	 * @return
	 */
	public int updateUbiOrder(UbiOrder ubiOrder) {
	    int result = sqlSession.update("order.updateUbiOrder", ubiOrder);
	    return result;
	}	
	
	/**
	 * UBI판매번호 생성
	 * @param ubiOrder
	 * @return
	 */
	public int ubiOrderSeq() {
	    int result = sqlSession.selectOne("order.ubiOrderSeq");
	    return result;
	}
	
	public int insertPoint(Point point) {
		int result = 0;
		if(point.getRsvPnt() > 0){
			result = sqlSession.insert("point.insertPoint", point);
		}
	    return result;
	}
	
	public int deleteOrderCart(SearchForm searchForm) {
	    int result = sqlSession.delete("order.deleteOrderCart", searchForm);
	    return result;
	}		
	
	public String getOrdNoForTno(String tno) {
	    String result = sqlSession.selectOne("order.getOrdNoForTno", tno);
	    return result;
	}
	
	/**
	 * 가상계좌 주문건 자동취소
	 * @param ubiOrder
	 * @return
	 */
	public int cancelTempOrder() {
	    int result = sqlSession.update("scheduler.cancelTempOrder");
	    return result;
	}
	
	public int cancelTempOrder2() {
	    int result = sqlSession.update("scheduler.cancelTempOrder2");
	    return result;
	}
	
	public List<UbiOrder> getUbiOrderList(SearchForm searchForm) {
	    List<UbiOrder> result = sqlSession.selectList("order.getUbiOrderList", searchForm);
	    return result;
	}

	//주문완료된 쿠폰 삭제처리
	public int updateOffCpn(Coupon coupon) {
	    int result = sqlSession.update("coupon.updateOffCpn", coupon);
	    return result;
	}
	
	/**
	 * 주문 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Order> listOrderBatch(SearchForm searchForm) {
	    List<Order> result = sqlSession.selectList("order.listOrderBatch", searchForm);
	    return result;
	}	
}