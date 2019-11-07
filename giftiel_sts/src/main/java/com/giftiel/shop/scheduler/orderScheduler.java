package com.giftiel.shop.scheduler;


import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.service.PointService;


@Component
public class orderScheduler {
	@Autowired
	OrderService orderService;
	@Autowired
	PointService pointService;	

	public boolean getServerType() throws UnknownHostException{
		boolean result = false;
		
		InetAddress inet= InetAddress.getLocalHost();
		if("1.234.39.106".equals(inet.toString().substring(inet.toString().indexOf("/")+1,inet.toString().length()))){
			result = true;
		}
		
		return result;
	}	
	
	/**
	 * 1. 오전 04:00:00에 호출이 되는 스케쥴러
	 * 가상계좌 주문시 자동 취소
	 * (초 분 시 일 월 요일) 
	 * @throws ParseException 
	 * @throws UnknownHostException 
	 */
	@Scheduled(cron = "0 0 04 * * *")
	//@Scheduled(cron = "0 02 15 * * *")
	public void tempOrderCancel() throws ParseException, UnknownHostException{
		
		//가상계좌주문 자동취소
		if(this.getServerType()){
			System.out.println("=====================3일 이전 가상계좌 주문 자동취소 시작=====================");
			orderService.cancelTempOrder();
			System.out.println("=====================3일 이전 가상계좌 주문 자동취소 완료=====================");
		}		
		
	}
	
	/**
	 * 2. 오전 :05:00:00에 호출이 되는 스케줄러
	 * 주문 배송 완료된 회원 포인트 지급
	 * @throws UnknownHostException 
	 */
	@Scheduled(cron = "0 0 05 * * *")
//	@Scheduled(cron = "0 10 17 * * *")
	public void pointRsv() throws UnknownHostException{
		if(this.getServerType()){
			System.out.println("=====================포인트 지급 시작=====================");
			pointService.pointReservProcess();
			System.out.println("=====================포인트 지급 끝=====================");
		}
		
	}
}
