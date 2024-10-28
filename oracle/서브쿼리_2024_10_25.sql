--서브쿼리 last_name이 'De Haan'인 직원과 Salary가 동일한 직원에는 누가 있는지 단 행 서브쿼리를 이용해서 출력  =
SELECT *
FROM employees
WHERE Salary = (
    SELECT Salary
    FROM employees
    WHERE last_name = 'De Haan'
);


--다중행 서브쿼리 in
select *
from employees A
where a.salary in (
            select salary
            from employees
            where last_name = 'Taylor');
            
-- department_id별로 가장 낮은 salary가 얼마인지 찾고 찾아낸 salary에 해당하는 직원은 누구인지 출력
select first_name||' '||last_name "이름" , salary, department_id
from employees a
where a.salary in (select min(salary) 최저급여
                    from employees
                    group by department_id)
order by salary desc;

--다중 열 /job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 찾아낸 job_id별 salary에 해당하는 직원이 누구인지 출력(다중 열 사용)
select job_id, min(salary) as 그룹별_급여
from employees
group by job_id;

select *
from employees a
where(a.job_id, a.salary) in (
            select job_id, min(salary) as 그룹별_급여
            from employees
            group by job_id)
order by a.salary desc;

-- 인라인 뷰( 가상 뷰) 직원중에서 department_name이 IT인 직원의 정보를 인라인 뷰를 사용해 출력(FROM절 서브쿼리 -> 인라인 뷰)
select *
from employees A,(
        select department_id
        from departments
        where department_name = 'IT') b
where A.department_id = B.department_id;

------------------------------------------- select
-- insert into / 커밋안하면 저장 안됨

--departments 테이블에 department_id가 271, department_name이 'sample_Dept', manager_id가 200, location_id가 1700인 행을 삽입
insert into departments(department_id, department_name, manager_id, location_id)
values(271,'Sample_Dept', 200, 1700);

insert into departments(department_id, department_name)
values(275, 'Sample_Dept');

select * from departments;

--update set

update departments
set manager_id = 201, location_id =1800
where department_name = 'Sample_Dept';

select * from departments;
-- department테이블에 department_id가 40인 manager_id와 location_id의 값을 찾아내고, department_name이 'Sample_Dept'인 행의
--manager_id와 location_id를 찾아낸 데이터 값과 동일하게 변경
update departments
set (manager_id, location_id) = (
            select manager_id, location_id
            from departments
            where department_id = 40
)
where department_name = 'Sample_Dept';

select manager_id, location_id
from departments
where department_id = 40;

--delete from
delete from departments
where department_name = 'Sample_Dept';

select * from departments;
--DDL
create table sample_product(
    product_id number primary key,
    product_name varchar2(30) not null,
    manu_date date not null
);

insert into sample_product 
values(1, 'television',to_date('241010', 'YYMMDD'));

select *
from sample_product;

insert into sample_product 
values(2, 'washer',to_date('241015', 'YYMMDD'));
insert into sample_product 
values(3, 'cleaner',to_date('241024', 'YYMMDD'));

update sample_product
set manu_date = '241015'
where product_id = 2;

alter table sample_product add(factory varchar(10));

alter table sample_product
drop column factory;

alter table sample_product
MODIFY factory not null;

delete from sample_product;

truncate table sample_product;

rollback;

select *
from sample_product;

drop table sample_product;

