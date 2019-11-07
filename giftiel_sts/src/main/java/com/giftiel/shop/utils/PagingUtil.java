package com.giftiel.shop.utils;

public class PagingUtil
{
	/*
	* 공통 목록 페이징 처리
	*/	
	public StringBuffer getPageHtml(int currentPage, int totalNum, int showListLimit, int showPageLimit) {		
		StringBuffer pageHtml = new StringBuffer();
		int startPage = 0;
		int lastPage = 0;
		int result = totalNum % showListLimit ;
		
		startPage = ((currentPage-1) / showPageLimit) * showPageLimit + 1;
		lastPage = startPage + showPageLimit - 1;
		
		if( lastPage > totalNum / showListLimit &&  result > 0 ) {
			lastPage = (totalNum / showListLimit) + 1;
		}else{
		    int totalpage = (totalNum / showListLimit) ;	
		    if(lastPage > totalpage) {
		    	lastPage = totalpage;
		    }
		}		
		
		pageHtml.append("<a href=\"javascript:paging('1');\" class=\"firstBtn\"><img src=\"/resources/admin/images/common/firstBtn.gif\" alt=\"처음으로\"></a>&nbsp;");
		
		if(currentPage == 1){
			pageHtml.append("<a href=\"javascript:paging('1');\" class=\"prevBtn\"><img src=\"/resources/admin/images/common/prevBtn.gif\" alt=\"이전으로\"></a>");
		} else {
			pageHtml.append("<a href=\"javascript:paging('" + (currentPage-1) + "');\" class=\"prevBtn\"><img src=\"/resources/admin/images/common/prevBtn.gif\" alt=\"이전으로\"></a>");
		}
		
		pageHtml.append("<span class='num'>");		
		for(int i = startPage ; i <= lastPage ; i++) {
			if(i == currentPage){
				pageHtml.append("<a href=\"javascript:paging('" + i + "');\" class=\"on\">" + i + "</a>");
			} else {
				pageHtml.append("<a href=\"javascript:paging('" + i + "');\" >" + i + "</a>");
			}
		} 
		pageHtml.append("</span>");
		
		if(currentPage == (totalNum / showListLimit + 1)){
			//pageHtml.append("</span>");
		} else {
			pageHtml.append("<a href=\"javascript:paging('" + (currentPage+1) + "');\" class=\"nextBtn\"><img src=\"/resources/admin/images/common/nextBtn.gif\" alt=\"다음으로\"></a>");
		}
		
		pageHtml.append("&nbsp;<a href=\"javascript:paging('"+lastPage+"');\" class=\"lastBtn\"><img src=\"/resources/admin/images/common/lastBtn.gif\" alt=\"마지막으로\"></a>");
		
		return pageHtml;
	}
	
	public StringBuffer getBootPageHtml(int currentPage, int totalNum, int showListLimit, int showPageLimit) {		
		StringBuffer pageHtml = new StringBuffer();
		int startPage = 0;
		int lastPage = 0;
		int result = totalNum % showListLimit ;
		int totalpage = 0;
		startPage = ((currentPage-1) / showPageLimit) * showPageLimit + 1;
		lastPage = startPage + showPageLimit - 1;
		
		if( lastPage > totalNum / showListLimit &&  result > 0 ) {
			lastPage = (totalNum / showListLimit) + 1;
		}else{
			totalpage = (totalNum / showListLimit) ;	
			if(lastPage > totalpage) {
				lastPage = totalpage;
			}
		}
	
		pageHtml.append("<ul class=\"pagination pagination-sm\">");
		pageHtml.append("<li><a href=\"javascript:paging('1');\" aria-label=\"Previous\"><i class=\"fa fa-angle-double-left\"></i></a></li>");		
		
		if(currentPage == 1){
			pageHtml.append("<li><a href=\"javascript:paging('1');\"><i class=\"fa fa-angle-left\"></i></a></li>");
		} else {
			pageHtml.append("<li><a href=\"javascript:paging('" + (currentPage-1) + "');\"><i class=\"fa fa-angle-left\"></i></a></li>");
		}
	
		for(int i = startPage ; i <= lastPage ; i++) {
			if(i == currentPage){
				pageHtml.append("<li class=\"active\"><a href=\"javascript:paging('" + i + "');\">" + i + "</a></li>");
			} else {
				pageHtml.append("<li><a href=\"javascript:paging('" + i + "');\">" + i + "</a></li>");
			}
		} 
	
		if(currentPage == (totalNum / showListLimit + 1)){
//			pageHtml.append("<li class=\"disabled\"><a href=\"#\">" + currentPage + "</a></li>");
		} else {
			pageHtml.append("<li><a href=\"javascript:paging('" + (currentPage+1) + "');\"><i class=\"fa fa-angle-right\"></i></a></li>");
		}

		pageHtml.append("<li><a href=\"javascript:paging('"+lastPage+"');\" aria-label=\"Next\"><i class=\"fa fa-angle-double-right\"></i></a></li>");
		pageHtml.append("</ul>");
		
		return pageHtml;
	}	
	
	
	
	/*
	* 공통 목록 페이징 처리(front용)
	*/	
	public StringBuffer getPageHtmlFront(int currentPage, int totalNum, int showListLimit, int showPageLimit) {		
		StringBuffer pageHtml = new StringBuffer();
		int startPage = 0;
		int lastPage = 0;
		int result = totalNum % showListLimit ;
		
		startPage = ((currentPage-1) / showPageLimit) * showPageLimit + 1;
		lastPage = startPage + showPageLimit - 1;
		
		if( lastPage > totalNum / showListLimit &&  result > 0 ) {
			lastPage = (totalNum / showListLimit) + 1;
		}else{
		    int totalpage = (totalNum / showListLimit) ;	
		    if(lastPage > totalpage) {
		    	lastPage = totalpage;
		    }
		}		
		
		pageHtml.append("<a href=\"javascript:paging('1');\" class=\"btn_go_home\"><span class=\"hide_txt\">맨 처음으로</span></a>&nbsp;");
		
		if(currentPage == 1){
			pageHtml.append("<a href=\"javascript:paging('1');\" class=\"btn_go_prev\"><span class=\"hide_txt\">이전으로</span></a>");
		} else {
			pageHtml.append("<a href=\"javascript:paging('" + (currentPage-1) + "');\" class=\"btn_go_prev\"><span class=\"hide_txt\">이전으로</span></a>");
		}
		
		pageHtml.append("<span class='num'>");		
		for(int i = startPage ; i <= lastPage ; i++) {
			if(i == currentPage){
				pageHtml.append("<a href=\"javascript:paging('" + i + "');\" class=\"on\"><span>" + i + "</span></a>");
			} else {
				pageHtml.append("<a href=\"javascript:paging('" + i + "');\" ><span>" + i + "</span></a>");
			}
		} 
		pageHtml.append("</span>");
		
		if(currentPage == (totalNum / showListLimit + 1)){
			//pageHtml.append("</span>");
		} else {
			pageHtml.append("<a href=\"javascript:paging('" + (currentPage+1) + "');\" class=\"btn_go_next\"><span class=\"hide_txt\">다음으로</span></a>");
		}
		
		pageHtml.append("&nbsp;<a href=\"javascript:paging('"+lastPage+"');\" class=\"btn_go_end\"><span class=\"hide_txt\">맨 끝으로</span></a>");
		
		return pageHtml;
	}
}
