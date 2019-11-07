package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CodeDao;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.Site;

@Service
@Transactional
public class CodeService {
	@Autowired
	private CodeDao codeDao;
	
	public List<Code> listCd(String supCdNo) {
	    List<Code> result = codeDao.listCd(supCdNo);
	    return result;
	}
	
	public List<Code> listUbiBrand() {
	    List<Code> result = codeDao.listUbiBrand();
	    return result;
	}	
	
	public int insertCd(Code code) {
	    int result = codeDao.insertCd(code);
	    return result;
	}
	
	
	public List<Site> getSiteList() {
		List<Site> site = codeDao.getSiteList();
		return site;
	}
	
	
}