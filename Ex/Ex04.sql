/*EQUI join*/

select employee_id, first_name

from employees e, departments d

where e.department_id = d.department_id;

 

--예제) 모든 직원이름, 부서이름, 업무명을 출력하세요

--먼저, employees, departments, jobs테이블 쳐본 뒤에, 겹친 곳이 있는지 확인

select  em.first_name,

        em.department_id,

        jo.job_title

from employees em, departments de, jobs jo

where em.department_id = de.department_id

and em.job_id = jo.job_id;

 

/*outer join*/

--left outer join 

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from employees em left outer join departments de

on em.department_id = de.department_id;

 

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from employees em, departments de

where em.department_id = de.department_id(+);

 


--right outer join

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from employees em right outer join departments de

on em.department_id = de.department_id;

 

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from employees em, departments de

where em.department_id(+) = de.department_id;

 

--right join --> left join

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from departments de left outer join employees em

on de.department_id = em.department_id;

 

 

--full outer join

select  em.employee_id, 

        em.first_name, 

        em.department_id,

        de.department_name

from employees em full outer join departments de

on em.department_id = de.department_id;

 

 

/*self join*/

select  em.employee_id,

        em.first_name,

        em.manager_id,

        ma.employee_id,

        ma.first_name

from employees em, employees ma

where em.manager_id = ma.employee_id;





--서브쿼리문 

select first_name, salary

from employees

where salary >= (select employee_id

                from employees

                where first_name = 'Den');
               
 

--den의 급여 -> 11000

select first_name, salary

from employees

where first_name = 'Den';

 
--급여가 11000 이상인 직원들 

select first_name, salary

from employees

where salary >= 11000;