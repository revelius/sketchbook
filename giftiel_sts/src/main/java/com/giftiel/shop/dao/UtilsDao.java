package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.Table;
import com.giftiel.shop.dto.ZipCode;

@Repository
public class UtilsDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public List<Table> selectTableList() {
		List<Table> table = sqlSession.selectList("util.selectTableList");
		return table;
	}
	
	public List<Table> selectColumnList(Table table) {
		List<Table> result = sqlSession.selectList("util.selectColumnList",table);
		return result;
	}
	
	public int googleCdnImgSend() {
	    int result = sqlSession.update("scheduler.googleCdnImgSend");
	    return result;
	}		
}
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		