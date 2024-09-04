-- 게시판 타입 테이블
create table tbl_board_type(
    BoardTypeNo number(10) primary key,
    BoardType varchar2(40)
);

create sequence seq_board_type;

create table tbl_user(
    UserId varchar2(50) primary key,
    UserPw varchar2(50) not null,
    NickName varchar2(50) not null,
    Email varchar2(50),
    RegDate date default sysdate,
    Profile varchar2(1000),
    UserLevel number default 1,
    Point number default 0,
    Gender char(1) check (gender in('M', 'W'))
 );
 
 create table tbl_board(
    BoardNo number(10) primary key,
    Title VARCHAR2(300) NOT NULL,
    Content clob NOT NULL,
    UserId varchar2(50),
    NickName varchar2(50) not null,
    BoardTypeNo NUMBER(10) NOT NULL,
    RegDate DATE DEFAULT SYSDATE,
    UpdateDate DATE DEFAULT SYSDATE,
    Views NUMBER(10) DEFAULT 0,
    Likes number(10) DEFAULT 0,
    ReplyCount number(10) DEFAULT 0,
    
    CONSTRAINT FK__board_Type FOREIGN KEY (BoardTypeNo) REFERENCES tbl_board_type (BoardTypeNo),
    CONSTRAINT FK_board_UserId FOREIGN KEY (UserId) REFERENCES tbl_user (UserId)
);

create sequence seq_board;

create table tbl_attach(
    FileNo number(10) primary key,
    BoardNo number(10),
    UploadPath varchar2(1000) not null,
    UploadDate date default sysdate,
    
    constraint FK_attach_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo)
);

create sequence seq_attach;

create table tbl_reply(
    ReplyNo number(10) primary key,
    BoardNo number(10),
    Comments varchar2(1000) not null,
    ParentReplyNo number(10),
    UserId varchar2(50),
    NickName varchar2(50),
    likes number(10) default 0,
    updateDate date default sysdate,
    
    constraint FK_reply_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo),
    constraint FK_reply_ParentReplyNo FOREIGN KEY (ParentReplyNo) REFERENCES tbl_reply(ReplyNo),
    constraint FK_reply_UserId FOREIGN KEY (UserId) REFERENCES tbl_user(UserId)
);

create sequence seq_reply;


create table tbl_like(
    LikeNo number(10) primary key,
    BoardNo number(10),
    UserId varchar2(50),
    
    constraint FK_like_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo),
    constraint FK_like_UserId FOREIGN KEY (UserId) REFERENCES tbl_user(UserId)
);

create sequence seq_like;

create table tbl_reply_like(
    LikeNo number(10) primary key,
    ReplyNo number(10),
    UserId varchar2(50),
    
    constraint FK_reply_like_ReplyNo FOREIGN KEY (ReplyNo) REFERENCES tbl_reply(ReplyNo),
    constraint FK_reply_like_UserId FOREIGN KEY (UserId) REFERENCES tbl_user(UserId)
);

create sequence seq_reply_like;

create table tbl_item_type(
  typeno number primary key,
  type varchar2(50),
  typeKr varchar2(50)
);
create sequence seq_item_type;

create table tbl_items(
  itemno number primary key,
  typeno number,
  itemname varchar2(50) not null,
  itemnamekr varchar2(50) not null,
  price number default 0,
  capacity number(10) default 1,
  itempath varchar2(50),
  constraint fk_user_items_type foreign key (typeno) references tbl_item_type (typeno)
);

create sequence seq_items;

create table tbl_user_items(
        userid varchar2(50) not null,
        itemno number,
        constraint fk_user_items_userid foreign key (userid) references tbl_user (userid),
        constraint fk_user_items_itemno foreign key (itemno) references tbl_items (itemno)
);

CREATE TABLE tbl_report_target_type (
targetTypeNo number(10,0) primary key,
targetType varchar2(100)
);

create sequence seq_report_target_type;


create table tbl_report_reason_type(
reasontypeno int primary key,
reasontype varchar2(50) not null
);

create sequence seq_report_reason_type;

CREATE TABLE tbl_report (
reportNo      NUMBER(10, 0) PRIMARY KEY,    
userId        VARCHAR2(50) NOT NULL,        
target        varchar2(100) NOT NULL,    
targetTypeNo   number(10,0) NOT NULL,        
content       CLOB NOT NULL,                
reportDate    DATE DEFAULT SYSDATE NOT NULL,
processedDate DATE,                         
status        VARCHAR2(20) DEFAULT 'pending',
reasonTypeNo number(10,0)  NOT NULL,
targetURL varchar2(255) NOT NULL,

CONSTRAINT fk_reasonTypeNo FOREIGN KEY (reasonTypeNo) REFERENCES tbl_report_reason_type(reasonTypeNo),
CONSTRAINT fk_targetTypeNo FOREIGN KEY (targetTypeNo) REFERENCES tbl_report_target_type(targettypeNo),
CONSTRAINT fk_userId FOREIGN KEY (userId) REFERENCES tbl_user(userId),
CONSTRAINT chk_status CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'on_hold'))
);

create sequence seq_report;

CREATE TABLE tbl_interests (
    userid VARCHAR2(50) NOT NULL,
    word VARCHAR2(50) NOT NULL,
    frequency NUMBER DEFAULT 1 NOT NULL,
    frequencylevel NUMBER,  -- 새로운 컬럼 추가
    updatedate TIMESTAMP DEFAULT SYSTIMESTAMP,
    PRIMARY KEY (userid, word),
    FOREIGN KEY (userid) REFERENCES tbl_user(userid)
);

CREATE TABLE tbl_user_actions (
    actionNo NUMBER(10, 0) PRIMARY KEY, 
    userId VARCHAR2(50 BYTE) NOT NULL,
    actionType VARCHAR2(50 BYTE) NOT NULL, -- '경고', '일시적 제한', '영구적 제한' 등
    reasonTypeNo NUMBER(10, 0) NOT NULL, -- tbl_report_reason_type의 reasonTypeNo를 참조
    startTime DATE DEFAULT SYSDATE,
    endTime DATE,
    issuedBy VARCHAR2(50 BYTE) DEFAULT 'system', -- 발부한 관리자 ID, 기본값 'system'
    status VARCHAR2(50 BYTE) DEFAULT 'ACTIVE',
    CONSTRAINT FK_USERACTIONS_USER FOREIGN KEY (userId) REFERENCES tbl_user(userId),
    CONSTRAINT FK_USERACTIONS_REASON FOREIGN KEY (reasonTypeNo) REFERENCES tbl_report_reason_type(reasonTypeNo),
    CONSTRAINT FK_USERACTIONS_ISSUEDBY FOREIGN KEY (issuedBy) REFERENCES tbl_user(userId)
);

create sequence seq_user_actions;

CREATE TABLE TBL_INTERESTS_BOARD (
    USERID VARCHAR2(50 BYTE) NOT NULL, 
    BOARDTYPENO NUMBER(10, 0) NOT NULL,
    PREFERENCE_COUNT NUMBER(10, 0) DEFAULT 0,
    CONSTRAINT PK_INTERESTS_BOARD PRIMARY KEY (USERID, BOARDTYPENO),
    CONSTRAINT FK_INTERESTS_BOARD_USERID FOREIGN KEY (USERID) REFERENCES TBL_USER(USERID),
    CONSTRAINT FK_INTERESTS_BOARD_BOARDTYPENO FOREIGN KEY (BOARDTYPENO) REFERENCES TBL_BOARD_TYPE(BOARDTYPENO)
);

-- 신고 테이블
CREATE TABLE tbl_report (
reportNo      NUMBER(10, 0) PRIMARY KEY,      -- 신고 번호 (Primary Key)
userId        VARCHAR2(50) NOT NULL,         -- 신고한 사용자 아이디 (Foreign Key)
target        varchar2(100) NOT NULL,        -- 신고 대상 번호 (게시글/댓글/유저의 번호)
targetTypeNo   number(10,0) NOT NULL,         -- 신고 대상의 유형 (게시글, 댓글, 유저)
content       CLOB NOT NULL,                 -- 신고 내용 (큰 텍스트 필드)
reportDate    DATE DEFAULT SYSDATE NOT NULL, -- 신고 날짜 (기본값: 현재 날짜)
processedDate DATE,                          -- 처리 날짜 (처리된 시점의 날짜)
status        VARCHAR2(20) DEFAULT 'pending', -- 처리 상태 (기본값: 대기 중)
reasonTypeNo number(10,0)  NOT NULL,
targetURL varchar2(100) NOT NULL,

CONSTRAINT fk_reasonTypeNo FOREIGN KEY (reasonTypeNo) REFERENCES tbl_report_reason_type(reasonTypeNo),
CONSTRAINT fk_targetTypeNo FOREIGN KEY (targetTypeNo) REFERENCES tbl_report_target_type(targettypeNo),
CONSTRAINT fk_userId FOREIGN KEY (userId) REFERENCES tbl_user(userId),
CONSTRAINT chk_status CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'on_hold'))
);

create sequence seq_report;


-- drop table
drop table tbl_attach;
drop table tbl_reply;
drop table tbl_like;
drop table tbl_board;
drop table tbl_user;
drop table tbl_board_type;
drop table tbl_reply_like;
drop table tbl_items;
drop table tbl_item_type;
drop table tbl_user_items;
drop table tbl_report;
drop table tbl_report_target_type;
drop table tbl_report_reason_type;
drop table tbl_user_actions;
drop table tbl_checkDay;
drop table tbl_interests_board;
drop table tbl_lottery;



-- drop sequence
drop sequence seq_attach;
drop sequence seq_reply;
drop sequence seq_like;
drop sequence seq_board;
drop sequence seq_board_type;
drop sequence seq_reply_like;
drop sequence seq_report;
drop sequence seq_items;
drop sequence seq_report_target_type;
drop sequence seq_report_reason_type;
drop sequence seq_user_actions;