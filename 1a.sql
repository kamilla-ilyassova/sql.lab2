CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER NOT NULL,
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (customer_name, email, phone, address) VALUES
('Kamilla', 'kami05@gmail.com', '87772447252', 'Shukshin 19'),
('Aru', 'aru_askarova@gmail.com', '87772347659', 'Yergozhina 8'),
('Dias', 'ilyassov_d@mail.ru', '87762042690', 'Pushkin 45'),
('Rasul', 'r_letipov@gmail.com', '87072789605', 'Zhetisu-4 1'),
('Damir', 'daamir@gmail.com', '87765043312', 'Zhamakayev 44'),
('Rissam', 'r_letip@gmail.com', '87051092559', 'Ainabulak-3 169'),
('Ruzanna', 'ruza_anna@gmail.com', '87772445670', 'Gorniy Gigant 5'),
('Riana', 'r_nur@gmail.com', '87773447788', 'Seyfullin 12'),
('Amina', 'mina_mina@mail.ru', '87076651255', 'Zhetisu-2 12'),
('Bulat', 'itakov_b@gmail.com', '87771254377', 'Shukshin 18');

INSERT INTO categories (category_name) VALUES
('Clothes'),
('School stuff'),
('Toys'),
('Home Goods'),
('Cosmetics');

INSERT INTO products (product_name, category_id, description) VALUES
('Dress', 1, 's-size beautiful dress'),
('T-shirt', 1, 'basic t-shirt'),
('Book', 2, 'Interesting romance book'),
('Hot Wheels', 3, 'Enjoying car toy'),
('Coffee Maker', 4, 'Multifunctional coffee maker'),
('Foundation', 5, '2n1 Este Lauder fondation'),
('Jeans', 1, 'Stylish blue jeans'),
('Notebook', 2, '24 pages basic notebook'),
('Teddy Bear', 3, 'Cute teddy bear'),
('Vacuum Cleaner', 4, 'Bagless vacuum cleaner');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2019-10-01', 355),
(2, '2024-11-23', 12),
(3, '2023-01-20', 177),
(4, '2024-09-03', 12),
(5, '2024-10-19', 277),
(6, '2020-02-05', 90),
(7, '2022-10-13', 55),
(8, '2024-12-12', 234),
(9, '2024-05-08', 5),
(10, '2024-05-09', 122);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 12, 23500),
(2, 3, 1, 1100),
(3, 5, 1, 10000),
(4, 2, 2, 9990),
(5, 6, 5, 2000),
(6, 7, 1, 2500),
(7, 8, 11, 1750),
(8, 4, 3, 15000),
(9, 9, 5, 2750),
(10, 10, 2, 4000);

WITH order_summary AS (
    SELECT 
        o.order_id,
        c.customer_name,
        o.order_date,
        o.total_amount,
        SUM(oi.quantity) AS total_quantity
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, c.customer_name, o.order_date, o.total_amount
)
SELECT * FROM order_summary;
