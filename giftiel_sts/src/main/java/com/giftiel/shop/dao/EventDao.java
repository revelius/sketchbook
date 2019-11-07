package com.giftiel.shop.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Event;

@Repository
public class EventDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int evtJoinEmailChk(String email){
		int result = sqlSession.selectOne("event.evtJoinEmailChk", email);
	    return result;
	}
	
	
	public int insertEvtJoin(Event event) {
	    int result = sqlSession.insert("event.insertEvtJoin", event);
	    return result;
	}
	
	public int updateEvtJoin(Event event) {
	    int result = sqlSession.update("event.updateEvtJoin", event);
	    return result;
	}

}
