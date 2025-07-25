select sales.order_items.quantity, sales.order_items.list_price, sales.order_items.discount,
sales.orders.order_date, sales.orders.required_date, sales.orders.shipped_date,
sales.stores.store_id, sales.stores.store_name, sales.stores.state, sales.stores.city,
sales.staffs.staff_id, sales.staffs.email,
production.products.product_id, production.products.product_name, production.products.model_year,
production.categories.category_name, production.brands.brand_name
from sales.order_items
inner join sales.orders
on sales.order_items.order_id = sales.orders.order_id
inner join sales.stores
on sales.orders.store_id = sales.stores.store_id
inner join sales.staffs
on sales.orders.staff_id = sales.staffs.staff_id
inner join production.products 
on sales.order_items.product_id = production.products.product_id
inner join production.categories 
on production.products.category_id = production.categories.category_id
inner join production.brands
on production.products.brand_id = production.brands.brand_id