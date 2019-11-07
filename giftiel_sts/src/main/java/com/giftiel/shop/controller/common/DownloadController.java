package com.giftiel.shop.controller.common;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ImageObserver;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.ImageIcon;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;




import java.awt.Graphics;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;


@Controller
@RequestMapping("/fileDownload")
public class DownloadController {
//public class DownloadController implements ApplicationContextAware{
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
    
    
    /**
     * 파일 다운로드
     * @param fileName
     * @return
     * @throws Exception 
     */
	@RequestMapping(value = "/fileExport", method = RequestMethod.GET)
    public ModelAndView fileExport(
    		@RequestParam("fileName") String fileName,
    		@RequestParam(value="option",  required=false, defaultValue="nonExist") String option,
    		HttpServletRequest request, 
			HttpServletResponse response
    		) throws Exception{
    	
    	String filePath = "";
    	
    	if("LOCAL".equals(serverSetting)){
    		filePath = localPath;
    	}else if("DEV".equals(serverSetting)){
    		filePath = localPath;
    	}else if("REAL".equals(serverSetting)){
    		filePath = realPath;
    	}
    	
    	int width = 0; 
    	int height = 0;
    	
    	if(option.equals("2560") || option.equals("PC")){
    		width = 2560;
    		height = 1440;
    	}else if(option.equals("1920") || option.equals("MOBILE")){
    		width = 1920;
    		height = 1080;
    	}else if(option.equals("2048") || option.equals("TABLET")){
    		width = 2048;
    		height = 1536;
    	}else{
    		width = 2560;
    		height = 1440;
    	}
    	
    	
    	String fullPath = filePath  + "\\upload\\image" +fileName;
    	//String fullPath = fileName;
    	String[] splitFileName = fileName.split("/");
    	
    	File file = option.equals("nonExist")?new File(fullPath):resizeImg(request,fileName, width,height,fullPath,splitFileName[splitFileName.length-1]);
    	
        return new ModelAndView("downloadView", "downloadFile", file);
    }
 
    public static File resizeImg(HttpServletRequest request,String fileName, int width, int height,String fullPath,String outputFileName)throws Exception{
    	
		String realPath = request.getRealPath("/tempResizeImg");
    	//System.out.println("+++++++++++++++realPath :"+realPath);
		
		
		File tempFile = new File(realPath);
        if(!tempFile.isFile()){   
    		if(!tempFile.isDirectory()){
    			tempFile.mkdir();
    		}
    	}
        
        
    	
    	String imgResdFile = fullPath;
        String imgWriteFile = realPath+tempFile.separator+outputFileName;
        
        
        tempFile = new File(imgWriteFile);
    	
    	// img = ImageIO.read( new File(fName));
        FileInputStream fis = new FileInputStream(imgResdFile);
        byte[] data = new byte[fis.available()];
        System.out.println(fis.available());
        fis.read(data);
        fis.close();

        Image image = Toolkit.getDefaultToolkit().createImage(data);
        Image rtnImage = resizing(image, width, height);

        MediaTracker tracker = new MediaTracker(new java.awt.Frame());
        tracker.addImage(rtnImage, 0);
        tracker.waitForAll();

        BufferedImage bi = new BufferedImage(rtnImage.getWidth(null),
                     rtnImage.getHeight(null), BufferedImage.TYPE_INT_RGB);
        Graphics g = bi.getGraphics();
        g.drawImage(rtnImage, 0, 0, null);
        g.dispose();
        ByteArrayOutputStream bas = new ByteArrayOutputStream();
        ImageIO.write(bi, "jpeg", bas);
        byte[] writeData = bas.toByteArray();

        
        
        DataOutputStream dos = new DataOutputStream(
                     new BufferedOutputStream(new FileOutputStream(imgWriteFile)));
        dos.write(writeData);
        dos.close();
    	
        
    	
    	return tempFile;
    }
    
    
    
    public static Image resizing(Image soruce, int width, int height)
            throws Exception {
	     int newW = width;
	     int newH = height;
	
	     return soruce.getScaledInstance(newW, -1, Image.SCALE_SMOOTH);
	}
    
    /* 이미지 리사이징 테스트 메서드
    public static ImageIcon resizeImage(String fileName, int maxWidth, int maxHeight){
		String data = fileName;
		BufferedImage src, dest;
		ImageIcon icon;
		
		try{
			src = ImageIO.read(new File(data));
			
			int width = src.getWidth();
			int height = src.getHeight();
			
			if(width > maxWidth){
				float widthRatio = maxWidth/(float)width;
				width = (int)(width*widthRatio);
				height = (int)(height*widthRatio);
			}
			if(height > maxHeight){
				float heightRatio = maxHeight/(float)height;
				width = (int)(width*heightRatio);
				height = (int)(height*heightRatio);
			}
			
			dest = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = dest.createGraphics();
			AffineTransform at = AffineTransform.getScaleInstance((double) width / src.getWidth(), (double)height / src.getHeight());
			g.drawRenderedImage(src, at);
			
			icon = new ImageIcon(dest);
			return icon;
		}catch(Exception e){
			 System.out.println("This image can not be resized. Please check the path and type of file.");
	         return null;
		}
	}
    */
    
    /*
    Image originalImage = ImageIO.read(new File(fileName));
    Image resizeImage = originalImage.getScaledInstance( 1920, 1080, Image.SCALE_SMOOTH);
    BufferedImage newImage = new BufferedImage( 1920, 1080, BufferedImage.TYPE_INT_RGB );
    
    ImageObserver imgObserv = new ImageObserver() {
		
		@Override
		public boolean imageUpdate(Image img, int infoflags, int x, int y,
				int width, int height) {
			// TODO Auto-generated method stub
			return false;
		}
	};
    
    Graphics g = newImage.getGraphics();
    g.drawImage(resizeImage, 0, 0, imgObserv);
    g.dispose();
    
    File file = ImageIO.write(newImage, "jpg", new File("test.jpg"));
    */
	
	/*
	String imgResdFile = fileName;
    String imgWriteFile = "c:\\a1.jpg";
	
	// img = ImageIO.read( new File(fName));
    FileInputStream fis = new FileInputStream(imgResdFile);
    byte[] data = new byte[fis.available()];
    System.out.println(fis.available());
    fis.read(data);
    fis.close();

    Image image = Toolkit.getDefaultToolkit().createImage(data);
    Image rtnImage = resizing(image, 640, 480);

    MediaTracker tracker = new MediaTracker(new java.awt.Frame());
    tracker.addImage(rtnImage, 0);
    tracker.waitForAll();

    BufferedImage bi = new BufferedImage(rtnImage.getWidth(null),
                 rtnImage.getHeight(null), BufferedImage.TYPE_INT_RGB);
    Graphics g = bi.getGraphics();
    g.drawImage(rtnImage, 0, 0, null);
    g.dispose();
    ByteArrayOutputStream bas = new ByteArrayOutputStream();
    ImageIO.write(bi, "jpeg", bas);
    byte[] writeData = bas.toByteArray();

    
    DataOutputStream dos = new DataOutputStream(
                 new BufferedOutputStream(new FileOutputStream(imgWriteFile)));
    dos.write(writeData);
    dos.close();
	
    File file = new File(imgWriteFile);
	*/
    
    
     
}

