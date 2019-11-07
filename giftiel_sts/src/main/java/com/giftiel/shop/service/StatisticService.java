package com.giftiel.shop.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giftiel.shop.dao.StatisticDao;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.StatisticsConn;
import com.giftiel.shop.dto.StatisticsForm;

@Service

public class StatisticService {

	@Autowired
	private StatisticDao statisticDao;

	public int countVisit(StatisticsForm statisticsForm) {
		int result = statisticDao.countVisit(statisticsForm);
		return result;
	}
	
	public int insertVisit(StatisticsForm statisticsForm) {
		int result = statisticDao.insertVisit(statisticsForm);
		return result;
	}
	
	public List<SearchForm> selectVisitAll(SearchForm searchForm) {
		List<SearchForm> result = statisticDao.selectVisitAll(searchForm);
		return result;
	}
	
	public List<SearchForm> selectVisitEtc(SearchForm searchForm) {
		List<SearchForm> result = statisticDao.selectVisitEtc(searchForm);
		return result;
	}
	
	public int totalVisit(SearchForm searchForm){
		int result = statisticDao.totalVisit(searchForm);
		return result;
	}
	public int totalVisitCnt(SearchForm searchForm){
		int result = statisticDao.totalVisitCnt(searchForm);
		return result;
	}
	
	public List<StatisticsForm> salesGraphStatistics (SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.salesGraphStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsForm> sumSalesGraphStatistics (SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.sumSalesGraphStatistics(searchForm);
		return result;
	}
	
	public int totalSalesGraphStatistics(SearchForm searchForm){
		int result = statisticDao.totalSalesGraphStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsForm> salesProductStatistics(SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.salesProductStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsForm> sumSalesProductStatistics (SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.sumSalesProductStatistics(searchForm);
		return result;
	}
	
	public int totalSalesProductStatistics(SearchForm searchForm){
		int result = statisticDao.totalSalesProductStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsForm> memStatistics(SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.memStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsForm> sumMemStatistics(SearchForm searchForm){
		List<StatisticsForm> result = statisticDao.sumMemStatistics(searchForm);
		return result;
	}
	
	public int totalMemStatistics(SearchForm searchForm){
		int result = statisticDao.totalMemStatistics(searchForm);
		return result;
	}
	
	public List<StatisticsConn> listVisit(SearchForm searchForm) {
		
		List<StatisticsConn> result = new ArrayList<StatisticsConn>();
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<HashMap<String,Object>> value = new ArrayList<HashMap<String,Object>>();
		
		// 일별
		if(searchForm.getDateType().equals("Day")){
			for(int i=0;i<24;i++){
				value.add(map);
			}
			searchForm.setValue(value);
			result = statisticDao.listVisit(searchForm);
		// 요일별
		}else if(searchForm.getDateType().equals("Week")){
			result = statisticDao.listVisitWeek(searchForm);
		
		// 월별
		}else if (searchForm.getDateType().equals("Month")) {
			int lastDay = 0;
			Calendar cal = Calendar.getInstance();
			String year = searchForm.getSearchStrDtm().split("\\.")[0];
			String month = searchForm.getSearchStrDtm().split("\\.")[1];
			
			int yy = Integer.parseInt(year);
			int mm = Integer.parseInt(month);
			
			cal.set(yy, mm-1, 1);
			lastDay = cal.getActualMaximum(Calendar.DATE);
			
			for(int i=0; i < lastDay; i++){
				map.put("day", (year + "." + month));
				value.add(map);
			}
			searchForm.setValue(value);
			
			searchForm.setSearchStrDtm(year + "." + month + ".01");
			searchForm.setSearchEndDtm(year + "." + month + "." + lastDay);
			
			result = statisticDao.listVisit(searchForm);
		
		// 연도별
		}else if (searchForm.getDateType().equals("Year")){
			int lastDay = 0;
			
			Calendar cal = Calendar.getInstance();
			
			String sYear = searchForm.getSearchStrDtm().split("\\.")[0];
			String sMonth = searchForm.getSearchStrDtm().split("\\.")[1];
			String eYear = searchForm.getSearchEndDtm().split("\\.")[0];
			String eMonth = searchForm.getSearchEndDtm().split("\\.")[1];
			
			int sy = Integer.parseInt(sYear);
			int sm = Integer.parseInt(sMonth);
			
			int ey = Integer.parseInt(eYear);
			int em = Integer.parseInt(eMonth);
			
			cal.set(ey, em-1, 1);
			
			int month = (ey - sy) * 12 + (em-sm);
			
			//마지막날 셋팅
			lastDay = cal.getActualMaximum(Calendar.DATE);
			
			for(int i=0; i < month+1; i++){
				map.put("day", (sYear + "." + sMonth));
				value.add(map);
			}

			searchForm.setValue(value);
			
			searchForm.setSearchStrDtm(sYear + "." + sMonth + ".01");
			searchForm.setSearchEndDtm(eYear + "." + eMonth + "." + lastDay);
			
			result = statisticDao.listVisit(searchForm);
		
		// 시간별
		}else if (searchForm.getDateType().equals("Hour")){
		
			for(int i=0;i<24;i++){
				value.add(map);
			}
			searchForm.setValue(value);
			
			result = statisticDao.listVisit(searchForm);
		}
		
		
	    return result;
	}	
	
	public int StatisticsTot(SearchForm searchForm){
		
		int result = 0;
		
		if(searchForm.getDateType().equals("Week")){
			result = statisticDao.StatisticsWeekTot(searchForm);
		}else{
			result = statisticDao.StatisticsTot(searchForm);
		}
		return result;
	}

	public List<SearchForm> genderVisit(SearchForm searchForm){
		List<SearchForm> result = statisticDao.genderVisit(searchForm);		
		return result;
	}
	
	public List<SearchForm> ageVisit(SearchForm searchForm){

		HashMap<String,Object> map = new HashMap<String,Object>();
		List<HashMap<String,Object>> value = new ArrayList<HashMap<String,Object>>();
		
		String orderCount = searchForm.getOrderBy()==""?"10":searchForm.getOrderBy();
		orderCount = searchForm.getOrderBy()==null?"10":searchForm.getOrderBy();
		
		int loopCnt = 0;
		String loopValue = null;
		
		if (orderCount.equals("10")) {
			loopCnt = 6;
			loopValue = "10";
		}else if (orderCount.equals("5")) {
			loopCnt = 12;
			loopValue = "5";
		}else if (orderCount.equals("3")) {
			loopCnt = 19;
			loopValue = "3";
		}else{
			loopCnt = 6;
			loopValue = "10";
		}
		
		for(int i=0; i < loopCnt; i++){
			map.put("age", loopValue);
			value.add(map);
		}

		searchForm.setValue(value);
		
		List<SearchForm> result = statisticDao.ageVisit(searchForm);		
		return result;
	}

	public List<SearchForm> residenceVisit(SearchForm searchForm){
		List<SearchForm> result = statisticDao.residenceVisit(searchForm);
		return result;
	}
	
	public List<HashMap<String, String>> residenceVisitAjax(SearchForm searchForm){
		List<HashMap<String, String>> result = statisticDao.residenceVisitAjax(searchForm);
		return result;
	}
	
	public List<SearchForm> residenceTotal(SearchForm searchForm){
		List<SearchForm> result = statisticDao.residenceTotal(searchForm);
		return result;
	}
	
	public List<SearchForm> savingStatisticsList(SearchForm searchForm) throws Exception{
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<HashMap<String,Object>> value = new ArrayList<HashMap<String,Object>>();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		
		Date beginDate = formatter.parse(searchForm.getSearchStrDtm());
		Date endDate = formatter.parse(searchForm.getSearchEndDtm());
		
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff/(24*60*60*1000);
		
		for(int i=0; i <= diffDays; i++){
			map.put("day", searchForm.getSearchStrDtm());
			value.add(map);
		}
		
		searchForm.setValue(value);
		
		List<SearchForm> result = statisticDao.savingStatisticsList(searchForm);
		
		return result;
	}
	
	public List<SearchForm> savingStatisticsTotal(SearchForm searchForm){
		List<SearchForm> result = statisticDao.savingStatisticsTotal(searchForm);
		return result;
	}
	
	public int savingStatisticsTotalCnt(SearchForm searchForm) throws Exception{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		
		Date beginDate = formatter.parse(searchForm.getSearchStrDtm());
		Date endDate = formatter.parse(searchForm.getSearchEndDtm());
		
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff/(24*60*60*1000);
		
		searchForm.setTotalCnt((int) diffDays);
		
		int result = statisticDao.savingStatisticsTotalCnt(searchForm);
		return result;
	}
	
	public List<StatisticsConn> goodsProductStatisticsList (SearchForm searchForm) throws Exception{
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<HashMap<String,Object>> value = new ArrayList<HashMap<String,Object>>();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		
		Date beginDate = formatter.parse(searchForm.getSearchStrDtm());
		Date endDate = formatter.parse(searchForm.getSearchEndDtm());
		
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff/(24*60*60*1000);

		for(int i=0; i <= diffDays; i++){
			map.put("day", searchForm.getSearchStrDtm());
			value.add(map);
		}
		
		searchForm.setValue(value);
		
		List<StatisticsConn> result = statisticDao.goodsProductStatisticsList(searchForm);
		return result;
	}

	public List<StatisticsConn> goodsProductStatisticsTot (SearchForm searchForm){
	
		List<StatisticsConn> result = statisticDao.goodsProductStatisticsTot(searchForm);
		return result;
	}
	
	public int goodsProductStatisticsTotCnt(SearchForm searchForm) throws Exception{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		
		Date beginDate = formatter.parse(searchForm.getSearchStrDtm());
		Date endDate = formatter.parse(searchForm.getSearchEndDtm());
		
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff/(24*60*60*1000);
		
		searchForm.setTotalCnt((int) diffDays);
		
		int result = statisticDao.goodsProductStatisticsTotCnt(searchForm);
		return result;
	}
}
