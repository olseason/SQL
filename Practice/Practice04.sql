--1. 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요. 
select  first_name 이름,
        salary 월급
from employees
where salary < (select avg(salary)
                from employees)
order by salary asc;



--2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호(employee_id), 
--이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        avgsal 평균급여,
        maxsal 최대급여
from employees, (select round(avg(salary), 2) avgsal,
                        max(salary) maxsal
                 from employees)
where salary >= (select avg(salary)
                from employees)
and salary <= (select max(salary)
              from employees)
order by salary asc;



--3 .직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다. 
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 
--나라아이디(country_id) 를 출력
select  sk.location_id 도시아이디,
        street_address 거리명,
        postal_code 우편번호,
        city 도시명,
        state_province 주,
        country_id 나라아이디
from locations lo, (select  em.first_name,
                            em.last_name,
                            de.department_id,
                            de.location_id
                    from employees em, departments de
                    where em.department_id = de.department_id
                    and first_name = 'Steven'
                    and last_name = 'King')  sk
where sk.location_id = lo.location_id;



--4. job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력  -ANY연산자 사용
select  employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary <ANY  (select salary
                    from employees
                    where job_id = 'ST_MAN')
order by salary desc;



--5. 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 조건절비교, 테이블조인 2가지 방법으로 작성하세요
--조건절비교
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
                                 from employees
                                 group by department_id)
order by salary desc;


--테이블조인
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        em.department_id 부서번호
from employees em, (select department_id, max(salary) maxsal
                    from employees
                    group by department_id) ma
where em.salary = ma.maxsal
and em.department_id = ma.department_id
order by salary desc;



--6. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회 
select  job_title 업무명,
        sal.sumsal 총합
from jobs jo,  (select job_id, sum(salary) sumsal
                from employees
                group by job_id) sal
where sal.job_id = jo.job_id
order by sal.sumsal desc;



--7. 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회 
select employee_id 직원번호,
        first_name 이름,
        salary 급여
from employees em, (select department_id, avg(salary) avgsal
                    from employees
                    group by department_id) de
where em.department_id = de.department_id
and em.salary > de.avgsal;



--8. 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
select  orn.rn,
        orn.employee_id 사번,
        orn.first_name 이름,
        orn.salary 월급,
        orn.hire_date 입사일 
from (select rownum rn,
             ot.employee_id,
             ot.first_name,
             ot.salary,
             ot.hire_date 
     from (select employee_id,
                  first_name,
                  salary,
                  hire_date
           from employees
           order by hire_date asc) ot
           )orn
where rn >= 11
and rn <= 15;