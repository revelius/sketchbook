package com.giftiel.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.CurrentGoodsColors;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.GoodsAddInfo;
import com.giftiel.shop.dto.GoodsAddInfoGrp;
import com.giftiel.shop.dto.GoodsImage;
import com.giftiel.shop.dto.GoodsSize;
import com.giftiel.shop.dto.GoodsTag;
import com.giftiel.shop.dto.GoodsView;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.SearchForm;

@Repository
public class GoodsDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	/**
	 * 상품 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoods(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoods", searchForm);
	    return result;
	}

	/**
	 * 상품 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListGoods(SearchForm searchForm) {
	    int result = sqlSession.selectOne("goods.totalListGoods", searchForm);
	    return result;
	}
	
	/**
	 * 상품 상세
	 * @param searchForm
	 * @return
	 */
	public Goods selectGoods(SearchForm searchForm) {
	    Goods result = sqlSession.selectOne("goods.selectGoods", searchForm);
	    return result;
	}
	
	
	/**
	 * 상품정보 유무 체크
	 * @param goods
	 * @return
	 */
	public int checkInsertGoods(String ubiGdsNo) {
	    int result = sqlSession.selectOne("goods.checkInsertGoods", ubiGdsNo);
		return result;
	}		
	
	/**
	 * 상품정보 insert
	 * @param goods
	 * @return
	 */
	public int insertGoods(Goods goods) {
	    int result = sqlSession.insert("goods.insertGoods", goods);
	    return result;
	}		
	
	/**
	 * 상품정보 update
	 * @param goods
	 * @return
	 */
	public int updateGoods(Goods goods) {
	    int result = sqlSession.update("goods.updateGoods", goods);
	    return result;
	}		
	
	public int updateGoodsArrvSort(Goods goods) {
	    int result = sqlSession.update("goods.updateGoodsArrvSort", goods);
	    return result;
	}		
	
	public int updateGoodsSort(Goods goods) {
	    int result = sqlSession.update("goods.updateGoodsSort", goods);
	    return result;
	}			

	public int updateGoodsSortCollabo(Goods goods) {
	    int result = sqlSession.update("goods.updateGoodsSortCollabo", goods);
	    return result;
	}
	
	/**
	 * 상품정보고시 그룹 리스트
	 * @param searchForm
	 * @return
	 */
	public List<GoodsAddInfoGrp> listAddInfoGrp(SearchForm searchForm) {
	    List<GoodsAddInfoGrp> result = sqlSession.selectList("goods.listAddInfoGrp", searchForm);
	    return result;
	}	
	
	/**
	 * 상품정보고시 상세
	 * @param searchForm
	 * @return
	 */
	public GoodsAddInfoGrp selectAddInfoGrp(SearchForm searchForm) {
		GoodsAddInfoGrp result = sqlSession.selectOne("goods.selectAddInfoGrp", searchForm);
	    return result;
	}	
	
	/**
	 * 상품정보고시그룹 INSERT
	 * @param goodsAddInfoGrp
	 * @return
	 */
	public int insertInfoGrp(GoodsAddInfoGrp goodsAddInfoGrp) {
	    int result = sqlSession.insert("goods.insertInfoGrp", goodsAddInfoGrp);
	    return result;
	}
	
	/**
	 * 상품정보고시그룹 UPDATE 
	 * @param goodsAddInfoGrp
	 * @return
	 */
	public int updateInfoGrp(GoodsAddInfoGrp goodsAddInfoGrp) {
	    int result = sqlSession.update("goods.updateInfoGrp", goodsAddInfoGrp);
	    return result;
	}
	
	/**
	 * 상품정보고시 INSERT
	 * @param goodsAddInfo
	 * @return
	 */
	public int insertInfo(GoodsAddInfo goodsAddInfo) {
	    int result = sqlSession.insert("goods.insertInfo", goodsAddInfo);
	    return result;
	}
	
	/**
	 * 상품정보고시 DELETE(INSERT 선행)
	 * @param gdsInfoNo
	 * @return
	 */
	public int deleteInfo(Integer gdsInfoNo) {
	    int result = sqlSession.delete("goods.deleteInfo", gdsInfoNo);
	    return result;
	}
	
	/**
	 * 상품태그 INSERT
	 * @param goodsAddInfo
	 * @return
	 */
	public int insertTag(GoodsTag goodsTag) {
	    int result = sqlSession.insert("goods.insertTag", goodsTag);
	    return result;
	}
	
	/**
	 * 상품태그 DELETE(INSERT 선행)
	 * @param gdsInfoNo
	 * @return
	 */
	public int deleteTag(String ubiGdsNo) {
	    int result = sqlSession.delete("goods.deleteTag", ubiGdsNo);
	    return result;
	}
	
	/**
	 * 상품이미지 INSERT
	 * @param goodsAddInfo
	 * @return
	 */
	public int insertGdsImg(GoodsImage goodsImage) {
	    int result = sqlSession.insert("goods.insertGdsImg", goodsImage);
	    return result;
	}
	
	/**
	 * 상품이미지 DELETE(INSERT 선행)
	 * @param gdsInfoNo
	 * @return
	 */
	public int deleteGdsImg(String ubiGdsNo) {
	    int result = sqlSession.delete("goods.deleteGdsImg", ubiGdsNo);
	    return result;
	}
	
	/**
	 * 상품 정렬순서 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoodsCategoryDisplay(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsCategoryDisplay", searchForm);
	    return result;
	}
	
	public List<Goods> listGoodsCategoryDisplayNew(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsCategoryDisplayNew", searchForm);
	    return result;
	}	
	
	
	public List<Goods> listGoodsCategoryDisplayBrand(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsCategoryDisplayBrand", searchForm);
	    return result;
	}
	
	public List<Goods> listGoodsCategoryDisplayThreeDepth(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsCategoryDisplayThreeDepth", searchForm);
	    return result;
	}	
	
	/**
	 * 상품 사이즈 차트 Insert
	 * @param goodsSize
	 * @return
	 */
	public int insertSize(GoodsSize goodsSize) {
	    int result = sqlSession.insert("goods.insertSize", goodsSize);
	    return result;
	}
	
	/**
	 * 상품 사이즈 차트 DELETE
	 * @param ubiGdsNo
	 * @return
	 */
	public int deleteSize(String ubiGdsNo) {
	    int result = sqlSession.delete("goods.deleteSize", ubiGdsNo);
	    return result;
	}
	
	/**
	 * FRONT 상품 리스트
	 * @param searchForm
	 * @return
	 */
//	@Cacheable(value="someCache", key="{#searchForm.oneDepth, #searchForm.twoDepth, #searchForm.threeDepth, #searchForm.brand, #searchForm.ubiGdsSize, #searchForm.sex, #searchForm.searchText, #searchForm.clbltnNm, #searchForm.siteNo, #searchForm.orderFlag, #searchForm.orderBy, #searchForm.newArrival}")
	public List<Goods> listGoodsFront(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsFront", searchForm);
	    return result;
	}
	
	public List<Goods> listGoodsFrontAjax(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsFront", searchForm);
	    return result;
	}

	public List<Goods> listGoodsFrontNew(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsFrontNew", searchForm);
	    return result;
	}
	
	/**
	 * FRONT 상품 카테고리 사이즈 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoodsSizeFront(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("goods.listGoodsSizeFront", searchForm);
	    return result;
	}
	
	/**
	 * 주문건에서 상품 사이즈 리스트 가지고 오기
	 */
	public List<Goods> listGoodsSize(){
		List<Goods> result = sqlSession.selectList("goods.listGoodsSize");
		return result;
	}
	

	/**
	 * FRONT 상품 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
//	@Cacheable(value="someCache2", key="{#searchForm.oneDepth, #searchForm.twoDepth, #searchForm.threeDepth, #searchForm.brand, #searchForm.ubiGdsSize, #searchForm.sex, #searchForm.searchText, #searchForm.clbltnNm, #searchForm.siteNo, #searchForm.orderFlag, #searchForm.orderBy, #searchForm.newArrival}")
	public int totalListGoodsFront(SearchForm searchForm) {
	    int result = sqlSession.selectOne("goods.totalListGoodsFront", searchForm);
	    return result;
	}
	
	public int totalListGoodsFrontAjax(SearchForm searchForm) {
	    int result = sqlSession.selectOne("goods.totalListGoodsFront", searchForm);
	    return result;
	}
	
	/**
	 * 카테고리 설정 new 상품 리스트 총갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListGoodsFrontNew(SearchForm searchForm) {
	    int result = sqlSession.selectOne("goods.totalListGoodsFrontNew", searchForm);
	    return result;
	}
	
	/**
	 * 상품 보유 사이즈 리스트
	 * @param UbiGdsNo
	 * @return
	 */
	public List<Goods> listCurGdsSize(String UbiGdsNo) {
	    List<Goods> result = sqlSession.selectList("goods.listCurGdsSize", UbiGdsNo);
	    return result;
	}
	
	/**
	 * 상품 보유 컬러
	 * @param searchForm
	 * @return
	 */
	public List<CurrentGoodsColors> listCurColors(SearchForm searchForm) {
	    List<CurrentGoodsColors> result = sqlSession.selectList("goods.listCurColors", searchForm);
	    return result;
	}	
	
	/**
	 * FRONT 상품 상세
	 * @param searchForm
	 * @return
	 */
	public Goods selectGoodsFront(SearchForm searchForm) {
	    Goods result = sqlSession.selectOne("goods.selectGoodsFront", searchForm);
	    return result;
	}

	/**
	 * FRONT 콜라보레이션 리스트
	 * @param searchForm
	 * @return
	 * */
	public List<IntgBoard> collaboList(SearchForm searchForm) {
		List<IntgBoard> collaboration = sqlSession.selectList("goods.collaboList", searchForm);
		return collaboration;
	}
	
	public int updateViewCount(String ubiGdsNo) {
	    int result = sqlSession.update("goods.updateViewCount", ubiGdsNo);
	    return result;
	}
	
	public int insertGdsView(GoodsView goodsView) {
	    int result = sqlSession.insert("goods.insertGdsView", goodsView);
	    return result;
	}		

	public int checkGdsView(GoodsView goodsView) {
	    int result = sqlSession.selectOne("goods.checkGdsView", goodsView);
	    return result;
	}
	
	/**
	 * 상품 재고 수량 체크
	 * @param searchForm
	 * @return
	 */
	public int checkGdsStock(SearchForm searchForm) {
	    int result = sqlSession.selectOne("goods.checkGdsStock", searchForm);
	    return result;
	}
	
	
	/**
	 * 쿠폰 리스트 가져오기
	 * @param searchForm
	 * @return
	 */
	public List<Coupon> getCouponList(SearchForm searchForm){
		List<Coupon> result = sqlSession.selectList("goods.getCouponList", searchForm);
		return result;
	}
	
	
	
	/**
	 * 쿠폰 등록
	 * @param couponForm
	 * @return
	 */
	public int couponReg(Coupon couponForm) {
		int result = sqlSession.insert("goods.couponReg", couponForm);
	    return result;
	}
	
	/**
	 * 쿠폰 수정
	 * @param couponForm
	 * @return
	 */
	public int couponModify(Coupon couponForm) {
		int result = sqlSession.update("goods.couponModify", couponForm);
		return result;
	}
	
	/**
	 * 쿠폰 상세 가져오기
	 * @param cpnNo
	 * @return
	 */
	public Coupon getCoupon(int cpnNo) {
		Coupon result = sqlSession.selectOne("goods.getCoupon", cpnNo);
	    return result;
	}
	
	
	
}