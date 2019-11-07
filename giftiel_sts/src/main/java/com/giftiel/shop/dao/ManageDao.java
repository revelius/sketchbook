package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.AuthGrp;
import com.giftiel.shop.dto.Awnes;
import com.giftiel.shop.dto.BoardGds;
import com.giftiel.shop.dto.CarharttRadioForm;
import com.giftiel.shop.dto.FeatureManage;
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

@Repository
public class ManageDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private SqlSession mapper;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public int totalListInquiry(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListInquiry", searchForm);
	    return result;
	}
	

	public List<Inquiry> inquiryList(SearchForm searchForm) {
		List<Inquiry> inquiry = sqlSession.selectList("manage.inquiryList", searchForm);
		return inquiry;
	}
	
	public List<Inquiry> frontInquiryList(SearchForm searchForm) {
		List<Inquiry> inquiry = sqlSession.selectList("manage.frontInquiryList", searchForm);
		return inquiry;
	}
	
	
	public int totalListSmsSend(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListSmsSend", searchForm);
	    return result;
	}
	
	public List<SmsMng> SmsMngList(SearchForm searchForm) {
		List<SmsMng> smsMng = sqlSession.selectList("manage.SmsMngList", searchForm);
		return smsMng;
	}
	
	public List<SmsMng> SmsMngTitleList(SearchForm searchForm){
		List<SmsMng> smsMng = sqlSession.selectList("manage.SmsMngTitleList", searchForm);
		return smsMng;
	}
	
	public SmsMng SmsMngDetail(Integer mngNo) {
		SmsMng smsMng = sqlSession.selectOne("manage.SmsMngDetail", mngNo);
		return smsMng;
	}
	
	public List<SmsMng> smsSendList(SearchForm searchForm) {
		List<SmsMng> smsMng = sqlSession.selectList("manage.smsSendList", searchForm);
		return smsMng;
	}
	
	
	public int smsSend(SmsMng smsMng) {
	    int result = sqlSession.insert("manage.SmsSend", smsMng);
	    return result;
	}
	
	public SmsMng smsDetail(int msgSeq) {
		SmsMng smsMng = sqlSession.selectOne("manage.smsDetail", msgSeq);
		return smsMng;
	}
	
	
		
	public Inquiry inquiryDetail(String cnslNo) {
		Inquiry inquiry = sqlSession.selectOne("manage.inquiryDetail", cnslNo);
		return inquiry;
	}
	
	
	public List<InquiryRepl> inquiryRepl(String cnslNo){
		List<InquiryRepl> inquiryRepl = sqlSession.selectList("manage.inquiryRepl", cnslNo);
		return inquiryRepl;
	}
	
	
	public int regInquiryRepl(InquiryRepl inquiryReplForm){
		int result = sqlSession.insert("manage.regInquiryRepl", inquiryReplForm);
		return result;
	}
	
	public int updateInquiryStat(String stat, int updrNo, String cnslNo){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("stat", stat);
		map.put("updrNo", updrNo);
		map.put("cnslNo", cnslNo);
		
		int result = sqlSession.update("manage.updateInquiryStat", map);
		return result;
	}
	
	public int regInquiry(Inquiry inquiry){
		int result = sqlSession.insert("manage.regInquiry", inquiry);
		return result;
	}
	
	
	public int totalListOperator(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListOperator", searchForm);
	    return result;
	}
	

	public List<Operator> operatorList(SearchForm searchForm) {
		List<Operator> operator = sqlSession.selectList("manage.operatorList", searchForm);
		return operator;
	}
	
	
	
	public List<AuthGrp> authGrpList() {
		List<AuthGrp> authGrp = sqlSession.selectList("manage.authGrpList");
		return authGrp;
	}
	
	public List<HashMap<String,String>> authGrpTot() {
		List<HashMap<String,String>> hm = sqlSession.selectList("manage.authGrpTot");
		return hm;
	}
	
	
	public int idDuplChk(String id) {
	    int result = sqlSession.selectOne("manage.idDuplChk", id);
	    return result;
	}
	
	
	
	
	public int getUserNo() {
	    int result = sqlSession.selectOne("manage.getUserNo");
	    return result;
	}
	
	
	
	public int setUserAuthGrp(UserAuthGrp userAuthGrp) {
	    int result = sqlSession.insert("manage.setUserAuthGrp", userAuthGrp);
	    return result;
	}
	
	
	public int regUser(User user) {
	    int result = sqlSession.insert("manage.regUser", user);
	    return result;
	}
	
	
	public User getUser(int userNo) {
		User user = sqlSession.selectOne("manage.getUser", userNo);
		
		List<Integer> TempAuthGrpNo = sqlSession.selectList("manage.getUserGrpNo", userNo);
		Integer[] authGrpNo = TempAuthGrpNo.toArray (new Integer [TempAuthGrpNo.size ()]);
		user.setAuthGrpNo(authGrpNo);
	    return user;
	}
	
	
	
	public int deleteUserAuthGrp(UserAuthGrp userAuthGrp) {
		int result = sqlSession.delete("manage.deleteUserAuthGrp", userAuthGrp.getUserNo());
		return result;
	}
	
	public int updateUserAuthGrp(UserAuthGrp userAuthGrp) {
	    int result = sqlSession.insert("manage.setUserAuthGrp", userAuthGrp);
	    return result;
	}
	
	public int updateUser(User user) {
	    int result = sqlSession.update("manage.updateUser", user);
	    return result;
	}
	
	public int delUser(User user) {
	    int result = sqlSession.delete("manage.delUser", user);
	    return result;
	}
	
	public int delUserAuthGrp(UserAuthGrp userAuthGrp) {
		int result = sqlSession.delete("manage.deleteUserAuthGrp", userAuthGrp.getUserNo());
	    return result;
	}
	
	
	public int smsManageUpdate(SmsMng smsMng) {
	    int result = sqlSession.update("manage.smsManageUpdate", smsMng);
	    return result;
	}
	
	public int smsInsert(SmsMng smsMng) {
	    int result = sqlSession.insert("manage.smsInsert", smsMng);
	    return result;
	}
	
	
	public int totalListCollabo(SearchForm searchForm) {
		int result = sqlSession.selectOne("manage.totalListCollabo", searchForm);
	    return result;
	}
	
	public List<IntgBoard> collaboList(SearchForm searchForm) {
		List<IntgBoard> collaboration = sqlSession.selectList("manage.collaboList", searchForm);
		return collaboration;
	}
	
	public IntgBoard collaboDetail(int txtNo) {
		IntgBoard collaboration = sqlSession.selectOne("manage.collaboDetail", txtNo);
		return collaboration;
	}
	
	public int collaboDelete(IntgBoard collabo) {
	    int result = sqlSession.delete("manage.collaboDelete", collabo);
	    return result;
	}
	
	public int collaboUpdateBoard(IntgBoard collabo) {
	    int result = sqlSession.update("manage.collaboUpdateBoard", collabo);
	    return result;
	}
	
	public int collaboUpdateCnts(IntgBoard collabo) {
	    int result = sqlSession.update("manage.collaboUpdateCnts", collabo);
	    return result;
	}
	
	public int collaboRegBoard(IntgBoard collabo) {
	    int result = sqlSession.insert("manage.collaboRegBoard", collabo);
	    return result;
	}
	
	public int collaboRegCnts(IntgBoard collabo) {
	    int result = sqlSession.insert("manage.collaboRegCnts", collabo);
	    return result;
	}
	
	
	public List<String> getCollabo() {
		List<String> result = sqlSession.selectList("manage.getCollabo");
	    return result;
	}
	
	
	public int totalListNews(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListNews", searchForm);
	    return result;
	}
	
	
	public List<News> newsList(SearchForm searchForm) {
		List<News> news = sqlSession.selectList("manage.newsList", searchForm);
		return news;
	}
	
	//@Cacheable(value="topNewsList", key="{#searchForm.siteNo}")
	public List<News> newsListFront(SearchForm searchForm) {
		List<News> news = sqlSession.selectList("manage.newsList", searchForm);
		return news;
	}
	
	
	public int regNewsProc(News newsForm) {
	    int result = sqlSession.insert("manage.regNewsProc", newsForm);
	    return result;
	}
	
	
	public int regNewsCont(News newsForm) {
		int result = sqlSession.insert("manage.regNewsCont", newsForm);
		return result;
	}
	
	
	public int regNewsSite(News newsForm) {
		int result = sqlSession.insert("manage.regNewsSite", newsForm);
		return result;
	}
	
	
	public News newsDetail(int txtNo) {
		News news = sqlSession.selectOne("manage.newsDetail", txtNo);
		return news;
	}
	
	
	
	public int updateNewsProc(News newsForm) {
	    int result = sqlSession.update("manage.updateNewsProc", newsForm);
	    return result;
	}
	
	
	public int deleteNewsSite(News newsForm) {
		int result = sqlSession.delete("manage.deleteNewsSite", newsForm);
		return result;
	}
	
	public int deleteNewsProc(News newsForm) {
		int result = sqlSession.delete("manage.deleteNewsProc", newsForm);
		return result;
	}
	
	
	public int deleteNewsCont(News newsForm) {
		int result = sqlSession.delete("manage.deleteNewsCont", newsForm);
		return result;
	}
	
	public int totalListLookbook(SearchForm searchForm) {
		int result = sqlSession.selectOne("manage.totalListLookbook", searchForm);
	    return result;
	}
	
	public List<IntgBoard> lookbookList(SearchForm searchForm) {
		List<IntgBoard> collaboration = sqlSession.selectList("manage.lookbookList", searchForm);
		return collaboration;
	}
	
	public IntgBoard lookbookDetail(int txtNo) {
		IntgBoard lookbook = sqlSession.selectOne("manage.lookbookDetail", txtNo);
		return lookbook;
	}
	
	
	public int regIntgBoard(IntgBoard lookbook) {
		int result = sqlSession.insert("manage.regIntgBoard", lookbook);
		return result;
	}
	
	public int regIntgBoardCnts(IntgBoardCnts lookbook) {
		int result = sqlSession.insert("manage.regIntgBoardCnts", lookbook);
		return result;
	}
	
	public int regBoardGds(BoardGds lookbook) {
		int result = sqlSession.insert("manage.regBoardGds", lookbook);
		return result;
	}
	
	
	public int updateIntgBoard(IntgBoard lookbook) {
		int result = sqlSession.update("manage.updateIntgBoard", lookbook);
		return result;
	}
	
	
	public int delelteIntgBoard(IntgBoard lookbook) {
		int result = sqlSession.delete("manage.delelteIntgBoard", lookbook);
		return result;
	}
	
	public int deleteIntgBoardCnts(IntgBoard lookbook) {
		int result = sqlSession.delete("manage.deleteIntgBoardCnts", lookbook);
		return result;
	}
	
	public int deleteBoardGds(IntgBoardCnts lookbook) {
		int result = sqlSession.delete("manage.deleteBoardGds", lookbook);
		return result;
	}
	
	public String getSiteNm(int siteNo){
		String result = sqlSession.selectOne("manage.getSiteNm", siteNo);
		return result;
	}
	
	
	public int getMaxMainNo(){
		int result = sqlSession.selectOne("manage.getMaxMainNo");
		return result;
	}
	
	public int existMainNo(int targetMainNo){
		int result = sqlSession.selectOne("manage.existMainNo", targetMainNo);
		return result;
	}
	
	
	public int delMainNo(int targetMainNo){
		int result = sqlSession.delete("manage.delMainNo", targetMainNo);
		return result;
	}
	
	public int mainManageReg(MainManage mainManage){
		int result = sqlSession.update("manage.mainManageReg", mainManage);
		return result;
	}
	
	
	public int mainManageDel(MainManageForm mainManageForm){
		int result = sqlSession.update("manage.mainManageDel", mainManageForm);
		return result;
	}
	
	public int featureManageReg(FeatureManage featureManage){
		int result = sqlSession.update("manage.featureManageReg", featureManage);
		return result;
	}
	
	
	public List<MainManage> mainManageList(int siteNo){
		List<MainManage> mainManage = sqlSession.selectList("manage.mainManageList", siteNo);
		return mainManage;
	}
	
	public List<FeatureManage> featureManageList(int siteNo, String sex){
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("siteNo", siteNo);
		hm.put("sex", sex);
		List<FeatureManage> featureManage = sqlSession.selectList("manage.featureManageList", hm);
		return featureManage;
	}
	
	
	public int delInquiry(Inquiry inquiry){
		int result = sqlSession.delete("manage.delInquiry", inquiry);
		return result;
	}
	
	
	public int delInquiryReply(InquiryRepl inquiryRepl){
		int result = sqlSession.delete("manage.delInquiryReply", inquiryRepl);
		return result;
	}
	
	
	public int modInquiry(Inquiry inquiry){
		int result = sqlSession.update("manage.modInquiry", inquiry);
		return result;
	}
	
	
	public int modInquiryReply(InquiryRepl inquiryRepl){
		int result = sqlSession.update("manage.modInquiryReply", inquiryRepl);
		return result;
	}
	
	
	
	public List<WorkWithUs> listWorkWithus(SearchForm searchForm) {
	    List<WorkWithUs> result = sqlSession.selectList("manage.listWorkWithus", searchForm);
	    return result;
	}
	public int totalListWorkWithus(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListWorkWithus", searchForm);
	    return result;
	}
	public int insertWorkWithus(WorkWithUs workWithUs) {
		int result = sqlSession.insert("manage.insertWorkWithus", workWithUs);
		return result;
	}
	
	public int insertWorkWithusSite(WorkWithUs workWithUs){
		int result = sqlSession.insert("manage.insertWorkWithusSite",workWithUs);
		return result;
	}
	
	public WorkWithUs workWithUsDetail(int withusSeq) {
		WorkWithUs workWithUs = sqlSession.selectOne("manage.workWithUsDetail", withusSeq);
		return workWithUs;
	} 

	public int updateWorkWithUs(WorkWithUs workWithUs) {
	    int result = sqlSession.update("manage.updateWorkWithUs", workWithUs);
	    return result;
	}
	public int deleteWorkWithUs(WorkWithUs workWithUs) {
	    int result = sqlSession.delete("manage.deleteWorkWithUs", workWithUs);
	    return result;
	}	
	public int deleteWorkWithUsSite(WorkWithUs workWithUs) {
	    int result = sqlSession.delete("manage.deleteWorkWithUsSite", workWithUs);
	    return result;
	}	
	public int insertSndMail(MailManage mailManage){
		int result = sqlSession.insert("manage.insertSndMail",mailManage);
		return result;
	}
	
	public List<MailManage> listSndMail(SearchForm searchForm) {
	    List<MailManage> result = sqlSession.selectList("manage.listSndMail", searchForm);
	    return result;
	}
	
	public MailManage mailSendDetail(int sndNo){
		MailManage mailManage = sqlSession.selectOne("manage.mailSendDetail", sndNo);
		return mailManage;
	}
	
	public List<MailManage> mailMemGradeList(MailManage mailManage){
		List<MailManage> result = sqlSession.selectList("manage.mailMemGradeList", mailManage);
		return result;
	}

	public int totalListSndMail(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListSndMail", searchForm);
	    return result;
	}	
	
	public int chkDsp() {
	    int result = sqlSession.selectOne("manage.chkDsp");
	    return result;
	}
	
	
	public int awnesReg(Awnes awnesForm) {
	    int result = sqlSession.insert("manage.awnesReg",awnesForm);
	    return result;
	}
	
	public int awnesUpdate(Awnes awnesForm) {
		int result = sqlSession.update("manage.awnesUpdate",awnesForm);
		return result;
	}
	
	
	public int awnesContReg(Awnes awnesForm) {
	    int result = sqlSession.insert("manage.awnesContReg",awnesForm);
	    return result;
	}
	
	
	public int awnesContDel(Awnes awnesForm) {
	    int result = sqlSession.delete("manage.awnesContDel",awnesForm);
	    return result;
	}
	
	
	//obey Awareness 리스트 총갯수
	public int totalListawnes(SearchForm searchForm) {
	    int result = sqlSession.selectOne("manage.totalListawnes", searchForm);
	    return result;
	}
	
	
	//obey Awareness 리스트
	public List<Awnes> getAwnesList(SearchForm searchForm){
		List<Awnes> result = sqlSession.selectList("manage.getAwnesList", searchForm);
		return result;
	}
	
	public List<Awnes> getFrontAwnes(){
		List<Awnes> result = sqlSession.selectList("manage.getFrontAwnes");
		return result;
	}
	
	
	//obey Awareness 상세
	public Awnes getAwnes(int awnesNo){
		Awnes result = sqlSession.selectOne("manage.getAwnes", awnesNo);
		return result;
	}
	public int insertCarharttRadio(CarharttRadioForm carharttRadioForm){
		int result = sqlSession.insert("manage.insertCarharttRadio",carharttRadioForm);
		return result;
	}
	public int totalListCarharttRadio(SearchForm searchForm){
		int result = sqlSession.selectOne("manage.totalListCarharttRadio",searchForm);
		return result;
	}
	public List<CarharttRadioForm> carharttRadioList(SearchForm searchForm){
		List<CarharttRadioForm> result = sqlSession.selectList("manage.carharttRadioList", searchForm);
		return result;
	}
	public CarharttRadioForm carharttRadioDetail(int radioNo){
		CarharttRadioForm result = sqlSession.selectOne("manage.carharttRadioDetail", radioNo);
		return result;
	}
	public int carharttRadioUpdate(CarharttRadioForm carharttRadioForm){
		int result = sqlSession.update("manage.carharttRadioUpdate", carharttRadioForm);
		return result;
	}
	public int carharttRadioDelete(CarharttRadioForm carharttRadioForm){
		int result = sqlSession.delete("manage.carharttRadioDelete", carharttRadioForm);
		return result;
	}
	
	public List<Menu> currentAuthMenu(int userNo) {
		List<Menu> menu = sqlSession.selectList("manage.currentAuthMenu", userNo);
	    return menu;
	}
	
	public int totalBoardCnt(SearchForm searchForm) {
		int result = sqlSession.selectOne("manage.totalBoardCnt", searchForm);
	    return result;
	}
	
	public List<IntgBoard> boardList(SearchForm searchForm) {
		List<IntgBoard> collaboration = sqlSession.selectList("manage.boardList", searchForm);
		return collaboration;
	}
	
	public int insertBoard(IntgBoard board) {
	    int result = sqlSession.insert("manage.insertBoard", board);
	    return result;
	}	
	
	public List<Goods> listSpecialGoods(SearchForm searchForm) {
	    List<Goods> result = sqlSession.selectList("manage.listSpecialGoods", searchForm);
	    return result;
	}
	
	public int updateSpecialSort(BoardGds boardGds) {
	    int result = sqlSession.update("manage.updateSpecialSort", boardGds);
	    return result;
	}
	
	public int updateInquiryRepl(InquiryRepl inquiryRepl) {
	    int result = sqlSession.update("manage.updateInquiryRepl", inquiryRepl);
	    return result;
	}	
	
	public int deleteInquiryRepl(InquiryRepl inquiryRepl) {
	    int result = sqlSession.delete("manage.deleteInquiryRepl", inquiryRepl);
	    return result;
	}		
	
}
