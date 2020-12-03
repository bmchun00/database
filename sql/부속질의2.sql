-- 각 부서에서 최대 급여를 받는 사원의 이름과 급여, 부서명칭을 검색하시오. 

-- 1. 부서별 최대 급여 

select dno, max(salary) 

from employee where dno is not null 

group by dno 

 

-- 2. 1번에서 계산된 결과를 employee 테이블, department 테이블과 조인 

-- employee 조인 시, 조인 조건은 반드시 2개!! 

select empname, salary, deptname 

from employee e1 

join  

(select dno, max(salary) as max_sal 

from employee where dno is not null 

group by dno) e2 

on e1.salary = e2.max_sal and e1.dno = e2.dno 

join department d 

on d.deptno = e1.dno 

 

-- 부속질의, 상관부속질의 

-- 각 부서에서 최대 급여를 받는 사원의 이름과 급여, 부서명칭을 검색하시오. 

select empname, salary, deptname from department d 

join employee e on d.deptno = e.dno 

where e.salary = (select max(salary) from employee e2 where e.dno = e2.dno) 

 

-- Insert 

select * from department; 

 

-- insert into 테이블이름 values(값들...) 

-- insert into 테이블이름(컬럼들) values(각 컬럼에 대응되는 값들...) 

insert into department values(5, '홍보', 3); 

insert into department(deptno, deptname) values(6, '연구'); 

insert into department values(6, '해외개발', 3); -- 기본키는 중복 x 

 

create table high_salary 

( 

name char(10) unique, 

title char(10) default '사원', 

salary int check(salary<6000000) 

) 

 

-- select 구문으로 데이터를 필터링하여 삽입하는 예시 

insert into high_salary (name, title, salary) 

select empname, title, salary 

from employee 

where salary >= 3500000; 

 

select * from high_salary; 

 

-- delete 

-- delete from 테이블이름 (where) 

 

delete from high_salary; 

delete from department where deptno > 4 

 

-- update 

-- update 테이블이름 set 컬럼이름 = 업데이트 값 (where) 

-- 총무부를 연구부로 이름 변경 

update department set deptname = '연구' where deptname = '총무' 

 

-- 테이블에 컬럼 추가(수정) 

alter table high_salary add column sal_raise int 

select * from high_salary; 

update high_salary set sal_raise = 1.1*salary; 

 

select * from employee; 

-- 1번 부서에서 근무하는 홍길동 대리 월급은 250만원 추가 

insert into employee values(5001, '홍길동', '대리', null, 2500000, 1); 

-- 사원 테이블에 정수형 타입의 보너스 컬럼 추가 

alter table employee add column bonus int; 

-- 프로젝트를 수행하고 있는 사원들은 프로젝트 갯수 * 월급의 20% 만큼 보너스를 책정하시오. 

-- 1. 사원들의 프로젝트 수행 갯수(프로젝트를 수행하고 있는 사원들) 

select e.empno, count(*) as num_prj 

from employee e 

join emp_proj ep 

on e.empno = ep.empno 

group by e.empno 

 

-- 2. 보너스 업데이트(조인 이용) 

update employee e 

set bonus = num_prj * 0.2 * e.salary 

from  

(select e.empno, count(*) as num_prj 

from employee e 

join emp_proj ep 

on e.empno = ep.empno 

group by e.empno) e2  

where e.empno = e2.empno 