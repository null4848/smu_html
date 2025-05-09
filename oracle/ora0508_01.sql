select * from employees;

select rownum, emp_name, manager from employees;

select rownum, a.* from employees a order by emp_name;

-- 테이블로 사용가능
select * from employees order by emp_name;

select rownum, a.* from employees a order by emp_name;

select rownum, a.* from (select * from employees order by emp_name) a;

--  이름에 a 가 들어가 있으면서, 월급이 4800 이상이면서, manager_id가 103
select * from (
select * from employees where emp_name like '%a')
where salary >= 4800 and manager_id=103;

select * from employees where salary >= 4800 and manager_id=103;

-- ******* rownum 순차적인 번호를 매기는 함수
select rownum, a.* from member a order by id;

-- 순차적인 번호를 다시 매겨서 출력하시오
select rownum, a.* from (select * from member a order by id) a;

select rownum, a.* from 
(select * from member a order by id) a
where rownum between 11 and 20;

select * from (
select rownum rnum, a.* from(
select * from member a order by id) a
) b
where rnum between 11 and 20 ;

select * from (
select rownum rnum, a.* from member a)
where rnum between 11 and 20;

select row_number() over(order by id asc) rnum, a.* from member a;

select rownum, a.* from (select * from member order by id asc) a;

select * from member;

select rank() over(order by total desc), total from stuscore;
select dense_rank() over(order by total desc), total from stuscore;

select * from stuscore;

desc stuscore;
ALTER TABLE stuscore ADD sgrade VARCHAR2(3);

update stuscore set rank=0, sgrade ='F';

-- rank, sgrade 값에 맞게 입력하시오.
rank() over()
-- sgrade non-equi join을 해서 해당되는 값을 입력하시오.
-- scoregrade 테이블사용

select * from scoregrade;
select * from stuscore;

select sno, rank() over(order by total desc), total, rank, avg, sgrade from stuscore;

select rank() over(order by total desc) ranks from stuscore;

update stuscore a set rank=(
select ranks from 
(select sno, rank() over(order by total desc) ranks from stuscore) b
where a.sno = b.sno);

-- non-equi join 
-- stusocre, scoregrade

select * from scoregrade;

select * from stuscore;

update stuscore a set sgrade = (
select grade from (
select sno, grade from stuscore, scoregrade where avg between minscore and maxscore) b
where a.sno = b.sno);

select sno, avg, grade from stuscore, scoregrade
where avg between minscore and maxscore;

-- ********* substr
select mdate, substr(mdate,4,2) from member;

-- 03~08 출력
select mdate, substr(mdate,4,2) from member where substr(mdate,4,2) between '03' and '08' order by substr(mdate,4,2);
select mdate, substr(mdate,4,2) from member where substr(mdate,4,2) in (3,4,5,6,7,8);

select mdate, to_number(substr(mdate,4,2)) from member where to_number(substr(mdate,4,2)) between 3 and 8;

-- 뒤에잇는 3글자를 출력하시오.
select emp_name from employees;

select emp_name, substr(emp_name,1,3), substr(emp_name,-3) from employees;

select '   aaa bbb ccc   ' from dual;

--  앞뒤 공백 제거
select trim('   aaa bbb ccc   ') from dual;

-- replace 특정 문자 변경
select replace('   aaa bbb ccc   ', ' ', '') from dual;

select replace(emp_name, ' ', '') from employees;

select phone_number from employees;

select lpad(phone_number) from employees;

-- 전화번호 뒤4자리를 ** 출력하시오.
select phone, rpad(substr(phone, 1, 8),12,'*') as r from member;

desc member;

-- 뒤에 2글자를 *로 표시해서 출력하시오.
select * name from member;

select length(name) from member;

select name, length(name), rpad(substr(name, 1, length(name)-2), length(name)+1, '*') from member;

select * from employees;
select * from member;

select emp_name from employees;
select id from member;
select id, length(id), rpad(substr(id, 1, length(id)-2), length(id), '*') from member;

------------------------------------------------------------------------------
select id, pw from member;

-- pw 뒤 2글자를 * 표시하세염
select pw, length(pw), rpad(substr(pw,1,length(pw)-2), length(pw), '*') from member;

-- id 모두를 * 표시 하세염
select id, rpad(substr(id,1),length(id),'*') from member;

-- 010-****-5678 phone 컬럼을 출력하시오.
select phone from member;
select substr(phone,1,4)||'***'||substr(phone,8,5) as phone from member;

-- 그달의 첫번째 일, 마지막일을 출력하시오.
select mdate from member;
select trunc(mdate,'mm'), mdate, last_day(mdate) from member;

-- 날짜 형태
-- yyyy-mm-dd hh:mi:ss 형태로 변경하시오. 24시간으로 표시
select to_char(mdate, 'yyyy-mm-dd hh24:mi:ss') from member;

select * from employees;
select emp_name, department_id from employees;
select emp_name, department_id,
decode
(department_id,
10,'총무기획부',
20,'마케팅부서',
30,'구매/생산부'
) as depart_name
from employees;

select * from member;
select mdate from member;
12,1,2->겨울
3,4,5->봄
6,7,8->여름
9,10,11->가을
select emp_name, department_id,
decode
(department_id,
10,'총무기획부',
20,'마케팅부서',
30,'구매/생산부'
) as depart_name
from employees;

select mdate,
decode
(to_char(mdate,'mm'),
1,'겨울',
2,'겨울',
3,'봄',
4,'봄',
5,'봄',
6,'여름',
7,'여름',
8,'여름',
9,'가을',
10,'가을',
11,'가을',
12,'겨울'
) as season 
from member;

select mdate, substr(mdate,4,2),
case
when substr(mdate,4,2) in ('12','01','02') then '겨울'
when substr(mdate,4,2) in ('03','04','05') then '봄'
when substr(mdate,4,2) in ('06','07','08') then '여름'
when substr(mdate,4,2) in ('09','10','11') then '가을'
end season
from member;

select * from departments;

select avg from stuscore;

-- 90점 이상이면 VVIP, 80점 VIP, 70점 GOLD, 60점 SILVER, 그외 BRONZE
-- if문이라고 보면 됨
select avg,
case
when avg >= 90 then 'VVIP'
when avg >= 80 then 'VIP'
when avg >= 70 then 'GOLD'
when avg >= 60 then 'SILVER'
when avg <= 59 then 'BRONZE'
end rank
from stuscore;

-- 그룹함수의 조건문 -> having 절 사용
select department_id, avg(salary) from employees 
where department_id<50 
group by department_id
having avg(salary)>5000;

select emp_name, salary from employees
where salary in (select max(salary));

select max(salary) from employees group by department_id having avg(salary)>5000;

-- 부서 이름을 출력하시오.
select employee_id, emp_name, a.department_id, department_name, salary from employees a, departments c
where salary = some (
select max(salary) from employees b
where a.department_id = b.department_id
group by department_id
) and a.department_id = c.department_id;

--sno 
--1-10까지 1
--11-20까지 2
--...
--..
--...
--11
select * from stuscore;

alter table stuscore add sclass number(2) default 0;

alter table stuscore modify sclass number(3); 

update stuscore set sclass = (
select rnum (
select rownum rnum, sno from stuscore
) a
);

update stuscore set sclass =
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
else 11
end;

select sno, total, avg, 
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
else 11
end as sclass
from stuscore;

-- 부서별 가장 우러급이 높은 사원 출력
select emp_name, salary, a.department_id, department_name from employees a, departments c
where salary in (
select max(salary) from employees b
where a.deaprtment_id = b.department_id
group by department_id)
where a.department_id = c.departmnet_id;

-- sclass 반별로 가장 성적이 높은 학생들을 출력하시오.
select * from stuscore;

select * from stuscore a
where total in (
select maxtotal from (
select sno, max(total) maxtotal from stuscore b 
group by sclass
) where a. sno = b.sno);

-- sclass 반별로 가장 성적이 낮은 학생들을 출력하시오.

select * from stuscore
where total in (
select min(total) from stuscore 
group by sclass);

-- 12
select distinct department_id from employees order by department_id;

-- 27
select department_id from departments;

-- employees 없는 부서
select department_id, department_name from departments a
where not exists
(select * from employees b where a.department_id = b.department_id);

-- member 테이블에 이름이 존재하는 stuscore 학생성적을 출력하시오.
select * from member;

select * from stuscore A
where exists
( select * from member b where a.name = b.name);

select * from employees
where (department_id, salary) in
(select department_id, max(salary) from employees group by department_id);

create table stuscore3 as select * from stuscore;

create table stuscore 3 as select * from stuscore where 1=2;

drop table stuscore2;
drop table stuscore3;

create table stuscore2 as select * from stuscore;

update stuscore2 set sclass = 0;
commit;

select * from stuscore2;

select * from stuscore;

select sno, name, total, avg,
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
when sno between 101 and 110 then 11


end as sclass
from stuscore;









