<%--
 * =============================================================================
 * 파일명 : /front/order/commonNoti.jsp
 * 작성자 : 권용재
 * 작성일자 : 2015-06-29
 *
 * 파일 내용 : order > 입금통보 데이터 공통처리
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%
    /* ============================================================================== */
    /* =   PAGE : 공통 통보 PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */
%>
    <%@ page import="com.kcp.*" %>
    <%@ page import="com.giftiel.shop.dao.*" %>
    <%@ page import="com.giftiel.shop.dto.*" %>
    <%@ page import="com.giftiel.shop.common.*" %>
    <%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
    <%@ page import="org.springframework.web.context.WebApplicationContext" %>
    <%@ page import="java.net.URLEncoder"%>
    <%@ page import="java.util.HashMap"%>
    <%@ include file="site_conf_inc.jsp"%>
<%
%>    
<%!
    /* ============================================================================== */
    /* =   null 값을 처리하는 메소드                                                = */
    /* = -------------------------------------------------------------------------- = */
        public String f_get_parm( String val )
        {
          if ( val == null ) val = "";
          return  val;
        }
    /* ============================================================================== */
%>
<%
    /* ============================================================================== */
    /* =   01. 공통 통보 페이지 설명(필독!!)                                        = */
    /* = -------------------------------------------------------------------------- = */
    /* =   공통 통보 페이지에서는,                                                  = */
    /* =   가상계좌 입금 통보 데이터와 모바일안심결제 통보 데이터 등을 KCP를 통해   = */
    /* =   실시간으로 통보 받을 수 있습니다.                                        = */
    /* =                                                                            = */
    /* =   common_return 페이지는 이러한 통보 데이터를 받기 위한 샘플 페이지        = */
    /* =   입니다. 현재의 페이지를 업체에 맞게 수정하신 후, 아래 사항을 참고하셔서  = */
    /* =   KCP 관리자 페이지에 등록해 주시기 바랍니다.                              = */
    /* =                                                                            = */
    /* =   등록 방법은 다음과 같습니다.                                             = */
    /* =  - KCP 관리자페이지(admin.kcp.co.kr)에 로그인 합니다.                      = */
    /* =  - [쇼핑몰 관리] -> [정보변경] -> [공통 URL 정보] -> 공통 URL 변경 후에    = */
    /* =    가맹점 URL을 입력합니다.                                                = */
    /* ============================================================================== */
	
    String mallResultCode	= "1111"; //기본 실패

    /* ============================================================================== */
    /* =   02. 공통 통보 데이터 받기                                                = */
    /* = -------------------------------------------------------------------------- = */
    String site_cd          = f_get_parm( request.getParameter( "site_cd"		   ) );    // 사이트 코드
    String tno              = f_get_parm( request.getParameter( "tno"              ) );    // KCP 거래번호
    String ordr_idxx        = f_get_parm( request.getParameter( "ordr_idxx"        ) );    // 주문번호
    String tx_cd            = f_get_parm( request.getParameter( "tx_cd"            ) );    // 업무처리 구분 코드
    String tx_tm            = f_get_parm( request.getParameter( "tx_tm"            ) );    // 업무처리 완료 시간
    /* = -------------------------------------------------------------------------- = */
    String ipgm_name        = "";                                                          // 주문자명
    String remitter         = "";                                                          // 입금자명
    String ipgm_mnyx        = "";                                                          // 입금금액
    String bank_code        = "";                                                          // 은행코드
    String account          = "";                                                          // 가상계좌 입금계좌번호
    String op_cd            = "";                                                          // 처리구분 코드
    String noti_id          = "";                                                          // 통보 아이디
    /* = -------------------------------------------------------------------------- = */
    String refund_nm        = "";                                                          // 환불계좌주명
    String refund_mny       = "";                                                          // 환불금액
   //String bank_code        = "";                                                          // 은행코드
    /* = -------------------------------------------------------------------------- = */
    String st_cd            = "";                                                          // 구매확인 코드
    String can_msg          = "";                                                          // 구매취소 사유
    /* = -------------------------------------------------------------------------- = */
    String waybill_no       = "";                                                          // 운송장 번호
    String waybill_corp     = "";                                                          // 택배 업체명
    /* = -------------------------------------------------------------------------- = */
    String cash_a_no        = "";                                                          // 현금영수증 승인번호
    String cash_a_dt        = "";                                                          // 현금영수증 승인시간
    /* = -------------------------------------------------------------------------- = */
    /* =   02-1. 가상계좌 입금 통보 데이터 받기                                     = */
    /* = -------------------------------------------------------------------------- = */
    if ( tx_cd.equals("TX00") )
    {
        ipgm_name = f_get_parm( request.getParameter( "ipgm_name" ) );           // 주문자명
        remitter  = f_get_parm( request.getParameter( "remitter"  ) );           // 입금자명
        ipgm_mnyx = f_get_parm( request.getParameter( "ipgm_mnyx" ) );           // 입금 금액
        bank_code = f_get_parm( request.getParameter( "bank_code" ) );           // 은행코드
        account   = f_get_parm( request.getParameter( "account"   ) );           // 가상계좌 입금계좌번호
        op_cd     = f_get_parm( request.getParameter( "op_cd"     ) );           // 처리구분 코드
        noti_id   = f_get_parm( request.getParameter( "noti_id"   ) );           // 통보 아이디
        cash_a_no = f_get_parm( request.getParameter( "cash_a_no" ) );           // 현금영수증 승인번호
        cash_a_dt = f_get_parm( request.getParameter( "cash_a_dt" ) );           // 현금영수증 승인시간
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   02-2. 가상계좌 환불 통보 데이터 받기                                      = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX01") )
    {
        refund_nm  = f_get_parm( request.getParameter( "refund_nm"  ) );         // 환불계좌주명
        refund_mny = f_get_parm( request.getParameter( "refund_mny" ) );         // 환불금액
        bank_code  = f_get_parm( request.getParameter( "bank_code"  ) );         // 은행코드
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   02-3. 구매확인/구매취소 통보 데이터 받기                                 = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX02") )
    {
        st_cd = f_get_parm( request.getParameter( "st_cd" ) );                   // 구매확인 코드

        if ( st_cd.equals("N") )                                                 // 구매확인 상태가 구매취소인 경우
        {
            can_msg = f_get_parm( request.getParameter( "can_msg" ) );           // 구매취소 사유
        }
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   02-4. 배송시작 통보 데이터 받기                                          = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX03") )
    {
        waybill_no   = f_get_parm( request.getParameter( "waybill_no"   ) );     // 운송장 번호
        waybill_corp = f_get_parm( request.getParameter( "waybill_corp" ) );     // 택배 업체명
    }
    /* ============================================================================== */


    /* ============================================================================== */
    /* =   03. 공통 통보 결과를 업체 자체적으로 DB 처리 작업하시는 부분입니다.      = */
    /* = -------------------------------------------------------------------------- = */
    /* =   통보 결과를 DB 작업 하는 과정에서 정상적으로 통보된 건에 대해 DB 작업을  = */
    /* =   실패하여 DB update 가 완료되지 않은 경우, 결과를 재통보 받을 수 있는     = */
    /* =   프로세스가 구성되어 있습니다. 소스에서 result 라는 Form 값을 생성 하신   = */
    /* =   후, DB 작업이 성공 한 경우, result 의 값을 "0000" 로 세팅해 주시고,      = */
    /* =   DB 작업이 실패 한 경우, result 의 값을 "0000" 이외의 값으로 세팅해 주시  = */
    /* =   기 바랍니다. result 값이 "0000" 이 아닌 경우에는 재통보를 받게 됩니다.   = */
    /* = -------------------------------------------------------------------------- = */
    
    /* = -------------------------------------------------------------------------- = */
    /* =   03-1. 가상계좌 입금 통보 데이터 DB 처리 작업 부분                        = */
    /* = -------------------------------------------------------------------------- = */
	System.out.println("=====================가상계좌 입금 통보 시작 site_cd=====================" + site_cd);
	System.out.println("=====================가상계좌 입금 통보 시작 tno=====================" + tno);
	System.out.println("=====================가상계좌 입금 통보 시작 ordr_idxx=====================" + ordr_idxx);
	System.out.println("=====================가상계좌 입금 통보 시작 tx_cd=====================" + tx_cd);
	System.out.println("=====================가상계좌 입금 통보 시작 tx_tm=====================" + tx_tm);

	WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
	OrderDao orderDao = (OrderDao)wac.getBean("orderDao");
	PointDao pointDao = (PointDao)wac.getBean("pointDao");
	SMSSend smsSend = (SMSSend)wac.getBean("SMSSend");
	MailSend mailSend = (MailSend)wac.getBean("MailSend");
	CommonDao commonDao = (CommonDao)wac.getBean("commonDao");
	MemberDao memberDao = (MemberDao)wac.getBean("memberDao");
	
    if ( tx_cd.equals("TX00") )
    {
    	if(ordr_idxx != null){
	    	SearchForm searchForm = new SearchForm();
	    	searchForm.setOrdNo(request.getParameter("ordr_idxx"));
	    	Order order = orderDao.selectOrder(searchForm);
	    	
	    	if("OR00202".equals(order.getOrdStat())){
	    		
	    		System.out.println("=====================가상계좌 입금 통보 입금대기중 확인=====================");
	    		int ubiOrderNo = orderDao.ubiOrderSeq();
					    	
		    	SearchForm searchMem = new SearchForm();
		    	searchMem.setMemNo(order.getMemNo()+"");
		    	//회원정보
		    	Member member = memberDao.selectMemInfo(searchMem);    
		        
		        Order orderResult = new Order();
		    	orderResult.setOrdNo(ordr_idxx);
		    	if(member == null){
		    		orderResult.setUpdrNo(99999999); //수정자
		    	}else{
		        	orderResult.setUpdrNo(member.getMemNo()); //수정자
		    	}
		    	
		    	OrderPay OrderPayResult = new OrderPay();
		    	OrderPayResult.setOrdNo(ordr_idxx);
		    	if(member == null){
		    		OrderPayResult.setUpdrNo(99999999); //수정자
		    	}else{
		    		OrderPayResult.setUpdrNo(member.getMemNo()); //수정자
		    	}       	
		    	
		        orderResult.setOrdStat("OR00203");
		        orderResult.setPerOrdStat("OR00502");
		        
		        OrderPayResult.setPayStat("OR00902");
		        
		    	//주문상태 수정
		    	orderDao.updateOrdr(orderResult);
		    	//주문개별상태 수정
		    	orderDao.updateOrdStat2(orderResult);      	
		    	//주문결제 상태
		    	orderDao.updateOrdPay(OrderPayResult);    	
		    	
		    	//UBI판매등록
		    	if(testCls){
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
		        		ubiOrder.set실판매금액(order.getOrderGoods().get(i).getSlPrc()-order.getOrderGoods().get(i).getUsePnt()-order.getOrderGoods().get(i).getCpnPayAmt());
		        		ubiOrder.set적립포인트(order.getOrderGoods().get(i).getExpPnt());
		        		ubiOrder.set사용포인트(order.getOrderGoods().get(i).getUsePnt());
		        		ubiOrder.set수정여부("N");
		        		ubiOrder.set처리여부("N");
		        		ubiOrder.set에러사유("");
		        		ubiOrder.set주문번호(ordr_idxx);
		        		if(member == null){
		            		ubiOrder.set적립율(0);
		            		ubiOrder.set온라인고객코드("99999999");
		            	}else{
		            		ubiOrder.set적립율(member.getCurRsvPer());
		            		ubiOrder.set온라인고객코드(member.getMemNo().toString());	
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
		        		ubiOrder.set실판매금액(order.getOrderDelivery().get(0).getOrderDlvCsts().get(0).getActlDlvCst());
		        		ubiOrder.set적립포인트(0);
		        		ubiOrder.set사용포인트(0);
		        		ubiOrder.set수정여부("N");
		        		ubiOrder.set처리여부("N");
		        		ubiOrder.set에러사유("");
		        		ubiOrder.set주문번호(ordr_idxx);
		        		if(member == null){
		            		ubiOrder.set적립율(0);
		            		ubiOrder.set온라인고객코드("99999999");
		            	}else{
		            		ubiOrder.set적립율(member.getCurRsvPer());
		            		ubiOrder.set온라인고객코드(member.getMemNo().toString());	
		            	}
		        		
		        		orderDao.insertUbiOrder(ubiOrder);
		    		}    		
		    	}
		    	
		    	//적립금 적립 처리
		    	/* if(member != null){
		        	Point point = new Point();
		        	point.setMemNo(member.getMemNo());
		        	point.setRsvPnt(order.getTotalExpPnt());
		        	point.setRsvRsnCd("MT00201");
		        	point.setRsvYn("Y");
		        	point.setOrdNo(ordr_idxx);
		        	point.setRegrNo(member.getMemNo());
		        	point.setRsvCls("CM01002");
		        	pointDao.insertPoint(point);
		    	}    	 */
		    	
		    	//SMS발송(SMS문구번호, 수신번호, 브랜드명, 이름, 주문번호) - null시 ""
				smsSend.sendSMS(4, order.getOrdrCp(), order.getSiteNm(), order.getRcpnNm(), order.getOrdNo(), 0);
				
				//MAIL 발송
				HashMap<String,Object> hm = new HashMap<String,Object>();
		       	hm.put("orderNo", order.getOrdNo());
		       	int result = 0;
		       	//메일발송 성공 : 1, 실패 : 0
		       	if(order.getOrdrEmail() != null){
					//result = mailSend.sendMail(order.getOrdrNm(),order.getOrdrEmail(),request,hm,"payComp");
		       	}
		       	
		       	mallResultCode = "0000";
		       	
	    	}else if("OR00203".equals(order.getOrdStat())){
		       	mallResultCode = "0000";
	    	}
	    	
    	}
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-2. 가상계좌 환불 통보 데이터 DB 처리 작업 부분                        = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX01") )
    {
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-3. 구매확인/구매취소 통보 데이터 DB 처리 작업 부분                    = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX02") )
    {
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-4. 배송시작 통보 데이터 DB 처리 작업 부분                             = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX03") )
    {
    	mallResultCode = "0000";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-5. 정산보류 통보 데이터 DB 처리 작업 부분                             = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX04") )
    {
    	mallResultCode = "0000";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-6. 즉시취소 통보 데이터 DB 처리 작업 부분                             = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX05") )
    {
    	mallResultCode = "0000";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-7. 취소 통보 데이터 DB 처리 작업 부분                                 = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX06") )
    {
    	mallResultCode = "0000";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-8. 발급계좌해지 통보 데이터 DB 처리 작업 부분                         = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX07") )
    {
    	ordr_idxx = orderDao.getOrdNoForTno(tno);
    	if(ordr_idxx != null){
	    	SearchForm searchForm = new SearchForm();
	    	searchForm.setOrdNo(ordr_idxx);
	    	Order order = orderDao.selectOrder(searchForm);    		
    		
	        Order orderResult = new Order();
	    	orderResult.setOrdNo(ordr_idxx);
	    	
	    	SearchForm searchMem = new SearchForm();
	    	searchMem.setMemNo(order.getMemNo()+"");
	    	//회원정보
	    	Member member = memberDao.selectMemInfo(searchMem);    	    	
	    	
	    	if(member == null){
	    		orderResult.setUpdrNo(99999999); //수정자
	    	}else{
	        	orderResult.setUpdrNo(member.getMemNo()); //수정자
	    	}
	    	
	    	OrderPay OrderPayResult = new OrderPay();
	    	OrderPayResult.setOrdNo(ordr_idxx);
	    	if(member == null){
	    		OrderPayResult.setUpdrNo(99999999); //수정자
	    	}else{
	    		OrderPayResult.setUpdrNo(member.getMemNo()); //수정자
	    	}       		    	
	    	
	    	orderResult.setOrdStat("OR00204");
	    	OrderPayResult.setPayStat("OR00904");
	    	OrderPayResult.setCnclAmt(order.getOrderPay().get(0).getPayAmt());
	    	orderDao.updateOrdr(orderResult);//주문상태 수정
	    	orderDao.updateOrdPay(OrderPayResult);//주문결제 상태
	    	
	    	//클레임
	    	OrderClm orderClm = new OrderClm();
	    	orderClm.setClmNo(commonDao.createKey("SEQ_TBL_OR_CLM"));
	    	orderClm.setClmStat("OR01702"); //클레임 완료
	    	orderClm.setOrdNo(order.getOrdNo());
	    	orderClm.setClmTp("OR01601");
	    	orderClm.setRegrNo(99999999);
	    	orderDao.insertClm(orderClm);
	    	
	    	//클레임 상품
	    	for (int i = 0; i < order.getOrderGoods().size(); i++) {
	    		OrderClmGds orderClmGds = new OrderClmGds();	   
	    		orderClmGds.setClmGdsSeq(commonDao.createKey("SEQ_TBL_OR_CLM_GDS"));
	    		orderClmGds.setClmNo(orderClm.getClmNo());
	    		orderClmGds.setOrdNo(order.getOrdNo());
	    		orderClmGds.setOrdGdsSeq(order.getOrderGoods().get(i).getOrdGdsSeq());
	    		orderClmGds.setOrdDlvNo(order.getOrderGoods().get(i).getOrdDlvNo());
	    		orderClmGds.setClmQty(1);
	    		orderClmGds.setClmRsnCd("OR01801"); 
	    		orderClmGds.setClmTxt("입금전취소");
	    		orderClmGds.setClmGdsStat("OR01904");
	    		orderClmGds.setRegrNo(99999999);
	    		orderDao.insertClmGds(orderClmGds);
	    		
	    		orderResult.setCnclQty(1);
	            orderResult.setPerOrdStat("OR00507");//결제상태
	            orderDao.updateOrdStat2(orderResult);//주문개별상태 수정
	            
        		//쿠폰 사용처리
        		if(order.getOrderGoods().get(i).getOffCpnNo() != null){
    				Coupon updCoupon = new Coupon();
    				updCoupon.setOffCpnNo(order.getOrderGoods().get(i).getOffCpnNo());
    				updCoupon.setMemNo(order.getMemNo());
    				updCoupon.setUpdrNo(order.getMemNo());
    				orderDao.updateOffCpn(updCoupon);            			
        		}	            
	    	}
	    	
	    	
    	}
    	
    	mallResultCode = "0000";
    }

    /* = -------------------------------------------------------------------------- = */
    /* =   03-9. 모바일계좌이체 통보 데이터 DB 처리 작업 부분                       = */
    /* = -------------------------------------------------------------------------- = */
    else if ( tx_cd.equals("TX08") )
    {
    }
    /* ============================================================================== */


    /* ============================================================================== */
    /* =   04. result 값 세팅 하기                                                  = */
    /* ============================================================================== */
    
    System.out.println("=====================가상계좌 입금 통보 끝========================" + mallResultCode);
%>
<html><body><form><input type="hidden" name="result" value="<%=mallResultCode%>"></form></body></html>