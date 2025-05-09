-- create 테이블 생성
-- select, insert, update, delete : dml 언어

-- 명령어
-- tab 현재 가지고 있는 테이블 출력
select * from tab;

select * from member;

select * from employees;

desc member; -- 테이블 구조 확인

-- 오라클 타입 *number, char, varchar2, nchar, nvarchar2, clob, blob, long
create table mem1(
memNo number, -- 용량을 많이 차지하는 단점
memNo2 number(3), -- 0 ~ 999
memNo3 number(4,2) -- 4자리 소수점 2자리, 소수점 1개의 자리를 차지
);


-------------------
-- number : 숫자데이터, 소수점 표현 가능 int, float 합
-- number(4,2) : 총 자리수 4자리, 소수점 자리수 2자리 -> 0.0 - 99.99

-- 대소문자 구분 X
-- insert into MEM1 (MEMNO, MEMNO2, MEMNO3) 
insert into mem1 (memNo, memNo2, memno3) values(
100000000, 999, 1.23
);

insert into mem1 values(
2,0,9.9
);

insert into mem1 (memno2) values(
999
);

insert into mem1 (memno3) values(
99.99
);

insert into mem1 (memno3) values(
99.9
);

insert into mem1 (memno3) values(
-99.9
);

insert into mem1 (memno3) values(
-99.99
);

select * from mem1;

commit;

desc mem1;

select * from mem1;

update mem1 set memno = 222222222 where memno3 = 99.99;
update mem1 set memno = 3333333 where memno3 = 99.9;

update mem1 set memno = 20000 where memno3 = 9.9;

commit;


-- 천단위 표시
select memno from mem1;
select to_char (memno,'999,999,999') from mem1; -- 9자리 수는 빈공백을 빈공백으로 표시
select to_char (memno,'000,000,000') from mem1; -- 0자리 수는 빈공백을 0으로 표시


--------------------------------------
-- date 세기, 년, 월, 일, 시, 분, 초 데이터 입력 가능, default : 년-월-일만 출력
-- timestamp 세기, 년, 월, 일, 시, 분, 초, 밀리초

create table date1 (
sdate date
);

insert into date1 values (
sysdate -- 현재 시간을 저장
);

insert into date1 values(
'2025-04-01'
);

select * from date1;

-- 25/04/09
-- 날짜 포맷 변경 방법 date 타입 -> char 타입으로 변경해서 날짜 형태를 바꿀 수 있음.
select to_char(sdate,'yyyy-mm-dd hh:mi:ss') from date1;



-- char 타입 : 고정형 문자형 타입, varchar2 타입 : 가변형 문자형타입

create table mem2(
juminNo char(14),
id varchar2(30),
kor number(5,2),
eng number(5,2)
);

-- 14자리 -> 10자리만 입력해도 14자리 자리를 차지
-- 속도가 빠르다
insert into mem2 values (
'880101-1111111','aaa1111',99,90
);

insert into mem2 values (
'991231-2222222','bbb1234',80,81
);

commit;

select * from mem2;

select kor, eng from mem2;

-- round, ceil, floor
select kor, eng, kor+eng, (kor+eng)/2 from mem2;

-- nchar 국제 언어 고정형 문자열 타입, nvarchar2 국제언어 가변형 문자열 타입
create table mem3 (
gender1 char(1), -- 영문 1byte, 국문 3byte
gender2 char(2),
gender3 char(3),
gender4 nchar(1) -- 모든 언어의 1글자를 저장하는 타입 2byte 사용
);

insert into mem3 values (
'M','m','m','m'
);

insert into mem3(gender3) values ('남');
insert into mem3(gender4) values ('남'); 

select * from mem3;

commit;

--- select 

-- distinct 중복된 것을 1개만 출력시켜줌
select distinct job_id from employees;

select * from employees;

-- department id 중복 제거 후 출력
-- 정렬 order by, 컬럼 asc:순차정렬, desc:역순정렬
select distinct department_id from employees order by department_id desc;

select * from employees order by salary desc;

-- as 닉네임 
-- 슷자형 타입만 더하기, 빼기, 곱하기, 나누기 가능
select salary, salary*1438*12, to_char(salary*1438*12, '999,999,999') as ysalary from employees order by salary*1438 desc;

select * from member;

-- 문자열타입은 사칙연산 적용 X
select id+pw from member;

select department_id, department_name from departments;

-- 사원번호, 사원이름, 입사일hire-date, 월급 출력하시오.
-- 4개 컬럼 출력하시오.
select * from employees;

select employee_id, emp_name, hire_date, salary from employees;

-- 입사일만 출력 
-- 날자 : 더하기 빼기 가능 등가비교 가능
select hire_date, hire_date + 100, hire_date + 1000 from employees order by hire_date;

-- dual 가상테이블, 임시테이블
select sysdate,sysdate + 100, sysdate + 1000 from dual;

-- 산술연산자 + - * /
select salary from employees;
select salary, salary + 1000, salary - 100, salary * 12, salary/2 from employees;

-- 별칭은 사이띄움 안됨 -> "" 으로 감싸면 가능
select salary, salary * 12 as "year salary" from employees;

select salary, salary*12 as "YearSalary" from employees;

-- 테이블 타입 확인
desc employees;

-- null  무한대 numm * 100 = null 0과는 다른 의미

select manager_id from employees;

-- where 조건절에 맞는 것을 출력시켜줌
select manager_id from employees where manager_id=100;

select salary from employees where salary<6000;

select manager_id from employees;
select manager_id from employees where manager_id = 100;
select employee_id,manager_id from employees where manager_id is null;


-- number 연산
select employee_id, salary from employees;
select employee_id, salary, salary*12 from employees;

select * from employees;

select employee_id, emp_name, salary, commission_pct, salary+(salary*nvl(commission_pct,0)) "실제월급" from employees;

- null +,-,*,/ 전부 null로 변경 nvl() -> null 값을 0으로 먼저 대체
select commission_pct, nvl(commission_pct,0) from employees;

-- null  값을 1로 변경해서 출력하시오.
select nvl(manager_id,1) from employees;

select manager_id, nvl(to_char(manager_id),'CEO') from employees;

select manager_id, nvl(manager_id,'CEO') from employees;

-- salary, salary*12, salary*commission_pct, salary+(salary*commission_pct) 출력하시오
-- salary*12*1438 천단위 표시해서 출력하시오

select salary, salary*12, salary*commission_pct, salary+(salary*commission_pct)  from employees;
select to_char(salary*12*1438, '999,999,999') as "연봉" from employees; 

-- concat 함수 : 문자열 컬럼을 합쳐주는 함수

select * from member;
desc member;

-- select id+pw from member;
select id||','||pw from member;
select concat(id,pw) from member;

-- distinct 중복제거

-- where 절 : 조건절
select employee_id, salary from employees where salary >= 5000 order by salary;

-- 숫자 개수 :count
select count(*) from employees where salary>=5000 order by salary;
-- 최대값: max, 최소값: min, 평균: avg round:반올림
select max(salary), min(salary), round(avg(salary),2) from employees;

-- 5000 이상 8000이하인 월급을 받는 사원을 출력하시오
select emp_name, salary from employees where 5000<=salary order by salary;
select emp_name, salary from employees where salary<=8000 order by salary;
select emp_name, salary from employees where 5000<=salary and salary<=8000 order by salary;
select emp_name, salary from employees where salary between 5000 and 8000;

-- 월급이 평균 이상인 사원을 출력하시오.
select avg(salary) from employees;

select emp_name, salary from employees where 6461.83<=salary order by salary;
select emp_name, salary from employees where (select avg(salary) from employees)<=salary order by salary;

select * from departments;

-- 부서번호가 50 이상인 부서를 출력하시오.
select department_name, department_id from departments where department_id>=50;


select * from kor_loan_status;

-- 천만원
-- loan_jan_amt 원단위 환산한 후 천단위 표시해서 출력하시오.

select loan_jan_amt,loan_jan_amt*10000000, to_char(loan_jan_amt*10000000, '999,999,999,999') from kor_loan_status;

-- 25000.0 이상 역순정렬로 출력하시오.
select loan_jan_amt from kor_loan_status where loan_jan_amt>=25000.0 order by loan_jan_amt desc;

select * from employees;
-- salary가 4000인 사원을 출력하시오.
select emp_name,salary from employees where salary = 4000;

-- 4000 6000 7000
select emp_name, salary from employees where salary = 4000;
select emp_name, salary from employees where salary = 6000;
select emp_name, salary from employees where salary = 7000;

select emp_name, salary from employees where salary=4000 or salary=6000 or salary=7000;
select emp_name, salary from employees where salary in (4000,6000,7000);

-- 월급 6000 이하 , 사우너번호 사원이름 급여컬럼만 출력하시오
select  employee_id, emp_name, salary from employees where salary <=6000 order by salary desc;
select count(*) from employees where salary<=6000;

select * from stuscore;

desc stuscore;

-- 테이블의 컬럼 타입 변경
alter table stuscore modify avg number(5,2);

desc stuscore;

insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (1, '홍길동', 50, 51, 59, 160, 53.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (2, '유관순', 95, 87, 53, 235, 78.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (3, '이순신', 94, 94, 83, 271, 90.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (4, '강감찬', 76, 56, 87, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (5, '김구', 81, 69, 87, 237, 79, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (6, '김유신', 95, 56, 86, 237, 79, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (7, '홍길순', 71, 77, 62, 210, 70, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (8, '홍길자', 56, 83, 95, 234, 78, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (9, '길동스', 84, 52, 77, 213, 71, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (10, '관순스', 87, 93, 69, 249, 83, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (11, '순신스', 90, 69, 77, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (12, '감찬스', 58, 81, 71, 210, 70, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (13, '구스', 72, 62, 88, 222, 74, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (14, '유신스', 96, 81, 89, 266, 88.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (15, '길순스', 90, 50, 54, 194, 64.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (16, '길자스', 79, 72, 65, 216, 72, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (17, 'Freschi', 74, 66, 64, 204, 68, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (18, 'Ewbanck', 76, 69, 54, 199, 66.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (19, 'Kehoe', 95, 51, 85, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (20, 'MacNulty', 53, 68, 95, 216, 72, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (21, 'Renihan', 56, 96, 76, 228, 76, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (22, 'Petheridge', 71, 100, 96, 267, 89, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (23, 'Witson', 94, 83, 100, 277, 92.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (24, 'Norgan', 69, 93, 61, 223, 74.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (25, 'Ineson', 55, 72, 88, 215, 71.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (26, 'Giacobillo', 78, 77, 50, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (27, 'Domb', 92, 99, 68, 259, 86.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (28, 'Jentges', 75, 96, 85, 256, 85.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (29, 'McGuinley', 98, 56, 90, 244, 81.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (30, 'Pavkovic', 73, 97, 61, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (31, 'Pretious', 100, 63, 88, 251, 83.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (32, 'Elan', 50, 71, 86, 207, 69, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (33, 'Burnham', 57, 61, 59, 177, 59, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (34, 'Coldrick', 85, 53, 89, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (35, 'Befroy', 73, 68, 84, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (36, 'Blainey', 51, 54, 72, 177, 59, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (37, 'Haglington', 80, 89, 60, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (38, 'Foro', 60, 64, 77, 201, 67, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (39, 'Clemon', 73, 61, 93, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (40, 'Ruffler', 98, 58, 98, 254, 84.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (41, 'Sogg', 82, 68, 55, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (42, 'Rouse', 74, 78, 95, 247, 82.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (43, 'Kellitt', 67, 75, 97, 239, 79.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (44, 'Fishbourn', 71, 89, 82, 242, 80.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (45, 'Connock', 94, 70, 55, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (46, 'Hugonin', 88, 64, 77, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (47, 'Gossage', 72, 59, 66, 197, 65.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (48, 'Dicey', 80, 89, 62, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (49, 'Writer', 62, 56, 91, 209, 69.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (50, 'Jammes', 55, 54, 63, 172, 57.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (51, 'Lilburn', 74, 57, 53, 184, 61.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (52, 'Sealy', 93, 78, 94, 265, 88.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (53, 'Clarke-Williams', 50, 90, 85, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (54, 'Brecknall', 72, 100, 95, 267, 89, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (55, 'Davids', 55, 66, 87, 208, 69.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (56, 'Rix', 59, 75, 65, 199, 66.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (57, 'Saldler', 76, 76, 68, 220, 73.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (58, 'Degenhardt', 81, 67, 88, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (59, 'Hubbard', 55, 72, 91, 218, 72.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (60, 'Janczyk', 81, 50, 55, 186, 62, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (61, 'Deinert', 53, 58, 97, 208, 69.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (62, 'Simeoni', 73, 69, 67, 209, 69.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (63, 'Oloshkin', 100, 93, 57, 250, 83.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (64, 'Westlake', 99, 56, 74, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (65, 'Caris', 83, 100, 50, 233, 77.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (66, 'Kenwell', 64, 73, 91, 228, 76, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (67, 'Pallister', 72, 70, 91, 233, 77.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (68, 'Swalteridge', 71, 69, 78, 218, 72.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (69, 'Tolwood', 57, 71, 77, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (70, 'Hagart', 86, 64, 69, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (71, 'Blay', 70, 83, 90, 243, 81, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (72, 'Judkin', 66, 50, 77, 193, 64.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (73, 'Pavlovsky', 57, 77, 87, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (74, 'Guilbert', 84, 84, 53, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (75, 'Biasini', 57, 63, 58, 178, 59.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (76, 'Fitzsimmons', 62, 64, 94, 220, 73.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (77, 'Lamming', 87, 100, 72, 259, 86.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (78, 'Guilliatt', 71, 91, 93, 255, 85, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (79, 'Bendell', 75, 67, 98, 240, 80, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (80, 'Pickett', 79, 96, 75, 250, 83.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (81, 'Devey', 83, 96, 57, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (82, 'Bold', 100, 58, 65, 223, 74.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (83, 'Philpot', 85, 99, 77, 261, 87, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (84, 'Henrie', 92, 53, 80, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (85, 'Bentinck', 55, 88, 93, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (86, 'Kitchiner', 56, 72, 73, 201, 67, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (87, 'Appleton', 59, 64, 53, 176, 58.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (88, 'Kiefer', 74, 75, 55, 204, 68, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (89, 'Gosby', 86, 61, 79, 226, 75.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (90, 'Reston', 56, 78, 73, 207, 69, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (91, 'Sale', 81, 75, 68, 224, 74.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (92, 'Dongles', 100, 56, 63, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (93, 'Edinboro', 77, 72, 72, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (94, 'Aers', 72, 85, 70, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (95, 'De Mars', 59, 66, 69, 194, 64.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (96, 'Bremmell', 93, 96, 90, 279, 93, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (97, 'Salmen', 64, 95, 95, 254, 84.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (98, 'Hazell', 75, 56, 61, 192, 64, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (99, 'Skellen', 89, 87, 82, 258, 86, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (100, 'Grief', 92, 73, 63, 228, 76, 0);

select * from stuscore;

select * from stuscore order by kor desc;

select * from stuscore order by name desc;
select * from stuscore order by name asc;

select * from stuscore order by total desc;
select * from stuscore order by total asc;

-- 파이썬 성적 정렬
select sno, name, rank() over(order by total desc) as ranks from stuscore;

select sno, rank from stuscore;

-- sno 1,1
update stuscore set rank=1 where sno=1;

-- sno 2, 5
update stuscore set rank=5 where sno=2;

-----------------------
select * from mem1;

-- memno3 9.9, memno 50000, memno2 1000
update mem1 set memno=50000, memno2=10 where memno3 = 9.9;

-- memno2 = 999,  memno = 5000000 memno3 = 50.05
update mem1 set memno = 5000000, memno3 = 50.05 where memno2 = 999;

desc mem2;
select * from mem2;

-- id aaaa1111을 찾아서 주민번호 010101-2222222 국어점수 88 영어점수 95 변경
update mem2 set juminno='010101-2222222',kor=88,eng=95 where id='aaa1111';


select salary, rank() over(order by salary desc) as ranks from employees;

-- 등수처리 stuscore
select sno,rank() over (order by total desc) as ranks from stuscore;
select rank() over(order by total desc) as ranks from stuscore;
select sno,rank from stuscore order by total desc;

-- update
update stuscore a
set rank = 1 
where a.sno =1;

update stuscore a 
set rank = (select ranks from (select sno, rank() over(order by total desc) as ranks from stuscore) b
where a.sno=b.sno);


update stuscore  a
set rank = (select ranks from (select sno, rank() over(order by total desc) as ranks from stuscore) b
where a.sno=b.sno);

select * from stuscore;

select sno, rank() over(order by total desc) as ranks from stuscore
where sno=96;

-- sno, rank() 2개 컬럼을 찾아서 rank() 컬럼만 출력하시오.
select ranks from (select sno, rank() over(order by total desc) as ranks from stuscore

select sno, total, rank from stuscore;

-- 컬럼 2개 검색할대 사용되는 sno, 입력할대 사용되는 ranks
select sno,rank() over (order by total desc) as ranks from stuscore;
select ranks from (select sno, rank() over(order by total desc) as ranks from stuscore);

select sno,rank from stuscore;

commit;
select * from stuscore;
-----------------------------------------------
-- 테이블(데이터 포함) 그대로 복사
create table mem4(
no number(4)
);

create table stuscore2 as select * from stuscore;
select * from stuscore2;

desc stuscore; -- 컬럼 8개 sno name kor eng math total avg rank

-- 컬럼 5개 sno,name,kor,eng,math
create table stuscore3 as select sno,name,kor,eng,math from stuscore;

select * from stuscore3;

-- stuscore 3 번호, 국어, 영어, 수학, 합계 평균 출력
-- 등수
select sno, kor, eng, math, kor+eng+math as total, round((kor+eng+math)/3,3),

as avg from stuscore3;

alter table stuscore3 add total number(3);

desc stuscore3;

alter table stuscore3 add avg number(5,2);
 
desc stuscore3;

alter table stuscore3 add rand number(3);

select * from stuscore3;

-- 1번재  rank()를 rank 컬럼에 저장

update stuscore3 a 
set rank = (
select ranks from(select sno,rank() over(order by total asc) ranks from stuscore3) b
where a.sno = b.sno
);

select ranks from(select sno,rank() over(order by total asc) ranks from stuscore3) b;
select sno,rank() over(order by total asc) ranks from stuscore3;


-- 2번째 avg()를 avg 컬럼에 저장
update  stuscore3 set total = kor+eng+math;
update stuscore3 set avg = (kor+eng+math)/3;
select * from stuscore3;

-- rank 등수 어떤 형태로 등수를 출력
-- sno 96,23,3,22,,,,
select sno,rank() over(order by total asc) from stuscore3;


commit;
     





