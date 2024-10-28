--job_id가 IT_FROG라면 employee_id, first_name, last_name, salary를 출력하되 salary가 9000이상이라면 '상위급여',
--6000과 8999사이이면 '중위급여' 그외에는 '하위급여'라고 출력
select employee_id as 직원번호, first_name as 성, last_name as 이름, salary as 월급,
case 
when salary >= 9000 then '상위급여'
when salary BETWEEN 6000 AND 8999 then '중위급여'
else '하위급여'
end as 급여등급
from employees
where job_id = 'IT_PROG';

--순위매기기, -RANK, DENSE_RANK, ROW_NUMBER 함수를 각각 아용해 employees 테이블의 salary값이 높은 순서대로 출력 (3가지 종류 구분)
select employee_id, salary,
    rank() over(order by salary desc) rank_급여,
    dense_rank() over(order by salary desc) dense_rank_급여, 
    row_number() over(order by salary desc) row_number_급여 
from employees;

--salary의 합계와 평균을 구하고, avg를 사용하지 않고 평균 출력
select sum(salary), avg(salary) as 평균, (SUM(salary)/count(employee_id)) as avg안쓰고평균
from employees;

-- 소수점 없애기
SELECT 
    SUM(salary) AS 총급여,
    ROUND(AVG(salary), 1) AS 평균, -- 소수점 없애기
    ROUND(SUM(salary) / COUNT(employee_id), 1) AS avg안쓰고평균 -- 소수점 없는 평균
FROM employees;

--salary의 최댓값과 최솟값 그리고 first_name의 최댓값, 최솟값 출력
select max(salary) 최대월급,min(salary)최소월급, max(first_name)최대문자, min(first_name)최소문자
from employees;

--employee_id가 10 이상인 직원에 대해 job_id별로 그룹화 하여 job_id별 총 급여와 job_id별로 평균 급여를 구함.
--job_id별 총급을 기준으로 내림차순 정렬
select job_id 직무, sum(salary) 총합, AVG(salary) 평균
from employees
where employee_id >= 10
group by job_id
order by sum(salary) desc;

--employee_id가 10 이상인 직원에 대해 job_id별로 그룹화 하여 job_id별 총 급여와 job_id별로 평균 급여를 구함.
--총급여가 30,000보다 큰 값만 출력 + 출력 결과는 job_id별 총 급여를 기준으로 내림차
select job_id 직무, sum(salary) 총합, AVG(salary) 평균
from employees
where employee_id >= 10
group by job_id
having sum(salary) > 30000
order by sum(salary) desc;

--동등 조인
select A.employee_id, a.department_id, b.department_name, c.location_id, c.city
from employees A, departments B, locations C
where a.department_id = b.department_id and b.location_id = c.location_id;

--외부조인/ employees 테이블과 departments테이블을 deparment_id로 외부 조인하여 department_id가 null 값인 Kimberley grant도 함께 출력
select a.employee_id, a.first_name, a.last_name, b.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id(+)--외부조인 +
order by a.employee_id;

--자체조인/ employees 테이블을 자체 조인하여 직원별 담당 매니저가 누구인지 조회
select a.employee_id, a.first_name, a.last_name, a.manager_id, (b.first_name||' ' ||b.last_name) manager_name
from employees a, employees b
where a.manager_id = b.employee_id
order by a.employee_id;

--집합연산자 합칩합(UNION, UNIONALL),차집합(INTERSET), 교집합(MINUS)
--department_id 집합과 departments테이블의 department_id 집합을 UNION연산자를 사용하여 합침.
select department_id
from employees
union 
select department_id
from departments;
--union all 중복 허용
select department_id
from employees
union all
select department_id
from departments;

--교집합을 이용하여 출력
select department_id
from employees
INTERSECT
select department_id
from departments
order by department_id;
--차집합을 이용하여 뺴기
select department_id
from departments
minus
select department_id
from employees;





