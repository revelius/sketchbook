package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.MemberGradeDao;
import com.giftiel.shop.dto.MemberGrade;
import com.giftiel.shop.dto.SearchForm;

@Service
@Transactional
public class MemberGradeService {
	@Autowired
	private MemberGradeDao memberGradeDao;
	
	public List<MemberGrade> listGrd(SearchForm searchForm) {
	    List<MemberGrade> result = memberGradeDao.listGrd(searchForm);
	    return result;
	}
	
}