package com.giftiel.shop.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MydlvAddr;
import com.giftiel.shop.dto.Reserve;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.StatisticsForm;
import com.giftiel.shop.dto.UbiMember;

/**
 * 회원관련 업무 수행
 * @author kwonYj
 *
 */
@Repository
public class MemberDao {
	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	public List<Member> listMemInfo(SearchForm searchForm) {
	    List<Member> result = sqlSession.selectList("member.listMemInfo", searchForm);
	    return result;
	}
	
	public List<Member> memberListXlsx() {
	    List<Member> result = sqlSession.selectList("member.memberListXlsx");
	    return result;
	}	
	
	public int totalListMemInfo(SearchForm searchForm) {
	    int result = sqlSession.selectOne("member.totalListMemInfo", searchForm);
	    return result;
	}
	
	public int totalListWdrwCnt(SearchForm searchForm) {
	    int result = sqlSession.selectOne("member.totalListWdrwCnt", searchForm);
	    return result;
	}
	
	public int insertMemInfo(Member member) {
	    int result = sqlSession.insert("member.insertMemInfo", member);
	    return result;
	}
	
	public Member selectMemInfo(SearchForm searchForm) {
		Member result = sqlSession.selectOne("member.selectMemInfo", searchForm);
	    return result;
	}
	
	public Member selectOrdInfo(SearchForm searchForm) {
		Member result = sqlSession.selectOne("member.selectOrdInfo", searchForm);
	    return result;
	}
	
	public int updateMemGrd(Member bean) {
		int result = sqlSession.update("member.updateMemGrd", bean);
	    return result;
	}
	
	public List<Member> selectInquiryList(SearchForm searchForm) {
	    List<Member> result = sqlSession.selectList("member.selectInquiryList", searchForm);
	    return result;
	}
	
	public int totalListInquiry(SearchForm searchForm) {
	    int result = sqlSession.selectOne("member.totalListInquiry", searchForm);
	    return result;
	}
	
	public Member selectloginHist(SearchForm searchForm) {
	    Member result = sqlSession.selectOne("member.selectloginHist", searchForm);
	    return result;
	}
	
	
	public int idDuplChk(String email) {
	    int result = sqlSession.selectOne("member.idDuplChk", email);
	    return result;
	}
	
	
	public int cpDuplChk(String cpNo) {
		int result = sqlSession.selectOne("member.cpDuplChk", cpNo);
		return result;
	}
	
	
	public int memberJoin(MemInfo joinForm) {
	    int result = sqlSession.insert("member.memberJoin", joinForm);
	    return result;
	}
	
	public int changeMemberInfo(MemInfo memberForm) {
	    int result = sqlSession.update("member.changeMemberInfo", memberForm);
	    return result;
	}
	
	public List<MydlvAddr> getDeliveryAddr(Member member) {
		List<MydlvAddr> result = sqlSession.selectList("member.getDeliveryAddr", member);
	    return result;
	}
	
	
	public int setBaseValYn(MydlvAddr dlvForm) {
	    int result = sqlSession.update("member.setBaseValYn", dlvForm);
	    return result;
	}
	
	public int delMydlvAddr(MydlvAddr dlvForm) {
		int result = sqlSession.update("member.delMydlvAddr", dlvForm);
		return result;
	}
	
	public int sortAddrBynm(MydlvAddr dlvForm) {
		int result = sqlSession.update("member.sortAddrBynm", dlvForm);
		return result;
	}
	
	public int modMydlvAddr(MydlvAddr dlvForm) {
		int result = sqlSession.update("member.modMydlvAddr", dlvForm);
		return result;
	}
	
	
	public int addMydlvAddr(MydlvAddr dlvForm) {
		int result = sqlSession.insert("member.addMydlvAddr", dlvForm);
		return result;
	}
	
	
	public List<Reserve> getReserveList(SearchForm searchForm) {
		List<Reserve> result = sqlSession.selectList("member.getReserveList", searchForm);
	    return result;
	}
	
	
	public int totalListReserve(SearchForm searchForm) {
	    int result = sqlSession.selectOne("member.totalListReserve", searchForm);
	    return result;
	}
	
	public int totalPoint(SearchForm searchForm) {
		int result = sqlSession.selectOne("member.totalPoint", searchForm);
		return result;
	}
	
	//멤버탈퇴
	public int withDrow(Member member) {
		int result = sqlSession.insert("member.withDrow", member);
		return result;
	}
	
	//비회원 인증
	public int nMemConfirm(HashMap<String,String> hashMap) {
		int result = sqlSession.selectOne("member.nMemConfirm", hashMap);
		return result;
	}
	
	//회원 최근배송지
	public MydlvAddr getRecentAddr(Integer memNo) {
		MydlvAddr result = sqlSession.selectOne("member.getRecentAddr", memNo);
		return result;
	}
	
	public int insertUbiMember(UbiMember ubiMember) {
	    int result = sqlSession.insert("member.insertUbiMember", ubiMember);
	    return result;
	}	

	/**
	 * 온라인샵 회원 등급업
	 * @return
	 */
	public int onlineShopMemGrdUp() {
		int result = sqlSession.update("scheduler.onlineShopMemGrdUp");
		return result;
	}
	
	/**
	 * ubi회원 등급업
	 * @return
	 */
	public int ubiMemGrdUp() {
		int result = sqlSession.insert("scheduler.ubiMemGrdUp");
		return result;
	}
	
	public int ubiMemGrdUpdate(Member member) {
		int result = sqlSession.insert("member.ubiMemGrdUpdate", member);
		return result;
	}	
	
	
	//로그인 히스토리 insert
	public int setLoginHist(StatisticsForm statisticsForm) {
		int result = sqlSession.insert("member.setLoginHist" , statisticsForm);
	    return result;
	}	
}