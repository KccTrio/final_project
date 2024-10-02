-- 삭제 
-- Foreign Key 제약 조건 삭제 (참조 순서 고려)
ALTER TABLE tag DROP CONSTRAINT FK_attached_file_TO_tag_1;
ALTER TABLE attached_file DROP CONSTRAINT FK_chat_TO_attached_file_1;

ALTER TABLE chat_status DROP CONSTRAINT FK_chat_TO_chat_status_1;
ALTER TABLE chat_status DROP CONSTRAINT FK_parti_emp_chat_status;

ALTER TABLE chat DROP CONSTRAINT FK_chat_room_TO_chat_1;

ALTER TABLE participation_employee DROP CONSTRAINT FK_employee_parti_emp_1;
ALTER TABLE participation_employee DROP CONSTRAINT FK_chat_room_parti_emp;

ALTER TABLE notification DROP CONSTRAINT FK_employee_TO_notification_1;

ALTER TABLE role DROP CONSTRAINT FK_employee_TO_role_1;

ALTER TABLE schedule_invite DROP CONSTRAINT FK_em_sche_invite;
ALTER TABLE schedule_invite DROP CONSTRAINT FK_sche_sche_invite;

ALTER TABLE detail_code DROP CONSTRAINT FK_master_TO_detail_1;

ALTER TABLE department DROP CONSTRAINT FK_department_TO_department_1;
ALTER TABLE department DROP CONSTRAINT FK_company_TO_department_1;

ALTER TABLE employee DROP CONSTRAINT FK_department_TO_employee_1;
ALTER TABLE employee DROP CONSTRAINT FK_company_TO_employee_1;

-- Primary Key 제약 조건 삭제
ALTER TABLE tag DROP CONSTRAINT PK_TAG;
ALTER TABLE attached_file DROP CONSTRAINT PK_ATTACHED_FILE;
ALTER TABLE chat_status DROP CONSTRAINT PK_CHAT_STATUS;
ALTER TABLE chat DROP CONSTRAINT PK_CHAT;
ALTER TABLE participation_employee DROP CONSTRAINT PK_PARTICIPATION_EMPLOYEE;
ALTER TABLE chat_room DROP CONSTRAINT PK_CHAT_ROOM;
ALTER TABLE notification DROP CONSTRAINT PK_NOTIFICATION;
ALTER TABLE role DROP CONSTRAINT PK_ROLE;
ALTER TABLE schedule_invite DROP CONSTRAINT PK_SCHEDULE_INVITE;
ALTER TABLE schedule DROP CONSTRAINT PK_SCHEDULE;
ALTER TABLE master_code DROP CONSTRAINT PK_MASTER;
ALTER TABLE detail_code DROP CONSTRAINT PK_DETAIL;
ALTER TABLE department DROP CONSTRAINT PK_DEPARTMENT;
ALTER TABLE employee DROP CONSTRAINT PK_EMPLOYEE;
ALTER TABLE company DROP CONSTRAINT PK_COMPANY;

-- 테이블 삭제
DROP TABLE tag CASCADE CONSTRAINTS;
DROP TABLE attached_file CASCADE CONSTRAINTS;
DROP TABLE chat_status CASCADE CONSTRAINTS;
DROP TABLE chat CASCADE CONSTRAINTS;
DROP TABLE participation_employee CASCADE CONSTRAINTS;
DROP TABLE chat_room CASCADE CONSTRAINTS;
DROP TABLE notification CASCADE CONSTRAINTS;
DROP TABLE role CASCADE CONSTRAINTS;
DROP TABLE schedule_invite CASCADE CONSTRAINTS;
DROP TABLE schedule CASCADE CONSTRAINTS;
DROP TABLE master_code CASCADE CONSTRAINTS;
DROP TABLE detail_code CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE company CASCADE CONSTRAINTS;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_COMPANY;
DROP SEQUENCE SEQ_EMPLOYEE;
DROP SEQUENCE SEQ_DEPARTMENT;
DROP SEQUENCE SEQ_NOTIFICATION;
DROP SEQUENCE SEQ_CHAT_ROOM;
DROP SEQUENCE SEQ_CHAT;
DROP SEQUENCE SEQ_ATTACHED_FILE;
DROP SEQUENCE SEQ_SCHEDULE;
DROP SEQUENCE SEQ_SCHEDULE_INVITE;
DROP SEQUENCE SEQ_MASTER_CODE;
DROP SEQUENCE SEQ_DETAIL_CODE;
DROP SEQUENCE SEQ_ROLE;
DROP SEQUENCE SEQ_TAG;


-- 생성
CREATE TABLE company (
	company_id NUMBER NOT NULL,
	name VARCHAR2(50) NULL,
	img_url VARCHAR(200) NULL,
	domain VARCHAR2(200) NULL,
	term TIMESTAMP NULL,
	company_number VARCHAR(15) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modify_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);


CREATE TABLE employee (
	employee_id NUMBER NOT NULL,
	dept_id NUMBER NOT NULL,
	company_id NUMBER NOT NULL,
	email VARCHAR2(50) NULL,
	password VARCHAR2(300) NULL,
	phone_num VARCHAR2(15) NULL,
	external_email VARCHAR2(50) NULL,
	name VARCHAR2(20) NULL,
	birth DATE NULL,
	profile_url VARCHAR(200) NULL,
	fax VARCHAR2(20) NULL,
	location VARCHAR2(200) NULL,
	is_receive_notification NUMBER(1) NULL,
	position VARCHAR2(30) NULL,
	status NUMBER NULL,
	status_message VARCHAR2(200) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE department (
	dept_id NUMBER NOT NULL,
	upper_dept_id NUMBER NULL,
	company_id NUMBER NOT NULL,
	name VARCHAR2(50) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modify_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL,
	dept_order NUMBER NULL
);

CREATE TABLE notification (
	notification_id NUMBER NOT NULL,
	employee_id NUMBER NOT NULL,
	notification_checked NUMBER(1) NULL,
	related_id NUMBER NULL,
	type NUMBER NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE chat_room (
	chat_room_id NUMBER NOT NULL,
	fixed_chat_id NUMBER NULL,
	name VARCHAR(50) NULL,
	last_chat_id NUMBER NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE participation_employee (
	chat_room_id NUMBER NOT NULL,
	employee_id NUMBER NOT NULL,
	is_favorited NUMBER(1) NULL,
	chat_room_profile_url VARCHAR(200) NULL,
	is_entered NUMBER(1) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE chat (
	chat_id NUMBER NOT NULL,
	chatroom_id NUMBER NOT NULL,
	contents VARCHAR2(500) NULL,
	chat_type NUMBER NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE chat_status (
	chat_room_id NUMBER NOT NULL,
	employee_id NUMBER NOT NULL,
	chat_id NUMBER NOT NULL,
	is_read NUMBER(1) NULL,
	emoticon_type NUMBER NULL,
	is_emoticon NUMBER(1) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE attached_file (
	file_id NUMBER NOT NULL,
	chat_id NUMBER NOT NULL,
	file_url VARCHAR(200) NULL,
	file_type VARCHAR(20) NULL,
	file_name VARCHAR2(100) NULL,
	file_volume NUMBER NULL,
	filename_extension VARCHAR2(20) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER NULL
);

CREATE TABLE schedule (
	schedule_id NUMBER NOT NULL,
	name VARCHAR(100) NULL,
	started_dt TIMESTAMP NULL,
	ended_dt TIMESTAMP NULL,
	contents VARCHAR(500) NULL,
	writer NUMBER NULL,
	created_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modifed_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE schedule_invite (
	schedule_invite_id NUMBER NOT NULL,
	employee_id NUMBER NOT NULL,
	is_participated NUMBER NULL,
	writer NUMBER NULL,
	created_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE master_code (
	master_code_id NUMBER NOT NULL,
	master_code_name NUMBER NULL
);

CREATE TABLE detail_code (
	detail_code_id NUMBER NOT NULL,
	detail_code_name VARCHAR2(50) NULL,
	master_code_id NUMBER NOT NULL
);

CREATE TABLE role (
	role_id NUMBER NOT NULL,
	employee_id NUMBER NOT NULL,
	name VARCHAR2(50) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modify_dt TIMESTAMP NULL,
	is_deleted NUMBER(1) NULL
);

CREATE TABLE tag (
	tag_id NUMBER NOT NULL,
	file_id NUMBER NOT NULL,
	name VARCHAR2(50) NULL,
	writer NUMBER NULL,
	write_dt TIMESTAMP NULL,
	modifier NUMBER NULL,
	modified_dt TIMESTAMP NULL,
	is_deleted VARCHAR2(30) NULL
);

ALTER TABLE company ADD CONSTRAINT PK_COMPANY PRIMARY KEY (
	company_id
);

ALTER TABLE employee ADD CONSTRAINT PK_EMPLOYEE PRIMARY KEY (
	employee_id
);

ALTER TABLE department ADD CONSTRAINT PK_DEPARTMENT PRIMARY KEY (
	dept_id
);

ALTER TABLE notification ADD CONSTRAINT PK_NOTIFICATION PRIMARY KEY (
	notification_id
);

ALTER TABLE chat_room ADD CONSTRAINT PK_CHAT_ROOM PRIMARY KEY (
	chat_room_id
);

ALTER TABLE participation_employee ADD CONSTRAINT PK_PARTICIPATION_EMPLOYEE PRIMARY KEY (
	chat_room_id,
	employee_id
);

ALTER TABLE chat ADD CONSTRAINT PK_CHAT PRIMARY KEY (
	chat_id
);

ALTER TABLE chat_status ADD CONSTRAINT PK_CHAT_STATUS PRIMARY KEY (
	chat_room_id,
	employee_id,
	chat_id
);

ALTER TABLE attached_file ADD CONSTRAINT PK_ATTACHED_FILE PRIMARY KEY (
	file_id
);

ALTER TABLE schedule ADD CONSTRAINT PK_SCHEDULE PRIMARY KEY (
	schedule_id
);

ALTER TABLE schedule_invite ADD CONSTRAINT PK_SCHEDULE_INVITE PRIMARY KEY (
	schedule_invite_id,
	employee_id
);

ALTER TABLE master_code ADD CONSTRAINT PK_MASTER PRIMARY KEY (
	master_code_id
);

ALTER TABLE detail_code ADD CONSTRAINT PK_DETAIL PRIMARY KEY (
	detail_code_id
);

ALTER TABLE role ADD CONSTRAINT PK_ROLE PRIMARY KEY (
	role_id
);

ALTER TABLE tag ADD CONSTRAINT PK_TAG PRIMARY KEY (
	tag_id
);

ALTER TABLE employee ADD CONSTRAINT FK_department_TO_employee_1 FOREIGN KEY (
	dept_id
) REFERENCES department (
	dept_id
);

ALTER TABLE employee ADD CONSTRAINT FK_company_TO_employee_1 FOREIGN KEY (
	company_id
) REFERENCES company (
	company_id
);

ALTER TABLE department ADD CONSTRAINT FK_department_TO_department_1 FOREIGN KEY (
	upper_dept_id
) REFERENCES department (
	dept_id
);

ALTER TABLE department ADD CONSTRAINT FK_company_TO_department_1 FOREIGN KEY (
	company_id
) REFERENCES company (
	company_id
);

ALTER TABLE notification ADD CONSTRAINT FK_employee_TO_notification_1 FOREIGN KEY (
	employee_id
) REFERENCES employee (
	employee_id
);

ALTER TABLE participation_employee ADD CONSTRAINT FK_chat_room_parti_emp FOREIGN KEY (
	chat_room_id
) REFERENCES chat_room (
	chat_room_id
);

ALTER TABLE participation_employee ADD CONSTRAINT FK_employee_parti_emp_1 FOREIGN KEY (
	employee_id
) REFERENCES employee (
	employee_id
);

ALTER TABLE chat ADD CONSTRAINT FK_chat_room_TO_chat_1 FOREIGN KEY (
	chatroom_id
) REFERENCES chat_room (
	chat_room_id
);

ALTER TABLE chat_status ADD CONSTRAINT FK_parti_emp_chat_status FOREIGN KEY (
	chat_room_id,
    employee_id
) REFERENCES participation_employee (
	chat_room_id,
    employee_id
);

ALTER TABLE chat_status ADD CONSTRAINT FK_chat_TO_chat_status_1 FOREIGN KEY (
	chat_id
) REFERENCES chat (
	chat_id
);

ALTER TABLE attached_file ADD CONSTRAINT FK_chat_TO_attached_file_1 FOREIGN KEY (
	chat_id
) REFERENCES chat (
	chat_id
);

ALTER TABLE schedule_invite ADD CONSTRAINT FK_sche_sche_invite FOREIGN KEY (
	schedule_invite_id
) REFERENCES schedule (
	schedule_id
);

ALTER TABLE schedule_invite ADD CONSTRAINT FK_em_sche_invite FOREIGN KEY (
	employee_id
) REFERENCES employee (
	employee_id
);

ALTER TABLE detail_code ADD CONSTRAINT FK_master_TO_detail_1 FOREIGN KEY (
	master_code_id
) REFERENCES master_code (
	master_code_id
);

ALTER TABLE role ADD CONSTRAINT FK_employee_TO_role_1 FOREIGN KEY (
	employee_id
) REFERENCES employee (
	employee_id
);

ALTER TABLE tag ADD CONSTRAINT FK_attached_file_TO_tag_1 FOREIGN KEY (
	file_id
) REFERENCES attached_file (
	file_id
);


----



-- Company 테이블 시퀀스
CREATE SEQUENCE SEQ_COMPANY
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Employee 테이블 시퀀스
CREATE SEQUENCE SEQ_EMPLOYEE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Department 테이블 시퀀스
CREATE SEQUENCE SEQ_DEPARTMENT
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Notification 테이블 시퀀스
CREATE SEQUENCE SEQ_NOTIFICATION
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Chat Room 테이블 시퀀스
CREATE SEQUENCE SEQ_CHAT_ROOM
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Chat 테이블 시퀀스
CREATE SEQUENCE SEQ_CHAT
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Attached File 테이블 시퀀스
CREATE SEQUENCE SEQ_ATTACHED_FILE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Schedule 테이블 시퀀스
CREATE SEQUENCE SEQ_SCHEDULE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Schedule Invite 테이블 시퀀스
CREATE SEQUENCE SEQ_SCHEDULE_INVITE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Master Code 테이블 시퀀스
CREATE SEQUENCE SEQ_MASTER_CODE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Detail Code 테이블 시퀀스
CREATE SEQUENCE SEQ_DETAIL_CODE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Role 테이블 시퀀스
CREATE SEQUENCE SEQ_ROLE
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Tag 테이블 시퀀스
CREATE SEQUENCE SEQ_TAG
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;