package com.giftiel.shop.dto;



public class SmsMng {
	private Integer rnum;        //번호
	private Integer totalCnt;        //총 갯수
	private Integer startListNum;        //페이징 시작번호
	private Integer endListNum;        //페이징 끝번호
	private Integer mngNo;         //관리번호 
	private String mngTitle;         //관리제목 
	private String smsTxt;         //SMS내용 
	private Integer regrNo;         //등록자 
	private String regDts;         //등록일시 
	private Integer updrNo;         //수정자 
	private String updDts;         //수정일시 
	private String sndCls;         //발송주체구분 
	private String autoCls;         //자동발송여부 
	
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
	//private String smsTxt;			//SMS용 메시지본문
	private Integer msgType;		//메시지의 TYPE(4: SMS 전송 ,5: URL 전송 ,6: MMS전송 , 7: BARCODE전송)
	private Integer contSeq;		//MMS의 컨텐츠 Key(MMS_CONTENTS_INFO의 CONT_SEQ)
	
	
	private String sendGb;    
	private String rsvTgGb;         //수신대상구분
	private String rsvTg;         	//수신대상 
	
	private String getBrnd;			// 브랜드명
	private String getMem;			// 등급명
	private String regUserNm;		//작성자 명
	
	

	private String mngSelect;
	
	
	
//	private List<SmsMng> smsMngList;
	

	//	public List<SmsMng> getSmsMngList() {
//		return smsMngList;
//	}
//	public void setSmsMngList(List<SmsMng> smsMngList) {
//		this.smsMngList = smsMngList;
//	}
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
	public Integer getMngNo() {
		return mngNo;
	}
	public void setMngNo(Integer mngNo) {
		this.mngNo = mngNo;
	}
	public String getMngTitle() {
		return mngTitle;
	}
	public void setMngTitle(String mngTitle) {
		this.mngTitle = mngTitle;
	}
	public String getSmsTxt() {
		return smsTxt;
	}
	public void setSmsTxt(String smsTxt) {
		this.smsTxt = smsTxt;
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
	public String getSndCls() {
		return sndCls;
	}
	public void setSndCls(String sndCls) {
		this.sndCls = sndCls;
	}
	public String getAutoCls() {
		return autoCls;
	}
	public void setAutoCls(String autoCls) {
		this.autoCls = autoCls;
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
	
	public String getSendGb() {
		return sendGb;
	}
	public void setSendGb(String sendGb) {
		this.sendGb = sendGb;
	}
	
	public String getRsvTgGb() {
		return rsvTgGb;
	}
	public void setRsvTgGb(String rsvTgGb) {
		this.rsvTgGb = rsvTgGb;
	}
	public String getRsvTg() {
		return rsvTg;
	}
	public void setRsvTg(String rsvTg) {
		this.rsvTg = rsvTg;
	}
	public String getGetBrnd() {
		return getBrnd;
	}
	public void setGetBrnd(String getBrnd) {
		this.getBrnd = getBrnd;
	}
	public String getGetMem() {
		return getMem;
	}
	public void setGetMem(String getMem) {
		this.getMem = getMem;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	public String getMngSelect() {
		return mngSelect;
	}
	public void setMngSelect(String mngSelect) {
		this.mngSelect = mngSelect;
	}
	
	
}
