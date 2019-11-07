package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CartDao;
import com.giftiel.shop.dto.Cart;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;

@Service
@Transactional
public class CartService {
	@Autowired
	private CartDao cartDao;
	
	public List<Cart> selectCartList(SearchForm searchForm) {
	    List<Cart> result = cartDao.selectCartList(searchForm);
	    return result;
	}
	
	public int totalListCart(SearchForm searchForm) {
	    int result = cartDao.totalListCart(searchForm);
	    return result;
	}
	
	public List<Cart> selectGdsNo(Cart bean) {
	    List<Cart> result = cartDao.selectGdsNo(bean);
	    return result;
	}
	
	public List<Cart> selectGdsCart(Cart bean) {
	    List<Cart> result = cartDao.selectGdsCart(bean);
	    return result;
	}
	
	public List<Cart> sizeList(String ubiGdsNo) {
	    List<Cart> result = cartDao.sizeList(ubiGdsNo);
	    return result;
	}
	
	public int insertGdsCart(Cart bean) {
	    int result = cartDao.insertGdsCart(bean);
	    return result;
	}
	
	public int updateGdsCart(Cart bean) {
	    int result = cartDao.updateGdsCart(bean);
	    return result;
	}
	
	public int deleteGdsCart(Integer cartNo) {
	    int result = cartDao.deleteGdsCart(cartNo);
	    return result;
	}
	
	public int updateGdsSize(Cart bean) {
	    int result = cartDao.updateGdsSize(bean);
	    return result;
	}
	public List<Cart> selectFrontCartList(SearchForm searchForm) {
	    List<Cart> result = cartDao.selectFrontCartList(searchForm);
	    return result;
	}	
}