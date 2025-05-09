select * from employees;

select * from employees where emp_name like '%n%' order by emp_name desc;
select count(*) from employees where emp_name like '%n%';

select * from stuscore order by rank desc;

select * from stuscore order by eng desc;

-- 입사일이 가장 일찍인 사원순으로 정렬하시오.
select * from employees order by hire_date;

-- 숫자 함수
-- abs(): 절댓값, round(): 반올림, ceil(): 올림, floor(): 버림, trunc(): 특정자리수를 잘라내기
-- mod(): 입력받은 수를 나눈 나머지 값 반환
-- power(m,n) m의 n 승을 반환

select -10 from dual;
select -10, abs(-10) from dual;

select kor,eng,kor-eng,abs(kor-eng) from stuscore order by abs(kor-eng) desc;

-- rownum : 조회된 순서대로 순번을 다시 매김
select rownum, name from stuscore;

select rownum, sno, name, total from stuscore where total>=250 and rownum<=10;

-- stuscore 테이블 1-`0까지ㅡㅇ==의 하생ㅇ르추력햇어요
select rownum, a.* from stuscore where rank<=10 order by rank;

select rownum, a.* from  (select * from stuscore where rank<=10 order by rank) a;

-- 국어 점수가 80점 이상인 학생 5명 출력
select rownum, a.* from (
select * from stuscore where kor>=80 order by kor desc
) a where rownum<=5;

select sno, a.* from stuscore a where sno<=5;

-- 국어점수와 영어점수의 차이가 가장 큰 10명의학생을 출력하여라

select rownum, kor, eng, abs(kor-eng) ke from(
select kor, eng, abs(kor-eng) ke from stuscore order by ke desc
) where rownum <= 10;

-- floor() : 버림
select 12.5, floor(12.5) from dual;

-- ceil(): 올림
select 12.1, ceil(12.1) from dual;

-- round(): 반올림 - (m,3) 소수점 3째자리까지 표시
select 12.1257, round(12.1257,3) from dual;
select 34.5678, round(35.5678,-1) from dual;

-- trunc(): 지정한 자리 버림, floor(): 소수점을 제거
select 34.5678, trunc(34.5678,2), trunc(34.5678,-1) from dual;

-- mod(): 나눈 나머지, mod(5,2) -> 5%2 와 같음
select mod(27,2), mod(27,5), mod(27,7) from dual;

-- stuscore sno에서 짝수만 출력하시오
select * from stuscore where mod(sno,2)=0;

-- 시퀀스
-- 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 발생기
select stu_seq.nextval from dual;
select stu_seq.currval from dual;

create sequence s_seq
start with 1 -- 초기값
increment by 1 -- 증가값
minvalue 1 -- 최소값
maxvalue 9999 -- 최대값
nocache
nocycle;

select s_seq.nextval from dual;
select s_seq.currval from dual;

create table board(
bno number(4) primary key, -- 게시글 번호
btitle varchar2(1000),     -- 제목
bcontent clob,             -- 내용 - 대용량 문자 varchar2(무한대)
id varchar2(100),          -- 회원가입 id 연결
bgroup number(4),          -- 답변 달기 부모 그룹
bstep number(4),           -- 답변 달기 순서
bindent number(4),         -- 답변 달기 들여쓰기
bhit number(4),            -- 조회수
bfile varchar2(100),       -- 파일첨부
bdate date                 -- 입력 날짜
);

insert into board values(
board_seq.nextval,'게시글을 등록합니다.','홈페이지를 오픈합니다. 많은 이용바랍니다.',
'aaa',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'이벤트 등록','이벤트를 등록합니다. 꼭 당첨 기대!!',
'bbb',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'아아아','으아아아아아아아아아아',
'ccc',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'안녕하세요','안녕하세용!@!',
'ddd',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'오렌지드링크','내몸사랑과일사랑',
'eee',board_seq.currval,0,0,0,'',sysdate
);

select * from board;
commit;

select * from stuscore;

insert into stuscore values(
stuscore_seq.nextval,'정진아',100,100,99,100+100+99,(100+100+99)/3,0
);

-- delete stuscore where sno in(101,102,103);

-- drop table stuscore3;
-- drop table stuscore4;

------------------------------------------------------

select * from stuscore;

update stuscore set kor=100, total = 100+eng+math, avg = (100+eng+math)/3 where sno = 105;

-- 이름 김 학생을 검색하시오.

select * from stuscore where name like '%김%';

-- 형변환
number, varchar2, char, date
-- 숫자는 사칙연산 가능
select 1+2 from dual;
-- 문자열 숫자는 자동으로 숫자로 변경됨
select 1+'2' from dual;


select 1 + 'a' from dual;

-- 문자는 + -  안됨
-- || contact() 문자열을 더하기 해서 출력
select 'a' + 'b' from dual;

select sysdate - 1,sysdate, sysdate + 1 from dual;

select sysdate from dual;

select sysdate-hire_date from employees;

select hire_date, round(hire_date), to_char(hire_date,'yyyy-mm-dd hh:mi:ss') from employees;

select bdate, to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board;

insert into board values(
board_seq.nextval,'추가 게시글 등록','추가로 게시글을 등록합니다. 당첨부탁드려요.',
'aaa',board_seq.currval,0,0,0,'',sysdate
);

select * from board;
desc board;

select bdate, to_char(bdate,'yyyy-mm-dd hh:mi:ss'), round(bdate,'day') from board;
-- 분을 반올림
select bdate, to_char(bdate,'yyyy-mm-dd hh:mi:ss'), to_char(round(bdate,'mi'),'yyyy-mm-dd hh24:mi:ss') from board;

select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss'), round(mdate,'month') from member;

select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss'), trunc(mdate, 'month') from member;

-- trunc
-- select date, trunc(mdate, 'month');
-----------------------------------------------


-- 현재일 입사일의 개월수 계산
select emp_name, hire_date, sysdate, months_between(sysdate,hire_date) from employees;

select mdate, sysdate, round(months_between(sysdate, mdate))||'개월' from member;

select name, mdate, sysdate, round(months_between(sysdate,mdate)) from member
where round(months_between(sysdate,mdate)) = 4;

substr()
select mdate from member;

select mdate, substr(to_char(mdate),4,3) from member;

select name from stuscore;

select emp_name from employees;

-- emp_name 3번째부터 4개의 글자를 가져와서 출력

select emp_name, substr(emp_name,3,4) from employees;

-- round (달을 기준)
select mdate from member;
select mdate, round(mdate,'month') from member;

-- trunc(달을 기준) 일을 절사
select mdate, trunc(mdate, 'month') from member;

-- round(년을 기준) round(mdate,'year');

select mdate, round(mdate,'year') from member;

-- months_between(두날짜사이의달수를계산)
select sysdate, mdate, sysdate-mdate from member;
select sysdate, mdate, trunc(months_between(sysdate,mdate),1) from member;

-- add_months (날짜에 달을 더해줌)
select sysdate, mdate, add_months(mdate,3)-1 from member;

select sysdate, next_day(sysdate, '화요일') from dual;

-- 마지막 날 찾기
select sysdate, last_day(sysdate) from dual;
select mdate, last_day(mdate) from member;
select hire_date, last_day(hire_date) from employees;

-- 날짜를 문자 타입으로 변경
select sysdate, to_char(sysdate,'yyyy') from dual;
select sysdate, to_number(to_char(sysdate, 'mm')) from dual;

-- member 테이블 5,6,7 회원가입한 회원을 출력하시오
select mdate from member where to_char(mdate, 'mm') in ('05','06','07') order by mdate asc;

-- employees 테이블 hire_date 5,6,7 입사한 사원을 출력하시오
select hire_date from employees where to_char(hire_date, 'mm') in ('05','06','07') order by hire_date asc;

-- mm 숫자월 mom영문 한글월
select sysdate to_char(sysdate,'mon') from dual;
select mdate, to_char(mdate,'mon') from member;

-- day
select mdate, to_char(mdate, 'day') from member;

select * from member;
select mdate, to_char(mdate,'day') from member where to_char(mdate,'day')='일요일';

select bdate, to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board;

-- 숫자타입을 문자타입으로 변경
-- L - 국가 통화 표시 , $ 달러 표시 .-> 소수점을 표시, , -> 천단위 표시 0 -> 공백 0 표시 9-> 공백 공백
select 1230000000, to_char(1230000000, 'L000,999,999,999.9') from dual;

-- salary 달러 표시, 1436 곱해서 원화시와 천단위 표시 소수점 2자리 넣어 출력하시오
select * from employees;

select to_char(salary, '$999,999'), to_char(salary*1436, 'L999,999,999.00') from employees;

-- 날짜형 타입 변환 to_date()
select 20221231, to_date(20221231, 'yyyy-mm-dd') from dual;
select '20221231'-1, to_date('20221231', 'yyyy-mm-dd') from dual;
select '20221231'-1, add_months(to_date('20221231', 'yyyy-mm-dd'),3) from dual;

'09/01/01' 날짜 타입으로 변경해서, 현재 날짜기준으로 몇개월이 지났는지 출력하시오.

-- select '20090101', to_date('20090101','yyyy-mm-dd'), months_between(sysdate, to_date('20090101','yyyy-mm-dd')) from dual;

select sysdate, '09/01/01', months_between(sysdate, '09/01/01')||'개월' from dual;

-- 숫자형 변환 to_number()
select to_number('20,000','999,999')-1 from dual;
select '***,111', replace('***,111','*','0') from dual;
select '20,000', replace('20,000',',','') from dual;
select '20,000', replace('20,000',',','')-1 from dual;

select '    aaa111 111 111      ' from dual;
select trim('    aaa111 111 111      ') from dual;
select replace('    aaa111 111 111      ',' ','')-1 from dual;

to_date() 날짜 변환 : 문자 숫자를 날짜로 변경해서 날짜 형태를 +,- 날짜 함수를 사용해서 계산
to_char() 문자 변환 : 숫자를 문자로 변경해서 천단위, 0표시, 통화표시
to_number() 숫자 변환 : 숫자 사칙연산을 할 수 있는 장점

-- commission_pct 커미션 부분 월급 * 커미션을 더해서 계산
SELECT salary, commission_pct, salary + salary * NVL(commission_pct, 0) AS "실제 월급" FROM employees;

select manager_id from employees;

-- - 10 null
-- ceo null ceo
-- null 0

select manager_id,nvl(manager_id, 0) from employees;
select manager_id,nvl(manager_id, 0), nvl(to_char(manager_id),'CEO') from employees;

--그룹 함수
-- max, min, sum, avg, count, median

select max(salary) from employees;
select min(salary) from employees;
select sum(salary) from employees;
select avg(salary) from employees;
select count(salary) from employees;
select median(salary) from employees;

select count(*) from employees where salary >= (select avg(salary) from employees);

select emp_name, avg(salary) from employees;

select min(salary) from employees;

select * from employees where salary=2100;

select * from employees where salary = (select min(salary) from employees);

select max(salary), min(salary), avg(salary), count(salary), sum(salary) from employees;

부서 번호가 50번인 사원들의 합게를 출력하시오
select sum(salary) from employees where department_id = 50;

select count(*) from employees;
select count(manager_id) from employees;

select manager_id from employees where manager_id is null;
select count(*) from employees where manager_id is null;

-- 문자열 함수
-- initcap, lower, upper
select emp_name from employees;
select emp_name, upper(emp_name), lower(emp_name) from employees;

select name from member;

-- lpad - 자리수 만큼 특정 문자를 대체
select kor,lpad(kor,10,'@') from stuscore;

trim, ltrim, rtrim  빈공백 제거
select '   aaa   aaa   ', ltrim('   aaa   aaa   '), rtrim('   aaa   aaa   '), trim('   aaa   aaa   ') from dual;


-- substr() 해당하는 만큼 문자열을 분리해서 가져옴
select name from stuscore;
select substr(name,2,2) from stuscore;
select substr(name,0,1) from stuscore;

-- replace : 문자열 대채ㅔ
select '111222333aaa', replace('111222333aaa','a','0') from dual;

-- length : 문자열 길이
select kor from stuscore;
select length(kor) from stuscore;
select length(name) from stuscore;

이름 가져오는 마지막 글자만 제외후 출력하시오

select name, substr(name,0,length(name)-1) from stuscore;

create table test(
ch1 char(30),
ch2 varchar2(30)
);

insert into test values(
'12345','12345'
);

select mdate from member;

select trunc(mdate,'month'),mdate, last_day(mdate) from member;

select mdate, to_char(mdate,'mm') from member where to_char(mdate,'mm') = '07';

select * from member;

홍길동 가입일 : 2024년 07월 14일 화요일
select name, '가입일 : '||to_char(mdate,'yyyy')||'년 '||to_char(mdate,'mm')||'월 '||to_char(mdate,'dd')||'일 '||to_char(mdate,'day') from member where name = '홍길동';

select name, to_char(mdate,'"가입일 : "yyyy"년" mm"월" dd"일" day') from member where name = '홍길동';

commit;


