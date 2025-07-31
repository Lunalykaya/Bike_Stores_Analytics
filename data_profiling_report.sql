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

/*After identifying top-performing staff, I noticed some staff had no sales at all.
  To include them in the results, I use LEFT JOIN and COALESCE to show zero sales.*/

select sales.staffs.staff_id, coalesce(sum(sales.order_items.quantity), 0) as sold_units, sales.staffs.manager_id, sales.staffs.active, sales.staffs.first_name, sales.staffs.last_name, sales.staffs.store_id, sales.stores.store_name 
from sales.staffs
left join sales.orders
on sales.staffs.staff_id = sales.orders.staff_id
left join sales.order_items
on sales.orders.order_id = sales.order_items.order_id
inner join sales.stores
on sales.staffs.store_id = sales.stores.store_id
group by sales.staffs.staff_id, sales.staffs.manager_id, sales.staffs.active, sales.staffs.first_name, sales.staffs.last_name, sales.staffs.store_id, sales.staffs.first_name, sales.staffs.last_name, sales.staffs.store_id, sales.stores.store_name 
order by sum(sales.order_items.quantity) 

/*stores*/
select s.store_id, s.store_name, s.city, COALESCE(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 0) as total_revenue
from sales.stores s
left join sales.orders o on s.store_id = o.store_id
left join sales.order_items oi on o.order_id = oi.order_id
group by s.store_id, s.store_name, s.city
order by total_revenue desc;
