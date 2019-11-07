package com.giftiel.shop.dto;

public class StatisticsForm {
	
	private Integer rnum;        		//번호
	private Integer totalCnt;        	//총 갯수
	private Integer startListNum;       //페이징 시작번호
	private Integer endListNum;        	//페이징 끝번호
	private Integer connSeq;         	//접속통계번호 
	private String connDtm;         	//접속일시 
	private String connIpAddr;         	//접속아이피 
	private Integer connBrnd;         	//브랜드 
	private String connDomain;         	//접속경로 
	private String connBrws;         	//브라우저 
	private String connOs;         		//OS 
	private Integer regrNo;         	//등록자 
	private String regDts;         		//등록일시 
	private Integer updrNo;         	//수정자 
	private String updDts;         		//수정일시
	private String brndNm;				//브랜드이름
	private Integer visitCnt;			//카운팅수
	
	//남여비율통계
	private String firstColumn;			//구분
    private String sexCnt;				//회원수
    private String newSex;				//신규회원
    private String benSex;				//탈퇴회원
	private String totAvg;				//회원비율
	
	//성별통계
	private String ageCnt;
	
	//거주지통계
	private String areaCnt;
	private String guGun;

	//적립금통계
	private String totPay;		//판매금액
	private String memGradeDc;	//회원할인
	private String totPoint;	//포인트적립
	private String usePoint;	//포인트사용
	
	//매출 통계
	private String ordDts;	//주문일
	private Integer ordCnt;	//주문수
	private long slPrc;	//주문액
	private Integer cancelCnt;	//취소수
	private long cancelSlPrc;	//취소액
	private Integer actlCnt;	//매출액
	private long expPnt;	//적립포인트
	private long usePnt;	//사용포인트
	private long actlDlvCst;	//배송비
	private long actlPayPrc;	//결재액
	private long sumPrc;	//총매출
	private long sumPayPrc;	//총매출(실결제)
	
	
	private String seasonGroupCode;	//시즌코드
	private String category1Code;	//카테고리1
	private String category2Code;	//카테고리2
	private String ubiGdsNo;	//상품코드
	private String ubiGdsNm;	//상품명
	private String color;	//색상
	private String size;	//사이즈
	
	private String nm;	//회원명
	private String email;	//email 계정
	private Integer age;	//나이
	private String sex;	//성별
	private String memGrdNo;	//회원등급
	private String ordrBsAddr;	//주소
	private Integer memNo;         //회원번호 
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
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
		return endListNum;
	}
	public void setEndListNum(Integer endListNum) {
		this.endListNum = endListNum;
	}
	public Integer getConnSeq() {
		return connSeq;
	}
	public void setConnSeq(Integer connSeq) {
		this.connSeq = connSeq;
	}
	public String getConnDtm() {
		return connDtm;
	}
	public void setConnDtm(String connDtm) {
		this.connDtm = connDtm;
	}
	public String getConnIpAddr() {
		return connIpAddr;
	}
	public void setConnIpAddr(String connIpAddr) {
		this.connIpAddr = connIpAddr;
	}
	public Integer getConnBrnd() {
		return connBrnd;
	}
	public void setConnBrnd(Integer connBrnd) {
		this.connBrnd = connBrnd;
	}
	public String getConnDomain() {
		return connDomain;
	}
	public void setConnDomain(String connDomain) {
		this.connDomain = connDomain;
	}
	public String getConnBrws() {
		return connBrws;
	}
	public void setConnBrws(String connBrws) {
		this.connBrws = connBrws;
	}
	public String getConnOs() {
		return connOs;
	}
	public void setConnOs(String connOs) {
		this.connOs = connOs;
	}
	public Integer getRegrNo() {
		return regrNo;
	}
	public void setRegrNo(Integer regrNo) {
		this.regrNo = regrNo;
	}
	public String getRegDts() {
		return regDts;
	}
	public void setRegDts(String regDts) {
		this.regDts = regDts;
	}
	public Integer getUpdrNo() {
		return updrNo;
	}
	public void setUpdrNo(Integer updrNo) {
		this.updrNo = updrNo;
	}
	public String getUpdDts() {
		return updDts;
	}
	public void setUpdDts(String updDts) {
		this.updDts = updDts;
	}
	public String getBrndNm() {
		return brndNm;
	}
	public void setBrndNm(String brndNm) {
		this.brndNm = brndNm;
	}
	public Integer getVisitCnt() {
		return visitCnt;
	}
	public void setVisitCnt(Integer visitCnt) {
		this.visitCnt = visitCnt;
	}
	public String getFirstColumn() {
		return firstColumn;
	}
	public void setFirstColumn(String firstColumn) {
		this.firstColumn = firstColumn;
	}
	public String getSexCnt() {
		return sexCnt;
	}
	public void setSexCnt(String sexCnt) {
		this.sexCnt = sexCnt;
	}
	public String getNewSex() {
		return newSex;
	}
	public void setNewSex(String newSex) {
		this.newSex = newSex;
	}
	public String getBenSex() {
		return benSex;
	}
	public void setBenSex(String benSex) {
		this.benSex = benSex;
	}
	public String getTotAvg() {
		return totAvg;
	}
	public void setTotAvg(String totAvg) {
		this.totAvg = totAvg;
	}
	public String getAgeCnt() {
		return ageCnt;
	}
	public void setAgeCnt(String ageCnt) {
		this.ageCnt = ageCnt;
	}
	public String getAreaCnt() {
		return areaCnt;
	}
	public void setAreaCnt(String areaCnt) {
		this.areaCnt = areaCnt;
	}
	public String getGuGun() {
		return guGun;
	}
	public void setGuGun(String guGun) {
		this.guGun = guGun;
	}
	public String getTotPay() {
		return totPay;
	}
	public void setTotPay(String totPay) {
		this.totPay = totPay;
	}
	public String getMemGradeDc() {
		return memGradeDc;
	}
	public void setMemGradeDc(String memGradeDc) {
		this.memGradeDc = memGradeDc;
	}
	public String getTotPoint() {
		return totPoint;
	}
	public void setTotPoint(String totPoint) {
		this.totPoint = totPoint;
	}
	public String getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}
	public String getOrdDts() {
		return ordDts;
	}
	public void setOrdDts(String ordDts) {
		this.ordDts = ordDts;
	}
	public Integer getOrdCnt() {
		return ordCnt;
	}
	public void setOrdCnt(Integer ordCnt) {
		this.ordCnt = ordCnt;
	}
	public long getSlPrc() {
		return slPrc;
	}
	public void setSlPrc(long slPrc) {
		this.slPrc = slPrc;
	}
	public Integer getCancelCnt() {
		return cancelCnt;
	}
	public void setCancelCnt(Integer cancelCnt) {
		this.cancelCnt = cancelCnt;
	}
	public long getCancelSlPrc() {
		return cancelSlPrc;
	}
	public void setCancelSlPrc(long cancelSlPrc) {
		this.cancelSlPrc = cancelSlPrc;
	}
	public Integer getActlCnt() {
		return actlCnt;
	}
	public void setActlCnt(Integer actlCnt) {
		this.actlCnt = actlCnt;
	}
	public long getExpPnt() {
		return expPnt;
	}
	public void setExpPnt(long expPnt) {
		this.expPnt = expPnt;
	}
	public long getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(long usePnt) {
		this.usePnt = usePnt;
	}
	public long getActlDlvCst() {
		return actlDlvCst;
	}
	public void setActlDlvCst(long actlDlvCst) {
		this.actlDlvCst = actlDlvCst;
	}
	public long getActlPayPrc() {
		return actlPayPrc;
	}
	public void setActlPayPrc(long actlPayPrc) {
		this.actlPayPrc = actlPayPrc;
	}
	public long getSumPrc() {
		return sumPrc;
	}
	public void setSumPrc(long sumPrc) {
		this.sumPrc = sumPrc;
	}
	public long getSumPayPrc() {
		return sumPayPrc;
	}
	public void setSumPayPrc(long sumPayPrc) {
		this.sumPayPrc = sumPayPrc;
	}
	public String getSeasonGroupCode() {
		return seasonGroupCode;
	}
	public void setSeasonGroupCode(String seasonGroupCode) {
		this.seasonGroupCode = seasonGroupCode;
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
	public String getUbiGdsNo() {
		return ubiGdsNo;
	}
	public void setUbiGdsNo(String ubiGdsNo) {
		this.ubiGdsNo = ubiGdsNo;
	}
	public String getUbiGdsNm() {
		return ubiGdsNm;
	}
	public void setUbiGdsNm(String ubiGdsNm) {
		this.ubiGdsNm = ubiGdsNm;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMemGrdNo() {
		return memGrdNo;
	}
	public void setMemGrdNo(String memGrdNo) {
		this.memGrdNo = memGrdNo;
	}
	public String getOrdrBsAddr() {
		return ordrBsAddr;
	}
	public void setOrdrBsAddr(String ordrBsAddr) {
		this.ordrBsAddr = ordrBsAddr;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}
	
		
}
