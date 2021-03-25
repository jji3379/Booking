-- by남기, 리뷰를 저장할 테이블_210301
CREATE TABLE board_review(
	num NUMBER PRIMARY KEY, --글번호
	isbn VARCHAR2(200), -- 책 고유번호
	imagePath VARCHAR2(300), -- 이미지 경로
	writer VARCHAR2(100), --작성자
	bookTitle VARCHAR2(300), --책제목
	reviewTitle VARCHAR2(500), --리뷰제목
	content VARCHAR2(1000), --내용
	rating NUMBER, --별점
	viewCount NUMBER, --조회수
	regdate DATE, --리뷰 작성일
	spoCheck VARCHAR2(100) --by채영, 스포포함 체크박스_210308
);

-- by남기, 리뷰의 글번호를 얻어낼 시퀀스_210301
CREATE SEQUENCE board_review_seq;

-- by남기, 리뷰의 댓글을 저장할 테이블 _210301
CREATE TABLE board_review_comment(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100),--작성자
	content VARCHAR2(500),--내용
	target_id VARCHAR2(100),--리뷰 대상자의 아이디
	ref_group NUMBER, --원글의 글번호 
	comment_group NUMBER, --댓글의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 리뷰인지 여부 'yes' or 'no'
	regdate DATE --리뷰 작성일
);
-- by남기, 리뷰의 댓글 글번호를 얻어낼 시퀀스_210301
CREATE SEQUENCE board_review_comment_seq;

/*
 * API 의 책 한권 정보를 담는 테이블
 */
CREATE TABLE cart_item(
	c_id NUMBER PRIMARY KEY,
	id VARCHAR2(100),
	image VARCHAR2(300),
	title VARCHAR2(300),
	price NUMBER,
	d_price NUMBER,
	count NUMBER,
	indate DATE,
	isbn VARCHAR2(300)
);
-- 결제 시퀀스 
CREATE SEQUENCE pay_seq;
 
-- 리뷰의 댓글을 저장할 테이블 
CREATE TABLE board_review_comment(
	num NUMBER PRIMARY KEY, --글번호
	isbn VARCHAR2(200), -- 책 고유번호
	imagePath VARCHAR2(300), -- 이미지 경로
	writer VARCHAR2(100), --작성자
	content VARCHAR2(500), --내용
	viewCount NUMBER, --조회수
	regdate DATE --리뷰 작성일
);

-- 리뷰의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE board_review_seq;

-- 유저 정보 테이블
create table users (
	num number(4) PRIMARY KEY, -- 회원번호
	id varchar2(40) NOT NULL, -- 회원id
	pwd varchar2(100) NOT NULL, -- 회원pwd
	email varchar2(200) NOT NULL, -- 회원email
	profile varchar2(100), -- 프로필사진 저장경로
	regdate DATE, -- 가입일
	recentSearch varchar2(100), -- 최근 검색어
	care varchar2(100) -- 관심사
);

create sequence users_seq; -- 회원번호 시퀀스

-- by욱현.주문내역 테이블_2021316 
create table my_order (
	o_id number(4) NOT NULL, --오더 넘버
	buyer varchar2(40) NOT NULL, -- 구매자
	image varchar2(400) NOT NULL, --구매 책 이미지
	title varchar2(400) NOT NULL, -- 책 제목
	price number(4), -- 정가
	d_price number(4), --할인가
	count number(4), --갯수
	o_date DATE, -- 주문일
	isbn varchar2(300)
);

--by욱현.주문번호 시퀀스_2021316
create sequence o_id_seq;




