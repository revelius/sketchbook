package com.giftiel.shop.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.UtilsDao;
import com.giftiel.shop.dto.Table;

@Service
@Transactional
public class UtilsService {
	
	@Autowired
	private UtilsDao utilsDao;
 
	public List<Table> selectTableList() {
		List<Table> table = utilsDao.selectTableList();
		return table;
	}
	
	public List<Table> selectColumnList(Table table) {
		List<Table> result = utilsDao.selectColumnList(table);
		return result;
	}
	
	public void googleCdnImgSend(String source) throws IOException {
		
		String path="Z:/upload/image";
		
		String mainPath = "";
		if(StringUtils.isNotEmpty(source)){
			path = source;
		}
		
		File dirFile=new File(path);
		
//		System.out.println(path);
		File []fileList=dirFile.listFiles();
		for(File tempFile : fileList) {
		  if(tempFile.isFile()) {
		    String tempPath=tempFile.getParent();
		    String tempFileName=tempFile.getName();
		    
		    String pathName = tempPath + "\\" + tempFileName;
		    String saveName = pathName.substring(pathName.indexOf(mainPath)+15, pathName.length());
		    
		    //System.out.println("Path="+pathName.substring(pathName.indexOf(mainPath), pathName.length()));
		    
		    
		    
		    File checkFile = new File("C:\\Users\\Kwon Yong-Jae\\Google 드라이브\\image\\"+saveName.replace("\\", "_"));
		    
		    if(checkFile.isFile()){
		    	
		    }else{
		    	System.out.println("파일없음 : C:\\Users\\Kwon Yong-Jae\\Google 드라이브\\image\\"+saveName.replace("\\", "_"));
		    	fileCopy(tempPath + "\\" + tempFileName,"C:\\Users\\Kwon Yong-Jae\\Google 드라이브\\image\\"+saveName.replace("\\", "_"));
		    }
		    
		    
		  }else if(tempFile.isDirectory()) {
			  googleCdnImgSend(tempFile.getCanonicalPath().toString()); 
		  }
		}		
	}

	public int googleCdnImgSendUpdate() {
		return utilsDao.googleCdnImgSend();	
	}
	
	
	public void worksoutRealPutClass(String source) throws IOException {
		String path="D:/workData_Zionid/20150319_worksout/workspace/worksout/target/classes";
		
		String mainPath = "";
		if(StringUtils.isNotEmpty(source)){
			path = source;
		}
		
		File dirFile=new File(path);
		
		File []fileList=dirFile.listFiles();
		for(File tempFile : fileList) {
		  if(tempFile.isFile()) {
		    String tempPath=tempFile.getParent();
		    String tempFileName=tempFile.getName();
		    
		    String pathName = tempPath + "\\" + tempFileName;
		    String saveName = pathName.substring(pathName.indexOf(mainPath)+19, pathName.length());
		    
		    //test
		    File checkFile = new File("Y:\\Tomcat\\ROOT\\WEB-INF\\classes\\"+tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\target\\classes", ""));
		    //real
		    //File checkFile = new File("X:\\WEB-INF\\classes\\"+tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\target\\classes", ""));
		    if(checkFile.isFile()){
		    	if(tempFile.length() != checkFile.length()){
			    	System.out.println("원본위치 :" + tempFile.getPath() + "      , 복사위치 : " + checkFile.getPath());
			    	System.out.println("원본용량 :" + tempFile.length() + "      , 복사용량 : " + checkFile.length());
			    	fileCopy(tempFile.getPath(),checkFile.getPath());
		    	}
		    }else{
		    	System.out.println("파일없음 :" + tempFile.getPath() + "      , 복사될 위치 : " + checkFile.getPath());
		    	fileCopy(tempFile.getPath(),checkFile.getPath());
		    }
		    
		    
		  }else if(tempFile.isDirectory()) {
			  worksoutRealPutClass(tempFile.getCanonicalPath().toString()); 
		  }
		}		
	}
	
	public void worksoutRealPutWebFiles(String source) throws IOException {
		String path="D:/workData_Zionid/20150319_worksout/workspace/worksout/src/main/webapp";
		
		String mainPath = "";
		if(StringUtils.isNotEmpty(source)){
			path = source;
		}
		
		File dirFile=new File(path);
		
		File []fileList=dirFile.listFiles();
		for(File tempFile : fileList) {
		  if(tempFile.isFile()) {
		    
		    String checkPath = StringUtils.substring(tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\src\\main\\webapp\\", ""), 0, tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\src\\main\\webapp\\", "").indexOf("\\"));
		    
		    if(!"WEB-INF".equals(checkPath)){
			    //test
			    File checkFile = new File("Y:\\Tomcat\\ROOT\\"+tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\src\\main\\webapp", ""));
			    //real
			    //File checkFile = new File("X:\\"+tempFile.getPath().replace("D:\\workData_Zionid\\20150319_worksout\\workspace\\worksout\\src\\main\\webapp", ""));
			    if(checkFile.isFile()){
			    	if(tempFile.length() != checkFile.length()){
				    	System.out.println("원본위치 :" + tempFile.getPath() + "      , 복사위치 : " + checkFile.getPath());
				    	System.out.println("원본용량 :" + tempFile.length() + "      , 복사용량 : " + checkFile.length());
				    	fileCopy(tempFile.getPath(),checkFile.getPath());
			    	}
			    }else{
			    	System.out.println("파일없음 :" + tempFile.getPath() + "      , 복사될 위치 : " + checkFile.getPath());
			    	fileCopy(tempFile.getPath(),checkFile.getPath());
			    }
		    
		    }		    
		  }else if(tempFile.isDirectory()) {
			  worksoutRealPutWebFiles(tempFile.getCanonicalPath().toString()); 
		  }
		}		
	}	
	
	
	 public static void fileCopy(String inFileName, String outFileName) throws IOException {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);
		   
			FileChannel fcin =  fis.getChannel();
			FileChannel fcout = fos.getChannel();
			  
			long size = fcin.size();
			fcin.transferTo(0, size, fcout);
			  
			fcout.close();
			fcin.close();
			  
			fis.close();
			fos.close();
	 }	
}