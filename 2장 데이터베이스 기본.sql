// 1-1. 테이블 생성
CREATE TABLE USER1(
    ID      VARCHAR2(20),
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER
);

// 1-2
INSERT INTO USER1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER1 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER1 (id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER1 (id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');

// 1-3
SELECT * FROM USER1;
SELECT * FROM USER1 WHERE id='A101';
SELECT * FROM USER1 WHERE name='김춘추';
SELECT * FROM USER1 WHERE age > 30;
SELECT id, name, age FROM USER1;

// 1-4
UPDATE USER1 SET hp='010-1234-4444' WHERE id='A104';
UPDATE USER1 SET age=51 WHERE id='A105';
UPDATE USER1 SET hp='010-1234-1001', age=27 WHERE id='A101';

// 1-5
DELETE FROM USER1 WHERE id='A101';
DELETE FROM USER1 WHERE id='A102' AND age=25;
DELETE FROM USER1 WHERE age >= 30;


////////////////////////////////////////////////////


// 2-1
CREATE TABLE USER2(
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER(2)
);

INSERT INTO USER2 VALUES ('A101','김유신','010-1234-1001',25);
INSERT INTO USER2 VALUES ('A101','김춘추','010-1234-1002',23);

// 2-2
CREATE TABLE USER3(
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13) UNIQUE,
    AGE     NUMBER(3)
);

INSERT INTO USER3 VALUES ('A101','김유신','010-1234-1001',25);
INSERT INTO USER3 VALUES ('A102','김춘추','010-1234-1002',23);
INSERT INTO USER3 VALUES ('A103','장보고','010-1234-1003',35);
INSERT INTO USER3 VALUES ('A104','강감찬','010-1234-1004',43);
INSERT INTO USER3 VALUES ('A105','정약용','010-1234-1005',55);

// 2-3
CREATE TABLE PARENT(
    PID     VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13) UNIQUE
);

CREATE TABLE CHILD(
    CID     VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13) UNIQUE,
    PARENT  VARCHAR2(20),
    FOREIGN KEY (PARENT) REFERENCES PARENT (PID)
);


INSERT INTO PARENT VALUES ('P101', '김서현', '010-1234-1001');
INSERT INTO PARENT VALUES ('P102', '이성계', '010-1234-1002');
INSERT INTO PARENT VALUES ('P103', '신사임당', '010-1234-1003');

INSERT INTO CHILD VALUES ('C101', '김유신', '010-1234-2001', 'P101');
INSERT INTO CHILD VALUES ('C102', '이방우', '010-1234-2002', 'P102');
INSERT INTO CHILD VALUES ('C103', '이방원', '010-1234-2003', 'P102');
INSERT INTO CHILD VALUES ('C104', '이이', '010-1234-2004', 'P103');


// 2-4
CREATE TABLE USER4(
    NAME        VARCHAR2(20) NOT NULL,
    GENDER      CHAR(1) NOT NULL,
    AGE         INT DEFAULT 1,
    ADDR        VARCHAR2(255)
);

INSERT INTO USER4 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER4 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER4 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER4 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER4 (NAME, GENDER, AGE) VALUES ('정약용', 'M',33);


// 2-5
CREATE TABLE USER5(
    NAME        VARCHAR2(20) NOT NULL,
    GENDER      CHAR(1) NOT NULL CHECK(GENDER IN('M', 'F')),
    AGE         INT DEFAULT 1 CHECK(AGE > 0 AND AGE < 100),
    ADDR        VARCHAR(255)
);

INSERT INTO USER5 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER5 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER5 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER5 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER5 (NAME, GENDER, AGE) VALUES ('정약용', 'M', 33);


////////////////////////////////////////////////////////


// 3-1. 데이터 사전 조회
SELECT * FROM DICT;

SELECT TABLE_NAME FROM USER_TABLES;

SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

SELECT * FROM DBA_TABLES;

SELECT * FROM DBA_USERS;

// 3-2 인덱스 조회/생성/삭제
-- 현재 사용자 인덱스 조회
SELECT * FROM USER_INDEXES;

-- 현재 사용자 인덱스 정보 조회
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 생성
CREATE INDEX IDX_USER1_ID ON USER1(ID);
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 삭제
DROP INDEX IDX_USER1_ID;
SELECT * FROM USER_IND_COLUMNS;

// 3-3 뷰 생성 권한 할당
GRANT CREATE VIEW TO scott;

// 3-4 뷰 생성/조회/삭제
// 뷰 생성
CREATE VIEW VW_USER1 AS (SELECT NAME, HP, AGE FROM USER1);
CREATE VIEW VW_USER2_AGE_UNDER30 AS (SELECT * FROM USER2 WHERE AGE < 30);
SELECT * FROM USER_VIEWS;

SELECT * FROM VW_USER1;
SELECT * FROM VW_USER2_AGE_UNDER30;

DROP VIEW VW_USER1;
DROP VIEW VW_USER2_AGE_UNDER30;

// 3-5 시퀀스 실습
CREATE TABLE USER6(
    SEQ     NUMBER PRIMARY KEY,
    NAME    VARCHAR2(20),
    GENDER  CHAR(1),
    AGE     NUMBER,
    ADDR    VARCHAR2(255)
);

// 3-6 시퀀스 생성 (1부터 1씩 증가하는 시퀀스)
CREATE SEQUENCE SEQ_USER6 INCREMENT BY 1 START WITH 1;

// 3-7 시퀀스 값 입력
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김유신', 'M', 25, '김해시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김춘추', 'M', 23, '경주시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '신사임당', 'F', 27, '강릉시');

// 4-1 사용자 생성(SYSTEM 접속)
// 사용자 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER lomong IDENTIFIED BY "1234";

// 4-2 사용자 조회
// 전체 사용자 조회
SELECT * FROM ALL_USERS;
SELECT * FROM ALL_USERS WHERE USERNAME='LOMONG';

// 4-3 사용자 변경
ALTER USER LOMONG IDENTIFIED BY "q12we34r";
ALTER USER LOMONG IDENTIFIED BY "1234";
DROP USER lomong;
// 테이블까지 모두 삭제
DROP USER lomong CASCADE;

// 4-4 Role 부여
GRANT CONNECT, RESOURCE TO lomong;
GRANT UNLIMITED TABLESPACE TO lomong;

