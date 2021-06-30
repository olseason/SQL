--문제1) 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 

--직원의 이름, 매니저아이디, 커미션 비율, 월급을 출력

select first_name, commission_pct, manager_id, salary

from employees

where manager_id is not null

and commission_pct is null

and salary >3000;

 

 

--문제2) 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름, 급여, 입사일, 전화번호,

--부서번호를 조회 

--조건절비교 방법으로 작성/ 급여의 내림차순 정렬/ 입사일은 2001-01-13 토요일 형식으로 출력

--전화번호는 515-123-4567형식으로 출력 

select  employee_id, 

        first_name, 

        salary,

        to_char(hire_date, 'yyyy-mm-dd day'),

        replace(phone_number, '.', '-'),

        department_id

from employees

where (department_id, salary) in (select department_id, max(salary)ms

                                  from employees

                                  group by department_id)

order by salary desc;








