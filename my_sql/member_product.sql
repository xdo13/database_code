use webdb;

create table member(
	member_id char(8) not null,
    member_name char(5) not null,
    member_addr char(20) not null,
    PRIMARY KEY (member_id)
);

create table product(
	product_name char(4) not null,
    cost int not null,
    make_date date,
    company char(5),
    amount int not null,
    primary key (product_name)
);

select * from member;

insert into member(member_id, member_name, member_addr)
values('tess', '나훈아', '경기도 부천시 중동');

insert into member(member_id, member_name, member_addr)
values('hero', '임영웅', '서울 은평구 증산동');

insert into member(member_id, member_name, member_addr)
values('iyou', '아이유', '인천 남구 주안동');

insert into member(member_id, member_name, member_addr)
values('jyp', '박진영', '경기도 고양시 장항동');

---------------------------------------------------------------

insert into product(product_name, cost, make_date, company, amount)
values('바나나', 1500, '2021-07-01', '델몬트', 17);

insert into product(product_name, cost, make_date, company, amount)
values('카스', 2500, '2022-03-01', 'OB', 3);

insert into product(product_name, cost, make_date, company, amount)
values('삼각김밥', 800, '2023-09-01', 'CJ', 22);

select * from product;


insert into member(member_id, member_name, member_addr)
		values ('carry', '머라이어', '미국 텍사스주 사막');
        
        -- 주소 변경
update member
set member_addr = '영국 런던 먹자골목'
where member_id ='carry';

-- 캐리 삭제
delete from member
where member_id = 'carry';

-----------------------------------------------------

CREATE TABLE product2 (
    product_name CHAR(4) NOT NULL,
    cost INT NOT NULL,
    make_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    company CHAR(5),
    amount INT NOT NULL,
    PRIMARY KEY (product_name)
);

select * from product2;


insert into product2(product_name, cost, company, amount)
values('삼각김밥', 800, 'CJ', 22);


use webdb;

select * from member;