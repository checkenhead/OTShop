create or replace procedure getAdmin(
    p_adminid in admins.adminid%type,
    p_cur out sys_refcursor)
is

begin
    open p_cur for select * from admins where adminid = p_adminid;
    
end;
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