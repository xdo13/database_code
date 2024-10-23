--직원테이블에서 id와 salary, salary에 500을 더한 값, 100을 뺀값, 10%를 추가해서 2로 나눈값
select employee_id as 직원번호,first_name||' '||last_name as 직원이름, salary as 월급, salary+500 as 추가, salary-100 as 감소, (salary*1.1)/2 as 나눈값
from employees;

-- 전부 다 출력 *
select * from
employees;

--직원 테이블에서 employee_id, salary, 
select salary as 월급
from employees
where salary between 10000 and 20000
order by salary desc;

--직원 테이블에서 직원 아이디가 100인 정보 출력
select *
from employees
where employee_id = 100;

--first_name이 David인 직원의 정보
select *
from employees
where first_name = 'David';

--employee_id가 105 이상인 직원의 정보
select *
from employees
where employee_id >= 105
order by employee_id desc;

--salary가 10,000 이상이고 20,000이하인 직원의 정보
select *
from employees
where salary between 10000 and 20000;

--salary가 10,000, 17,000, 24,000인 직원 정보
select *
from employees
where salary in(10000,17000,24000);

--job_id값이 AD로 시작하는 모든(%) 데이터를 출력
select *
from employees
where job_id LIKE 'AD%';

-- AD로 시작하면서 뒤에 따라오는 문자열이 3자리인 데이터 출력
select *
from employees
where job_id LIKE 'AD___';

-- manager_id가 null값인 직원 정보
select *
from employees
where manager_id is null;

--salary가 4000을 초과하면서 job_id가 IT_PROG인 값을 조회
select * 
from employees
where salary > 4000 and job_id = 'IT_PROG';

--salary가 4000을 초과하면서 job_id가 IT_PROG이거나 FI_ACCOUNT인 경우
select * 
from employees
where salary > 4000 and job_id = 'IT_PROG' or job_id = 'FI_ACCOUNT';

--employee_id가 105가 아닌 직원만 출력
select * 
from employees
where employee_id <> 105;

---------------------------------------sql함수---------------------------------------------------

--last_name을 소문자와 대문자로 각각 출력하고, email은 첫번째 문자는 대문자로 출력
select last_name,lower(last_name) as 소문자, upper(last_name) as 대문자, email, initcap(email) as 첫글자만대문자
from employees;

--job_id의 데이터 값의 첫째 자리부터 시작해서 두 개의 문자를 출력
select job_id, substr(job_id,1,2)
from employees;

--job_id 문자열 값이 ACCOUNT이면 ACCNT로 출력
select job_id, replace(job_id,'ACCOUNT', 'ACCNT') as 적용결과
from employees;

--특정 문자로 채우기 ex)주민등록번호
--first_name에 대해 12자리의 문자열 자리를 만들되 first_name의 데이터 값이 12보다 작으면 왼쪽보다 *을 채워 출력
select first_name, LPAD(first_name, 12, '*') LPAD적용결과
from employees;

--자르기(LTRIM, RTRIM, TRIM), 중간에 공백을 제외한 나머지 공백 제거
select 'start'||'    - space -    '||'end'
from dual;

select 'start'||trim('    - space -    ')||'end'
from dual;

--salary를 30일로 나눈 후 나눈값의 소수점 첫쨰자리, 소수점 둘째 자리, 정수 첫째 자리에서 반올림 한 값을 출력
select salary,
       salary/30 일급,
       round(salary/30, 0) 적용결과_0,
       round(salary/30, 1) 적용결과_1,
       round(salary/30, -1) 적용결과_마이너스1
from employees;

--salary를 30일로 나눈 후 나눈값의 소수점 첫쨰자리, 소수점 둘째 자리, 정수 첫째 자리에서 절삭하여 출력
select salary,
       salary/30 일급,
       trunc(salary/30, 0) 적용결과_0,
       trunc(salary/30, 1) 적용결과_1,
       trunc(salary/30, -1) 적용결과_마이너스1
from employees;

--날짜계산 -오늘 날짜, +1, -1, 특정날짜 빼기, 시간더하기
select to_char(sysdate, 'YY/MM/DD/HH24:MI')오늘날짜,
       sysdate + 1 더하기_1,
       sysdate - 1 빼기_1,
       to_date('20241205') - to_date('20021201')날짜빼기,
       sysdate + 13/24 시간더하기
from dual;

--두 날짜 사이에 개월 수 계산
select sysdate, hire_date, months_between(sysdate, hire_date) 적용결과
from employees
where department_id = 100;

--월에 날짜 더하기(ADD_MONTHS, id가 100과 106사이인 직원의 hire_date에 3개월을 더한 값, hire_date에 3개월을 뺀 값
select hire_date as 고용날짜, add_months(hire_date, 3) 더하기_적용결과, add_months(hire_date, -3) 빼기_적용결과
from employees;


select salary * commission_pct
from employees
order by commission_pct;

--salary에 commission_pct를 곱하되 commission_pct가 null일 때는 1로 치환하여 commission_pct를 곱한 결과를 출력
--NULL 값 처리
select salary * NVL(commission_pct, 1) as 수수료를뗀값
from employees
order by commission_pct;

--first_name, last_name, department_id, salary를 출력하되 department_id가 60인 경우에는 급여를 10% 인상한 값을 계산하여 출력하고
--나머지 경우에는 원래의 값을 출력, 그리고 department_id가 60인 경우에는 '10% 인상'을 출력하고 나머지 경우에는 '미인상'을 출력

select first_name, last_name, department_id, salary 원래_급여,
       decode(department_id, 60, salary*1.1, salary) 조정된_급여,
       decode(department_id, 60, '10%인상', '미인상') 인상여부      
from employees;

--case문
select first_name, last_name, department_id, salary 원래_급여,
       case department_id  when 60 then  salary*1.1  else salary end 조정된_급여,
       case department_id  when 60 then  '10%인상'  else '미인상' end 인상여부      
from employees;