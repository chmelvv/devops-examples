CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'PENDING'
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL
);


INSERT INTO users (username, email) VALUES
('taras.s', 'taras@example.com'),
('olena_dev', 'olena@example.com'),
('ivan.tester', 'ivan@example.com');

INSERT INTO products (name, price, stock_quantity) VALUES
('Ноутбук Lenovo ThinkPad', 1250.00, 15),
('Бездротова миша Logitech', 45.50, 100),
('Механічна клавіатура Keychron', 120.00, 30),
('Монітор Dell 27"', 350.00, 20);

INSERT INTO orders (user_id, status) VALUES
(1, 'COMPLETED'),
(2, 'PROCESSING'),
(1, 'PENDING');

-- Деталі першого замовлення (Тарас купив ноутбук і мишу)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1250.00),
(1, 2, 1, 45.50);

-- Деталі другого замовлення (Олена купила клавіатуру і монітор)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(2, 3, 1, 120.00),
(2, 4, 1, 350.00);

-- Деталі третього замовлення (Тарас докупив ще одну мишу)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(3, 2, 1, 45.50);