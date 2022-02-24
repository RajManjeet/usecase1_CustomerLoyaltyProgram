create table menu(
 product_id number(5) primary key,
 product_name varchar(2),
 price number(5)
);



insert all
into menu values(1,'sushi',10)
into menu values(2,'curry',15)
into menu values(3,'remen',12)
select * from dual;

CREATE TABLE members
(
customer_id varchar(1) PRIMARY KEY,
join_date timestamp
);

insert into members values ('A','07/01/2021');
insert into members values ('B','09/01/2021');
insert into members values ('C','12/01/2021');

CREATE TABLE sales
(
customer_id varchar(1) REFERENCES members(customer_id),
order_date date,
product_id int REFERENCES menu(product_id)
);

insert into sales values ('A','01/01/2021',1);
insert into sales values ('A','01/01/2021',2);
insert into sales values ('A','07/01/2021',2);
insert into sales values ('A','10/01/2021',3);
insert into sales values ('A','11/01/2021',3);
insert into sales values ('A','11/01/2021',3);
insert into sales values ('B','01/01/2021',2);
insert into sales values ('B','02/01/2021',2);
insert into sales values ('B','01/01/2021',1);
insert into sales values ('B','11/01/2021',1);
insert into sales values ('B','16/01/2021',3);
insert into sales values ('B','01/01/2021',3);
insert into sales values ('C','01/01/2021',3);
insert into sales values ('C','01/01/2021',3);
insert into sales values ('C','07/01/2021',3);

truncate table sales;
INSERT ALL
INTO SALES VALUES ('A',to_date('2021-01-01','YYYY-MM-DD'),1)
INTO SALES VALUES ('A',to_date('2021-01-01','YYYY-MM-DD'),2)
INTO SALES VALUES ('A',to_date('2021-01-07','YYYY-MM-DD'),2)
INTO SALES VALUES ('A',to_date('2021-01-10','YYYY-MM-DD'),3)
INTO SALES VALUES ('A',to_date('2021-01-11','YYYY-MM-DD'),3)
INTO SALES VALUES ('A',to_date('2021-01-11','YYYY-MM-DD'),3)
INTO SALES VALUES ('B',to_date('2021-01-01','YYYY-MM-DD'),2)
INTO SALES VALUES ('B',to_date('2021-01-02','YYYY-MM-DD'),2)
INTO SALES VALUES ('B',to_date('2021-01-04','YYYY-MM-DD'),1)
INTO SALES VALUES ('B',to_date('2021-01-11','YYYY-MM-DD'),1)
INTO SALES VALUES ('B',to_date('2021-01-16','YYYY-MM-DD'),3)
INTO SALES VALUES ('B',to_date('2021-02-01','YYYY-MM-DD'),3)
INTO SALES VALUES ('C',to_date('2021-01-01','YYYY-MM-DD'),3)
INTO SALES VALUES ('C',to_date('2021-01-01','YYYY-MM-DD'),3)
INTO SALES VALUES ('C',to_date('2021-01-07','YYYY-MM-DD'),3)
select * from DUAL;
select * from sales;

--1) What is the total amount each customer spent at the restaurant? 

select s.customer_id, sum(m.price) from 
sales s join menu m on m.product_id = s.product_id group by(s.customer_id);

--2) How many days has each customer visited the restaurant?
select t.customer_id, count(t.No_of_times_visited) as No_of_days_visited from(
select customer_id,order_date, count(order_date) No_of_times_visited from sales group by(customer_id,order_date) order by customer_id) t
group by customer_id order by customer_id;

--3) What was the first item from the menu purchased by each customer? 
select * from sales;
select t.customer_id, m.product_name from
(select s.*, dense_rank() over(order by order_date) as drank from sales s) t 
join menu m on t.product_id = m.product_id where drank=1 order by t.customer_id;

--4) What is the most purchased item on the menu and how many times was it purchased by all
--customers?
select m.product_name, t.times from
(select product_id, count(product_id) as times from sales group by(product_id) 
order by times desc) t join menu m
on t.product_id = m.product_id
where rownum = 1;

--5) Which item was the most popular for each customer? 
select customer_id, product_name, noofproduct from
(
select t.customer_id,m.product_name, t.noofproduct, rank() over(partition by customer_id order by t.customer_id asc ,t.noofproduct desc) as rnk from
(select customer_id, product_id, count(product_id) as noofproduct from sales group by product_id, customer_id order by customer_id asc,noofproduct desc) t
join menu m on t.product_id=m.product_id
) where rnk=1;

--6) Which item was purchased first by the customer after they became a member?
select customer_id, product_id from
(
select t.customer_id, t.order_date, t.product_id, rank() over(partition by customer_id order by order_date) as rnk from(
select s.customer_id, s.order_date, s.product_id from sales s join members m on m.customer_id = s.customer_id 
where s.order_date>=m.join_date order by customer_id asc, order_date asc) t 
) where rnk =1 ;

--7) Which item was purchased just before the customer became a member? 
select s.customer_id, s.order_date, s.product_id from sales s join members m on m.customer_id = s.customer_id 
where s.order_date<m.join_date order by customer_id asc, order_date asc;

--8) What is the total items and amount spent for each member before they became a member?
select customer_id, count(product_id) as no_of_items, sum(price) as total_amount_spent from
(
select t.*, m.price from 
(select s.customer_id, s.order_date, s.product_id from sales s join members m on m.customer_id = s.customer_id 
where s.order_date<m.join_date order by customer_id asc, order_date asc) t join menu m on m.product_id = t.product_id
) group by customer_id;

--9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
with menu_sales as 
(
select * from menu m
inner join sales s
on m.product_id = s.product_id
)
select customer_id, sum(total_spent), sum(rewards) as total_rewards
from(
select customer_id, product_name, total_spent,
  case
    when product_name='curry' then 10*total_spent
    when product_name='remen' then 10*total_spent
    when product_name='sushi' then 20*total_spent
  end as rewards
from(
select customer_id, product_name,sum(price) as total_spent
from menu_sales
group by customer_id, product_name
order by customer_id)
)
group by customer_id
order by customer_id
;



--10) In the first week after a customer joins the program (including their join date) they earn
--2x points on all items, not just sushi - how many points do customer A and B have at the
--end of January?
select customer_id, sum(total_spent*20) as total_points_end_jan from( 
select s.customer_id, m.product_name, sum(m.price) as total_spent
from sales s join menu m on s.product_id=m.product_id
join members mem on mem.customer_id=s.customer_id
where order_date>=join_date and order_date<=join_date+7
and to_char(order_date,'MM')='01'
group by s.customer_id, m.product_name
order by s.customer_id
)group by customer_id order by customer_id;
