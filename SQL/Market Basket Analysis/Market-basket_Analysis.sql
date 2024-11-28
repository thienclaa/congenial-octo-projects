-- Load datasets into database
LOAD DATA LOCAL INFILE ''
INTO TABLE order_products_prior
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Data Preparation
# Inspect Raw Data
select * from orders;
# See if the specific variable have duplicates
select order_id, COUNT(*) from orders
group by order_id having COUNT(*) >1;
# Check for null values in the column 
select * from orders where days_since_prior_order is Null;
# Check for empty string in the column 
select * from orders where days_since_prior_order = '';
# Delete empty string from the column
delete from orders where days_since_prior_order = '';
# Delete unnecessary column
delete from departments where department_id = 21;

-- Data Exploratory Market Basket

-- Product Analysis
# What products are usually ordered?
with order_products as (
	select order_id, product_id from order_products_prior
    union all
    select order_id, product_id from order_products_train
    )
select p.product_id, p.product_name, count(*) as order_count from order_products op
join products p on p.product_id = op.product_id
group by p.product_id, p.product_name order by order_count desc limit 10;
# What products are usually added to the cart first?
with order_products as (
	select order_id, product_id, add_to_cart_order from order_products_prior
    union all
    select order_id, product_id, add_to_cart_order from order_products_train
    )
select p.product_id, p.product_name, count(*) as cart_count from order_products op
join products p on p.product_id = op.product_id where op.add_to_cart_order = 1
group by p.product_id, p.product_name order by cart_count desc limit 10;
# How many products are usually in the cart?
with order_products as (
	select order_id, count(distinct product_id) as unique_products from order_products_prior group by order_id
    union all
    select order_id, count(distinct product_id) as unique_products from order_products_train group by order_id
    )
select avg(unique_products) as 'Avg Products in Cart' from order_products;
# Which products are usually reordered?
with order_products as (
	select order_id, product_id, reordered from order_products_prior
    union all
    select order_id, product_id, reordered from order_products_train
    )
select p.product_id, p.product_name, count(reordered) as reordered_count from order_products op
join products p on p.product_id = op.product_id where op.reordered = 1
group by p.product_id, p.product_name order by reordered_count desc limit 10;

-- Customer Segmentation Analysis
# Categorize customers on total amount spent on orders?
with customer_spent as (
	select user_id, count(order_id) as total,
    case 
    when count(order_id) >= 70 then 'High' 
    when count(order_id) >= 40 and count(order_id) < 70 then 'Medium' else 'Low' 
    end as spending from orders group by user_id order by total desc
    )
    select spending, count(user_id) from customer_spent
    group by spending order by spending asc;
# Customers who haven't placed an order in the last 30 days?
select count(distinct user_id) as totalcustomer
from (select user_id, max(days_since_prior_order) as max_prior_order from orders group by user_id) as sub_query
where max_prior_order >= 30;

-- Trends Analysis
# What are the most popular day of week to place orders?
select 
case
	when order_dow = 0 then 'Mon'
    when order_dow = 1 then 'Tue'
    when order_dow = 2 then 'Wed'
    when order_dow = 3 then 'Thu'
    when order_dow = 4 then 'Fri'
    when order_dow = 5 then 'Sat'
	when order_dow = 6 then 'Sun'
end as dayofweek,
count(order_id) as totalorder from orders 
group by order_dow order by order_dow asc;
# What are the most popular hours to place orders?
select count(order_id) as totalorder, order_hour_day from orders od
group by order_hour_day order by totalorder desc;
# How often do customers reorder?
select count(order_id) as number_orders, days_since_prior_order from orders
group by days_since_prior_order order by number_orders desc;
# What is the proportion between reordered and newly ordered items?
with order_products as (
	select order_id, reordered, add_to_cart_order from order_products_prior
    union all
    select order_id, reordered, add_to_cart_order from order_products_train
    )
select count(od.order_id) as totalorders, op.reordered from order_products op
join orders od on op.order_id = od.order_id
group by op.reordered
# What are the most popular aisles per products ordered?
with order_products as (
	select order_id, product_id from order_products_prior
    union all
    select order_id, product_id from order_products_train
    )
select count(p.product_id) as product_count, a.aisle from order_products op
join products p on p.product_id = op.product_id
join aisles a on a.aisle_id = p.aisle_id
group by a.aisle order by product_count desc limit 10;
# What are the most popular departments?
with order_products as (
	select order_id, product_id from order_products_prior
    union all
    select order_id, product_id from order_products_train
    )
select count(p.product_id) as product_count, d.department from order_products op
join products p on p.product_id = op.product_id
join departments d on d.department_id = p.department_id
group by d.department order by product_count desc limit 10;

