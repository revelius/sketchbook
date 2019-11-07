package com.giftiel.shop.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class FtpUtils {
	@Value("${upload.ftp.url}")
	private String url;
	@Value("${upload.ftp.id}")
	private String id;	
	@Value("${upload.ftp.pwd}")
	private String pwd;	
	@Value("${upload.ftp.port}")
	private Integer port;	
	
	@Value("${local.upload.path}")
	private String localPath;	
	
	 public void upload(String localFilePath, String remoteFilePath, String fileName) throws Exception {
		  
		  FTPClient ftp = null; // FTP Client 객체
		  FileInputStream fis = null; // File Input Stream
		  File uploadfile = new File(localFilePath); // File 객체
		  
		  int result = -1;

		  
		  try{          
		      ftp = new FTPClient(); // FTP Client 객체 생성
		      ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
		      ftp.connect(url, port); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
		      ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
		      ftp.enterLocalPassiveMode(); // Passive Mode 접속일때 
		      for (int i = 0; i < remoteFilePath.split("/").length; i++) {
		    	  ftp.makeDirectory(remoteFilePath.split("/")[i]);
		    	  ftp.changeWorkingDirectory(remoteFilePath.split("/")[i]); // 작업 디렉토리 변경
		      }
		      
		      
		      ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
		      
		      try{
		          fis = new FileInputStream(uploadfile); // 업로드할 File 생성
		          boolean isSuccess = ftp.storeFile(fileName, fis); // File 업로드
		          
		          if (isSuccess){
				     result = 1; // 성공     
				  }
				  else{
				     throw new Exception();
				  }
		      } catch(IOException ex){
		          System.out.println("IO Exception : " + ex.getMessage());
		      }finally{
		          if (fis != null){
		              try{
		                  fis.close(); // Stream 닫기
		                  //return result;
		                  
		              }
		              catch(IOException ex){
		                  System.out.println("IO Exception : " + ex.getMessage());
		              }
		          }
		      }
		      ftp.logout(); // FTP Log Out
		  }catch(IOException e){
		      System.out.println("IO:"+e.getMessage());
		  }finally{
		      if (ftp != null && ftp.isConnected()){
		          try{
		              ftp.disconnect(); // 접속 끊기
		              //return result;
		          }
		          catch (IOException e){
		              System.out.println("IO Exception : " + e.getMessage());
		          }
		      }
		  }
		  //return result;
		 }
	 
	 public void download(String localFilePath, String remoteFilePath) throws Exception {
		  
		  FTPClient ftp = null; // FTP Client 객체
		  FileInputStream fis = null; // File Input Stream
		  
		  
		  try{          
		      ftp = new FTPClient(); // FTP Client 객체 생성
		      ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
		      ftp.connect(url, port); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
		      ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
		      ftp.enterLocalPassiveMode(); // Passive Mode 접속일때 
		      ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
		      
		      
		      ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
		      
		      
//		      String[] ftpFiles = ftp.listNames();
//		      File getFile;
//		      FileOutputStream outputstream;
		      
		      for (int i = 0; i < ftp.listFiles().length; i++) {
//		    	  getFile = new File(localFilePath + ftp.listFiles()[i].getName());
//		    	  outputstream = new FileOutputStream(getFile);
//		    	  ftp.retrieveFile(remoteFilePath+ftp.listFiles()[i].getName(),outputstream);
//		    	  
//		    	  outputstream.close();
		    	  
		    	  if(ftp.listFiles()[i].isFile()){
//		    		  System.out.println(i + "=file====" + remoteFilePath+ftp.listFiles()[i].getName() + "    fileSize====" + ftp.listFiles()[i].getSize());
		    	  }else{
		    		  String pathName = ftp.listFiles()[i].getName()+"/";
		    		  ftp.changeWorkingDirectory(ftp.listFiles()[i].getName()); // 작업 디렉토리 변경
		    		  
		    		  for (int j = 0; j < ftp.listFiles().length; j++) {
				    	  if(ftp.listFiles()[j].isFile()){
//				    		  System.out.println(j + "=file====" + remoteFilePath+ftp.listFiles()[i].getName() + "    fileSize====" + ftp.listFiles()[j].getSize());
				    	  }else{
				    		  String pathName2 = ftp.listFiles()[j].getName()+"/";
				    		  ftp.changeWorkingDirectory(ftp.listFiles()[j].getName()); // 작업 디렉토리 변경
				    		  
				    		  for (int k = 0; k < ftp.listFiles().length; k++) {
//				    			  System.out.println(k + "=file====" + remoteFilePath+pathName+pathName2+ftp.listFiles()[k].getName() + "    fileSize====" + ftp.listFiles()[k].getSize());
				    		  }
				    		  ftp.changeWorkingDirectory("../"); // 작업 디렉토리 변경
				    	  }
		    		  }
		    		  ftp.changeWorkingDirectory("../"); // 작업 디렉토리 변경
		    	  }
		    	  
		      }
		      
		      ftp.logout(); // FTP Log Out
		  }catch(IOException e){
		      System.out.println("IO:"+e.getMessage());
		  }finally{
		      if (ftp != null && ftp.isConnected()){
		          try{
		              ftp.disconnect(); // 접속 끊기
		          }
		          catch (IOException e){
		              System.out.println("IO Exception : " + e.getMessage());
		          }
		      }
		  }
		 }	 
}
