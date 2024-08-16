-- 함수 : 컬럼값 | 지정된값을 읽어 연산한 결과를 반환하는 것

-- 단일행 함수 : N개의 행의 컬럼 값을 전달하여 N개의 결과가 반환

-- 그룹 함수  : N개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
--			  (그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환)

-- 함수는 SELECT절, WHERE절, ORDER BY절
--      GROUP BY절, HAVING절에서 사용 가능



/********************* 단일행 함수 *********************/

-- <문자열 관련 함수>

-- LENGTH(문자열|컬럼명) : 문자열의 길이 반환
SELECT 'HELLO WORLD', LENGTH('HELLO WORLD')
FROM DUAL; -- DUMMY TABLE(가상/가짜 테이블)

-- EMPLOYEE 테이블에서
-- 사원명, 이메일, 이메일 길이 조회
-- 단, 이메일 길이가 12 이하인 행만
-- 이메일 길이 오름차순 조회
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) <= 12
ORDER BY LENGTH(EMAIL) ASC;

--------------------------------------------------------

-- INSTR(문자열 | 컬럼명, '찾을 문자열' [, 찾을 시작 위치 [, 순번]]) 

-- 찾을 시작 위치부터 지정된 순번째 찾은 문자열의 시작 위치를 반환

-- 문자열에서 맨 앞에있는 'B'의 위치를 조회
SELECT 'AABBAACAABBAA', INSTR('AABAACAABBAA', 'B')
FROM DUAL; -- 3 (INDEX 아님, 1부터 시작하는 COUNT 개념)

-- 문자열에서 5번 부터 검색 시작해서 처음 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5)
FROM DUAL; -- 9

-- 문자열에서 5번 부터 검색 시작해서 두번째로 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5, 2)
FROM DUAL; -- 10

----------------------------------------------------

-- SUBSTR(문자열 | 컬럼명, 시작위치 [,길이])

-- 문자열을 시작 위치부터 지정된 길이 만큼 잘라내서 반환
-- 길이 미작성 시 시작 위치 부터 끝까지 잘라내서 반환

-- 시작 위치 + 길이 지정
SELECT SUBSTR('ABCDEFG', 2, 3)
FROM DUAL; -- BCD

-- 시작위치만 지정
SELECT SUBSTR('ABCDEFG', 4)
FROM DUAL; -- DEFG

-- SUBSTR() + INSTR() 같이 사용하기

-- EMPLOYEE 테이블에서 
-- 사원명, 이메일 아이디 (@ 앞에까지 문자열)을
-- 이메일 아이디 오름차순으로 조회
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) "이메일 아이디"
FROM EMPLOYEE
ORDER BY "이메일 아이디" ASC;

--------------------------------------------------------

-- TRIM([ [옵션] 문자열 | 컬럼명 FROM ] 문자열 | 컬럼명)
-- 주어진 문자열의 앞쪽|뒤쪽|양쪽에 존재하는 지정된 문자열을 제거

-- 옵션 : LEADING(앞쪽), TRAILING(뒤쪽), BOTH(양쪽, 기본값)

-- 문자열 앞/뒤/양쪽 공백 제거
SELECT '  기 준  ', 
		TRIM(LEADING ' ' FROM '  기 준  '),
		TRIM(TRAILING ' ' FROM '  기 준  '),
		TRIM(BOTH ' ' FROM '  기 준  ')
FROM DUAL;

-- 문자열 앞/뒤/양쪽 특정 문자 제거
SELECT '##@기 준@##', 
		TRIM(LEADING '#' FROM '##@기 준@##'),
		TRIM(TRAILING '#' FROM '##@기 준@##'),
		TRIM(BOTH '#' FROM '##@기 준@##')
FROM DUAL;

--------------------------------------------------------

-- REPLACE(문자열 | 컬럼명, 찾을 문자열, 바꿀 문자열)
SELECT NATIONAL_NAME, REPLACE(NATIONAL_NAME, '한국', '대한민국')
FROM "NATIONAL"; -- "테이블명" == 이름이 "테이블명"과 같은 테이블

--------------------------------------------------------
--------------------------------------------------------
--------------------------------------------------------

-- <숫자 관련 함수>

-- MOD(숫자 | 컬럼명, 나눌 값) : 결과로 나머지 반환
SELECT MOD(105. 100) FROM DUAL; -- 5

-- ABS(숫자 | 컬럼명) : 절대 값
SELECT ABS(10), ABS(-10) FROM DUAL; -- 10, 10

-- CEIL(숫자 | 컬럼명)  : 올림 -> 정수 형태로 반환
-- FLOOR(숫자 | 컬럼명) : 내림 -> 정수 형태로 반환
SELECT CEIL(1.1), FLOOR(1.9) FROM DUAL; -- 2, 1

-- ROUND(숫자 | 컬럼명 [, 소수점 위치]) : 반올림
-- 소수점 위치 지정 x : 소수점 첫째 자리에서 반올림 -> 정수 표현
-- 소수점 위치 지정 O
 -- 1) 양수 : 지정된 위치의 소수점 자리까지 표현
 -- 2) 음수 : 지정된 위치의 정수 자리까지 표현

SELECT 123.456, 
       ROUND(123.456), -- 123
       ROUND(123.345,0), -- 123 (0이 ROUND 기본값)
       ROUND(123.456,1), -- 123.5
       ROUND(123.456,2), -- 123.46
       ROUND(123.456,-1), -- 120
       ROUND(123.456,-2) -- 100
FROM DUAL;


-- TRUNC(숫자 | 컬럼명 [,소수점 위치]) : 버림 (잘라내기)
SELECT 
	123.456,
	TRUNC(123.456), -- 123
	TRUNC(123.456, 1) -- 123.4  (둘째 자리부터 버림)
FROM DUAL;

-- 버림(TRUNC), 내림(FLOOR) 차이점
SELECT -123.5, TRUNC(-123.5), FLOOR(-123.5)
FROM DUAL;


---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------

-- <날짜 관련 함수>
-- SYSDATE : 현재 시간 (시스템, DB가 설치된 컴퓨터 기준)
-- SYSTIMESTAMP : 현재 시간 (ms 포함, 표준시간대)

-- CURRENT_DATE (접속한 계정)
-- CURRENT_TIMESTAMP
SELECT 
	SYSDATE, SYSTIMESTAMP,
	CURRENT_DATE, CURRENT_TIMESTAMP	
FROM DUAL;


-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜 사이의 개월 수를 반환
--> 반환 값 중 정수 부분은 자이나는 개월 수

SELECT 
	MONTHS_BETWEEN( TO_DATE('2024-09-16', 'YYYY-MM-DD'), 
									CURRENT_DATE)
FROM DUAL; -- 1(달)

-- ** ORACLE은 자료형이 맞지 않은 상황이라도
--    작성된 값의 형태가 요구하는 자료형의 형태를 띄고 있으면
--    자동으로 형변환(PARSING)을 진행한다!!

SELECT
	MONTHS_BETWEEN('2024-12-06', '2024-06-24'),
	(TO_DATE('2024-12-06') - TO_DATE('2024-06-24')) / 30
FROM DUAL; -- 5.42 == 5개월 13일

/* MONTH_BETWEEN이 지정된 두 날짜 사이의 차를 계산할 때 
 * 훨씬 좋다!!(더 정확함)
 * -> 달 마다 길이(28, 29, 30, 31)가 다 다르기 때문에
 *    직접 계산하면 오차가 있을 수 있는데
 *     MONTH-BETWEEN을 이용하면 이런 부분까지 모두
 *    자동으로 적용되어 계산된다!!
 * */

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 입사일, N년차 조회
SELECT EMP_NAME, 
       HIRE_DATE, 
       CEIL(MONTHS_BETWEEN(CURRENT_DATE, HIRE_DATE) / 12)
       || '년차' AS "N년차"
FROM EMPLOYEE;

--------------------------------------------------------------

-- ADD_MONTHS(날짜, 숫자) : 날짜를 숫자만큼의 개월 수를 더하여 반환
SELECT
    CURRENT_DATE,       -- 8/16
    CURRENT_DATE + 31,   -- 9/16
    CURRENT_DATE + 61,   -- 10/16
    ADD_MONTHS(CURRENT_DATE, 1), -- 9/16
    ADD_MONTHS(CURRENT_DATE, 2)  -- 10/16
FROM DUAL;

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 반환
SELECT LAST_DAY(CURRENT_DATE), LAST_DAY('2024-09-01')
FROM DUAL;

-- 다음달 1일, 다음달 말일 조회하기
SELECT LAST_DAY(CURRENT_DATE) + 1 "다음달 1일",
       LAST_DAY(ADD_MONTHS(CURRENT_DATE, 1)) "다음달 말일",
       LAST_DAY(ADD_MONTHS(CURRENT_DATE, 1))
          - LAST_DAY(CURRENT_DATE)
FROM DUAL;

-----------------------------------------------------------

-- EXTRACT(YEAR | MONTH | DAY  FROM  날짜)

-- (EXTRACT : 뽑아내다, 추출하다)

-- 지정된 날짜의 년 | 월 | 일을 추출하여 정수로 반환

SELECT
     EXTRACT(YEAR FROM CURRENT_DATE) 년,
     EXTRACT(MONTH FROM CURRENT_DATE) 월,
     EXTRACT(DAY FROM CURRENT_DATE) 일
FROM DUAL;

-- EMPLOYEE에서
-- 2010년대에 입사한 사원의
-- 사번, 이름, 입사일을 입사일 내림차순으로 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE HIRE_DATE BETWEEN '2010-01-01' AND '2019-12-31'
WHERE EXTRACT(YEAR FROM HIRE_DATE) BETWEEN 2010 AND 2019
ORDER BY HIRE_DATE DESC; -- 10행 조회


------------------------------------------------------------

-- <형변환(Parsing) 함수>

-- 문자열(CHAR, VARCHAR2) <-> 숫자(NUMBER)
-- 문자열(CHAR, VARCHAR2) <-> 날짜(DATE)
-- 숫자(NUMBER) --> 날짜(DATE)


/* TO_CHAR(날짜 | 숫자 [, 포맷]) : 문자열로 변환
 * 
 * 숫자 -> 문자열
 * 포맷 
 * 1) 9 : 숫자 한 칸을 의미, 오른쪽 정렬
 * 2) 0 : 숫자 한 칸을 의미, 오른쪽 정렬, 빈 칸에 0을 추가
 * 3) L : 현재 시스템이나 DB에 설정된 나라의 화폐 기호
 * 4) , : 숫자의 자릿수 구분
 * */

-- 숫자 -> 문자열 변환 확인
SELECT 1234, TO_CHAR(1234) FROM DUAL;

-- 지정된 칸 내부에서 문자열로 변환하기
SELECT 1234, TO_CHAR(1234, '999999999')
FROM DUAL; -- '     1234'

SELECT 1234, TO_CHAR(1234, '000000000')
FROM DUAL; -- '000001234'

/* 숫자 -> 문자열 변환 시 발생할 수 있는 문제 상황 */
--> 지정된 포맷의 칸 수가 변환하려는 숫자 자릿수 보다 적은 경우 
--  모든 숫자가 #으로 변환되서 출력

SELECT 1234, TO_CHAR(1234, '999') -- ####
FROM DUAL;

-- 자릿수 구분(,)
SELECT 123456789, TO_CHAR(123456789, '999,999,999')
FROM DUAL;

-- 화폐 기호 + 자릿수 구분
SELECT 
     123456789, 
     TO_CHAR(123456789, 'L999,999,999'),
     TO_CHAR(123456789, '$999,999,999')
FROM DUAL;

-- 모든 사원의 연봉을
-- \OOO,OOO,OOO으로 조회
SELECT
    EMP_NAME,
    TO_CHAR(SALARY * 12, 'L999,999,999') 연봉
FROM EMPLOYEE;




















