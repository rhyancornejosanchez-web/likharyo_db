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