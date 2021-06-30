create table book(

    book_id number(5),

    title varchar2(50),

    author varchar2(10),

    pub_date date

);

 

alter table book add(pubs varchar2(50));

 

alter table book modify(title varchar2(100));

 

alter table book rename column title to subject;

 

alter table book drop (author);

 

 

create table author (

    author_id   number(10),

    author_name varchar2(100) not null,

    author_desc varchar2(500),

    PRIMARY KEY (author_id)

);

 

 

 

CREATE TABLE book (

  book_id	 NUMBER(10),

  title	 VARCHAR2(100) 	NOT NULL,

  pubs	 VARCHAR2(100),

  pub_date	 DATE,

  author_id NUMBER(10),

  PRIMARY 	KEY(book_id),

  CONSTRAINT book_fk FOREIGN KEY (author_id)

  REFERENCES author(author_id)

);

 

 

insert into author values(1, '박경리', '토지작가');

insert into author values(2, '기안84', '웹툰작가');

 

SELECT *

FROM AUTHOR;

 

insert into author (author_id, author_name) 

values('2', '이문열');

 

update author

set author_name = '기안84',

    author_desc = '웹툰작가'

where author_id = 2;  

 

 

update author

set author_name = '이소정',

    author_desc = '사람'

where author_id = 2;    

 

update author

set author_name = '강풀',

    author_desc = '인기작가';

 

 

create sequence seq_author_id

increment by 1

start with 1

nocache;

    

    

 

select seq_author_id.currval from dual;