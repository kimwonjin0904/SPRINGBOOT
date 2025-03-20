ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT CONNECT, RESOURCE TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;



CREATE TABLE MEMBERS (
    mem_id       VARCHAR2(50)    PRIMARY KEY,  -- ȸ�� ID (�⺻ Ű)
    mem_pw       VARCHAR2(1000)  NOT NULL,     -- ȸ�� ��й�ȣ
    mem_nm       VARCHAR2(100),                -- ȸ�� �̸�
    mem_addr     VARCHAR2(1000),               -- ȸ�� �ּ�
    profile_img  VARCHAR2(1000),               -- ������ �̹��� URL �Ǵ� ���
    use_yn       VARCHAR2(1)    DEFAULT 'Y',   -- ��� ���� (Y �Ǵ� N)
    update_dt    DATE           DEFAULT SYSDATE, -- ���� ������
    create_dt    DATE           DEFAULT SYSDATE  -- ���� ������
);
COMMENT ON COLUMN members.mem_id IS 'ȸ�� ID (�⺻ Ű)';
COMMENT ON COLUMN members.mem_pw IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN members.mem_nm IS 'ȸ�� �̸�';
COMMENT ON COLUMN members.mem_addr IS 'ȸ�� �ּ�';
COMMENT ON COLUMN members.profile_img IS '������ �̹��� URL �Ǵ� ���';
COMMENT ON COLUMN members.use_yn IS '��� ���� (Y �Ǵ� N)';
COMMENT ON COLUMN members.update_dt IS '���� ������';
COMMENT ON COLUMN members.create_dt IS '���� ������';


commit;



SELECT *
FROM members;

INSERT INTO members (mem_id,mem_pw, mem_nm)
VALUES('a001','1234','��');
commit;

delete members;
commit;



SELECT   mem_id
        ,mem_pw
        ,mem_nm

FROM members
WHERE use_yn = 'Y'
AND mem_id = 'nick'
AND mem_pw='1234';




-----member.xml
SELECT   mem_id
        ,mem_pw
        ,mem_nm
        ,profile_img
FROM members
WHERE use_yn = 'Y'
AND mem_id = 'nick'
AND mem_pw='1234';




------boards ------------
CREATE TABLE boards (
    board_no       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- �ڵ� ���� (IDENTITY)
    board_title    VARCHAR2(1000),                                    -- �Խñ� ����
    mem_id         VARCHAR2(100) NOT NULL,                            -- �ۼ��� ID (ȸ�� ���̺� ����)
    board_content  VARCHAR2(2000),                                    -- �Խñ� ����
    create_dt      DATE DEFAULT SYSDATE,                              -- ���� ��¥ (�⺻��: ���� �ð�)
    update_dt      DATE DEFAULT SYSDATE,                              -- ���� ��¥ (�⺻��: ���� �ð�)
    use_yn         VARCHAR2(1) DEFAULT 'Y',                           -- ��� ���� (�⺻��: 'Y')
    CONSTRAINT fk_boards_members FOREIGN KEY (mem_id) REFERENCES members(mem_id)
);


--replys ���̺��� ��Ű�� ����--
CREATE TABLE replys (
    reply_no       NUMBER(10),              PRIMARY KEY (board_no, reply_no),                         
    board_no       NUMBER(10) NOT NULL,                          
    mem_id         VARCHAR2(100) NOT NULL,                      
    reply_content  VARCHAR2(1000),                              
    reply_date     DATE DEFAULT SYSDATE,                        
    del_yn         VARCHAR2(1) DEFAULT 'N',                                              
    CONSTRAINT fk_replys_boards FOREIGN KEY (board_no) REFERENCES boards(board_no) ON DELETE CASCADE,
    CONSTRAINT fk_replys_members FOREIGN KEY (mem_id) REFERENCES members(mem_id) ON DELETE CASCADE
);



select *
from boards;


--�׽�Ʈ--
INSERT INTO boards (board_title, mem_id, board_content)
VALUES  ('test2','nick','�����Դϴ�.');

SELECT a.board_no
     , a.board_title
     , b.mem_id
     , b.mem_nm
     , TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
    ,members b
WHERE a.mem_id = b.mem_id
AND   a.use_yn = 'Y'
ORDER BY a.update_dt DESC;


----����ȸ
SELECT a.board_no
     , a.board_title
     , a.board_content
     , b.mem_id
     , b.mem_nm
     , TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
    ,members b
WHERE a.mem_id = b.mem_id
AND   a.use_yn = 'Y'
AND   a.board_no = '4';







select * from 








