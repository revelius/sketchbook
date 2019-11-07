package com.giftiel.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.SettingDao;
import com.giftiel.shop.dto.MainManage;
import com.giftiel.shop.dto.MainManageForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.SiteSetting;

@Service
@Transactional
public class SettingService {
	@Autowired
	private SettingDao settingDao;
 
	/**
	 * 상점 환경 설정 저장 
	 **/
	public int storeSettingSave(Setting bean) {
		
		int successCnt = settingDao.storeSettingSave(bean);
		return successCnt;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int siteSettingReg(Setting setting) throws Exception{
		int result = 0;

		List<SiteSetting> siteSetting = setting.getSiteSetting();
		for(SiteSetting site:siteSetting){
			result = settingDao.siteSettingDel(site);
			result = settingDao.siteSettingReg(site);
			if(result < 1) {
				throw new Exception();
			}
		}
		return result;
	}

	
//	public int siteSettingSave(SiteSetting siteSetting){
//		int result = settingDao.siteSettingSave(siteSetting);
//		return result;
//	}
//
//	public int siteSettingInsert(SiteSetting siteSetting){
//		int result = settingDao.siteSettingInsert(siteSetting);
//		return result;
//	}
	
	/**
	 * 사이트 설정 저장 
	 **/
//	public int siteSettingSave1(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingSave1(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingInsert1(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingInsert1(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingSave2(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingSave2(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingInsert2(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingInsert2(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingInsert3(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingInsert3(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingInsert4(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingInsert4(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingInsert5(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingInsert5(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingSave3(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingSave3(bean);
//		return successCnt;
//	}
//	
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingSave4(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingSave4(bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정 저장 
//	 **/
//	public int siteSettingSave5(Setting bean) {
//		
//		int successCnt = settingDao.siteSettingSave5(bean);
//		return successCnt;
//	}
	
	/**
	 * 배송 설정 업데이트 
	 **/
	public int deliverySettingSave(Setting bean) {
		
		int successCnt = settingDao.deliverySettingSave(bean);
		return successCnt;
	}
	
	/**
	 * 배송 설정 등록 
	 **/
	public int deliverySettingInsert(Setting bean) {
		
		int successCnt = settingDao.deliverySettingInsert(bean);
		return successCnt;
	}
	
	/**
	 * 상점 환경 설정  
	 **/
	public List<Object> selectSuperAdmin() {
		
		List<Object> list = settingDao.selectSuperAdmin();
		return list;
	}	
	
	/**
	 * 상점 환경 설정  
	 **/
	public List<Site> siteSettingList(Setting setting) {
		List<Site> list = settingDao.siteSettingList(setting);
		return list;
	}
	
	/**
	 * 회원등급관리 수정 
	 **/
	public Setting memberLevelList(Setting bean) {
		
		Setting list = settingDao.memberLevelList(bean);
		return list;
	}
	
	/**
	 * 회원등급관리 중복 체크 
	 **/
	public List<Object> memberGrdList(Setting bean) {
		
		List list = settingDao.memberGrdList(bean);
		return list;
	}
	
	/**
	 * 배송 설정  
	 **/
	public Setting deliverySettingList() {
		
		Setting list = settingDao.deliverySettingList();
		return list;
	}
	
	/**
	 * 회원 등급관리 목록 가져오기 
	 **/
	public List<Object> memberSettingList() {
		
		List<Object> list = settingDao.memberSettingList();
		return list;
	}
	/**
	 * 회원 등급관리 수정하기
	 **/
	public int memberGrdUpdate(Setting bean) {
		
		int val = settingDao.memberGrdUpdate(bean);
		return val;
	}
	
	/**
	 * 회원 등급관리 등록하기
	 **/
	public int memberGrdInsert(Setting bean) {
		
		int val = settingDao.memberGrdInsert(bean);
		return val;
	}
	
	/**
	 * 회원 등급관리 삭제하기
	 **/
	public int memberGrdDelete(Setting bean) {
		
		int val = settingDao.memberGrdDelete(bean);
		return val;
	}
	
	/**
	 * 포인트 설정 가져오기
	 **/
	public Setting pointSettingList() {
		
		Setting list = settingDao.pointSettingList();
		return list;
	}
	
	/**
	 * 포인트 설정 업데이트 
	 **/
	public int pointSettingSave(Setting bean) {
		
		int val = settingDao.pointSettingSave(bean);
		return val;
	}
	
	/**
	 * 포인트 설정 등록 
	 **/
	public int pointSettingInsert(Setting bean) {
		
		int val = settingDao.pointSettingInsert(bean);
		return val;
	}	
	
	/**
	 * 상점운영정책 목록 가져오기
	 **/
	public List<Setting> storeManageList(Setting bean) {
		
		List<Setting> list = settingDao.storeManageList(bean);
		return list;
	}
	
	/**
	 * 상점운영정책 단건 가져오기 
	 **/
	public Setting storeManageSelect(Setting bean) {
		
		Setting list = settingDao.storeManageSelect(bean);
		return list;
	}
	
	/**
	 * 상점운영정책 수정 
	 **/
	public int storeMngSave(Setting bean) {
		
		int val = settingDao.storeMngSave(bean);
		return val;
	}
	
	/**
	 * 상점운영정책 등록 
	 **/
	public int storeMngInsert(Setting bean) {
		
		int val = settingDao.storeMngInsert(bean);
		return val;
	}	
	
	
}