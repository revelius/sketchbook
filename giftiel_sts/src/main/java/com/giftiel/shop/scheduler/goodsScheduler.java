package com.giftiel.shop.scheduler;


import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.giftiel.shop.service.CategoryService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.UtilsService;


@Component
public class goodsScheduler {
	@Autowired
	OrderService orderService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	UtilsService utilsService;		
	
	public boolean getServerType() throws UnknownHostException{
		boolean result = false;
		
		//해당 아이피에서만 동작
		InetAddress inet= InetAddress.getLocalHost();
		if("1.234.39.106".equals(inet.toString().substring(inet.toString().indexOf("/")+1,inet.toString().length()))){
			result = true;
		}
		
		return result;
	}	
	
	/**
	 * 1. 매시 30분에 호출이 되는 스케쥴러
	 * (초 분 시 일 월 요일) 
	 */
	@Scheduled(cron = "0 30 * * * *")
	public void goodsCacheDelete(){
		//상품 캐시 삭제
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("someCache")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		    if (name.equals("someCache2")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }		    
		}
		
		System.out.println("===============상품 캐시 삭제=============");
	}
	
	@Scheduled(cron = "0 0 07 * * *")
	public void newsCacheDelete(){
		//뉴스 캐시 삭제
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("topNewsList")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		}
		
		System.out.println("===============뉴스 캐시 삭제=============");
	}
	
	@Scheduled(cron = "0 0 05 * * *")
	public void cateCacheDelete(){
		//카테고리 캐시 삭제
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("snbShop")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		}
		System.out.println("===============카테고리 캐시 삭제=============");
	}
	
	
	
	/**
	 * 상품이 전시되지 않은 브랜드 감춤처리
	 * @throws UnknownHostException 
	 */
	@Scheduled(cron = "0 0 06 * * *")
	public void brandCategoryInit() throws UnknownHostException{
		if(this.getServerType()){
			categoryService.brandCategoryInit();
			System.out.println("===============상품이 전시되지 않은 브랜드 감춤처리=============");
		}
	}
	
	@Scheduled(cron = "0 0 23 * * *")
	public void googleCdnImgSend() throws IOException{
		//로컬에서만 작동
		if(!this.getServerType()){
//			utilsService.googleCdnImgSend("");
			//utilsService.googleCdnImgSendUpdate();
		}
	}	
}
