--내림차 순으로 출력
select employee_id, first_name, last_name
from employees
order by employee_id desc;

--Last name이 S로 시작하는 데이터를 오름차순으로 출력
select employee_id, first_name, last_name
from employees
where last_name LIKE 'S%'
order by employee_id asc;

--job_id 중복을 처리하여 출력
select DISTINCT job_id
from employees;

--필드명을 사용자 지정으로 출력
select employee_id as 사원번호, first_name as 이름, last_name as 성
from employees;

--first_name과 last_name을 붙여서 출력 (||)- 연결 연산자
select employee_id as 사원번호, first_name||' '||last_name as 이름
from employees;

--직원 테이블에서 firstname과 lastname을 붙이고 email을 출력하되 @company.com문구를 붙여서 출력
select employee_id as 회원번호, first_name||' '||last_name as 이름, email || '@company.com'as 이메일
from employees

