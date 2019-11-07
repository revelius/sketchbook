package com.giftiel.shop.controller.common;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.GoodsAddInfoGrp;
import com.giftiel.shop.dto.GoodsSize;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.service.GoodsService;
import com.giftiel.shop.service.OrderService;
import com.giftiel.shop.utils.FtpUtils;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/common")
public class FileUploadController {
	@Value("${server.setting}")
	private String serverSetting;
	
	@Value("${local.upload.path}")
	private String localPath;
	@Value("${dev.upload.path}")
	private String devPath;
	@Value("${real.upload.path}")
	private String realPath;
	
	@Value("${upload.image.path}")
	private String imagePath;
	@Value("${upload.excel.path}")
	private String excelPath;
	
	@Value("${upload.image}")
	private String uploadImage;	
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private FtpUtils ftpUtils;
	
    @RequestMapping(value = "/fileUpload", method = RequestMethod.GET)
    public ModelAndView fileForm(@RequestParam("type") String type) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/common/fileUpload/fileUpload");
        return mv;
    }
     
    @RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
    public ModelAndView fileSubmit(@RequestParam("uploadFile") MultipartFile uploadFile, @RequestParam("type") String type, @RequestParam("folderNm") String folderNm) {
    	ModelAndView mav = new ModelAndView();
    	String resultCode = "0";
    	String filePath = "";
    	String fileType = "";
    	String resultFileNm = "";
    	if("LOCAL".equals(serverSetting)){
    		filePath = localPath;
    	}else if("DEV".equals(serverSetting)){
    		filePath = devPath;
    	}else if("REAL".equals(serverSetting)){
    		filePath = realPath;
    	}
    	
    	if("image".equals(type)){
    		fileType = imagePath;
    	}else if("excel".equals(type)){
    		fileType = excelPath;
    	}else{
    		resultCode = "2";
    	}

    	try {
	    	//날짜별 폴더 생성
	        Calendar cal = Calendar.getInstance();
	        String folder=String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));

	        String fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	        if("LOCAL".equals(serverSetting)){
	        	fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	    	}else if("DEV".equals(serverSetting)){
	    		fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	    	}else if("REAL".equals(serverSetting)){
	    		fullFileName = filePath+fileType+"/"+folderNm+"/"+folder + "/";
	    	}	        
	        
	        File f = new File(fullFileName);
	        f.mkdirs();
	        
	        if (uploadFile != null) {
	            String fileName = String.format("%04d%02d%02d%02d%02d%02d%04d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.HOUR), cal.get(Calendar.MINUTE),cal.get(Calendar.SECOND) ,cal.get(Calendar.MILLISECOND)) + "." + StringUtils.split(uploadFile.getOriginalFilename(), ".")[1];
	            
	            String fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		        if("LOCAL".equals(serverSetting)){
		        	fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		    	}else if("DEV".equals(serverSetting)){
		    		fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		    	}else if("REAL".equals(serverSetting)){
		    		fullFileName2 = filePath+fileType+"/"+folderNm+"/"+folder+"/"+fileName;
		    	}	            
	            
	            File file = new File(fullFileName2);
	            uploadFile.transferTo(file);
	            resultFileNm =  "/"+folderNm+"/"+folder+"/"+fileName;	            
	            
	            //사이즈 차트 업로드시
	            if("sizeChart".equals(folderNm)){
	            	List<GoodsSize> goodsSizes = goodsService.getSizeChartExcel(file);
	            	mav.addObject("goodsSizes", goodsSizes);
	            }
	            
	            //상품 엑셀 대량업로드시
	            if("goodsExcel".equals(folderNm)){
	            	List<Goods> goodss = goodsService.getGoodsExcel(file);
	            	mav.addObject("goodss", goodss);
	            }
	            
	            //상품정보고시 엑셀 대량업로드시
	            if("goodsAddInfoExcel".equals(folderNm)){
	            	List<GoodsAddInfoGrp> goodsAddInfoGrp = goodsService.getGoodsAddInfoExcel(file);
	            	mav.addObject("goodsAddInfoGrp", goodsAddInfoGrp);
	            }
	            
	            //송장번호 업로드시
	            if("invNoExcel".equals(folderNm)){
	            	List<OrderGoods> orderGoods =  orderService.getInvNoExcel(file);
	            	mav.addObject("orderGoods", orderGoods);
	            }
	            
	            ftpUtils.upload(fullFileName2, fileType+"/"+folderNm+"/"+folder+"/", fileName);
	        }
    	}catch (Exception e) {
    		e.printStackTrace();
    		resultCode = "1";
		}
    	mav.addObject("fileNm", resultFileNm);
        mav.addObject("resultCode", resultCode);
        mav.setViewName("/common/fileUpload/fileUploadComplete");
		
        return mav;
    }
    
    @RequestMapping(value = "/fileUploadEditor", method = RequestMethod.POST)
    public ModelAndView fileUploadEditor(@RequestParam("uploadFile") MultipartFile uploadFile) {
    	String resultCode = "0";
    	String filePath = "";
    	String fileType = "";
    	String resultFileNm = "";
    	String type = "image";
    	String folderNm = "editor";
    	if("LOCAL".equals(serverSetting)){
    		filePath = localPath;
    	}else if("DEV".equals(serverSetting)){
    		filePath = devPath;
    	}else if("REAL".equals(serverSetting)){
    		filePath = realPath;
    	}
    	if("image".equals(type)){
    		fileType = imagePath;
    	}else if("excel".equals(type)){
    		fileType = excelPath;
    	}else{
    		resultCode = "2";
    	}
    	
    	try {
	    	//날짜별 폴더 생성
	        Calendar cal = Calendar.getInstance();
	        String folder=String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));

	        String fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	        if("LOCAL".equals(serverSetting)){
	        	fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	    	}else if("DEV".equals(serverSetting)){
	    		fullFileName = filePath+fileType+"\\"+folderNm+"\\"+folder + "\\";
	    	}else if("REAL".equals(serverSetting)){
	    		fullFileName = filePath+fileType+"/"+folderNm+"/"+folder + "/";
	    	}	        
	        
	        File f = new File(fullFileName);
	        f.mkdirs();
	        
	        
	        if (uploadFile != null) {
	            String fileName = String.format("%04d%02d%02d%02d%02d%02d%04d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.HOUR), cal.get(Calendar.MINUTE),cal.get(Calendar.SECOND) ,cal.get(Calendar.MILLISECOND)) + "." + StringUtils.split(uploadFile.getOriginalFilename(), ".")[1];
	            
	            String fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		        if("LOCAL".equals(serverSetting)){
		        	fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		    	}else if("DEV".equals(serverSetting)){
		    		fullFileName2 = filePath+fileType+"\\"+folderNm+"\\"+folder+"\\"+fileName;
		    	}else if("REAL".equals(serverSetting)){
		    		fullFileName2 = filePath+fileType+"/"+folderNm+"/"+folder+"/"+fileName;
		    	}	            
	            
	            File file = new File(fullFileName2);
	            uploadFile.transferTo(file);
	            resultFileNm =  "/"+folderNm+"/"+folder+"/"+fileName;
	            
	            ftpUtils.upload(fullFileName2, fileType+"/"+folderNm+"/"+folder+"/", fileName);
	        }
    	}catch (Exception e) {
    		e.printStackTrace();
    		resultCode = "1";
		}
        Map resultMap = new HashMap();
        resultMap.put("link", uploadImage+resultFileNm);
    	
    	ModelAndView modelAndView = new ModelAndView("jsonView",resultMap);    	
    	return modelAndView;
    }    
}
