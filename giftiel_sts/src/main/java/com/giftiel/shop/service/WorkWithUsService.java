package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.WorkWithUsDao;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.WorkWithUs;

@Service
public class WorkWithUsService {

	@Autowired
	private WorkWithUsDao workWithUsDao;
	
	public List<WorkWithUs> listWorkWithus(SearchForm searchForm) {
		List<WorkWithUs> workWithUs = workWithUsDao.listWorkWithus(searchForm);
		return workWithUs;
	}
	
	public int totalListWorkWithus(SearchForm searchForm) {
		int result = workWithUsDao.totalListWorkWithus(searchForm);
		return result;
	}
	
	public WorkWithUs workWithUsDetail(int withusSeq) {
		WorkWithUs workWithUs = workWithUsDao.workWithUsDetail(withusSeq);
		
		int size = workWithUs.getWorkWithUsSite().size();
		Integer[] siteNo = new Integer[size];
		for(int i=0;i<size;i++ ){
			siteNo[i] = workWithUs.getWorkWithUsSite().get(i).getSiteNo();
		}
		workWithUs.setSiteNo(siteNo);
		
		return workWithUs;
	}
}
