package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.StatisticsConn;
import com.giftiel.shop.dto.StatisticsForm;

@Repository
public class StatisticDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession; 
	}
	
	// Front Intercepter에서 사용
	public int countVisit(StatisticsForm statisticsForm) {
		int result = sqlSession.selectOne("statistic.countVisit", statisticsForm);
		return result;
	}
	public int insertVisit(StatisticsForm statisticsForm) {
		int result = sqlSession.insert("statistic.insertVisit", statisticsForm);
		return result;
	}

	// 관리자 - 접속통계 : 접속방향통계
	public List<SearchForm> selectVisitAll(SearchForm searchForm) {
	    List<SearchForm> result = sqlSession.selectList("statistic.selectVisitAll", searchForm);
	    return result;
	}
	
	public List<SearchForm> selectVisitEtc(SearchForm searchForm) {
	    List<SearchForm> result = sqlSession.selectList("statistic.selectVisitEtc", searchForm);
	    return result;
	}
	
	
	// 전체방문수
	public int totalVisit(SearchForm searchForm){
		
		int result = 0;
		
		if(searchForm.getDateType().equals("All")){
			result = sqlSession.selectOne("statistic.totalVisitAll", searchForm);
		}
		if(searchForm.getDateType().equals("Domain")){
			result = sqlSession.selectOne("statistic.totalVisitDomain", searchForm);
		}
		if(searchForm.getDateType().equals("OS")){
			result = sqlSession.selectOne("statistic.totalVisitEtc", searchForm);
		}
		if(searchForm.getDateType().equals("Browser")){
			result = sqlSession.selectOne("statistic.totalVisitEtc", searchForm);
		}
		
		return result;
	}

	// 전체합계
	public int totalVisitCnt(SearchForm searchForm){

		int result = 0;
		
		if(searchForm.getDateType().equals("Domain")){
			result = sqlSession.selectOne("statistic.totalVisitDomain", searchForm);
		}else{
			result = sqlSession.selectOne("statistic.totalVisitAll", searchForm);
		}
		return result;
	}
	
	// 전체매출통계
	public List<StatisticsForm> salesGraphStatistics(SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.salesGraphStatistics", searchForm);
		return result;
	}
	// 전체매출통계 합계
	public List<StatisticsForm> sumSalesGraphStatistics(SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.sumSalesGraphStatistics", searchForm);
		return result;
	}
	//전체매출통계 토탈
	public int totalSalesGraphStatistics(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.totalSalesGraphStatistics", searchForm);
		return result;
	}	
	//상품별매출통계
	public List<StatisticsForm> salesProductStatistics(SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.salesProductStatistics",searchForm);
		return result;
	}
	//상품별매출 통계	
	public List<StatisticsForm> sumSalesProductStatistics (SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.sumSalesProductStatistics",searchForm);
		return result;
	}
	//상품별매출통계 토탈	
	public int totalSalesProductStatistics(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.totalSalesProductStatistics",searchForm);
		return result;
	}
	//상품별매출통계
	public List<StatisticsForm> memStatistics(SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.memStatistics",searchForm);
		return result;
	}
	//상품별매출 통계	
	public List<StatisticsForm> sumMemStatistics (SearchForm searchForm){
		List<StatisticsForm> result = sqlSession.selectList("statistic.sumMemStatistics",searchForm);
		return result;
	}
	//상품별매출통계 토탈	
	public int totalMemStatistics(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.totalMemStatistics",searchForm);
		return result;
	}

	
	//방문자 접속 통계 리스트
	public List<StatisticsConn> listVisit(SearchForm searchForm) {
	    List<StatisticsConn> result = sqlSession.selectList("statistic.listVisit", searchForm);
	    return result;
	}	
	
	//방문자 총합
	public int StatisticsTot(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.StatisticsTot", searchForm);
		return result;
	}
	
	
	//방문자 접속 통계 리스트[요일별]
	public List<StatisticsConn> listVisitWeek(SearchForm searchForm) {
	    List<StatisticsConn> result = sqlSession.selectList("statistic.listVisitWeek", searchForm);
	    return result;
	}
	
	//방문자 접속 통계 리스트[시간별]
	public List<StatisticsConn> listHourVisit(SearchForm searchForm){
		List<StatisticsConn> result = sqlSession.selectList("statistic.listHourVisit", searchForm);
		return result;
	}
	
	//방문자 총합[요일별]
	public int StatisticsWeekTot(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.StatisticsWeekTot", searchForm);
		return result;
	}
	
	//남여비율통계
	public List<SearchForm> genderVisit(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.genderVisit", searchForm);
		return result;
	}
	
	//연령대별통계
	public List<SearchForm> ageVisit(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.ageVisit", searchForm);
		return result;
	}
	
	//거주지별통계
	public List<SearchForm> residenceVisit(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.residenceVisit", searchForm);
		return result;
	}
	
	public List<HashMap<String, String>> residenceVisitAjax(SearchForm searchForm){
		List<HashMap<String, String>> result = sqlSession.selectList("statistic.residenceVisitAjax", searchForm);
		return result;
	}
	
	public List<SearchForm> residenceTotal(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.residenceTotal", searchForm);
		return result;
	}
	
	public List<SearchForm> savingStatisticsList(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.savingStatisticsList", searchForm);
		return result;
	}
	
	public List<SearchForm> savingStatisticsTotal(SearchForm searchForm){
		List<SearchForm> result = sqlSession.selectList("statistic.savingStatisticsTotal", searchForm);
		return result;
	}
	
	public int savingStatisticsTotalCnt(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.savingStatisticsTotalCnt", searchForm);
		return result;
	}
	public int goodsProductStatisticsTotCnt(SearchForm searchForm){
		int result = sqlSession.selectOne("statistic.goodsProductStatisticsTotCnt", searchForm);
		return result;
	}
	
	public List<StatisticsConn> goodsProductStatisticsList(SearchForm searchForm){
		List<StatisticsConn> result = sqlSession.selectList("statistic.goodsProductStatisticsList", searchForm);
		return result;
	}

	public List<StatisticsConn> goodsProductStatisticsTot(SearchForm searchForm){
		List<StatisticsConn> result = sqlSession.selectList("statistic.goodsProductStatisticsTot", searchForm);
		return result;
	}
}