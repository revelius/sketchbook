package com.giftiel.shop.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.ManageDao;
import com.giftiel.shop.dto.AuthGrp;
import com.giftiel.shop.dto.Awnes;
import com.giftiel.shop.dto.BoardGds;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.FeatureManage;
import com.giftiel.shop.dto.FeatureManageForm;
import com.giftiel.shop.dto.Goods;
import com.giftiel.shop.dto.Inquiry;
import com.giftiel.shop.dto.InquiryRepl;
import com.giftiel.shop.dto.IntgBoard;
import com.giftiel.shop.dto.IntgBoardCnts;
import com.giftiel.shop.dto.MailManage;
import com.giftiel.shop.dto.MainManage;
import com.giftiel.shop.dto.MainManageForm;
import com.giftiel.shop.dto.Menu;
import com.giftiel.shop.dto.News;
import com.giftiel.shop.dto.Operator;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.SmsMng;
import com.giftiel.shop.dto.User;
import com.giftiel.shop.dto.UserAuthGrp;
import com.giftiel.shop.dto.WorkWithUs;

@Service
public class ManageService {
	
	@Autowired
	private ManageDao manageDao;
	
//	@Value("#{setting['send.sms.no']}")
	private String sendSmsNo;	
	
	public int totalListInquiry(SearchForm searchForm) {
		int result = manageDao.totalListInquiry(searchForm);
		return result;
	}
	
	
	public List<Inquiry> inquiryList(SearchForm searchForm) {
		List<Inquiry> inquiry = manageDao.inquiryList(searchForm);
		return inquiry;
	}	
	
	public List<Inquiry> frontInquiryList(SearchForm searchForm) {
		List<Inquiry> inquiry = manageDao.frontInquiryList(searchForm);
		return inquiry;
	}
	
	
	public int totalListSmsSend(SearchForm searchForm) {
		int result = manageDao.totalListSmsSend(searchForm);
		return result;
	}
	
	
	public List<SmsMng> SmsMngList(SearchForm searchForm) {
		List<SmsMng> smsMng = manageDao.SmsMngList(searchForm);
		return smsMng;
	}
	
	public List<SmsMng> SmsMngTitleList(SearchForm searchForm) {
		List<SmsMng> smsMng = manageDao.SmsMngTitleList(searchForm);
		return smsMng;
	}
	
	public List<SmsMng> smsSendList(SearchForm searchForm) {
		List<SmsMng> smsMng = manageDao.smsSendList(searchForm);
		return smsMng;
	}
	
	public SmsMng smsDetail(int msgSeq) {
		SmsMng result = manageDao.smsDetail(msgSeq);
	    return result;
	}
	

	
	
	
	@Transactional(rollbackFor=Exception.class)
	public int smsInsert(SmsMng smsForm) {
		smsForm.setCallFrom(sendSmsNo);
		
	    int result = manageDao.smsInsert(smsForm);

	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int smsManageUpdate(List<SmsMng> smsMngListCompare) {
		int result = 0;
		for(SmsMng sm:smsMngListCompare){
			result += manageDao.smsManageUpdate(sm);
		}
		return result;
	}
	
	
	public Inquiry inquiryDetail(String cnslNo, int updrNo) {
		Inquiry inquiry = manageDao.inquiryDetail(cnslNo);
		int result = manageDao.updateInquiryStat("CM00702", updrNo, cnslNo);
		return inquiry;
	}
	
	
	
	public List<InquiryRepl> inquiryRepl(String cnslNo){
		List<InquiryRepl> inquiryRepl = manageDao.inquiryRepl(cnslNo);
		return inquiryRepl;
	}
	
	
	//1:1 reply(답변,추가문의) 등록 wrtrCls값 설정해 주세요 운영자:CM01001,사용자:CM01002
	@Transactional(rollbackFor=Exception.class)
	public int regInquiryRepl(InquiryRepl inquiryReplForm){
		int result = manageDao.regInquiryRepl(inquiryReplForm);
		String stat = inquiryReplForm.getWrtrCls().equals("CM01001")?"CM00703":"CM00701";
		result = manageDao.updateInquiryStat(stat, inquiryReplForm.getUpdrNo(), String.valueOf(inquiryReplForm.getCnslNo()));
		return result;
	}
	
	
	public int regInquiry(Inquiry inquiry){
		int result = manageDao.regInquiry(inquiry);
		return result;
	}
	
	
	public int totalListOperator(SearchForm searchForm) {
	    int result = manageDao.totalListOperator(searchForm);
	    return result;
	}
	
	
	public List<Operator> operatorList(SearchForm searchForm) {
		List<Operator> operator = manageDao.operatorList(searchForm);
		return operator;
	}
	
	
	public List<AuthGrp> authGrpList() {
		List<AuthGrp> authGrp = manageDao.authGrpList();
		List<HashMap<String,String>> hm = manageDao.authGrpTot();
		
		int size = authGrp.size();
		for(int cnt = 0 ; cnt < size; cnt++) {
			authGrp.get(cnt).setGrpTot(String.valueOf(hm.get(cnt).get("GRPTOT")));
		}
		
		return authGrp;
	}
	
	
	
	public int idDuplChk(String id) {
	    int result = manageDao.idDuplChk(id);
	    return result;
	}
	
	
	public int getUserNo() {
	    int result = manageDao.getUserNo();
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int regUser(User user, UserAuthGrp userAuthGrp) {
		//유저등록
	    int result = manageDao.regUser(user);
	    userAuthGrp.setUserNo(user.getIdx());
	    //권한 등록
	    if(userAuthGrp.getAuthGrpNo().length > 0){ //선택한 권한이 있으면
	    	result = manageDao.setUserAuthGrp(userAuthGrp);
	    }
	    
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int updateUser(User user, UserAuthGrp userAuthGrp) {
		//유저정보 수정
	    int result = manageDao.updateUser(user);
	    //권한 삭제
	    result = manageDao.deleteUserAuthGrp(userAuthGrp);
	    //권한 등록
	    if(userAuthGrp.getAuthGrpNo().length > 0){ //선택한 권한이 있으면
	    	result = manageDao.updateUserAuthGrp(userAuthGrp);
	    }
	    
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int delUser(User user, UserAuthGrp userAuthGrp) {
		//유저정보 삭제
	    int result = manageDao.delUser(user);
	    //권한 삭제
	    result = manageDao.delUserAuthGrp(userAuthGrp);
	    return result;
	}
	
	
	public User getUser(int userNo) {
		User user = manageDao.getUser(userNo);
	    return user;
	}
	
	

	
	
	public int totalListCollabo(SearchForm searchForm) {
	    int result = manageDao.totalListCollabo(searchForm);
	    return result;
	}
	
	
	
	
	public List<IntgBoard> collaboList(SearchForm searchForm) {
		List<IntgBoard> collaboration = manageDao.collaboList(searchForm);
		return collaboration;
	}
	
	
	public IntgBoard collaboDetail(int txtNo) {
		IntgBoard collaboration = manageDao.collaboDetail(txtNo);
		return collaboration;
	}
	
	
	
	
	public int collaboDelete(IntgBoard collabo) {
	    int result = manageDao.collaboDelete(collabo);
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int collaboUpdate(IntgBoard collabo) {
	    int result = manageDao.collaboUpdateBoard(collabo);
	    result = manageDao.collaboUpdateCnts(collabo);
	    return result;
	}
	
	
	
	@Transactional(rollbackFor=Exception.class)
	public int collaboReg(IntgBoard collabo) {
	    int result = manageDao.collaboRegBoard(collabo);
	    result = manageDao.collaboRegCnts(collabo);
	    return result;
	}
	
	
	public List<String> getCollabo() {
		List<String> result = manageDao.getCollabo();
	    return result;
	}
	
	
	public int totalListNews(SearchForm searchForm) {
	    int result = manageDao.totalListNews(searchForm);
	    return result;
	}
	
 
	public List<News> newsList(SearchForm searchForm) {
		List<News> news = manageDao.newsList(searchForm);
		return news;
	}
	
	public List<News> newsListFront(SearchForm searchForm) {
		List<News> news = manageDao.newsListFront(searchForm);
		return news;
	}	
	
	@Transactional(rollbackFor=Exception.class)
	public int regNewsProc(News newsForm) {
	    int result = manageDao.regNewsProc(newsForm);
	    if(newsForm.getNewsCont() != null){
	    	result = manageDao.regNewsCont(newsForm);
	    }
	    result = manageDao.regNewsSite(newsForm);
	    return result;
	}
	
	
	public News newsDetail(int txtNo) {
		News news = manageDao.newsDetail(txtNo);
		
		int size = news.getNewsSite().size();
		Integer[] siteNo = new Integer[size];
		for(int i=0;i<size;i++ ){
			siteNo[i] = news.getNewsSite().get(i).getSiteNo();
		}
		news.setSiteNo(siteNo);
		
		return news;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int updateNewsProc(News newsForm) {
		//뉴스등록
	    int result = manageDao.updateNewsProc(newsForm);
	    //뉴스 추가 컨텐츠 삭제
	    result = manageDao.deleteNewsCont(newsForm);
	    
	    if(newsForm.getNewsCont() != null){
	    	//뉴스 추가 컨텐츠 등록
	    	result = manageDao.regNewsCont(newsForm);
	    }
	    //뉴스사이트 삭제
	    result = manageDao.deleteNewsSite(newsForm);
	    //뉴스사이트 등록
	    result = manageDao.regNewsSite(newsForm);
	    return result;
	}
	
	
	
	@Transactional(rollbackFor=Exception.class)
	public int deleteNewsProc(News newsForm) {
	    //뉴스 삭제
	    int result = manageDao.deleteNewsProc(newsForm);
	    			 manageDao.deleteNewsCont(newsForm);
	    return result;
	}
	
	
	public int totalListLookbook(SearchForm searchForm) {
	    int result = manageDao.totalListLookbook(searchForm);
	    return result;
	}
	
	
	
	public List<IntgBoard> lookbookList(SearchForm searchForm) {
		List<IntgBoard> collaboration = manageDao.lookbookList(searchForm);
		return collaboration;
	}
	
	
	
	public IntgBoard lookbookDetail(int txtNo) {
		IntgBoard lookbook = manageDao.lookbookDetail(txtNo);
		return lookbook;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int lookbookReg(IntgBoard lookbook) {
	    int result = manageDao.regIntgBoard(lookbook);
	    
	    List<IntgBoardCnts> intgBoardCnts = lookbook.getIntgBoardCnts();
	    for(IntgBoardCnts ibc:intgBoardCnts){
	    	if(ibc.getImgUrl() != null){// 빈배열 제외
	    		ibc.setTxtNo(lookbook.getTxtNo());
		    	ibc.setRegrNo(lookbook.getRegrNo());
		    	ibc.setUpdrNo(lookbook.getUpdrNo());
		    	result = manageDao.regIntgBoardCnts(ibc);
		    	List<BoardGds> boardGds = ibc.getBoardGds();
		    	if(boardGds != null){// 빈배열 제외
			    	for(BoardGds bgs:boardGds){
			    		if(bgs.getSlPrc() != null){// 빈배열 제외
				    		bgs.setImgSeq(ibc.getImgSeq());
				    		result = manageDao.regBoardGds(bgs);
			    		}
			    	}
		    	}
	    	}
	    	
	    }
	    
	    
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int lookbookUpdate(IntgBoard lookbook) {
		IntgBoard tempIntgBoard = manageDao.lookbookDetail(lookbook.getTxtNo());
		
	    int result = manageDao.updateIntgBoard(lookbook);
	    
	    result = manageDao.deleteIntgBoardCnts(tempIntgBoard);
	    List<IntgBoardCnts> tempIntgBoardCnts = tempIntgBoard.getIntgBoardCnts();
	    for(IntgBoardCnts tibc:tempIntgBoardCnts){
	    	result = manageDao.deleteBoardGds(tibc);
	    }
	    
	    
	    List<IntgBoardCnts> intgBoardCnts = lookbook.getIntgBoardCnts();
	    for(IntgBoardCnts ibc:intgBoardCnts){
	    	if(ibc.getImgUrl() != null){// 빈배열 제외
		    	ibc.setTxtNo(lookbook.getTxtNo());
		    	ibc.setRegrNo(lookbook.getRegrNo());
		    	ibc.setUpdrNo(lookbook.getUpdrNo());
		    	result = manageDao.regIntgBoardCnts(ibc);
		    	List<BoardGds> boardGds = ibc.getBoardGds();
		    	
		    	if(boardGds != null){// 빈배열 제외
			    	for(BoardGds bgs:boardGds){
			    		if(bgs.getSlPrc() != null){// 빈배열 제외
			    			bgs.setImgSeq(ibc.getImgSeq());
				    		result = manageDao.regBoardGds(bgs);
			    		}
			    	}
		    	}
	    	}
	    }
	    return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int lookbookDel(IntgBoard lookbook) {
		IntgBoard tempIntgBoard = manageDao.lookbookDetail(lookbook.getTxtNo());
		
	    int result = manageDao.delelteIntgBoard(lookbook);
	    
	    result = manageDao.deleteIntgBoardCnts(tempIntgBoard);
	    List<IntgBoardCnts> tempIntgBoardCnts = tempIntgBoard.getIntgBoardCnts();
	    for(IntgBoardCnts tibc:tempIntgBoardCnts){
	    	manageDao.deleteBoardGds(tibc);
	    }
	    return result;
	}
	
	
	
	public String getSiteNm(int siteNo){
		String result = manageDao.getSiteNm(siteNo);
		return result;
	}
	
	
	public int getMaxMainNo(){
		int result = manageDao.getMaxMainNo();
		return result;
	}
	
	public int delMainNo(int targetMainNo){
		int result = manageDao.existMainNo(targetMainNo);
		if(result > 0){
			result = manageDao.delMainNo(targetMainNo);
		}else{
			result = 1;
		}
		
		return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int mainManageReg(MainManageForm mainManageForm) throws Exception{
		int result = 0;
		result = manageDao.mainManageDel(mainManageForm);
		List<MainManage> mainManageList = mainManageForm.getMainManage();
		for(MainManage mme:mainManageList){
			mme.setRegrNo(mainManageForm.getRegrNo());
			mme.setUpdrNo(mainManageForm.getUpdrNo());
			mme.setSiteNo(mainManageForm.getSiteNo());
			result = manageDao.mainManageReg(mme);
			if(result < 1) {
				throw new Exception();
			}
		}
		return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int featureManageReg(FeatureManageForm featureManageForm) throws Exception{
		int result = 0;
		List<FeatureManage> featureManageList = featureManageForm.getFeatureManage();
		for(FeatureManage fme:featureManageList){
			fme.setRegrNo(featureManageForm.getRegrNo());
			fme.setUpdrNo(featureManageForm.getUpdrNo());
			fme.setSiteNo(featureManageForm.getSiteNo());
			fme.setSex(featureManageForm.getSex());
			result = manageDao.featureManageReg(fme);
			if(result < 1) {
				throw new Exception();
			}
		}
		return result;
	}
	
	
	
	public List<MainManage> mainManageList(int siteNo){
		List<MainManage> mainManage = manageDao.mainManageList(siteNo);
		return mainManage;
	}
	
	
	public List<FeatureManage> featureManageList(int siteNo, String sex){
		List<FeatureManage> featureManage = manageDao.featureManageList(siteNo , sex);
		return featureManage;
	}
	
	
	
	public int delInquiry(Inquiry inquiry){
		int result = manageDao.delInquiry(inquiry);
		return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int delInquiryReply(InquiryRepl inquiryRepl) throws Exception{
		int result = manageDao.delInquiryReply(inquiryRepl);
		if(result < 1) {
			throw new Exception();
		}
		result = manageDao.updateInquiryStat("CM00703", inquiryRepl.getUpdrNo(), String.valueOf(inquiryRepl.getCnslNo()));
		return result;
	}
	
	public int modInquiry(Inquiry inquiry) throws Exception{
		int result = manageDao.modInquiry(inquiry);
		return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int modInquiryReply(InquiryRepl inquiryRepl) throws Exception{
		int result = manageDao.modInquiryReply(inquiryRepl);
		if(result < 1) {
			throw new Exception();
		}
		result = manageDao.updateInquiryStat("", inquiryRepl.getUpdrNo(), String.valueOf(inquiryRepl.getCnslNo()));
		return result;
	}
	
	public List<WorkWithUs> listWorkWithus(SearchForm searchForm) {
		List<WorkWithUs> workWithUs = manageDao.listWorkWithus(searchForm);
		return workWithUs;
	}
	
	public int totalListWorkWithus(SearchForm searchForm) {
		int result = manageDao.totalListWorkWithus(searchForm);
		return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int insertWorkWithus(WorkWithUs workWithUs) {
		int result = manageDao.insertWorkWithus(workWithUs);
		result = manageDao.insertWorkWithusSite(workWithUs);
		return result;
	}
	
	public WorkWithUs workWithUsDetail(int withusSeq) {
		WorkWithUs workWithUs = manageDao.workWithUsDetail(withusSeq);
		
		int size = workWithUs.getWorkWithUsSite().size();
		Integer[] siteNo = new Integer[size];
		for(int i=0;i<size;i++ ){
			siteNo[i] = workWithUs.getWorkWithUsSite().get(i).getSiteNo();
		}
		workWithUs.setSiteNo(siteNo);
		
		return workWithUs;
	}

	@Transactional(rollbackFor=Exception.class)
	
	public int updateWorkWithUs(WorkWithUs workWithUs) {
		//뉴스등록
	    int result = manageDao.updateWorkWithUs(workWithUs);

	    //뉴스사이트 삭제
	    result = manageDao.deleteWorkWithUsSite(workWithUs);
	    //뉴스사이트 등록
	    result = manageDao.insertWorkWithusSite(workWithUs);
	    return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int deleteWorkWithUsProc(WorkWithUs workWithUs) {
	    //뉴스 삭제
	    int result = manageDao.deleteWorkWithUsSite(workWithUs);
	    result = manageDao.deleteWorkWithUs(workWithUs);
	    return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int insertSndMail(MailManage mailManage){
		int result = manageDao.insertSndMail(mailManage);
		return result;
	}
	
	public List<MailManage> listSndMail(SearchForm searchForm){
		List<MailManage> listSndMail = manageDao.listSndMail(searchForm);
		return listSndMail;		
	}
	
	public MailManage mailSendDetail(int sndNo){
		MailManage mailManage = manageDao.mailSendDetail(sndNo);
		return mailManage;
	}
	
	public List<MailManage> mailMemGradeList(MailManage mailManage){
		List<MailManage> result = manageDao.mailMemGradeList(mailManage);
		return result;
	}

	public int totalListSndMail(SearchForm searchForm) {
	    int result = manageDao.totalListSndMail(searchForm);
	    return result;
	}
	
	public int chkDsp() {
	    int result = manageDao.chkDsp();
	    return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int obeyAwarenessReg(Awnes awnesForm) {
		int result = manageDao.awnesReg(awnesForm);
		result = manageDao.awnesContReg(awnesForm);
		return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int obeyAwarenessUpdate(Awnes awnesForm) {
		int result = manageDao.awnesUpdate(awnesForm);
		result = manageDao.awnesContDel(awnesForm);
		result = manageDao.awnesContReg(awnesForm);
		return result;
	}
	
	
	@Transactional(rollbackFor=Exception.class)
	public int obeyAwarenessDel(Awnes awnesForm) {
		int result = manageDao.awnesReg(awnesForm);
		result = manageDao.awnesContReg(awnesForm);
		return result;
	}
	
	
	
	//obey Awareness 리스트 총갯수
	public int totalListawnes(SearchForm searchForm) {
	    int result = manageDao.totalListawnes(searchForm);
	    return result;
	}
	
	//obey Awareness 리스트
	public List<Awnes> getAwnesList(SearchForm searchForm){
		List<Awnes> result = manageDao.getAwnesList(searchForm);
		return result;
	}
	
	
	public List<Awnes> getFrontAwnes(){
		List<Awnes> result = manageDao.getFrontAwnes();
		return result;
	}
	
	
	//obey Awareness 상세
	public Awnes getAwnes(int awnesNo){
		Awnes result = manageDao.getAwnes(awnesNo);
		return result;
	}	

	@Transactional(rollbackFor=Exception.class)
	public int insertCarharttRadio(CarharttRadioForm carharttRadioForm) {
		int result = manageDao.insertCarharttRadio(carharttRadioForm);
		return result;
	}
	public int totalListCarharttRadio(SearchForm searchForm){
		int result = manageDao.totalListCarharttRadio(searchForm);
		return result;
	}
	public List<CarharttRadioForm> carharttRadioList(SearchForm searchForm){
		List<CarharttRadioForm> result = manageDao.carharttRadioList(searchForm);
		return result;
	}
	public CarharttRadioForm carharttRadioDetail(int radioNo){
		CarharttRadioForm result = manageDao.carharttRadioDetail(radioNo);
		return result;
	}
	public int carharttRadioUpdate(CarharttRadioForm carharttRadioForm){
		int result = manageDao.carharttRadioUpdate(carharttRadioForm);
		return result;
	}
	public int carharttRadioDelete(CarharttRadioForm carharttRadioForm){
		int result = manageDao.carharttRadioDelete(carharttRadioForm);
		return result;
	}
	
	public List<Menu> currentAuthMenu(int userNo) {
		List<Menu> menu = manageDao.currentAuthMenu(userNo);
	    return menu;
	}
	
	/**
	 * 게시판 결과 수
	 * @param searchForm
	 * @return
	 */
	public int totalBoardCnt(SearchForm searchForm) {
	    int result = manageDao.totalBoardCnt(searchForm);
	    return result;
	}
	
	/**
	 * 게시판 리스트
	 * @param searchForm
	 * @return
	 */
	public List<IntgBoard> boardList(SearchForm searchForm) {
		List<IntgBoard> boardList = manageDao.boardList(searchForm);
		return boardList;
	}
	
	/**
	 * 게시판 입력
	 * @param collabo
	 * @return
	 */
	public int insertBoard(IntgBoard board) {
	    int result = manageDao.insertBoard(board);
	    result = manageDao.collaboRegCnts(board);
	    return result;
	}
	
	public int regBoardGds(BoardGds boardGds) {
		int	result = manageDao.regBoardGds(boardGds);
	    return result;
	}	
	
	public List<Goods> listSpecialGoods(SearchForm searchForm) {
		List<Goods> boardGdsList = manageDao.listSpecialGoods(searchForm);
		return boardGdsList;
	}
	
	public int updateSpecialSort(BoardGds boardGds) {
		int result = manageDao.updateSpecialSort(boardGds);
		return result;
	}
	
	public int updateInquiryRepl(InquiryRepl inquiryRepl) {
		int result = manageDao.updateInquiryRepl(inquiryRepl);
		return result;
	}	
	
	public int deleteInquiryRepl(InquiryRepl inquiryRepl) {
		int result = manageDao.deleteInquiryRepl(inquiryRepl);
		return result;
	}		
}