package com.giftiel.shop.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.SiteSetting;

@Repository
public class SettingDao {
	protected Logger log = LoggerFactory.getLogger(SettingDao.class);

	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	/**
	 * 상점환경설정 저장
	 **/
	public int storeSettingSave(Setting bean) {
		int successCnt = sqlSession.update("setting.storeSettingSave", bean);
		return successCnt;
	}

	/**
	 * 사이트 설정  저장
	 **/
	public int siteSettingReg(SiteSetting siteSetting) {
		int result = sqlSession.update("setting.siteSettingReg", siteSetting);
		return result;
	}

	public int siteSettingDel(SiteSetting siteSetting){
		int result = sqlSession.update("setting.siteSettingDel", siteSetting);
		return result;
	}


//
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingSave1(Setting bean) {
//		int successCnt = sqlSession.update("setting.siteSettingSave1", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingInsert1(Setting bean) {
//		int successCnt = sqlSession.insert("setting.siteSettingInsert1", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingInsert2(Setting bean) {
//		int successCnt = sqlSession.insert("setting.siteSettingInsert2", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingInsert3(Setting bean) {
//		int successCnt = sqlSession.insert("setting.siteSettingInsert3", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingInsert4(Setting bean) {
//		int successCnt = sqlSession.insert("setting.siteSettingInsert4", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingInsert5(Setting bean) {
//		int successCnt = sqlSession.insert("setting.siteSettingInsert5", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingSave2(Setting bean) {
//		int successCnt = sqlSession.update("setting.siteSettingSave2", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingSave3(Setting bean) {
//		int successCnt = sqlSession.update("setting.siteSettingSave3", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingSave4(Setting bean) {
//		int successCnt = sqlSession.update("setting.siteSettingSave4", bean);
//		return successCnt;
//	}
//
//	/**
//	 * 사이트 설정  저장
//	 **/
//	public int siteSettingSave5(Setting bean) {
//		int successCnt = sqlSession.update("setting.siteSettingSave5", bean);
//		return successCnt;
//	}

	/**
	 * 배송 설정  저장
	 **/
	public int deliverySettingSave(Setting bean) {
		int successCnt = sqlSession.update("setting.deliverySettingSave", bean);
		return successCnt;
	}

	/**
	 * 배송 설정  저장
	 **/
	public int deliverySettingInsert(Setting bean) {
		int successCnt = sqlSession.insert("setting.deliverySettingInsert", bean);
		return successCnt;
	}

	/**
	 * 상점환경설정
	 **/
	public List<Object> selectSuperAdmin() {
		List<Object> list = new ArrayList<Object>();
		try {
			list = sqlSession.selectList("setting.selectSuperAdmin");
		} catch (Exception e) {
			log.error("상점 환경설정 리스트 오류",e);
		}
		return list;
	}

	/**
	 * 상점환경설정
	 **/
	public List<Site> siteSettingList(Setting setting) {
		List<Site> list = sqlSession.selectList("setting.siteSettingList", setting);
		return list;
	}

	/**
	 * 상점환경설정
	 **/
	public Setting memberLevelList(Setting bean) {
		Setting list = sqlSession.selectOne("setting.memberLevelList", bean);
		return list;
	}

	/**
	 * 상점환경설정
	 **/
	public List<Object> memberGrdList(Setting bean) {
		List<Object> list = sqlSession.selectList("setting.memberGrdList", bean);
		return list;
	}

	/**
	 * 배송설정
	 **/
	public Setting deliverySettingList() {
		Setting list = sqlSession.selectOne("setting.deliverySettingList");
		return list;
	}

	/**
	 * 회원 등급관리 목록
	 **/
	public List<Object> memberSettingList() {
		List<Object> list = sqlSession.selectList("setting.memberSettingList");
		return list;
	}

	/**
	 * 회원 등급관리 수정하기
	 **/
	public int memberGrdUpdate(Setting bean) {
		int val = sqlSession.update("setting.memberGrdUpdate",bean);
		return val;
	}

	/**
	 * 회원 등급관리 등록하기
	 **/
	public int memberGrdInsert(Setting bean) {
		int val = sqlSession.insert("setting.memberGrdInsert",bean);
		return val;
	}

	/**
	 * 회원 등급관리 삭제하기
	 **/
	public int memberGrdDelete(Setting bean) {
		int val = sqlSession.delete("setting.memberGrdDelete",bean);
		return val;
	}

	/**
	 * 회원 등급관리 목록
	 **/
	public Setting pointSettingList() {
		Setting list = sqlSession.selectOne("setting.pointSettingList");
		return list;
	}

	/**
	 * 포인트 설정 등록
	 **/
	public int pointSettingInsert(Setting bean) {
		int val = sqlSession.insert("setting.pointSettingInsert",bean);
		return val;
	}

	/**
	 * 포인트 설정 수정
	 **/
	public int pointSettingSave(Setting bean) {
		int val = sqlSession.update("setting.pointSettingSave",bean);
		return val;
	}

	/**
	 * 상점운영정책 브랜드 가져오기
	 **/
	public List<Setting> storeManageList(Setting bean) {
		List<Setting> list = sqlSession.selectList("setting.storeManageList",bean);
		return list;
	}

	/**
	 * 상점운영정책 단건 가져오기
	 **/
	public Setting storeManageSelect(Setting bean) {
		Setting list = sqlSession.selectOne("setting.storeManageSelect",bean);
		return list;
	}


	/**
	 * 포인트 설정 등록
	 **/
	public int storeMngInsert(Setting bean) {
		int val = sqlSession.insert("setting.storeMngInsert",bean);
		return val;
	}

	/**
	 * 포인트 설정 수정
	 **/
	public int storeMngSave(Setting bean) {
		int val = sqlSession.update("setting.storeMngSave",bean);
		return val;
	}
}