create table customers (
customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
phone VARCHAR(20),
create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM customers;

create table products (
product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
description TEXT,
price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM products;

CREATE TABLE orders (
order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
customer_id INTEGER NOT NULL,
order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),

CONSTRAINT check_orders_status
CHECK (status IN ('PENDING','PAID','SHIPPED','CANCELLED'))
);
SELECT * FROM orders;

CREATE TABLE order_items (
order_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id INTEGER NOT NULL,
product_id INTEGER NOT NULL,
quantity INTEGER NOT NULL CHECK (quantity > 0),
unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),

CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id),

CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id)
REFERENCES products(product_id),

CONSTRAINT uq_order_product
UNIQUE (order_id, product_id)
);
SELECT * FROM order_items;

--Checkpoint
--Why do we keep customers and orders in separate tables?
--Separating customers and orders into different tables prevents data duplication, ensures accuracy, and avoids anomalies, while customer_id in orders links each order to its customer.

--Why does orders contain customer_id?
-- Customer_id is a foreign key that links each order to its customer.

--What could go wrong if price were stored as text?
-- We would get an error as we specified that we need numerical inputs.

--What does the CHECK (quantity > 0) rule protect against?
--It makes sure thet the quantity column never stores zero or negative values.

--Why does order_items store unit_price?
--The order_items table records the price at the time of the order.