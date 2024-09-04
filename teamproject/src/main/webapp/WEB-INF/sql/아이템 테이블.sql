--������ ���� ���̺�

-- ���̺�
-- ������ Ÿ�� ���̺�
create table tbl_item_type(
    typeno number primary key,
    type varchar2(50) ,
	typekr varchar2(50)
);

-- ������ ���̺�
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

-- ������ �����ִ� ������ ���̺�
create table tbl_user_items(
    userid varchar2(50) not null,
    itemno number,
    constraint fk_user_items_userid foreign key (userid) references tbl_user (userid),
    constraint fk_user_items_itemno foreign key (itemno) references tbl_items (itemno)
);
t
-- ������
-- �����۹�ȣ ������ ����
create sequence seq_items;
create sequence seq_item_type;

-- ���� �� ������
-- Ÿ�� insert
insert into tbl_item_type
values(seq_item_type.nextval, 'car', '��');
insert into tbl_item_type
values(seq_item_type.nextval, 'tent', '��Ʈ');

-- ������ insert
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 1, 'rearcar', '����ī', 0, 1, '/resources/lee/image/chabak/image/rearcarL.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 2, 'newspaper', '�Ź���', 0, 1, '/resources/lee/image/chabak/image/newspaper.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 1, 'smallcar', '������', 100, 2, '/resources/lee/image/chabak/image/smallcarL.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity, itempath)
values(seq_items.nextval, 2, 'smalltent', '������Ʈ', 100, 2, '/resources/lee/image/chabak/image/smalltent.png');
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 1, 'midcar', '������', 500, 4);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 2, 'midtent', '������Ʈ', 500, 4);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 1, 'bigcar', '������', 1500, 6);
insert into tbl_items(itemno, typeno, itemname, itemnamekr, price, capacity)
values(seq_items.nextval, 2, 'bigtent', '������Ʈ', 1500, 6);




