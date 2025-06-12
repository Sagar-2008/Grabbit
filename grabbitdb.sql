-- GrabbitDB Database Creation Script
-- This script creates the complete database structure and inserts all data

-- Create database
CREATE DATABASE IF NOT EXISTS grabbitdb;
USE grabbitdb;

-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
                       id INT NOT NULL AUTO_INCREMENT,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(100) NOT NULL,
                       role VARCHAR(10) DEFAULT 'user',
                       PRIMARY KEY (id)
);

-- Create category table
CREATE TABLE category (
                          id INT NOT NULL AUTO_INCREMENT,
                          name VARCHAR(50) NOT NULL,
                          PRIMARY KEY (id)
);

-- Create products table
CREATE TABLE products (
                          id INT NOT NULL AUTO_INCREMENT,
                          name VARCHAR(100) NOT NULL,
                          description TEXT,
                          price DECIMAL(10,2) NOT NULL,
                          image_url VARCHAR(1000),
                          category_id INT,
                          PRIMARY KEY (id),
                          FOREIGN KEY (category_id) REFERENCES category(id)
);

-- Insert data into users table
INSERT INTO users (id, username, password, role) VALUES
                                                     (1, 'Sagar', 'SagarSalgar@1234', 'user'),
                                                     (3, 'Admin', 'Admin@1234', 'admin');

-- Insert data into category table
INSERT INTO category (id, name) VALUES
                                    (1, 'Fruits & Vegetables'),
                                    (2, 'Dairy & Bakery'),
                                    (3, 'Beverages'),
                                    (4, 'Snacks & Branded Foods'),
                                    (5, 'Household Items');

-- Insert data into products table
INSERT INTO products (id, name, description, price, image_url, category_id) VALUES
                                                                                (1, 'Fresh Apples', 'Juicy red apples rich in fiber.', 120.00, 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg', 1),
                                                                                (2, 'Carrots', 'Organic carrots, perfect for snacks.', 45.50, 'https://theseedcompany.ca/cdn/shop/files/crop_CARR1923_Carrot___Sweetness_Pelleted_Long.png?v=1720113309&width=1024', 1),
                                                                                (3, 'Brown Bread', 'Whole wheat brown bread.', 35.00, 'https://www.allrecipes.com/thmb/OniK53C6v09aKhrv6TogSevXv30=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/8721666-Copycat-Cheesecake-Factory-Brown-Bread-ddmfs-4x3-ccabd963c6b44b679ce95ff84397703c.jpg', 2),
                                                                                (4, 'Milk 1L', 'Pure cow milk, 1 litre pack.', 55.00, 'https://www.bbassets.com/media/uploads/p/l/306926_4-amul-homogenised-toned-milk.jpg', 2),
                                                                                (5, 'Orange Juice', 'Fresh orange juice, 500ml.', 60.00, 'https://juice9.com/images/product/200mlpaperbox/200ml_orange.webp', 3),
                                                                                (6, 'Cold Coffee', 'Chilled coffee in a can.', 40.00, 'https://cravova.com/cdn/shop/products/IMG_0008.jpg2_53ba1744-afb1-4f00-9d70-aea58537266c_1400x.jpg?v=1646307483', 3),
                                                                                (7, 'Chips', 'Crunchy salted potato chips.', 25.00, 'https://images-cdn.ubuy.co.in/67c1549d8028b20f6e0dde51-lays-classic-potato-chips-8-oz-bag.jpg', 4),
                                                                                (8, 'Chocolate Cookies', 'Delicious chocolate cookies.', 70.00, 'https://m.media-amazon.com/images/I/41Pk14do2GL.jpg', 4),
                                                                                (9, 'Dishwash Liquid', 'Lemon dishwash liquid, 500ml.', 85.00, 'https://ueirorganic.com/cdn/shop/files/organicdishwash.jpg?v=1685621731', 5),
                                                                                (10, 'Floor Cleaner', 'Floral fragrance cleaner.', 110.00, 'https://www.netmeds.com/images/product-v1/600x600/1045847/lizol_disinfectant_surface_floor_cleaner_liquid_lavender_2_litre_416520_0_0.jpg', 5),
                                                                                (11, 'Bananas', 'Fresh ripe bananas rich in potassium.', 48.00, 'https://www.allrecipes.com/thmb/jYmw-0Vijg1E_OuG2yGjEAcdQg4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/ar-new-banana-adobe-ar-4x3-d8f0871e12214350be7ae5575eea4eed.jpg', 1),
                                                                                (12, 'Tomatoes', 'Juicy red tomatoes for cooking.', 30.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm-6QVkNbO5SKS1InuN3riDYtExHP5G1y2qw&s', 1),
                                                                                (13, 'Spinach', 'Fresh green spinach leaves.', 25.00, 'https://gabbarfarms.com/cdn/shop/products/Spinach.jpg?v=1620713074', 1),
                                                                                (14, 'Mangoes', 'Sweet Alphonso mangoes.', 150.00, 'https://5.imimg.com/data5/SELLER/Default/2023/6/318348003/RE/QT/DJ/45117192/fresh-kesar-mango-500x500.jpg', 1),
                                                                                (15, 'Onions', 'Fresh and spicy onions.', 35.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgIxB4TqKd66zyoFXx9QiHPP_bsfzq6xLPHA&s', 1),
                                                                                (16, 'Cucumbers', 'Cool and crunchy cucumbers.', 28.00, 'https://seed2plant.in/cdn/shop/products/saladcucumberseeds.jpg?v=1603435556', 1),
                                                                                (17, 'Butter 100g', 'Creamy dairy butter.', 45.00, 'https://purvanchalmart.com/wp-content/uploads/2024/11/16839818902880-1.jpg', 2),
                                                                                (18, 'Paneer 200g', 'Fresh cottage cheese.', 75.00, 'https://i0.wp.com/nvpmart.in/wp-content/uploads/2022/07/milky-mist-paneer-200-g-pack-product-images-o490006894-p490006894-0-202203170956.jpg?fit=600%2C600&ssl=1', 2),
                                                                                (19, 'Cheese Slices', '10 slices of processed cheese.', 90.00, 'https://dlecta.com/cdn/shop/files/Side_635dac82-341e-4222-aa29-55207c92c3a2.jpg?v=1741767332&width=1080', 2),
                                                                                (20, 'White Bread', 'Soft white sandwich bread.', 30.00, 'https://www.jiomart.com/images/product/original/490007881/english-oven-freshly-baked-milk-sliced-white-bread-400-g-product-images-o490007881-p591190839-0-202208012040.jpg?im=Resize=(1000,1000)', 2),
                                                                                (21, 'Eggs (6 pcs)', 'Farm fresh eggs.', 42.00, 'https://m.media-amazon.com/images/I/714r91-V7XL.jpg', 2),
                                                                                (22, 'Buns (Pack of 2)', 'Soft burger buns.', 25.00, 'https://m.media-amazon.com/images/I/71bT2JDqXML.jpg', 2),
                                                                                (23, 'Mango Juice', 'Refreshing mango drink.', 50.00, 'https://wanabeverage.com/wp-content/uploads/2021/09/mango-300.jpg', 3),
                                                                                (24, 'Lemonade', 'Cool lemon flavored drink.', 35.00, 'https://5.imimg.com/data5/EW/VE/MY-39319845/tropicana-premium-drinks-lemonade-500x500.png', 3),
                                                                                (25, 'Green Tea', 'Antioxidant rich green tea.', 70.00, 'https://5.imimg.com/data5/SELLER/Default/2021/11/CH/OF/OZ/32986075/organic-green-tea-500x500.jpeg', 3),
                                                                                (26, 'Energy Drink', 'Boost your energy.', 90.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMHTBKJDq-VI9UlPjwVYNe_B93Iv9wxGkPg&s', 3),
                                                                                (27, 'Buttermilk', 'Traditional Indian chaas.', 25.00, 'https://img1.exportersindia.com/product_images/bc-full/2023/12/12874023/butter-milk-powder-1703083868-7215301.jpeg', 3),
                                                                                (28, 'Soda Bottle', 'Carbonated soda drink.', 30.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23Fa4noLBvuWZcHNcN-XrAvNciZOV2C91qA&s', 3),
                                                                                (29, 'Nachos', 'Cheesy tortilla chips.', 65.00, 'https://shop.cornitos.in/cdn/shop/files/1_2_1000x1000.jpg?v=1712122933', 4),
                                                                                (30, 'Salted Peanuts', 'Crunchy and salted.', 35.00, 'https://www.haldirams.com/media/catalog/product/cache/71134970afb779eb7860339989626b7e/s/a/salted_peanuts_1.jpg', 4),
                                                                                (31, 'Instant Noodles', 'Ready in 2 minutes.', 20.00, 'https://themintleaves.com/cdn/shop/products/maggi-noodles_9b215303-75e2-429b-a20f-70539a0ac1f3_2048x.jpg?v=1619599708', 4),
                                                                                (32, 'Masala Chips', 'Spicy flavored potato chips.', 30.00, 'https://freshmills.in/cdn/shop/files/organic-masala-potato-chips-happy-leaf-snacks-freshmills-711350.png?v=1718903907', 4),
                                                                                (33, 'Popcorn', 'Microwave butter popcorn.', 40.00, 'https://www.flippedoutfood.com/wp-content/uploads/2022/02/Movie-Theater-Popcorn-featured-720x720.jpg', 4),
                                                                                (34, 'Trail Mix', 'Mixed dry fruits and seeds.', 95.00, 'https://images-cdn.ubuy.co.in/6813552fe042961f43012470-kirkland-signature-trail-mix-4-lb-2.jpg', 4),
                                                                                (35, 'Toilet Cleaner', 'Kills 99.9% germs.', 95.00, 'https://cdn.zeptonow.com/production/ik-seo/tr:w-640,ar-2400-2400,pr-true,f-auto,q-80/cms/product_variant/07b624b5-7737-403a-80f4-2e44420a3730/BAY6-Disinfectant-Toilet-Cleaner.jpeg', 5),
                                                                                (36, 'Garbage Bags', 'Pack of 20 large bags.', 60.00, 'https://easy-flux.in/wp-content/uploads/2019/12/Garbage.jpg', 5),
                                                                                (37, 'Hand Wash', 'Liquid hand soap.', 55.00, 'https://assets.unileversolutions.com/v1/110405810.jpg', 5),
                                                                                (38, 'Detergent Powder', 'For bright and clean clothes.', 110.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVpG9xTl0JgOoXQBcqKVxqcZs-E8VyfLGg6Q&s', 5),
                                                                                (39, 'Room Freshener', 'Jasmine air freshener.', 85.00, 'https://johnphillips.in/cdn/shop/files/Lavender_c1c81206-8799-4f8c-9a5d-d820f98788ad.jpg?v=1695470363', 5),
                                                                                (40, 'Toilet Paper', 'Pack of 4 rolls.', 70.00, 'https://thumbs.dreamstime.com/b/four-roll-toilet-paper-package-white-background-67284530.jpg', 5);

-- Reset AUTO_INCREMENT values to match original data
ALTER TABLE users AUTO_INCREMENT = 4;
ALTER TABLE category AUTO_INCREMENT = 6;
ALTER TABLE products AUTO_INCREMENT = 41;

-- Display confirmation message
SELECT 'Database grabbitdb created successfully!' as Status;
SELECT 'Tables created: users, category, products' as Tables;
SELECT COUNT(*) as 'Total Users' FROM users;
SELECT COUNT(*) as 'Total Categories' FROM category;
SELECT COUNT(*) as 'Total Products' FROM products;