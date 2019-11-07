	
 $(document).ready(function(){    
     /* 작성자 : jhr
	 * 전체 선택 / 전체 해제 체크박스
	 * * */
	$("#allCheck").on("click" ,function(){
    	//alert($("#allCheck").is(":checked"));
		//전체 선택
		if($("#allCheck").is(":checked")) {
			$("input[name=selChk]").prop("checked",true);
		} else {
			//전체 해제
			$("input[name=selChk]").prop("checked",false);
		}
	});
	
	
    //엔터를 치면 로그인 함.
    $("#searchText").on("keyup",function(){
    	var keycode = event.keyCode;
    	
    	if(keycode==13){ //엔터를 치면 로그인 함.
    		$("#btn_search").click();
    	}
    });	
 });
	
	/* 작성자 : jhr
	 * 숫자에 콤마 / 소수점까지 표현  
	 * 사용 예 : 
     * <input type="text" onkeyup="inputNumberFormat(this)" />
	 * */
	
	function inputNumberFormat(obj) {
		 //obj.value = comma(uncomma(obj.value));
		obj.value = obj.value.replace(/[^\.0-9]/g, ''); 
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
		var regx = new RegExp(/(-?\d+)(\d{3})/);  
		var bExists = str.indexOf(".",0);  
		var strArr = str.split('.');  
		while(regx.test(strArr[0])){  
		strArr[0] = strArr[0].replace(regx,"$1,$2");  
		}  
		if (bExists > -1)  
		obj.value = strArr[0] + "." + strArr[1];  
		else  
		obj.value = strArr[0]; 
	}
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	/* 작성자 : jhr
	 * 숫자에 콤마 제거 
	 * */
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	/*
	 * 이메일 유효성 체크(오브젝트 타입) 
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
	 * 이메일 유효성 체크(value 타입) 
	 * */
	function regEmailValue(obj){
		// 정규식 - 이메일 유효성 검사
        var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if(!regEmail.test(obj)) {
            //alert('이메일 주소가 유효하지 않습니다');
            //u_email.focus();
            return false;
        }
        return true;
	}
	
	/*
	 * 전화번호 유효성 체크 
	 * */
	function regPhone(obj){
		// 정규식 -전화번호 유효성 검사
        var regPhone1 = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
        
        if(!regPhone1.test(obj.val())) {
            //alert('이메일 주소가 유효하지 않습니다');
            //u_email.focus();
            return false;
        }  
        return true;
	}
	
	/*
	 * 글자수 체크 : 한글 2바이트  
	 */
	function chkByteLen(obj,maximumByte){
		//var before = $count.text() * 1;
        var str_len = obj.val().length;
        var cbyte = 0;
        var li_len = 0;
        for (i = 0; i < str_len; i++) {
            var ls_one_char = obj.val().charAt(i);
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
        	return false;
        }
        return true;
	}
	
	 function chkLen(obj,maximumByte) {
         //var before = $count.text() * 1;
         var str_len = obj.value.length;
         var cbyte = 0;
         var li_len = 0;
         for (i = 0; i < str_len; i++) {
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
             var str = obj.value;
             var str2 = obj.value.substr(0, li_len);
             obj.value = str2;
             var cbyte = 0;
             for (i = 0; i < obj.value.length; i++) {
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
	  * form serialize를 json 형태를 변환함.
	  * */
	 function convertFrmToJSON(obj){
	    var array = obj.serializeArray();
	    var json = {};
	    
	    jQuery.each(array, function() {
	        json[''|| this.name || ''] = this.value || '';
	    });
	    
	    obj.find('[type=file]').each(function(i, file) {
	    	json[''|| file.name || ''] = this.value || '';
	    });
	    
	    return json;
	}
	
	/*
	 * 특수문자 입력 방지 
	 * */ 
	function fn_filterChk(name){
		 var chktext = /^s[ \{\}\[\]\/?,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;	//공백추가
		  //정규식 구문
		 var obj = document.getElementsByName(name)[0];
		 if (chktext.test(obj.value)) {
		     alert("특수문자는 입력하실 수 없습니다.");
		     jQuery("#"+name).val("");
			jQuery("#"+name).focus();
			return false;
		  }
		  return true;
	}
	
	//파일첨부 공통 팝업
	function openFileUploadPop(type, target, folderNm){
		var popUrl = "/common/fileUpload?type="+type+"&target="+target+"&folderNm="+folderNm;	//팝업창에 출력될 페이지 URL
		var popOption = "width=460, height=188, resizable=yes, scrollbars=yes, status=no, toolbar=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"",popOption);
	}		
	
	
	//직접등록 팝업
	function openPersonallyRegisterPop(type, target, folderNm, targetTbody){
		var popUrl = "/admin/popup/lookbook/popupPersonallyRegister?type="+type+"&target="+target+"&folderNm="+folderNm+"&targetTbody="+targetTbody;
		var popOption = "toolbar=no,width=700,height=500, top=200, left=30, scrollbars=no, resizable=yes";
			window.open(popUrl,"",popOption);
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
	
	// 동적으로 form 생성
	function create_form(nm,mt,ac,tg) {
	    var fm = document.createElement("form");
	    fm.name = nm;
	    fm.method = mt;
	    fm.action = ac;
	    fm.target = tg;
	      
	    return fm;
	}
	
	// 동적으로 input 객체 생성
	function add_input(fm,nm,vu){
	    var input = document.createElement("input");
	    input.type = "hidden";
	    input.name = nm;
	    input.value =  vu;
	    fm.insertBefore(input,null);
	    return fm;
	}

	
	
	// trim
	function trim(str){
    	while(str && str.indexOf(" ") == 0)
    		str = str.substring(1);
    	while(str && str.lastIndexOf(" ") == str.length-1)
    		str = str.substring(0, str.length-1);
    	return str;
    }
	
