
/* Drop Triggers */

DROP TRIGGER TRI_cart_cseq;
DROP TRIGGER TRI_faq_category_fcseq;
DROP TRIGGER TRI_faq_fseq;
DROP TRIGGER TRI_invoice_iseq;
DROP TRIGGER TRI_odetail_odseq;
DROP TRIGGER TRI_option_opseq;
DROP TRIGGER TRI_orders_oseq;
DROP TRIGGER TRI_order_detail_odseq;
DROP TRIGGER TRI_order_oseq;
DROP TRIGGER TRI_product_category_pcseq;
DROP TRIGGER TRI_product_detail_opseq;
DROP TRIGGER TRI_product_detail_pdseq;
DROP TRIGGER TRI_product_pseq;
DROP TRIGGER TRI_qna_category_qcseq;
DROP TRIGGER TRI_qna_qseq;
DROP TRIGGER TRI_reply_rseq;
DROP TRIGGER TRI_stock_sseq;
DROP TRIGGER TRI_transport_tseq;



/* Drop Tables */

DROP TABLE admins CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE faq CASCADE CONSTRAINTS;
DROP TABLE faq_category CASCADE CONSTRAINTS;
DROP TABLE transport CASCADE CONSTRAINTS;
DROP TABLE invoice CASCADE CONSTRAINTS;
DROP TABLE logis CASCADE CONSTRAINTS;
DROP TABLE order_detail CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE product_detail CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE product_category CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE qna_category CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_cart_cseq;
DROP SEQUENCE SEQ_faq_category_fcseq;
DROP SEQUENCE SEQ_faq_fseq;
DROP SEQUENCE SEQ_invoice_iseq;
DROP SEQUENCE SEQ_odetail_odseq;
DROP SEQUENCE SEQ_option_opseq;
DROP SEQUENCE SEQ_orders_oseq;
DROP SEQUENCE SEQ_order_detail_odseq;
DROP SEQUENCE SEQ_order_oseq;
DROP SEQUENCE SEQ_product_category_pcseq;
DROP SEQUENCE SEQ_product_detail_opseq;
DROP SEQUENCE SEQ_product_detail_pdseq;
DROP SEQUENCE SEQ_product_pseq;
DROP SEQUENCE SEQ_qna_category_qcseq;
DROP SEQUENCE SEQ_qna_qseq;
DROP SEQUENCE SEQ_reply_rseq;
DROP SEQUENCE SEQ_stock_sseq;
DROP SEQUENCE SEQ_transport_tseq;




/* Create Sequences */

CREATE SEQUENCE SEQ_cart_cseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_faq_category_fcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_faq_fseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_invoice_iseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_odetail_odseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_option_opseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_orders_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_order_detail_odseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_order_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_category_pcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_detail_opseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_detail_pdseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_pseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_qna_category_qcseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_qna_qseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_reply_rseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_stock_sseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_transport_tseq INCREMENT BY 1 START WITH 1;



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
	logisid varchar2(20),
	PRIMARY KEY (iseq)
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
	birthdate date NOT NULL,
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

select * from members;
delete from members;


CREATE TABLE orders
(
	oseq number NOT NULL,
	userid varchar2(20) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	invoicenum number DEFAULT 0 NOT NULL,
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
	options varchar2(50) DEFAULT 'option' NOT NULL,
	stock number DEFAULT 0 NOT NULL,
	PRIMARY KEY (pdseq)
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


CREATE TABLE transport
(
	tseq number NOT NULL,
	iseq number NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	-- 배송위치
	description varchar2(100) NOT NULL,
	PRIMARY KEY (tseq)
);



/* Create Foreign Keys */

ALTER TABLE faq
	ADD FOREIGN KEY (fcseq)
	REFERENCES faq_category (fcseq)
;


ALTER TABLE transport
	ADD FOREIGN KEY (iseq)
	REFERENCES invoice (iseq)
;


ALTER TABLE cart
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE orders
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (oseq)
	REFERENCES orders (oseq)
;


ALTER TABLE product_detail
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
;


ALTER TABLE product
	ADD FOREIGN KEY (pcseq)
	REFERENCES product_category (pcseq)
;


ALTER TABLE cart
	ADD FOREIGN KEY (pdseq)
	REFERENCES product_detail (pdseq)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (pdseq)
	REFERENCES product_detail (pdseq)
;


ALTER TABLE qna
	ADD FOREIGN KEY (qcseq)
	REFERENCES qna_category (qcseq)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_cart_cseq BEFORE INSERT ON cart
FOR EACH ROW
BEGIN
	SELECT SEQ_cart_cseq.nextval
	INTO :new.cseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_faq_category_fcseq BEFORE INSERT ON faq_category
FOR EACH ROW
BEGIN
	SELECT SEQ_faq_category_fcseq.nextval
	INTO :new.fcseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_faq_fseq BEFORE INSERT ON faq
FOR EACH ROW
BEGIN
	SELECT SEQ_faq_fseq.nextval
	INTO :new.fseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_invoice_iseq BEFORE INSERT ON invoice
FOR EACH ROW
BEGIN
	SELECT SEQ_invoice_iseq.nextval
	INTO :new.iseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_odetail_odseq BEFORE INSERT ON odetail
FOR EACH ROW
BEGIN
	SELECT SEQ_odetail_odseq.nextval
	INTO :new.odseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_option_opseq BEFORE INSERT ON option
FOR EACH ROW
BEGIN
	SELECT SEQ_option_opseq.nextval
	INTO :new.opseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_orders_oseq BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
	SELECT SEQ_orders_oseq.nextval
	INTO :new.oseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_order_detail_odseq BEFORE INSERT ON order_detail
FOR EACH ROW
BEGIN
	SELECT SEQ_order_detail_odseq.nextval
	INTO :new.odseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_order_oseq BEFORE INSERT ON order
FOR EACH ROW
BEGIN
	SELECT SEQ_order_oseq.nextval
	INTO :new.oseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_product_category_pcseq BEFORE INSERT ON product_category
FOR EACH ROW
BEGIN
	SELECT SEQ_product_category_pcseq.nextval
	INTO :new.pcseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_product_detail_opseq BEFORE INSERT ON product_detail
FOR EACH ROW
BEGIN
	SELECT SEQ_product_detail_opseq.nextval
	INTO :new.opseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_product_detail_pdseq BEFORE INSERT ON product_detail
FOR EACH ROW
BEGIN
	SELECT SEQ_product_detail_pdseq.nextval
	INTO :new.pdseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_product_pseq BEFORE INSERT ON product
FOR EACH ROW
BEGIN
	SELECT SEQ_product_pseq.nextval
	INTO :new.pseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_qna_category_qcseq BEFORE INSERT ON qna_category
FOR EACH ROW
BEGIN
	SELECT SEQ_qna_category_qcseq.nextval
	INTO :new.qcseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_qna_qseq BEFORE INSERT ON qna
FOR EACH ROW
BEGIN
	SELECT SEQ_qna_qseq.nextval
	INTO :new.qseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_reply_rseq BEFORE INSERT ON reply
FOR EACH ROW
BEGIN
	SELECT SEQ_reply_rseq.nextval
	INTO :new.rseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_stock_sseq BEFORE INSERT ON stock
FOR EACH ROW
BEGIN
	SELECT SEQ_stock_sseq.nextval
	INTO :new.sseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_transport_tseq BEFORE INSERT ON transport
FOR EACH ROW
BEGIN
	SELECT SEQ_transport_tseq.nextval
	INTO :new.tseq
	FROM dual;
END;

/




/* Comments */

COMMENT ON COLUMN product_detail.price1 IS '원가';
COMMENT ON COLUMN product_detail.price2 IS '판매가';
COMMENT ON COLUMN product_detail.price3 IS '마진';
COMMENT ON COLUMN transport.description IS '배송위치';



