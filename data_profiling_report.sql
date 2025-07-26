/* EDA */

/*Frequencies */
/*Calculate the total quantity of products sold for each brand*/

select production.brands.brand_name, sum(sales.order_items.quantity) as total_quantity
from production.brands
inner join production.products
on production.brands.brand_id = production.products.brand_id
inner join sales.order_items
on production.products.product_id = sales.order_items.product_id
group by production.brands.brand_name;


/*Calculate the total quantity of products sold for each category*/
select production.categories.category_name, sum(sales.order_items.quantity) as total_quantity
from production.categories
inner join production.products
on production.categories.category_id = production.products.category_id
inner join sales.order_items
on production.products.product_id = sales.order_items.product_id
group by production.categories.category_name;

/*Retrieve the total number of product units purchased by each customer.*/
select sales.customers.email, sum(sales.order_items.quantity) as purchased_units
from sales.customers
inner join sales.orders
on sales.customers.customer_id = sales.orders.customer_id
inner join sales.order_items
on sales.orders.order_id = sales.order_items.order_id
group by sales.customers.email
order by sum(sales.order_items.quantity) desc;

/*Identify top-performing sales staff based on the total quantity of products they have sold*/
select sales.staffs.email, sum(sales.order_items.quantity) as sold_units
from sales.staffs
inner join sales.orders
on sales.staffs.staff_id = sales.orders.staff_id
inner join sales.order_items
on sales.orders.order_id = sales.order_items.order_id
group by sales.staffs.email
order by sum(sales.order_items.quantity) desc;

select sales.staffs.email, sales.staffs.active
from sales.staffs;

/*посмотреть есть ли такие продаваны которые ничего не продали*/