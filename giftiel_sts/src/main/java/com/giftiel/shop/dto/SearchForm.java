package com.giftiel.shop.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.List;



public class SearchForm {
	//공통
	private Integer page; 				//페이지 번호
	private Integer totalCnt;			//총갯수
	private Integer startListNum;		//페이징 시작번호
	private Integer endListNum;			//페이징 끝번호	
	private boolean excel;				//엑셀다운로드 구분
	private Integer searchCount;        //목록갯수
	private String orderBy;        		//정렬기준컬럼
	private String orderFlag;      		//정렬기준	
	private String searchGb;			//직접검색구분
	private String searchText;			//직접검색
	private String regStrDtm;			//작성시작일
	private String regEndDtm;			//작성종료일
	private String regNm;				//작성자
	private String updStrDtm;			//수정시작일
	private String updEndDtm;			//수정종료일
	private String updrNm;				//작성자	
	private String dispYn;				//전시유무
	private String siteNo;				//사이트번호
	private Integer rownum;				//제한줄번호 
	
	private String searchStrDtm;			//검색시작일
	private String searchEndDtm;			//검색종료일
	
	private String gubun;				//구분

	//회원목록
	private String loginStrDtm;			//최근접속시작일
	private String loginEndDtm;			//최근접속종료일
	private String ordStrDtm;			//주문시작일
	private String ordEndDtm;			//주문종료일
	private String joinStrDtm;			//가입시작일
	private String joinEndDtm;			//가입종료일
	private Integer memGrdNo;			//회원등급번호
	private Integer actlPayStrPrc;		//구매시작액
	private Integer actlPayEndPrc;		//구매종료액
	private Integer ordGdsCnt;			//상품구매건수
	private Integer rsvStrPnt;			//적립시작액
	private Integer rsvEndPnt;			//적립종료액
	private String email;				//email
	private String nm;					//이름
	private String cpNo;				//휴대폰번호
	private String memNo;            	//회원번호
	private String pwd;   	         	//비밀번호
	
	private String memYn;   	        //회원유무
	private String ipAddr;   	        //아이피주소
	
	private boolean allMember; //전체회원 조회 여부
	
	//2019-11-06 이후 추가
	private String cbNo;				//사업자등록번호
	private String id;					//회원아이디
	private String reprNm;				//대표자
	private String cmpNm;				//상호명
	private String cmpType;				//사업자구분
	private String bizSt;				//업종/업태
	private String mngr;				//담당자
	private String dept;				//근무부서
	private String tel;					//전화번호
	
	//코드
	private String supCdNo;				//상위코드번호
	private String depthCode;			//조회 코드
	
	
	//1:1문의관리
	private String inqStrDtm;			//조회기간시작일
	private String inqEndDtm;			//조회기간종료일
	private String memGb;				//회원검색구분값 
	private String member;				//회원검색값
	private String replGb;				//답변구분값
	
	//상품
	private String gdsStat;				//상품상태
	private Integer ubiSlStrPrc;		//판매시작액
	private Integer ubiSlEndPrc;		//판매종료액
	private String oneDepth;			//카테고리1
	private String twoDepth;			//카테고리2
	private String threeDepth;			//카테고리3
	private String color;				//상품컬러
	private String brand;				//브랜드
	private String brandCode;				//브랜드
	private String ubiGdsNo;			//UBI상품번호
	private String ubiGdsSize;			//사이즈
	private boolean soldoutYn;			//품절유무
	private boolean dispYn2;			//전시유무 checkbox용		
	private Integer qty;				//수량
	private String sex;					//성별
	private boolean stockZeroChk;		//재고수량체크
	private boolean imageUploadChk;		//이미지유무체크
	private String clbltnNm;			//콜라보레이션
	private String etcGdsNo;			//기타상품코드
	private String seasonCode;			//시즌코드
	private int seasonSeq;			    //시즌 seq
	private int nowSeq;			        //선택한 시즌 seq
	
	private String stockZeroGubun;		//재고수량 구분값
	private String imageUploadGubun;    //이미지 업로드여부 구분값
	
	private boolean newArrival;			//신상품유무
	private Integer imgSeq;				//게시판이미지번호
	private String preSeason;			//지난시즌(season1)
	private String curSeason;			//현재시즌
	private String category1Code;		//카테고리1코드
	private String category2Code;		//카테고리2코드
	
	private String cateGubun;         //카테고리 구분코드
	
	//포인트 관리
	private String pointContents;     //포인트 내용
	private String rsvRsnCd;          //적립 사유
	private String rsvCls;			  // 적립주체 
	
	//우편번호, 주소
	private String sidoNm;			//시도명
	private String sigunguNm;         //시군구명 	
	
	//상품정보고시
	private Integer gdsInfoNo;         //상품정보번호 
	private String gdsInfoNm;         //상품정보명 
	private String useYn;         //사용여부 
	
	//주문매출관리
	private String[] siteNos;				//사이트번호
	private String[] perOrdStats;    //개별진행상태
	private String[] ordStats; //진행상태
	private String[] brands; //브랜드
	private String[] ordGdsSeqs; //주문상품일련번호
	private String[] categoryTexts; //카테고리 검색텍스트 배열
	private String[] payTps; //결제유형
	private String[] payStats; //결제상태
	
	private Integer ordGdsSeq; //주문상품일련번호
	private String perOrdStat;    //개별진행상태 
	private String ordNo;         //주문번호
	private String ordStat; //진행상태
	private String payWay; //결제수단
	private String[] payWays;	//결제수단(checkboxs)
	private String barnd; 	
	private String categoryGb;	//카테고리구분
	private String categoryText; //카테고리 검색텍스트
	private String ordKnd; //주문구분
	private String payTp; //결제유형
	private String invNo;//송장 번호
	private String chgInvNo;//송장 번호
	private Integer dlvCmpNo;//택배사 번호
	private Integer chgDlvCmpNo;//택배사 번호
	private Date sndCmplDts;//발송완료일시 
	private String payStat;//결제상태 
	private Integer addPayStrPrc;//추가결제금액시작액
	private Integer addPayEndPrc;//추가결제금액종료액
	private String addPayRsn; //추가결제사유
	private boolean allDay; //전체날자조회
	private String ordClmCls; //주문,클라임구분
	
	private String egnoreStat; //주문,클라임구분
	
	private Integer sAge;	// 나이검색[S]
	private Integer eAge;	// 나이검색[E]
	
	private String offLineEgnoreChk;

	//NEWS 게시판
	private String newsType;   //news 게시물유형
	private String txtNo;		//news no
	
	private String topBnnrDispYn;   //탑배너노출여부
	
	//방문자접속통계
	private String dateType;	//방문자접속통계 검색 조건
	private String siteName;	//통계브랜드 사이트명
	private List<HashMap<String,Object>> value; //조건값

	//회원별 접속통계
	private String age;			//연령별
	
	private boolean web;
	private boolean mobile;
	
	//거주지별통계
	private String sido;		//시도
	private String gugun;		//시군구
	
	//SMS 게시판
	private String smsStrDtm;			//조회기간시작일
	private String smsEndDtm;			//조회기간종료일
	private String numGb;				//검색구분값 
	private Integer msgSeq;  		//메시지의 고유번호. 자동 증가하는 것으로 MSG_DATA의 PRIMARY KEY가 된다.
	private Integer curState;		//상태 값(발송요청:0, 전송 중:1, 전송:2, 결과수신:3)
	private String sentDate;		//메시지를 전송한 시각
	private String rsltDate;		//핸드폰에 전달된 시간 (이통사가 핸드폰이 수신했다고 주장하는 시간)
	private String reqDate;		//예약일시
	private Integer rsltCode;		//결과처리코드
	private String rsltCode2;		//결과처리 상세코드
	private String rsltNet;		//결과처리 통신사
	private String callTo;			//수신번호 (하이픈 등의 문자를 제외한 12byte이하의 숫자로 입력한다.)
	private String callFrom;		//발신번호 (하이픈 등의 문자를 제외한 12byte이하의 숫자로 입력한다.)
	private String msgTxt;			//SMS용 메시지본문
	private Integer msgType;		//메시지의 TYPE(4: SMS 전송 ,5: URL 전송 ,6: MMS전송 , 7: BARCODE전송)
	private Integer contSeq;		//MMS의 컨텐츠 Key(MMS_CONTENTS_INFO의 CONT_SEQ)
	private Integer sendGb;
	
	
	
	private String resultId;			//popupGoodsListForStatistics.jsp 창 호출시 필요 변수
	
	
	
	//게시판
	private String boardClcd;			//게시판분류코드
	
	
	//쿠폰
	private String offCpnNo;			//오프라인쿠폰번호
	
	public boolean isAllMember() {
		return allMember;
	}

	public void setAllMember(boolean allMember) {
		this.allMember = allMember;
	}

	public List<HashMap<String, Object>> getValue() {
		return value;
	}

	public void setValue(List<HashMap<String, Object>> value) {
		this.value = value;
	}

	public String getRsvRsnCd() {
		return rsvRsnCd;
	}

	public void setRsvRsnCd(String rsvRsnCd) {
		this.rsvRsnCd = rsvRsnCd;
	}

	public Integer getActlPayStrPrc() {
		return actlPayStrPrc;
	}

	public void setActlPayStrPrc(Integer actlPayStrPrc) {
		this.actlPayStrPrc = actlPayStrPrc;
	}

	public Integer getActlPayEndPrc() {
		return actlPayEndPrc;
	}

	public void setActlPayEndPrc(Integer actlPayEndPrc) {
		this.actlPayEndPrc = actlPayEndPrc;
	}

	public Integer getOrdGdsCnt() {
		return ordGdsCnt;
	}

	public void setOrdGdsCnt(Integer ordGdsCnt) {
		this.ordGdsCnt = ordGdsCnt;
	}

	public Integer getRsvStrPnt() {
		return rsvStrPnt;
	}

	public void setRsvStrPnt(Integer rsvStrPnt) {
		this.rsvStrPnt = rsvStrPnt;
	}

	public Integer getRsvEndPnt() {
		return rsvEndPnt;
	}

	public void setRsvEndPnt(Integer rsvEndPnt) {
		this.rsvEndPnt = rsvEndPnt;
	}

	public String getPointContents() {
		return pointContents;
	}

	public void setPointContents(String pointContents) {
		this.pointContents = pointContents;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(Integer totalCnt) {
		this.totalCnt = totalCnt;
	}

	public Integer getStartListNum() {
		return startListNum;
	}

	public void setStartListNum(Integer startListNum) {
		this.startListNum = startListNum;
	}

	public Integer getEndListNum() {
		if(excel){
			endListNum = Integer.MAX_VALUE;
		}
		return endListNum;
	}

	public void setEndListNum(Integer endListNum) {
		this.endListNum = endListNum;
	}


	public boolean isExcel() {
		return excel;
	}

	public void setExcel(boolean excel) {
		this.excel = excel;
	}

	public Integer getSearchCount() {
		return searchCount;
	}

	public void setSearchCount(Integer searchCount) {
		this.searchCount = searchCount;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}

	public String getSearchGb() {
		return searchGb;
	}

	public void setSearchGb(String searchGb) {
		this.searchGb = searchGb;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getRegStrDtm() {
		return regStrDtm;
	}

	public void setRegStrDtm(String regStrDtm) {
		this.regStrDtm = regStrDtm;
	}

	public String getRegEndDtm() {
		return regEndDtm;
	}

	public void setRegEndDtm(String regEndDtm) {
		this.regEndDtm = regEndDtm;
	}

	public String getRegNm() {
		return regNm;
	}

	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}

	public String getUpdStrDtm() {
		return updStrDtm;
	}

	public void setUpdStrDtm(String updStrDtm) {
		this.updStrDtm = updStrDtm;
	}

	public String getUpdEndDtm() {
		return updEndDtm;
	}

	public void setUpdEndDtm(String updEndDtm) {
		this.updEndDtm = updEndDtm;
	}

	public String getUpdrNm() {
		return updrNm;
	}

	public void setUpdrNm(String updrNm) {
		this.updrNm = updrNm;
	}

	public String getLoginStrDtm() {
		return loginStrDtm;
	}

	public void setLoginStrDtm(String loginStrDtm) {
		this.loginStrDtm = loginStrDtm;
	}

	public String getLoginEndDtm() {
		return loginEndDtm;
	}

	public void setLoginEndDtm(String loginEndDtm) {
		this.loginEndDtm = loginEndDtm;
	}

	public String getOrdStrDtm() {
		return ordStrDtm;
	}

	public void setOrdStrDtm(String ordStrDtm) {
		this.ordStrDtm = ordStrDtm;
	}

	public String getOrdEndDtm() {
		return ordEndDtm;
	}

	public void setOrdEndDtm(String ordEndDtm) {
		this.ordEndDtm = ordEndDtm;
	}

	public String getJoinStrDtm() {
		return joinStrDtm;
	}

	public void setJoinStrDtm(String joinStrDtm) {
		this.joinStrDtm = joinStrDtm;
	}

	public String getJoinEndDtm() {
		return joinEndDtm;
	}

	public void setJoinEndDtm(String joinEndDtm) {
		this.joinEndDtm = joinEndDtm;
	}

	public Integer getMemGrdNo() {
		return memGrdNo;
	}

	public void setMemGrdNo(Integer memGrdNo) {
		this.memGrdNo = memGrdNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getCpNo() {
		return cpNo;
	}

	public void setCpNo(String cpNo) {
		this.cpNo = cpNo;
	}

	public String getSupCdNo() {
		return supCdNo;
	}

	public void setSupCdNo(String supCdNo) {
		this.supCdNo = supCdNo;
	}

	public String getCbNo() {
		return cbNo;
	}

	public void setCbNo(String cbNo) {
		this.cbNo = cbNo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReprNm() {
		return reprNm;
	}

	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}

	public String getCmpNm() {
		return cmpNm;
	}

	public void setCmpNm(String cmpNm) {
		this.cmpNm = cmpNm;
	}

	public String getCmpType() {
		return cmpType;
	}

	public void setCmpType(String cmpType) {
		this.cmpType = cmpType;
	}

	public String getBizSt() {
		return bizSt;
	}

	public void setBizSt(String bizSt) {
		this.bizSt = bizSt;
	}

	public String getMngr() {
		return mngr;
	}

	public void setMngr(String mngr) {
		this.mngr = mngr;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getInqStrDtm() {
		return inqStrDtm;
	}

	public void setInqStrDtm(String inqStrDtm) {
		this.inqStrDtm = inqStrDtm;
	}

	public String getInqEndDtm() {
		return inqEndDtm;
	}

	public void setInqEndDtm(String inqEndDtm) {
		this.inqEndDtm = inqEndDtm;
	}

	public String getMemGb() {
		return memGb;
	}

	public void setMemGb(String memGb) {
		this.memGb = memGb;
	}

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}

	public String getReplGb() {
		return replGb;
	}

	public void setReplGb(String replGb) {
		this.replGb = replGb;
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}

	public String getGdsStat() {
		return gdsStat;
	}

	public void setGdsStat(String gdsStat) {
		this.gdsStat = gdsStat;
	}

	public String getDispYn() {
		return dispYn;
	}

	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}

	public Integer getUbiSlStrPrc() {
		return ubiSlStrPrc;
	}

	public void setUbiSlStrPrc(Integer ubiSlStrPrc) {
		this.ubiSlStrPrc = ubiSlStrPrc;
	}

	public Integer getUbiSlEndPrc() {
		return ubiSlEndPrc;
	}

	public void setUbiSlEndPrc(Integer ubiSlEndPrc) {
		this.ubiSlEndPrc = ubiSlEndPrc;
	}

	public String getOneDepth() {
		return oneDepth;
	}

	public void setOneDepth(String oneDepth) {
		this.oneDepth = oneDepth;
	}

	public String getTwoDepth() {
		return twoDepth;
	}

	public void setTwoDepth(String twoDepth) {
		this.twoDepth = twoDepth;
	}

	public String getThreeDepth() {
		return threeDepth;
	}

	public void setThreeDepth(String threeDepth) {
		this.threeDepth = threeDepth;
	}

	public String getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(String siteNo) {
		this.siteNo = siteNo;
	}

	public String getSidoNm() {
		return sidoNm;
	}

	public void setSidoNm(String sidoNm) {
		this.sidoNm = sidoNm;
	}

	public String getSigunguNm() {
		return sigunguNm;
	}

	public void setSigunguNm(String sigunguNm) {
		this.sigunguNm = sigunguNm;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getUbiGdsNo() {
		return ubiGdsNo;
	}

	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}

	public String getUbiGdsSize() {
		return ubiGdsSize;
	}

	public void setUbiGdsSize(String ubiGdsSize) {
		this.ubiGdsSize = ubiGdsSize;
	}

	public Integer getRownum() {
		return rownum;
	}

	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}

	public Integer getGdsInfoNo() {
		return gdsInfoNo;
	}

	public void setGdsInfoNo(Integer gdsInfoNo) {
		this.gdsInfoNo = gdsInfoNo;
	}

	public String getGdsInfoNm() {
		return gdsInfoNm;
	}

	public void setGdsInfoNm(String gdsInfoNm) {
		this.gdsInfoNm = gdsInfoNm;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getPerOrdStat() {
		return perOrdStat;
	}

	public void setPerOrdStat(String perOrdStat) {
		this.perOrdStat = perOrdStat;
	}

	public String getOrdStat() {
		return ordStat;
	}

	public void setOrdStat(String ordStat) {
		this.ordStat = ordStat;
	}

	public String getPayWay() {
		return payWay;
	}

	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	
	public String[] getPayWays() {
		return payWays;
	}

	public void setPayWays(String[] payWays) {
		this.payWays = payWays;
	}

	public String getBarnd() {
		return barnd;
	}

	public void setBarnd(String barnd) {
		this.barnd = barnd;
	}

	public String getSearchStrDtm() {
		return searchStrDtm;
	}

	public void setSearchStrDtm(String searchStrDtm) {
		this.searchStrDtm = searchStrDtm;
	}

	public String getSearchEndDtm() {
		return searchEndDtm;
	}

	public void setSearchEndDtm(String searchEndDtm) {
		this.searchEndDtm = searchEndDtm;
	}

	public String getNewsType() {
		return newsType;
	}

	public void setNewsType(String newsType) {
		this.newsType = newsType;
	}

	public String getTxtNo() {
		return txtNo;
	}

	public void setTxtNo(String txtNo) {
		this.txtNo = txtNo;
	}

	public String getDateType() {
		return dateType;
	}

	public void setDateType(String dateType) {
		this.dateType = dateType;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getCategoryGb() {
		return categoryGb;
	}

	public void setCategoryGb(String categoryGb) {
		this.categoryGb = categoryGb;
	}

	public String getCategoryText() {
		return categoryText;
	}

	public void setCategoryText(String categoryText) {
		this.categoryText = categoryText;
	}

	public String getOrdKnd() {
		return ordKnd;
	}

	public void setOrdKnd(String ordKnd) {
		this.ordKnd = ordKnd;
	}

	public String[] getOrdStats() {
		return ordStats;
	}

	public void setOrdStats(String[] ordStats) {
		this.ordStats = ordStats;
	}

	public String[] getSiteNos() {
		return siteNos;
	}

	public void setSiteNos(String[] siteNos) {
		this.siteNos = siteNos;
	}

	public String[] getPerOrdStats() {
		return perOrdStats;
	}

	public void setPerOrdStats(String[] perOrdStats) {
		this.perOrdStats = perOrdStats;
	}

	public String[] getBrands() {
		return brands;
	}
	
	public String[] getPayTps() {
		return payTps;
	}

	public void setPayTps(String[] payTps) {
		this.payTps = payTps;
	}

	public void setBrands(String[] brands) {
		this.brands = brands;
	}

	public boolean isSoldoutYn() {
		return soldoutYn;
	}

	public void setSoldoutYn(boolean soldoutYn) {
		this.soldoutYn = soldoutYn;
	}

	public boolean isDispYn2() {
		return dispYn2;
	}

	public void setDispYn2(boolean dispYn2) {
		this.dispYn2 = dispYn2;
	}

	public String[] getOrdGdsSeqs() {
		return ordGdsSeqs;
	}

	public void setOrdGdsSeqs(String[] ordGdsSeqs) {
		this.ordGdsSeqs = ordGdsSeqs;
	}
	public Integer getOrdGdsSeq() {
		return ordGdsSeq;
	}

	public void setOrdGdsSeq(Integer ordGdsSeq) {
		this.ordGdsSeq = ordGdsSeq;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String[] getCategoryTexts() {
		return categoryTexts;
	}

	public void setCategoryTexts(String[] categoryTexts) {
		this.categoryTexts = categoryTexts;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPayTp() {
		return payTp;
	}

	public void setPayTp(String payTp) {
		this.payTp = payTp;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public Integer getDlvCmpNo() {
		return dlvCmpNo;
	}

	public void setDlvCmpNo(Integer dlvCmpNo) {
		this.dlvCmpNo = dlvCmpNo;
	}

	public String getChgInvNo() {
		return chgInvNo;
	}

	public void setChgInvNo(String chgInvNo) {
		this.chgInvNo = chgInvNo;
	}

	public Integer getChgDlvCmpNo() {
		return chgDlvCmpNo;
	}

	public void setChgDlvCmpNo(Integer chgDlvCmpNo) {
		this.chgDlvCmpNo = chgDlvCmpNo;
	}

	public Date getSndCmplDts() {
		return sndCmplDts;
	}

	public void setSndCmplDts(Date sndCmplDts) {
		this.sndCmplDts = sndCmplDts;
	}

	public String getPayStat() {
		return payStat;
	}

	public void setPayStat(String payStat) {
		this.payStat = payStat;
	}

	public Integer getAddPayStrPrc() {
		return addPayStrPrc;
	}

	public void setAddPayStrPrc(Integer addPayStrPrc) {
		this.addPayStrPrc = addPayStrPrc;
	}

	public Integer getAddPayEndPrc() {
		return addPayEndPrc;
	}

	public void setAddPayEndPrc(Integer addPayEndPrc) {
		this.addPayEndPrc = addPayEndPrc;
	}

	public String getAddPayRsn() {
		return addPayRsn;
	}

	public void setAddPayRsn(String addPayRsn) {
		this.addPayRsn = addPayRsn;
	}

	public String[] getPayStats() {
		return payStats;
	}

	public void setPayStats(String[] payStats) {
		this.payStats = payStats;
	}

	public boolean isAllDay() {
		return allDay;
	}

	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}

	public String getOrdClmCls() {
		return ordClmCls;
	}

	public void setOrdClmCls(String ordClmCls) {
		this.ordClmCls = ordClmCls;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public String getMemYn() {
		return memYn;
	}

	public void setMemYn(String memYn) {
		this.memYn = memYn;
	}

	public String getIpAddr() {
		return ipAddr;
	}

	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}

	public String getSmsStrDtm() {
		return smsStrDtm;
	}

	public void setSmsStrDtm(String smsStrDtm) {
		this.smsStrDtm = smsStrDtm;
	}

	public String getSmsEndDtm() {
		return smsEndDtm;
	}

	public void setSmsEndDtm(String smsEndDtm) {
		this.smsEndDtm = smsEndDtm;
	}

	public String getNumGb() {
		return numGb;
	}

	public void setNumGb(String numGb) {
		this.numGb = numGb;
	}


	public Integer getMsgSeq() {
		return msgSeq;
	}

	public void setMsgSeq(Integer msgSeq) {
		this.msgSeq = msgSeq;
	}

	public Integer getCurState() {
		return curState;
	}

	public void setCurState(Integer curState) {
		this.curState = curState;
	}

	public String getSentDate() {
		return sentDate;
	}

	public void setSentDate(String sentDate) {
		this.sentDate = sentDate;
	}

	public String getRsltDate() {
		return rsltDate;
	}

	public void setRsltDate(String rsltDate) {
		this.rsltDate = rsltDate;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public Integer getRsltCode() {
		return rsltCode;
	}

	public void setRsltCode(Integer rsltCode) {
		this.rsltCode = rsltCode;
	}

	public String getRsltCode2() {
		return rsltCode2;
	}

	public void setRsltCode2(String rsltCode2) {
		this.rsltCode2 = rsltCode2;
	}

	public String getRsltNet() {
		return rsltNet;
	}

	public void setRsltNet(String rsltNet) {
		this.rsltNet = rsltNet;
	}

	public String getCallTo() {
		return callTo;
	}

	public void setCallTo(String callTo) {
		this.callTo = callTo;
	}

	public String getCallFrom() {
		return callFrom;
	}

	public void setCallFrom(String callFrom) {
		this.callFrom = callFrom;
	}

	public String getMsgTxt() {
		return msgTxt;
	}

	public void setMsgTxt(String msgTxt) {
		this.msgTxt = msgTxt;
	}

	public Integer getMsgType() {
		return msgType;
	}

	public void setMsgType(Integer msgType) {
		this.msgType = msgType;
	}

	public Integer getContSeq() {
		return contSeq;
	}

	public void setContSeq(Integer contSeq) {
		this.contSeq = contSeq;
	}	
	
	
	
	public Integer getSendGb() {
		return sendGb;
	}

	public void setSendGb(Integer sendGb) {
		this.sendGb = sendGb;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public boolean isStockZeroChk() {
		return stockZeroChk;
	}

	public void setStockZeroChk(boolean stockZeroChk) {
		this.stockZeroChk = stockZeroChk;
	}

	public boolean isImageUploadChk() {
		return imageUploadChk;
	}

	public void setImageUploadChk(boolean imageUploadChk) {
		this.imageUploadChk = imageUploadChk;
	}

	public String getEgnoreStat() {
		return egnoreStat;
	}

	public void setEgnoreStat(String egnoreStat) {
		this.egnoreStat = egnoreStat;
	}
	
	public Integer getsAge() {
		return sAge;
	}

	public void setsAge(Integer sAge) {
		this.sAge = sAge;
	}

	public Integer geteAge() {
		return eAge;
	}

	public void seteAge(Integer eAge) {
		this.eAge = eAge;
	}

	public String getClbltnNm() {
		return clbltnNm;
	}

	public void setClbltnNm(String clbltnNm) {
		this.clbltnNm = clbltnNm;
	}

	public String getTopBnnrDispYn() {
		return topBnnrDispYn;
	}

	public void setTopBnnrDispYn(String topBnnrDispYn) {
		this.topBnnrDispYn = topBnnrDispYn;
	}

	public String getEtcGdsNo() {
		return etcGdsNo;
	}

	public void setEtcGdsNo(String etcGdsNo) {
		this.etcGdsNo = etcGdsNo;
	}

	public String getSeasonCode() {
		return seasonCode;
	}

	public void setSeasonCode(String seasonCode) {
		this.seasonCode = seasonCode;
	}

	public String getRsvCls() {
		return rsvCls;
	}

	public void setRsvCls(String rsvCls) {
		this.rsvCls = rsvCls;
	}

	public String getOffLineEgnoreChk() {
		return offLineEgnoreChk;
	}

	public void setOffLineEgnoreChk(String offLineEgnoreChk) {
		this.offLineEgnoreChk = offLineEgnoreChk;
	}

	public boolean isNewArrival() {
		return newArrival;
	}

	public void setNewArrival(boolean newArrival) {
		this.newArrival = newArrival;
	}

	public String getBoardClcd() {
		return boardClcd;
	}

	public void setBoardClcd(String boardClcd) {
		this.boardClcd = boardClcd;
	}

	public Integer getImgSeq() {
		return imgSeq;
	}

	public void setImgSeq(Integer imgSeq) {
		this.imgSeq = imgSeq;
	}

	public String getCurSeason() {
		return curSeason;
	}

	public void setCurSeason(String curSeason) {
		this.curSeason = curSeason;
	}
	
	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getCategory1Code() {
		return category1Code;
	}

	public void setCategory1Code(String category1Code) {
		this.category1Code = category1Code;
	}

	public String getCategory2Code() {
		return category2Code;
	}

	public void setCategory2Code(String category2Code) {
		this.category2Code = category2Code;
	}

	public String getPreSeason() {
		return preSeason;
	}

	public void setPreSeason(String preSeason) {
		this.preSeason = preSeason;
	}

	public int getSeasonSeq() {
		return seasonSeq;
	}

	public void setSeasonSeq(int seasonSeq) {
		this.seasonSeq = seasonSeq;
	}

	public int getNowSeq() {
		return nowSeq;
	}

	public void setNowSeq(int nowSeq) {
		this.nowSeq = nowSeq;
	}

	public String getCateGubun() {
		return cateGubun;
	}

	public void setCateGubun(String cateGubun) {
		this.cateGubun = cateGubun;
	}

	public String getStockZeroGubun() {
		return stockZeroGubun;
	}

	public void setStockZeroGubun(String stockZeroGubun) {
		this.stockZeroGubun = stockZeroGubun;
	}

	public String getImageUploadGubun() {
		return imageUploadGubun;
	}

	public void setImageUploadGubun(String imageUploadGubun) {
		this.imageUploadGubun = imageUploadGubun;
	}

	public String getResultId() {
		return resultId;
	}

	public void setResultId(String resultId) {
		this.resultId = resultId;
	}

	public String getOffCpnNo() {
		return offCpnNo;
	}

	public void setOffCpnNo(String offCpnNo) {
		this.offCpnNo = offCpnNo;
	}

	public boolean isWeb() {
		return web;
	}

	public void setWeb(boolean web) {
		this.web = web;
	}

	public boolean isMobile() {
		return mobile;
	}

	public void setMobile(boolean mobile) {
		this.mobile = mobile;
	}

	public String getDepthCode() {
		return depthCode;
	}

	public void setDepthCode(String depthCode) {
		this.depthCode = depthCode;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
}

