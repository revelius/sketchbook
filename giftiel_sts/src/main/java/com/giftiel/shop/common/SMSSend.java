package com.giftiel.shop.common;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.giftiel.shop.dao.ManageDao;
import com.giftiel.shop.dao.OrderDao;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.SmsMng;
@Component
public class SMSSend{
	@Autowired
	private ManageDao manageDao;
	@Autowired
	private OrderDao orderDao;
	
	@Value("${send.sms.no}")
	private String sendSmsNo;		
	
	public int sendSMS(Integer mngNo, String rndrSmsNo, String brandSite, String name, String ordNo, Integer ordGdsSeq) {
		SmsMng smsDetail = manageDao.SmsMngDetail(mngNo);
		
		String text = smsDetail.getSmsTxt();
		
		if(StringUtils.isNotEmpty(brandSite)){
			text = StringUtils.replace(text, "[BRANDNAME]", brandSite);
			text = StringUtils.replace(text, "[BRANDSITE]", brandSite);
		}
		if(StringUtils.isNotEmpty(name)){
			text = StringUtils.replace(text, "[NAME]", name);
		}
		if(StringUtils.isNotEmpty(ordNo)){
			text = StringUtils.replace(text, "[ORDERNUMBER]", ordNo);	
		}
		
		//배송시작 문자
		if(mngNo == 5){
			SearchForm searchForm = new SearchForm();
			searchForm.setOrdNo(ordNo);
			
			Order order = orderDao.selectOrder(searchForm);
			
			for (int i = 0; i < order.getOrderGoods().size(); i++) {
				if(order.getOrderGoods().get(i).getOrdGdsSeq().equals(ordGdsSeq)){
					text = StringUtils.replace(text, "[DLVCMPNM]", order.getOrderGoods().get(i).getDlvCmpNm());
					text = StringUtils.replace(text, "[INV_NO]", order.getOrderGoods().get(i).getInvNo());
					text = StringUtils.replace(text, "[GOODSNAME]", order.getOrderGoods().get(i).getUbiGdsNm());					
				}
			}

		}

		SmsMng smsForm = new SmsMng();
		smsForm.setSmsTxt(text);
		smsForm.setCallFrom(sendSmsNo);
		smsForm.setCallTo(StringUtils.replace(rndrSmsNo.trim(), "-", ""));
		
		int result = 0;
		if("Y".equals(smsDetail.getAutoCls())){
			result = manageDao.smsInsert(smsForm);
		}else{
			result = 0;
		}

	    return result;
	}
	
	public int sendSMSEtc(String message, String rndrSmsNo) {
		
		SmsMng smsForm = new SmsMng();
		smsForm.setSmsTxt(message);
		smsForm.setCallFrom(sendSmsNo);
		smsForm.setCallTo(StringUtils.replace(rndrSmsNo.trim(), "-", ""));
		
		int result = manageDao.smsInsert(smsForm);

	    return result;
	}
	
}


