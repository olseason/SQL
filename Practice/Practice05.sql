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





--문제3) 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
---통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
---매니저별 평균급여가 5000이상만 출력합니다.
---매니저별 평균급여의 내림차순으로 출력합니다.
---매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
---출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
--(9건)

select  ma.manager_id 매니저아이디,
        em.first_name 매니저이름,
        avgsal 매니저별편균급여,
        minsal 매니저별최소급여,
        maxsal 매니저별최대급여
from (select  manager_id, 
        round(avg(salary), 1) avgsal, 
        min(salary) minsal, 
        max(salary) maxsal
      from employees
      where hire_date > '05/01/01'
      group by manager_id
      having round(avg(salary)) > 5000) ma, employees em
where ma.manager_id = em.employee_id;



---문제4) 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요. 부서가 없는 직원(Kimberely)도 표시합니다.
--(106명)

select  em.employee_id 사번,
        em.first_name 이름,
        de.department_name 부서명,
        ma.first_name 매니저이름
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);





--문제5) 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
select ort.rn,
       employee_id 사번,
       first_name 이름,
       department_name 부서명,
       salary 급여,
       hire_date 입사일
from (select rownum rn,
             ot.employee_id,
             ot.first_name,
             ot.department_name ,
             ot.salary,
             ot.hire_date
      from (select employee_id,
                   first_name,
                   department_name ,
                   salary,
                   hire_date
            from employees em, departments de
            where em.department_id = de.department_id
            order by hire_date asc) ot) ort
where rn >= 11
and rn <= 20;



