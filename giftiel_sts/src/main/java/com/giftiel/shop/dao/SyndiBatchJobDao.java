package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Event;

@Repository
public class SyndiBatchJobDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<HashMap<String,Object>> getNewsList(){
		List<HashMap<String,Object>> result = sqlSession.selectList("scheduler.getNewsList");
		return result;
	}
	
	
	public List<HashMap<String,Object>> getNewsList(String siteNo){
		List<HashMap<String,Object>> result = sqlSession.selectList("scheduler.getNewsList",siteNo);
		return result;
	}
	
//	public int evtJoinEmailChk(String email){
//		int result = sqlSession.selectOne("event.evtJoinEmailChk", email);
//	    return result;
//	}
//	
	
//	public int insertEvtJoin(Event event) {
//	    int result = sqlSession.insert("event.insertEvtJoin", event);
//	    return result;
//	}
//	
//	public int updateEvtJoin(Event event) {
//	    int result = sqlSession.update("event.updateEvtJoin", event);
//	    return result;
//	}

}
