SELECT * FROM naver_db.member;

insert into naver_db.member values ( 'TWC', '트와이스', '9', '서울', '02', '11111111', '167', '2015.10.19');
insert into naver_db.member values ( 'BLK', '블랙핑크', '4', '경남', '055', '22222222', '163', '2016.08.08');
insert into naver_db.member values ( 'WMN', '여자친구', '6', '경기', '031', '33333333', '166', '2015.01.15');

select * from naver_db.buy;

insert into naver_db.buy values ( 'BLK', '지갑', '30', '2');
insert into naver_db.buy values ( 'BLK', '맥북프로','디지털', '1000', '1');
insert into naver_db.buy values ( 'APN', '아이폰','디지털', '200', '1');

drop table if exists buy, member;
create table member
(mem_id char(8) not null primary key,
 mem_name varchar(10) not null,
 height tinyint unsigned
 );
 
 describe member;
 
 drop table if exists member;
 create table member
 (mem_id   char(8) not null,
  mem_name varchar(10) not null,
  height  tinyint unsigned null
  );
  
  alter table member
	add constraint
    primary key (mem_id);
    
    create table member
    (mem_id    char(8) not null primary key,
     mem_name  varchar(10) not null,
     height tinyint unsigned null
     );
     create table buy
     ( num  int auto_increment not null primary key,
       mem_id  char(8) not null,
       prod_name char(6) not null,
       foreign key(mem_id) references member(mem_id)
       );
       
       drop table if exists buy;
        create table buy
     ( num  int auto_increment not null primary key,
       mem_id  char(8) not null,
       prod_name char(6) not null
       );
       alter table buy
		add constraint
        foreign key(mem_id)
        references member(mem_id);
       
       insert into member values ('BLK', '블랙핑크', 163);
       insert into buy(mem_id, prod_name) values('BLK', '지갑');
       insert into buy(mem_id, prod_name) values('BLK', '맥북');
       
       select * from buy;
       
       select m.mem_id, m.mem_name, b.prod_name
			from buy b
				inner join member m
                on b.mem_id = m.mem_id;
                
		drop table if exists buy;
        create table buy
        ( num       int auto_increment not null primary key,
          mem_id    char(8) not null,
          prod_name char(6) not null
          );
          alter table buy
			add constraint
            foreign key(mem_id) references member(mem_id)
            on update cascade
            on delete cascade;
            
		   insert into buy(mem_id, prod_name) values ( 'BLK', '지갑');
           insert into buy(mem_id, prod_name) values ( 'BLK', '맥북');
           
           update member set mem_id = 'PINK' where mem_id = 'BLK';
       
       select m.mem_id, m.mem_name, b.prod_name
       from buy b
		inner join member m
        on b.mem_id = m.mem_id;
        
        delete from member where mem_id='PINK';
        
        select * from buy;
        
        drop table if exists buy, member;
        create table member
        ( mem_id     char(8) not null primary key,
          mem_name   varchar(10) not null,
          height     tinyint unsigned null,
          email      char(30) null unique
          );
          
          insert into member values('BLK', '블랙핑크', 163, 'pink@gamil.com');
          insert into member values('TWC', '트와이스', 167, NULL);
          insert into member values('APN', '에이핑크', 164, 'pink@gamil.com');
          
          drop table if exists member;
          create table member
          ( mem_id   char(8) not null primary key,
            mem_name varchar(10) not null,
            height   tinyint unsigned null check (height >= 100),
            phone1   char(3) null
            );
            
            insert into member values('BLK', '블랙핑크', 163, NULL);
            insert into member values('TWC', '트와이스',99, NULL);
            
            
            alter table member
				add constraint
                check (phone1 in ('02', '031', '032', '054', '055', '061'));
                
                drop table if exists member;
                create table member
                ( mem_id   char(8) not null primary key,
                  mem_name varchar(10) not null,
                  height   tinyint unsigned null default 160,
                  phone1   char(3)  null
                  );
                  
                  alter table member
							alter column phone1 set default '02';
                            
				insert into member values('RED', '레드벨벳', 161, '054');
                insert into member values('SPC', '우주소녀', default, default);
                select * from member;