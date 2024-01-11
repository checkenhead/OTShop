create or replace procedure getAdmin(
    p_adminid in admins.adminid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from admins where adminid = p_adminid;
    
end;


--------------------------------------------------------------------------------------------

-- ¿Â¿Ø¡¯ (Member)

CREATE OR REPLACE PROCEDURE getMember(
    p_userid IN members.userid%TYPE,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM members WHERE userid = p_userid;
END;

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE findId(
    p_name IN members.name%TYPE,
    p_email IN members.email%TYPE,
    p_userid OUT members.userid%TYPE
)
IS
BEGIN
    SELECT userid INTO p_userid FROM members WHERE name = p_name AND email = p_email;
EXCEPTION
    WHEN NO_DATA_FOUND THEN p_userid := NULL;
END;

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE findPwd(
    p_userid IN OUT findAcc.userid%TYPE,
    p_kind OUT findAcc.kind%TYPE,
    p_answer OUT findAcc.answer%TYPE,
    p_pwd OUT findAcc.pwd%TYPE
)
IS
BEGIN
   SELECT kind, answer, pwd INTO p_kind, p_answer, p_pwd FROM findAcc WHERE userid = p_userid;
EXCEPTION
   WHEN NO_DATA_FOUND THEN p_pwd := NULL; 
END;


--------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertMember(
    p_userid IN members.userid%TYPE,         p_pwd IN members.pwd%TYPE,
    p_kind IN pwd_find.kind%TYPE,            p_answer IN pwd_find.answer%TYPE,
    p_name IN members.name%TYPE,             p_gender IN members.gender%TYPE,
    p_birthdate IN members.birthdate%TYPE,   p_tel IN members.tel%TYPE,
    p_email IN members.email%TYPE,           p_zipnum IN members.zipnum%TYPE,
    p_address1 IN members.address1%TYPE,     p_address2 IN members.address2%TYPE,     
    p_address3 IN members.address3%TYPE,     p_provider IN members.provider%TYPE
)
IS
BEGIN

    INSERT INTO members( userid, pwd, name, gender, birthdate, tel, email, zipnum, address1,
                        address2, address3, provider)
    VALUES ( p_userid, p_pwd, p_name, p_gender, p_birthdate, p_tel, p_email, p_zipnum,
            p_address1, p_address2, p_address3, p_provider);
            
    INSERT INTO pwd_find(pfseq, userid, kind, answer)
    VALUES ( pwd_find_pfseq.nextVal, p_userid, p_kind, p_answer);
    
    COMMIT;
END;

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE updateMember(
    p_userid IN members.userid%TYPE,        p_pwd IN members.pwd%TYPE,
    p_name IN members.name%TYPE,            p_gender IN members.gender%TYPE,
    p_birthdate IN members.birthdate%TYPE,  p_tel IN members.tel%TYPE,
    p_email IN members.email%TYPE,          p_zipnum IN members.zipnum%TYPE,
    p_address1 IN members.address1%TYPE,    p_address2 IN members.address2%TYPE,
    p_address3 IN members.address3%TYPE,    p_provider IN members.provider%TYPE
)
IS
BEGIN
    UPDATE members SET userid=p_userid, pwd=p_pwd, name=p_name, gender=p_gender, birthdate=p_birthdate,
    tel=p_tel, email=p_email, zipnum=p_zipnum, address1=p_address1, address2=p_address2,
    address3=p_address3, provider=p_provider
    WHERE userid = p_userid;
    COMMIT;
END;

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE deleteMember(
    p_userid IN members.userid%TYPE
)
IS
BEGIN
    UPDATE members SET useyn='N' WHERE userid = p_userid;
    COMMIT;
END;

--------------------------------------------------------------------------------------------














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
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductList(
    p_keyword in varchar2,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from product where name like '%' || p_keyword || '%' or brand like '%' || p_keyword || '%' order by regdate desc;
    
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

--create or replace procedure insertProduct(
--    p_optionlist in opt_table_type,
--    p_out out varchar2)
--is
--
--begin
--    p_out := 'success';
--    
--end;

------------------------------------------------------------------------------

create or replace procedure getCount(
    p_tablename in varchar2,
    p_keynum in number,
    p_cnt out number)
is

begin
    if p_tablename = 'product' then
        select count(*) into p_cnt from product where pcseq = p_keynum;
    elsif p_tablename = 'faq' then
        select count(*) into p_cnt from faq where fcseq = p_keynum;
    end if;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProductCat(
    p_name in product_category.name%type)
is

begin
    insert into product_category(pcseq, name)
    values(product_category_pcseq.nextval, p_name);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteProductCat(
    p_pcseq in product_category.pcseq%type)
is

begin
    delete from product_category where pcseq = p_pcseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateProductCat(
    p_pcseq in product_category.pcseq%type,
    p_name in product_category.name%type)
is

begin
    update product_category set name = p_name where pcseq = p_pcseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProduct(
    p_pseq in product.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from product where pseq = p_pseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateProduct(
    p_pseq in product.pseq%type,
    p_pcseq in product.pcseq%type,
    p_brand in product.brand%type,
    p_name in product.name%type,
    p_description in product.description%type,
    p_gender in product.gender%type,
    p_image in product.image%type,
    p_bestyn in product.bestyn%type,
    p_useyn in product.useyn%type)
is

begin
    update product set pcseq = p_pcseq, brand = p_brand, name = p_name, description = p_description,
    gender = p_gender, image = p_image, bestyn = p_bestyn, useyn = p_useyn
    where pseq = p_pseq;

    
end;
------------------------------------------------------------------------------

create or replace procedure updateProductDetail(
    p_pdseq in product_detail.pdseq%type,
    p_store in product_detail.stock%type,
    p_useyn in product_detail.useyn%type)
is

begin
    update product_detail set stock = stock + p_store, useyn = p_useyn where pdseq = p_pdseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure getFaqList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from faq_view order by fseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getFaqCatList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from faq_category order by fcseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertFaqCat(
    p_name in faq_category.name%type)
is

begin
    insert into faq_category(fcseq, name)
    values(faq_category_fcseq.nextval, p_name);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteFaqCat(
    p_fcseq in faq_category.fcseq%type)
is

begin
    delete from faq_category where fcseq = p_fcseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateFaqCat(
    p_fcseq in faq_category.fcseq%type,
    p_name in faq_category.name%type)
is

begin
    update faq_category set name = p_name where fcseq = p_fcseq;
    commit;
    
end;