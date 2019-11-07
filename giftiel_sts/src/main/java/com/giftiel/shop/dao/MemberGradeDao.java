package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.MemberGrade;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class MemberGradeDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public List<MemberGrade> listGrd(SearchForm searchForm) {
	    List<MemberGrade> result = sqlSession.selectList("memberGrade.listGrd", searchForm);
	    return result;
	}
	
}