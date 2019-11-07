package com.giftiel.shop.controller.common;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;




@Controller
@RequestMapping("/common")
public class CacheController extends FrontController{
    
    /**
     * 인증시작
     * @param urlCode
     * @param locale
     * @param model
     * @param request
     * @param response
     * @throws Exception
     */
	@RequestMapping(value = "/cacheReload" , method = RequestMethod.GET)
	public void cacheReload(Locale locale,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {		
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("someCache") || name.equals("someCache2")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		}
	}
	
	@RequestMapping(value = "/cacheReloadNews" , method = RequestMethod.GET)
	public void cacheReloadNews(Locale locale,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {		
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("topNewsList")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		}
	}
	
	@RequestMapping(value = "/cacheReloadCate" , method = RequestMethod.GET)
	public void cacheReloadCate(Locale locale,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {		
		CacheManager cacheManager = CacheManager.getInstance();
		String[] names = cacheManager.getCacheNames();
		for (String name : names) {
		    if (name.equals("snbShop")) {
		        Cache cache = cacheManager.getCache(name);
		        cache.removeAll();
		    }
		}
	}	
}

