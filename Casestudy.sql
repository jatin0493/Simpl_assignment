--1.a Write a query to find the first merchant a user transacts on -TRANSACTION_ID,USER_ID,MERCHANT_NAME,TRANSACTION_DATE,AMOUNT 

select MERCHANT_NAME,  TRANSACTION_DATE  
from test_data 
order by TRANSACTION_DATE;

select MERCHANT_NAME from
(select MERCHANT_NAME,  TRANSACTION_DATE  
from test_data 
order by TRANSACTION_DATE) t2 limit 1

-- 1.b Extract count of users who transacted for the first time on a Monday for each merchant

select count(distinct USER_ID)
from
(select USER_ID , MERCHANT_NAME, weekday(min(TRANSACTION_DATE)) wd1, min(TRANSACTION_DATE), hour(min(TRANSACTION_DATE))
from test_data 
group by USER_ID, MERCHANT_NAME
 having wd1 = 0
) t1
where wd1 =0

--2. Write a query to extract alternate rows ordered by date for each user  
   
   -- To get odd row -                                                                                            
  select *, RANK() OVER (ORDER BY payment_date) as my_rank from sakila.test_data order by my_rank;

 select * from (select *, RANK() OVER (ORDER BY payment_date) as my_rank from sakila.test_data order by my_rank) r1
 where my_rank % 2 = 1;
                                                                                                 
     -- to get even row  -
  select *, RANK() OVER (ORDER BY payment_date) as my_rank from sakila.test_data order by my_rank;
                                                                                                 
 select * from (select *, RANK() OVER (ORDER BY payment_date) as my_rank from sakila.test_data order by my_rank) r1
 where my_rank % 2 = 0;                                                                                          
  
--  3 - . Write a query to extract top 25% of users based on amount spent. 
select USER_ID, tot_amt
from
(select USER_ID, sum(amount) tot_amt, rank()over(order by sum(amount) desc) amt_rnk1
from test_data 
group by USER_ID ) t1
where t1.amt_rnk1 <= (select count(distinct USER_ID) * 0.25 from test_data)
;
