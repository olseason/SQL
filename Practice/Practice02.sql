-- 문제1
select count(*) "haveMngCnt"
from employees
where manager_id is not null;

-- 문제2
select  max(salary) 최고임금,
        min(salary) 최저임금,
        max(salary)-min(salary) "최고임금-최저임금"
from employees;

-- 문제3
select to_char(max(hire_date), ' yyyy"년"mm"월"dd"일" ')
from employees;

-- 문제4
select  department_id,
        avg(salary),
        max(salary),
        min(salary)
from employees
group by department_id
order by department_id desc;

-- 문제5
select  job_id,
        avg(nvl(salary, 0)),
        max(salary),
        min(salary)
from employees
group by job_id
order by min(salary) desc,
         avg(nvl(salary, 0)) asc;
         

-- 문제6
select to_char(min(hire_date), ' yyyy-mm-dd day ')
from employees;

-- 문제7
select  department_id,
        avg(salary),
        min(salary),
        avg(salary)-min(salary)
from employees
group by department_id
having avg(salary)-min(salary) < 2000
order by avg(salary)-min(salary) desc;

-- 문제8
select  job_id,
        max_salary-min_salary
from jobs
group by job_id, max_salary, min_salary
order by max_salary-min_salary desc;

-- 문제9
select  manager_id, round(avg(salary), 1), min(salary), max(salary)
from employees
where hire_date >= '05/01/01'
group by manager_id
having avg(nvl(salary, 0)) >= 5000 
order by avg(nvl(salary, 0)) desc;

-- 문제10
select  first_name,
case    when hire_date <= '02/12/31' then '창립멤버'
        when hire_date <= '03/12/31' then '03년입사'
        when hire_date <= '04/12/31' then '04년입사'
        else '상장이후입사'
end as optDate
from employees
order by hire_date asc;