CREATE DATABASE likharyo;

-- Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(150) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'images/default.png'
);

-- Addresses Table 
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A',
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000'
);

-- Shops Table
CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    owner_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_shop_id INT REFERENCES shops(shop_id) ON DELETE SET NULL
);

-- Categories Table
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300) UNIQUE NOT NULL,
    code VARCHAR(50)
);

-- Items Table
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price FLOAT NOT NULL,
    stock INT DEFAULT 0,
    img_url VARCHAR(250),
    category_id INT NOT NULL REFERENCES category(id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE
);

-- Cart Items Table
CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT DEFAULT 1
);

-- Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'placed',
    location VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order Items Table
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price FLOAT NOT NULL
);

-- Ratings Table
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    value INT NOT NULL,
    CONSTRAINT uq_user_shop_rating UNIQUE (user_id, shop_id)
);

INSERT INTO users (username, password_hash, first_name, last_name, gender, birthdate, contact_num, is_admin) VALUES
('ZiaMadePH', 'default_hash', 'Zia', 'Gonzales', 'Female', '1995-03-12', '09171234567', TRUE),
('AltheaCreates', 'default_hash', 'Althea', 'Ramos', 'Female', '1992-08-21', '09172345678', TRUE),
('KaiGoods', 'default_hash', 'Kai', 'Tan', 'Male', '1990-11-05', '09173456789', TRUE),
('MaelysWeave', 'default_hash', 'Maelys', 'Santos', 'Female', '1998-04-19', '09174567890', TRUE),
('EthanLeather', 'default_hash', 'Ethan', 'Lopez', 'Male', '1993-01-25', '09175678901', TRUE),
('ZoeyAtbp', 'default_hash', 'Zoey', 'Villanueva', 'Female', '2001-07-30', '09176789012', TRUE),
('LiamPrint', 'default_hash', 'Liam', 'De La Cruz', 'Male', '1996-10-01', '09177890123', TRUE),
('LunaCrafted', 'default_hash', 'Luna', 'Reyes', 'Female', '1997-12-14', '09178901234', TRUE),
('CieloScents', 'default_hash', 'Cielo', 'Mendoza', 'Female', '1991-05-08', '09179012345', TRUE),
('NicoCeramics', 'default_hash', 'Nico', 'Lim', 'Male', '1994-06-28', '09181234567', TRUE),
('SkyeTextile', 'default_hash', 'Skye', 'Garcia', 'Female', '1999-02-03', '09182345678', TRUE),
('AmariMetals', 'default_hash', 'Amari', 'Dela Rosa', 'Female', '1990-09-17', '09183456789', TRUE),
('ChloeQuilts', 'default_hash', 'Chloe', 'Aquino', 'Female', '1993-03-29', '09184567890', TRUE),
('JaviBuilds', 'default_hash', 'Javi', 'Torres', 'Male', '1997-07-07', '09185678901', TRUE),
('AvaPaints', 'default_hash', 'Ava', 'Salazar', 'Female', '2000-04-11', '09186789012', TRUE),
('XanderWares', 'default_hash', 'Xander', 'Bautista', 'Male', '1995-08-04', '09187890123', TRUE),
('FreyaClay', 'default_hash', 'Freya', 'Castro', 'Female', '1991-05-22', '09188901234', TRUE),
('ZenCraftsMNL', 'default_hash', 'Zen', 'Ramos', 'Male', '1998-09-10', '09189012345', TRUE),
('ElioLighting', 'default_hash', 'Elio', 'Fernandez', 'Male', '1994-12-03', '09191234567', TRUE),
('MilaKape', 'default_hash', 'Mila', 'Corpuz', 'Female', '1992-06-16', '09192345678', TRUE);

INSERT INTO addresses (user_id, street_address, city, province, zip_code) VALUES
(1, '88 Duyan St., San Roque', 'San Fernando', 'Pampanga', '2000'),
(2, '12 Munting Lupa, Poblacion', 'Quezon City', 'Metro Manila', '1100'),
(3, 'Blk 5 Lot 14 Aklan Rd., Holy Spirit', 'Cebu City', 'Cebu', '6000'),
(4, '77 Makisig Ave., San Isidro', 'Makati', 'Metro Manila', '1200'),
(5, '22 Shoe Road, Concepcion Uno', 'Marikina', 'Metro Manila', '1800'),
(6, '9 Palawan Way, Sta. Monica', 'Puerto Princesa', 'Palawan', '5300'),
(7, '4 Antique Press Lane, Sampaloc', 'Manila', 'Metro Manila', '1008'),
(8, '16 Constellation Blvd., Kanan', 'Legazpi', 'Albay', '4500'),
(9, '33 Aromatics Circle, Purok 5', 'Naga City', 'Camarines Sur', '4400'),
(10, '10 Glaze Trail, Malinta', 'Valenzuela', 'Metro Manila', '1440'),
(11, '5 Barong Thread, San Jose', 'Baguio City', 'Benguet', '2600'),
(12, '1 Filigree St., Poblacion', 'Vigan', 'Ilocos Sur', '2700'),
(13, '18 Comfort Lane, Commonwealth', 'Quezon City', 'Metro Manila', '1121'),
(14, '6 Joinery Road, Sta. Cruz', 'Davao City', 'Davao del Sur', '8000'),
(15, '15 River Stone Path, San Agustin', 'Tagaytay City', 'Cavite', '4120'),
(16, '22 Knotting Loop, Talisay', 'Bacolod City', 'Negros Occidental', '6100'),
(17, '7 Earthy Hill, Polo', 'Iloilo City', 'Iloilo', '5000'),
(18, '99 Folding Point, Pinagbuhatan', 'Pasig', 'Metro Manila', '1600'),
(19, '3 Resin Light, Mambaling', 'Cebu City', 'Cebu', '6004'),
(20, '1 Coconut Oil Dr., Calamba', 'Lucena City', 'Quezon', '4301');

INSERT INTO category (name, code) VALUES
('Home & Functional Ceramics', 'CERAMIC'),
('Sustainable Textiles & Fiber Art', 'TEXTILE'),
('Leather & Wood Goods', 'WOOD'),
('Personal Accessories & Jewelry', 'JEWELRY'),
('Fine Art & Stationery', 'ART'),
('Aromatics & Wellness', 'WELLNESS'),
('Heirloom & Custom Gifts', 'GIFT');
