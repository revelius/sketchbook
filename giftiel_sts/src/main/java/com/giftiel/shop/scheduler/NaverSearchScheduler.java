package com.giftiel.shop.scheduler;


import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.giftiel.shop.service.SyndiBatchJobService;


@Component
public class NaverSearchScheduler {
	@Autowired
	SyndiBatchJobService syndiBatchJobService;
	
	public boolean getServerType() throws UnknownHostException{
		boolean result = false;
		
		InetAddress inet= InetAddress.getLocalHost();
		if("1.234.39.106".equals(inet.toString().substring(inet.toString().indexOf("/")+1,inet.toString().length()))){
			result = true;
		}
		
		return result;
	}
	
	
	/**
	 * 1. 오전 02:00:00에 호출이 되는 스케쥴러
	 * (초 분 시 일 월 요일) 
	 * @throws UnknownHostException 
	 */
	@Scheduled(cron = "0 0 02 * * *")
	public void naverSearch() throws UnknownHostException{
		if(this.getServerType()){
			System.out.println("=====================naver 검색 등록 시작=====================");
	//		syndiBatchJobService.syndiNaverSearch_news();
			syndiBatchJobService.syndiNaverSearch_news("10001");//worksout
			syndiBatchJobService.syndiNaverSearch_news("10002");//carhartt-wip
			syndiBatchJobService.syndiNaverSearch_news("10003");//obeyclothing
			syndiBatchJobService.syndiNaverSearch_news("10004");//brixton
			syndiBatchJobService.syndiNaverSearch_news("10006");//deus
	//		syndiBatchJobService.syndiNaverSearch_manual("10004","http://www.brixton.co.kr/front/storeInfo/Ab","brixton store info");
			System.out.println("=====================naver 검색 등록 완료=====================");
		}
	}
	
	
	
}
