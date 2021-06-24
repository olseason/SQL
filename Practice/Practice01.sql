--문제1.
select  first_name||' '||last_name as 이름,
        salary as 월급,
        phone_number as 전화번호,
        hire_date as 입사일
from employees
order by hire_date asc;


--문제2.
select job_title, max_salary
from jobs
order by max_salary desc;
         
         
         
--문제3.
select first_name, manager_id, commission_pct, salary
from employees
where salary >3000
and commission_pct is null;


--문제4.
select job_title, max_salary
from jobs
where max_salary >=10000
order by max_salary desc;
         
         
--문제5.
select first_name, salary, nvl(commission_pct, 0)
from employees
where salary >=10000
and salary <14000
order by salary desc;


--문제6.
select  first_name, 
        salary,
        to_char(sysdate, 'yyyy-mm-dd'),
        department_id
from employees
where department_id in (10, 90, 100);


--문제7.
select first_name, salary
from employees
where first_name like '%s%';


--문제8.
select *
from departments
order by length(department_name) desc;


--문제9.
select upper(country_name)
from countries;



--문제10.
select  first_name,
        salary,
        replace(phone_number, '.', '-'),
        hire_date
from employees
where hire_date <= '03/12/31';