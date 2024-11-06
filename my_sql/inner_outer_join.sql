-- 내부조인
select * from buy
inner join member
on buy.mem_id = member.mem_id
where buy.mem_id = 'GRL';

-- 내부조인 간결하게
select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처'
from buy
inner join member
on buy.mem_id = member.mem_id;

-- 테이블명을 약호로
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(m.phone1, m.phone2) '연락처'
from buy B
inner join member M
on B.mem_id = m.mem_id;

-- 중복된 결과 1개만 출력하기
select distinct m.mem_id, M.mem_name, M.addr
from buy b
inner join member m
on B.mem_id = m.mem_id
order by m.mem_id;

-- Left 외부조인
select m.mem_id, m.mem_name,b.prod_name, m. addr
from member m
left outer join buy b
on m.mem_id = b. mem_id
order by m.mem_id;

-- right 외부조인
select distinct m.mem_id, b.prod_name, m.mem_name, m.addr
from member m
left outer join buy b
on m.mem_id = b.mem_id
where b.prod_name is null
order by m.mem_id;

create table emp_table(
	emp char(4),
	manager char(4),
	phone varchar(8)
);

insert into emp_table values('대표',Null,'0000');
insert into emp_table values('영업이사', '대표','1111');
insert into emp_table values('관리이사', '대표','2222');
insert into emp_table values('정보이사', '대표','3333');
insert into emp_table values('영업과장', '영업이사','1111-1');
insert into emp_table values('경리부장', '관리이사','2222-1');
insert into emp_table values('인사부장', '관리이사','2222-2');
insert into emp_table values('개발팀장', '정보이사','3333-1');
insert into emp_table values('개발주임', '정보이사','3333-1-1');

select * from emp_table;

-- 자체 조인
select a.emp '직원', b.emp '직속상관', b.phone '직속상관연락처'
from emp_table a
inner join emp_table b
on a.manager =b.emp
where a.emp = '경리부장';