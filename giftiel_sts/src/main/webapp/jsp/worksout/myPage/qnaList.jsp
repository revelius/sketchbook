<%--
 * =============================================================================
 * 파일명 :  /front/myPage/qnaList.jsp
 * 작성자 : 김진성
 * 작성일자 : 2015-06-23
 *
 * 파일 내용 : qna 리스트
 * =============================================================================
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/admin/include/taglibs.jsp"%>
<%
	pageContext.setAttribute("CrLf", "\r\n"); 
	pageContext.setAttribute("Cr", "\r"); 
	pageContext.setAttribute("Lf", "\n"); 
%>
<!DOCTYPE html>
<!--[if IE 7]><html lang="ko" class="ie7"><![endif]-->
<!--[if IE 8]><html lang="ko" class="ie8"><![endif]-->
<!--[if IE 9]><html lang="ko" class="ie9"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
	<!--<![endif]-->
	<head>
		<jsp:include page="/jsp/worksout/include/head.jsp"/>
		
		<script type="text/javascript">
    		$(function() { 
    			
    			//리스트 검색
    		    $('#btn_search').click(function() {
    				$("#page").val("1");
    		    	goSubmit();
    		    });
    			
    			//페이징 처리
    		    paging = function(page) {
    		        //var frm = document.schForm;
    		        document.getElementById("page").value = page;
    		        goSubmit();
    		    };	
    		    
    		    
    		  	//검색
    		    goSubmit = function(){
   			        var frm = document.searchForm;
   						frm.action = "<c:url value='/front/myPage/qnaList'/>";
			 	        frm.submit();
    		    };
    		    
    			
    			//수정하기 클릭
    			$("div[data-area='mod_default']").on("click",function(e){
    				e.preventDefault();
    				var $target = $(e.currentTarget);
    				$target.hide();
    				$target.parent().find("div[data-area='mod_input']").show();
    			});
    			
    			
    			//문의수정하기 취소 클릭
    			$("a[data-btn='mod_return_default']").on("click",function(e){
    				e.preventDefault();
    				var $target = $(e.currentTarget);
    				$target.parent().parent().parent().find("div[data-area='mod_input']").hide();
    				$target.parent().parent().parent().find("div[data-area='mod_default']").show();
    			});
    			
    			
    			// 추가 문의 하기 클릭
    			$("a[data-btn='add_reply']").on("click",function(e){
    				e.preventDefault();
    				var $target = $(e.currentTarget);
    				//$target.parent().parent().parent().find("div[data-area='mod_input']").hide();
    				$target.parent().parent().parent().find("div[data-area='add_input']").show();
    			});
    			
    			
    			//추가 문의하기 취소 클릭
    			$("a[data-btn='add_return_default']").on("click",function(e){
    				e.preventDefault();
    				var $target = $(e.currentTarget);
    				$target.parent().parent().parent().find("a[data-btn='add_reply']").show();
    				$target.parent().parent().parent().find("div[data-area='add_input']").hide();
    			});
    			
    			
    			//글 수정 클릭
   				$("a[data-btn='mod_modify']").on("click",function(e){
   					e.preventDefault();
    				var $target = $(e.currentTarget);
    				if(!confirm("수정 하시겠습니까?")) return false;
    				
    				var url = "<c:url value='/front/myPage/modInquiryAjax'/>";
    				
    				var cnslNo = $target.parents(".reply_section").prev().attr("data-cnslNo");
					$("#cnslNo").val(cnslNo);
					
					
    				if($target.parents(".qna_add_input").prev().prev().prev().attr("data-gubun") == "main"){ //메인
    					var cnslTxt = $target.parents(".qna_add_input").find("#add_qna").val();
    					if(cnslTxt == ""){
    						alert("수정할 내용을 입력해주세요");
    						return false;
    					}
    					$("#cnslTxt").val(cnslTxt);
    					$("#memoNo").val("");
    				}else{                                                     //reply
    					var memoNo = $target.parents(".qna_add_input").prev().prev().prev().attr("data-memoNo");
    					var memoTxt = $target.parents(".qna_add_input").find("#add_qna").val();
    					if(memoTxt == ""){
    						alert("수정할 내용을 입력해주세요");
    						return false;
    					}
    					$("#memoNo").val(memoNo);
    					$("#memoTxt").val(memoTxt);
    				}
    				
    				$.ajax({
       	   		        url : url,
       	   		        type: "post",
       	   		        data : $("form#hiddenForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   						alert("수정 되었습니다."); 
       	   						var frm = document.hiddenForm;
       	   						frm.action = "<c:url value='/front/myPage/qnaList'/>";
       				 	        frm.submit();
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
    				
    				
    				
    				
   				});
    			
    			//글 삭제 클릭
    			$("a[data-btn='btn_del_reply']").on("click",function(e){
    				e.preventDefault();
    				var $target = $(e.currentTarget);
    				if(!confirm("삭제 하시겠습니까?")) return false;
    				
    				var url = "<c:url value='/front/myPage/delInquiryAjax'/>";
    				
					var cnslNo = $target.parents(".reply_section").prev().attr("data-cnslNo");
					$("#cnslNo").val(cnslNo);
    				if($target.parent().next().attr("data-gubun") == "main"){ //메인
    					$("#memoNo").val("");
    				}else{                                                     //reply
    					var memoNo = $target.parent().next().attr("data-memoNo");
    					$("#memoNo").val(memoNo);
    				}
    				
    				$.ajax({
       	   		        url : url,
       	   		        type: "post",
       	   		        data : $("form#hiddenForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   						alert("삭제 되었습니다."); 
       	   						var frm = document.hiddenForm;
       	   						frm.action = "<c:url value='/front/myPage/qnaList'/>";
       				 	        frm.submit();
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
    				
    				
    			});
    			
    			
    			
    			//문의추가하기 
   				$("a[data-btn='add_reply_proc']").on("click",function(e){
       				e.preventDefault();
       				var $target = $(e.currentTarget);
       				
       				if(!confirm("추가 하시겠습니까?")) return false;
       				
       				if($target.parent().prev().find("#add_qna").val() == ""){
       					alert("추가 문의사항을 입력해 주세요");
       					return false; 
       				}
       			
       				var cnslNo = $target.parents(".reply_section").prev().attr("data-cnslNo");
       				var memoTxt = $target.parent().prev().find("#add_qna").val();
       				$("#cnslNo").val(cnslNo);
       				$("#memoTxt").val(memoTxt);
       		    	
       				
       		    	$.ajax({
       	   		        url : "<c:url value='/front/myPage/regInquiryReplAjax'/>",
       	   		        type: "post",
       	   		        data : $("form#hiddenForm").serialize(),
       	   		        async: true,
       	   		        success : function(res){
       	   		            if (res > 0) {
       	   						alert("저장 되었습니다."); 
       	   						var frm = document.hiddenForm;
       	   						frm.action = "<c:url value='/front/myPage/qnaList'/>";
       				 	        frm.submit();
       	   					} else {
       	   						alert("오류가 발생되었습니다.\n확인 후 다시 시도해 주시기 바랍니다.");
       	   					}
       	   		        },
       	   		        error:function(request,status,error){
       	   		            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
       	   		        }
       	   		    });
       			});
   				
   				//파일다운로드
   			    fileExport= function(e){
   			    	var $target = $(e);
   			    	var fileName = $target.attr('data-file');
   			    	
   			    	$target.attr('href' , "<c:url value='/fileDownload/fileExport?fileName="+fileName+"'/>");
   			    };
   			    
   			    
   			    
   			    
    		    
    		    
    		    
    		    //load more
    			var isLoading = false;
    			loadMore = function() {
    				if (isLoading) {
    					alert('처리중');
    					return;
    				}
    				isLoading = true;
    				
    				$.ajax({
    			        url : "<c:url value='/front/myPage/qnaListAjax'/>",
    			        type: "post",
    			        data : $('#searchForm').serialize(),
    			        async: true,
    			        success : function(responseData){
    			        	if(responseData.replace(/^\s+/,"").length < 1){
    			        		alert("리스트끝");
    			        		return;
    			        	}
    			        	
    			        	var list = $('#list');
    			        	list.append(responseData);
    			        	var currentPage = Number($('#page').val()) + 1;
			        		$('#page').val(currentPage);
    			        },
    			        error:function(request,status,error){
    			            alert("code:"+request.status+"\n"+"error:"+error+"\n 관리자에게 문의하십시오.");
    			        },
    			        complete:function(request,status){
    			        	isLoading = false;
    			        }
    			    });
    			};
   			    
   			    
    			
//     			$('#page').val("1");
    			
    			
    		});
   		</script>
		
		
	</head>
	<body>
		<form id="hiddenForm" name="hiddenForm" method="post" >
			<input type="hidden" name="cnslNo"  id="cnslNo"  value=""/>
			<input type="hidden" name="cnslTxt"  id="cnslTxt"  value=""/>
			<input type="hidden" name="memoNo"  id="memoNo"  value=""/>
			<input type="hidden" name="memoTxt"  id="memoTxt"  value=""/>
		</form>
		<!--[if lte IE 8]><p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->
		<div class="dimm">
			<img src="/html/worksout/images/common/blank_size_100.png" alt="">
		</div>
		<div id="wrap">
			<h2 class="hide_txt">주요 메뉴 영역</h2>
			<div id="header">
				<!-- header include -->
				<!-- header include -->
			</div>
			<h2 class="hide_txt">본문 영역</h2>
			<div id="container">
				<div id="content">
					<div class="content_wrap">
						<ul class="location_list clfix">
							<li class="home">
								<a href="<c:url value='/front/main'/>">HOME</a>
							</li>
							<li>
								<a href="<c:url value='/front/myPage/myPageHome'/>">MY PAGE</a>
							</li>
							<li>
								<a href="#">Q&amp;A</a>
							</li>
						</ul>
						<div class="menu_section">
							<div id="snb_mypage_area">
								<!-- snbMain include -->
								<!-- snbMain include -->
							</div>
						</div>
						<div class="content_section">
							<div class="content_area">
								<div class="content_top">
									<div class="content_menu clfix height02">
										<!-- on 클래스 붙으면 활성화 됨 -->
										<span class="menu_link">
											<a href="<c:url value="/front/myPage/qnaList"/>" class="on">1:1 문의내역</a>
											<a href="<c:url value="/front/myPage/qna"/>" class="last_child">1:1 문의하기</a>
										</span>
									</div>
								</div>
								<div class="mypage_area">
									<div class="btn_area type02">
										<a href="<c:url value="/front/myPage/qna"/>" class="btn_white02">1:1 문의하기</a>
									</div>
									<table class="tbl_col02 tbl_col02_mypage_qna_list ui_reponsible_table_type01 ui_personal_qna">
										<caption>Q &amp; A 게시판으로 제목, 답변여부 를 확인 할 수 있습니다.</caption>
										<thead>
											<tr>
												<th scope="col">NO</th>
												<th scope="col">제목</th>
												<th scope="col">최근 문의일</th>
												<th scope="col">최근 답변일</th>
												<th scope="col">답변여부</th>
											</tr>
										</thead>
										<tbody id="list">
											<c:choose>
												<c:when test="${not empty inquiryList}">
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
																		<span class="txt_q">${fn:replace(inquiry.cnslTxt,CrLf, "<br/>")}</span>
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
																				<span class="txt_q">${fn:replace(inqueryRepl.memoTxt,CrLf, "<br/>")}</span>
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
																				<span class="txt_a">${fn:replace(inqueryRepl.memoTxt,CrLf,'<br/>')}</span>
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
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="5" align="center">문의내역이 없습니다.</td>
													</tr>
												</c:otherwise>
											</c:choose>
										
											
										</tbody>
									</table>
									<!-- a태그에 on 붙으면 활성화 됨. -->
									<!-- 처음, 이전, 끝, 다음으로는 활성화 없음 -->
									<!-- 웹에서는 페이징 모바일에서는 아래 더보기 버튼 사용 -->
									<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
									<div class="pagenavi_loadmoer_select_ctr">
										<div class="pagenavi space01">
											<!--[s] 페이징 -->
											<div class="paging">
											<c:choose>
												<c:when test="${not empty inquiryList}">
												${pageHtml}
												</c:when>
											</c:choose>
											</div>
											<!--[e] 페이징 -->
										</div>
										<!-- 화면사이즈에 따라 나오고 안나오게 CSS 처리함 -->
										<!-- 모바일에서는 아래 더보기 버튼 사용.  -->
										<div class="btn_area">
											<a href="javascript:loadMore();">
												<img src="/html/worksout/images/common/btn_loadmore.png" alt="LOAD MORE">
											</a>
										</div>
									</div>
									<form:form id="searchForm" name="searchForm" method="post" modelAttribute="searchForm" onsubmit="">
			        					<form:hidden path="page" id="page" value="1"/>
			        					<form:hidden path="orderBy" id="orderBy"/>
			       						<form:hidden path="orderFlag" id="orderFlag"/>
										<div class="tbl_search_box clfix">
											<div class="box_item01">
												<span class="input_select">
													<form:select path="searchGb" id="searchGb">
														<form:option value="title">제목</form:option>
														<form:option value="content">내용</form:option>
														<form:option value="all">제목+내용</form:option>
													</form:select>
												</span>
											</div>
											<div class="box_item02">
												<span class="input_txt input_btn_search">
													<form:input path="searchText" id="searchText" type="text" />
													<a href="#" class="btn_search">
														<img src="/html/worksout/images/common/btn_search.png" alt="search"  id="btn_search">
													</a>
												</span>
											</div>
										</div>
									</form:form>
								</div>
							</div>
						</div>
						<div class="etc_section"></div>
					</div>
				</div>
			</div>
			<h2 class="hide_txt">하단 영역</h2>
			<div id="footer">
				<!-- footer include -->
				<!-- footer include -->
			</div>
		</div>
	</body>
</html>