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















