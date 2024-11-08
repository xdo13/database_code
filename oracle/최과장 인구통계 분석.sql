-- 인구 통계 분석하기
select count(customer_id) 고객수,
       sum(decode(sex_code, 'M', 1, 0))남자,
       sum(decode(sex_code, 'F', 1, 0))여자,
       round(avg(months_between(to_date('20171231','YYYYMMDD'), to_date
       (birth, 'YYYYMMDD'))/12),1) 평균나이,
       round(avg(months_between(to_date('20171231', 'YYYYMMDD'), first_reg_date)),
       1) 평균거래기간 from customer;
       
-- 개인화 분석: 개인별 매출 분석
select a.customer_id 고객아이디,
       a.customer_name 고객이름,
       count(c.order_no) 전체상품주문건수,
       sum(c.sales) 총매출,
       sum(decode(c.item_id, 'M0001', 1, 0)) 전용상품주문건수,
       sum(decode(c.item_id, 'M0001', C.sales, 0)) 전용상품매출
from customer a, reservation b, order_info c
where a.customer_id = b.customer_id
and   b.reserv_no   = c.reserv_no
and   b.cancel      = 'N'
group by a.customer_id, a.customer_name
order by sum(decode(c.item_id, 'M0001', c.sales, 0)) desc;

-- 특징분석: 거주지와 직업의 비율 분석
select b.address_detail 주소, b.zip_code, count(b.address_detail)카운팅
from(
    select distinct a. customer_id, a.zip_code
    from  customer a, reservation b, order_info c
    where a.customer_id = b.customer_id
    and b.reserv_no = c.reserv_no
    and b.cancel = 'N'
    )a, address b
where a.zip_code = b.zip_code
GROUP BY b.address_detail, b.zip_code
order by count(b.address_detail) desc;

-- 상위 고객 분석:상위 10위 고객 찾아내기
select * from
( select a.customer_id,
         a.customer_name,
         sum(c.sales) 전용상품매출,
         row_number() over(partition by c.item_id order by sum(c.sales) desc) 순위
  from customer a, reservation b, order_info c
  where a.customer_id = b.customer_id
  and   b.reserv_no   = c.reserv_no
  and   b.cancel      = 'N'
  and   c.item_id     = 'M0001'
  group by a.customer_id, c.item_id, a.customer_name
  ) a
  where a.순위 <=10
  order by a.순위;
  
  --선호도 분석: 개인별 두 번째 선호 상품 분석
  select * from
  ( select a.고객아이디,
           a.고객이름,
           d.product_name 상품명,
           sum(c.sales) 상품매출,
           rank() over(partition by a.고객아이디 order by sum(c.sales) desc) 선호도순위
           from (
           select a.customer_id   고객아이디,
                  a.customer_name 고객이름,
                  sum(c.sales)    전용상품매출
          from customer a, reservation b, order_info c
          where a.customer_id = b.customer_id
          and b.reserv_no     = c.reserv_no
          and b.cancel        = 'N'
          and c.item_id       = 'M0001'
          group by a.customer_id, a.customer_name
          having sum(c.sales) >= 216000
          )a, reservation b, order_info c, item d
          where a.고객아이디  = b.customer_id
          and   b.reserv_no = c.reserv_no
          and   c.item_id   = d.item_id
          and   d.item_id   <> 'M0001'
          and   b.cancel    = 'N'
          group by a.고객아이디, a.고객이름, d.product_name
          ) a
          where a.선호도순위 = 1;