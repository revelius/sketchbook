package com.giftiel.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.GiftielViewDao;
import com.giftiel.shop.dto.GiftielViewInput;
import com.giftiel.shop.dto.GiftielViewReply;

@Service
@Transactional
public class GiftielViewService {

	@Autowired
	private GiftielViewDao giftielViewDao;
	
	public String getReplyData(GiftielViewInput giftielViewInput) {

		String result = giftielViewDao.getReplyData(giftielViewInput);
		
		return result;
	}

	
}
