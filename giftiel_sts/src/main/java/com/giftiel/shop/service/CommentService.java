package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CommentDao;
import com.giftiel.shop.dto.Comment;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.SearchForm;

@Service
@Transactional
public class CommentService {
	@Autowired
	private CommentDao commentDao;
	
	public int insertMemComment(Comment bean) {
		int result = commentDao.insertMemComment(bean);
	    return result;
	} 
	
	public int deleteMemComment(Comment bean) {
		int result = commentDao.deleteMemComment(bean);
	    return result;
	} 
	
	public List<Comment> memberCmtList(SearchForm searchForm) {
	    List<Comment> result = commentDao.memberCmtList(searchForm);
	    return result;
	}
}