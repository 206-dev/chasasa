-- �Ű� Ÿ�� ���̺�			
CREATE TABLE tbl_report_target_type (		
    targetTypeNo number(10,0) primary key,			
    targetType varchar2(100)			
);

-- ���� Ÿ�� ���̺�
create table tbl_report_reason_type(
    reasontypeno int primary key,
    reasontype varchar2(50) not null
);

-- �Ű� ���̺�
CREATE TABLE tbl_report (
    reportNo      NUMBER(10, 0) PRIMARY KEY,      -- �Ű� ��ȣ (Primary Key)
    userId        VARCHAR2(50) NOT NULL,         -- �Ű��� ����� ���̵� (Foreign Key)
    target        varchar2(100) NOT NULL,        -- �Ű� ��� ��ȣ (�Խñ�/���/������ ��ȣ)
    targetTypeNo   number(10,0) NOT NULL,         -- �Ű� ����� ���� (�Խñ�, ���, ����)
    content       CLOB NOT NULL,                 -- �Ű� ���� (ū �ؽ�Ʈ �ʵ�)
    reportDate    DATE DEFAULT SYSDATE NOT NULL, -- �Ű� ��¥ (�⺻��: ���� ��¥)
    processedDate DATE,                          -- ó�� ��¥ (ó���� ������ ��¥)
    status        VARCHAR2(20) DEFAULT 'pending', -- ó�� ���� (�⺻��: ��� ��)
    reasonTypeNo number(10,0)  NOT NULL,
    targetURL varchar2(100) NOT NULL,
    
    CONSTRAINT fk_reasonType FOREIGN KEY (reasonTypeNo) REFERENCES tbl_report_reason_type(reasonTypeNo),
    CONSTRAINT fk_targetType FOREIGN KEY (targetTypeNo) REFERENCES tbl_report_target_type(targetTypeNo),
    CONSTRAINT fk_userId FOREIGN KEY (userId) REFERENCES tbl_user(userId),
    CONSTRAINT chk_status CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'on_hold'))
);

-- ������
create sequence seq_report;	--�Ű����̺�
create sequence seq_report_target_type;	--Ÿ��Ÿ��
create sequence seq_report_reson_type; --����Ÿ��


-- Ÿ�� Ÿ�� insert
insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'board');

insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'user');

insert into tbl_report_target_type
values(seq_report_target_type.nextval, 'reply');

-- ���� Ÿ�� insert
insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '����ȫ��/����');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '������');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '�ҹ�����');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, 'û�ҳ�����');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '�������� ����');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '������ ǥ��');

insert into tbl_report_reason_type(reasontypeno, reasontype)
values(seq_report_reson_type.nextval, '�弳/������/����/������ ǥ��');
