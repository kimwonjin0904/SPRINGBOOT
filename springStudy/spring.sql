ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT CONNECT, RESOURCE TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;



CREATE TABLE MEMBERS (
    mem_id       VARCHAR2(50)    PRIMARY KEY,  -- 회원 ID (기본 키)
    mem_pw       VARCHAR2(1000)  NOT NULL,     -- 회원 비밀번호
    mem_nm       VARCHAR2(100),                -- 회원 이름
    mem_addr     VARCHAR2(1000),               -- 회원 주소
    profile_img  VARCHAR2(1000),               -- 프로필 이미지 URL 또는 경로
    use_yn       VARCHAR2(1)    DEFAULT 'Y',   -- 사용 여부 (Y 또는 N)
    update_dt    DATE           DEFAULT SYSDATE, -- 정보 수정일
    create_dt    DATE           DEFAULT SYSDATE  -- 정보 생성일
);
COMMENT ON COLUMN members.mem_id IS '회원 ID (기본 키)';
COMMENT ON COLUMN members.mem_pw IS '회원 비밀번호';
COMMENT ON COLUMN members.mem_nm IS '회원 이름';
COMMENT ON COLUMN members.mem_addr IS '회원 주소';
COMMENT ON COLUMN members.profile_img IS '프로필 이미지 URL 또는 경로';
COMMENT ON COLUMN members.use_yn IS '사용 여부 (Y 또는 N)';
COMMENT ON COLUMN members.update_dt IS '정보 수정일';
COMMENT ON COLUMN members.create_dt IS '정보 생성일';


commit;



SELECT *
FROM members;

INSERT INTO members (mem_id,mem_pw, mem_nm)
VALUES('a001','1234','닉');
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
    board_no       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- 자동 증가 (IDENTITY)
    board_title    VARCHAR2(1000),                                    -- 게시글 제목
    mem_id         VARCHAR2(100) NOT NULL,                            -- 작성자 ID (회원 테이블 참조)
    board_content  VARCHAR2(2000),                                    -- 게시글 내용
    create_dt      DATE DEFAULT SYSDATE,                              -- 생성 날짜 (기본값: 현재 시간)
    update_dt      DATE DEFAULT SYSDATE,                              -- 수정 날짜 (기본값: 현재 시간)
    use_yn         VARCHAR2(1) DEFAULT 'Y',                           -- 사용 여부 (기본값: 'Y')
    CONSTRAINT fk_boards_members FOREIGN KEY (mem_id) REFERENCES members(mem_id)
);


--replys 테이블의 스키마 정보--
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


--테스트--
INSERT INTO boards (board_title, mem_id, board_content)
VALUES  ('test2','nick','내용입니다.');

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


----상세조회
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








