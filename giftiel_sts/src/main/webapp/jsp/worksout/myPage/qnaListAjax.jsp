<%--
 * =============================================================================
 * 파일명 :  /front/myPage/qnaListAjax.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-23
 *
 * 파일 내용 : qna 리스트 모바일용 Ajax페이지
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>

		<c:forEach items="${inquiryList}" var="inquiry" varStatus="inquiryCount">
			<tr data-cnslNo="${inquiry.cnslNo}">
				<td class="tbl_layout01">
					<div class="mobile_th">NO</div>
					<div class="tbl_cont">${inquiry.rnum}</div>
				</td>
				<td class="tbl_layout02">
					<div class="mobile_th">제목</div>
					<div class="tbl_cont">
						<a href="#" class="ui_title">${inquiry.title}</a>
						<c:if test="${inquiryCount.first}">
							<img src="/html/worksout/images/common/ico_new.gif" alt="NEW" class="ico_new">
						</c:if>
					</div>
				</td>
				<td class="tbl_layout03">
					<div class="mobile_th">최근 문의일</div>
					<div class="tbl_cont">${inquiry.maxQ}</div>
				</td>
				<td class="tbl_layout04">
					<div class="mobile_th">최근 답변일</div>
					<div class="tbl_cont">${inquiry.maxA}</div>
				</td>
				<td class="tbl_layout05">
					<div class="mobile_th">답변여부</div>
					<div class="tbl_cont">${inquiry.cnslStat}</div>
				</td>
			</tr>
			
			
				<!-- 기본 질문 -->
				<tr class="reply_section" style="display: none;">
					<td colspan="5">
					<div class="qna_reply_area">
						<c:choose>
							<c:when test="${empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중')}">
								<div class="qna_add_top">
									<a href="#" class="btn_del_reply" data-btn="btn_del_reply">
										<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
									</a>
								</div>
							</c:when>
						</c:choose>
						
						<div class="qna_q clfix" data-gubun="main">
							<span class="ico_q">Q</span>
							<span class="txt_q">${inquiry.cnslTxt}</span>
							<span class="date_q">${inquiry.regDts}</span>
						</div>
						<c:if test="${inquiry.atchFile ne null}">
							<div class="qna_file">
								<a href="#" class="ico_file" onclick="javascript:fileExport(this);" data-file="<c:out value='${inquiry.atchFile}'/>">
									<span class="line">
										<c:set value="${fn:split(inquiry.atchFile,'/') }" var="fileName" />
										<c:out value="${fileName[fn:length(fileName)-1] }"></c:out>
									</span>
								</a>
							</div>
						</c:if>
						
						<c:choose>
							<c:when test="${empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중')}">
								<div class="qna_add_bottom" data-area="mod_default">
									<a href="#" class="btn_modify_reply">수정하기</a>
								</div>

								<div class="qna_add_top" data-area="mod_input" style="display: none;">
									<a href="#" class="btn_del_reply" data-btn="mod_return_default">
										<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
									</a>
								</div>
								<div class="qna_add_input" data-area="mod_input" style="display: none;">
									<span class="input_txt">
										<input type="text" id="add_qna" name="add_qna" placeholder="">
									</span>
									<div class="btn_add_reply">
										<a href="#" class="btn_black01"  data-btn="mod_modify">문의 수정하기</a>
									</div>
								</div>
							</c:when>
						</c:choose>
						
						<c:forEach items="${inquiry.inqueryRepl}" var="inqueryRepl" varStatus="inqueryReplCount">
							<c:if test="${inqueryRepl.wrtrCls == 'CM01002'}">
							
								<c:choose>
									<c:when test="${not empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중') && inqueryReplCount.last}">
										<div class="qna_add_top">
											<a href="#" class="btn_del_reply" data-btn="btn_del_reply">
												<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
											</a>
										</div>
									</c:when>
								</c:choose>
							
								<div class="qna_q clfix"  data-gubun="reply" data-memoNo="${inqueryRepl.memoNo}">
									<span class="ico_q">Q</span>
									<span class="txt_q">${inqueryRepl.memoTxt}</span>
									<span class="date_q">${inqueryRepl.updDts}</span>
								</div>
								
								<c:choose>
									<c:when test="${not empty inquiry.inqueryRepl && (inquiry.cnslStat eq '미처리' || inquiry.cnslStat eq '처리중') && inqueryReplCount.last}">
										<div class="qna_add_bottom" data-area="mod_default">
											<a href="#" class="btn_modify_reply">수정하기</a>
										</div>

										<div class="qna_add_top" data-area="mod_input" style="display: none;">
											<a href="#" class="btn_del_reply" data-btn="mod_return_default">
												<img src="/html/worksout/images/common/btn_del_reply.png" alt="삭제">
											</a>
										</div>
										<div class="qna_add_input" data-area="mod_input" style="display: none;">
											<span class="input_txt">
												<input type="text" id="add_qna" name="add_qna" placeholder="">
											</span>
											<div class="btn_add_reply">
												<a href="#" class="btn_black01" data-btn="mod_modify">문의 수정하기</a>
											</div>
										</div>
									</c:when>
								</c:choose>
								
								
								
								
							</c:if>
							<c:if test="${inqueryRepl.wrtrCls == 'CM01001'}">
								<div class="qna_a clfix">
									<span class="ico_a">A</span>
									<span class="txt_a">${inqueryRepl.memoTxt}</span>
									<span class="date_a">${inqueryRepl.updDts}</span>
								</div>
							</c:if>
							<c:if test="${inqueryReplCount.last && inquiry.cnslStat eq '처리완료'}">
								<div class="qna_replay_add_btn" data-area="add_reply">
									<a href="#" class="btn_add_reply_show ui_add_reply_btn" data-btn="add_reply">+ 추가문의</a>
								</div>
								
								<div class="qna_add_top" data-area="add_input" style="display: none;">
									<a href="#" class="btn_del_reply" data-btn="add_return_default">
										<img src="/html/worksout/images/common/btn_del_reply.png" alt="닫기">
									</a>
								</div>
								<div class="qna_add_input" data-area="add_input" style="display: none;">
									<span class="input_txt">
										<input type="text" id="add_qna" name="add_qna" placeholder="">
									</span>
									<div class="btn_add_reply">
										<a href="#" class="btn_black01" data-btn="add_reply_proc">추가 문의하기</a>
									</div>
								</div>
							
							</c:if>
						</c:forEach>
					</div>
					</td>
				</tr>
				<!-- 기본 질문 -->
			
		</c:forEach>
