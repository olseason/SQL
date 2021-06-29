/*
-EQUI Join  --> null 포함되지 않는다
-OUTER Join(left right full) --> null 포함시켜야 할때
 (+)<--오라클 
-Self Join 
*/

/*********************
*subQuery
**********************/
--SubQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태

/*다일행 SubQuery*/
--예제)‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
--1. Den의 급여를 구한다. --> 11000
select first_name, salary 
from employees
where first_name = 'Den';

--2. 11000(Den) 보다 많은 사람을 구한다?
select first_name, salary
from employees
where salary > (11000);

--3. 두식을 조합한다.
select first_name, salary
from employees
where salary > (select salary 
                from employees
                where first_name = 'Den');

--예제)급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1.급여를 가장 적게 받는 사람의 급여 --> 2100
select  min(salary)
from employees;

--2. 2100을 받는 사람의 이름 급여 사원번호
select  first_name,
        salary,
        employee_id
from employees
where salary = 2100;

--3.식을 조합
select  first_name,
        salary,
        employee_id
from employees
where salary = (select  min(salary)
                from employees);

--예제)평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1.평균급여를 구한다.  6461.83
select avg(salary)
from employees;


--2. 6461.83보다 적게 받는 사람의 이름, 급여를 구한다.
select  first_name,
        salary
from employees
where salary < 6461.83;


--3.식을 조합한다.
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);
                
                
/*다중행 SubQuery*/                
-- 부서번호 110인 직원의 급여 리스트를 구한다.  Shelley 12008, William 8300
select salary
from employees
where department_id = 110;

-- 급여가 12008, 8300 인 직원리스트를 구한다
select  first_name,
        salary
from employees
where salary = 12008
or salary = 8300;

select  first_name,
        salary
from employees
where salary in(12008, 8300);

-- 두식을 조합한다
select  first_name,
        salary
from employees
where salary in(select salary
                from employees
                where department_id = 110);



--예제)각 부서별로 최고급여를 받는 사원을 출력하세요 
--마케팅 유재석 10000, 배송 정우성 20000, 관리 이효리 30000 (X)
--1. 그룹별 최고급여 를 구한다
select department_id, max(salary)
from employees
group by department_id;

--2. 사원테이블에서 그룹번호 와 급여가 같은 직원의 정보를 구한다.
select first_name, salary, department_id
from employees
where (nvl(department_id,0), salary) in (select nvl(department_id,0), max(salary)
                                  from employees
                                  group by department_id);


--예제)부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
--    사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)

--1. 부서번호가 110인 직원 리스트  12008, 8300
select salary
from employees
where department_id = 110;

--2. 부서번호가 110인 직원급여(12008, 8300) 보다 급여가 큰 직원리스트(사번, 이름, 급여)를 구하시오
select  employee_id,
        first_name,
        salary
from employees emp
where salary > 12008
or salary > 8300;

select  employee_id,
        first_name,
        salary
from employees emp
where salary >any (select salary
                   from employees
                   where department_id = 110);



--all    <--> any 와 비교
select  employee_id,
        first_name,
        salary
from employees emp
where salary >all (select salary
                   from employees
                   where department_id = 110);


--예제(where)
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각부서별 최고 급여 리스트 구하기
select department_id, max(salary)
from employees
group by department_id;

--2. 직원테이블 부서코드, 급여가 동시에 같은 직원 리스트 출력하기
select  first_name,
        department_id,
        salary
from employees
where (department_id, salary) in   (select department_id, max(salary)
                                           from employees
                                           group by department_id);
                                           
         
         
         
--예제(join)
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각부서별 최고 급여 테이블 s         
     select department_id, max(salary)
     from employees
     group by department_id;
         
--2. 직원 테이블과 조인한다 e
     --e.부서번호 = s.부서번호    e.급여 = s.급여(최고급여)
     select e.employee_id,
            e.first_name,
            e.department_id,
            e.salary,
            s.department_id, --추가된 컬럼
            s.msalary        --추가된 컬럼     
     from employees e, (select department_id, max(salary) mSalary
                        from employees
                        group by department_id) s
     where e.department_id = s.department_id
     and e.salary = s.mSalary;
                      
               
/*******************
rownum
********************/
--예)급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다. (X) --> 정렬을하고 rownum 한다 
select  rownum,
        employee_id,
        first_name,
        salary
from employees --정렬되어 있는 테이블이면??
order by salary desc;

----> 정렬을하고 rownum 한다 
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary,
        ot.hire_date
from (select employee_id,
             first_name,
             salary,
             hire_date
      from employees
      order by salary desc) ot  --정렬되어 있는 테이블이면??
where rownum >=1   -- rownum >= 2  --> 데이터가 없다
and rownum <=3;

----> (1)정렬을하고, (2)rownum하고  (3)where절을 한다 

select  ort.rn,
        ort.employee_id,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select employee_id,
                   first_name,
                   salary
            from employees
            order by salary desc) ot  --(1)
      ) ort --(2)     
where rn >=3
and rn <= 5;  --(3)