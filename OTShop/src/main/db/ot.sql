/* Drop Tables

DROP TABLE admins CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE faq CASCADE CONSTRAINTS;
DROP TABLE faq_category CASCADE CONSTRAINTS;
DROP TABLE logis CASCADE CONSTRAINTS;
DROP TABLE order_detail CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE product_detail CASCADE CONSTRAINTS;
DROP TABLE pwd_find CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE qna_category CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE product_category CASCADE CONSTRAINTS;
DROP TABLE transport CASCADE CONSTRAINTS;
DROP TABLE invoice CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
*/




/* Drop Sequences

DROP SEQUENCE cart_cseq;
DROP SEQUENCE faq_category_fcseq;
DROP SEQUENCE faq_fseq;
DROP SEQUENCE orders_oseq;
DROP SEQUENCE order_detail_odseq;
DROP SEQUENCE product_category_pcseq;
DROP SEQUENCE product_detail_pdseq;
DROP SEQUENCE product_pseq;
DROP SEQUENCE pwd_find_pfseq;
DROP SEQUENCE qna_category_qcseq;
DROP SEQUENCE qna_qseq;
DROP SEQUENCE transport_tseq;
DROP SEQUENCE invoice_iseq;
*/



-- 모든 table/seq drop 후 이하 sql 실행-------------------------------------------

/* Create Sequences */

CREATE SEQUENCE cart_cseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE faq_category_fcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE faq_fseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE orders_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE order_detail_odseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_category_pcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_detail_pdseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_pseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE pwd_find_pfseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE qna_category_qcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE qna_qseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE transport_tseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE invoice_iseq INCREMENT BY 1 START WITH 1;


/* Create Tables */

CREATE TABLE admins
(
	adminid varchar2(20) NOT NULL,
	pwd varchar2(30) NOT NULL,
	name varchar2(20) NOT NULL,
	tel varchar2(20) NOT NULL,
	email varchar2(30) NOT NULL,
	PRIMARY KEY (adminid)
);


CREATE TABLE cart
(
	cseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	pdseq number NOT NULL,
	qty number DEFAULT 1 NOT NULL,
	PRIMARY KEY (cseq)
);


CREATE TABLE faq
(
	fseq number NOT NULL,
	fcseq number NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	PRIMARY KEY (fseq)
);


CREATE TABLE faq_category
(
	fcseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (fcseq)
);


CREATE TABLE logis
(
	logisid varchar2(20) NOT NULL,
	pwd varchar2(30) NOT NULL,
	name varchar2(20) NOT NULL,
	tel varchar2(20) NOT NULL,
	email varchar2(30) NOT NULL,
	PRIMARY KEY (logisid)
);


CREATE TABLE members
(
	userid varchar2(20) NOT NULL,
	pwd varchar2(30) NOT NULL,
	name varchar2(20) NOT NULL,
	gender char(1) NOT NULL,
	birthdate varchar2(20) NOT NULL,
	tel varchar2(20) NOT NULL,
	email varchar2(30) NOT NULL,
	zipnum varchar2(20),
	address1 varchar2(100),
	address2 varchar2(100),
	address3 varchar2(100),
	regdate date DEFAULT sysdate NOT NULL,
	useyn char(1) DEFAULT 'Y' NOT NULL,
	provider varchar2(10) DEFAULT 'ot' NOT NULL,
	PRIMARY KEY (userid)
);


CREATE TABLE orders
(
	oseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	invoicenum number default 0 not null,
	PRIMARY KEY (oseq)
);


CREATE TABLE order_detail
(
	odseq number NOT NULL,
	oseq number NOT NULL,
	pdseq number NOT NULL,
	qty number NOT NULL,
	state char(1) DEFAULT '1' NOT NULL,
	PRIMARY KEY (odseq)
);


CREATE TABLE product
(
	pseq number NOT NULL,
	pcseq number NOT NULL,
	brand varchar2(30),
	name varchar2(30) NOT NULL,
	description varchar2(1000),
	gender char(1) DEFAULT 'N' NOT NULL,
	image varchar2(300),
	viewcount number DEFAULT 0 NOT NULL,
	bestyn char(1) DEFAULT 'N',
	useyn char(1) DEFAULT 'Y',
	regdate date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (pseq)
);


CREATE TABLE product_category
(
	pcseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (pcseq)
);


CREATE TABLE product_detail
(
	pdseq number NOT NULL,
	pseq number NOT NULL,
	-- 원가
	price1 number NOT NULL,
	-- 판매가
	price2 number NOT NULL,
	-- 마진
	price3 number NOT NULL,
	optname varchar2(50) DEFAULT 'option' NOT NULL,
	stock number DEFAULT 0 NOT NULL,
	useyn char(1) DEFAULT 'Y',
	PRIMARY KEY (pdseq)
);


CREATE TABLE pwd_find
(
	pfseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	kind number NOT NULL,
	answer varchar2(100) NOT NULL,
	PRIMARY KEY (pfseq)
);



CREATE TABLE qna
(
	qseq number NOT NULL,
	qcseq number NOT NULL,
	title varchar2(50) NOT NULL,
	content varchar2(1000) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	reply varchar2(1000),
	secret char(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (qseq)
);


CREATE TABLE qna_category
(
	qcseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (qcseq)
);


CREATE TABLE reply
(
	rseq number NOT NULL,
	qseq number NOT NULL,
	content varchar2(1000) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	secret char(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (rseq)
);



CREATE TABLE transport
(
	tseq number NOT NULL,
	iseq number NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	-- 배송위치
	description varchar2(100) NOT NULL,
	PRIMARY KEY (tseq)
);


CREATE TABLE invoice
(
	iseq number NOT NULL,
	clientid varchar2(20) NOT NULL,
	ordernum number DEFAULT 0 NOT NULL,
	recipient varchar2(30) NOT NULL,
	zipnum varchar2(20) NOT NULL,
	address1 varchar2(100) NOT NULL,
	address2 varchar2(100) NOT NULL,
	address3 varchar2(100),
	tel varchar2(20) NOT NULL,
	state char(1) DEFAULT '1' NOT NULL,
	PRIMARY KEY (iseq)
);




/* Create Foreign Keys */

ALTER TABLE faq
	ADD FOREIGN KEY (fcseq)
	REFERENCES faq_category (fcseq)
	ON DELETE CASCADE
;


ALTER TABLE cart
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
	ON DELETE CASCADE
;


ALTER TABLE orders
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
	ON DELETE CASCADE
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (oseq)
	REFERENCES orders (oseq)
	ON DELETE CASCADE
;


ALTER TABLE product_detail
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
	ON DELETE CASCADE
;

ALTER TABLE product
	ADD FOREIGN KEY (pcseq)
	REFERENCES product_category (pcseq)
	ON DELETE CASCADE
;


ALTER TABLE pwd_find
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;



ALTER TABLE qna
	ADD FOREIGN KEY (qcseq)
	REFERENCES qna_category (qcseq)
	ON DELETE CASCADE
;


ALTER TABLE cart
	ADD FOREIGN KEY (pdseq)
	REFERENCES product_detail (pdseq)
	ON DELETE CASCADE
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (pdseq)
	REFERENCES product_detail (pdseq)
	ON DELETE CASCADE
;


ALTER TABLE reply
	ADD FOREIGN KEY (qseq)
	REFERENCES qna (qseq)
	ON DELETE CASCADE
;


ALTER TABLE transport
	ADD FOREIGN KEY (iseq)
	REFERENCES invoice (iseq)
	ON DELETE CASCADE
;

/* View */
create or replace view faq_view as
select f.fseq, f.fcseq, fc.name, f.title, f.content
from faq f, faq_category fc
where f.fcseq = fc.fcseq;

create or replace view findAcc as
select pf.pfseq, m.userid, m.pwd, pf.kind, pf.answer
from members m, pwd_find pf
where m.userid = pf.userid;
select*from findAcc;



/* Select Tables */
select * from admins;
select * from members;
select * from product;
select * from product_detail;
select * from product_category;
select * from faq;
select * from faq_category;
select * from faq_view;
select * from pwd_find;

delete from product where pseq = 25;


/* Test Records */

insert into admins(adminid, pwd, name, tel, email)
values('admin', '1234', '관리자', '010-1234-1234', 'admin@otshop.com');

insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('hong', '1234', '홍길동', 'M', '1999-04-05', '010-1111-1111', 'hong@gmail.com');
insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('kim', '1234', '김길동', 'F', '1989-02-03', '010-2222-2222', 'kim@gmail.com');
insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('park', '1234', '박길동', 'M', '2000-07-15', '010-3333-3333', 'park@gmail.com');

insert into pwd_find(pfseq, userid, kind, answer) values(pwd_find_pfseq.nextval, 'hong', 1, '신촌');


insert into product_category(pcseq, name) values(product_category_pcseq.nextval, '반소매 티셔츠');
insert into product_category(pcseq, name) values(product_category_pcseq.nextval, '니트/스웨터');
insert into product_category(pcseq, name) values(product_category_pcseq.nextval, '후드 티셔츠');