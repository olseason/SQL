--문제1) 직원들의 사번, 이름, 성과 부서명을 조회하여 부서이름 오름차순, 사번 내림차순으로 정렬 

select em.employee_id, em.first_name, em.last_name, de.department_name

from employees em, departments de

where em.department_id = de.department_id

order by de.department_name asc, 

         em.employee_id desc;

 


--문제2) 테이블의 job_id는 현재의 업무아이디를 가지고 있다. 직원들의 사번, 이름, 급여, 부서명,

--현재업무를 사번 오름차순으로 정렬 (부서가 없는 사번은 표시하지 않음)

select  em.employee_id,

        em.first_name, 

        em.salary, 

        de.department_name,

        jo.job_title

from employees em, departments de, jobs jo

where em.department_id = de.department_id

and   em.job_id = jo.job_id

order by em.employee_id asc;

 


--문제2-1) 문제2번에서 부서가 없는 사번까지 표시 

select  e.employee_id,

        e.first_name,

        e.salary,

        d.department_name,

        j.job_title

from employees e, departments d, jobs j

where e.department_id = d.department_id(+)

and e.job_id = j.job_id

order by e.employee_id asc;

 

 

--문제3) 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력

select lo.location_id, lo.city, de.department_id, de.department_name

from locations lo, departments de

where lo.location_id = de.location_id

order by lo.location_id asc;

 

 

--문제3-1) 문제3에서 부서가 없는 도시도 표시 

select lo.location_id, lo.city, de.department_id, de.department_name

from locations lo, departments de

where lo.location_id = de.location_id(+)

order by lo.location_id asc;

 

 

 
--문제4) 지역에 속한 나라들을 지역이름, 나라이름으로 출력하되 지역이름(오름차순), 나라이름(내림차순)으로 정렬

select re.region_name, co.country_name

from regions re, countries co

where re.region_id = co.region_id

order by re.region_name asc,

         co.country_name desc;

         

 

--문제5) 자신의 매니저보다 채용일이 빠른 사원의 사번, 이름과 채용일, 매니저 이름, 매니저 입사일을 조회

select  em.first_name "이름",

        em.hire_date "입사일",

        em.employee_id "사원번호",

        emm.first_name "매니저 이름",

        emm.hire_date "매니저 입사일"

from employees em, employees emm

where em.manager_id = emm.employee_id

and em.hire_date < emm.hire_date; 

 

 

--문제6) 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력

select  co.country_name, 

        co.country_id, 

        lo.city, 

        lo.location_id, 

        de.department_name, 

        de.department_id

from departments de, locations lo, countries co

where de.location_id = lo.location_id

and lo.country_id = co.country_id

order by co.country_name asc;

 

 

--문제7) job_history 테이블은 과거의 담당엄무의 데이터를 가지고 있음

-- 과거의 업무아이디가 'AC_ACCOUNT'로 근무한 사원의 사번, 이름(풀네임), 업무아이디,

--시작일, 종료일을 출력

select em.first_name||' '||em.last_name,

       em.employee_id,

       jo.job_id,

       jo.start_date,

       jo.end_date

from employees em, job_history jo

where em.employee_id = jo.employee_id(+)

and jo.job_id = 'AC_ACCOUNT';

 

 


--문제8) 각 부서에 대해서 부서번호, 부서이름, 매니저의 이름, 위치한 도시, 나라의 이름, 지역구분의 이름까지 전부 출력    

select  e.department_id,

        d.department_name,

        e.first_name,

        l.city,

        c.country_name,

        r.region_name

from    employees em,

        departments de,

        locations lo,

        countries co,

        regions re

where   e.employee_id = d.manager_id 

and     e.department_id = d.department_id

and     d.location_id = l.location_id

and     l.country_id = c.country_id

and     c.region_id = r.region_id;

 

--문제9) 각 사원에 대해서 사번, 이름, 부서명, 매니저의 이름을 조회
--부서가 없는 직원도표시 

select  e.employee_id,

        e.first_name,

        d.department_name,

        m.first_name

from employees e, employees m, departments d

where e.department_id = d.department_id(+)

and e.manager_id = m.employee_id;