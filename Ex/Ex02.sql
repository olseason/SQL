--null
select first_name, salary, commission_pct, salary * commission_pct
from employees
where salary between 13000 and 15000;


select first_name, salary, commission_pct
from employees
where commission_pct is not null;

select first_name, salary, commission_pct
from employees
where commission_pct is null;

--예제) 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력 
select first_name, commission_pct
from employees
where commission_pct is not null;

--예제) 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력 
SELECT  first_name
from employees
where commission_pct is null
and manager_id is null;

--ordrer by
select first_name, salary
from employees
order by salary desc;  --내림차순 


select first_name, salary
from employees
order by salary asc;   --오름차순 \\

select first_name, salary
from employees
order by salary asc, first_name asc;  --1순위 급여 오름차순. 급여가 동률일 때 사용 


--예제) 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력
select department_id, salary, first_name
from employees
order by department_id asc;


--예제) 급여가 10000이상인 이름과 급여가 큰 직원부터 출력
select first_name, salary
from employees
where salary >= 10000
order by salary desc;


--예제) 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호, 급여, 이름 출력
select department_id, salary, first_name
from employees
order by department_id asc, salary desc;


--가상의 테이블 dual
select initcap('aaaa')
from dual;


/*단일행 함수*/
--문자함수 -initcap(컬럼명) 영어의 첫글자만 대문자로 출력, 나머지는 소문자 
select email, initcap(email), department_id
from employees
where department_id = 100;

--문자함수 -lower(컬럼명) /  upper(컬럼명) 입력되는 값을 전부 소문자/대문자로 변경 
select first_name, lower(first_name), upper(first_name)
from employees
where department_id = 100;

--문자함수 -substr(컬럼명, 시작위치, 글자수)
select substr('abcdefg', 3, 4)
from dual;

select first_name, substr(first_name, 1, 3), substr(first_name, -3, 1)
from employees
where department_id = 100;

--문자함수 -lpad(컬럼명, 자리수, '채울문자') 왼쪽공백에 특별한 문자 / rpad() 오른쪽 공백 
select first_name, lpad(first_name, 10, '*'),rpad(first_name, 10, '*')
from employees;


--문자함수 -replace(컬럼명, 문자1, 문자2) 컬럼명에서 문자1 -> 문자2로 바꿈 
select first_name,
replace(first_name, 'a', '****')
from employees;

select first_name,
replace(first_name, 'a', '*'),
replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;


/*숫자함수*/
--round(숫자, 출력을 원하는 자리수) 반올림 
select  round(123.346, 2),
        round(123.346, 0),
        round(123.346, -1)
from dual;


--turn 숫자의 버림을 하는 함수 
select  trunc(123.346, 2),
        trunc(123.346, 0),
        round(123.346, -1)
        from dual;
        
        
/*단일행 함수*/
--abs
select abs(-5)
from dual;


/*날짜함수*/
--sysdate
select sysdate
from dual;

--monts_between 
select MONTHS_BETWEEN(SYSDATE,hire_date)
from employees
where department_id = 110;


/*변환함수*/
--to_char() 숫자->문자열 
select first_name, salary*12, to_char(salary*12, '$999,999.99')
from employees
where department_id = 100;


select  to_char(9876, '99999'),
        to_char(9876, '099999'),
        to_char(9876, '$9999'),
        to_char(9876, '9999.99'),
        to_char(987654321, '999,999,999'),
        to_char(987654321, '999,999,999,999')
from dual;


--to_char() 날짜->문자열 
             select sysdate,
             to_char(sysdate, 'hh24: mi:ss'), 
             to_char(sysdate, 'yyyy"년"-mm"월"-dd"일"'), 
             to_char(sysdate, 'dd'), 
             to_char(sysdate, 'yyyy'),
             to_char(sysdate, 'yy'),
             to_char(sysdate, 'mm'),   
             to_char(sysdate, 'month'),
             to_char(sysdate, 'dd'),
             to_char(sysdate, 'day'),
             to_char(sysdate, 'hh'),
             to_char(sysdate, 'hh24'),
             to_char(sysdate, 'mi'), 
             to_char(sysdate, 'ss') 
from dual;


--nvl()  nvl2()
select first_name, commission_pct, nvl(commission_pct, 0)
from employees;


select  first_name, 
        commission_pct, 
        nvl(commission_pct, 0),
        nvl2(commission_pct, 1, 0)
from employees;