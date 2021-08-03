-- Show table schema 
\d+ retail;

-- Q1: Show first 10 rows
select * from retail limit 10;

--Q2: Check # of records
select count(*) from retail r;

--Q3: number of clients (e.g. unique client ID)
select count(distinct customer_id) from retail r ;

--Q4: invoice date range (e.g. max/min dates)
select max(invoice_date), min(invoice_date) from retail r ;

--Q5: number of SKU/merchants (e.g. unique stock code)
select count(distinct stock_code) from retail r ;

--Q6: Calculate average invoice amount excluding invoices with a negative amount (e.g. canceled orders have negative amount)
SELECT count(distinct(stock_code)) FROM retail;
select avg(t.total)
from (SELECT invoice_no, sum(unit_price*quantity) as total FROM retail GROUP BY invoice_no) t
where t.total > 0

--Q7: Calculate total revenue (e.g. sum of unit_price * quantity)
select sum(unit_price*quantity) from retail r ;

--Q8: Calculate total revenue by YYYYMM 
SELECT to_char(invoice_date, 'YYYYMM') as d, sum(unit_price*quantity) FROM retail group by d order by d ASC 

