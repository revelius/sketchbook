package com.giftiel.shop.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	
	/**
	 * 현재시간부터 대상일이 지낫는지 판단
	 * @return
	 * @throws ParseException 
	 */
	public static boolean overDate(String D_Date) throws ParseException {
		boolean result = false;
		
		SimpleDateFormat dateFormat = new  SimpleDateFormat("yyyy-MM-dd HH:mm", java.util.Locale.getDefault());
		
		Date ddate = dateFormat.parse(D_Date);
		Date today = new Date (); 
		
		result = today.after(ddate);
		return result;
	}

	public static boolean preDate(String D_Date) throws ParseException {
		boolean result = false;
		
		SimpleDateFormat dateFormat = new  SimpleDateFormat("yyyy-MM-dd HH:mm", java.util.Locale.getDefault());
		
		Date ddate = dateFormat.parse(D_Date);
		Date today = new Date (); 
		
		result = today.before(ddate);
		return result;
	}	
	
	/**
	 * 추가된 현재날짜 추출
	 */
	public static String getAddDate(Date nowDate, Integer D_Date) throws ParseException {
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String result = "";
	    // 날짜 더하기 
		Calendar cal = Calendar.getInstance();
		cal.setTime(nowDate);
		cal.add(Calendar.DATE, D_Date);
		//cal.add(Calendar.MONTH, 2);

		result = df.format(cal.getTime()).toString();
	    
    	return result;	
	}	
}
