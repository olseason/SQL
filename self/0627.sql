/*case end 와 decode 차이 알기*/

select first_name, department_id, job_id,

CASE 

     when 10 <= department_id and department_id <= '50' then 'A-TEAM'

     when 60 <= department_id and  department_id <= '100' then 'B-TEAM'

     when 110 <= department_id and department_id <= '150' then 'C-TEAM'

     else '팀없음' 

END TEAM

from employees;

 

select employee_id, salary,

decode( job_id, 'AC_COUNT', salary + salary * 0.1,

                'SA_REP', salary + salary * 0.2,

                'ST_CLERK', salary + salary * 0.3,

                salary) realSalary

from employees;

 

--null은 조인안됨 (제외됨) 

select first_name, em.department_id, department_name, de.department_id

from employees em, departments de

where em.department_id = de.department_id;

 

 

--예제) 각 직업별 인원과 월급의 평균을 구해서 월급 평균의 내림차순으로 정렬하시오. 단, 인원이 3명 이상인 직업만 출력할 것

select job_id as "직업",count(employee_id) as "인원", avg(salary) as "월급평균"

from employees

group by job_id

/*having sum(salary) desc;*/  --sum이 아니라 count

having count(salary) >= 3

order by 3 desc;

 

 

--예제) 월급 10000달러 이상은 40% 세금, 5000달러 이상은 30% 세급, 그 외는 5% 세급이라고 했을 때

--이름과 세금, 실수령액을 출력하시오

select first_name as "이름", salary as "실수령액",

case when salary >= 10000 then salary * 0.4

     when salary >= 5000 then salary * 0.3

     else salary * 0.05

end 세금     

from employees;

 
--정답.. 

select 이름, 세금, salary-세금 실수령액 

from( select first_name 이름, salary, 

case when salary >= 10000 then salary*0.4 

     when salary < 10000 and salary >= 5000 then salary*0.3 

     else salary*0.05 

     end 세금 

from employees );