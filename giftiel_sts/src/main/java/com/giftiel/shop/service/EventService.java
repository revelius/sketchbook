package com.giftiel.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.EventDao;
import com.giftiel.shop.dto.Event;

@Service
public class EventService {

	@Autowired
	private EventDao eventDao;
	
	public int evtJoinEmailChk(String email){
		int result = eventDao.evtJoinEmailChk(email);
	    return result;
	}
	
	public int insertEvtJoin(Event event) {
	    int result = eventDao.insertEvtJoin(event);
	    return result;
	}
	
	public int updateEvtJoin(Event event){
		int result = eventDao.updateEvtJoin(event);
		return result;
	}

}
