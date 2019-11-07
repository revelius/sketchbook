package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.CarharttRadioDao;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.SearchForm;

@Service
public class CarharttRadioService {
	@Autowired
	private CarharttRadioDao carharttRadioDao;
	
	public List<CarharttRadioForm> carharttRadioList(SearchForm searchForm) {
	    List<CarharttRadioForm> result = carharttRadioDao.carharttRadioList(searchForm);
	    return result;
	}
	
	public CarharttRadioForm carharttRadioPopup(int radioNo) {
		CarharttRadioForm carharttRadioPopup = carharttRadioDao.carharttRadioPopup(radioNo);
		return carharttRadioPopup;
	}
	
	public int carharttRadioTotalList(SearchForm searchForm) {
	    int result = carharttRadioDao.carharttRadioTotalList(searchForm);
	    return result;
	}
}
