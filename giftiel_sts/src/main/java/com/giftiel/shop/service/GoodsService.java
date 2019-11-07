package com.giftiel.shop.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dao.GoodsDao;
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
import com.giftiel.shop.dto.UBIGoods;

@Service
public class GoodsService {
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private CommonDao commonDao;	
	
	/**
	 * 상품 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoods(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoods(searchForm);
	    return result;
	}
	
	/**
	 * 상품 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListGoods(SearchForm searchForm) {
	    int result = goodsDao.totalListGoods(searchForm);
	    return result;
	}	
	
	/**
	 * 상품 상세
	 * @param searchForm
	 * @return
	 */
	public Goods selectGoods(SearchForm searchForm) {
	    Goods result = goodsDao.selectGoods(searchForm);
	    if("Y".equals(result.getOffGdsChk())){
	    	result.setOfflineGoodsChk(true);
	    }
	    return result;
	}
	
	/**
	 * 상품정보고시그룹 리스트
	 * @param searchForm
	 * @return
	 */
	public List<GoodsAddInfoGrp> listAddInfoGrp(SearchForm searchForm) {
	    List<GoodsAddInfoGrp> result = goodsDao.listAddInfoGrp(searchForm);
	    return result;
	}
	
	/**
	 * 상품정보고시 그룹 & 상품정보고시 상세 리스트
	 * @param searchForm
	 * @return
	 */
	public GoodsAddInfoGrp selectAddInfoGrp(SearchForm searchForm) {
		GoodsAddInfoGrp result = goodsDao.selectAddInfoGrp(searchForm);
	    return result;
	}
	
	/**
	 * 상품정보고시 저장(INSERT OR UPDATE)
	 * @param goodsAddInfoGrp
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int saveInfoGrp(GoodsAddInfoGrp goodsAddInfoGrp) {
		int result = 0;
			//insert
			if(goodsAddInfoGrp.getGdsInfoNo() == null){
				goodsAddInfoGrp.setGdsInfoNo(commonDao.createKey("SEQ_GD_GDS_INFO"));
				result = goodsDao.insertInfoGrp(goodsAddInfoGrp);
				
				goodsDao.deleteInfo(goodsAddInfoGrp.getGdsInfoNo());	
				for (int i = 0; i < goodsAddInfoGrp.getGoodsAddInfos().size(); i++) {
					if(!goodsAddInfoGrp.getGoodsAddInfos().get(i).getTitle().equals("") && !goodsAddInfoGrp.getGoodsAddInfos().get(i).getTxt().equals("")){
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setGdsInfoNo(goodsAddInfoGrp.getGdsInfoNo());
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setRegrNo(goodsAddInfoGrp.getRegrNo());
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setUpdrNo(goodsAddInfoGrp.getRegrNo());
						goodsDao.insertInfo(goodsAddInfoGrp.getGoodsAddInfos().get(i));
					}
				}
			//update
			}else{
				result = goodsDao.updateInfoGrp(goodsAddInfoGrp);
				
				goodsDao.deleteInfo(goodsAddInfoGrp.getGdsInfoNo());				
				for (int i = 0; i < goodsAddInfoGrp.getGoodsAddInfos().size(); i++) {
					if(!goodsAddInfoGrp.getGoodsAddInfos().get(i).getTitle().equals("") && !goodsAddInfoGrp.getGoodsAddInfos().get(i).getTxt().equals("")){
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setGdsInfoNo(goodsAddInfoGrp.getGdsInfoNo());
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setRegrNo(goodsAddInfoGrp.getRegrNo());
						goodsAddInfoGrp.getGoodsAddInfos().get(i).setUpdrNo(goodsAddInfoGrp.getRegrNo());
						goodsDao.insertInfo(goodsAddInfoGrp.getGoodsAddInfos().get(i));
					}
				}
			}
		return result;
	}
	
	/**
	 * 상품정보고시 엑셀저장(INSERT OR UPDATE)
	 * @param goodsAddInfoGrp
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int saveInfoGrpExcel(GoodsAddInfoGrp goodsAddInfoGrp){

		int result = 0;
		
		SearchForm searchForm = new SearchForm();
		
		String[] gdsInfoNm = goodsAddInfoGrp.getGdsInfoNm().split(",");
		
		for (int i = 0; i < goodsAddInfoGrp.getGoodsAddInfos().size(); i++) {
			searchForm.setUbiGdsNo(gdsInfoNm[i]);
			GoodsAddInfoGrp grpResult1 = goodsDao.selectAddInfoGrp(searchForm);
			if (grpResult1 == null) {
				goodsAddInfoGrp.setGdsInfoNo(commonDao.createKey("SEQ_GD_GDS_INFO"));
				goodsAddInfoGrp.setGdsInfoNm(goodsAddInfoGrp.getGoodsAddInfos().get(i).getGdsInfoNm());
				result = goodsDao.insertInfoGrp(goodsAddInfoGrp);
			}
		}
		searchForm.setUbiGdsNo(null);		
		List<GoodsAddInfoGrp> grpResult2 = goodsDao.listAddInfoGrp(searchForm);
		for (int j = 0; j < goodsAddInfoGrp.getGoodsAddInfos().size(); j++) {
			for (int i = 0; i < grpResult2.size(); i++) {
				if(grpResult2.get(i).getGdsInfoNm().equals(gdsInfoNm[j])){
					goodsAddInfoGrp.getGoodsAddInfos().get(j).setGdsInfoNo(grpResult2.get(i).getGdsInfoNo());				
					goodsAddInfoGrp.getGoodsAddInfos().get(j).setRegrNo(grpResult2.get(i).getRegrNo());
					goodsDao.insertInfo(goodsAddInfoGrp.getGoodsAddInfos().get(j));
				}
			}
		}
		return result;
	}
	
	/**
	 * 상품정보 merge
	 * @param goods
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int mergeGoods(Goods goods) {
		int result = 0;
		
		if(goods.isOfflineGoodsChk()){
			goods.setOffGdsChk("Y");
		}else{
			goods.setOffGdsChk("N");
		}
		
		//update
		if(goodsDao.checkInsertGoods(goods.getUbiGoods().getUbiGdsNo()) > 0){
			result = goodsDao.updateGoods(goods);
		//insert
		}else{
			result = goodsDao.insertGoods(goods);
		}
		
		//검색어
		goodsDao.deleteTag(goods.getUbiGoods().getUbiGdsNo());
		if(goods.getGoodsTags() != null){
			for (int i = 0; i < goods.getGoodsTags().size(); i++) {
				goods.getGoodsTags().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
				goods.getGoodsTags().get(i).setRegrNo(goods.getRegrNo());
				
				if(StringUtils.isNotEmpty(goods.getGoodsTags().get(i).getTagNm())){
					goodsDao.insertTag(goods.getGoodsTags().get(i));	
				}
			}
		}
		
		//이미지
		goodsDao.deleteGdsImg(goods.getUbiGoods().getUbiGdsNo());
		if(goods.getGoodsImages() != null){
			for (int i = 0; i < goods.getGoodsImages().size(); i++) {
				goods.getGoodsImages().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
				goods.getGoodsImages().get(i).setRegrNo(goods.getRegrNo());
				
				if(StringUtils.isNotEmpty(goods.getGoodsImages().get(i).getImgUrl())){
					goodsDao.insertGdsImg(goods.getGoodsImages().get(i));
				}
			}
		}

		//사이즈차트
		if(goods.getGoodsSizes() != null){
			goodsDao.deleteSize(goods.getUbiGoods().getUbiGdsNo());
			for (int i = 0; i < goods.getGoodsSizes().size(); i++) {
				goods.getGoodsSizes().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
				goods.getGoodsSizes().get(i).setPrir(i);
				
				goodsDao.insertSize(goods.getGoodsSizes().get(i));
			}					
		}
		
		return result;
	}
	
	/**
	 * 상품정보 대량 merge
	 * @param goods
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int mergeGoodsExcel(List<Goods> goodss) {
		for (int j = 0; j < goodss.size(); j++) {
			Goods goods = goodss.get(j);	
			
			//update
			if(goodsDao.checkInsertGoods(goods.getUbiGoods().getUbiGdsNo()) > 0){
				goodsDao.updateGoods(goods);
			//insert
			}else{
				goodsDao.insertGoods(goods);
			}
			
			//검색어
			goodsDao.deleteTag(goods.getUbiGoods().getUbiGdsNo());
			for (int i = 0; i < goods.getGoodsTags().size(); i++) {
				goods.getGoodsTags().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
				goods.getGoodsTags().get(i).setRegrNo(goods.getRegrNo());
				
				if(StringUtils.isNotEmpty(goods.getGoodsTags().get(i).getTagNm())){
					goodsDao.insertTag(goods.getGoodsTags().get(i));	
				}
			}
			
			//이미지
			goodsDao.deleteGdsImg(goods.getUbiGoods().getUbiGdsNo());
			for (int i = 0; i < goods.getGoodsImages().size(); i++) {
				goods.getGoodsImages().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
				goods.getGoodsImages().get(i).setRegrNo(goods.getRegrNo());
				goods.getGoodsImages().get(i).setPrir(i);
				
				if(StringUtils.isNotEmpty(goods.getGoodsImages().get(i).getImgUrl())){
					goodsDao.insertGdsImg(goods.getGoodsImages().get(i));
				}
			}
			
			//사이즈차트
			if(goods.getGoodsSizes() != null){
				goodsDao.deleteSize(goods.getUbiGoods().getUbiGdsNo());
				for (int i = 0; i < goods.getGoodsSizes().size(); i++) {
					goods.getGoodsSizes().get(i).setUbiGdsNo(goods.getUbiGoods().getUbiGdsNo());
					goods.getGoodsSizes().get(i).setPrir(i);
					goodsDao.insertSize(goods.getGoodsSizes().get(i));
				}
			}
			
		}
		return goodss.size();
	}	
	
	/**
	 * 상품 노출순서 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoodsCategoryDisplayNew(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsCategoryDisplayNew(searchForm);
	    return result;
	}	
	
	public List<Goods> listGoodsCategoryDisplay(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsCategoryDisplay(searchForm);
	    return result;
	}		
	
	public List<Goods> listGoodsCategoryDisplayBrand(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsCategoryDisplayBrand(searchForm);
	    return result;
	}	
	
	public List<Goods> listGoodsCategoryDisplayThreeDepth(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsCategoryDisplayThreeDepth(searchForm);
	    return result;
	}			
	
	/**
	 * 상품 정렬 순서 저장
	 * @param goods
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int updateGoodsDisplay(Goods goods) {
		return goodsDao.updateGoodsSort(goods);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int updateGoodsSortCollabo(Goods goods) {
		return goodsDao.updateGoodsSortCollabo(goods);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int updateGoodsSort(Goods goods) {
		return goodsDao.updateGoods(goods);
	}	
	
	@Transactional(rollbackFor=Exception.class)
	public int updateGoodsArrvSort(Goods goods) {
		return goodsDao.updateGoodsArrvSort(goods);
	}		
	
	/**
	 * 상품 사이즈차트 엑셀 파싱
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	public List<GoodsSize> getSizeChartExcel(File file) throws IOException {
		List<GoodsSize> goodsSizes = new ArrayList<GoodsSize>();
		
		//파일을 읽기위해 엑셀파일을 가져온다 
		FileInputStream fis=new FileInputStream(file);
		XSSFWorkbook workbook=new XSSFWorkbook(fis);
		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
			GoodsSize goodsSize = new GoodsSize();
		    //행을읽는다
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        for(columnindex=0;columnindex<=cells;columnindex++){
		            //셀값을 읽는다
		            XSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case XSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                case XSSFCell.CELL_TYPE_NUMERIC:
		                    value=cell.getNumericCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		            }
		            
		            if("false".equals(value)){
		            	value="";
		            }
		            
		            switch (columnindex) {
			            case 0:  goodsSize.setSizeNm(value);
	                    		 break;		            
			            case 1:  goodsSize.setSize1(value);
			                     break;
			            case 2:  goodsSize.setSize2(value);
			                     break;
			            case 3:  goodsSize.setSize3(value);
			                     break;
			            case 4:  goodsSize.setSize4(value);
			                     break;
			            case 5:  goodsSize.setSize5(value);
			                     break;
			            case 6:  goodsSize.setSize6(value);
			                     break;
			            case 7:  goodsSize.setSize7(value);
			                     break;
			            case 8:  goodsSize.setSize8(value);
			                     break;
			            case 9:  goodsSize.setSize9(value);
			                     break;
		            }
		        }
		        goodsSizes.add(goodsSize);
		    }
		}	
		
		return goodsSizes;
	}	
	
	/**
	 * 상품엑셀 대량업로드 파싱
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	public List<Goods> getGoodsExcel(File file) throws IOException {
		
		List<Goods> goodss = new ArrayList<Goods>();
		
		//파일을 읽기위해 엑셀파일을 가져온다 
		FileInputStream fis=new FileInputStream(file);
		XSSFWorkbook workbook=new XSSFWorkbook(fis);
		DataFormatter fmt = new DataFormatter();
		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
			
			Goods goods = new Goods();
			UBIGoods ubiGoods = new UBIGoods();
			List<GoodsTag> goodsTags = new ArrayList<GoodsTag>();
			List<GoodsImage> goodsImages = new ArrayList<GoodsImage>();
			
		    //행을읽는다
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        for(columnindex=0;columnindex<=cells;columnindex++){
		            //셀값을 읽는다
		            XSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case XSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                case XSSFCell.CELL_TYPE_NUMERIC:
		                	value=fmt.formatCellValue(cell);
		                    //value=cell.getNumericCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		            }
		            
		            GoodsTag goodsTag = new GoodsTag();
		            GoodsImage goodsImage = new GoodsImage();
		            
		            switch (columnindex) {
			            case 0: ubiGoods.setUbiGdsNo(value);
	                    		break;		            
			            case 1: goodsTag.setTagNm(value);
			            		goodsTags.add(goodsTag);
			                    break;
			            case 2: goodsTag.setTagNm(value);
	            				goodsTags.add(goodsTag);
	            				break;
			            case 3: goodsTag.setTagNm(value);
		        				goodsTags.add(goodsTag);
		        				break;
			            case 4: goodsTag.setTagNm(value);
		        				goodsTags.add(goodsTag);
		        				break;
			            case 5: goodsTag.setTagNm(value);
		        				goodsTags.add(goodsTag);
		        				break;
			            case 6: goodsTag.setTagNm(value);
		        				goodsTags.add(goodsTag);
		        				break;
			            case 7: goods.setGdsInfoNo(Integer.parseInt(value));
			                    break;
			            case 8: goods.setDispYn(value);
			                    break;
			            case 9: goods.setSlTermCls(value);
			                    break;
			            case 10:goods.setSlStrDtm(value);
			            		break;
			            case 11:goods.setSlEndDtm(value);
	                    		break;
			            case 12:goods.setGdsStat(value);
                				break;
			            case 13:goods.setBsDesc(value);
        						break;
			            case 14:goods.setDtlDesc(value);
        						break;
			            case 15:goodsImage.setImgUrl(value);goodsImage.setPrir(0);
			            		goodsImages.add(goodsImage);
        						break;
			            case 16:goodsImage.setImgUrl(value);goodsImage.setPrir(1);
	            				goodsImages.add(goodsImage);
	            				break;
			            case 17:goodsImage.setImgUrl(value);goodsImage.setPrir(2);
		        				goodsImages.add(goodsImage);
		        				break;
			            case 18:goodsImage.setImgUrl(value);goodsImage.setPrir(3);
		        				goodsImages.add(goodsImage);
		        				break;
			            case 19:goodsImage.setImgUrl(value);goodsImage.setPrir(4);
		        				goodsImages.add(goodsImage);
		        				break;
			            case 20:goodsImage.setImgUrl(value);goodsImage.setPrir(5);
		        				goodsImages.add(goodsImage);
		        				break;
		            }
		        }
		        goods.setUbiGoods(ubiGoods);
		        goods.setGoodsTags(goodsTags);
		        goods.setGoodsImages(goodsImages);
		        goodss.add(goods);
		    }
		}	
		
		return goodss;
	}

	/**
	 * 상품정보고시엑셀 대량업로드 파싱
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	public List<GoodsAddInfoGrp> getGoodsAddInfoExcel(File file) throws IOException {
		
		List<GoodsAddInfoGrp> goodsAddInfoGrps = new ArrayList<GoodsAddInfoGrp>();
		List<GoodsAddInfo> goodsAddInfos = new ArrayList<GoodsAddInfo>();
		
		//파일을 읽기위해 엑셀파일을 가져온다 
		FileInputStream fis = new FileInputStream(file);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		DataFormatter fmt = new DataFormatter();
		
		int rowindex=0;
		int columnindex=0;
		
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet=workbook.getSheetAt(0);
		
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();

		for(rowindex=1; rowindex<rows; rowindex++){
		
			GoodsAddInfoGrp goodsAddinfoGrp = new GoodsAddInfoGrp();
	    	GoodsAddInfo goodsAddInfo = new GoodsAddInfo();
	    	
		    //행을읽는다
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){

		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        for(columnindex=0;columnindex<=cells;columnindex++){
		            //셀값을 읽는다
		            XSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case XSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                case XSSFCell.CELL_TYPE_NUMERIC:
		                	value=fmt.formatCellValue(cell);
		                    //value=cell.getNumericCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case XSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		            }
		            
		            switch (columnindex) {
			            case 0: goodsAddinfoGrp.setGdsInfoNm(value);
	                    	break;
			            case 1: goodsAddInfo.setTitle(value);
	                    	break;
			            case 2: goodsAddInfo.setTxt(value);
			            	break;
		            }
		        }
		    }
		    goodsAddInfos.add(goodsAddInfo);
		    goodsAddinfoGrp.setGoodsAddInfos(goodsAddInfos);
		    goodsAddInfoGrps.add(goodsAddinfoGrp);
		}	
		
		return goodsAddInfoGrps;
	}
	
	/**
	 * Front 상품 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoodsFront(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsFront(searchForm);
	    return result;
	}
	
	public List<Goods> listGoodsFrontAjax(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsFrontAjax(searchForm);
	    return result;
	}
	
	public List<Goods> listGoodsFrontNew(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsFrontNew(searchForm);
	    return result;
	}	
	
	/**
	 * FRONT 상품 카테고리 사이즈 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listGoodsSizeFront(SearchForm searchForm) {
	    List<Goods> result = goodsDao.listGoodsSizeFront(searchForm);
	    return result;
	}	
	
	/**
	 * 주문건에서 상품 사이즈 리스트 가지고 오기
	 */
	public List<Goods> listGoodsSize(){
		List<Goods> result = goodsDao.listGoodsSize();
		return result;
	}
	
	/**
	 * Front 상품 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListGoodsFront(SearchForm searchForm) {
	    int result = goodsDao.totalListGoodsFront(searchForm);
	    return result;
	}
	
	public int totalListGoodsFrontAjax(SearchForm searchForm) {
	    int result = goodsDao.totalListGoodsFrontAjax(searchForm);
	    return result;
	}
	
	/**
	 * 카테고리 New 상품 리스트 총갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListGoodsFrontNew(SearchForm searchForm) {
	    int result = goodsDao.totalListGoodsFrontNew(searchForm);
	    return result;
	}	

	/**
	 * Front 상품 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Goods> listCurGdsSize(String ubiGdsNo) {
	    List<Goods> result = goodsDao.listCurGdsSize(ubiGdsNo);
	    return result;
	}
	
	/**
	 * Front 상품 상세
	 * @param searchForm
	 * @return
	 */
	public Goods selectGoodsFront(SearchForm searchForm) {
	    Goods result = goodsDao.selectGoodsFront(searchForm);
	    if("Y".equals(result.getOffGdsChk())){
	    	result.setOfflineGoodsChk(true);
	    }
	    return result;
	}

	public List<IntgBoard> collaboList(SearchForm searchForm) {
		List<IntgBoard> collaboration = goodsDao.collaboList(searchForm);
		return collaboration;
	}
	
	public int insertGdsView(GoodsView goodsView) {
	    int result = goodsDao.insertGdsView(goodsView);
	    	goodsDao.updateViewCount(goodsView.getUbiGdsNo());
	    return result;
	}
	
	public int checkGdsView(GoodsView goodsView) {
	    int result = goodsDao.checkGdsView(goodsView);
	    return result;
	}
	
	public List<CurrentGoodsColors> listCurColors(SearchForm searchForm) {
	    List<CurrentGoodsColors> result = goodsDao.listCurColors(searchForm);
	    return result;
	}
	
	/**
	 * 상품 재고수량 체크
	 * @param searchForm
	 * @return
	 */
	public int checkGdsStock(SearchForm searchForm) {
	    int result = goodsDao.checkGdsStock(searchForm);
	    return result;
	}
	
	
	
	/**
	 * 쿠폰 리스트 가져오기
	 * @param searchForm
	 * @return
	 */
	public List<Coupon> getCouponList(SearchForm searchForm){
		List<Coupon> result = goodsDao.getCouponList(searchForm);
		return result;
	}
	
	
	
	/**
	 * 쿠폰 등록
	 * @param couponForm
	 * @return
	 */
	public int couponReg(Coupon couponForm) {
	    int result = goodsDao.couponReg(couponForm);
	    return result;
	}
	
	
	/**
	 * 쿠폰 수정
	 * @param couponForm
	 * @return
	 */
	public int couponModify(Coupon couponForm) {
		int result = goodsDao.couponModify(couponForm);
		return result;
	}
	
	
	/**
	 * 쿠폰 상세 가져오기
	 * @param cpnNo
	 * @return
	 */
	public Coupon getCoupon(int cpnNo) {
		Coupon result = goodsDao.getCoupon(cpnNo);
	    return result;
	}
	
	
}