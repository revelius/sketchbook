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
public class CommentDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public int insertMemComment(Comment bean) {
		int result = sqlSession.insert("comment.insertMemComment", bean);
	    return result;
	}
	
	public int deleteMemComment(Comment bean) {
		int result = sqlSession.delete("comment.deleteMemComment", bean);
	    return result;
	}
	
	public List<Comment> memberCmtList(SearchForm searchForm) {
	    List<Comment> result = sqlSession.selectList("comment.memberCmtList", searchForm);
	    return result;
	}
}