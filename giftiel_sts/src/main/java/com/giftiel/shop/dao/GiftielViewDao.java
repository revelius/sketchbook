package com.giftiel.shop.dao;

import java.net.URI;
import java.nio.charset.Charset;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.giftiel.shop.dto.GiftielViewInput;


@Repository
public class GiftielViewDao {

	private static final Logger log = LoggerFactory.getLogger(GiftielViewDao.class);
	
	@Value("${giftiel.test.url}")
	private String giftielTestUrl;
	
//	@Value("${giftiel.oper.url}")
//	private String giftielOperUrl;

	@Value("${giftiel.getCouponViewData.url}")
	private String giftielGetCouponViewDataUrl;
	
	@Value("${giftiel.getCouponCondition.url}")
	private String giftielGetCouponConditionUrl;
	
	@Value("${giftiel.getCouponConditionEx.url}")
	private String giftielGetCouponConditionExUrl;
	
	@Value("${giftiel.getEachCouponAuthInformation.url}")
	private String giftielGetEachCouponAuthInformationUrl;
	
	@Value("${giftiel.getSendCouponData.url}")
	private String giftielGetSendCouponDataUrl;
	
	@Value("${http.timeout}")
	private int timeout;
	
	@Value("${http.maxConnetTotal}")
	private int httpMaxConnetTotal;
	
	@Value("${http.maxConnPerRoute}")
	private int httpMaxConnPerRoute;
	
	public String getReplyData(GiftielViewInput giftielViewInput) {
		StringBuffer sb = new StringBuffer();
		sb.append(giftielTestUrl);
		sb.append(giftielGetCouponViewDataUrl);
		
		
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(timeout); // 읽기시간초과, 10초
		factory.setConnectTimeout(timeout); // 연결시간초과, 10초 
		
		CloseableHttpClient httpClient = HttpClientBuilder.create()
			.setMaxConnTotal(httpMaxConnetTotal) // 최대 connection 
			.setMaxConnPerRoute(httpMaxConnPerRoute) // IP/domain name당 최대 커넥션 갯수 
			.build();
		factory.setHttpClient(httpClient);
				
		log.info("============ getReplyData factory : " + factory);
		RestTemplate restTemplate = new RestTemplate(factory);
		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		
		URI uri = UriComponentsBuilder.fromHttpUrl(sb.toString().trim())
				.queryParam("CiCode", giftielViewInput.getCiCode())
				.queryParam("CiPwd", giftielViewInput.getCiPwd())
				.queryParam("CouponCode", giftielViewInput.getCouponCode())
				.queryParam("CouponNum", giftielViewInput.getCouponNum())
				.build().toUri(); 
		
		log.info("============ getReplyDataUrl : " + uri);
		
		String response = restTemplate.getForObject(uri, String.class);

		log.info("============ getReplyDataResult : " + response);
		
		return response;
	}

}