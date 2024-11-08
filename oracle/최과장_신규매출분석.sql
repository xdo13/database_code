@C:\Users\04-07\Downloads\모두의SQL\sql_practice\create_table.sql;

@C:\Users\04-07\Downloads\모두의SQL\sql_practice\1.address.sql;

@C:\Users\04-07\Downloads\모두의SQL\sql_practice\2.customer.sql;

@C:\Users\04-07\Downloads\모두의SQL\sql_practice\3.item.sql;

@C:\Users\04-07\Downloads\모두의SQL\sql_practice\4.reservation.sql;

@C:\Users\04-07\Downloads\모두의SQL\sql_practice\5.order_info.sql;

select * from order_info;

select count(*)     전체주문건,
       sum(B.sales) 총매출,
       avg(b.sales) 평균매출,
       max(b.sales) 최고매출,
       min(b.sales) 최저매출
from reservation a, order_info b
where a.reserv_no = b.reserv_no;

select count(*) 총판매량,

    sum(B.sales) 총매출,
    sum(decode(B.item_id, 'M0001', 1, 0)) 전용상품판매량,
    sum(decode(B.item_id, 'M0001', B.sales, 0)) 전용상품매출
    
from reservation A, order_info B
where a.reserv_no = b.reserv_no
and a.cancel = 'N';

select c.item_id 상품아이디,
       c.product_name 상품이름,
       sum(b.sales) 상품매출
from reservation a, order_info b, item c
where a.reserv_no = b.reserv_no
and   b.item_id   = c.item_id
and   a.cancel    = 'N'
group by c.item_id, c.product_name
order by sum(b.sales) desc;

select substr(a.reserv_date, 1, 6) 매출월,
       sum(decode(b.item_id, 'M0001', b.sales, 0)) special_set,
       sum(decode(b.item_id, 'M0002', b.sales, 0)) pasta,
       sum(decode(b.item_id, 'M0003', b.sales, 0)) pizza,
       sum(decode(b.item_id, 'M0004', b.sales, 0)) sea_food,
       sum(decode(b.item_id, 'M0005', b.sales, 0)) steak,
       sum(decode(b.item_id, 'M0006', b.sales, 0)) salad_bar,
       sum(decode(b.item_id, 'M0007', b.sales, 0)) salad,
       sum(decode(b.item_id, 'M0008', b.sales, 0)) sandwich,
       sum(decode(b.item_id, 'M0009', b.sales, 0)) wine,
       sum(decode(b.item_id, 'M0010', b.sales, 0)) juice
from reservation a, order_info b
where a.reserv_no = b.reserv_no
and a.cancel = 'N'
group by substr(a.reserv_date, 1, 6)
order by substr(a.reserv_date, 1, 6);

select substr(a.reserv_date, 1, 6) 매출월,
       sum(b.sales) 총매출,
       sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출
from reservation a, order_info b
where a.reserv_no = b.reserv_no
and   a.cancel    = 'N'
group by substr(a.reserv_date, 1, 6)
order by substr(a.reserv_date, 1, 6);

-- 외부 조인: 부족한 데이터 처리
select substr(a.reserv_date, 1, 6) 매출월,
       sum(b.sales) 총매출,
       sum(b.sales)
       - sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
       sum(decode(b.item_id, 'M0001', b.sales, 0))전용상품매출,
       round(sum(decode(b.item_id, 'M0001', b.sales, 0))/sum(b.sales)*100, 1) 매출기여율,
       count(a.reserv_no) 총예약건,
       sum(decode(a.cancel, 'N', 1, 0)) 예약완료건,
       sum(decode(a.cancel, 'Y', 1, 0)) 예약취소건
from reservation a, order_info b
where a.reserv_no = b.reserv_no
group by substr(a.reserv_date, 1, 6)
order by substr(a.reserv_date, 1, 6);

-- 데이터처리 : 날짜 가공하기, 문자 붙이기
select substr(a.reserv_date, 1, 6) 매출월,
       sum(b.sales) 총매출,
       sum(b.sales)
       - sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
       sum(decode(b.item_id, 'M0001', b.sales, 0))전용상품매출,
       round(sum(decode(b.item_id, 'M0001', b.sales, 0))/sum(b.sales)*100, 1) ||'%' 전용상품판매율,
       count(a.reserv_no) 총예약건,
       sum(decode(a.cancel, 'N', 1, 0)) 예약완료건,
       sum(decode(a.cancel, 'Y', 1, 0)) 예약취소건,
       round(sum(decode(a.cancel, 'Y', 1, 0))/count(a.reserv_no)*100,1) || '%' 예약취소율
       from reservation a, order_info b
       where a.reserv_no = b.reserv_no
       group by substr(a.reserv_date, 1, 6)
       order by substr(a.reserv_date, 1, 6);
       
   -- 요일별 매출 분석: 날짜 처리하기
   select substr(reserv_date, 1, 6) 날짜,
            a.product_name 상품명,
            sum(decode(a.week, '1', a.sales, 0)) 일요일,
            sum(decode(a.week, '2', a.sales, 0)) 월요일,
            sum(decode(a.week, '3', a.sales, 0)) 화요일,
            sum(decode(a.week, '4', a.sales, 0)) 수요일,
            sum(decode(a.week, '5', a.sales, 0)) 목요일,
            sum(decode(a.week, '6', a.sales, 0)) 금요일,
            sum(decode(a.week, '7', a.sales, 0)) 토요일
    from
          (
            select a.reserv_date,
                   c.product_name,
                   to_char(to_date(a.reserv_date, 'YYYYMMDD'),'d') week,
                   b.sales
            from reservation a, order_info b, item c
            where a.reserv_no = b.reserv_no
            and   b.item_id   = c.item_id
            and   b.item_id   = 'M0001'
            ) a
    group by substr(reserv_date, 1, 6), a.product_name
    order by substr(reserv_date, 1, 6);
        
-- 순위 분석: 월별 전용 상품 최대 실적 지점 확인하기
select * from
(
 select substr(a.reserv_date, 1, 6) 매출월,
        a.branch                    지점,
        sum(b.sales)                전용상품매출,
        rank() over(partition by substr(a.reserv_date, 1, 6)
 order by sum(b.sales) desc) 지점순위
 from reservation a, order_info b
 where a.reserv_no = b.reserv_no
 and   a.cancel    = 'N'
 and   b.item_id   = 'M0001'
 group by substr(a.reserv_date, 1, 6), a.branch
 order by substr(a.reserv_date, 1, 6)
 )a
 where a.지점순위 <=3;
 
 -- 1위 지점만 한눈에 보기
 select * from
(
 select substr(a.reserv_date, 1, 6) 매출월,
        a.branch                    지점,
        sum(b.sales)                전용상품매출,
        row_number() over(partition by substr(a.reserv_date, 1, 6)
 order by sum(b.sales) desc) 지점순위,
 decode(a.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')지점등급
 from reservation a, order_info b
 where a.reserv_no = b.reserv_no
 and   a.cancel    = 'N'
 and   b.item_id   = 'M0001'
 group by substr(a.reserv_date, 1, 6), a.branch,
        decode(a.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
        order by substr(a.reserv_date, 1, 6)
 )a
 where a.지점순위 =1;
 
 --종합 리포트 만들기
 select a.매출월                  매출월,
        Max(총매출)               총매출,
        Max(전용상품외매출)        전용상품외매출,
        Max(전용상품매출)          전용상품매출,
        Max(전용상품판매율)        전용상품판매율,
        Max(총예약건)             총예약건,
        Max(예약완료건)           예약완료건,
        Max(예약취소건)           예약취소건,
        Max(예약취소율)           예약취소율,
        Max(최대매출지점)          최대매출지점,
        Max(지점매출액)            지점매출액
from
(
    select substr(a.reserv_date, 1, 6) 매출월,
    sum(b.sales) 총매출,
    sum(b.sales)
    - sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출,
    round(sum(decode(b.item_id, 'M0001', b.sales, 0))/sum(b.sales)*100,1)||'%' 전용상품판매율,
    count(a.reserv_no)총예약건,
    sum(decode(a.cancel, 'N', 1, 0)) 예약완료건,
    sum(decode(a.cancel, 'Y', 1, 0)) 예약취소건,
    round(sum(decode(a.cancel, 'Y', 1, 0))/count(a.reserv_no)*100, 1)||'%'예약취소율,
    '' 최대매출지점,
    0  지점매출액
    from reservation a, order_info b
    where a.reserv_no = b.reserv_no(+)
    group by substr(a.reserv_date, 1, 6), '', 0
    union
        select a.매출월,
        0 총매출,
        0 전용상품외매출,
        0 전용상품매출,
        '' 전용상품판매율,
        0 총예약건,
        0 예약완료건,
        0 예약취소건,
        '' 예약취소율,
        A.지점 최대매출지점,
        A.전용상품매출 지점매출액
    from
    (
    select substr(a.reserv_date, 1, 6) 매출월,
           a.branch                    지점,
           sum(b.sales)                전용상품매출,
           row_number() over(partition by substr(a.reserv_date, 1, 6)
    order by sum(b.sales) desc) 지점순위,
           decode(a.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')지점등급
    from reservation a, order_info b
    where a.reserv_no = b.reserv_no
    and   a.cancel = 'N'
    and   b.item_id = 'M0001'
    group by substr (a.reserv_date, 1, 6), a.branch,
    decode(a.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
    order by substr(a.reserv_date, 1, 6)
    ) a
    where a.지점순위 = 1
    ) a
    group by a.매출월
    order by a.매출월;
    
    
    