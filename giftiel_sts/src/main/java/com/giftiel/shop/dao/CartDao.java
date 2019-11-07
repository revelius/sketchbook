package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.dto.Comment;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;

/**
 * 회원관련 업무 수행
 * @author kwonYj
 *
 */
@Repository
public class CartDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	public List<Cart> selectCartList(SearchForm searchForm) {
	    List<Cart> result = sqlSession.selectList("cart.selectCartList", searchForm);
	    return result;
	}
	public int totalListCart(SearchForm searchForm) {
	    int result = sqlSession.selectOne("cart.totalListCart", searchForm);
	    return result;
	}
	
	public List<Cart> selectGdsNo(Cart bean) {
	    List<Cart> result = sqlSession.selectList("cart.selectGdsNo", bean);
	    return result;
	}
	
	public List<Cart> selectGdsCart(Cart bean) {
	    List<Cart> result = sqlSession.selectList("cart.selectGdsCart", bean);
	    return result;
	}
	
	public List<Cart> sizeList(String ubiGdsNo) {
	    List<Cart> result = sqlSession.selectList("cart.sizeList", ubiGdsNo);
	    return result;
	}
	
	public int insertGdsCart(Cart bean) {
	    int result = sqlSession.insert("cart.insertGdsCart", bean);
	    return result;
	}
	
	public int updateGdsCart(Cart bean) {
	    int result = sqlSession.update("cart.updateGdsCart", bean);
	    return result;
	}
	
	public int deleteGdsCart(Integer cartNo) {
	    int result = sqlSession.delete("cart.deleteGdsCart", cartNo);
	    return result;
	}
	
	public int updateGdsSize(Cart bean) {
	    int result = sqlSession.update("cart.updateGdsSize", bean);
	    return result;
	}
	public List<Cart> selectFrontCartList(SearchForm searchForm) {
	    List<Cart> result = sqlSession.selectList("cart.selectFrontCartList", searchForm);
	    return result;
	}	
}