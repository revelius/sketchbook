/**
 * =============================================================================
 * 파일명 : /resources/common/frontUtils.js
 * 작성자 : 권용재
 * 작성일자 : 2015-05-22
 *
 * 파일 내용 : 프론트 공통 스크립트
 * =============================================================================
 **/

//상품상세 이동
gotoGoodsDetail = function(ubiGdsNo,oneDepth) {
	$(location).attr('href','/front/onlineShop/goodsDetail?ubiGdsNo='+ubiGdsNo + "&oneDepth=" + oneDepth);
};

gotoGoodsDetailBlank = function(ubiGdsNo,oneDepth) {
	window.open('/front/onlineShop/goodsDetail?ubiGdsNo='+ubiGdsNo + "&oneDepth=" + oneDepth, '_blank');
};

//뉴스상세 이동
gotoNewsDetail = function(txtNo, path) {
	$(location).attr('href',path + "/front/news/newsDetail?siteNo=" + txtNo);
};

//뉴스상세 이동
gotoLookbookDetail = function(txtNo, path) {
	$(location).attr('href',path + "/front/lookbook/detail?txtNo=" + txtNo);
};


// 검색시 탭이동 용도로 추가
// onlineShopSearchResult.jsp, newsSearchResult.jsp, lookbookSearchResult.jsp, otherSearchResult.jsp 에서 사용
SearchType = function(mode,strVal,path){
	$("#searchText").val(strVal);
	switch (mode) {
		case "ONLINE":
			$("#schForm").attr("action",path + "/front/search/onlineShop");
		break;
		
		case "NEWS":
			$("#schForm").attr("action",path + "/front/search/news");
		break;
		
		case "LOOKBOOK":
			$("#schForm").attr("action",path + "/front/search/lookbook");
		break;
		
		case "OTHER":
			$("#schForm").attr("action",path + "/front/search/other");
		break;
		
		default:
			$("#schForm").attr("action",path + "/front/search/onlineShop");
		break;
	}				
	$("#schForm").submit();
};


var cookieList = function(cookieName){
  	 var cookie = $.cookie(cookieName);
  	 var items = cookie ? cookie.split(/,/) : new Array();
  	 return {
  		 "add" : function(val){
  			 items.push(val);
  			 
/*  			 if($.cookie(cookieName) == "null"){
  				
  			 }*/
  			 $.cookie(cookieName,items.join(','), { expires: 7, path: '/', domain: 'worksout.co.kr', secure: false });
  		 },
  		 "clear" : function(){
  			 items = null;
  			 $.cookie(cookieName, "");
  		 },
  		 "items" : function(){
  			 return items; 
  		 }
  	 };
};

//숫자에 콤마 추가
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//숫자에 콤마 제거
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

//파일첨부 공통 팝업
function openFileUploadPop(type, target, folderNm){
	var popUrl = "/common/fileUpload?type="+type+"&target="+target+"&folderNm="+folderNm;	//팝업창에 출력될 페이지 URL
	var popOption = "width=400, height=150, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}


//우체국 배송조회
//invNo: 송장번호
function openDlvPop(invNo,dlvCmpSrc){
	var popUrl = dlvCmpSrc+invNo;	//팝업창에 출력될 페이지 URL
	var popOption = "width=400, height=150, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}




// 글자수 제한(나머지 절삭)
function chkLen(obj,maximumByte) {
    //var before = $count.text() * 1;
    var str_len = obj.value.length;
    var cbyte = 0;
    var li_len = 0;
    for (var i = 0; i < str_len; i++) {
        var ls_one_char = obj.value.charAt(i);
        if (escape(ls_one_char).length > 4) {
            cbyte += 2; //한글이면 2를 더한다
        } else {
            cbyte++; //한글아니면 1을 다한다
        }
        if (cbyte <= maximumByte) {
            li_len = i + 1;
        }
    }
    // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
    if (parseInt(cbyte) > parseInt(maximumByte)) {
        alert(maximumByte + '자를 초과되었습니다.\r\n\n초과된 부분은 자동으로 삭제됩니다.');
//        var str = obj.value;
        var str2 = obj.value.substr(0, li_len);
        obj.value = str2;
        var cbyte = 0;
        for (var i = 0; i < obj.value.length; i++) {
            var ls_one_char = obj.value.charAt(i);
            if (escape(ls_one_char).length > 4) {
                cbyte += 2; //한글이면 2를 더한다
            } else {
                cbyte++; //한글아니면 1을 다한다
            }
        }
    }
}

/*
 * 이메일 유효성 체크 
 * */
function regEmail(obj){
	// 정규식 - 이메일 유효성 검사
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if(!regEmail.test(obj.val())) {
        //alert('이메일 주소가 유효하지 않습니다');
        //u_email.focus();
        return false;
    }
    return true;
}

/*
 * 스크립트로 URL param 값 추출
 * 변수.파라미터명
 * ex) param.id
 */
function getUrlParams() {
	var params = {};
	window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
    return params;
}


/* 
 * 
 * 같은 값이 있는 열을 병합함
 * 
 * 사용법 : $('#테이블 ID').rowspan(0);
 * 
 */    
$.fn.rowspan = function(colIdx, isStats) {       
    return this.each(function(){      
        var that;     
        $('tr', this).each(function(row) {      
            $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
                 
                if ($(this).html() == $(that).html()
                    && (!isStats 
                            || isStats && $(this).prev().html() == $(that).prev().html()
                            )
                    ) {            
                    rowspan = $(that).attr("rowspan") || 1;
                    rowspan = Number(rowspan)+1;
 
                    $(that).attr("rowspan",rowspan);
                     
                    // do your action for the colspan cell here            
                    $(this).hide();
                     
                    //$(this).remove(); 
                    // do your action for the old cell here
                     
                } else {            
                    that = this;         
                }          
                 
                // set the that if not already set
                that = (that == null) ? this : that;      
            });     
        });    
    });  
}; 
 
 
/* 
 * 
 * 같은 값이 있는 행을 병합함
 * 
 * 사용법 : $('#테이블 ID').colspan (0);
 * 
 */  
$.fn.colspan = function(rowIdx) {
    return this.each(function(){
         
        var that;
        $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
            $(this).find('th').filter(':visible').each(function(col) {
                if ($(this).html() == $(that).html()) {
                    colspan = $(that).attr("colSpan") || 1;
                    colspan = Number(colspan)+1;
                    $(that).attr("colSpan",colspan);
                    $(this).hide(); // .remove();
                } else {
                    that = this;
                }
                // set the that if not already set
                that = (that == null) ? this : that;
            });
        });
    });
};




/*
 *
 * 네이버 지도 api
*/
nhnMap = function(w,h,lat,lng,mTitle){
	var wSize = w;	// 가로
	var hSize = h;	// 세로
	
	var Lat = lat;	// 위도
	var Lng = lng;	// 경도
	
	var oPoint = new nhn.api.map.LatLng(Lat, Lng);
	var defaultLevel = 12;
	var oMap = new nhn.api.map.Map
		(
			document.getElementById('nhnMap'), 
			{ 
			point : oPoint,
			zoom : defaultLevel,
			enableWheelZoom : true,
			enableDragPan : true,
			enableDblClickZoom : false,
			mapMode : 0,
			activateTrafficMap : false,
			activateBicycleMap : false,
			minMaxLevel : [ 1, 14 ],
			size : new nhn.api.map.Size(wSize,hSize)
			}
		);
	var oInfoWnd = new nhn.api.map.InfoWindow();
	oInfoWnd.setVisible(false);
	oMap.addOverlay(oInfoWnd);

	oInfoWnd.setPosition(oPoint);
	var oSlider = new nhn.api.map.ZoomControl();
	oMap.addControl(oSlider);
	oSlider.setPosition({
			top : 400,
			left : 920
	});
	oSlider.setCenterMarkOptions(true);

	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
	
	oMap.attach('mouseenter', function(oCustomEvent) {

		var oTarget = oCustomEvent.target;
		// 마커위에 마우스 올라간거면
		if (oTarget instanceof nhn.api.map.Marker) {
				var oMarker = oTarget;
				oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
		}
	});

	oMap.attach('mouseleave', function(oCustomEvent) {

		var oTarget = oCustomEvent.target;
		// 마커위에서 마우스 나간거면
		if (oTarget instanceof nhn.api.map.Marker) {
				oLabel.setVisible(false);
		}
	});

	var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
	oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.

	var oMarker = new nhn.api.map.Marker(oIcon, { title : mTitle });
	oMarker.setPoint(oPoint);
	oMap.addOverlay(oMarker);
};




/**
 * front Utils Common
 * 151109 Leeyoonwoo
 */
var wUtils = {
    /**
     * user agent check 
     */
    agent: {
        getBrowser:function(){
            var navigatorObj = navigator.appName,
                userAgentObj = navigator.userAgent,
                matchVersion;
              var match = userAgentObj.match(/(opera|chrome|safari|firefox|msie|trident)\/?\s*(\.?\d+(\.\d+)*)/i);
              if( match && (matchVersion = userAgentObj.match(/version\/([\.\d]+)/i)) !== null) match[2] = matchVersion[1];

              //mobile
              var mobile = navigator.userAgent.match(/iPhone|Android|webOS|iPad/i);
              if (mobile) {
                return match ? [match[1], match[2], mobile] : [navigatorObj, navigator.appVersion, mobile];
              }
              // web browser
              return match ? [match[1], match[2]] : [navigatorObj, navigator.appVersion, '-?'];
        },
        /*****
         *
         * deviceOsCheck
         *  - 디바이스 체크 로직 
         *  - return
         *      pc : 현재 pc 인지 ( boolean )
         *      android : 현재 android 인지 ( boolean )
         *      androidVer : android version ( number ), android기기가 아니라면 빈 string
         *      ios : 현재 ios 인지 ( boolean )
         *      chrome25ver : 크롬브라우져 버전이 25이상인지 체크 ( boolean ), 안드로이드 내에서 브라우져 체크를 하기 위함
         *  
         */
        deviceOsCheck : function(){
          var ua = navigator.userAgent.toLowerCase(),
              _pc = ua.match(/linux|windows (nt|98)|macintosh/) && ! ua.match(/android|mobile|polaris|lgtelecom|uzard|natebrowser|ktf;|skt;/) ? true : false,
              _android = ua.match(/android/)?true:false, _androidVer = '',
              _ios = ua.match(/ip(hone|od|ad)/)?true:false,
              _chrome25ver = (ua.search("chrome") > -1 && navigator.appVersion.match(/Chrome\/\d+.\d+/)[0].split("/")[1] > 25)?true:false;
          if( _android ) _androidVer = ua.match(/android\s([0-9\.]*)/)[1];
          return{
            pc: _pc, android: _android, androidVer:_androidVer, ios: _ios,
            // Android Chrome Version Check
            chrome25ver:_chrome25ver
          }
        }
    },

    scroll: {
        /**
         * 현재의 스크롤 위치
         */
        nowScrollTop: function(){
            return $(window).scrollTop();
        },

        touchScrollBlock: function(ch){
            var $el = $('html, body, document');
            if (ch) {
                console.log('on');
                $('html, body').on('touchstart touchmove', function(e) {
                    e.preventDefault();
                }); 
           }else{
                console.log('off');
                $el.off('touchstart touchmove');
           }
            
        }
    },

    stage: {
        inner: function(){
            var w = window,
                d = document,
                e = d.documentElement,
                g = d.getElementsByTagName('body')[0],
                x = w.innerWidth || e.clientWidth || g.clientWidth,
                y = w.innerHeight|| e.clientHeight|| g.clientHeight;

            return {w:x, h:y};
        }
    }
}

//style='display:none;'

function loadingBarShow(){
	$("#loadingBar").show();
}

function loadingBarHide(){
	$("#loadingBar").hide();
}
