
-- 거래처
CREATE TABLE "MACH"."TBL_AD_PTNR" (
	"PTNR_NO"              VARCHAR(20)   NOT NULL, -- 거래처번호
	"PTNR_CLS"             CHAR(7)       NULL,     -- 거래처구분
	"PTNR_NM"              VARCHAR(50)   NULL,     -- 거래처명
	"BIZ_REG_NO"           VARCHAR(20)   NULL,     -- 사업자등록번호
	"BIZ_ST"               VARCHAR(300)  NULL,     -- 업태
	"BIZ_TP"               VARCHAR(300)  NULL,     -- 업종
	"REPR_NM"              VARCHAR(20)   NOT NULL, -- 대표자명
	"TEL"                  VARCHAR(14)   NULL,     -- 전화번호
	"FAX_NO"               VARCHAR(14)   NOT NULL, -- 팩스번호
	"ADDR"                 VARCHAR(300)  NULL,     -- 주소
	"STAT"                 CHAR(7)       NULL,     -- 상태
	"BNK_NM"               VARCHAR(50)   NULL,     -- 은행명
	"ACCT_NO"              VARCHAR(20)   NULL,     -- 계좌번호
	"ACCT_OWN_NM"          VARCHAR(50)   NULL,     -- 예금주
	"CHGR_NM"              VARCHAR(50)   NULL,     -- 담당자명
	"CHGR_TEL"             VARCHAR(14)   NULL,     -- 담당자전화번호
	"CHGR_EMAIL"           VARCHAR(100)  NULL,     -- 담당자이메일
	"ETC"                  VARCHAR(4000) NULL,     -- 기타
	"COR_REG_NO"           VARCHAR(20)   NULL,     -- 법인등록번호
	"DTL_ADDR"             VARCHAR(300)  NULL,     -- 상세주소
	"ZIP_CD"               CHAR(6)       NOT NULL, -- 우편번호
	"CHGR_CPNO"            VARCHAR(14)   NULL,     -- 담당자휴대폰번호
	"CHGR_JOBPOS"          VARCHAR(20)   NULL,     -- 담당자직급
	"REP_DLV_CMPNO"        VARCHAR(20)   NULL,     -- 대표택배사번호
	"DLV_CST_PAYWAY"       CHAR(7)       NULL,     -- 배송비지불방식
	"MIN_ORD_AMT"          INTEGER       NULL,     -- 기준주문금액
	"DLV_CST"              INTEGER       NULL,     -- 배송비
	"FEE_RT"               DECIMAL(5,2)  NULL,     -- 수수료율
	"SHP_OPN_YN"           VARCHAR(20)   NULL,     -- shop개설여부
	"PRMM_SHP_OPN_YN"      VARCHAR(20)   NULL,     -- 프리미엄shop개설여부
	"FND_ADDR"             VARCHAR(4000) NULL,     -- 찾아오는길
	"PTNR_INTRO"           CLOB          NULL,     -- 거래처소개
	"INFO_IMG1"            VARCHAR(200)  NULL,     -- 소개이미지1
	"INFO_IMG2"            VARCHAR(200)  NULL,     -- 소개이미지2
	"INFO_IMG3"            VARCHAR(200)  NULL,     -- 소개이미지3
	"SND_POSB_TM"          VARCHAR(20)   NULL,     -- 발송가능시간
	"ACCT_STL_CYCL"        CHAR(7)       NULL,     -- 정산주기
	"ACCT_STL_STR_DT"      DATE          NULL,     -- 최종정산기준일
	"ACCT_STL_END_DT"      DATE          NULL,     -- 최종정산종료일
	"MAP_IMG"              VARCHAR(200)  NULL,     -- 약도이미지
	"solution"             VARCHAR(50)   NULL,     -- 밴더사솔루션
	"CHGR_FAX_NO"          VARCHAR(14)   NULL,     -- 담당자팩스번호
	"BIZ_CT"               VARCHAR(300)  NULL,     -- 종목
	"SOURCING_NAME"        VARCHAR(40)   NULL,     -- 소싱담당자
	"REG_DTS"              TIMESTAMP     NULL,     -- 등록일시
	"REGR_NO"              VARCHAR(20)   NULL,     -- 등록자
	"UPD_DTS"              TIMESTAMP     NULL,     -- 수정일시
	"UPDR_NO"              VARCHAR(20)   NULL      -- 수정자
);

-- XPK거래처
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_PTNR" ( -- 거래처
		"PTNR_NO" ASC -- 거래처번호
	);

-- 거래처
ALTER TABLE "MACH"."TBL_AD_PTNR"
	ADD
		PRIMARY KEY (
			"PTNR_NO" -- 거래처번호
		);

-- 거래처
COMMENT ON TABLE "MACH"."TBL_AD_PTNR" IS '거래처';

-- 거래처번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."PTNR_NO" IS '거래처번호';

-- 거래처구분
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."PTNR_CLS" IS '거래처구분';

-- 거래처명
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."PTNR_NM" IS '거래처명';

-- 사업자등록번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."BIZ_REG_NO" IS '사업자등록번호';

-- 업태
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."BIZ_ST" IS '업태';

-- 업종
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."BIZ_TP" IS '업종';

-- 대표자명
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."REPR_NM" IS '대표자명';

-- 전화번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."TEL" IS '전화번호';

-- 팩스번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."FAX_NO" IS '팩스번호';

-- 주소
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ADDR" IS '주소';

-- 상태
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."STAT" IS '상태';

-- 은행명
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."BNK_NM" IS '은행명';

-- 계좌번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ACCT_NO" IS '계좌번호';

-- 예금주
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ACCT_OWN_NM" IS '예금주';

-- 담당자명
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_NM" IS '담당자명';

-- 담당자전화번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_TEL" IS '담당자전화번호';

-- 담당자이메일
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_EMAIL" IS '담당자이메일';

-- 기타
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ETC" IS '기타';

-- 법인등록번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."COR_REG_NO" IS '법인등록번호';

-- 상세주소
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."DTL_ADDR" IS '상세주소';

-- 우편번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ZIP_CD" IS '우편번호';

-- 담당자휴대폰번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_CPNO" IS '담당자휴대폰번호';

-- 담당자직급
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_JOBPOS" IS '담당자직급';

-- 대표택배사번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."REP_DLV_CMPNO" IS '대표택배사번호';

-- 배송비지불방식
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."DLV_CST_PAYWAY" IS '배송비지불방식';

-- 기준주문금액
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."MIN_ORD_AMT" IS '기준주문금액';

-- 배송비
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."DLV_CST" IS '배송비';

-- 수수료율
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."FEE_RT" IS '수수료율';

-- shop개설여부
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."SHP_OPN_YN" IS 'shop개설여부';

-- 프리미엄shop개설여부
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."PRMM_SHP_OPN_YN" IS '프리미엄shop개설여부';

-- 찾아오는길
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."FND_ADDR" IS '찾아오는길';

-- 거래처소개
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."PTNR_INTRO" IS '거래처소개';

-- 소개이미지1
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."INFO_IMG1" IS '소개이미지1';

-- 소개이미지2
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."INFO_IMG2" IS '소개이미지2';

-- 소개이미지3
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."INFO_IMG3" IS '소개이미지3';

-- 발송가능시간
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."SND_POSB_TM" IS '발송가능시간';

-- 정산주기
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ACCT_STL_CYCL" IS '정산주기';

-- 최종정산기준일
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ACCT_STL_STR_DT" IS '최종정산기준일';

-- 최종정산종료일
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."ACCT_STL_END_DT" IS '최종정산종료일';

-- 약도이미지
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."MAP_IMG" IS '약도이미지';

-- 밴더사솔루션
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."solution" IS '밴더사솔루션';

-- 담당자팩스번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."CHGR_FAX_NO" IS '담당자팩스번호';

-- 종목
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."BIZ_CT" IS '종목';

-- 소싱담당자
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."SOURCING_NAME" IS '소싱담당자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."REG_DTS" IS '등록일시';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."REGR_NO" IS '등록자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."UPD_DTS" IS '수정일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_PTNR"."UPDR_NO" IS '수정자';

-- XPK거래처
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK거래처';

-- 사용자권한그룹
CREATE TABLE "MACH"."TBL_AD_USER_AUTH_GRP" (
	"USER_NO"     VARCHAR(20) NOT NULL, -- 사용자번호
	"AUTH_GRP_NO" VARCHAR(20) NOT NULL, -- 권한그룹번호
	"REGR_NO"     VARCHAR(20) NULL,     -- 등록자
	"REG_DTS"     TIMESTAMP   NULL,     -- 등록일시
	"UPDR_NO"     VARCHAR(20) NULL,     -- 수정자
	"UPD_DTS"     TIMESTAMP   NULL      -- 수정일시
);

-- XPK사용자권한그룹
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_USER_AUTH_GRP" ( -- 사용자권한그룹
		"USER_NO"     ASC, -- 사용자번호
		"AUTH_GRP_NO" ASC  -- 권한그룹번호
	);

-- 사용자권한그룹
ALTER TABLE "MACH"."TBL_AD_USER_AUTH_GRP"
	ADD
		PRIMARY KEY (
			"USER_NO",     -- 사용자번호
			"AUTH_GRP_NO"  -- 권한그룹번호
		);

-- 사용자권한그룹
COMMENT ON TABLE "MACH"."TBL_AD_USER_AUTH_GRP" IS '사용자권한그룹';

-- 사용자번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."USER_NO" IS '사용자번호';

-- 권한그룹번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."AUTH_GRP_NO" IS '권한그룹번호';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_USER_AUTH_GRP"."UPD_DTS" IS '수정일시';

-- XPK사용자권한그룹
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK사용자권한그룹';

-- 코드
CREATE TABLE "MACH"."TBL_AD_CD" (
	"CD_NO"          CHAR(7)       NOT NULL, -- 코드번호
	"SUP_CD_NO"      CHAR(7)       NULL,     -- 상위코드번호
	"CD_NM"          VARCHAR(50)   NULL,     -- 코드명
	"CD_DESC"        VARCHAR(4000) NULL,     -- 코드설명
	"CD_TP"          CHAR(7)       NULL,     -- 코드유형
	"WRK_CLS_CD"     CHAR(2)       NULL,     -- 업무분류코드
	"PRIR"           SMALLINT      NULL,     -- 우선순위
	"USE_YN"         CHAR(1)       NULL,     -- 사용여부
	"REGR_NO"        VARCHAR(20)   NULL,     -- 등록자
	"REG_DTS"        TIMESTAMP     NULL,     -- 등록일시
	"UPDR_NO"        VARCHAR(20)   NULL,     -- 수정자
	"UPD_DTS"        TIMESTAMP     NULL      -- 수정일시
);

-- XPK코드
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_CD" ( -- 코드
		"CD_NO" ASC -- 코드번호
	);

-- 코드
ALTER TABLE "MACH"."TBL_AD_CD"
	ADD
		PRIMARY KEY (
			"CD_NO" -- 코드번호
		);

-- 코드
COMMENT ON TABLE "MACH"."TBL_AD_CD" IS '코드';

-- 코드번호
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."CD_NO" IS '코드번호';

-- 상위코드번호
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."SUP_CD_NO" IS '상위코드번호';

-- 코드명
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."CD_NM" IS '코드명';

-- 코드설명
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."CD_DESC" IS '코드설명';

-- 코드유형
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."CD_TP" IS '코드유형';

-- 업무분류코드
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."WRK_CLS_CD" IS '업무분류코드';

-- 우선순위
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."PRIR" IS '우선순위';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."USE_YN" IS '사용여부';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_CD"."UPD_DTS" IS '수정일시';

-- XPK코드
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK코드';

-- 메뉴
CREATE TABLE "MACH"."TBL_AD_MENU" (
	"MENU_NO"            VARCHAR(20)  NOT NULL, -- 메뉴번호
	"SUP_MENU_NO"        VARCHAR(20)  NULL,     -- 상위메뉴번호
	"MENU_NM"            VARCHAR(200) NULL,     -- 메뉴명
	"MENU_TP"            CHAR(7)      NULL,     -- 메뉴유형
	"PAGE_URL"           VARCHAR(200) NULL,     -- 페이지URL
	"USE_YN"             CHAR(1)      NOT NULL, -- 사용여부
	"SYS_CLS"            CHAR(7)      NULL,     -- 시스템구분
	"PRIR"               SMALLINT     NULL,     -- 우선순위
	"REGR_NO"            VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"            TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"            VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"            TIMESTAMP    NULL      -- 수정일시
);

-- XPK메뉴
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_MENU" ( -- 메뉴
		"MENU_NO" ASC -- 메뉴번호
	);

-- 메뉴
ALTER TABLE "MACH"."TBL_AD_MENU"
	ADD
		PRIMARY KEY (
			"MENU_NO" -- 메뉴번호
		);

-- 메뉴
COMMENT ON TABLE "MACH"."TBL_AD_MENU" IS '메뉴';

-- 메뉴번호
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."MENU_NO" IS '메뉴번호';

-- 상위메뉴번호
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."SUP_MENU_NO" IS '상위메뉴번호';

-- 메뉴명
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."MENU_NM" IS '메뉴명';

-- 메뉴유형
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."MENU_TP" IS '메뉴유형';

-- 페이지URL
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."PAGE_URL" IS '페이지URL';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."USE_YN" IS '사용여부';

-- 시스템구분
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."SYS_CLS" IS '시스템구분';

-- 우선순위
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."PRIR" IS '우선순위';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_MENU"."UPD_DTS" IS '수정일시';

-- XPK메뉴
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK메뉴';

-- 공휴일관리달력
CREATE TABLE "MACH"."TBL_AD_HOLYDAY_MNG_CAL" (
	"DT"           DATE         NOT NULL, -- 날짜
	"WKDY_CD"      CHAR(1)      NULL,     -- 요일코드
	"HOLIDAY_YN"   CHAR(1)      NULL,     -- 휴일여부
	"HOLIDAY_DESC" VARCHAR(100) NULL,     -- 휴일설명
	"REGR_NO"      VARCHAR(20)  NOT NULL, -- 등록자
	"REG_DTS"      TIMESTAMP    NULL,     -- 등록일시
	"UPD_DTS"      TIMESTAMP    NULL,     -- 수정일시
	"UPDR_NO"      VARCHAR(20)  NULL      -- 수정자
);

-- XPK공휴일관리달력
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_HOLYDAY_MNG_CAL" ( -- 공휴일관리달력
		"DT" ASC -- 날짜
	);

-- 공휴일관리달력
ALTER TABLE "MACH"."TBL_AD_HOLYDAY_MNG_CAL"
	ADD
		PRIMARY KEY (
			"DT" -- 날짜
		);

-- 공휴일관리달력
COMMENT ON TABLE "MACH"."TBL_AD_HOLYDAY_MNG_CAL" IS '공휴일관리달력';

-- 날짜
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."DT" IS '날짜';

-- 요일코드
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."WKDY_CD" IS '요일코드';

-- 휴일여부
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."HOLIDAY_YN" IS '휴일여부';

-- 휴일설명
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."HOLIDAY_DESC" IS '휴일설명';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."REG_DTS" IS '등록일시';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."UPD_DTS" IS '수정일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_HOLYDAY_MNG_CAL"."UPDR_NO" IS '수정자';

-- XPK공휴일관리달력
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK공휴일관리달력';

-- 권한그룹
CREATE TABLE "MACH"."TBL_AD_AUTH_GRP" (
	"AUTH_GRP_NO"        VARCHAR(20)   NOT NULL, -- 권한그룹번호
	"AUTH_GRP_NM"        VARCHAR(50)   NULL,     -- 권한그룹명
	"SYS_CLS"            CHAR(7)       NULL,     -- 시스템구분
	"USE_YN"             CHAR(1)       NOT NULL, -- 사용여부
	"AUTH_GRP_DESC"      VARCHAR(4000) NULL,     -- 권한그룹설명
	"REGR_NO"            VARCHAR(20)   NULL,     -- 등록자
	"REG_DTS"            TIMESTAMP     NULL,     -- 등록일시
	"UPDR_NO"            VARCHAR(20)   NULL,     -- 수정자
	"UPD_DTS"            TIMESTAMP     NULL      -- 수정일시
);

-- XPK권한그룹
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_AUTH_GRP" ( -- 권한그룹
		"AUTH_GRP_NO" ASC -- 권한그룹번호
	);

-- 권한그룹
ALTER TABLE "MACH"."TBL_AD_AUTH_GRP"
	ADD
		PRIMARY KEY (
			"AUTH_GRP_NO" -- 권한그룹번호
		);

-- 권한그룹
COMMENT ON TABLE "MACH"."TBL_AD_AUTH_GRP" IS '권한그룹';

-- 권한그룹번호
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."AUTH_GRP_NO" IS '권한그룹번호';

-- 권한그룹명
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."AUTH_GRP_NM" IS '권한그룹명';

-- 시스템구분
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."SYS_CLS" IS '시스템구분';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."USE_YN" IS '사용여부';

-- 권한그룹설명
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."AUTH_GRP_DESC" IS '권한그룹설명';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_AUTH_GRP"."UPD_DTS" IS '수정일시';

-- XPK권한그룹
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK권한그룹';

-- 접근가능권한
CREATE TABLE "MACH"."TBL_AD_ACCESS_AUTH" (
	"AUTH_GRP_NO" VARCHAR(20) NOT NULL, -- 권한그룹번호
	"MENU_NO"     VARCHAR(20) NOT NULL, -- 메뉴번호
	"REG_DTS"     TIMESTAMP   NULL,     -- 등록일시
	"REGR_NO"     VARCHAR(20) NULL,     -- 등록자
	"UPD_DTS"     TIMESTAMP   NULL,     -- 수정일시
	"UPDR_NO"     VARCHAR(20) NULL      -- 수정자
);

-- XPK접근가능권한
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_ACCESS_AUTH" ( -- 접근가능권한
		"AUTH_GRP_NO" ASC, -- 권한그룹번호
		"MENU_NO"     ASC  -- 메뉴번호
	);

-- 접근가능권한
ALTER TABLE "MACH"."TBL_AD_ACCESS_AUTH"
	ADD
		PRIMARY KEY (
			"AUTH_GRP_NO", -- 권한그룹번호
			"MENU_NO"      -- 메뉴번호
		);

-- 접근가능권한
COMMENT ON TABLE "MACH"."TBL_AD_ACCESS_AUTH" IS '접근가능권한';

-- 권한그룹번호
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."AUTH_GRP_NO" IS '권한그룹번호';

-- 메뉴번호
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."MENU_NO" IS '메뉴번호';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."REG_DTS" IS '등록일시';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."REGR_NO" IS '등록자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."UPD_DTS" IS '수정일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_ACCESS_AUTH"."UPDR_NO" IS '수정자';

-- XPK접근가능권한
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK접근가능권한';

-- 사용자
CREATE TABLE "MACH"."TBL_AD_USER" (
	"USER_NO"            VARCHAR(20)  NOT NULL, -- 사용자번호
	"ID"                 VARCHAR(20)  NULL,     -- 아이디
	"PWD"                VARCHAR(20)  NULL,     -- 패스워드
	"BELONGTO_CLS"       CHAR(7)      NULL,     -- 소속구분
	"BELONGTO_NO"        VARCHAR(20)  NULL,     -- 소속번호
	"SYS_CLS"            CHAR(7)      NULL,     -- 시스템구분
	"USER_NM"            VARCHAR(50)  NULL,     -- 사용자명
	"EMAIL"              VARCHAR(100) NULL,     -- 이메일
	"CP_NO"              VARCHAR(14)  NULL,     -- 휴대폰번호
	"USE_YN"             CHAR(1)      NOT NULL, -- 사용여부
	"TEL"                VARCHAR(14)  NULL,     -- 전화번호
	"SALE_SMS_YN"        CHAR(1)      NULL,     -- 매출SMS수신여부
	"REGR_NO"            VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"            TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"            VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"            TIMESTAMP    NULL      -- 수정일시
);

-- XPK사용자
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_USER" ( -- 사용자
		"USER_NO" ASC -- 사용자번호
	);

-- 사용자
ALTER TABLE "MACH"."TBL_AD_USER"
	ADD
		PRIMARY KEY (
			"USER_NO" -- 사용자번호
		);

-- 사용자
COMMENT ON TABLE "MACH"."TBL_AD_USER" IS '사용자';

-- 사용자번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."USER_NO" IS '사용자번호';

-- 아이디
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."ID" IS '아이디';

-- 패스워드
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."PWD" IS '패스워드';

-- 소속구분
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."BELONGTO_CLS" IS '소속구분';

-- 소속번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."BELONGTO_NO" IS '소속번호';

-- 시스템구분
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."SYS_CLS" IS '시스템구분';

-- 사용자명
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."USER_NM" IS '사용자명';

-- 이메일
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."EMAIL" IS '이메일';

-- 휴대폰번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."CP_NO" IS '휴대폰번호';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."USE_YN" IS '사용여부';

-- 전화번호
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."TEL" IS '전화번호';

-- 매출SMS수신여부
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."SALE_SMS_YN" IS '매출SMS수신여부';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_USER"."UPD_DTS" IS '수정일시';

-- XPK사용자
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK사용자';

-- 부서
CREATE TABLE "MACH"."TBL_AD_DEPT" (
	"DEPT_NO"     VARCHAR(20) NOT NULL, -- 부서번호
	"SUP_DEPT_NO" VARCHAR(20) NULL,     -- 상위부서번호
	"DEPT_NM"     VARCHAR(50) NULL,     -- 부서명
	"TEL"         VARCHAR(14) NULL,     -- 전화번호
	"FAX_NO"      VARCHAR(14) NULL,     -- 팩스번호
	"CHGR_NM"     VARCHAR(50) NULL,     -- 담당자명
	"USE_YN"      CHAR(1)     NOT NULL, -- 사용여부
	"REGR_NO"     VARCHAR(20) NULL,     -- 등록자
	"REG_DTS"     TIMESTAMP   NULL,     -- 등록일시
	"UPDR_NO"     VARCHAR(20) NULL,     -- 수정자
	"UPD_DTS"     TIMESTAMP   NULL      -- 수정일시
);

-- XPK부서
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_DEPT" ( -- 부서
		"DEPT_NO" ASC -- 부서번호
	);

-- 부서
ALTER TABLE "MACH"."TBL_AD_DEPT"
	ADD
		PRIMARY KEY (
			"DEPT_NO" -- 부서번호
		);

-- 부서
COMMENT ON TABLE "MACH"."TBL_AD_DEPT" IS '부서';

-- 부서번호
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."DEPT_NO" IS '부서번호';

-- 상위부서번호
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."SUP_DEPT_NO" IS '상위부서번호';

-- 부서명
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."DEPT_NM" IS '부서명';

-- 전화번호
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."TEL" IS '전화번호';

-- 팩스번호
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."FAX_NO" IS '팩스번호';

-- 담당자명
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."CHGR_NM" IS '담당자명';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."USE_YN" IS '사용여부';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_DEPT"."UPD_DTS" IS '수정일시';

-- XPK부서
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK부서';

-- 택배사
CREATE TABLE "MACH"."TBL_AD_DLV_CMP" (
	"DLV_CMP_NO"   VARCHAR(20)  NOT NULL, -- 택배사번호
	"ADDR"         VARCHAR(300) NULL,     -- 주소
	"CHGR_NM"      VARCHAR(50)  NULL,     -- 담당자명
	"TEL"          VARCHAR(14)  NULL,     -- 전화번호
	"FAX_NO"       VARCHAR(14)  NULL,     -- 팩스번호
	"ZIP_CD"       CHAR(6)      NOT NULL, -- 우편번호
	"DLV_SRCH_URL" VARCHAR(200) NULL,     -- 배송조회페이지
	"DLV_RS_PAGE"  VARCHAR(200) NULL,     -- 배송결과페이지
	"USE_YN"       CHAR(1)      NOT NULL, -- 사용여부
	"DLV_CMP_NM"   VARCHAR(50)  NULL,     -- 택배사명
	"DTL_ADDR"     VARCHAR(300) NULL,     -- 상세주소
	"REGR_NO"      VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"      TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"      VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"      TIMESTAMP    NULL      -- 수정일시
);

-- XPK택배사
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_DLV_CMP" ( -- 택배사
		"DLV_CMP_NO" ASC -- 택배사번호
	);

-- 택배사
ALTER TABLE "MACH"."TBL_AD_DLV_CMP"
	ADD
		PRIMARY KEY (
			"DLV_CMP_NO" -- 택배사번호
		);

-- 택배사
COMMENT ON TABLE "MACH"."TBL_AD_DLV_CMP" IS '택배사';

-- 택배사번호
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."DLV_CMP_NO" IS '택배사번호';

-- 주소
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."ADDR" IS '주소';

-- 담당자명
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."CHGR_NM" IS '담당자명';

-- 전화번호
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."TEL" IS '전화번호';

-- 팩스번호
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."FAX_NO" IS '팩스번호';

-- 우편번호
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."ZIP_CD" IS '우편번호';

-- 배송조회페이지
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."DLV_SRCH_URL" IS '배송조회페이지';

-- 배송결과페이지
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."DLV_RS_PAGE" IS '배송결과페이지';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."USE_YN" IS '사용여부';

-- 택배사명
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."DLV_CMP_NM" IS '택배사명';

-- 상세주소
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."DTL_ADDR" IS '상세주소';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_DLV_CMP"."UPD_DTS" IS '수정일시';

-- XPK택배사
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK택배사';

-- 우편번호
CREATE TABLE "MACH"."TBL_AD_ZIP_CD" (
	"ZIP_CD"         CHAR(6)      NOT NULL, -- 우편번호
	"SEQ"            VARCHAR(3)   NOT NULL, -- 일련번호
	"SD"             VARCHAR(60)  NULL,     -- 시도
	"SGG"            VARCHAR(60)  NULL,     -- 시군구
	"UMD"            VARCHAR(100) NULL,     -- 읍면동
	"RI"             VARCHAR(60)  NULL,     -- 리
	"ISLD"           VARCHAR(100) NULL,     -- 도서
	"BUNJI"          CHAR(7)      NULL,     -- 산/번지
	"BEG_PRM_BUNJI"  VARCHAR(20)  NULL,     -- 시작주번지
	"BEG_SUB_BUNJI"  VARCHAR(20)  NULL,     -- 시작부번지
	"LST_PRM_BUNJI"  VARCHAR(20)  NULL,     -- 끝주번지
	"LST_SUB_BUNJI"  VARCHAR(20)  NULL,     -- 끝부번지
	"BDNG_NM"        VARCHAR(100) NULL,     -- 건물명
	"BEG_DONG"       VARCHAR(60)  NULL,     -- 시작동
	"LST_DONG"       VARCHAR(60)  NULL,     -- 끝동
	"ADDR"           VARCHAR(300) NULL,     -- 주소
	"AREA_CD"        VARCHAR(20)  NULL,     -- 지역코드
	"USE_YN"         CHAR(1)      NOT NULL, -- 사용여부
	"CHNG_DT"        DATE         NULL      -- 변경일자
);

-- XPK우편번호
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_ZIP_CD" ( -- 우편번호
		"ZIP_CD" ASC, -- 우편번호
		"SEQ"    ASC  -- 일련번호
	);

-- 우편번호
ALTER TABLE "MACH"."TBL_AD_ZIP_CD"
	ADD
		PRIMARY KEY (
			"ZIP_CD", -- 우편번호
			"SEQ"     -- 일련번호
		);

-- 우편번호
COMMENT ON TABLE "MACH"."TBL_AD_ZIP_CD" IS '우편번호';

-- 우편번호
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."ZIP_CD" IS '우편번호';

-- 일련번호
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."SEQ" IS '일련번호';

-- 시도
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."SD" IS '시도';

-- 시군구
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."SGG" IS '시군구';

-- 읍면동
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."UMD" IS '읍면동';

-- 리
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."RI" IS '리';

-- 도서
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."ISLD" IS '도서';

-- 산/번지
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."BUNJI" IS '산/번지';

-- 시작주번지
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."BEG_PRM_BUNJI" IS '시작주번지';

-- 시작부번지
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."BEG_SUB_BUNJI" IS '시작부번지';

-- 끝주번지
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."LST_PRM_BUNJI" IS '끝주번지';

-- 끝부번지
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."LST_SUB_BUNJI" IS '끝부번지';

-- 건물명
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."BDNG_NM" IS '건물명';

-- 시작동
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."BEG_DONG" IS '시작동';

-- 끝동
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."LST_DONG" IS '끝동';

-- 주소
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."ADDR" IS '주소';

-- 지역코드
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."AREA_CD" IS '지역코드';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."USE_YN" IS '사용여부';

-- 변경일자
COMMENT ON COLUMN "MACH"."TBL_AD_ZIP_CD"."CHNG_DT" IS '변경일자';

-- XPK우편번호
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK우편번호';

-- 정책
CREATE TABLE "MACH"."TBL_AD_PLCY" (
	"PLCY_CD"        VARCHAR(20)   NOT NULL, -- 정책코드
	"PLCY_NM"        VARCHAR(50)   NULL,     -- 정책명
	"PLCY_DESC"      VARCHAR(4000) NULL,     -- 정책설명
	"PLCY_TP"        CHAR(7)       NULL,     -- 정책유형
	"PRIR"           SMALLINT      NULL,     -- 우선순위
	"USE_YN"         CHAR(1)       NOT NULL, -- 사용여부
	"SUP_PLCY_CD"    VARCHAR(20)   NULL,     -- 상위정책코드
	"UNT"            VARCHAR(10)   NULL,     -- 단위
	"PLCY_VAL"       INTEGER       NULL,     -- 정책값
	"REGR_NO"        VARCHAR(20)   NULL,     -- 등록자
	"REG_DTS"        TIMESTAMP     NULL,     -- 등록일시
	"UPDR_NO"        VARCHAR(20)   NULL,     -- 수정자
	"UPD_DTS"        TIMESTAMP     NULL      -- 수정일시
);

-- XPK정책
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_PLCY" ( -- 정책
		"PLCY_CD" ASC -- 정책코드
	);

-- 정책
ALTER TABLE "MACH"."TBL_AD_PLCY"
	ADD
		PRIMARY KEY (
			"PLCY_CD" -- 정책코드
		);

-- 정책
COMMENT ON TABLE "MACH"."TBL_AD_PLCY" IS '정책';

-- 정책코드
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PLCY_CD" IS '정책코드';

-- 정책명
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PLCY_NM" IS '정책명';

-- 정책설명
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PLCY_DESC" IS '정책설명';

-- 정책유형
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PLCY_TP" IS '정책유형';

-- 우선순위
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PRIR" IS '우선순위';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."USE_YN" IS '사용여부';

-- 상위정책코드
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."SUP_PLCY_CD" IS '상위정책코드';

-- 단위
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."UNT" IS '단위';

-- 정책값
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."PLCY_VAL" IS '정책값';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_PLCY"."UPD_DTS" IS '수정일시';

-- XPK정책
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK정책';

-- 거래처이력
CREATE TABLE "MACH"."TBL_AD_PTNRHIST" (
	"PTNR_NO"        VARCHAR(20)  NOT NULL, -- 거래처번호
	"HIST_NO"        INTEGER      NOT NULL, -- 이력번호
	"FEE_RT"         DECIMAL(5,2) NULL,     -- 수수료율
	"DLV_CST_PAYWAY" CHAR(7)      NULL,     -- 배송비지불방식
	"MIN_ORD_AMT"    INTEGER      NULL,     -- 기준주문금액
	"DLV_CST"        INTEGER      NULL,     -- 배송비
	"REGR_NO"        VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"        TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"        VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"        TIMESTAMP    NULL      -- 수정일시
);

-- XPK거래처이력
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_PTNRHIST" ( -- 거래처이력
		"PTNR_NO" ASC, -- 거래처번호
		"HIST_NO" ASC  -- 이력번호
	);

-- 거래처이력
ALTER TABLE "MACH"."TBL_AD_PTNRHIST"
	ADD
		PRIMARY KEY (
			"PTNR_NO", -- 거래처번호
			"HIST_NO"  -- 이력번호
		);

-- 거래처이력
COMMENT ON TABLE "MACH"."TBL_AD_PTNRHIST" IS '거래처이력';

-- 거래처번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."PTNR_NO" IS '거래처번호';

-- 이력번호
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."HIST_NO" IS '이력번호';

-- 수수료율
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."FEE_RT" IS '수수료율';

-- 배송비지불방식
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."DLV_CST_PAYWAY" IS '배송비지불방식';

-- 기준주문금액
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."MIN_ORD_AMT" IS '기준주문금액';

-- 배송비
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."DLV_CST" IS '배송비';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_PTNRHIST"."UPD_DTS" IS '수정일시';

-- XPK거래처이력
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK거래처이력';

-- SMS문구관리
CREATE TABLE "MACH"."TBL_AD_SMS_MNG" (
	"MNG_NO"    VARCHAR(20)  NOT NULL, -- 관리번호
	"MNG_TITLE" VARCHAR(100) NULL,     -- 관리제목
	"SMS_TXT"   VARCHAR(200) NULL,     -- SMS내용
	"REGR_NO"   VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"   TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"   VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"   TIMESTAMP    NULL      -- 수정일시
);

-- XPKSMS문구관리
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_SMS_MNG" ( -- SMS문구관리
		"MNG_NO" ASC -- 관리번호
	);

-- SMS문구관리
ALTER TABLE "MACH"."TBL_AD_SMS_MNG"
	ADD
		PRIMARY KEY (
			"MNG_NO" -- 관리번호
		);

-- SMS문구관리
COMMENT ON TABLE "MACH"."TBL_AD_SMS_MNG" IS 'SMS문구관리';

-- 관리번호
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."MNG_NO" IS '관리번호';

-- 관리제목
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."MNG_TITLE" IS '관리제목';

-- SMS내용
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."SMS_TXT" IS 'SMS내용';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_SMS_MNG"."UPD_DTS" IS '수정일시';

-- XPKSMS문구관리
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPKSMS문구관리';

-- 몰
CREATE TABLE "MACH"."TBL_AD_MALL" (
	"MALL_ID"                  VARCHAR(20)  NOT NULL, -- 몰ID
	"MALL_NM"                  VARCHAR(50)  NULL,     -- 몰명
	"MALL_TYPE"                VARCHAR(7)   NULL,     -- 몰형태
	"MALL_CSS"                 VARCHAR(7)   NULL,     -- 몰사용CSS
	"MALL_URL"                 VARCHAR(100) NULL,     -- 몰대표URL
	"MAIN_CSS"                 VARCHAR(20)  NULL,     -- 몰메인CSS
	"PG ID"                    VARCHAR(40)  NULL,     -- PG ID
	"PG PW"                    VARCHAR(40)  NULL,     -- PG PW
	"MEMBER_TYPE"              VARCHAR(7)   NULL,     -- 회원종류
	"LOGIN_TYPE"               VARCHAR(7)   NULL,     -- 로그인방법
	"PNT_USE_YN"               VARCHAR(1)   NULL,     -- 포인트사용여부
	"RSV_USE_YN"               VARCHAR(1)   NULL,     -- 적립금사용여부
	"MARGIN_YN"                VARCHAR(1)   NULL,     -- 마진율사용여부
	"MARGIN_RATE"              NUMERIC(5)   NULL,     -- 마진율
	"SEC_KEY_TYPE"             VARCHAR(7)   NULL,     -- 인증키종류
	"SEC_KEY_TYPE_NM"          VARCHAR(40)  NULL,     -- 인증키종류명
	"NAVI_DEPTH"               VARCHAR(1)   NULL,     -- TopNavi Depth
	"PRIR"                     NUMERIC(5)   NULL,     -- 우선순위
	"USE_YN"                   VARCHAR(1)   NULL,     -- 사용여부
	"COMPANY_CODE"             VARCHAR(10)  NULL,     -- 회사코드
	"AO_DEPT_CODE"             VARCHAR(10)  NULL,     -- 매출부서코드
	"AO_ID"                    VARCHAR(20)  NULL,     -- 매출ID
	"SG_CODE"                  VARCHAR(5)   NULL,     -- 소싱그룹코드
	"V_BIZ_NO"                 VARCHAR(20)  NULL,     -- 가상사업자번호
	"CP_PAY_USE_YN"            CHAR(1)      NULL,     -- 휴대폰결제 사용여부
	"BUY_WAY"                  VARCHAR(20)  NULL,     -- 구매방식
	"MALL_CHG_NO"              VARCHAR(20)  NULL,     -- 몰담당자
	"DEPT_NM"                  VARCHAR(100) NULL,     -- 부서명
	"DEPT_CD"                  VARCHAR(20)  NULL,     -- 부서코드
	"ORG_NM"                   VARCHAR(100) NULL,     -- 조직명
	"ORG_CD"                   VARCHAR(20)  NULL,     -- 조직코드
	"MALL_PW"                  VARCHAR(40)  NULL,     -- 몰 PW
	"REGR_NO"                  VARCHAR(20)  NULL,     -- 등록자
	"REG_DTS"                  TIMESTAMP    NULL,     -- 등록일시
	"UPDR_NO"                  VARCHAR(20)  NULL,     -- 수정자
	"UPD_DTS"                  TIMESTAMP    NULL      -- 수정일시
);

-- XPK몰
CREATE UNIQUE INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}"
	ON "MACH"."TBL_AD_MALL" ( -- 몰
		"MALL_ID" ASC -- 몰ID
	);

-- 몰
ALTER TABLE "MACH"."TBL_AD_MALL"
	ADD
		PRIMARY KEY (
			"MALL_ID" -- 몰ID
		);

-- 몰
COMMENT ON TABLE "MACH"."TBL_AD_MALL" IS '몰';

-- 몰ID
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_ID" IS '몰ID';

-- 몰명
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_NM" IS '몰명';

-- 몰형태
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_TYPE" IS '몰형태';

-- 몰사용CSS
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_CSS" IS '몰사용CSS';

-- 몰대표URL
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_URL" IS '몰대표URL';

-- 몰메인CSS
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MAIN_CSS" IS '몰메인CSS';

-- PG ID
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."PG ID" IS 'PG ID';

-- PG PW
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."PG PW" IS 'PG PW';

-- 회원종류
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MEMBER_TYPE" IS '회원종류';

-- 로그인방법
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."LOGIN_TYPE" IS '로그인방법';

-- 포인트사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."PNT_USE_YN" IS '포인트사용여부';

-- 적립금사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."RSV_USE_YN" IS '적립금사용여부';

-- 마진율사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MARGIN_YN" IS '마진율사용여부';

-- 마진율
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MARGIN_RATE" IS '마진율';

-- 인증키종류
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."SEC_KEY_TYPE" IS '인증키종류';

-- 인증키종류명
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."SEC_KEY_TYPE_NM" IS '인증키종류명';

-- TopNavi Depth
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."NAVI_DEPTH" IS 'TopNavi Depth';

-- 우선순위
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."PRIR" IS '우선순위';

-- 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."USE_YN" IS '사용여부';

-- 회사코드
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."COMPANY_CODE" IS '회사코드';

-- 매출부서코드
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."AO_DEPT_CODE" IS '매출부서코드';

-- 매출ID
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."AO_ID" IS '매출ID';

-- 소싱그룹코드
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."SG_CODE" IS '소싱그룹코드';

-- 가상사업자번호
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."V_BIZ_NO" IS '가상사업자번호';

-- 휴대폰결제 사용여부
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."CP_PAY_USE_YN" IS '휴대폰결제 사용여부';

-- 구매방식
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."BUY_WAY" IS '구매방식';

-- 몰담당자
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_CHG_NO" IS '몰담당자';

-- 부서명
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."DEPT_NM" IS '부서명';

-- 부서코드
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."DEPT_CD" IS '부서코드';

-- 조직명
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."ORG_NM" IS '조직명';

-- 조직코드
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."ORG_CD" IS '조직코드';

-- 몰 PW
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."MALL_PW" IS '몰 PW';

-- 등록자
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."REGR_NO" IS '등록자';

-- 등록일시
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."REG_DTS" IS '등록일시';

-- 수정자
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."UPDR_NO" IS '수정자';

-- 수정일시
COMMENT ON COLUMN "MACH"."TBL_AD_MALL"."UPD_DTS" IS '수정일시';

-- XPK몰
COMMENT ON INDEX "MACH"."%If (%==(%KeyType, PK)) {PK} %Else {IDX}_%Substr(%TableName,5)%If (%!=(%KeyType, PK)) {_0%Substr(%KeyType,3)}" IS 'XPK몰';

-- 거래처
ALTER TABLE "MACH"."TBL_AD_PTNR"
	ADD
		CONSTRAINT "R/438" -- R/438
		FOREIGN KEY (
			"REP_DLV_CMPNO" -- 대표택배사번호
		)
		REFERENCES "MACH"."TBL_AD_DLV_CMP" ( -- 택배사
			"DLV_CMP_NO" -- 택배사번호
		);

-- R/438
COMMENT ON CONSTRAINT "MACH"."TBL_AD_PTNR"."R/438" IS 'R/438';

-- 사용자권한그룹
ALTER TABLE "MACH"."TBL_AD_USER_AUTH_GRP"
	ADD
		CONSTRAINT "R/346" -- R/346
		FOREIGN KEY (
			"USER_NO" -- 사용자번호
		)
		REFERENCES "MACH"."TBL_AD_USER" ( -- 사용자
			"USER_NO" -- 사용자번호
		);

-- R/346
COMMENT ON CONSTRAINT "MACH"."TBL_AD_USER_AUTH_GRP"."R/346" IS 'R/346';

-- 사용자권한그룹
ALTER TABLE "MACH"."TBL_AD_USER_AUTH_GRP"
	ADD
		CONSTRAINT "R/347" -- R/347
		FOREIGN KEY (
			"AUTH_GRP_NO" -- 권한그룹번호
		)
		REFERENCES "MACH"."TBL_AD_AUTH_GRP" ( -- 권한그룹
			"AUTH_GRP_NO" -- 권한그룹번호
		);

-- R/347
COMMENT ON CONSTRAINT "MACH"."TBL_AD_USER_AUTH_GRP"."R/347" IS 'R/347';

-- 코드
ALTER TABLE "MACH"."TBL_AD_CD"
	ADD
		CONSTRAINT "R/370" -- R/370
		FOREIGN KEY (
			"SUP_CD_NO" -- 상위코드번호
		)
		REFERENCES "MACH"."TBL_AD_CD" ( -- 코드
			"CD_NO" -- 코드번호
		);

-- R/370
COMMENT ON CONSTRAINT "MACH"."TBL_AD_CD"."R/370" IS 'R/370';

-- 메뉴
ALTER TABLE "MACH"."TBL_AD_MENU"
	ADD
		CONSTRAINT "R/372" -- R/372
		FOREIGN KEY (
			"SUP_MENU_NO" -- 상위메뉴번호
		)
		REFERENCES "MACH"."TBL_AD_MENU" ( -- 메뉴
			"MENU_NO" -- 메뉴번호
		);

-- R/372
COMMENT ON CONSTRAINT "MACH"."TBL_AD_MENU"."R/372" IS 'R/372';

-- 접근가능권한
ALTER TABLE "MACH"."TBL_AD_ACCESS_AUTH"
	ADD
		CONSTRAINT "R/335" -- R/335
		FOREIGN KEY (
			"MENU_NO" -- 메뉴번호
		)
		REFERENCES "MACH"."TBL_AD_MENU" ( -- 메뉴
			"MENU_NO" -- 메뉴번호
		);

-- R/335
COMMENT ON CONSTRAINT "MACH"."TBL_AD_ACCESS_AUTH"."R/335" IS 'R/335';

-- 접근가능권한
ALTER TABLE "MACH"."TBL_AD_ACCESS_AUTH"
	ADD
		CONSTRAINT "R/336" -- R/336
		FOREIGN KEY (
			"AUTH_GRP_NO" -- 권한그룹번호
		)
		REFERENCES "MACH"."TBL_AD_AUTH_GRP" ( -- 권한그룹
			"AUTH_GRP_NO" -- 권한그룹번호
		);

-- R/336
COMMENT ON CONSTRAINT "MACH"."TBL_AD_ACCESS_AUTH"."R/336" IS 'R/336';

-- 사용자
ALTER TABLE "MACH"."TBL_AD_USER"
	ADD
		CONSTRAINT "R/345" -- R/345
		FOREIGN KEY (
			"BELONGTO_NO" -- 소속번호
		)
		REFERENCES "MACH"."TBL_AD_DEPT" ( -- 부서
			"DEPT_NO" -- 부서번호
		);

-- R/345
COMMENT ON CONSTRAINT "MACH"."TBL_AD_USER"."R/345" IS 'R/345';

-- 사용자
ALTER TABLE "MACH"."TBL_AD_USER"
	ADD
		CONSTRAINT "R/384" -- R/384
		FOREIGN KEY (
			"BELONGTO_NO" -- 소속번호
		)
		REFERENCES "MACH"."TBL_AD_PTNR" ( -- 거래처
			"PTNR_NO" -- 거래처번호
		);

-- R/384
COMMENT ON CONSTRAINT "MACH"."TBL_AD_USER"."R/384" IS 'R/384';

-- 부서
ALTER TABLE "MACH"."TBL_AD_DEPT"
	ADD
		CONSTRAINT "R/366" -- R/366
		FOREIGN KEY (
			"SUP_DEPT_NO" -- 상위부서번호
		)
		REFERENCES "MACH"."TBL_AD_DEPT" ( -- 부서
			"DEPT_NO" -- 부서번호
		);

-- R/366
COMMENT ON CONSTRAINT "MACH"."TBL_AD_DEPT"."R/366" IS 'R/366';

-- 정책
ALTER TABLE "MACH"."TBL_AD_PLCY"
	ADD
		CONSTRAINT "R/373" -- R/373
		FOREIGN KEY (
			"SUP_PLCY_CD" -- 상위정책코드
		)
		REFERENCES "MACH"."TBL_AD_PLCY" ( -- 정책
			"PLCY_CD" -- 정책코드
		);

-- R/373
COMMENT ON CONSTRAINT "MACH"."TBL_AD_PLCY"."R/373" IS 'R/373';

-- 거래처이력
ALTER TABLE "MACH"."TBL_AD_PTNRHIST"
	ADD
		CONSTRAINT "R/440" -- R/440
		FOREIGN KEY (
			"PTNR_NO" -- 거래처번호
		)
		REFERENCES "MACH"."TBL_AD_PTNR" ( -- 거래처
			"PTNR_NO" -- 거래처번호
		);

-- R/440
COMMENT ON CONSTRAINT "MACH"."TBL_AD_PTNRHIST"."R/440" IS 'R/440';