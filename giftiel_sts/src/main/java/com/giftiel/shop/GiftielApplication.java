package com.giftiel.shop;


import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

import com.giftiel.shop.common.FullBeanNameGenerator;

@SpringBootApplication
@EnableAutoConfiguration
@ComponentScan(basePackages = "com.giftiel.shop")
public class GiftielApplication extends SpringBootServletInitializer{
	public static void main(String[] args){
		final SpringApplicationBuilder builder = new SpringApplicationBuilder(GiftielApplication.class);
		builder.beanNameGenerator(new FullBeanNameGenerator());
		builder.run(args);
	}
}
