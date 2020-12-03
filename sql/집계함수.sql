select dno, count(*) as num_emp, avg(salary) as avg_salary  from employee 

group by dno 

having avg(salary) > 2000000 

order by count(*); 

 

select dno, count(*), avg(salary), max(salary) from employee 

where salary <= 5000000 and dno is not null 

group by dno 

having count(*) >= 2 and dno <> 2 

 

 

-- 합집합 union 

-- (select ... from ...) union (select ... from ...) 

-- 월급이 200만원 미만이거나 2번 부서에서 근무하는 직원들의 이름 

(select empname from employee where salary < 2000000) 

union 

(select empname from employee where dno = 2); 

 

-- = select empname from employee where salary < 2000000 or dno = 2 

 

(select dno from employee where empname = '박영권') -- = 1 

union all 

(select deptno from department where deptname = '영업') -- = 1 

 

-- intersect: 교집합 

(select dno from employee where empname = '박영권' or empname = '이성래') -- = 1, 2 

intersect 

(select deptno from department where deptname = '영업') -- = 1 

 

-- Except: 차집합 

(select dno from employee where empname = '박영권' or empname = '이성래') -- = 1, 2 

except 

(select deptno from department where deptname = '영업') -- = 1 

 

 

-- limit or offset: postgresql에서 상위 n개 혹은 상위 n개 제외한 결과를 뽑는 구문 

select * from employee offset 1 

 

-- 가장 많은 월급을 받는 사람의 이름과 월급, 가장 적은 월급을 받는 사람의 이름과 월급을 검색하시오. 

(select empname, salary from employee order by salary desc limit 1) 

union 

(select empname, salary from employee order by salary limit 1) 

 

-- where 절에서는 집계 함수를 사용할 수 없음 

-- having 절에서는 집계 함수를 이용한 필터링이 가능 

-- 다만, having 절은 group by 이후에 등장 

-- 그루핑을 하지 않고, 집계 함수를 적용하여 필터링하는 방법 -> 부속 질의 

(select empname, salary from employee  

where salary = (select min(salary) from employee)) 

union 

(select empname, salary from employee  

where salary = (select max(salary) from employee)); 

 

-- 조인 

-- 부모 릴레이션 R, 자식 릴레이션 S가 있다고 할때, 

-- R과 S의 조인 

select r.*, s.* 

from R as r 

join S as s 

ON r.primarykey = s.foreignkey 

 

select * from department 

select * from employee 

 

select d.*, e.* 

from department as d 

join employee as e 

on d.deptno = e.dno 

 

select d.deptname, e.empname, e.title 

from department as d 

join employee as e 

on d.deptno = e.dno 

-- 일반적으로 부모 릴레이션을 왼쪽에 명시, department join employee 

 

select r.*, s.*, l.* 

from R as r 

join S as s 

on r.A = s.B 

join L as l 

on s.C = l.D 

 

-- 사원 테이블과 프로젝트-사원 테이블, 프로젝트 테이블을 조인하시오. 

-- 즉, 사원의 이름과 해당 사원이 수행하는 프로젝트의 번호 및 이름을 검색하시오. 

select * from employee 

select * from emp_proj 

select * from project 

 

select e.empname, p.prjname 

from employee as e 

join emp_proj as ep 

on e.empno = ep.empno 

join project as p 

on ep.prjno = p.prjno 

order by e.empname 