package com.giftiel.shop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dao.CategoryDao;
import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dto.CateSeason;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.CategoryForm;
import com.giftiel.shop.dto.CategoryNew;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.SeasonForm;
import com.giftiel.shop.dto.Site;
import com.giftiel.shop.dto.UbiCode;

@Service
@Transactional
public class CategoryService {
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private CommonDao commonDao;	
	
	/**
	 * 구분을 이용해 카테고리 리스트를 가져온다.
	 * @param gubun
	 * @return
	 */
	public List<Category> listCategory(String gubun) {
	    List<Category> result = categoryDao.listCategory(gubun);
	    return result;
	}
	
	/**
	 * 상품이 노출 되고있는 카테고리만 노출
	 * @param gubun
	 * @return
	 */
	public List<Category> listCategoryGdsCnt(SearchForm searchForm) {
	    List<Category> result = categoryDao.listCategoryGdsCnt(searchForm);
	    return result;
	}		
	
	/**
	 * 시즌 카테고리 설정 가져오기
	 * @return
	 */
	public List<SeasonForm> getSeasonCategory(List<Site> siteList){
		List<SeasonForm> result = new ArrayList<SeasonForm>();
		
		for(Site site:siteList){
			SeasonForm seasonForm = new SeasonForm();
			
			
			CateSeason cate1Season = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_1,site.getSiteNo());
			CateSeason cate2Season = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_2,site.getSiteNo());
			CateSeason cateOutlet = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_OUTLET,site.getSiteNo());
			
			
			seasonForm.setSiteNo(site.getSiteNo());
			seasonForm.setSiteNm(site.getSiteNm());
			seasonForm.setCate1Season(cate1Season);
			seasonForm.setCate2Season(cate2Season);
			seasonForm.setCateOutlet(cateOutlet);
			result.add(seasonForm);
		}
		
		
		return result;
	}
	
	
	
	/**
	 * 시즌 카테고리 설정 가져오기(site개별)
	 * @return
	 */
	public SeasonForm getSeasonCategory(int siteNo){
		
			SeasonForm seasonForm = new SeasonForm();
			
			
			CateSeason cate1Season = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_1,siteNo);
			CateSeason cate2Season = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_2,siteNo);
			CateSeason cateOutlet  = categoryDao.getSeasonCategory(Constants.CATE_SEASON_GUBUN_CODE_OUTLET,siteNo);
			
			
			seasonForm.setSiteNo(siteNo);
			seasonForm.setCate1Season(cate1Season);
			seasonForm.setCate2Season(cate2Season);
			seasonForm.setCateOutlet(cateOutlet);
		
		
		return seasonForm;
	}
	
	
	
	
	
	/**
	 * 카테고리 시즌 저장
	 * @param categoryForm
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int saveSeason(CategoryForm categoryForm, int userNo){
		int result = 0;
		List<SeasonForm> seasonFormList = categoryForm.getSeasonFormList();
		for(SeasonForm seasonForm:seasonFormList){
			seasonForm.getCate1Season().setUpdrNo(userNo);
			seasonForm.getCate2Season().setUpdrNo(userNo);
			seasonForm.getCateOutlet().setUpdrNo(userNo);
			seasonForm.getCateOutlet().setSeasonCd("OUTLET");
			seasonForm.getCateOutlet().setSeasonCdDisp("OUTLET");
			seasonForm.getCateOutlet().setDispYn("Y");
			seasonForm.getCateOutlet().setUseYn("Y");
			result = categoryDao.setSeasonCategory(seasonForm.getCate1Season());
			if(result!=1) return result;
			result = categoryDao.setSeasonCategory(seasonForm.getCate2Season());
			if(result!=1) return result;
			result = categoryDao.setSeasonCategory(seasonForm.getCateOutlet());
			if(result!=1) return result;
			
		}
		return result;
	}
	
	
	
	/**
	 * ubi 카테고리 가져오기
	 * @return
	 */
	public List<UbiCode> getUbiCategory(CategoryForm categoryForm){
		List<UbiCode> result =  categoryDao.getUbiCategory(categoryForm);
		
		List<HashMap<String,String>> hm = categoryDao.getUbiCategoryTot(categoryForm);
		
		int size = result.size();
		int tot  = 0;
		
		for(int cnt = 0 ; cnt < size; cnt++) {
			tot += Integer.parseInt((String.valueOf(hm.get(cnt).get("GRPTOT"))));
		}
		for(int cnt = 0 ; cnt < size; cnt++) {
			result.get(cnt).setGrpTot(String.valueOf(hm.get(cnt).get("GRPTOT")));
			result.get(cnt).setTot(tot);
		}
		
		
		
		return result;
	}
	
	
	/**
	 * 카테고리 설정값 가져오기
	 * @param categoryForm
	 * @return
	 */
	public HashMap<String,String> getCateDepth(CategoryForm categoryForm){
		
		if(categoryForm.getSeasonSeq()==null || categoryForm.getSeasonSeq().equals("")){//시즌seq가 없으면 초기값 worksout 현시즌으로 세팅
			HashMap<String,String> tempHm = categoryDao.getdefaultSeason(categoryForm);
			categoryForm.setSiteNo(Integer.valueOf(String.valueOf(tempHm.get("SITE_NO"))));
			categoryForm.setSeasonSeq(String.valueOf(tempHm.get("SEASON_SEQ")));
		}
		
		HashMap<String,String> result = categoryDao.getCateDepth(categoryForm);
		
		//카테고리 설정 row가 없으면 생성해줌
		if(result == null){
			categoryDao.setCateDepth(categoryForm);
			result = categoryDao.getCateDepth(categoryForm);
		}
		
		
		return result;
	}
	
	
	
	
	/**
	 * 등록시즌 정보 리스트
	 * @param categoryForm
	 * @return
	 */
	public List<HashMap<String,String>> getSeasonList(CategoryForm categoryForm){
		List<HashMap<String,String>> result = categoryDao.getSeasonList(categoryForm);
		return result;
	}
	
	
	/**
	 * 카테고리 저장
	 * @param gubun
	 * @return
	 */
	public int saveCate(CategoryForm categoryForm) {
		int result = categoryDao.saveCate(categoryForm);
	    return result;
	}
	
	/**
	 * 브랜드 저장
	 * @param gubun
	 * @return
	 */
	public int saveBrand(CategoryForm categoryForm) {
		int result = categoryDao.saveBrand(categoryForm);
	    return result;
	}
	
	
	
	
	/**
	 * 브랜드 설정값 가져오기
	 * @param categoryForm
	 * @return
	 */
	public String getBrand(CategoryForm categoryForm){
		HashMap<String,String> hm = categoryDao.getBrand(categoryForm);
		
		
		//카테고리 설정 row가 없으면 생성해줌
		if(hm == null){
			categoryDao.setBrandCate(categoryForm);
		}
		String result = categoryDao.getBrand(categoryForm).get("CATE_DEPTH_2");
		
		return result;
	}
	
	public String getBrand2(CategoryForm categoryForm){
		HashMap<String,String> hm = categoryDao.getBrand(categoryForm);
		
		
		//카테고리 설정 row가 없으면 생성해줌
		if(hm == null){
			categoryDao.setBrandCate2(categoryForm);
		}
		String result = categoryDao.getBrand(categoryForm).get("CATE_DEPTH_2");
		
		return result;
	}	
	
	/**
	 * 설정한 브랜드 가져오기
	 * @param supCdNo
	 * @return
	 */
	public List<Code> listCd(SearchForm searchForm) {
	    List<Code> result = categoryDao.listCd(searchForm);
	    return result;
	}
	
	public List<Code> listCdAll(SearchForm searchForm) {
	    List<Code> result = categoryDao.listCdAll(searchForm);
	    return result;
	}	
	
	public List<Code> listBrand(SearchForm searchForm) {
	    List<Code> result = categoryDao.listBrand(searchForm);
	    return result;
	}	
	
	/**
	 * 시즌시퀀스 가져오기
	 * @param hm
	 * @return
	 */
	public int getSeasonSeq(HashMap<String,Object> hm) {
		int result = categoryDao.getSeasonSeq(hm);
	    return result;
	}

	
	public List<Category> listBrandGdsCnt(SearchForm searchForm) {
	    List<Category> result = categoryDao.listBrandGdsCnt(searchForm);
	    return result;
	}		
	
	/**
	 * 
	 * @param searchForm
	 * @return
	 */
	public String brandCategoryInit() {
		String result = "";

		CategoryForm categoryForm = new CategoryForm();
		categoryForm.setSiteNo(10001);
		List<HashMap<String,String>> seasonList = categoryDao.getSeasonList(categoryForm);
		
		String curSeasonCode = "";
		for (int i = 0; i < seasonList.size(); i++) {
			if(!seasonList.get(i).get("SEASON_CD").equals("OUTLET")){
				curSeasonCode = seasonList.get(i).get("SEASON_CD").toString();
			}
		}
		
		for (int i = 0; i < seasonList.size(); i++) {
			SearchForm searchForm = new SearchForm();
			searchForm.setSeasonCode(seasonList.get(i).get("SEASON_CD"));

			System.out.println("seasonCode========" + seasonList.get(i).get("SEASON_CD") + "====" + Integer.valueOf(String.valueOf(seasonList.get(i).get("SEASON_SEQ"))));
			
			
			categoryForm.setSeasonSeq(String.valueOf(seasonList.get(i).get("SEASON_SEQ")));
			HashMap<String,String> cateListOri = categoryDao.getCateDepth(categoryForm);

			String cateOri = cateListOri.get("BRAND");
			System.out.println("cateOri======"+seasonList.get(i).get("SEASON_CD")+"===" + cateOri);
			searchForm.setCurSeason(curSeasonCode);
			List<Category> cateList = categoryDao.listBrandGdsCnt(searchForm);
			for (int j = 0; j < cateList.size(); j++) {
				cateOri = cateOri.replaceAll(cateList.get(j).getCateNm()+",", "");
				cateOri = cateOri.replaceAll(","+cateList.get(j).getCateNm(), "");
			}
			
			System.out.println("cateAfter======"+seasonList.get(i).get("SEASON_CD")+"===" + cateOri);
			
			
			categoryForm.setBrandCd(cateOri);
			categoryDao.saveBrand(categoryForm);
			
		}
		
	    return result;
	}	
	
	
	/**
	 * NEW ARRIVAL명 수정
	 * @param categoryForm
	 * @return
	 */
	public int updateNa(CategoryForm categoryForm) {
		int result = categoryDao.updateNa(categoryForm);
	    return result;
	}
	
	public int insertCategoryNew(CategoryNew categoryNew) {
		int result = 0;
		
		
		String cateNo_ = categoryDao.getCategoryNewId(categoryNew);
		
		System.out.println("cateNo_============ " + cateNo_);
		
		if(cateNo_ != null) {
			categoryDao.deleteCategoryNewGds(cateNo_);
			categoryDao.deleteCategoryNew(cateNo_);
		}
		
		int cateNo = commonDao.createKey("SEQ_GD_CATE_NEW");
		categoryNew.setCateNo(cateNo);
		
		categoryDao.insertCategoryNew(categoryNew);
		
		for (int i = 0; i < categoryNew.getCategoryNewGoods().size(); i++) {
			categoryNew.getCategoryNewGoods().get(i).setCateNo(cateNo);
			categoryDao.insertCategoryNewGds(categoryNew.getCategoryNewGoods().get(i));
			result++;
		}
		
	    return result;
	}
	
}