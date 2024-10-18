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


EJERCICIO 11

SELECT 
    o.ship_country, 
    o.order_id,
    o.freight,
    SUM(o.freight) OVER (PARTITION BY o.ship_country) AS total_shipping_cost_by_country
FROM 
    orders o
ORDER BY 
    o.ship_country ASC, o.order_id ASC;
	

EJERCICIO 12

WITH TotalSales AS (
    SELECT
        c.customer_id,
        c.company_name,
        SUM(od.unit_price * od.quantity) AS total_sales
    FROM
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 
        c.customer_id, c.company_name
)
SELECT
    *,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM
    TotalSales;


EJERCICIO 13

SELECT 
    employee_id,
    first_name || ' ' || last_name AS full_name,
    hire_date,
    RANK() OVER (ORDER BY hire_date ASC) AS hire_rank
FROM 
    employees
	
EJERCICIO 14

select
product_id,
product_name,
unit_price,
RANK() over (order by unit_price desc) as unit_price_rank
from products
	
EJERCICIO 15

select 
od.order_id,
p.product_id,
od.quantity,
LAG(od.quantity, 1) over (order by od.order_id, p.product_id) as prevquantity
from products p
join order_details od on p.product_id = od.product_id


EJERCICIO 16

select
o.order_id,
o.order_date,
o.customer_id,
LAG(o.order_date, 1) over (order by o.customer_id, o.order_date)
from orders o

EJERCICIO 17

SELECT 
product_id, 
product_name, 
unit_price, 
LAG(unit_price, 1) OVER (ORDER BY product_id) AS previous_price,
unit_price - LAG(unit_price, 1) OVER (ORDER BY product_id) AS price_difference
FROM products

EJERCICIO 18

select
product_name,
unit_price,
LEAD(unit_price, 1) over (order by product_id) as nextprice
from products p

EJERCICIO 19

SELECT 
    category_name,
    total_sales_by_category,
    LEAD(total_sales_by_category) OVER (ORDER BY category_name) AS next_total_sales
FROM (
    SELECT 
        c.category_name,
        SUM(od.quantity * od.unit_price) AS total_sales_by_category
    FROM 
        products p
    JOIN 
        categories c ON p.category_id = c.category_id
    JOIN 
        order_details od ON p.product_id = od.product_id
    GROUP BY 
        c.category_name
) AS category_sales