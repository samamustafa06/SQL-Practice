-- ============================================================
--  E-COMMERCE STUDY DATABASE  :  ecommerce_db
--  5 tables: customer, category, product, orders, order_item
--  Full schema + data + practice queries
--  Compatible with MySQL Workbench
-- ============================================================

DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- ============================================================
-- 1. TABLES
-- ============================================================

CREATE TABLE category (
    cat_id   INT          PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR(50)  NOT NULL UNIQUE,
    cat_desc VARCHAR(200)
);

CREATE TABLE product (
    prod_id    INT            PRIMARY KEY AUTO_INCREMENT,
    prod_name  VARCHAR(100)   NOT NULL,
    cat_id     INT            NOT NULL,
    price      DECIMAL(10,2)  NOT NULL CHECK (price > 0),
    stock      INT            NOT NULL DEFAULT 0 CHECK (stock >= 0),
    FOREIGN KEY (cat_id) REFERENCES category(cat_id)
);

CREATE TABLE customer (
    cust_id   INT          PRIMARY KEY AUTO_INCREMENT,
    cust_name VARCHAR(100) NOT NULL,
    email     VARCHAR(100) NOT NULL UNIQUE,
    city      VARCHAR(50),
    reg_date  DATE         NOT NULL
);

CREATE TABLE orders (
    order_id    INT          PRIMARY KEY AUTO_INCREMENT,
    cust_id     INT          NOT NULL,
    order_date  DATE         NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'pending'
                             CHECK (status IN ('pending','shipped','delivered','cancelled')),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

CREATE TABLE order_item (
    item_id   INT            PRIMARY KEY AUTO_INCREMENT,
    order_id  INT            NOT NULL,
    prod_id   INT            NOT NULL,
    qty       INT            NOT NULL CHECK (qty > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (prod_id)  REFERENCES product(prod_id)
);

-- ============================================================
-- 2. INSERT DATA
-- ============================================================

INSERT INTO category (cat_name, cat_desc) VALUES
('Electronics',  'Phones, laptops, and gadgets'),
('Clothing',     'Men and women fashion items'),
('Books',        'Academic and fiction books'),
('Home & Garden','Furniture and garden tools'),
('Sports',       'Fitness and outdoor equipment');

INSERT INTO product (prod_name, cat_id, price, stock) VALUES
('Smartphone X12',      1, 4999.99, 30),
('Laptop ProMax',       1, 12500.00, 15),
('Wireless Earbuds',    1,  799.50, 60),
('USB-C Hub',           1,  349.00, 45),
('Men T-Shirt',         2,  149.99, 100),
('Women Jacket',        2,  599.00, 40),
('Jeans Classic',       2,  299.99, 75),
('Python Programming',  3,  250.00, 25),
('Data Structures Book',3,  180.00, 30),
('SQL for Beginners',   3,  120.00, 50),
('Office Chair',        4, 1850.00, 10),
('Standing Desk',       4, 3200.00,  8),
('Yoga Mat',            5,  220.00, 55),
('Dumbbells 10kg',      5,  450.00, 20),
('Running Shoes',       5,  899.00, 35);

INSERT INTO customer (cust_name, email, city, reg_date) VALUES
('Ahmed Ali',      'ahmed@mail.com',  'Cairo',  '2022-03-15'),
('Sara Hassan',    'sara@mail.com',   'Alex',   '2022-07-20'),
('Mohamed Nour',   'mnour@mail.com',  'Asyut',  '2023-01-10'),
('Fatma Khalil',   'fatma@mail.com',  'Cairo',  '2023-04-05'),
('Omar Saad',      'omar@mail.com',   'Giza',   '2023-06-18'),
('Nadia Youssef',  'nadia@mail.com',  'Alex',   '2023-09-01'),
('Khaled Ibrahim', 'khaled@mail.com', 'Asyut',  '2024-01-22'),
('Rania Mostafa',  'rania@mail.com',  'Cairo',  '2024-02-14'),
('Tarek Fouad',    'tarek@mail.com',  'Giza',   '2024-05-30'),
('Dina Ramzy',     'dina@mail.com',   'Luxor',  '2024-08-11');

INSERT INTO orders (cust_id, order_date, status) VALUES
(1,  '2024-01-05', 'delivered'),
(1,  '2024-03-18', 'delivered'),
(2,  '2024-02-10', 'delivered'),
(3,  '2024-03-22', 'shipped'),
(4,  '2024-04-01', 'delivered'),
(4,  '2024-06-15', 'pending'),
(5,  '2024-05-08', 'cancelled'),
(6,  '2024-06-20', 'delivered'),
(7,  '2024-07-11', 'shipped'),
(8,  '2024-08-03', 'delivered'),
(9,  '2024-09-17', 'pending'),
(10, '2024-10-05', 'shipped'),
(2,  '2024-11-01', 'delivered'),
(3,  '2024-11-20', 'pending'),
(1,  '2024-12-02', 'pending');

INSERT INTO order_item (order_id, prod_id, qty, unit_price) VALUES
(1,  1,  1, 4999.99),
(1,  3,  2,  799.50),
(2,  8,  1,  250.00),
(2,  10, 2,  120.00),
(3,  5,  3,  149.99),
(3,  7,  1,  299.99),
(4,  2,  1,12500.00),
(4,  4,  2,  349.00),
(5,  13, 1,  220.00),
(5,  14, 1,  450.00),
(6,  6,  2,  599.00),
(7,  15, 1,  899.00),
(8,  11, 1, 1850.00),
(9,  9,  2,  180.00),
(9,  8,  1,  250.00),
(10, 3,  1,  799.50),
(10, 4,  3,  349.00),
(11, 12, 1, 3200.00),
(12, 5,  4,  149.99),
(12, 6,  1,  599.00),
(13, 1,  1, 4999.99),
(13, 2,  1,12500.00),
(14, 10, 3,  120.00),
(14, 9,  1,  180.00),
(15, 13, 2,  220.00),
(15, 15, 1,  899.00);


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION A : BASIC SELECT QUERIES
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-A01  All products
SELECT * FROM product;

-- Q-A02  Product name and price only
SELECT prod_name, price FROM product;

-- Q-A03  Alias columns
SELECT prod_name AS product, price AS price_EGP FROM product;

-- Q-A04  Customers from Cairo
SELECT * FROM customer WHERE city = 'Cairo';

-- Q-A05  Products priced between 200 and 1000
SELECT * FROM product WHERE price BETWEEN 200 AND 1000;

-- Q-A06  Products NOT in categories 1 or 2
SELECT * FROM product WHERE cat_id NOT IN (1, 2);

-- Q-A07  Products with 'Pro' in the name
SELECT * FROM product WHERE prod_name LIKE '%Pro%';

-- Q-A08  Products with name starting with any 2 chars then 'o'
SELECT * FROM product WHERE prod_name LIKE '__o%';

-- Q-A09  Orders that are NOT delivered
SELECT * FROM orders WHERE status != 'delivered';

-- Q-A10  Customers who registered in 2024
SELECT * FROM customer WHERE YEAR(reg_date) = 2024;

-- Q-A11  Products sorted by price descending
SELECT prod_name, price FROM product ORDER BY price DESC;

-- Q-A12  Top 5 most expensive products
SELECT prod_name, price FROM product ORDER BY price DESC LIMIT 5;

-- Q-A13  Products with low stock (less than 20 units)
SELECT prod_name, stock FROM product WHERE stock < 20;

-- Q-A14  Products with NULL description (categories)
SELECT * FROM category WHERE cat_desc IS NULL;

-- Q-A15  Concatenate customer name + city
SELECT CONCAT(cust_name, ' — ', city) AS customer_info FROM customer;

-- Q-A16  Orders in 2024 Q4 (Oct–Dec)
SELECT * FROM orders
WHERE order_date BETWEEN '2024-10-01' AND '2024-12-31';


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION B : CASE EXPRESSION
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-B01  Label products by price range
SELECT prod_name, price,
  CASE
    WHEN price >= 5000  THEN 'Premium'
    WHEN price >= 1000  THEN 'Mid-Range'
    WHEN price >= 300   THEN 'Budget'
    ELSE                     'Economy'
  END AS price_tier
FROM product
ORDER BY price DESC;

-- Q-B02  Label order status in Arabic-style labels
SELECT order_id, status,
  CASE status
    WHEN 'delivered'  THEN 'Delivered'
    WHEN 'shipped'    THEN 'On the Way'
    WHEN 'pending'    THEN 'Pending'
    WHEN 'cancelled'  THEN 'Cancelled'
  END AS status_label
FROM orders;

-- Q-B03  Stock health label
SELECT prod_name, stock,
  CASE
    WHEN stock = 0      THEN 'Out of Stock'
    WHEN stock < 15     THEN 'Low Stock'
    WHEN stock < 40     THEN 'Normal'
    ELSE                     'Well Stocked'
  END AS stock_status
FROM product;


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION C : AGGREGATE FUNCTIONS
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-C01  Total products, avg price, max price, min price
SELECT COUNT(*)       AS total_products,
       ROUND(AVG(price),2) AS avg_price,
       MAX(price)     AS max_price,
       MIN(price)     AS min_price
FROM product;

-- Q-C02  Product count per category
SELECT cat_id, COUNT(*) AS num_products
FROM product
GROUP BY cat_id
ORDER BY num_products DESC;

-- Q-C03  Category name + product count (with JOIN)
SELECT c.cat_name, COUNT(p.prod_id) AS num_products
FROM category c
LEFT JOIN product p ON c.cat_id = p.cat_id
GROUP BY c.cat_id, c.cat_name
ORDER BY num_products DESC;

-- Q-C04  Total stock value per category (price × stock)
SELECT c.cat_name,
       SUM(p.price * p.stock) AS total_stock_value
FROM category c
JOIN product p ON c.cat_id = p.cat_id
GROUP BY c.cat_id, c.cat_name
ORDER BY total_stock_value DESC;

-- Q-C05  Number of orders per customer
SELECT cust_id, COUNT(*) AS order_count
FROM orders
GROUP BY cust_id
ORDER BY order_count DESC;

-- Q-C06  Customers with more than 1 order (HAVING)
SELECT cust_id, COUNT(*) AS order_count
FROM orders
GROUP BY cust_id
HAVING order_count > 1;

-- Q-C07  Order count per status
SELECT status, COUNT(*) AS cnt
FROM orders
GROUP BY status
ORDER BY cnt DESC;

-- Q-C08  Revenue per order (SUM of qty * unit_price)
SELECT order_id,
       SUM(qty * unit_price) AS order_total
FROM order_item
GROUP BY order_id
ORDER BY order_total DESC;

-- Q-C09  Total revenue across all orders
SELECT SUM(qty * unit_price) AS total_revenue
FROM order_item;

-- Q-C10  Average order value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT order_id, SUM(qty * unit_price) AS order_total
    FROM order_item
    GROUP BY order_id
) AS order_totals;

-- Q-C11  Top selling product by total qty sold
SELECT prod_id, SUM(qty) AS total_sold
FROM order_item
GROUP BY prod_id
ORDER BY total_sold DESC
LIMIT 5;


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION D : DATE FUNCTIONS
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-D01  Current date functions
SELECT NOW(), CURDATE(), CURTIME();

-- Q-D02  Extract parts from order_date
SELECT order_id,
       order_date,
       YEAR(order_date)      AS yr,
       MONTH(order_date)     AS mo,
       MONTHNAME(order_date) AS mo_name,
       DAYNAME(order_date)   AS day_name
FROM orders;

-- Q-D03  Days since each customer registered
SELECT cust_name,
       reg_date,
       DATEDIFF(CURDATE(), reg_date) AS days_since_reg
FROM customer
ORDER BY days_since_reg DESC;

-- Q-D04  Customers who registered more than 1 year ago
SELECT cust_name, reg_date
FROM customer
WHERE DATEDIFF(CURDATE(), reg_date) > 365;

-- Q-D05  Orders placed in 2024, grouped by month
SELECT MONTH(order_date) AS month_num,
       MONTHNAME(order_date) AS month_name,
       COUNT(*) AS order_count
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_num;

-- Q-D06  Add 30 days to each order_date (estimated delivery)
SELECT order_id, order_date,
       DATE_ADD(order_date, INTERVAL 30 DAY) AS estimated_delivery
FROM orders
WHERE status = 'pending';

-- Q-D07  Orders placed in the last 6 months
SELECT * FROM orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION E : SET OPERATIONS
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-E01  UNION – customers from Cairo OR Alex (distinct)
SELECT cust_id, cust_name, city FROM customer WHERE city = 'Cairo'
UNION
SELECT cust_id, cust_name, city FROM customer WHERE city = 'Alex';

-- Q-E02  UNION ALL – same but keep all rows
SELECT cust_id, cust_name, city FROM customer WHERE city = 'Cairo'
UNION ALL
SELECT cust_id, cust_name, city FROM customer WHERE city = 'Alex';

-- Q-E03  INTERSECT – product IDs that are both Electronics AND have stock > 20
SELECT prod_id FROM product WHERE cat_id = 1
INTERSECT
SELECT prod_id FROM product WHERE stock > 20;

-- Q-E04  EXCEPT – customers who placed orders but have NO delivered order
SELECT cust_id FROM orders
EXCEPT
SELECT cust_id FROM orders WHERE status = 'delivered';

-- Q-E05  UNION for reporting – combine cities from customer + 'Online' label
SELECT city AS location FROM customer WHERE city IS NOT NULL
UNION
SELECT 'Online' AS location;


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION F : SUBQUERIES
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-F01  IN – customers who placed at least one order
SELECT cust_id, cust_name
FROM customer
WHERE cust_id IN (SELECT cust_id FROM orders);

-- Q-F02  NOT IN – customers who have NEVER placed an order
SELECT cust_id, cust_name
FROM customer
WHERE cust_id NOT IN (SELECT cust_id FROM orders);

-- Q-F03  IN with condition – customers with at least one delivered order
SELECT cust_id, cust_name
FROM customer
WHERE cust_id IN (
    SELECT cust_id FROM orders WHERE status = 'delivered'
);

-- Q-F04  Scalar – products priced above average
SELECT prod_name, price
FROM product
WHERE price > (SELECT AVG(price) FROM product)
ORDER BY price DESC;

-- Q-F05  ALL – most expensive product(s)
SELECT prod_name, price
FROM product
WHERE price >= ALL (SELECT price FROM product);

-- Q-F06  ANY – products cheaper than at least one Electronics product
SELECT prod_name, price
FROM product
WHERE price < ANY (
    SELECT price FROM product WHERE cat_id = 1
);

-- Q-F07  EXISTS – customers who have a pending order
SELECT cust_name, email
FROM customer c
WHERE EXISTS (
    SELECT * FROM orders o
    WHERE o.cust_id = c.cust_id
      AND o.status = 'pending'
);

-- Q-F08  NOT EXISTS – customers with no pending orders
SELECT cust_name, email
FROM customer c
WHERE NOT EXISTS (
    SELECT * FROM orders o
    WHERE o.cust_id = c.cust_id
      AND o.status = 'pending'
);

-- Q-F09  Subquery in FROM – avg revenue per order then filter
SELECT cust_id, order_total
FROM (
    SELECT o.cust_id,
           SUM(oi.qty * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY o.cust_id
) AS cust_revenue
WHERE order_total > 5000
ORDER BY order_total DESC;

-- Q-F10  Products never ordered
SELECT prod_id, prod_name
FROM product
WHERE prod_id NOT IN (SELECT DISTINCT prod_id FROM order_item);


-- ============================================================
-- ██████████████████████████████████████████████████████████
--  SECTION G : JOINS
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-G01  INNER JOIN – product name with its category name
SELECT p.prod_name, c.cat_name, p.price
FROM product p
INNER JOIN category c ON p.cat_id = c.cat_id;

-- Q-G02  INNER JOIN – order details with customer name
SELECT o.order_id, cu.cust_name, o.order_date, o.status
FROM orders o
INNER JOIN customer cu ON o.cust_id = cu.cust_id;

-- Q-G03  LEFT JOIN – all categories even if they have no products
SELECT c.cat_name, COUNT(p.prod_id) AS prod_count
FROM category c
LEFT JOIN product p ON c.cat_id = p.cat_id
GROUP BY c.cat_id, c.cat_name;

-- Q-G04  LEFT JOIN – customers with no orders (NULL order_id)
SELECT cu.cust_name, o.order_id
FROM customer cu
LEFT JOIN orders o ON cu.cust_id = o.cust_id
WHERE o.order_id IS NULL;

-- Q-G05  3-table JOIN – full order line detail
SELECT cu.cust_name,
       o.order_id,
       o.order_date,
       p.prod_name,
       oi.qty,
       oi.unit_price,
       (oi.qty * oi.unit_price) AS line_total
FROM customer cu
JOIN orders     o  ON cu.cust_id = o.cust_id
JOIN order_item oi ON o.order_id  = oi.order_id
JOIN product    p  ON p.prod_id   = oi.prod_id
ORDER BY o.order_id, p.prod_name;

-- Q-G06  4-table JOIN – full detail with category
SELECT cu.cust_name, c.cat_name, p.prod_name,
       oi.qty, oi.unit_price,
       (oi.qty * oi.unit_price) AS line_total,
       o.status
FROM customer  cu
JOIN orders     o  ON cu.cust_id = o.cust_id
JOIN order_item oi ON o.order_id  = oi.order_id
JOIN product    p  ON p.prod_id   = oi.prod_id
JOIN category   c  ON c.cat_id    = p.cat_id
ORDER BY cu.cust_name;

-- Q-G07  JOIN + GROUP – total spent per customer
SELECT cu.cust_name,
       COUNT(DISTINCT o.order_id)          AS num_orders,
       SUM(oi.qty * oi.unit_price)         AS total_spent
FROM customer cu
JOIN orders     o  ON cu.cust_id = o.cust_id
JOIN order_item oi ON o.order_id  = oi.order_id
GROUP BY cu.cust_id, cu.cust_name
ORDER BY total_spent DESC;

-- Q-G08  JOIN + GROUP + HAVING – big spenders (> 10000 total)
SELECT cu.cust_name,
       SUM(oi.qty * oi.unit_price) AS total_spent
FROM customer cu
JOIN orders     o  ON cu.cust_id = o.cust_id
JOIN order_item oi ON o.order_id  = oi.order_id
GROUP BY cu.cust_id, cu.cust_name
HAVING total_spent > 10000
ORDER BY total_spent DESC;

-- Q-G09  JOIN + category revenue breakdown
SELECT c.cat_name,
       SUM(oi.qty * oi.unit_price) AS revenue
FROM category c
JOIN product    p  ON c.cat_id   = p.cat_id
JOIN order_item oi ON p.prod_id  = oi.prod_id
GROUP BY c.cat_id, c.cat_name
ORDER BY revenue DESC;

-- Q-G10  RIGHT JOIN – all products even if never ordered
SELECT p.prod_name, oi.order_id, oi.qty
FROM order_item oi
RIGHT JOIN product p ON p.prod_id = oi.prod_id
ORDER BY oi.order_id IS NULL DESC, p.prod_name;
-- ██████████████████████████████████████████████████████████
--  SECTION I : MIXED CHALLENGE QUERIES
-- ██████████████████████████████████████████████████████████
-- ============================================================

-- Q-I01  Monthly revenue in 2024
SELECT MONTH(o.order_date)     AS month_num,
       MONTHNAME(o.order_date) AS month_name,
       SUM(oi.qty * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = 2024
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY month_num;



-- Q-I03  Products low on stock + their category
SELECT c.cat_name, p.prod_name, p.stock
FROM product p
JOIN category c ON p.cat_id = c.cat_id
WHERE p.stock < 20
ORDER BY p.stock ASC;



-- Q-I05  Category with highest number of distinct products ordered
SELECT c.cat_name, COUNT(DISTINCT oi.prod_id) AS distinct_prods_sold
FROM category c
JOIN product    p  ON c.cat_id  = p.cat_id
JOIN order_item oi ON p.prod_id = oi.prod_id
GROUP BY c.cat_id, c.cat_name
ORDER BY distinct_prods_sold DESC
LIMIT 1;

-- Q-I06  Reorder report: products with stock < 20 that were ordered
SELECT p.prod_name, p.stock,
       SUM(oi.qty) AS total_ordered_qty
FROM product p
JOIN order_item oi ON p.prod_id = oi.prod_id
WHERE p.stock < 20
GROUP BY p.prod_id, p.prod_name, p.stock
ORDER BY p.stock ASC;


