package com.giftiel.shop.controller.front;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.giftiel.shop.controller.common.FrontController;
import com.giftiel.shop.service.PointService;
import com.giftiel.shop.service.UtilsService;
import com.giftiel.shop.utils.FtpUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/test")
public class TestController extends FrontController{
	
	@Autowired
	private FtpUtils ftpUtils;
	@Autowired
	private UtilsService utilsService;
	@Autowired
	private PointService pointService;	
	
	
	@RequestMapping(value = "/test", method = {RequestMethod.GET, RequestMethod.POST})
	public void test(String source)
			throws IOException {
		
		utilsService.googleCdnImgSend("");
		//pointService.pointReservProcess();
//		utilsService.worksoutRealPutClass("");
//		utilsService.worksoutRealPutWebFiles("");
	}
	 
	 @RequestMapping(value = "/download", method = {RequestMethod.GET, RequestMethod.POST})
	 public void download(String filePath, String fileName, HttpServletRequest request) throws Exception {
		 //ftpUtils.download("D:\\image_backup\\upload_googledrive\\", "/www/upload/image/");
	 }
}

























