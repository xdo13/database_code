use market_db;

create table hongong1 (
	toy_id INT,
	toy_name CHAR(4),
	age INT
);

INSERT INTO hongong1
VALUES (1, '우디', 25);

INSERT INTO hongong1(toy_id, toy_name)
VALUES (2, '버즈');

INSERT INTO hongong1(toy_name, age, toy_id)
VALUES ('제시', 20, 3);

select * from hongong2;

-- autoincrement 자동으로 증가
create table hongong2(
toy_id INT auto_increment primary key,
toy_name char(4),
age int);

insert into hongong2 values (null, '보핍', 25);
insert into hongong2(toy_name, age)
values ('슬링키', 22);
insert into hongong2(toy_name, age)
values ('렉스', 21);

alter table hongong2 auto_increment = 100;
insert into hongong2(toy_name, age) values('재남', 35);

create table hongong3(
toy_id INT auto_increment primary key,
toy_name char(4),
age int);

alter table hongong3 auto_increment=1000;
set @@auto_increment_increment=3;

INSERT INTO hongong3(toy_name, age)
VALUES ('토마스', 20);

INSERT INTO hongong3(toy_name, age)
VALUES ('제임스', 23);

INSERT INTO hongong3(toy_name, age)
VALUES ('고든', 25);

select * from hongong3;

select * from city_popul where city_name='Seoul';

update city_popul
	set city_name = '서울'
    where city_name = 'Seoul';
    
select *from city_popul where city_name = '서울';

update city_popul
set city_name = '뉴욕', population = 0
where city_name = 'New York';

select *from city_popul where city_name = '뉴욕';

delete from city_popul
where city_name like 'New%';

