select sysdate from dual;

-- 현재일에서 이달의 최초일 이달의 마지막일을 출력하시오.
select trunc(sysdate,'month'), sysdate, last_day(sysdate) from dual;

-- rownum 검색된 것에 일련번호를 다시 붙이는 것을 말함.

select * from stuscore;
select * from stuscore where avg>=80 and rownum<=5 order by avg desc; 

select rownum, stuscore.* from stuscore where kor>=80;
select rownum, stuscore.* from stuscore where name like '%s%';

-- 국어 점수와 영어점수 차이가 가장큰 10명의 학생을 출력하시오. 그리고 row num 을 붙여서 출력하시오

select rownum, a.* from (select name, kor, eng, abs(kor-eng) ke from stuscore order by ke desc) a where rownum<=10;

select name, kor, eng, abs(kor-eng) ke from stuscore order by ke desc;

-- 년월일시분초 요일출력
select to_char(sysdate,'yyyy-mm-dd am hh:mi:ss day') from dual;

-- 날짜 이후로 요일이 금요일인 날 출력
select next_day(sysdate,'금요일') from dual;

-- min max avg count sum 
select min(salary), max(salary), avg(salary), count(salary), sum(salary) from employees;

-- 현재 날짜에서 3일전의 날자 3달전의 날짜를 출력하시오.
select sysdate from dual;
select sysdate, sysdate-3, add_months(sysdate,-3) from dual;

-- ABC좋은나라DEF -> 좋은나라만 출력하시오. substr 사용해서 출력하시오.
select 'ABC좋은나라DEF', substr('ABC좋은나라DEF',4,4) from dual;

select mdate from member;

--월만분리해서출력하되 050607 인 회원만 출력하시오.
select mdate, to_char(mdate,'mm') from member where to_char(mdate,'mm') in (05,06,07);
select mdate, substr(mdate,4,2) subs from member where substr(mdate,4,2) in (05,06,07) order by substr(mdate,4,2);

desc stuscore;

create table stuscore5(
sno number(4),
name varchar2(100),
kor number(3),
eng number(3),
math number(3)
);

select * from stuscore3;
-- 기존 테이블이 존재시 데이터 모두 복사
insert into stuscore3 select * from stuscore;
-- 테이블과 함게 데이터를 모두 복사
create table stuscore4 as select * from stuscore;
-- 컬럼이 다른 경우의 데이터 모두 복사
insert into stuscore5(sno,name,kor,eng,math) select sno,name,kor,eng,math from stuscore;

desc stuscore5;
select * from stuscore5;

-- 컬람추가
alter table stuscore5 add total number(3);
-- 컥럼 삭제
alter table stuscore5 drop column total;

alter table stuscore5 add total number(2);

desc stuscore5;

-- 컬럼 변경 (타입변경)
alter table stuscore5 modify total number(3);
-- 기존에 들어가 있는 데이터가 3자리, 2자리 변경하려고하면 변환되지않으 ㅜ ㅜ 
-- 기존에 문자가 들어가 있는데 숫자형으로 변경하려고 하면 변경X

-- 컬럼 변경 (이름변경)
alter table stuscore5 rename column total to tot;

-- 테이블 명 변경
alter table stuscore2 rename to stu2;
alter table stu2 rename to stuscore2;

-- 칼럼 순서 변경
alter table stuscore5 modify name invisible;
alter table stuscore5 modify kor invisible;
alter table stuscore5 modify eng invisible;
alter table stuscore5 modify math invisible;

alter table stuscore5 modify name visible;
alter table stuscore5 modify kor visible;
alter table stuscore5 modify eng visible;
alter table stuscore5 modify math visible;

select * from stuscore5;

commit;

-- drop table stuscore3;
-- drop table stuscore4;
-- drop table stuscore5;

create table mem(
    id varchar2(30) primary key, -- 중복 X, null X
    name varchar2(100) not null, -- 중복 O, null X
    phone varchar2(20) unique, -- 중복 X, null O
    gender nchar(2) check(gender in ('남성','여성')),
    kor number(3) check(kor between 0 and 100)
);

insert into mem values(
'aaa','홍길동','010-111','남성',100
);


insert into mem values(
'bbb','유관순',null,'여성',99
);

insert into mem values(
'ccc','유관순',null,'여성',99
);

insert into mem values(
'ddd','이순신',null,'남성',100
);

commit;

select * from mem;

-- 테이블 mem 테이블 primary key id
-- constraint 별칭(fk_score_id) foreign key(현재테이블의 컬럼) refrences 

--- ### 기본키 설정
sno number(4) primary key;

--- ### 기본키 삭제
alter table score drop constraint SYS_C008357;

--- ### 기본키 설정
alter table score add constraint pk_score_sno
primary key(sno);

--- ### 외래키 설정

create table score(
sno number(4) primary key,
id varchar2(30),
kor number(3),
constraint fk_score_id foreign key(id) references mem(id)
);

desc score;

-- 기본키 : 중복 X, null X
-- 외래키 : 기본키업슨데이터를입력하면입력XX

-- 외래키 조건 등록
alter table score add constraint fk_socre_id foreign key(id) references mem(id);

-- 외래키 조건 삭제
alter table score drop constraint fk_score_id;

select * from mem;

insert into score values(1,'aaa',100);
insert into score values(2,'bbb',90);

select * from score;

delete score where sno=2;

commit;

select * from mem;

delete mem where id = 'bbb';

-- 조인

select * from employees;
select department_id from employees;
-- cross join - 테이블 2개 선택해서 출력 
-- 컬럼수 : 13*6 = 48
-- 데이터 수 : 107 * 27 = 2889개
select * from employees, departments; 



select * from departments;

desc employees; -- 13
desc departments; -- 6

equl join : 같은 컬럼을 가지고 조인
select emp_name, a.department_id, department_name, salary 
from employees a, departments b
where a.department_id = b.department_id;

select * from member;
select * from stuscore;

select phone, a.name, total, avg
from member a, stuscore b
where a.name = b.name;

select emp_name, salary, job_id from employees;
select * from jobs;
select * from employees;
select * from departments;
select min_salary, max_salary from jobs;

select emp_name, a.department_id, department_name, salary, a.job_id, min_salary, max_salary
from employees a, jobs b, departments c
where a.job_id = b.job_id and a.department_id = c.department_id;

select min_salary, max_salary from jobs;

desc board;
select * from board;

alter table board add (bfile3 varchar2(100));

alter table board modify bdate invisible;
alter table board modify bdate visible;

desc board;

create table bfile(
bno number(4),
bfile varchar2(100)
);

insert into bfile values(
1,'1.jpg'
);

insert into bfile values(
4,'d1.jpg'
);
commit;

select * from bfile;

select * from board a, bfile b where a.bno = b.bno;

alter table board drop column bfile;
alter table board drop column bfile2;
alter table board drop column bfile3;

desc board;

select count(*) 
select * from board a, bfile b where a.bno=b.bno and a.bno=1;

select * from board where bno=1;
select * from bfile where bno=1;

select * from board;

bno: board_seq.nextval
bgroup: board_seq.currval
bdate: sysdate

insert into board values(
board_seq.nextval, '2번째 게시글','파이썬에서 글쓰기 테스트','aaa',board_seq.currval,0,0,0,sysdate
);

select * from stuscore;
insert into stuscore values(
stuscore_seq.nextval, '이주연', 90, 90, 90, 90+90+90, (90+90+90)/3,0
);

commit;

select * from bfile;

select * from board;

cross join -> equi join -> non-equi join , inner join, outer join

non-equi join

create table scoreGrade(
grade char(1),
minscore number(3),
maxscore number(3)
);

insert into scoregrade values('F',0,59);
insert into scoregrade values('D',60,69);
insert into scoregrade values('C',70,79);
insert into scoregrade values('B',80,89);
insert into scoregrade values('A',90,100);

select * from scoregrade;
commit;

select * from scoregrade;
select * from stuscore;

-- stuscore 테이블 avg 가지고 scoregrade 테이블의 grade를 출력할 수 있게 구성
select sno, name, avg, grade from stuscore, scoregrade where avg between minscore and maxscore;

select trunc(to_char(sysdate, 'yyyy')- to_char(hire_date, 'yyyy'),-1) tyear, count(*) from employees 
group by trunc(to_char(sysdate, 'yyyy')- to_char(hire_date, 'yyyy'),-1);


-- 부서별평균월급을출력하시오
select * from employees;

select a.department_id, department_name, round(avg(salary),2)
from employees a, departments b
where a.department_id = b.department_id;



















