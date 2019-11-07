package com.giftiel.shop.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	/**
	 * 시퀀스 키 생성
	 * @param seqId
	 * @return
	 */
	public Integer createKey(String seqId) {
		HashMap<String, String> params = new HashMap<String, String>(); 
		params.put("id", seqId);
		
		Integer result = sqlSession.selectOne("common.createKey", params);
	    return result;
	}
}