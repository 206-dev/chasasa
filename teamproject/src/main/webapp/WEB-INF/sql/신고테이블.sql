-- 신고 타입 테이블			
CREATE TABLE tbl_report_target_type (		
    targetTypeNo number(10,0) primary key,			
    targetType varchar2(100)			
);

-- 사유 타입 테이블
create table tbl_report_reason_type(
    reasontypeno int primary key,
    reasontype varchar2(50) not null
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
    
    CONSTRAINT fk_reasonType FOREIGN KEY (reasonTypeNo) REFERENCES tbl_report_reason_type(reasonTypeNo),
    CONSTRAINT fk_targetType FOREIGN KEY (targetTypeNo) REFERENCES tbl_report_target_type(targetTypeNo),
    CONSTRAINT fk_userId FOREIGN KEY (userId) REFERENCES tbl_user(userId),
    CONSTRAINT chk_status CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'on_hold'))
);

-- 시퀀스
create sequence seq_report;	--신고테이블
create sequence seq_report_target_type;	--타겟타입
create sequence seq_report_reson_type; --사유타입


-- 타겟 타입 insert
insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'board');

insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'user');

insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'reply');

-- 사유 타입 insert
insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '스팸홍보/도배');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '음란물');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '불법정보');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '청소년유해');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '개인정보 노출');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '불쾌한 표현');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '욕설/생명경시/혐오/차별적 표현');
