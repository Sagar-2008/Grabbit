CREATE DATABASE IF NOT EXISTS grabbitdb;
USE grabbitdb;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(10) DEFAULT 'user'
);

-- Category table
CREATE TABLE IF NOT EXISTS category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Insert categories
INSERT INTO category (id, name) VALUES
(1, 'Fruits & Vegetables'),
(2, 'Dairy & Bakery'),
(3, 'Beverages'),
(4, 'Snacks & Branded Foods'),
(5, 'Household Items');

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    CONSTRAINT fk_category FOREIGN KEY (category_id)
        REFERENCES category(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Insert products
INSERT INTO products (id, name, description, price, image_url, category_id) VALUES
(1, 'Fresh Apples', 'Juicy red apples rich in fiber.', 120.00, 'https://via.placeholder.com/180x120?text=Apples', 1),
(2, 'Carrots', 'Organic carrots, perfect for snacks.', 45.50, 'https://via.placeholder.com/180x120?text=Carrots', 1),
(3, 'Brown Bread', 'Whole wheat brown bread.', 35.00, 'https://via.placeholder.com/180x120?text=Brown+Bread', 2),
(4, 'Milk 1L', 'Pure cow milk, 1 litre pack.', 55.00, 'https://via.placeholder.com/180x120?text=Milk', 2),
(5, 'Orange Juice', 'Fresh orange juice, 500ml.', 60.00, 'https://via.placeholder.com/180x120?text=Orange+Juice', 3),
(6, 'Cold Coffee', 'Chilled coffee in a can.', 40.00, 'https://via.placeholder.com/180x120?text=Cold+Coffee', 3),
(7, 'Chips', 'Crunchy salted potato chips.', 25.00, 'https://via.placeholder.com/180x120?text=Chips', 4),
(8, 'Chocolate Cookies', 'Delicious chocolate cookies.', 70.00, 'https://via.placeholder.com/180x120?text=Cookies', 4),
(9, 'Dishwash Liquid', 'Lemon dishwash liquid, 500ml.', 85.00, 'https://via.placeholder.com/180x120?text=Dishwash', 5),
(10, 'Floor Cleaner', 'Floral fragrance cleaner.', 110.00, 'https://via.placeholder.com/180x120?text=Cleaner', 5);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DOUBLE,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT fk_user_order FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Order Items table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    CONSTRAINT fk_order FOREIGN KEY (order_id)
        REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
);
