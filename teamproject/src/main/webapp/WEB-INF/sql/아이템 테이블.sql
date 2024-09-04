--아이템 관련 테이블

-- 테이블
-- 아이템 타입 테이블
create table tbl_item_type(
    typeno number primary key,
    type varchar2(50) ,
	typekr varchar2(50)
);

-- 아이템 테이블
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

-- 유저가 갖고있는 아이템 테이블
create table tbl_user_items(
    userid varchar2(50) not null,
    itemno number,
    constraint fk_user_items_userid foreign key (userid) references tbl_user (userid),
    constraint fk_user_items_itemno foreign key (itemno) references tbl_items (itemno)
);
t
-- 시퀀스
-- 아이템번호 시퀀스 생성
create sequence seq_items;
create sequence seq_item_type;

-- 설정 및 데이터
-- 타입 insert
insert into tbl_item_type
values(seq_item_type.nextval, 'car', '차');
insert into tbl_item_type
values(seq_item_type.nextval, 'tent', '텐트');

-- 아이템 insert
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 1, 'rearcar', '리어카', 0, 1, '/resources/lee/image/chabak/image/rearcarL.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 2, 'newspaper', '신문지', 0, 1, '/resources/lee/image/chabak/image/newspaper.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 1, 'smallcar', '소형차', 100, 2, '/resources/lee/image/chabak/image/smallcarL.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 2, 'smalltent', '소형텐트', 100, 2, '/resources/lee/image/chabak/image/smalltent.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 1, 'midcar', '중형차', 500, 4);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 2, 'midtent', '중형텐트', 500, 4);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 1, 'bigcar', '대형차', 1500, 6);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 2, 'bigtent', '대형텐트', 1500, 6);




