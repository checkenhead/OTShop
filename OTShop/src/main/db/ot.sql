/* Drop Tables

DROP TABLE banner CASCADE CONSTRAINTS;
DROP TABLE banner_images CASCADE CONSTRAINTS;
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
DROP TABLE product_main_category CASCADE CONSTRAINTS;
DROP TABLE product_sub_category CASCADE CONSTRAINTS;
DROP TABLE product_main_category_list CASCADE CONSTRAINTS;
DROP TABLE product_sub_category_list CASCADE CONSTRAINTS;
DROP TABLE product_sub_cat_set CASCADE CONSTRAINTS;
DROP TABLE product_main_cat_set CASCADE CONSTRAINTS;
DROP TABLE transport CASCADE CONSTRAINTS;
DROP TABLE invoice CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
*/


/* Drop Sequences

DROP SEQUENCE banner_images_biseq;
DROP SEQUENCE banner_bseq;
DROP SEQUENCE cart_cseq;
DROP SEQUENCE faq_category_fcseq;
DROP SEQUENCE faq_fseq;
DROP SEQUENCE orders_oseq;
DROP SEQUENCE order_detail_odseq;
DROP SEQUENCE product_detail_pdseq;
DROP SEQUENCE product_pseq;
DROP SEQUENCE product_main_category_pmcseq;
DROP SEQUENCE product_sub_category_pscseq;
DROP SEQUENCE product_main_cat_list_pmclseq;
DROP SEQUENCE product_sub_cat_list_psclseq;
DROP SEQUENCE product_main_cat_set_pmcsseq;
DROP SEQUENCE product_sub_cat_set_pscsseq;
DROP SEQUENCE pwd_find_pfseq;
DROP SEQUENCE qna_category_qcseq;
DROP SEQUENCE qna_qseq;
DROP SEQUENCE transport_tseq;
DROP SEQUENCE invoice_iseq;
*/



-- 모든 table/seq drop 후 이하 sql 실행-------------------------------------------

/* Create Sequences */

CREATE SEQUENCE banner_bseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE banner_images_biseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE cart_cseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE faq_category_fcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE faq_fseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE orders_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE order_detail_odseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_detail_pdseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_pseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE pwd_find_pfseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE qna_category_qcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE qna_qseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE transport_tseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE invoice_iseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_main_cat_list_pmclseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_sub_cat_list_psclseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_main_category_pmcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_sub_category_pscseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_main_cat_set_pmcsseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_sub_cat_set_pscsseq INCREMENT BY 1 START WITH 1;



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

CREATE TABLE banner
(
	bseq number NOT NULL,
	biseq number NOT NULL,
	priority number DEFAULT 0 NOT NULL,
	uri varchar2(300) DEFAULT '#' NOT NULL,
	useyn char(1) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (bseq)
);



CREATE TABLE banner_images
(
	biseq number NOT NULL,
	name varchar2(50) NOT NULL,
	image varchar2(300) NOT NULL,
	PRIMARY KEY (biseq)
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
alter table members modify birthdate varchar2(20);
alter table members drop column birthdate;
alter table members add birthdate varchar2(20) DEFAULT '0' NOT NULL;
delete from members where userid = 'park';
SELECT * FROM MEMBERS;

CREATE TABLE orders
(
	oseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	invoicenum number default 0 not null,
	state char(1) DEFAULT '1' NOT NULL,
	PRIMARY KEY (oseq)
);


CREATE TABLE order_detail
(
	odseq number NOT NULL,
	oseq number NOT NULL,
	pdseq number NOT NULL,
	qty number NOT NULL,
	PRIMARY KEY (odseq)
);


CREATE TABLE product
(
	pseq number NOT NULL,
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




CREATE TABLE product_main_category_list
(
	pmclseq number NOT NULL,
	pseq number NOT NULL,
	pmcseq number NOT NULL,
	PRIMARY KEY (pmclseq)
);


CREATE TABLE product_sub_category_list
(
	psclseq number NOT NULL,
	pseq number NOT NULL,
	pscseq number NOT NULL,
	PRIMARY KEY (psclseq)
);


CREATE TABLE product_main_category
(
	pmcseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (pmcseq)
);


CREATE TABLE product_sub_category
(
	pscseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (pscseq)
);


CREATE TABLE product_main_cat_set
(
	pmcsseq number NOT NULL,
	pmcseq number NOT NULL,
	PRIMARY KEY (pmcsseq)
);

CREATE TABLE product_sub_cat_set
(
	pscsseq number NOT NULL,
	pmcsseq number NOT NULL,
	pscseq number NOT NULL,
	PRIMARY KEY (pscsseq)
);




CREATE TABLE pwd_find
(
	pfseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	kind char(1) NOT NULL,
	answer varchar2(100) NOT NULL,
	PRIMARY KEY (pfseq)
);



CREATE TABLE qna
(
	qseq number NOT NULL,
	qcseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	title varchar2(50) NOT NULL,
	content varchar2(1000) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	reply varchar2(1000),
	secret char(1) DEFAULT 'N' NOT NULL,
	pseq number DEFAULT 0 NOT NULL,
	PRIMARY KEY (qseq)
);


CREATE TABLE qna_category
(
	qcseq number NOT NULL,
	name varchar2(30) NOT NULL,
	PRIMARY KEY (qcseq)
);



CREATE TABLE transport
(
	tseq number NOT NULL,
	iseq number NOT NULL,
	logisid varchar2(30) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	-- 배송위치
	description varchar2(100) NOT NULL,
	state char(1) DEFAULT '1' NOT NULL,
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

ALTER TABLE banner
	ADD FOREIGN KEY (biseq)
	REFERENCES banner_images (biseq)
	ON DELETE CASCADE
;

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


ALTER TABLE product_main_category_list
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
	ON DELETE CASCADE
;

ALTER TABLE product_main_category_list
	ADD FOREIGN KEY (pmcseq)
	REFERENCES product_main_category (pmcseq)
	ON DELETE CASCADE
;


ALTER TABLE product_sub_category_list
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
	ON DELETE CASCADE
;

ALTER TABLE product_sub_category_list
	ADD FOREIGN KEY (pscseq)
	REFERENCES product_sub_category (pscseq)
	ON DELETE CASCADE
;


ALTER TABLE product_main_cat_set
	ADD FOREIGN KEY (pmcseq)
	REFERENCES product_main_category (pmcseq)
	ON DELETE CASCADE
;


ALTER TABLE product_sub_cat_set
	ADD FOREIGN KEY (pmcsseq)
	REFERENCES product_main_cat_set (pmcsseq)
	ON DELETE CASCADE
;

ALTER TABLE product_sub_cat_set
	ADD FOREIGN KEY (pscseq)
	REFERENCES product_sub_category (pscseq)
	ON DELETE CASCADE
;

ALTER TABLE pwd_find
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
	ON DELETE CASCADE
;



ALTER TABLE qna
	ADD FOREIGN KEY (qcseq)
	REFERENCES qna_category (qcseq)
	ON DELETE CASCADE
;

ALTER TABLE qna
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
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



ALTER TABLE transport
	ADD FOREIGN KEY (iseq)
	REFERENCES invoice (iseq)
	ON DELETE CASCADE
;


ALTER TABLE transport
	ADD FOREIGN KEY (logisid)
	REFERENCES logis (logisid)
	ON DELETE CASCADE
;



/* Create Views */


/* View */

create or replace view faq_view as
select f.fseq, f.fcseq, fc.name, f.title, f.content
from faq f, faq_category fc
where f.fcseq = fc.fcseq;
select*from faq_view;

create or replace view findAcc as
select pf.pfseq, m.userid, m.pwd, pf.kind, pf.answer
from members m, pwd_find pf
where m.userid = pf.userid;
select*from findAcc;


create or replace view qna_view as
select q.qseq, q.qcseq, q.userid, qc.name, q.title, q.content, q.regdate, q.reply, q.secret, q.pseq
from qna q, qna_category qc
where q.qcseq = qc.qcseq;


create or replace view banner_view as
select b.bseq, b.biseq, bi.name, bi.image, b.priority, b.uri, b.useyn
from banner b, banner_images bi
where b.biseq = bi.biseq;


create or replace view product_category_set_view as
select pcs.pcsseq, pcs.pmcseq, pmc.name as mname, pcs.pscseq, psc.name as sname
from product_category_set pcs, product_main_category pmc, product_sub_category psc
where pcs.pmcseq = pmc.pmcseq and pcs.pscseq = psc.pscseq
order by pcs.pscseq asc;

create or replace view product_main_cat_set_view as
select pmcs.pmcsseq, pmcs.pmcseq, pmc.name
from product_main_cat_set pmcs, product_main_category pmc
where pmcs.pmcseq = pmc.pmcseq;

create or replace view product_sub_cat_set_view as
select pscs.pscsseq, pscs.pmcsseq ,pscs.pscseq, psc.name
from product_sub_cat_set pscs, product_sub_category psc
where pscs.pscseq = psc.pscseq;

create or replace view product_main_cat_list_view as
select pmcl.pmclseq, pmcl.pseq, pmcl.pmcseq, pmc.name
from product_main_category_list pmcl, product_main_category pmc
where pmcl.pmcseq = pmc.pmcseq;

create or replace view product_sub_cat_list_view as
select pscl.psclseq, pscl.pseq, pscl.pscseq, psc.name
from product_sub_category_list pscl, product_sub_category psc
where pscl.pscseq = psc.pscseq;

create or replace view product_cart_view as
select c.cseq, c.userid, pd.pseq, p.brand, p.name, p.image, c.pdseq, pd.price2, pd.optname, c.qty
from cart c, product p, product_detail pd
where c.pdseq = pd.pdseq and pd.pseq = p.pseq;


--create or replace view order_view as
--select o.oseq, o.regdate, o.state,
--o.userid, m.name as mname, m.email, m.tel, m.zipnum, m.address1, m.address2, m.address3,
--o.odseq, pd.pseq, p.name as pname, od.pdseq, pd.optname, pd.price2, od.qty
--from orders o, order_detail od, members m, product p, product_detail pd
--where o.userid = m.userid and od.pdseq = pd.pdseq and pd.pseq = p.pseq;

--orders/member join
create or replace view orders_view as
select o.oseq, o.regdate, o.state, o.invoicenum, o.userid, m.name, m.email, m.tel, m.zipnum, m.address1, m.address2, m.address3
from orders o, members m
where o.userid = m.userid;

--order_detail/product/product_detail join
create or replace view order_detail_view as
select od.odseq, od.oseq, pd.pseq, p.brand, p.name, od.pdseq, pd.optname, pd.price2, od.qty
from order_detail od, product p, product_detail pd
where od.pdseq = pd.pdseq and pd.pseq = p.pseq;





/* Select Tables */
select * from admins;
select * from members;
select * from product;
select * from product_detail;
select * from product_category;
select * from faq;
select * from faq_category;
select * from faq_view;

select * from qna;
select * from qna_category;
select * from qna_view;
select * from banner;
select * from banner_images;
select * from banner_view;

select * from pwd_find;
select * from findAcc;

select * from product_main_category;
select * from product_sub_category;

select * from product_main_category_list;
select * from product_sub_category_list;

select * from product_main_cat_set;
select * from product_sub_cat_set;

delete from qna;

select * from product_main_cat_list_view;
select * from product_sub_cat_list_view;

select * from cart;
select * from product_cart_view;


select max(nvl(priority, 0)) from banner;



select * from product_main_category_list;
select * from product where pseq in (select pseq from product_main_category_list where pmcseq = 2);


select * from orders;
select * from order_detail;

--alter table order_detail drop column state;
--alter table orders add state char(1) default '1' not null;

select * from orders_view;
select * from order_detail_view;

select * from logis;
select * from invoice;
select * from transport;




select * from invoice where iseq in (select distinct iseq from
                (select * from transport where logisid = 'logis' order by regdate desc));



/* Test Records */

insert into admins(adminid, pwd, name, tel, email)
values('admin', '1234', '관리자', '010-1234-1234', 'admin@otshop.com');

insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('hong', '1234', '홍길동', 'M', '1999-04-05', '010-1111-1111', 'hong@gmail.com');
insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('kim', '1234', '김길동', 'F', '1989-02-03', '010-2222-2222', 'kim@gmail.com');
insert into members(userid, pwd, name, gender, birthdate, tel, email)
values('park', '1234', '박길동', 'M', '2000-07-15', '010-3333-3333', 'park@gmail.com');

insert into pwd_find(pfseq, userid, kind, answer) values(pwd_find_pfseq.nextval, 'hong', '1', '신촌');

insert into faq_category(fcseq, name) values(faq_category_fcseq.nextval, '회원/계정');
insert into faq_category(fcseq, name) values(faq_category_fcseq.nextval, '상품/배송');
insert into faq_category(fcseq, name) values(faq_category_fcseq.nextval, '주문/결제');

insert into faq(fseq, fcseq, title, content)
values(faq_fseq.nextval, 1, '회원가입은 어떻게 하나요?', '회원가입은 화면 왼쪽 상단에 있는 회원가입 버튼을 눌러 진행합니다. 약관에 동의하지 않으면 가입할 수 없습니다.');
insert into faq(fseq, fcseq, title, content)
values(faq_fseq.nextval, 2, '배송은 언제 되나요??', '택배사의 사정에 따라 정확한 일정은 알 수 없습니다. 결제일로부터 평균 7일 이내 배송됩니다.');
insert into faq(fseq, fcseq, title, content)
values(faq_fseq.nextval, 3, '주문을 취소했는데 환불은 언제 되나요?', '주문 취소가 확인되면 2~3일 이내 환불 예정입니다. (주말 제외, 카드사에 따라 상세일정 다름)');
insert into faq(fseq, fcseq, title, content)
values(faq_fseq.nextval, 1, '회원 탈퇴는 어떻게 하나요?', '마이페이지 - 내 정보 수정 - 회원탈퇴 버튼을 누르면 회원탈퇴 과정이 진행됩니다.');


insert into qna_category(qcseq, name) values(qna_category_qcseq.nextval, '회원정보/계정');
insert into qna_category(qcseq, name) values(qna_category_qcseq.nextval, '상품');
insert into qna_category(qcseq, name) values(qna_category_qcseq.nextval, '주문/결제');


insert into qna(qseq, qcseq, userid, title, content, pseq) values(qna_qseq.nextval, 2, 'hong', '상품 문의 드려요.', '정품 맞나요?', 28);
insert into qna(qseq, qcseq, userid, title, content, secret) values(qna_qseq.nextval, 1, 'kim', '전화번호 변경 문의', '전화번호를 변경하고 싶은데 어떻게 해야하나요?', 'Y');


insert into product_main_category_list(pmclseq, pseq, pmcseq) values(product_main_cat_list_pmclseq.nextval, 3, 2);
insert into product_sub_category_list(psclseq, pseq, pscseq) values(product_sub_cat_list_psclseq.nextval, 3, 3);
insert into product_sub_category_list(psclseq, pseq, pscseq) values(product_sub_cat_list_psclseq.nextval, 3, 3);


insert into qna(qseq, qcseq, userid, title, content, pseq) values(qna_qseq.nextval, 2, 'hong', '상품 문의 드려요.', '정품 맞나요?', 4);
insert into qna(qseq, qcseq, userid, title, content, secret) values(qna_qseq.nextval, 1, 'kim', '전화번호 변경 문의', '전화번호를 변경하고 싶은데 어떻게 해야하나요?', 'Y');


insert into logis(logisid, pwd, name, tel, email) values('logis', '1234', '김배송', '010-9875-5789', 'logis1@naver.com');

