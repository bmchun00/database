-- 만약에 고정 길이 문자열로 컬럼이 되어 있고, 컬럼의 타입을 수정하지 않는 상태에서 

-- 공백을 제거하고 특정 문자의 포함여부를 검색할 수 있나요? 

-- char 타입의 컬럼은 '~~___' 공백이 필연적으로 발생 

-- trim 메소드: 문자열의 공백을 제거 '~~___' -> '~~'  

-- '사원______' -> trim('사원______') => '사원' 

 

-- '원'으로 끝나는 직급에 해당하는 사원들의 모든 정보를 검색하시오. 

select * from employee where trim(title) like '%원'; 

 

-- 김정현 사원 추가 

-- 외래키는 null을 가질 수 있기 때문에 dno 컬럼에 null 삽입하는 것이 가능 

insert into employee values(5000, '김정현', '사원', 2106, 1500000, null); 

 

-- 1번 부서가 아닌 사원들의 모든 정보를 검색하시오. 

select * from employee where dno <> 1; 

select * from employee where dno != 1; 

 

-- null은 사칙연산을 적용할 수 없기 때문에 

-- 위 연산은 null 값을 포함하는 튜플들을 제외하고 수행 

select * from employee where dno <> 1 or dno is null; 

 

-- 사원들의 이름과 월급과 월급의 10%의 인상액을 검색하시오. 

-- select 구문은 산술연산이 가능하며 as 키워드를 통해 별칭을 붙일 수 있음 

select  

empname, salary,  

1.1*salary as new_salary, (1.1*salary - salary) as increment  

from employee; 

 

-- 월급순으로 사원정보를 정렬하시오. 

-- order by 정렬, 기본은 오름차순 

-- where 절 다음에 위치 

select * 

from employee 

order by salary 

 

select * 

from employee 

where dno = 3 

order by salary desc 

 

-- limit, offset 

-- limit: 상위 n개만 

-- offset: 상위 n개 제외 

-- 월급이 낮은 상위 3명만 보여줘 

select *  

from employee 

order by salary 

limit 3; 

 

-- 월급이 낮은 상위 3명을 제외한 나머지를 보여줘 

select *  

from employee 

order by salary 

offset 3; 

 

-- 평균, 최대/최소, 합 

select max(salary) 

from employee 