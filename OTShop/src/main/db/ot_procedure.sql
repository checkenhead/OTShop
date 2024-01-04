create or replace procedure getAdmin(
    p_adminid in admins.adminid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from admins where adminid = p_adminid;
    
end;
<<<<<<< HEAD


--------------------------------------------------------------------------------------------

-- ÀåÀ¯Áø (Member)

CREATE OR REPLACE PROCEDURE getMember(
    p_userid IN members.userid%TYPE,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM members WHERE userid = p_userid;
END;


CREATE OR REPLACE PROCEDURE joinKakao(
    p_userid IN members.userid%TYPE,
    p_name IN members.name%TYPE,
    p_tel IN members.tel%TYPE,
    p_email IN members.email%TYPE,
    p_provider IN members.provider%TYPE
)
IS
BEGIN
    INSERT INTO members(userid, name, tel, email, provider, pwd, gender, birthdate)
    VALUES (p_userid, p_name, p_tel, p_email, p_provider, '1234', 'W', '1996-03-01');
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE insertMembet(
    p_userid IN members.userid%TYPE,         p_pwd IN members.pwd%TYPE,
    p_name IN members.name%TYPE,             p_gender IN members.gender%TYPE,
    p_birthdate IN members.birthdate%TYPE,   p_tel IN members.tel%TYPE,
    p_email IN members.email%TYPE,           p_zipnum IN members.zipnum%TYPE,
    p_address1 IN members.address1%TYPE,     p_address2 IN members.address2%TYPE,     
    p_address3 IN members.address3%TYPE,     p_provider IN members.provider%TYPE
)
IS
BEGIN
    INSERT INTO members(userid, pwd, name, gender, birthdate, tel, email, zipnum, address1,
                        address2, address3, provider)
    VALUES (p_userid, p_pwd, p_name, p_gender, p_birthdate, p_tel, p_email, p_zipnum,
            p_address1, p_address2, p_address3, p_provider);
    COMMIT;
END;















=======
------------------------------------------------------------------------------

create or replace procedure getProductCatList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from product_category order by pcseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProduct(
    p_pcseq in product.pcseq%type,
    p_brand in product.brand%type,
    p_name in product.name%type,
    p_description in product.description%type,
    p_gender in product.gender%type,
    p_image in product.image%type,
    p_pseq out product.pseq%type)
is

begin
    insert into product(pseq, pcseq, brand, name, description, gender, image)
    values(product_pseq.nextval, p_pcseq, p_brand, p_name, p_description, p_gender, p_image);
    p_pseq := product_pseq.currval;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProductDetail(
    p_pseq in product_detail.pseq%type,
    p_optname in product_detail.optname%type,
    p_price1 in product_detail.price1%type,
    p_price2 in product_detail.price2%type,
    p_price3 in product_detail.price3%type,
    p_stock in product_detail.stock%type)
is

begin
    insert into product_detail(pdseq, pseq, optname, price1, price2, price3, stock)
    values(product_detail_pdseq.nextval, p_pseq, p_optname, p_price1, p_price2, p_price3, p_stock);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from product order by regdate desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductDetailList(
    p_pseq in product_detail.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from product_detail where pseq = p_pseq order by pseq desc;
    
end;
------------------------------------------------------------------------------
>>>>>>> branch 'master' of https://github.com/checkenhead/OTShop.git
