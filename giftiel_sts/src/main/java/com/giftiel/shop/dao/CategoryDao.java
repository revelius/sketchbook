package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.CateSeason;
import com.giftiel.shop.dto.Category;
import com.giftiel.shop.dto.CategoryForm;
import com.giftiel.shop.dto.CategoryNew;
import com.giftiel.shop.dto.CategoryNewGoods;
import com.giftiel.shop.dto.Code;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.UbiCode;

/**
 * 회원관련 업무 수행
 * @author kwonYj
 *
 */
@Repository
public class CategoryDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	public List<Category> listCategory(String gubun) {
	    List<Category> result = sqlSession.selectList("category.listCategory", gubun);
	    return result;
	}
	
	
	/**
	 * 카테고리에 상품이 존재하는것만 노출
	 * @param gubun
	 * @return
	 */
	@Cacheable(value="snbShop", key="{#searchForm.gubun, #searchForm.seasonCode, #searchForm.category1Code, #searchForm.sex, #searchForm.curSeason, #searchForm.siteNo, #searchForm.brand}")
	public List<Category> listCategoryGdsCnt(SearchForm searchForm) {
	    List<Category> result = sqlSession.selectList("category.listCategoryGdsCnt", searchForm);
	    return result;
	}		
	
	//@Cacheable(value="snbShop", key="{#searchForm.gubun, #searchForm.seasonCode, #searchForm.category1Code, #searchForm.sex, #searchForm.curSeason, #searchForm.siteNo, #searchForm.brand}")
	public List<Category> listBrandGdsCnt(SearchForm searchForm) {
	    List<Category> result = sqlSession.selectList("category.listBrandGdsCnt", searchForm);
	    return result;
	}
	
	public CateSeason getSeasonCategory(String seasonGubunCode, int siteNo) {
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("seasonGubunCode", seasonGubunCode);
		hm.put("siteNo", siteNo);
		CateSeason result = sqlSession.selectOne("category.getSeasonCategory",hm);
		if(result==null){
			CateSeason cs = new CateSeason();
			cs.setSiteNo(siteNo);
			cs.setSeasonGubun(seasonGubunCode);
			result=cs;
		}
		
		return result;
	}
	
	
	public int setSeasonCategory(CateSeason cateSeason) {
	    int result = sqlSession.insert("category.setSeasonCategory", cateSeason);
	    return result;
	} 
	
	
	
	/**
	 * ubi 카테고리 가져오기
	 * @return
	 */
	public List<UbiCode> getUbiCategory(CategoryForm categoryForm){
		List<UbiCode> result =  sqlSession.selectList("category.getUbiCategory",categoryForm);
		return result;
	}
	
	
	/**
	 * ubi 카테고리별 갯수 가져오기
	 * @return
	 */
	public List<HashMap<String,String>> getUbiCategoryTot(CategoryForm categoryForm){
		List<HashMap<String,String>> result =  sqlSession.selectList("category.getUbiCategoryTot", categoryForm);
		return result;
	}
	
	
	/**
	 * 설정 카테고리 정보 가져오기
	 * @param categoryForm
	 * @return
	 */
	public HashMap<String,String> getCateDepth(CategoryForm categoryForm){
		HashMap<String,String> result = sqlSession.selectOne("category.getCateDepth",categoryForm);
		return result;
	}
	
	
	/**
	 * worksout 현시즌 default
	 * @param categoryForm
	 * @return
	 */
	public HashMap<String,String> getdefaultSeason(CategoryForm categoryForm){
		HashMap<String,String> result = sqlSession.selectOne("category.getdefaultSeason", categoryForm);
		return result;
	}
	
	/**
	 * 카테고리 설정정보 insert
	 * @param categoryForm
	 * @return
	 */
	public int setCateDepth(CategoryForm categoryForm){
		int result = sqlSession.insert("category.setCateDepth", categoryForm);
	    return result;
	}
	
	
	
	/**
	 * 등록시즌 정보 리스트
	 * @param categoryForm
	 * @return
	 */
	public List<HashMap<String,String>> getSeasonList(CategoryForm categoryForm){
		List<HashMap<String,String>> result = sqlSession.selectList("category.getSeasonList", categoryForm);
		return result;
	}
	
	
	
	
	/**
	 * 카테고리 저장
	 * @param gubun
	 * @return
	 */
	public int saveCate(CategoryForm categoryForm) {
		int result = sqlSession.update("category.saveCate", categoryForm);
	    return result;
	}
	
	
	/**
	 * 브랜드 저장
	 * @param gubun
	 * @return
	 */
	public int saveBrand(CategoryForm categoryForm) {
		int result = sqlSession.update("category.saveBrand", categoryForm);
		if(categoryForm.getBrandCd2() != null) {
			result = sqlSession.update("category.saveBrand2", categoryForm);
		}
		return result;
	}
	
	
	
	/**
	 * 브랜드 설정값 가져오기
	 * @param categoryForm
	 * @return
	 */
	public HashMap<String,String> getBrand(CategoryForm categoryForm){
		HashMap<String,String> result = sqlSession.selectOne("category.getBrand", categoryForm);
		return result;
	}
	
	
	/**
	 * brand 저장 row추가
	 * @param gubun
	 * @return
	 */
	public int setBrandCate(CategoryForm categoryForm) {
		int result = sqlSession.insert("category.setBrandCate", categoryForm);
	    return result;
	}

	public int setBrandCate2(CategoryForm categoryForm) {
		int result = sqlSession.insert("category.setBrandCate2", categoryForm);
	    return result;
	}	
	
	/**
	 * 설정한 브랜드 가져오기
	 * @param supCdNo
	 * @return
	 */
	public List<Code> listCd(SearchForm searchForm) {
	    List<Code> result = sqlSession.selectList("category.listCd", searchForm);
	    return result;
	}
	
	public List<Code> listCdAll(SearchForm searchForm) {
	    List<Code> result = sqlSession.selectList("category.listCdAll", searchForm);
	    return result;
	}
	
	
	/**
	 * 시즌시퀀스 가져오기
	 * @param hm
	 * @return
	 */
	public int getSeasonSeq(HashMap<String,Object> hm) {
		int result = sqlSession.selectOne("category.getSeasonSeq", hm);
	    return result;
	}
	
	
	/**
	 * NEW ARRIVAL명 수정
	 * @param categoryForm
	 * @return
	 */
	public int updateNa(CategoryForm categoryForm) {
		int result = sqlSession.update("category.updateNa", categoryForm);
	    return result;
	}
	
	
	/**
	 * 설정한 브랜드 가져오기
	 * @param supCdNo
	 * @return
	 */
	public List<Code> listBrand(SearchForm searchForm) {
	    List<Code> result = sqlSession.selectList("category.listBrand", searchForm);
	    return result;
	}
	
	public int insertCategoryNew(CategoryNew categoryNew) {
	    int result = sqlSession.insert("categoryNew.insertCategoryNew", categoryNew);
	    return result;
	}
	
	public int insertCategoryNewGds(CategoryNewGoods categoryNewGoods) {
	    int result = sqlSession.insert("categoryNew.insertCategoryNewGds", categoryNewGoods);
	    return result;
	}
	
	public String getCategoryNewId(CategoryNew categoryNew) {
		String result = sqlSession.selectOne("categoryNew.getCategoryNewId", categoryNew);
	    return result;
	}
	
	public int deleteCategoryNew(String cateNo) {
	    int result = sqlSession.delete("categoryNew.deleteCategoryNew", cateNo);
	    return result;
	}
	
	public int deleteCategoryNewGds(String cateNo) {
	    int result = sqlSession.delete("categoryNew.deleteCategoryNewGds", cateNo);
	    return result;
	}	
}