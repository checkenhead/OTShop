create or replace procedure getAdmin(
    p_adminid in admins.adminid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from admins where adminid = p_adminid;
    
end;


--------------------------------------------------------------------------------------------

-- 장유진 (Member)

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

--------------------------------------------------------------------------------------------

-- 장유진 (FAQ)


CREATE OR REPLACE PROCEDURE listFaq(
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM faq_view ORDER BY fseq DESC;
END;

--------------------------------------------------------------------------------------------

-- 장유진 (Customer)


CREATE OR REPLACE PROCEDURE listQna(
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM qna_view ORDER BY qseq DESC;
END;

--------------------------------------------------------------------------------------------

create or replace procedure getQnaCatListUser(
    p_qseq IN qna_view.qseq%TYPE,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from qna_view WHERE qseq = p_qseq;
    
end;

--------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertQna(
    p_userid IN qna.userid%TYPE,
    p_secret IN qna.secret%TYPE,
    p_qcseq IN qna.qcseq%TYPE,
    p_title IN qna.title%TYPE,
    p_content IN qna.content%TYPE
)
IS
BEGIN

    INSERT INTO qna( qseq, qcseq, userid, secret, title, content )
    VALUES ( qna_qseq.nextVal, p_qcseq, p_userid, p_secret, p_title, p_content);
    
    COMMIT;
END;
------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE getLogis(
    p_logisid in logis.logisid%TYPE,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM logis WHERE logisid = p_logisid;
END;
------------------------------------------------------------------------------

create or replace procedure getAllProductCatList(
    p_categoryClass in varchar2,
    p_cur out sys_refcursor)
is

begin
    if p_categoryClass = 'main' then
        open p_cur for select * from product_main_category order by pmcseq asc;
    elsif p_categoryClass = 'sub' then
        open p_cur for select * from product_sub_category order by pscseq asc;
    end if;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProduct(
    p_brand in product.brand%type,
    p_name in product.name%type,
    p_description in product.description%type,
    p_gender in product.gender%type,
    p_image in product.image%type,
    p_pseq out product.pseq%type)
is

begin
    insert into product(pseq, brand, name, description, gender, image)
    values(product_pseq.nextval, p_brand, p_name, p_description, p_gender, p_image);
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
    if p_tablename = 'product_main_category' then
        select count(*) into p_cnt from product_main_category_list where pmcseq = p_keynum;
    elsif p_tablename = 'product_sub_category' then
        select count(*) into p_cnt from product_sub_category_list where pscseq = p_keynum;
    elsif p_tablename = 'faq' then
        select count(*) into p_cnt from faq where fcseq = p_keynum;
    elsif p_tablename = 'qna' then
        select count(*) into p_cnt from qna where qcseq = p_keynum;
    elsif p_tablename = 'banner' then
        select count(*) into p_cnt from banner where priority > 0 and biseq = p_keynum;
    end if;
    
end;
------------------------------------------------------------------------------
--제품 카테고리 변경
--create or replace procedure insertProductCat(
--    p_name in product_category.name%type)
--is
--
--begin
--    insert into product_category(pcseq, name)
--    values(product_category_pcseq.nextval, p_name);
--    commit;
--    
--end;
------------------------------------------------------------------------------

create or replace procedure insertProductCat(
    p_tablename in varchar2,
    p_name in varchar2)
is

begin
    if p_tablename = 'main' then
        insert into product_main_category(pmcseq, name)
        values(product_main_category_pmcseq.nextval, p_name);
    elsif  p_tablename = 'sub' then
        insert into product_sub_category(pscseq, name)
        values(product_sub_category_pscseq.nextval, p_name);
    end if;
    
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteProductCat(
    p_tablename in varchar2,
    p_index in number)
is

begin
    if p_tablename = 'main' then
         delete from product_main_category where pmcseq = p_index;
    elsif  p_tablename = 'sub' then
         delete from product_sub_category where pscseq = p_index;
    end if;
    
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateProductCat(
    p_tablename in varchar2,
    p_index in number,
    p_name in varchar2)
is

begin
    if p_tablename = 'main' then
         update product_main_category set name = p_name where pmcseq = p_index;
    elsif  p_tablename = 'sub' then
         update product_sub_category set name = p_name where pscseq = p_index;
    end if;
    
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
    p_brand in product.brand%type,
    p_name in product.name%type,
    p_description in product.description%type,
    p_gender in product.gender%type,
    p_image in product.image%type,
    p_bestyn in product.bestyn%type,
    p_useyn in product.useyn%type)
is

begin
    update product set brand = p_brand, name = p_name, description = p_description,
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
------------------------------------------------------------------------------

create or replace procedure insertFaq(
    p_fcseq in faq.fcseq%type,
    p_title in faq.title%type,
    p_content in faq.content%type)
is

begin
    insert into faq(fseq, fcseq, title, content)
    values(faq_fseq.nextval, p_fcseq, p_title, p_content);
    commit;
    
end;

------------------------------------------------------------------------------

create or replace procedure updateFaq(
    p_fseq in faq.fseq%type,
    p_fcseq in faq.fcseq%type,
    p_title in faq.title%type,
    p_content in faq.content%type)
is

begin
    update faq set fcseq = p_fcseq, title = p_title, content = p_content
    where fseq = p_fseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteFaq(
    p_fseq in faq.fseq%type)
is

begin
    delete from faq where fseq = p_fseq;
    commit;
    
end;

------------------------------------------------------------------------------

create or replace procedure getMemberList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from members order by regdate desc;
    
end;

------------------------------------------------------------------------------

create or replace procedure changeMemberUseyn(
    p_userid in members.userid%type,
    p_useyn in members.useyn%type)
is

begin
    update members set useyn = p_useyn where userid = p_userid;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getQnaList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from qna_view order by regdate desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getQnaCatList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from qna_category order by qcseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertQnaCat(
    p_name in qna_category.name%type)
is

begin
    insert into qna_category(qcseq, name)
    values(qna_category_qcseq.nextval, p_name);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteQnaCat(
    p_qcseq in qna_category.qcseq%type)
is

begin
    delete from qna_category where qcseq = p_qcseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateQnaCat(
    p_qcseq in qna_category.qcseq%type,
    p_name in qna_category.name%type)
is

begin
    update qna_category set name = p_name where qcseq = p_qcseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getQna(
    p_qseq in qna_view.qseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from qna_view where qseq = p_qseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateQnaReply(
    p_qseq in qna.qseq%type,
    p_reply in qna.reply%type)
is

begin
    update qna set reply = p_reply where qseq = p_qseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteQna(
    p_qseq in qna.qseq%type)
is

begin
    delete from qna where qseq = p_qseq;
    commit;
    
end;

------------------------------------------------------------------------------

create or replace procedure insertBannerImage(
    p_name in banner_images.name%type,
    p_image in banner_images.image%type)
is

begin
    insert into banner_images(biseq, name, image)
    values(banner_images_biseq.nextval, p_name, p_image);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getBannerImageList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from banner_images order by biseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteBannerImage(
    p_biseq in banner_images.biseq%type)
is

begin
    delete from banner_images where biseq = p_biseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getImageByBiseq(
    p_biseq in banner_images.biseq%type,
    p_image out varchar2)
is

begin
    select image into p_image from banner_images where biseq = p_biseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertBanner(
    p_biseq in banner.biseq%type,
    p_uri in banner.uri%type,
    p_useyn in banner.useyn%type,
    p_priority in banner.priority%type)
is

begin
    insert into banner(bseq, biseq, uri, useyn, priority)
    values(banner_bseq.nextval, p_biseq, p_uri, p_useyn, p_priority);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getBannerList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from banner_view order by (case when priority = 0 then 1 else 0 end), priority;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteBanner(
    p_bseq in banner.bseq%type)
is

begin
    delete from banner where bseq = p_bseq;
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure updateBanner(
    p_bseq in banner.bseq%type,
    p_uri in banner.uri%type,
    p_useyn in banner.useyn%type,
    p_priority in banner.priority%type)
is

begin
    update banner set uri = p_uri, useyn = p_useyn, priority = p_priority where bseq = p_bseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getMaxPriority(
    p_maxpriority out number)
is

begin
    select max(nvl(priority, 0)) into p_maxpriority from banner;
    
end;
------------------------------------------------------------------------------

create or replace procedure getBannerPriorityList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from banner where priority > 0 order by priority asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateBannerPriority(
    p_bseq in banner.bseq%type,
    p_priority in banner.priority%type)
is

begin
    update banner set priority = p_priority where bseq = p_bseq;
    -- no commit here : Service Transaction
end;
------------------------------------------------------------------------------

create or replace procedure getMainCatList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from product_main_category order by pmcseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getSubCatList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from product_sub_category order by pscseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProductMainCatSet(
    p_pmcseq in product_main_cat_set.pmcseq%type,
    p_pmcsseq out product_main_cat_set.pmcsseq%type)
is

begin
    insert into product_main_cat_set(pmcsseq, pmcseq)
    values(product_main_cat_set_pmcsseq.nextval, p_pmcseq);
    p_pmcsseq := product_main_cat_set_pmcsseq.currval;
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure insertProductSubCatSet(
    p_pmcsseq in product_sub_cat_set.pmcsseq%type,
    p_pscseq in product_sub_cat_set.pscseq%type)
is

begin
    insert into product_sub_cat_set(pscsseq, pmcsseq, pscseq)
    values(product_sub_cat_set_pscsseq.nextval, p_pmcsseq, p_pscseq);
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure getMainCatSetList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from product_main_cat_set_view order by pmcsseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getSubCatSetList(
    p_pmcsseq in product_sub_cat_set.pmcsseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
    select * from product_sub_cat_set_view where pmcsseq = p_pmcsseq order by pscsseq asc;
    
end;

------------------------------------------------------------------------------

create or replace procedure updateProductCatSet(
    p_tablename in varchar2,
    p_index in number,
    p_value in number)
is

begin
    if p_tablename = 'main' then
        update product_main_cat_set set pmcseq = p_value where pmcsseq = p_index;
    elsif p_tablename = 'sub' then
        update product_sub_cat_set set pscseq = p_value where pscsseq = p_index;
    end if;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteProductCatSet(
    p_tablename in varchar2,
    p_index in number)
is

begin
    if p_tablename = 'main' then
        delete from product_main_cat_set where pmcsseq = p_index;
    elsif p_tablename = 'sub' then
        delete from product_sub_cat_set where pscsseq = p_index;
    end if;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertMainCatList(
    p_pseq in product_main_category_list.pseq%type,
    p_pmcseq in product_main_category_list.pmcseq%type)
is

begin
    insert into product_main_category_list(pmclseq, pseq, pmcseq)
    values(product_main_cat_list_pmclseq.nextval, p_pseq, p_pmcseq);
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure insertSubCatList(
    p_pseq in product_sub_category_list.pseq%type,
    p_pscseq in product_sub_category_list.pscseq%type)
is

begin
    insert into product_sub_category_list(psclseq, pseq, pscseq)
    values(product_sub_cat_list_psclseq.nextval, p_pseq, p_pscseq);
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductMainCatList(
    p_pseq in product_main_cat_list_view.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product_main_cat_list_view where pseq = p_pseq order by pmclseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductSubCatList(
    p_pseq in product_sub_cat_list_view.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product_sub_cat_list_view where pseq = p_pseq order by psclseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteMainCatList(
    p_pmclseq in product_main_category_list.pmclseq%type)
is

begin
    delete from product_main_category_list where pmclseq = p_pmclseq;
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteSubCatList(
    p_psclseq in product_sub_category_list.psclseq%type)
is

begin
    delete from product_sub_category_list where psclseq = p_psclseq;
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductMainCatList(
    p_pseq in product_main_category_list.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product_main_category_list where pseq = p_pseq order by pmclseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductSubCatList(
    p_pseq in product_sub_category_list.pseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product_sub_category_list where pseq = p_pseq order by psclseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductListByPmcseq(
    p_pmcseq in product_main_category_list.pmcseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product where pseq in 
        (select pseq from product_main_category_list where pmcseq = p_pmcseq)
        order by regdate desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getProductListByPscseq(
    p_pscseq in product_sub_category_list.pscseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product where pseq in 
        (select pseq from product_sub_category_list where pscseq = p_pscseq)
        order by regdate desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getCartList(
    p_userid in cart.userid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from product_cart_view where userid = p_userid order by cseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertCart(
    p_userid in cart.userid%type,
    p_pdseq in cart.pdseq%type,
    p_qty in cart.qty%type)
is

begin
    insert into cart(cseq, userid, pdseq, qty) values(cart_cseq.nextval, p_userid, p_pdseq, p_qty);
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure deleteCart(
    p_cseq in cart.cseq%type)
is

begin
    delete from cart where cseq = p_cseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertOrders(
    p_userid in orders.userid%type,
    p_oseq out number)
is

begin
    insert into orders(oseq, userid) values(orders_oseq.nextval, p_userid);
    p_oseq := orders_oseq.currval;
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure getCart(
    p_cseq in cart.cseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from cart where cseq = p_cseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertOrderDetail(
    p_oseq in order_detail.oseq%type,
    p_pdseq in order_detail.pdseq%type,
    p_qty in order_detail.qty%type)
is

begin
    insert into order_detail(odseq, oseq, pdseq, qty)
    values(order_detail_odseq.nextval, p_oseq, p_pdseq, p_qty);
    -- no commit here : Service Transaction
    
end;
------------------------------------------------------------------------------

create or replace procedure getOrderList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from orders_view order by oseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure getOrderDetailList(
    p_oseq in order_detail_view.oseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from order_detail_view where oseq = p_oseq order by odseq asc;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateOrderState(
    p_oseq in order_detail_view.oseq%type,
    p_command in varchar2)
is

begin
    if p_command = 'cancel' then
        update orders set state = '0' where oseq = p_oseq;
    elsif p_command = 'preparing' then
        update orders set state = '2' where oseq = p_oseq;
    elsif p_command = 'delivering' then
        update orders set state = '3' where oseq = p_oseq;
    elsif p_command = 'deliverCompleted' then
        update orders set state = '4' where oseq = p_oseq;
    elsif p_command = 'purchaseConfirmed' then
        update orders set state = '5' where oseq = p_oseq;
    elsif p_command = 'returning' then
        update orders set state = '6' where oseq = p_oseq;
    elsif p_command = 'returnCompleted' then
        update orders set state = '7' where oseq = p_oseq;
    elsif p_command = 'checking' then
        update orders set state = '8' where oseq = p_oseq;
    elsif p_command = 'RefundCompleted' then
        update orders set state = '9' where oseq = p_oseq;
    end if;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertInvoice(
    p_clientid in invoice.clientid%type,
    p_ordernum in invoice.ordernum%type,
    p_recipient in invoice.recipient%type,
    p_tel in invoice.tel%type,
    p_zipnum in invoice.zipnum%type,
    p_address1 in invoice.address1%type,
    p_address2 in invoice.address2%type,
    p_address3 in invoice.address3%type)
is

begin
    insert into invoice(iseq, clientid, ordernum, recipient, tel, zipnum, address1, address2, address3)
    values(invoice_iseq.nextval, p_clientid, p_ordernum, p_recipient, p_tel, p_zipnum, p_address1, p_address2, p_address3);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getInvoiceStateByIseq(
    p_iseq in invoice.iseq%type,
    p_state out invoice.state%type)
is

begin
    select state into p_state from invoice where iseq = p_iseq;
    
end;
------------------------------------------------------------------------------

create or replace procedure getInvoiceStateByIdAndOrdernum(
    p_clientid in invoice.clientid%type,
    p_ordernum in invoice.ordernum%type,
    p_state out varchar2)
is

begin
    select state into p_state from invoice where clientid = p_clientid and ordernum = p_ordernum;
    exception when no_data_found then p_state := '0';
    
end;
------------------------------------------------------------------------------

create or replace procedure getInvoicenumByIdAndOrdernum(
    p_clientid in invoice.clientid%type,
    p_ordernum in invoice.ordernum%type,
    p_invoicenum out invoice.iseq%type)
is

begin
    select iseq into p_invoicenum from invoice where clientid = p_clientid and ordernum = p_ordernum;
    exception when no_data_found then p_invoicenum := 0;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateOrderInvoicenum(
    p_oseq in orders.oseq%type,
    p_invoicenum in orders.invoicenum%type)
is

begin
    update orders set invoicenum = p_invoicenum where oseq = p_oseq;
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure getAllInvoiceList(
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from invoice order by iseq desc;
    
end;
------------------------------------------------------------------------------

create or replace procedure insertTransport(
    p_iseq in transport.iseq%type,
    p_logisid in transport.logisid%type,
    p_description in transport.description%type,
    p_state in transport.state%type)
is

begin
    insert into transport(tseq, iseq, logisid, description, state)
    values(transport_tseq.nextval, p_iseq, p_logisid, p_description, p_state);
    commit;
    
end;
------------------------------------------------------------------------------

create or replace procedure updateInvoiceState(
    p_iseq in invoice.iseq%type,
    p_command in varchar2)
is

begin
    if p_command = 'startCollect' then
        update invoice set state = '2' where iseq = p_iseq;
    elsif p_command = 'collectgCompleted' then
        update invoice set state = '3' where iseq = p_iseq;
    elsif p_command = 'delivering' then
        update invoice set state = '4' where iseq = p_iseq;
    elsif p_command = 'deliverCompleted' then
        update invoice set state = '9' where iseq = p_iseq;
    end if;
    
    commit;
    
end;
------------------------------------------------------------------------------

--create or replace procedure getTransportListById(
--    p_logisid in transport.logisid%type,
--    p_cur out sys_refcursor)
--is
--
--begin
--    open p_cur for
--        select * from transport order by state asc, tseq asc;
--    
--end;
------------------------------------------------------------------------------

create or replace procedure getInvoiceListByLogisid(
    p_logisid in transport.logisid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from invoice where iseq in
            (select distinct iseq from
                (select * from transport where logisid = p_logisid order by regdate desc));
    
end;
------------------------------------------------------------------------------

create or replace procedure getTransportListByIseq(
    p_iseq in transport.iseq%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for
        select * from transport where iseq = p_iseq order by regdate asc;
    
end;

