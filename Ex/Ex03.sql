/*그룹함수*/

-- 단일행함수
SELECT
    first_name 이름,
    round(salary, - 3)
FROM
    employees;

-- avg() 오류 --> 107개 필드 vs 1개 필드 = 오류
SELECT
    first_name 이름,
    AVG(salary)
FROM
    employees;

-- avg() 컬럼에 대한 평균값
SELECT
    '연봉평균',
    AVG(salary)
FROM
    employees;


-- count() row의 개수(데이터개수)(NULL 제외)
SELECT
    COUNT(*), -- 107
    COUNT(first_name), -- 107
    COUNT(commission_pct), -- 35 (NULL 제외)
    COUNT(nvl(commission_pct, 0)) -- 107 (NULL을 0으로)
FROM
    employees;

-- 조건절(WHERE) 추가 조건에 맞는 개수
SELECT
    COUNT(*)
FROM
    employees
WHERE
    salary > 16000;


-- sum()
SELECT
    SUM(salary),
    COUNT(salary)
FROM
    employees;

-- avg() NULL일때 0으로 변환해서 사용
SELECT
    COUNT(*), -- row 전체개수 107COUNT ( commission_pct ), -- 커미션 값이 있는 직원 35 (NULL제외)
    SUM(commission_pct), -- 커미션 총합

-- NULL 제외 되는 평균값
    AVG(commission_pct), -- 커미션 평균 (NULL 제외) --> 0.222857...
    SUM(commission_pct) / COUNT(commission_pct), -- 커미션 평균 (NULL 제외) --> 0.222857...

-- NULL 포함 되는 평균값
    AVG(nvl(commission_pct, 0)), -- 커미션 평균 (NULL 포함, NULL = 0) --> 0.072897...
    SUM(commission_pct) / COUNT(*) -- 커미션 평균 (svg가 아니므로 NULL포함) --> 0.072897...
FROM
    employees;

SELECT
    COUNT(*)                      "row 개수",
    SUM(salary)                   연봉합,
    AVG(salary)                   연봉평균,
    SUM(salary) / COUNT(*)        "연봉평균sum/count"
FROM
    employees;


-- max(), min() --> 정렬 후 값을 출력함(처리속도가 오래걸려서 테스트에만 사용)
SELECT
    first_name,
    salary,
    nvl(commission_pct, 0)
FROM
    employees
ORDER BY
    salary DESC;

SELECT
    MAX(salary),
    MIN(salary),
    MAX(commission_pct),
    MIN(commission_pct)
FROM
    employees;

/* row값이 달라서 오류
SELECT
    first_name, -- 107
    MAX(salary) -- 1
FROM
    employees;
*/


/*GROUP BY*/
SELECT
    department_id,
    salary
FROM
    employees
ORDER BY
    department_id ASC;

-- 부서별 묶음, 부서별 연봉 평균
SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id ASC;

-- TEST
SELECT
    hire_date,
    AVG(salary)
FROM
    employees
GROUP BY
    hire_date
ORDER BY
    hire_date ASC;
    
-- GROUP BY 절 사용시 주의
SELECT
    department_id,
    COUNT(*),
    SUM(salary),
    round(AVG(salary), 3)
FROM
    employees
GROUP BY
    department_id;

/* 안되는 경우 --> 그룹컴럼과 관련성이 없다
SELECT
    department_id,
    job_id,
    COUNT(*),
    SUM(salary),
    round(AVG(salary), 3)
FROM
    employees
GROUP BY
    department_id;
*/

-- GROUP BY 세분화 -- 위의 오류를 해결 할 수 있다.
SELECT
    department_id,
    job_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id, -- 1순위 그룹
    job_id -- 2순위 그룹
ORDER BY
    department_id ASC;

-- 예제)
SELECT
    department_id   부서번호,
    COUNT(*)        부서별인원, --> COUNT(department_id) 가능
    SUM(salary)     급여합계
FROM
    employees
GROUP BY
    department_id
ORDER BY
    SUM(salary) DESC;

-- 예제2) GROUP BY에 대한 조건절 = HAVING 절
SELECT
    department_id            부서번호,
    COUNT(department_id)     부서별인원,
    SUM(salary)              급여합계
FROM
    employees
/*WHERE 오류
    SUM(salary) >= 20000*/
GROUP BY
    department_id
HAVING -- GROUP BY에 대한 조건절(HAVING = WHERE)
    SUM(salary) >= 20000
ORDER BY
    SUM(salary) DESC;

-- 예제2-1) 조건추가
SELECT
    department_id            부서번호,
    COUNT(department_id)     부서별인원,
    SUM(salary)              급여합계
FROM
    employees
GROUP BY
    department_id
HAVING SUM(salary) >= 20000
       AND department_id = 100 -- 조건추가(GROUP BY에 참여한 컴럼만 조건추가 가능)
ORDER BY
    SUM(salary) DESC;

-- 예제2-2) 그룹추가, 조건추가2
SELECT
    department_id            부서번호,
    job_id                   팀,
    COUNT(department_id)     부서별인원,
    SUM(salary)              급여합계
FROM
    employees
GROUP BY
    department_id,
    job_id
HAVING SUM(salary) >= 20000
       AND department_id < 100 -- 조건추가(GROUP BY에 참여한 컴럼만 조건추가 가능)
       AND job_id > 'AD_VP'
ORDER BY
    SUM(salary) DESC;


/*
SELECT 문
    SELECT 절
    FROM 절
    WHERE 절
    GROUP BY 절
    HAVING 절
    ORDER BY 절
*/


-- CASE ~END 문
SELECT
    employee_id,
    job_id,
    salary,
    CASE
        WHEN job_id = 'AC+ACCOUNT'  THEN
            salary + ( salary * 0.1 )
        WHEN job_id = 'SA_REP'      THEN
            salary + ( salary * 0.2 )
        WHEN job_id = 'ST_CLERK'    THEN
            salary + ( salary * 0.3 )
        ELSE
            salary
    END "팀별 연봉"
FROM
    employees;

-- DECODE() 문 (CASE ~END 문이 모두 = 일때)
SELECT
    employee_id,
    job_id,
    salary,
    decode(job_id, 'AC+ACCOUNT', salary +(salary * 0.1), 'SA_REP', salary +(salary * 0.2),
           'ST_CLERK', salary +(salary * 0.3),
           salary) "팀별 연봉"
FROM
    employees;

-- 예제)
SELECT
    first_name     이름,
    department_id  부서번호,
    job_id         팀,
    CASE
        WHEN 10 <= department_id
             AND department_id <= 50 THEN
            'A-TEAM'
        WHEN 60 <= department_id
             AND department_id <= 100 THEN
            'B-TEAM'
        WHEN 110 <= department_id
             AND department_id <= 150 THEN
            'C-TEAM'
        ELSE
            '팀없음'
    END            "부서별 팀 이름"
FROM
    employees
ORDER BY
    department_id ASC;


/*JOIN*/
SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    departments;

SELECT
    first_name       이름, -- 107row
    department_name  부서이름 -- 27row
-- employees 1개 마다 departments 27개 출력 ( 107 * 27 )
FROM
    employees,
    departments;

-- JOIN
SELECT
    first_name                   이름,
    department_name              부서이름,
    departments.department_id    부서번호 -- table에 같은 컴럼이 있을 경우 table.컴럼명
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

-- table 별명
SELECT
    first_name          이름,
    hire_date           입사일,
    department_name     부서이름,
    em.department_id    부서번호,
    em.manager_id       관리자번호
FROM
    employees    em,
    departments  de
WHERE
    em.department_id = de.department_id;
