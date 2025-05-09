select * from employees;

employees테이블에 department_name컬럼을 생성
select department_id from employees;

select department_id,department_name from departments;

desc employees;

DEPARTMENT_ID           NUMBER(6)
DEPARTMENT_NAME NOT NULL VARCHAR2(80) 

select emp_name,a.department_id,department_name 
from employees a,departments b
where
a.department_id = b.department_id
;

create table emp1
(
    EMP_NAME VARCHAR2(80),
    DEPARTMENT_ID NUMBER(6),
    DEPARTMENT_NAME VARCHAR2(80),
    SALARY NUMBER(8,2) 
);

insert into emp1 values ( '홍길동',10,'총무기획부','100');
insert into emp1 values ( '유관순',20,'마케팅','200');
insert into emp1 values ( '이순신',30,'구매/생산부','200');

commit;

update emp1 set department_name = '전략기획부' 
where department_id = 10;

commit;

select * from emp1;
select * from depart1;

create table depart1 (
    DEPARTMENT_ID NUMBER(6),
    DEPARTMENT_NAME VARCHAR2(80)   
);

insert into depart1 values (10,'총무기획부');
insert into depart1 values (20,'마케팅');
insert into depart1 values (30,'구매/생산부');

commit;

select count(*) from board;


select * from board;

select * from member;


update member set id='aaa' where id='Flori';
update member set id='bbb' where id='Holt';
update member set id='ccc' where id='Byrom';
update member set id='eee' where id='Austin';
update member set id='fff' where id='Allard';

commit;

select bno,btitle,name from member a,board b
where a.id = b.id;

select * from scoregrade;

create table scoregrade (
    GRADE       CHAR(1),   
    MINSCORE    NUMBER(3), 
    MAXSCORE    NUMBER(3) 
);

insert into scoregrade values (
    'F',0,59
);

desc scoregrade;


select * from stuscore;
select * from scoregrade;
alter table stuscore add grade char(1) default 'C' not null;

alter table stuscore rename column grade to sgrade; 

select * from stuscore;

--
scoregrade, stuscore테이블 non-equi join

select total,grade
from scoregrade,stuscore
where total between minscore and maxscore
;

select * from scoregrade;

select avg,grade
from stuscore,scoregrade
where avg between minscore and maxscore;

select * from stuscore;

구매리스트 정보 1달별로 총구매금액 출력 회원등급기준으로 등급 입력시킬때
non-equi join
--
-- 그룹함수 sum
select a.department_id,department_name, 
count(salary),round(avg(salary),2),sum(salary) 
from employees a,departments b
where a.department_id = b.department_id
group by a.department_id,department_name
order by sum(salary) desc
;

select * from stuscore;


select * from stuscore2;

update stuscore2 set rank=0;
commit;

select * from stuscore2;

rank()함수를 사용해서 등수를 입력하시오.

수정
update stuscore a 
set rank=
( select ranks from
( select sno,rank() over(order by total desc) ranks from stuscore) b
where a.sno = b.sno )
;

select * from stuscore;

select sgrade from stuscore order by total desc;

update stuscore a 
set sgrade = 'A';
commit;

select grade from (
select sno,avg,grade
from stuscore,scoregrade
where avg between minscore and maxscore
) b
where a.sno = b.sno
;

update stuscore a 
set sgrade = (
select grades from (
select sno,avg,grade as grades from stuscore,scoregrade
where avg between minscore and maxscore
) b 
where a.sno = b.sno
)
;

update stuscore a set sgrade = 
(
select grades from(
select sno,grade grades from scoregrade,stuscore
where avg between minscore and maxscore
) b
where a.sno = b.sno
);

select * from stuscore;

update stuscore a set sgrade = (
select grades from (
select sno,grade as grades
from stuscore,scoregrade
where avg between minscore and maxscore
) b
where a.sno = b.sno
);


select sno,grade as grades
from stuscore,scoregrade
where avg between minscore and maxscore
order by sno 
;

select count(*) from stuscore2;

select * from stuscore2 order by avg;
select * from scoregrade;

select sno,avg,grade
from stuscore2,scoregrade
where avg between minscore and maxscore
;

select * from scoregrade;

update scoregrade set maxscore = 59.999 where grade='F';
update scoregrade set maxscore = 69.999 where grade='D';
update scoregrade set maxscore = 79.999 where grade='C';
update scoregrade set maxscore = 89.999 where grade='B';
commit;
desc scoregrade;

alter table scoregrade modify (maxscore number(6,3)); 

select * from stuscore2;
alter table stuscore2 add sgrade char(1) default 'F';

select sno,avg,grade 
from stuscore2,scoregrade
where avg between minscore and maxscore;

update stuscore2 a 
set sgrade = 
(
select grade from
(
select sno,avg,grade 
from stuscore2,scoregrade
where avg between minscore and maxscore
) b
where a.sno = b.sno
)
;

select * from stuscore2;


update stuscore2 set rank = 1;

select ranks from
(select sno,rank() over(order by total desc) ranks from stuscore2)
;

update stuscore2 a
set rank = (
select ranks from
(select sno,rank() over(order by total desc) ranks from stuscore2) b
where a.sno = b.sno
);
commit;

select * from stuscore2;



select * from stuscore2;

drop table stuscore;

create table stuscore as select * from stuscore2;

create table stuscore3 as select * from stuscore where 1=2;

select * from stuscore;

drop table stuscore3;

alter table stuscore2 drop column rank;

select * from 
(select a.*,rank() over(order by total desc) ranks from stuscore2 a)
order by sno desc
;

select * from member;

alter table member add total number(3) default 0;

update member a set a.total = (
select b.total from stuscore2 b
);

select * from stuscore;


insert into member(total) select total from stuscore where total>0;

select * from member;

delete member where id is null;

commit;

alter table member add no number(4);

select * from member;

insert into member(no,total) select sno,total from stuscore;
update member set no=(select sno from stuscore),total=(select total from stuscore);

delete from member where id is null;

commit;

select rownum, no from member;

update member set no=(select rownum from member);


select * from stuscore;
update stuscore set sgrade = 'F';

commit;

-- 등급처리
update stuscore a set sgrade = (
select grade from (
select sno,avg,grade from stuscore,scoregrade
where avg between minscore and maxscore
) b where a.sno = b.sno )
;

select * from stuscore;
select grade from (
select sno,avg,grade from stuscore,scoregrade
where avg between minscore and maxscore
) b where a.sno = b.sno
;


select grade from(
select avg,grade from stuscore,scoregrade
where avg between minscore and maxscore
) where grade in( 'A','B','C');

select * from scoregrade;   grade,minscore,maxscore
select * from stuscore;     


insert into stuscore values (stuscore_seq.nextval,'홍',100,100,100,300,100,0,'F')
;

rollback;


select * from employees;

select employee_id,emp_name,manager_id,job_id 
from employees;

equi-join : 서로다른 2개 테이블에서 같은 컬럼을 가지고 검색
non equi-join : 서로다른 2개 테이블에서 같은 컬럼이 없는 경우 검색
self join : 같은 테이블 2개에서 검색
outer join - null값이 있을때, null값도 포함해서 검색

같은 테이블 2개를 가지고 조인 : 셀프조인
select a.employee_id,a.emp_name,a.manager_id,b.emp_name 
from employees a,employees b
where a.manager_id = b.employee_id and b.emp_name like '%Steven%';


셀프조인 - 106명, null검색이 안됨.
outer join - null값이 있을때, null값도 포함해서 검색
select sum(a.salary),a.manager_id,b.emp_name
from employees a,employees b
where a.manager_id(+) = b.employee_id(+)
group by a.manager_id,b.emp_name
;

manager_id null
select * from employees where manager_id is null;


107명
select count(*) from employees;


-- ansi cross join
select * from employees cross join departments;
-- 기본 sql구문
select * from employees,departments;

-- 기본sql구문 equi-join
select emp_name,a.department_id,department_name 
from employees a, departments b
where a.department_id = b.department_id
;

-- ansi조인 equi-join
select department_id,department_name 
from employees join departments
using(department_id)
;

-- 기본sql구문 : outer-join (+)
select a.manager_id,b.emp_name 
from employees a, employees b
where a.manager_id = b.employee_id(+)
;

select a.manager_id,b.emp_name 
from employees a, employees b
where a.manager_id(+) = b.employee_id
;

-- 기본sql구문에서는 full join 은 사용할수 없음.
select a.manager_id,b.emp_name 
from employees a, employees b
where a.manager_id(+) = b.employee_id(+)
;

-- ansi 조인구문 : outer-join
select a.manager_id,b.emp_name from employees a
left outer join employees b
on a.manager_id = b.employee_id
;

select a.manager_id,b.emp_name from employees a
right outer join employees b
on a.manager_id = b.employee_id
;

select a.manager_id,b.emp_name from employees a
full outer join employees b
on a.manager_id = b.employee_id
;


union : 2개의 검색된 결과에서 중복된 결과값은 제거해서 출력(중복제거) 2개 테이블을 출력시킬때 사용

select * from departments;

select department_id,manager_id
from departments
where manager_id is not null
union
select department_id,manager_id
from employees
where department_id>80;

employees테이블에서 부서번호가 50 검색 -> department_id,department_name
employees테이블에서 없는 departments의 부서검색 -> department_id,department_name
2개를 union 하시오.

department_id,department_name

employees테이블에서 없는 departments의 부서검색 12개 
select distinct department_id from employees order by department_id;

employees테이블에서 부서번호가 50 이상 검색 6개
select distinct a.department_id,department_name
from employees a,departments b
where a.department_id = b.department_id and a.department_id>50

union

select department_id,department_name
from departments a
where not exists
(select * from employees b where a.department_id = b.department_id);

select * from member;

select * from employees;

create or replace view emp
as select employee_id,emp_name,email,phone_number from employees
;


select * from emp;


select department_id,department_name from employees;

select * from depart1;
select * from emp1;

select * from emp;

select * from employees;

update employees set phone_number = '650.507.9834' where employee_id=198;

drop view emp;

select * from member;



