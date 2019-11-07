package com.giftiel.shop.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.common.Constants;
import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dao.CouponDao;
import com.giftiel.shop.dao.GoodsDao;
import com.giftiel.shop.dao.MemberDao;
import com.giftiel.shop.dao.OrderDao;
import com.giftiel.shop.dao.PointDao;
import com.giftiel.shop.dao.SettingDao;
import com.giftiel.shop.dto.Coupon;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.Order;
import com.giftiel.shop.dto.OrderAddPay;
import com.giftiel.shop.dto.OrderClm;
import com.giftiel.shop.dto.OrderDelivery;
import com.giftiel.shop.dto.OrderDlvCmp;
import com.giftiel.shop.dto.OrderDlvCst;
import com.giftiel.shop.dto.OrderGoods;
import com.giftiel.shop.dto.OrderMemo;
import com.giftiel.shop.dto.OrderPay;
import com.giftiel.shop.dto.Point;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.Setting;
import com.giftiel.shop.dto.UbiOrder;
import com.giftiel.shop.utils.DateUtils;

@Service
public class OrderService {
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private CommonDao commonDao;	
	@Autowired
	private SettingDao settingDao;
	@Autowired
	private PointDao pointDao;
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CouponDao couponDao;
	
	/**
	 * 주문 리스트
	 * @param searchForm
	 * @return
	 */
	public List<Order> listOrder(SearchForm searchForm) {
	    List<Order> result = orderDao.listOrder(searchForm);
	    return result;
	}
		
	/**
	 * 주문 리스트 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListOrder(SearchForm searchForm) {
	    int result = orderDao.totalListOrder(searchForm);
	    return result;
	}
	
	/**
	 * 주문 상세
	 * @param searchForm
	 * @return
	 */
	public Order selectOrder(SearchForm searchForm) {
		Order result = orderDao.selectOrder(searchForm);
	    return result;
	}
	
	/**
	 * 주문상품 개별진행상태  UPDATE 
	 * @param searchForm
	 * @return
	 */
	public int updateOrdStat(Order order) {
	    int result = orderDao.updateOrdStat(order);
	    return result;
	}
	
	/**
	 * 주문상품 개별진행상태  UPDATE 
	 * @param searchForm
	 * @return
	 */
	public int updateOrdStat2(Order order) {
	    int result = orderDao.updateOrdStat2(order);
	    return result;
	}	
		
	/**
	 * 주문자정보  UPDATE
	 * @param searchForm
	 * @return
	 */
	public int updateOrdr(Order orderForm) {
	    int result = orderDao.updateOrdr(orderForm);
	    return result;
	}
	
	/**
	 * 주문상품정보 수정  UPDATE  
	 * @param searchForm
	 * @return
	 */
	public int updateOrdGoods(Order orderForm) {
	    int result = orderDao.updateOrdGoods(orderForm);
	    return result;
	}
	
	/**
	 * 주문커멘트 등록 
	 * @param searchForm
	 * @return
	 */
	public int insertOrdMemo(OrderMemo orderMemo) {
	    int result = orderDao.insertOrdMemo(orderMemo);
	    return result;
	}
	
	/**
	 * 주문커멘트 삭제 
	 * @param searchForm
	 * @return
	 */
	public int deleteOrdMemo(OrderMemo orderMemo) {
	    int result = orderDao.deleteOrdMemo(orderMemo);
	    return result;
	}
	
	/**
	 * 택배사조회
	 * @param searchForm
	 * @return
	 */
	public List<OrderDlvCmp> listDlvCmp() {
	    List<OrderDlvCmp> result = orderDao.listDlvCmp();
	    return result;
	}
	
	/**
	 * 택배사조회 - 택배사 코드로 조회시
	 * @param searchForm
	 * @return
	 */
	public OrderDlvCmp dlvCmp(int invNo) {
	    OrderDlvCmp result = orderDao.dlvCmp(invNo);
	    return result;
	}
	
	/**
	 * 추가결제 조회
	 * @param searchForm
	 * @return
	 */
	public List<OrderAddPay> listAddPay(SearchForm searchForm) {
	    List<OrderAddPay> result = orderDao.listAddPay(searchForm);
	    return result;
	}
	
	
	/**
	 * 추가결제 조회 총 갯수
	 * @param searchForm
	 * @return
	 */
	public int totalListAddPay(SearchForm searchForm) {
	    int result = orderDao.totalListAddPay(searchForm);
	    return result;
	}	
	
	
	
	/**
	 * 추가결제등록
	 * @param orderAddPay
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int insertOrdAddPay(OrderAddPay orderAddPay) {
	    int result = orderDao.insertOrdAddPay(orderAddPay);
	    return result;
	}
	
	/**
	 * 주문 추가결제 수정
	 * @param orderAddPay
	 * @return
	 */
	public int updateOrdAddPay(OrderAddPay orderAddPay) {
	    int result = orderDao.updateOrdAddPay(orderAddPay);
	    return result;
	}
	
	/**
	 * 주문 추가결제 취소 
	 * @param searchForm
	 * @return
	 */
	public int updateOrdPay(OrderPay orderPay) {
	    int result = orderDao.updateOrdPay(orderPay);
	    return result;
	}
	
	/**
	 * 주문데이터 생성(pg모듈 호출 전)
	 * @param order
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public Order orderInit(Order order) {
		//상점환경설정
		Setting setting = settingDao.pointSettingList();
		
		String ordNo = orderDao.createOrdNo();
		order.setOrdNo(ordNo);
		orderDao.insertOrd(order);
		
		//회원정보
		SearchForm searchMem = new SearchForm();
		searchMem.setMemNo(order.getMemNo()+"");
		Member member = memberDao.selectMemInfo(searchMem);
		
		//배송비 그룹
		//List<OrderDelivery> orderDeliverys = new ArrayList<OrderDelivery>();
		OrderDelivery orderDelivery = new OrderDelivery();
		orderDelivery.setOrdDlvNo(commonDao.createKey("SEQ_OR_DLV_NO"));
		orderDelivery.setOrdNo(order.getOrdNo());
		orderDelivery.setPlcyDlvCst((int)setting.dlv_cst);
		orderDelivery.setDlvCstEtc("주문상품 배송비");
		orderDelivery.setDlvCstPayway(Constants.DLV_CST_PAYWAY_CASE);
		orderDelivery.setMinOrdAmt((int)setting.getCnd_free_dlv_amt());
		orderDelivery.setRegrNo(order.getRegrNo());
		orderDao.insertOrddvl(orderDelivery);
		
		//배송비금액
		OrderDlvCst orderDlvCst = new OrderDlvCst();
		orderDlvCst.setDlvCstSeq(commonDao.createKey("SEQ_OR_DLV_CST_SEQ"));
		orderDlvCst.setOrdDlvNo(orderDelivery.getOrdDlvNo());
		orderDlvCst.setOrdClmCls("OR00601");
		orderDlvCst.setActlDlvCst(order.getTotalDlvCst());
		orderDlvCst.setRegrNo(order.getRegrNo());
		if(order.getTotalDlvCst() > 0){
			orderDlvCst.setDlvCstTp("OR01302"); //배송비부과	
		}else{
			orderDlvCst.setDlvCstTp("OR01301"); //무료배송
		}
		orderDao.insertDlvCst(orderDlvCst);
		
		
		//주문상품
		int totActlPayPrc = 0;
		int totActlPoint = 0;
		//포인트 결제금액에 나머지가 생겨서 나머지금액을 먼저 계산해줌
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			//상품 가격정보를 다시 셋팅(변조방지)
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
			searchForm.setUbiGdsSize(order.getOrderGoods().get(i).getUbiGdsSize());
			Goods goods = goodsDao.selectGoods(searchForm);			
			double totalSlAmt = (order.getOrderPay().get(0).getPayAmt()+order.getOrderPay().get(1).getPayAmt()) - orderDlvCst.getActlDlvCst();
			double actlPayPer = Integer.parseInt(goods.getUbiGoods().getUbiSlPrc())/totalSlAmt;
			double actlPayPrc = Math.floor((order.getOrderPay().get(0).getPayAmt() * actlPayPer)/100)*100;
			double usePnt = Math.floor(order.getOrderPay().get(1).getPayAmt() * actlPayPer);
			totActlPoint = totActlPoint + (int)usePnt;
		}
		
		
		for (int i = 0; i < order.getOrderGoods().size(); i++) {
			int ordGdsNo = commonDao.createKey("SEQ_OR_ORD_GDS");
			
			//상품 가격정보를 다시 셋팅(변조방지)
			SearchForm searchForm = new SearchForm();
			searchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
			searchForm.setUbiGdsSize(order.getOrderGoods().get(i).getUbiGdsSize());
			Goods goods = goodsDao.selectGoods(searchForm);
			
			order.getOrderGoods().get(i).setOrdNo(ordNo);
			order.getOrderGoods().get(i).setOrdGdsSeq(ordGdsNo);
			order.getOrderGoods().get(i).setSlPrc(Integer.parseInt(goods.getUbiGoods().getUbiSlPrc()));
			order.getOrderGoods().get(i).setBrnd(goods.getUbiGoods().getBrand());
			order.getOrderGoods().get(i).setUbiGdsNm(goods.getUbiGoods().getUbiGdsNm());
			order.getOrderGoods().get(i).setUbiGdsSize(goods.getUbiGoods().getUbiGdsSize());
			order.getOrderGoods().get(i).setColor(goods.getUbiGoods().getColor());
			order.getOrderGoods().get(i).setPerOrdStat(Constants.PER_ORD_STAT_PAYSTAY);
			order.getOrderGoods().get(i).setSeasongroupCode(goods.getUbiGoods().getYearCode()+goods.getUbiGoods().getSeasongroupCode());
			order.getOrderGoods().get(i).setCategory1Code(goods.getUbiGoods().getCategory1Code());
			order.getOrderGoods().get(i).setCategory2Code(goods.getUbiGoods().getCategory2Code());
			order.getOrderGoods().get(i).setCnclQty(0);
			order.getOrderGoods().get(i).setRegrNo(order.getRegrNo());
			
			//실결제 금액 계산 {
				//배송비 제외한 총 결제금액(적립금 사용액 포함)
				double totalSlAmt = (order.getOrderPay().get(0).getPayAmt()+order.getOrderPay().get(1).getPayAmt()) - orderDlvCst.getActlDlvCst();
				//상품별 총 결제금액 비율
				double actlPayPer = Integer.parseInt(goods.getUbiGoods().getUbiSlPrc())/totalSlAmt;
				//총 결제금액 비율별 상품 실 결제금액
				double actlPayPrc = Math.floor((order.getOrderPay().get(0).getPayAmt() * actlPayPer)/100)*100;
				
				double usePnt = Math.floor(order.getOrderPay().get(1).getPayAmt() * actlPayPer);
				
				if(i == order.getOrderGoods().size()-1){
					actlPayPrc = order.getOrderPay().get(0).getPayAmt() - totActlPayPrc;
				}else{
					totActlPayPrc = totActlPayPrc + (int)actlPayPrc;
				}
				
				//배송비 빠지는 정책으로 변경
				//actlPayPrc = ((totalSlAmt * actlPayPer) - (order.getOrderPay().get(1).getPayAmt() * actlPayPer));
				actlPayPrc = Integer.parseInt(goods.getUbiGoods().getUbiSlPrc()) - (int)usePnt;
				
				order.getOrderGoods().get(i).setActlPayPrc((int)actlPayPrc);
				order.getOrderGoods().get(i).setUsePnt((int)usePnt);
				if(i == 0){
					if(order.getOrderPay().get(1).getPayAmt() > 0){
						order.getOrderGoods().get(i).setActlPayPrc(Integer.parseInt(goods.getUbiGoods().getUbiSlPrc()) - (int)usePnt - (order.getOrderPay().get(1).getPayAmt() - totActlPoint));
						order.getOrderGoods().get(0).setUsePnt(order.getOrderGoods().get(0).getUsePnt() + (order.getOrderPay().get(1).getPayAmt() - totActlPoint));
					}
				}
			//실결제 금액 계산 종료 }
			
			//배송비
			order.getOrderGoods().get(i).setOrdDlvNo(orderDelivery.getOrdDlvNo());
			order.getOrderGoods().get(i).setGdsDlvCstPayway("GD00601");
			
			//회원 포인트 지급 정책 시작
			if(Constants.PNT_RSV_CLS_NONE.equals(setting.getPnt_rsv_cls())){
				order.getOrderGoods().get(i).setExpPnt(0);	
			}else if(Constants.PNT_RSV_CLS_MEMLV.equals(setting.getPnt_rsv_cls())){
				if(member!=null){
					order.getOrderGoods().get(i).setExpPnt((order.getOrderGoods().get(i).getSlPrc()/100) * member.getCurRsvPer());
				}else{
					order.getOrderGoods().get(i).setExpPnt(0);		
				}
			}else if(Constants.PNT_RSV_CLS_SLPRC.equals(setting.getPnt_rsv_cls())){
				order.getOrderGoods().get(i).setExpPnt((order.getOrderGoods().get(i).getSlPrc()/100) * (int)setting.getPnt_rsv_rt());
			}else if(Constants.PNT_RSV_CLS_PAYAMT.equals(setting.getPnt_rsv_cls())){
				order.getOrderGoods().get(i).setExpPnt((order.getOrderGoods().get(i).getPayAmt()/100) * (int)setting.getPnt_rsv_rt());
			}
			//회원 포인트 지급 정책 끝
			
			
			//쿠폰금액 계산 시작{
			//orderForm 에서 쿠폰번호가 입력된 경우에만 실행
//			try {
				if(StringUtils.isNotEmpty(order.getOrderGoods().get(i).getCpnNo())){
					SearchForm coupSearchForm = new SearchForm();
					coupSearchForm.setOffCpnNo(order.getOrderGoods().get(i).getOffCpnNo());
					coupSearchForm.setUbiGdsNo(order.getOrderGoods().get(i).getUbiGdsNo());
					
					Coupon coupon = couponDao.offCpnInfo(coupSearchForm);
					
//					if(coupon == null){
//						throw new Exception();
//					}
					
					int dcAmt = 0;
					
					//정액 정률 구분
					if(Constants.DC_WAY_FIX.equals(coupon.getDcWay())){
						dcAmt = coupon.getDcAmt();
					}else{
						dcAmt = (order.getOrderGoods().get(i).getSlPrc() * coupon.getDcAmt()) / 100;
						if(dcAmt > coupon.getMaxDcAmt()){
							dcAmt = coupon.getMaxDcAmt();
						}
					}
					
					order.getOrderGoods().get(i).setActlPayPrc(order.getOrderGoods().get(i).getActlPayPrc() - dcAmt);
					order.getOrderGoods().get(i).setCpnPayAmt(dcAmt);					
				}
//			} catch (Exception e) {
//				System.out.println("쿠폰정보 에러");
//			}
			//}쿠폰금액 계산 끝					
			
			orderDao.insertOrdGds(order.getOrderGoods().get(i));
		}
		
		//적립금 사용금액 결제금액에서 차감
		order.getOrderPay().get(0).setPayAmt(order.getOrderPay().get(0).getPayAmt() - order.getOrderPay().get(1).getPayAmt());
		
		for (int i = 0; i < order.getOrderPay().size(); i++) {
			order.getOrderPay().get(i).setPayNo(commonDao.createKey("SEQ_OR_PAY_NO"));
			order.getOrderPay().get(i).setOrdNo(ordNo);
			order.getOrderPay().get(i).setPayTp("OR00701");
			order.getOrderPay().get(i).setPayStat("OR00901");
			order.getOrderPay().get(i).setOrdClmCls("OR00601");
			order.getOrderPay().get(i).setCnclAmt(0);
			order.getOrderPay().get(i).setRegrNo(order.getRegrNo());
			
			int totalPayAmt = 0;
			for (int f = 0; f < order.getOrderGoods().size(); f++) {
				if(order.getOrderGoods().get(f).getCpnPayAmt() != null){
					totalPayAmt += order.getOrderGoods().get(f).getSlPrc() - order.getOrderGoods().get(f).getCpnPayAmt();
				}else{
					totalPayAmt += order.getOrderGoods().get(f).getSlPrc();
				}
			}
			
			if(i == 0){
				order.getOrderPay().get(i).setPayAmt(totalPayAmt - order.getOrderPay().get(1).getPayAmt() + order.getTotalDlvCst());
			}
			
			
			if(StringUtils.isEmpty(order.getOrderPay().get(i).getPayWay())){
				order.getOrderPay().get(i).setPayWay("OR00800");
			}
			
			orderDao.insertOrdPay(order.getOrderPay().get(i));
		}		
		
		return order;
	}
	
	
	
	//교환,반품신청
	@Transactional(rollbackFor=Exception.class)
	public int claimApply(OrderClm clmForm, String ordStat) {
	    int result = orderDao.insertClm(clmForm);//클래임추가
	    
	   
	    for(int i=0;i<clmForm.getOrderClmGds().size();i++){
	    	clmForm.getOrderClmGds().get(i).setClmNo(clmForm.getClmNo());
	    	clmForm.getOrderClmGds().get(i).setOrdNo(clmForm.getOrdNo());
	    	clmForm.getOrderClmGds().get(i).setRegrNo(clmForm.getRegrNo());
	    	clmForm.getOrderClmGds().get(i).setUpdrNo(clmForm.getUpdrNo());
	    	
	    	result = orderDao.insertClmGds(clmForm.getOrderClmGds().get(i));//클래임상품추가
	    	
	    	Order order = new Order();
		    order.setPerOrdStat(ordStat);
		    order.setUpdrNo(clmForm.getUpdrNo());
		    order.setCnclQty(1);
		    order.setOrdNo(clmForm.getOrdNo());
		    order.setOrdGdsSeq(clmForm.getOrderClmGds().get(i).getClmGdsSeq());
		    order.setOrdGdsSeq(clmForm.getOrderClmGds().get(i).getOrdGdsSeq());
		    result = orderDao.updateOrdStat2(order);//주문상품 상태변경
	    }
	    
	    
	    return result;
	}
	
	
	/**
	 * 주문번호
	 * @param searchForm
	 * @return
	 */
	public HashMap<String,Integer> getClmNo(SearchForm searchForm){
		HashMap<String,Integer> result = orderDao.getClmNo(searchForm);
	    return result;
	}	
	
	//교환,반품취소
	@Transactional(rollbackFor=Exception.class)
	public int claimCancel(Order order){
		int result = orderDao.updateOrdStat2(order);//주문상품 상태변경
		result = orderDao.updateClmGds(order.getOrderClm().get(0).getOrderClmGds().get(0)); //클래임 상품상태변경
		
		result = orderDao.clmGdsStatChk(order.getOrderClm().get(0).getOrderClmGds().get(0));
		if(result == 0){
			result = orderDao.updateClm(order.getOrderClm().get(0)); //클래임 상태변경
		}
		
		return result;
	}

	/**
	 * 주문 결제 등록
	 * @param OrderMemo
	 * @return
	 */
	public int insertOrdPay(OrderPay orderPay) {
		orderPay.setPayNo(commonDao.createKey("SEQ_OR_PAY_NO"));
		
	    int result = orderDao.insertOrdPay(orderPay);
	    return result;
	}

	public int insertUbiOrder(UbiOrder ubiOrder) {
	    int result = orderDao.insertUbiOrder(ubiOrder);
	    return result;
	}	
	
	public int insertUbiOrderCancel(UbiOrder ubiOrder) {
	    int result = orderDao.insertUbiOrderCancel(ubiOrder);
	    return result;
	}
	
	
	public int insertUbiOrderExchange(UbiOrder ubiOrder) {
		int result = orderDao.insertUbiOrderCancel(ubiOrder);
	    result = orderDao.insertUbiOrderExchange(ubiOrder);
	    return result;
	}
	
	
	/**
	 * 상품 사이즈차트 엑셀 파싱
	 * @param file
	 * @return
	 * @throws IOException 
	 */
	public List<OrderGoods> getInvNoExcel(File file) throws Exception {
		List<OrderGoods> orderGoodss = new ArrayList<OrderGoods>();
		
		//파일을 읽기위해 엑셀파일을 가져온다 
		FileInputStream fis=new FileInputStream(file);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		
		int rowindex=0;
		int columnindex=0;
		
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet = workbook.getSheetAt(0);
				
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();

		for(rowindex=1;rowindex<rows;rowindex++){
			OrderGoods orderGoods = new OrderGoods();
			
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
		            
		            System.out.println("value============[" + value + "]");
		            
		            switch (columnindex) {
		            case 0:  orderGoods.setOrdNo(value);
		            		 break;
		            case 1:  orderGoods.setChgInvNo(value);
		            		 break;
		            case 2:  orderGoods.setDlvCmpNo(Integer.parseInt(value));
                    		 break;
                    default:
                    		 break;
		            }
		        }
		        orderGoodss.add(orderGoods);
		    }
		}
		return orderGoodss;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int invoUpdateOrdGoods(List<OrderGoods> orderGoods){
	
		Order order = new Order();
		
		for (int i = 0; i < orderGoods.size(); i++) {
			
			order.setRegrNo(orderGoods.get(i).getRegrNo());				// 작성자
			order.setUpdrNo(orderGoods.get(i).getUpdrNo());				// 수정자
			
			order.setOrdNo(orderGoods.get(i).getOrdNo());				// 주문번호
			order.setChgInvNo(orderGoods.get(i).getChgInvNo());			// 송장번호
			if (orderGoods.get(i).getChgDlvCmpNo() == null) {
				orderGoods.get(i).setChgDlvCmpNo(1);
			}
			order.setChgDlvCmpNo(orderGoods.get(i).getChgDlvCmpNo());	// 택배사 번호
			
			orderDao.updateOrdGoods(order);
		}
		
		return orderGoods.size();
	}
	
	
	/**
	 * 가상계좌 자동취소
	 * @param searchForm
	 * @return
	 * @throws ParseException 
	 */
	@Transactional(rollbackFor=Exception.class)
	public void cancelTempOrder() throws ParseException {
		Date currentTime = new Date ( );
		
		String sDate = DateUtils.getAddDate(currentTime, -30);
		String eDate = DateUtils.getAddDate(currentTime, -2);
		
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdStat(Constants.ORD_STAT_STAND);
		searchForm.setInqStrDtm(sDate);
		searchForm.setInqEndDtm(eDate);
		searchForm.setOffLineEgnoreChk("Y");
		List<Order> result = orderDao.listOrderBatch(searchForm);
		
		for (int i = 0; i < result.size(); i++) {
			Order order = new Order();
			order.setOrdNo(result.get(i).getOrdNo());
			order.setOrdStat(Constants.ORD_STAT_CANCEL);
			order.setUpdrNo(0);
			orderDao.updateOrdr(order);	
			
			order.setPerOrdStat(Constants.PER_ORD_STAT_ORDER_CANCEL);
			orderDao.updateOrdStat2(order);
			
        	//적립금 사용
			if(result.get(i).getUsePnt() > 0){
	        	Point point = new Point();
				point.setRsvRsnCd("MT00206");
				point.setMemNo(result.get(i).getMemNo());
				point.setRsvPnt(result.get(i).getUsePnt());
				point.setRsvYn("Y");
				point.setRegrNo(result.get(i).getMemNo());
				point.setRsvCls("CM01001");
				point.setOrdNo(result.get(i).getOrdNo());
				orderDao.insertPoint(point);
			}
		}
	}
	
	public List<UbiOrder> getUbiOrderList(SearchForm searchForm) {
	    List<UbiOrder> result = orderDao.getUbiOrderList(searchForm);
	    return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void orderProcessingOnlyPoint(Order order, Member member) {
    	
		SearchForm searchForm = new SearchForm();
		searchForm.setOrdNo(order.getOrdNo());
		order = orderDao.selectOrder(searchForm);		
		
		Order orderResult = new Order();
    	orderResult.setOrdNo(order.getOrdNo());
        orderResult.setUpdrNo(order.getMemNo()); //수정자
    	
    	OrderPay OrderPayResult = new OrderPay();
    	OrderPayResult.setOrdNo(order.getOrdNo());
    	OrderPayResult.setUpdrNo(order.getMemNo()); //수정자
		
    	
        orderResult.setOrdStat("OR00203");
        orderResult.setPerOrdStat("OR00502");
        
        OrderPayResult.setPayStat("OR00902");
        
    	//주문상태 수정
    	orderDao.updateOrdr(orderResult);
    	//주문개별상태 수정
    	orderDao.updateOrdStat2(orderResult);             
    	//UBI판매등록
    	
    	int ubiOrderNo = orderDao.ubiOrderSeq();

    	//상품
    		for (int i = 0; i < order.getOrderGoods().size(); i++) {
    			
        		UbiOrder ubiOrder = new UbiOrder();
        		ubiOrder.set매장코드("WE001");
        		ubiOrder.set판매번호(String.format("%04d", ubiOrderNo));
        		ubiOrder.set판매연번(String.format("%04d", i+1));
        		ubiOrder.set작업구분("0");
        		ubiOrder.set품번(order.getOrderGoods().get(i).getUbiGdsNo());
        		ubiOrder.set색상(order.getOrderGoods().get(i).getUbiGdsColorCd());
        		ubiOrder.set사이즈(order.getOrderGoods().get(i).getUbiGdsSize());
        		ubiOrder.set판매수량(1);
        		ubiOrder.set실판매금액(0);
        		ubiOrder.set적립포인트(order.getOrderGoods().get(i).getExpPnt());
        		ubiOrder.set사용포인트(order.getOrderGoods().get(i).getUsePnt()-order.getOrderDelivery().get(0).getOrderDlvCsts().get(0).getActlDlvCst());
        		ubiOrder.set수정여부("N");
        		ubiOrder.set처리여부("N");
        		ubiOrder.set에러사유("");
        		ubiOrder.set주문번호(order.getOrdNo());
        		if(member == null){
            		ubiOrder.set적립율(0);
            		ubiOrder.set온라인고객코드("99999999");
            	}else{
            		ubiOrder.set적립율(member.getCurRsvPer());
            		ubiOrder.set온라인고객코드(order.getMemNo().toString());	
            	}
        		
        		orderDao.insertUbiOrder(ubiOrder);
    		}
    		//배송비
    		if(order.getOrderDelivery().get(0).getOrderDlvCsts().get(0).getActlDlvCst() > 0){
    			UbiOrder ubiOrder = new UbiOrder();
        		ubiOrder.set매장코드("WE001");
        		ubiOrder.set판매번호(String.format("%04d", ubiOrderNo));
        		ubiOrder.set판매연번(String.format("%04d", order.getOrderGoods().size()+1));
        		ubiOrder.set작업구분("0");
        		ubiOrder.set품번("000000000000000001");
        		ubiOrder.set색상("000");
        		ubiOrder.set사이즈("NO");
        		ubiOrder.set판매수량(1);
        		ubiOrder.set실판매금액(0);
        		ubiOrder.set적립포인트(0);
        		ubiOrder.set사용포인트(order.getOrderDelivery().get(0).getOrderDlvCsts().get(0).getActlDlvCst());
        		ubiOrder.set수정여부("N");
        		ubiOrder.set처리여부("N");
        		ubiOrder.set에러사유("");
        		ubiOrder.set주문번호(order.getOrdNo());
        		if(member == null){
            		ubiOrder.set적립율(0);
            		ubiOrder.set온라인고객코드("99999999");
            	}else{
            		ubiOrder.set적립율(member.getCurRsvPer());
            		ubiOrder.set온라인고객코드(member.getMemNo().toString());	
            	}
        		orderDao.insertUbiOrder(ubiOrder);
    		}
    		
        	//적립금 사용
        	Point point = new Point();
			point.setRsvRsnCd("MT00201");
			point.setMemNo(member.getMemNo());
			point.setRsvPnt(order.getOrderPay().get(1).getPayAmt()==null?0:order.getOrderPay().get(1).getPayAmt());
			point.setRsvYn("N");
			point.setRegrNo(member.getMemNo());
			point.setRsvCls("CM01002");
			point.setOrdNo(order.getOrdNo());
			orderDao.insertPoint(point);            		
	}
	
	public int insertPoint(Point point) {
	    int result = orderDao.insertPoint(point);
	    return result;
	}
	
	public int ubiOrderSeq() {
	    int result = orderDao.ubiOrderSeq();
	    return result;
	}
}