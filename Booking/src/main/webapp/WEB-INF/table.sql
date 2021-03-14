/*
 * API 의 책 한권 정보를 담는 테이블
 */
CREATE TABLE pay_item(
	id NUMBER REFERENCES pay_cart(id) ,
	image VARCHAR2(100),
	title VARCHAR2(300),
	price NUMBER,
	d_price NUMBER,
	count NUMBER
);
 
CREATE TABLE pay_cart(
	id NUMBER PRIMARY KEY,
	status NUMBER
);