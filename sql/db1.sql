-- 20.10.06 

-- 데이터 정의어, 조작어, 제어어 

-- 데이터 정의어 

-- create, alter, drop 

 

-- 데이터 조작어 

-- select 

-- 테이블 혹은 테이블 조합(조인)에서 보고자 하는 컬럼 혹은 값(함수) 검색 

-- 문자열이나 사칙연산 수행 

 

select 'hello~'; 

select 3+5; 

select deptno, deptname from department; 

 

-- 관계대수 연산자 projection의 결과에는 중복값이 포함된다. -> t or f => f 

-- sql의 select 구문에서는 중복값을 포함한다. 

-- 중복값을 제거하려면, distinct 활용 

select title, salary from employee; 

select distinct title, salary from employee 

 

-- where: 조건절 

-- 특정 조건을 만족하는 튜플들을 검색할 때 활용(필터링) 

-- =, >, <= 등의 비교연산자 적용 

-- like: 문자열의 포함관계 검색 

-- in, not in: 집합의 포함관계 

-- between a and b: a와 b 사이에 해당하는 값 

 

-- 사원이름이 '이'로 시작하는 사원들의 모든 정보를 검색하시오. 

-- %: 문자열 

select * from employee where empname like '이%'; 

-- '권'로 끝나는 이름 검색 

select * from employee where empname like '%권'; 

 

-- 컬럼의 타입 바꾸기 

-- 1. 테이블 수정 

-- 2. 컬럼 수정 

-- 3. 타입 수정 

alter table employee alter column empname type varchar(10); 

-- varchar(x) 최대 x의 유동 길이를 갖는 문자열 

-- char(x) x의 고정 길이를 갖는 문자열 

 

-- 이름에 '수'가 들어가는 사원들의 모든 정보 검색 

select * from employee where empname like '%수%'; 

-- 고정 길이: _ 언더스코어 활용 

-- 성이 '이'로 시작하고 이름이 3글자인 사원들의 모든 정보 검색 

select * from employee where empname like '이__'; 

-- 이름이 3글자이면서 '철'로 끝나는 사원들의 모든 정보 검색 

select * from employee where empname like '__철'; 
