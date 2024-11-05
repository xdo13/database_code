create table users(
id INTEGER primary key,
myid integer unique,
username VARCHAR2(25) not null,
enabled char(1) default '1',
last_login date DEFAULT sysdate
);

create table addresses(
user_id integer primary KEY,
street varchar2(30) not null,
city VARCHAR2(30) not null,
state VARCHAR2(30) not null
);

--나중에 추가하는 방법
alter table addresses add CONSTRAINT fk_user_id foreign key (user_id) references users(myid); -- 관계설정
alter table users add CONSTRAINT fk_addresses_id foreign key (user_id) references users(id);
--constraint fk_user_id foreigh key (user_id) references users (myid) <- 처음에 연결하는 코드