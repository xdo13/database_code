create table table1 (
col1 int primary key,
col2 int,
col3 int
);
 -- 클러스터형 인덱스
show index from table1;

create table table2 (
	col1 int primary key,
    col2 int unique,
    col3 int unique
    );
    
    show index from table2;
    
    drop table if exists buy, member;
    
    create table member
    ( mem_id     char(8),
      mem_name   varchar(10),
      mem_number int,
      addr       char(2)
      );
      
      insert into member values('TWC', '트와이스', 9, '서울');
      insert into member values('BLK', '블랙핑크', 4, '경남');
      insert into member values('WMN', '여자친구', 6, '경기');
      insert into member values('OMY', '오마이걸', 7, '서울');
      select * from member;
      
      alter table member
			add constraint
            primary key (mem_id);
            
	select * from member;
    
alter table member drop primary key;
alter table member
		add constraint
        primary key(mem_name);
	select * from member;
    
insert into member values('GRL', '소녀시대', 8, '서울');

select * from member;

drop table if exists member;
create table member
( mem_id     char(8),
  mem_name   varchar(10),
  mem_number int ,
  addr       char(2)
  );
  
  insert into member values('TWC', '트와이스', 9, '서울');
  insert into member values('BLK', '블랙핑크', 4, '경남');
  insert into member values('WMN', '여자친구', 6, '경기');
  insert into member values('OMY', '오마이걸', 7, '서울');
  select * from member;
  
  alter table member add constraint
                     unique (mem_id);
select * from member;

alter table member add constraint
                   unique (mem_name);
                   
select * from member;

insert into member values('GRL', '소녀시대', 8, '서울');

 -- 인덱스의 내부구조
 drop table if exists cluster;
 create table cluster -- 클러스터형 인덱스를 테스트하기 위한 테이블
 ( mem_id   char(8),
   mem_name varchar(10)
   );
   
   insert into cluster values('TWC','트와이스');
   insert into cluster values('BLK','블랙핑크');
   insert into cluster values('WMN','여자친구');
   insert into cluster values('OMY','오마이걸');
   insert into cluster values('GRL','소녀시대');
   insert into cluster values('iTZ','잇지');
   insert into cluster values('RED','레드벨벳');
   insert into cluster values('APN','에이핑크');
   insert into cluster values('SPC','우주소녀');
   insert into cluster values('MMU','마마무');
   
   select * from cluster;
   
   alter table cluster
						add constraint
					    primary key (mem_id);
                        
create table second
( mem_id    char(8) ,
  mem_name  varchar(10)
  );
 insert into second values('TWC','트와이스');
   insert into second values('BLK','블랙핑크');
   insert into second values('WMN','여자친구');
   insert into second values('OMY','오마이걸');
   insert into second values('GRL','소녀시대');
   insert into second values('iTZ','잇지');
   insert into second values('RED','레드벨벳');
   insert into second values('APN','에이핑크');
   insert into second values('SPC','우주소녀');
   insert into second values('MMU','마마무');
   
  alter table second add constraint
					 unique (mem_id);
                     
select * from second;

select * from member;

show index from member;
			
show table status like 'member';

create index idx_member_addr on member (addr);

show index from member;

show table status like 'member';

analyze table member;

show table status like 'member';

create unique index idx_member_mem_number on member (mem_number);

show index from member;

