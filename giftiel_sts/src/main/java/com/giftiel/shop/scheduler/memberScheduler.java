package com.giftiel.shop.scheduler;


import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.giftiel.shop.service.MemberService;


@Component
public class memberScheduler {
	@Autowired
	MemberService memberService;

	public boolean getServerType() throws UnknownHostException{
		boolean result = false;
		
		InetAddress inet= InetAddress.getLocalHost();
		if("1.234.39.106".equals(inet.toString().substring(inet.toString().indexOf("/")+1,inet.toString().length()))){
			result = true;
		}
		
		return result;
	}
	
	
	/**
	 * 1. 매월 1일 자정 실행
	 * 전달 30만원 이상 구매 회원 등급업
	 * (초 분 시 일 월 요일) 
	 * @throws UnknownHostException 
	 */
	@Scheduled(cron = "0 0 1 1 * *")
	public void tempOrderCancel() throws UnknownHostException{
		if(this.getServerType()){
			System.out.println("=====================회원등급업 시작=====================");
			memberService.gradeUpMember();
			System.out.println("=====================회원등급업 완료=====================");
		}
		
	}
}
