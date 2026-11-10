create table customers (
customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
phone VARCHAR(20),
create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM customers;

INSERT INTO customers (first_name, last_name, email, phone)
VALUES
('Aisha', 'Khumalo', 'aisha3@example.com', '0710000001'),
('Daniel', 'Mokoena', 'daniel2@example.com', '0720000002'),
('Lona','Hans','hans097@gmail.com','0834209946'),
('Andile','Magwaza','andile087@gmail.com','0663162637'),
('Lethabo','Manama','manama@gmail.com','0987654321'),
('Tshepo','Majoro','majoro@gmail.com','1234567890');

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

INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
('Wireless Mouse', 'Wired computer mouse', 249.99, 30),
('Mechanical Keyboard', 'USB electrick keyboard', 899.00, 15),
('USB-C Cable', 'Two metre USB-C cable', 99.50, 50),
('TV','Led TV',1000.00,4),
('Remote','Black remote',23.99,17),
('Lights','Blue light',29.00,9);
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

SELECT customer_id, first_name, last_name
FROM customers
ORDER BY customer_id;

INSERT INTO orders (customer_id, status)
VALUES
(4, 'PAID'),
(6, 'PENDING'),
(7,'CANCELLED'),
(8,'PAID');
SELECT * FROM orders;

SELECT order_id, customer_id, status FROM orders;
SELECT product_id, product_name, price FROM products;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
(7,3,4,99.00),
(8,4,3,249.00),
(9,5,5,899.00),
(10,6,2,99.00);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT * FROM customers;

SELECT first_name, last_name, email
FROM customers;

SELECT
    product_name AS product,
    price AS selling_price
FROM products;

SELECT product_name, price
FROM products
WHERE price > 200;

SELECT product_name, price, stock_quantity
FROM products
WHERE price > 100
  AND stock_quantity >= 20;

SELECT product_name
FROM products
WHERE product_name LIKE '%USB%';

SELECT product_name
FROM products
WHERE product_name ILIKE '%keyboard%';

SELECT order_id, status
FROM orders
WHERE status IN ('PAID', 'SHIPPED');

SELECT product_name, price
FROM products
WHERE price BETWEEN 100 AND 500;

SELECT product_name, price
FROM products
ORDER BY price DESC;

SELECT product_name, price
FROM products
ORDER BY product_name ASC;

SELECT product_name, stock_quantity, price
FROM products
ORDER BY stock_quantity ASC, price DESC;


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
