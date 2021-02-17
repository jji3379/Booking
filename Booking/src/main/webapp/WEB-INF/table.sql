-- 리뷰를 저장할 테이블 
CREATE TABLE board_review_comment(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100),--작성자
	title VARCHAR2(100),--제목
	content VARCHAR2(500),--내용
	viewCount NUMBER, --리뷰의 글번호 
	regdate DATE --리뷰 작성일
);
-- 리뷰의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE board_review__seq;

-- 리뷰를 저장할 테이블 
CREATE TABLE board_review_comment(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100),--작성자
	content VARCHAR2(500),--내용
	target_id VARCHAR2(100),--리뷰 대상자의 아이디
	ref_group NUMBER, --원글(카페글)의 글번호 
	comment_group NUMBER, --리뷰의 그룹번호
	deleted CHAR(3) DEFAULT 'no', --삭제된 리뷰인지 여부 'yes' or 'no'
	regdate DATE --리뷰 작성일
);
-- 리뷰의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE board_review_comment_seq;

create table users (
	num number(4), -- 회원번호
	id varchar2(40), -- 회원id
)