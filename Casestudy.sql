1.a Write a query to find the first merchant a user transacts on -TRANSACTION_ID,USER_ID,MERCHANT_NAME,TRANSACTION_DATE,AMOUNT 

select MERCHANT_NAME,  TRANSACTION_DATE  
from test_data 
order by TRANSACTION_DATE;

select MERCHANT_NAME from
(select MERCHANT_NAME,  TRANSACTION_DATE  
from test_data 
order by TRANSACTION_DATE) t2 limit 1

1.b Extract count of users who transacted for the first time on a Monday for each merchant

Logic - Identify Merchant ID and User ID with day as monday for min payment date. Using Group By (On Merchant ID) calculating user count for each merchant

Query:-
select merchant_id,count(*) from (select merchant_id,user_id,payment_date,dayname(payment_date) from sakila.test_data group by merchant_id,user_id having weekday(min(Payment_DATE)) = 0) as count_User group by merchant_id;


2. Write a query to extract alternate rows ordered by date for each user  

Logic - Rank function is used to extract data from data set. Firstly each row is ranked according to payment date and nested this query within query to find Odd rows using reminder method. ;

Query:-
select user_id,merchant_id, transaction_id, amount, transaction_date from (select *, RANK() OVER (ORDER BY transaction_date ) As my_rank from sakila.test_data order by my_rank) r1 where my_rank % 2 = 1;
 
                                                                                                 
3. Write a query to extract top 25% of users based on amount spent. 

select USER_ID, tot_amt from
(select USER_ID, sum(amount) tot_amt, rank()over(order by sum(amount) desc) amt_rnk1
from test_data group by USER_ID ) t1
where t1.amt_rnk1 <= (select count(distinct USER_ID) * 0.25 from test_data);
