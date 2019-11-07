<%
    /* ============================================================================== */
    /* =   PAGE : 결제 정보 환경 설정 PAGE                                          = */
    /* =----------------------------------------------------------------------------= */
    /* =   연동시 오류가 발생하는 경우 아래의 주소로 접속하셔서 확인하시기 바랍니다.= */
    /* =   접속 주소 : http://kcp.co.kr/technique.requestcode.do			        = */
    /* =----------------------------------------------------------------------------= */
    /* =   Copyright (c)  2013   KCP Inc.   All Rights Reserverd.                   = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* = ※ 주의 ※                                                                 = */
    /* = * 지불 데이터 설정                                                         = */
    /* =----------------------------------------------------------------------------= */
    /* = ※ 주의 ※                                                                 = */
	/* = * g_conf_home_dir 변수 설정                                                = */
    /* =   BIN 절대 경로 입력 (bin전까지 설정)                                      = */
    /* =                                                                            = */
    /* = * g_conf_key_dir 변수 설정                                                 = */
    /* =   pub.key 파일의 절대 경로 설정(파일명을 포함한 경로로 설정)               = */
    /* =                                                                            = */
    /* = * g_conf_log_dir 변수 설정                                                 = */
    /* =   log 디렉토리 설정                                                        = */
    /* ============================================================================== */
    String curUrl = request.getRequestURL().toString();
    String curDomain = request.getScheme()+"://"+request.getServerName();
    
    String g_conf_log_path = "/home/hosting_users/worksout2015/log";
    
    String g_conf_home_dir  = "";                  // BIN 절대경로 입력 (bin전까지) 
    String g_conf_key_dir   = "";    // 공개키 파일 절대경로 
    String g_conf_log_dir   = "";             // LOG 디렉토리 절대경로 입력
    
    //true시 UBI테이블에 연동
    boolean testCls = true;
    if(curUrl.indexOf("loc.") > -1){
    	//로컬
        g_conf_home_dir  = "d:\\workdata_zionid\\20150319_worksout\\kcp";                  // BIN 절대경로 입력 (bin전까지) 
        g_conf_key_dir   = "d:\\workdata_zionid\\20150319_worksout\\kcp\\pub_dev.key";    // 공개키 파일 절대경로 
        g_conf_log_dir   = "d:\\workdata_zionid\\20150319_worksout\\kcp\\log";             // LOG 디렉토리 절대경로 입력    	
    }else if(curUrl.indexOf("dev.") > -1){
        //개발
        g_conf_home_dir  = "d:\\kcp";                  // BIN 절대경로 입력 (bin전까지) 
        g_conf_key_dir   = "d:\\kcp\\bin\\pub.key";    // 공개키 파일 절대경로 
        g_conf_log_dir   = "d:\\kcp\\log";             // LOG 디렉토리 절대경로 입력    	
    }else{
		//운영
        g_conf_home_dir  = "/home/hosting_users/worksout2015/kcp";                  // BIN 절대경로 입력 (bin전까지) 
        g_conf_key_dir   = "/home/hosting_users/worksout2015/pub.key";    // 공개키 파일 절대경로 
        g_conf_log_dir   = "/home/hosting_users/worksout2015/log";             // LOG 디렉토리 절대경로 입력		
    }
    g_conf_home_dir  = "/home/hosting_users/worksout2015/kcp";                  // BIN 절대경로 입력 (bin전까지) 
    g_conf_key_dir   = "/home/hosting_users/worksout2015/pub.key";    // 공개키 파일 절대경로 
    g_conf_log_dir   = "/home/hosting_users/worksout2015/log";             // LOG 디렉토리 절대경로 입력
    
    /* ============================================================================== */
    /* = ※ 주의 ※                                                                 = */
    /* = * g_conf_gw_url 설정                                                       = */
    /* =----------------------------------------------------------------------------= */
    /* = 테스트 시 : testpaygw.kcp.co.kr로 설정해 주십시오.                         = */
    /* = 실결제 시 : paygw.kcp.co.kr로 설정해 주십시오.                             = */
    /* ============================================================================== */
    String g_conf_gw_url    = "paygw.kcp.co.kr";
    if(curUrl.indexOf("loc.") > -1){
    	//g_conf_gw_url    = "testpaygw.kcp.co.kr";
    	g_conf_gw_url    = "paygw.kcp.co.kr";
    }else if(curUrl.indexOf("dev.") > -1){
    	g_conf_gw_url    = "paygw.kcp.co.kr";
    }else{
    	g_conf_gw_url    = "paygw.kcp.co.kr";
    }    

    /* ============================================================================== */
    /* = ※ 주의 ※                                                                 = */
    /* = * g_conf_js_url 설정                                                       = */
    /* =----------------------------------------------------------------------------= */
	/* = 테스트 시 : src="http://pay.kcp.co.kr/plugin/payplus_test.js"              = */
	/* =             src="https://pay.kcp.co.kr/plugin/payplus_test.js"             = */
    /* = 실결제 시 : src="http://pay.kcp.co.kr/plugin/payplus.js"                   = */
	/* =             src="https://pay.kcp.co.kr/plugin/payplus.js"                  = */
    /* =                                                                            = */
	/* = 테스트 시(UTF-8) : src="http://pay.kcp.co.kr/plugin/payplus_test_un.js"    = */
	/* =                    src="https://pay.kcp.co.kr/plugin/payplus_test_un.js"   = */
    /* = 실결제 시(UTF-8) : src="http://pay.kcp.co.kr/plugin/payplus_un.js"         = */
	/* =                    src="https://pay.kcp.co.kr/plugin/payplus_un.js"        = */
    /* ============================================================================== */
    String g_conf_js_url    = "http://pay.kcp.co.kr/plugin/payplus_un.js";
    
    if(curUrl.indexOf("loc.") > -1){
    	//g_conf_js_url    = "https://pay.kcp.co.kr/plugin/payplus_test_un.js";
    	g_conf_js_url    = "http://pay.kcp.co.kr/plugin/payplus_un.js";
    }else if(curUrl.indexOf("dev.") > -1){
    	g_conf_js_url    = "http://pay.kcp.co.kr/plugin/payplus_un.js";
    }else{
    	g_conf_js_url    = "http://pay.kcp.co.kr/plugin/payplus_un.js";
    }       

    /* ============================================================================== */
    /* = 스마트폰 SOAP 통신 설정                                                    = */
    /* =----------------------------------------------------------------------------= */
    /* = 테스트 시 : false                                                          = */
    /* = 실결제 시 : true                                                           = */
    /* ============================================================================== */
    boolean g_conf_server    = true;

    /* ============================================================================== */
    /* = g_conf_site_cd, g_conf_site_key 설정                                       = */
    /* = 실결제시 KCP에서 발급한 사이트코드(site_cd), 사이트키(site_key)를 반드시   = */
    /* = 변경해 주셔야 결제가 정상적으로 진행됩니다.                                = */
    /* =----------------------------------------------------------------------------= */
    /* = 테스트 시 : 사이트코드(T0000)와 사이트키(3grptw1.zW0GSo4PQdaGvsF__)로      = */
    /* =            설정해 주십시오.                                                = */
	/* = 에스크로 테스트 시: 사이트코드(T0007)와 사이트키(4Ho4YsuOZlLXUZUdOxM1Q7X__)= */
    /* =            설정해 주십시오.                                                = */
    /* = 실결제 시 : 반드시 KCP에서 발급한 사이트코드(site_cd)와 사이트키(site_key) = */
    /* =            로 설정해 주십시오.                                             = */
    /* ============================================================================== */
    String g_conf_site_cd   = "V5594";
    String g_conf_site_key  = "3fS5puKB57rX7lHPSaVHgwF__";
    
    if(curUrl.indexOf("loc.") > -1){
    	//g_conf_site_cd   = "T0007";
        //g_conf_site_key  = "4Ho4YsuOZlLXUZUdOxM1Q7X__";
    	g_conf_site_cd   = "V5594";
        g_conf_site_key  = "3fS5puKB57rX7lHPSaVHgwF__";        
    }else if(curUrl.indexOf("dev.") > -1){
    	g_conf_site_cd   = "V5594";
        g_conf_site_key  = "3fS5puKB57rX7lHPSaVHgwF__";
    }else{
    	g_conf_site_cd   = "V5594";
        g_conf_site_key  = "3fS5puKB57rX7lHPSaVHgwF__";    	
    }           

    /* ============================================================================== */
    /* = g_conf_site_name 설정                                                      = */
    /* =----------------------------------------------------------------------------= */
    /* = 사이트명 설정(한글 불가) : 반드시 영문자로 설정하여 주시기 바랍니다.       = */
    /* ============================================================================== */
    String g_conf_site_name = "WORKSOUT";
    if(curUrl.indexOf("loc.") > -1){
    	g_conf_site_name   = "LOC_WORKSOUT";
    }else if(curUrl.indexOf("dev.") > -1){
    	g_conf_site_name   = "DEV_WORKSOUT";
    }else{
    	g_conf_site_name   = "WORKSOUT";
    }       
    
    
    /* ============================================================================== */
    /* = 지불 데이터 셋업 (변경 불가)                                               = */
    /* ============================================================================== */
    String g_conf_log_level = "5";
    String g_conf_gw_port   = "8090";        // 포트번호(변경불가)
	String module_type      = "01";          // 변경불가
    int    g_conf_tx_mode   = 0;             // 변경불가
%>
