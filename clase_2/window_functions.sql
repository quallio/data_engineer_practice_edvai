EJERCICIO 1

select 
c.category_name,
product_name, 
unit_price,
AVG(unit_price) over (partition by c.category_id) as avg_price_by_category
from products p
join categories c on p.category_id = c.category_id

EJECRCICIO 2

select
avg(od.unit_price * od.quantity) over (partition by customer_id) as avg_order_amount,
o.order_id,
customer_id,
employee_id,
order_date,
required_date
from orders o
join order_details od on o.order_id = od.order_id

EJERCICIO 3

SELECT 
	p.product_name, 
    c.category_name, 
    p.quantity_per_unit, 
    p.unit_price,
    od.quantity,
    AVG(od.quantity) OVER (PARTITION BY c.category_name) AS avg_quantity_by_category
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    order_details od ON p.product_id = od.product_id
order by c.category_name, p.product_name

EJERCICIO 4

select
c.customer_id,
o.order_date,
MIN(o.order_date) over (partition by c.customer_id)
from customers c
join orders o on c.customer_id = o.customer_id

EJECRCICIO 5

select
p.product_id,
p.product_name,
p.unit_price,
p.category_id,
MAX(p.unit_price) over (partition by p.category_id)
from products p

EJERCICIO 6

SELECT 
    p.product_name, 
    SUM(od.quantity) AS total_quantity_sold,
    ROW_NUMBER() OVER (ORDER BY SUM(od.quantity) DESC) AS product_rank
FROM 
    products p
JOIN 
    order_details od ON p.product_id = od.product_id
GROUP BY 
    p.product_name
ORDER BY 
    product_rank;
	
EJERCICIO 7

select
	ROW_NUMBER() OVER (ORDER BY customer_id) AS row_number,
    *
FROM
    customers;
	
EJERCICIO 8

SELECT 
    ROW_NUMBER() OVER (ORDER BY birth_date DESC) AS ranking,
    CONCAT(first_name, ' ', last_name) AS employeename,
    birth_date
FROM 
    employees


??????????????????????????????????????????????????
EJERCICIO 9

select
SUM(od.quantity * od.unit_price),
*
from orders o
JOIN order_details od ON o.order_id = od.order_id


EJERCICIO 10

SELECT 
    c.category_name,
    p.product_name,
    p.unit_price,
    od.quantity,
    (od.quantity * p.unit_price) AS product_sales,
    SUM(od.quantity * p.unit_price) OVER (PARTITION BY c.category_name) AS total_sales_by_category
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    order_details od ON p.product_id = od.product_id
ORDER BY 
    c.category_name, p.product_name


