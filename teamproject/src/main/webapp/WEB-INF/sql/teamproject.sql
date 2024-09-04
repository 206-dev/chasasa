drop table tbl_like;
drop table tbl_reply;
drop table tbl_attach;
drop table tbl_user;
drop table tbl_board;
drop table tbl_board_type;


create table tbl_board_type(
BoardTypeNo number(10) primary key,
BoardType varchar2(40)
);

-- 유저 테이블
create table tbl_user(
UserId varchar2(50) primary key,
UserPw varchar2(50) not null,
NickName varchar2(50) not null,
Email varchar2(50),
RegDate date default sysdate,
Profile varchar2(1000),
UserLevel number default 1,
Point number default 0
);

-- 일반적인 게시판 테이블
create table tbl_board(
BoardNo number(10) primary key,
Title VARCHAR2(300) NOT NULL,
Content clob NOT NULL,
UserId varchar2(50),
NickName varchar2(50) NOT NULL,
BoardTypeNo NUMBER(10) NOT NULL, -- 게시글 타입(공지/자유/질문/지식/...)
RegDate DATE DEFAULT SYSDATE,
UpdateDate DATE DEFAULT SYSDATE,
Views NUMBER(10) DEFAULT 0, -- 조회수
Likes number(10) DEFAULT 0, -- 좋아요
ReplyCount number(10) DEFAULT 0, -- 댓글 수

CONSTRAINT FK_board_Type FOREIGN KEY (BoardTypeNo) REFERENCES tbl_board_type (BoardTypeNo),
CONSTRAINT FK_board_UserId FOREIGN KEY (UserId) REFERENCES tbl_user (UserId)
);

-- 첨부파일 테이블
create table tbl_attach(
FileNo number(10) primary key,
BoardNo number(10),
UploadPath varchar2(1000) not null,
UploadDate date default sysdate,

constraint FK_attach_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo)
);

-- 댓글 테이블
create table tbl_reply(
ReplyNo number(10) primary key,
BoardNo number(10),
Comments varchar2(1000) not null,
ParentReplyNo number(10),
Replyer varchar2(50),
likes number(10) default 0,
updateDate date default sysdate,

constraint FK_reply_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo),
constraint FK_reply_ParentReplyNo FOREIGN KEY (ParentReplyNo) REFERENCES tbl_reply(ReplyNo),
constraint FK_reply_Replyer FOREIGN KEY (Replyer) REFERENCES tbl_user(UserId)
);

-- 좋아요/찜 테이블
create table tbl_like(
LikeNo number(10) primary key,
BoardNo number(10),
UserId varchar2(50),

constraint FK_like_BoardNo FOREIGN KEY (BoardNo) REFERENCES tbl_board(BoardNo),
constraint FK_like_UserId FOREIGN KEY (UserId) REFERENCES tbl_user(UserId)
);

create sequence seq_board;
create sequence seq_board_type;
create sequence seq_attach;
create sequence seq_reply;
create sequence seq_like;

insert into tbl_user(userId, userPw, nickname, email)
values('system', '1234', 'nickname', 'system@email,com');

insert into tbl_board_type
values(1, 'notice');
insert into tbl_board_type
values(2, 'join');
insert into tbl_board_type
values(3, 'check');
insert into tbl_board_type
values(4, 'free');
insert into tbl_board_type
values(5, 'info');
insert into tbl_board_type
values(6, 'review');
insert into tbl_board_type
values(7, 'qna');
insert into tbl_board_type
values(8, 'meet');
insert into tbl_board_type
values(9, 'meetReview');
insert into tbl_board_type
values(10, 'buy');
insert into tbl_board_type
values(11, 'sell');
insert into tbl_board_type
values(12, 'report');

INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항1', '<h2>2024년 차박 캠핑 안내</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 차박 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 체험</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항2', '<h2>2024년 글램핑 행사 안내</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 글램핑 행사를 안내드립니다. 이번 행사에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>럭셔리 글램핑</li><li>별 관측</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/glamping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항3', '<h2>2024년 캠핑 축제 안내</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 캠핑 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>캠핑 장비 전시</li><li>야외 게임</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/camping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항4', '<h2>2024년 여름 차박 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 요리 교실</li><li>야외 영화 상영</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항5', '<h2>2024년 가을 글램핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 글램핑을 안내드립니다. 이번 글램핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-glamping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항6', '<h2>2024년 겨울 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>겨울 캠프파이어</li><li>눈놀이</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항7', '<h2>2024년 봄 차박 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>캠핑 장비 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항8', '<h2>2024년 차박 이벤트</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 차박 이벤트를 안내드립니다. 이번 이벤트에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 요리 대회</li><li>자연 탐험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/car-event">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항9', '<h2>2024년 글램핑 파티</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 글램핑 파티를 안내드립니다. 이번 파티에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>럭셔리 파티</li><li>바비큐 파티</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/glamping-party">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate) VALUES (seq_board.nextval, '공지사항10', '<h2>2024년 여름 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 수영장</li><li>야외 바베큐</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항11', '<h2>2024년 차박 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 차박 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 장소 탐방</li><li>캠핑 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/car-travel">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항12', '<h2>2024년 봄 글램핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 글램핑을 안내드립니다. 이번 글램핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-glamping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항13', '<h2>2024년 여름 차박</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박을 안내드립니다. 이번 차박에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 요리 대회</li><li>여름 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항14', '<h2>2024년 가을 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항15', '<h2>2024년 겨울 차박</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 차박을 안내드립니다. 이번 차박에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>겨울 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항16', '<h2>2024년 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>럭셔리 체험</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항17', '<h2>2024년 가을 차박 캠핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 차박 캠핑을 안내드립니다. 이번 캠핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>캠핑 장비 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-car-camping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항18', '<h2>2024년 봄 글램핑 행사</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 글램핑 행사를 안내드립니다. 이번 행사에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-glamping-event">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항19', '<h2>2024년 여름 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>럭셔리 캠핑</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항20', '<h2>2024년 겨울 글램핑</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 글램핑을 안내드립니다. 이번 글램핑에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-glamping">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항21', '<h2>2024년 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>차박 요리 대회</li><li>캠핑 장비 전시</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/car-camping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항22', '<h2>2024년 봄 차박 이벤트</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 이벤트를 안내드립니다. 이번 이벤트에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>캠핑 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-event">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항23', '<h2>2024년 여름 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 차박</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항24', '<h2>2024년 가을 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항25', '<h2>2024년 겨울 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>겨울 차박</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항26', '<h2>2024년 봄 글램핑 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 글램핑 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>럭셔리 여행</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-glamping-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항27', '<h2>2024년 여름 글램핑 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 글램핑 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 럭셔리 여행</li><li>캠핑 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-glamping-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항28', '<h2>2024년 가을 글램핑 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 글램핑 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>럭셔리 여행</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-glamping-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항29', '<h2>2024년 겨울 글램핑 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 글램핑 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>럭셔리 여행</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-glamping-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항30', '<h2>2024년 봄 차박 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항31', '<h2>2024년 여름 차박 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 차박</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항32', '<h2>2024년 가을 차박 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 차박 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-car-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항33', '<h2>2024년 겨울 차박 여행</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 차박 여행을 안내드립니다. 이번 여행에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-car-trip">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항34', '<h2>2024년 봄 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항35', '<h2>2024년 여름 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>럭셔리 캠핑</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항36', '<h2>2024년 가을 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항37', '<h2>2024년 겨울 글램핑 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 글램핑 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-glamping-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항38', '<h2>2024년 봄 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항39', '<h2>2024년 여름 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 차박</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항40', '<h2>2024년 가을 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항41', '<h2>2024년 겨울 차박 체험</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 차박 체험을 안내드립니다. 이번 체험에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>겨울 차박</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-car-experience">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항42', '<h2>2024년 봄 글램핑 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 글램핑 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-glamping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항43', '<h2>2024년 여름 글램핑 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 글램핑 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 럭셔리 캠핑</li><li>캠핑 요리</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-glamping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항44', '<h2>2024년 가을 글램핑 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 글램핑 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-glamping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항45', '<h2>2024년 겨울 글램핑 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 글램핑 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>럭셔리 캠핑</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-glamping-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항46', '<h2>2024년 봄 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항47', '<h2>2024년 여름 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 여름 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>여름 차박</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/summer-car-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항48', '<h2>2024년 가을 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 가을 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>단풍 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/fall-car-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항49', '<h2>2024년 겨울 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 겨울 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>눈놀이</li><li>겨울 차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/winter-car-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);
INSERT INTO tbl_board (boardNo, title, content, userId, nickname, boardType, regdate, updatedate)
VALUES (seq_board.nextval, '공지사항50', '<h2>2024년 봄 차박 축제</h2><p>안녕하세요, 사용자 여러분!</p><p>2024년 봄 차박 축제를 안내드립니다. 이번 축제에는 다음과 같은 프로그램이 준비되어 있습니다:</p><ul><li>봄꽃 구경</li><li>차박 요리 체험</li><li>경품 추첨</li></ul><p>참여 신청은 <a href="http://example.com/spring-car-festival">여기</a>에서 해주시기 바랍니다.</p><p>감사합니다.</p><p>작성자: 운영팀</p>', 'system', 'nickname', 1, sysdate, sysdate);

commit;
