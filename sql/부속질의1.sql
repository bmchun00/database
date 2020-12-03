-- 사원들의 평균 급여보다 적게 급여를 받고 있는 직원들의 이름을 검색하시오. 

select empname, salary 

from employee 

where salary < (select avg(salary) from employee) 

-- = where salary < 2800000.000000000000 

 

-- 직원들이 2명 이상 소속된 부서에서 근무하는 직원들의 이름을 검색하시오. 

select empname 

from employee 

where dno in (select dno from employee group by dno having count(*) >= 2) 

-- = where dno in {1,3,2} 

 

-- 상관 부속 질의 

-- 외부 질의의 테이블에 별칭을 적용 

-- 별칭이 부속 질의에 참조되어 연산 

-- 외부 질의의 각 행에 대하여 순자척으로 연산의 t/f을 검사 

 

-- 사원 수가 2명 이상인 부서 이름을 검색하시오. 

-- 상관부속질의 

select deptname from department as d 

where 2 <= (select count(*) from employee where d.deptno = dno) 

 

-- 사원 수가 2명 이상인 부서 이름을 검색하시오. (부서별 사원 수 계산, ~별? -> group by) 

-- 조인 

select deptname 

from department d 

join employee e 

on d.deptno = e.dno 

group by deptname 

having count(*) >= 2 

 

-- 사원 이름과 소속 부서의 이름 

-- 상관부속질의를 이용 

-- select 절에도 상관부속질의를 적용할 수 있음 

select  

e.empname,  

(select deptname from department where e.dno = deptno ) 

from employee e 

 

-- 프로젝트를 수행하는 사원들의 평균 급여보다 급여를 적게 받는 사원들의 이름을 검색하시오. 

-- 부속질의 

select empname from employee 

where salary <  

(select avg(salary) 

from employee e 

join emp_proj ep 

on e.empno = ep.empno) 

 

-- 부하직원이 2명 이상인 사원들의 이름을 검색하시오. 

-- 상관부속질의 

select empname from employee as E 

where 2 <=  

(select count(*) from employee 

where manager = E.empno) 

 

-- 기획 부서에서 근무하는 사원들의 모든 정보를 검색하시오. 

-- 조인 이용 

select * from employee e 

join department d 

on e.dno = d.deptno 

where d.deptname = '기획' 

 

-- 상관부속질의, exists 

select * from employee E 

where exists  

(select 1 from department where deptno = E.dno and deptname = '기획') 

 

-- 소속 직원이 하나도 없는 부서 번호와 부서명을 검색하시오. 

select deptno, deptname 

from department d 

where not exists  

(select 1 from employee where d.deptno = dno) 