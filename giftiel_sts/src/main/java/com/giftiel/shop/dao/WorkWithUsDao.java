package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.WorkWithUs;

@Repository
public class WorkWithUsDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<WorkWithUs> listWorkWithus(SearchForm searchForm) {
	    List<WorkWithUs> result = sqlSession.selectList("workWithUs.listWorkWithus", searchForm);
	    return result;
	}
	public int totalListWorkWithus(SearchForm searchForm) {
	    int result = sqlSession.selectOne("workWithUs.totalListWorkWithus", searchForm);
	    return result;
	}
	public WorkWithUs workWithUsDetail(int withusSeq) {
		WorkWithUs workWithUs = sqlSession.selectOne("workWithUs.workWithUsDetail", withusSeq);
		return workWithUs;
	} 
}
