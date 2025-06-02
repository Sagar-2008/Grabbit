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
INSERT INTO products (name, description, price, image_url, category_id) VALUES
                                                                            ('Bananas', 'Fresh ripe bananas rich in potassium.', 48.00, 'https://via.placeholder.com/180x120?text=Bananas', 1),
                                                                            ('Tomatoes', 'Juicy red tomatoes for cooking.', 30.00, 'https://via.placeholder.com/180x120?text=Tomatoes', 1),
                                                                            ('Spinach', 'Fresh green spinach leaves.', 25.00, 'https://via.placeholder.com/180x120?text=Spinach', 1),
                                                                            ('Mangoes', 'Sweet Alphonso mangoes.', 150.00, 'https://via.placeholder.com/180x120?text=Mangoes', 1),
                                                                            ('Onions', 'Fresh and spicy onions.', 35.00, 'https://via.placeholder.com/180x120?text=Onions', 1),
                                                                            ('Cucumbers', 'Cool and crunchy cucumbers.', 28.00, 'https://via.placeholder.com/180x120?text=Cucumbers', 1);
INSERT INTO products (name, description, price, image_url, category_id) VALUES
                                                                            ('Butter 100g', 'Creamy dairy butter.', 45.00, 'https://via.placeholder.com/180x120?text=Butter', 2),
                                                                            ('Paneer 200g', 'Fresh cottage cheese.', 75.00, 'https://via.placeholder.com/180x120?text=Paneer', 2),
                                                                            ('Cheese Slices', '10 slices of processed cheese.', 90.00, 'https://via.placeholder.com/180x120?text=Cheese+Slices', 2),
                                                                            ('White Bread', 'Soft white sandwich bread.', 30.00, 'https://via.placeholder.com/180x120?text=White+Bread', 2),
                                                                            ('Eggs (6 pcs)', 'Farm fresh eggs.', 42.00, 'https://via.placeholder.com/180x120?text=Eggs', 2),
                                                                            ('Buns (Pack of 2)', 'Soft burger buns.', 25.00, 'https://via.placeholder.com/180x120?text=Buns', 2);
INSERT INTO products (name, description, price, image_url, category_id) VALUES
                                                                            ('Mango Juice', 'Refreshing mango drink.', 50.00, 'https://via.placeholder.com/180x120?text=Mango+Juice', 3),
                                                                            ('Lemonade', 'Cool lemon flavored drink.', 35.00, 'https://via.placeholder.com/180x120?text=Lemonade', 3),
                                                                            ('Green Tea', 'Antioxidant rich green tea.', 70.00, 'https://via.placeholder.com/180x120?text=Green+Tea', 3),
                                                                            ('Energy Drink', 'Boost your energy.', 90.00, 'https://via.placeholder.com/180x120?text=Energy+Drink', 3),
                                                                            ('Buttermilk', 'Traditional Indian chaas.', 25.00, 'https://via.placeholder.com/180x120?text=Buttermilk', 3),
                                                                            ('Soda Bottle', 'Carbonated soda drink.', 30.00, 'https://via.placeholder.com/180x120?text=Soda', 3);
INSERT INTO products (name, description, price, image_url, category_id) VALUES
                                                                            ('Nachos', 'Cheesy tortilla chips.', 65.00, 'https://via.placeholder.com/180x120?text=Nachos', 4),
                                                                            ('Salted Peanuts', 'Crunchy and salted.', 35.00, 'https://via.placeholder.com/180x120?text=Peanuts', 4),
                                                                            ('Instant Noodles', 'Ready in 2 minutes.', 20.00, 'https://via.placeholder.com/180x120?text=Noodles', 4),
                                                                            ('Masala Chips', 'Spicy flavored potato chips.', 30.00, 'https://via.placeholder.com/180x120?text=Masala+Chips', 4),
                                                                            ('Popcorn', 'Microwave butter popcorn.', 40.00, 'https://via.placeholder.com/180x120?text=Popcorn', 4),
                                                                            ('Trail Mix', 'Mixed dry fruits and seeds.', 95.00, 'https://via.placeholder.com/180x120?text=Trail+Mix', 4);
INSERT INTO products (name, description, price, image_url, category_id) VALUES
                                                                            ('Toilet Cleaner', 'Kills 99.9% germs.', 95.00, 'https://via.placeholder.com/180x120?text=Toilet+Cleaner', 5),
                                                                            ('Garbage Bags', 'Pack of 20 large bags.', 60.00, 'https://via.placeholder.com/180x120?text=Garbage+Bags', 5),
                                                                            ('Hand Wash', 'Liquid hand soap.', 55.00, 'https://via.placeholder.com/180x120?text=Hand+Wash', 5),
                                                                            ('Detergent Powder', 'For bright and clean clothes.', 110.00, 'https://via.placeholder.com/180x120?text=Detergent', 5),
                                                                            ('Room Freshener', 'Jasmine air freshener.', 85.00, 'https://via.placeholder.com/180x120?text=Freshener', 5),
                                                                            ('Toilet Paper', 'Pack of 4 rolls.', 70.00, 'https://via.placeholder.com/180x120?text=Toilet+Paper', 5);

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

-- Update img_url for real image links
UPDATE products SET image_url = 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg' WHERE id = 1;
UPDATE products SET image_url = 'https://theseedcompany.ca/cdn/shop/files/crop_CARR1923_Carrot___Sweetness_Pelleted_Long.png?v=1720113309&width=1024' WHERE id = 2;
UPDATE products SET image_url = 'https://www.allrecipes.com/thmb/OniK53C6v09aKhrv6TogSevXv30=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/8721666-Copycat-Cheesecake-Factory-Brown-Bread-ddmfs-4x3-ccabd963c6b44b679ce95ff84397703c.jpg' WHERE id = 3;
UPDATE products SET image_url = 'https://www.bbassets.com/media/uploads/p/l/306926_4-amul-homogenised-toned-milk.jpg' WHERE id = 4;
UPDATE products SET image_url = 'https://juice9.com/images/product/200mlpaperbox/200ml_orange.webp' WHERE id = 5;
UPDATE products SET image_url = 'https://cravova.com/cdn/shop/products/IMG_0008.jpg2_53ba1744-afb1-4f00-9d70-aea58537266c_1400x.jpg?v=1646307483' WHERE id = 6;
UPDATE products SET image_url = 'https://images-cdn.ubuy.co.in/67c1549d8028b20f6e0dde51-lays-classic-potato-chips-8-oz-bag.jpg' WHERE id = 7;
UPDATE products SET image_url = 'https://m.media-amazon.com/images/I/41Pk14do2GL.jpg' WHERE id = 8;
UPDATE products SET image_url = 'https://ueirorganic.com/cdn/shop/files/organicdishwash.jpg?v=1685621731' WHERE id = 9;
UPDATE products SET image_url = 'https://www.netmeds.com/images/product-v1/600x600/1045847/lizol_disinfectant_surface_floor_cleaner_liquid_lavender_2_litre_416520_0_0.jpg' WHERE id = 10;
UPDATE products SET image_url = 'https://www.allrecipes.com/thmb/jYmw-0Vijg1E_OuG2yGjEAcdQg4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/ar-new-banana-adobe-ar-4x3-d8f0871e12214350be7ae5575eea4eed.jpg' WHERE id = 11;
UPDATE products SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm-6QVkNbO5SKS1InuN3riDYtExHP5G1y2qw&s' WHERE id = 12;
UPDATE products SET image_url = 'https://gabbarfarms.com/cdn/shop/products/Spinach.jpg?v=1620713074' WHERE id = 13;
UPDATE products SET image_url = 'https://5.imimg.com/data5/SELLER/Default/2023/6/318348003/RE/QT/DJ/45117192/fresh-kesar-mango-500x500.jpg' WHERE id = 14;
UPDATE products SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgIxB4TqKd66zyoFXx9QiHPP_bsfzq6xLPHA&s' WHERE id = 15;
UPDATE products SET image_url = 'https://seed2plant.in/cdn/shop/products/saladcucumberseeds.jpg?v=1603435556' WHERE id = 16;
UPDATE products SET image_url = 'https://purvanchalmart.com/wp-content/uploads/2024/11/16839818902880-1.jpg' WHERE id = 17;
UPDATE products SET image_url = 'https://i0.wp.com/nvpmart.in/wp-content/uploads/2022/07/milky-mist-paneer-200-g-pack-product-images-o490006894-p490006894-0-202203170956.jpg?fit=600%2C600&ssl=1' WHERE id = 18;
UPDATE products SET image_url = 'https://dlecta.com/cdn/shop/files/Side_635dac82-341e-4222-aa29-55207c92c3a2.jpg?v=1741767332&width=1080' WHERE id = 19;
UPDATE products SET image_url = 'https://www.jiomart.com/images/product/original/490007881/english-oven-freshly-baked-milk-sliced-white-bread-400-g-product-images-o490007881-p591190839-0-202208012040.jpg?im=Resize=(1000,1000)' WHERE id = 20;
UPDATE products SET image_url = 'https://m.media-amazon.com/images/I/714r91-V7XL.jpg' WHERE id = 21;
UPDATE products SET image_url = 'https://m.media-amazon.com/images/I/71bT2JDqXML.jpg' WHERE id = 22;
UPDATE products SET image_url = 'https://wanabeverage.com/wp-content/uploads/2021/09/mango-300.jpg' WHERE id = 23;
UPDATE products SET image_url = 'https://5.imimg.com/data5/EW/VE/MY-39319845/tropicana-premium-drinks-lemonade-500x500.png' WHERE id = 24;
UPDATE products SET image_url = 'https://5.imimg.com/data5/SELLER/Default/2021/11/CH/OF/OZ/32986075/organic-green-tea-500x500.jpeg' WHERE id = 25;
UPDATE products SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMHTBKJDq-VI9UlPjwVYNe_B93Iv9wxGkPg&s' WHERE id = 26;
UPDATE products SET image_url = 'https://img1.exportersindia.com/product_images/bc-full/2023/12/12874023/butter-milk-powder-1703083868-7215301.jpeg' WHERE id = 27;
UPDATE products SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23Fa4noLBvuWZcHNcN-XrAvNciZOV2C91qA&s' WHERE id = 28;
UPDATE products SET image_url = 'https://shop.cornitos.in/cdn/shop/files/1_2_1000x1000.jpg?v=1712122933' WHERE id = 29;
UPDATE products SET image_url = 'https://www.haldirams.com/media/catalog/product/cache/71134970afb779eb7860339989626b7e/s/a/salted_peanuts_1.jpg' WHERE id = 30;
UPDATE products SET image_url = 'https://themintleaves.com/cdn/shop/products/maggi-noodles_9b215303-75e2-429b-a20f-70539a0ac1f3_2048x.jpg?v=1619599708' WHERE id = 31;
UPDATE products SET image_url = 'https://freshmills.in/cdn/shop/files/organic-masala-potato-chips-happy-leaf-snacks-freshmills-711350.png?v=1718903907' WHERE id = 32;
UPDATE products SET image_url = 'https://www.flippedoutfood.com/wp-content/uploads/2022/02/Movie-Theater-Popcorn-featured-720x720.jpg' WHERE id = 33;
UPDATE products SET image_url = 'https://images-cdn.ubuy.co.in/6813552fe042961f43012470-kirkland-signature-trail-mix-4-lb-2.jpg' WHERE id = 34;
UPDATE products SET image_url = 'https://cdn.zeptonow.com/production/ik-seo/tr:w-640,ar-2400-2400,pr-true,f-auto,q-80/cms/product_variant/07b624b5-7737-403a-80f4-2e44420a3730/BAY6-Disinfectant-Toilet-Cleaner.jpeg' WHERE id = 35;
UPDATE products SET image_url = 'https://easy-flux.in/wp-content/uploads/2019/12/Garbage.jpg' WHERE id = 36;
UPDATE products SET image_url = 'https://assets.unileversolutions.com/v1/110405810.jpg' WHERE id = 37;
UPDATE products SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVpG9xTl0JgOoXQBcqKVxqcZs-E8VyfLGg6Q&s' WHERE id = 38;
UPDATE products SET image_url = 'https://johnphillips.in/cdn/shop/files/Lavender_c1c81206-8799-4f8c-9a5d-d820f98788ad.jpg?v=1695470363' WHERE id = 39;
UPDATE products SET image_url = 'https://thumbs.dreamstime.com/b/four-roll-toilet-paper-package-white-background-67284530.jpg' WHERE id = 40;