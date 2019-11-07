package com.giftiel.shop.service;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.giftiel.shop.dao.CommonDao;
import com.giftiel.shop.dao.MemberDao;
import com.giftiel.shop.dto.MemInfo;
import com.giftiel.shop.dto.Member;
import com.giftiel.shop.dto.MydlvAddr;
import com.giftiel.shop.dto.Reserve;
import com.giftiel.shop.dto.SearchForm;
import com.giftiel.shop.dto.StatisticsForm;
import com.giftiel.shop.dto.UbiMember;

@Service
public class MemberService {
	//true시 UBI 회원정보 연동
	private boolean testCls = true;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CommonDao commonDao;
	
	public List<Member> listMemInfo(SearchForm searchForm) {
	    List<Member> result = memberDao.listMemInfo(searchForm);
	    return result;
	}
	
	public List<Member> memberListXlsx() {
	    List<Member> result = memberDao.memberListXlsx();
	    return result;
	}
	
	public int totalListMemInfo(SearchForm searchForm) {
	    int result = memberDao.totalListMemInfo(searchForm);
	    return result;
	}
	
	public int totalListWdrwCnt(SearchForm searchForm) {
	    int result = memberDao.totalListWdrwCnt(searchForm);
	    return result;
	}
	
	public Member selectMemInfo(SearchForm searchForm) {
		Member result = memberDao.selectMemInfo(searchForm);
	    return result;
	}  
	
	public Member selectOrdInfo(SearchForm searchForm) {
		Member result = memberDao.selectOrdInfo(searchForm);
	    return result;
	}
	
	@Transactional
	public int updateMemGrd(Member member) {
		int result = memberDao.updateMemGrd(member);
		if(member.getMemGrdNo() == 4){
			member.setMemGrdNo(1);
			member.setCurRsvPer(1);
		}else if(member.getMemGrdNo() == 1){
			member.setMemGrdNo(2);
			member.setCurRsvPer(2);
		}else if(member.getMemGrdNo() == 21){
			member.setMemGrdNo(3);
			member.setCurRsvPer(0);
		}
		result = memberDao.ubiMemGrdUpdate(member);
	    return result;
	} 
	
	public List<Member> selectInquiryList(SearchForm searchForm) {
	    List<Member> result = memberDao.selectInquiryList(searchForm);
	    return result;
	}
	
	public int totalListInquiry(SearchForm searchForm) {
	    int result = memberDao.totalListInquiry(searchForm);
	    return result;
	}
	
	public Member selectloginHist(SearchForm searchForm) {
	    Member result = memberDao.selectloginHist(searchForm);
	    return result;
	}
	
	
	public int idDuplChk(String email) {
	    int result = memberDao.idDuplChk(email);
	    return result;
	}
	
	
	public int cpDuplChk(String cpNo) {
		int result = memberDao.cpDuplChk(cpNo);
		return result;
	}
	
	
	
	
	public int memberJoin(MemInfo joinForm) {
		joinForm.setMemNo(commonDao.createKey("SEQ_ME_MEM"));
	    int result = memberDao.memberJoin(joinForm);
	    
	    if(testCls){
		    UbiMember ubiMember = new UbiMember();
		    ubiMember.set온라인고객코드(joinForm.getMemNo().toString());
		    ubiMember.set성명(joinForm.getNm());
		    ubiMember.set핸드폰번호(joinForm.getCpNo().replaceAll("-", ""));
		    ubiMember.set성별(joinForm.getSex());
		    ubiMember.set가입매장코드("WE001"); //확인
		    ubiMember.set생년월일(StringUtils.replace(joinForm.getBirthDt(), ".", ""));
		    ubiMember.set생일구분("Y");
		    ubiMember.setDM발송지(" ");
		    ubiMember.setSMS수신("Y");
		    ubiMember.set이메일수신("Y");
		    ubiMember.set수정여부("I");
		    ubiMember.set처리여부("Y");
		    ubiMember.set고객등급("1");
		    ubiMember.set적립율(1);
		    ubiMember.set이메일(joinForm.getEmail());
	    	memberDao.insertUbiMember(ubiMember);
	    }
	    
	    
	    return result;
	}
	
	
	public int changeMemberInfo(MemInfo memberForm) {
	    int result = memberDao.changeMemberInfo(memberForm);
	    return result;
	}
	
	public List<MydlvAddr> getDeliveryAddr(Member member) {
		List<MydlvAddr> result = memberDao.getDeliveryAddr(member);
	    return result;
	}
	
	
	public int setBaseValYn(MydlvAddr dlvForm) {
	    int result = memberDao.setBaseValYn(dlvForm);
	    return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int delMydlvAddr(MydlvAddr dlvForm) {
		int result = memberDao.delMydlvAddr(dlvForm);
		result = memberDao.sortAddrBynm(dlvForm);
		return result;
	}
	
	
	public int modMydlvAddr(MydlvAddr dlvForm) {
		int result = memberDao.modMydlvAddr(dlvForm);
		return result;
	}
	
	
	public int addMydlvAddr(MydlvAddr dlvForm) {
		int result = memberDao.addMydlvAddr(dlvForm);
		return result;
	}
	
	
	public List<Reserve> getReserveList(SearchForm searchForm) {
		List<Reserve> result = memberDao.getReserveList(searchForm);
	    return result;
	}
	
	public int totalListReserve(SearchForm searchForm) {
	    int result = memberDao.totalListReserve(searchForm);
	    return result;
	}
	
	public int totalPoint(SearchForm searchForm) {
		int result = memberDao.totalPoint(searchForm);
		return result;
	}
	
	//멤버탈퇴
	public int withDrow(Member member) {
		int result = memberDao.withDrow(member);
		return result;
	}
	
	//비회원 인증
	public int nMemConfirm(HashMap<String,String> hashMap) {
		int result = memberDao.nMemConfirm(hashMap);
		return result;
	}
	
	
	
	//회원 최근배송지
	public MydlvAddr getRecentAddr(Integer memNo) {
		MydlvAddr result = memberDao.getRecentAddr(memNo);
		return result;
	}
	
	public int insertUbiMember(UbiMember ubiMember) {
	    int result = memberDao.insertUbiMember(ubiMember);
	    return result;
	}	
	

	@Transactional
	public void gradeUpMember() {
		memberDao.onlineShopMemGrdUp();
		memberDao.ubiMemGrdUp();
	}		
	
	//로그인 히스토리 insert
	public int setLoginHist(StatisticsForm statisticsForm) {
	    int result = memberDao.setLoginHist(statisticsForm);
	    return result;
	}
	
	public int ubiMemGrdUpdate(Member member) {
	    int result = memberDao.ubiMemGrdUpdate(member);
	    return result;
	}	
}