-- USERS TABLE
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(150) NOT NULL,
    is_admin BOOLEAN DEFAULT 0,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'images/default.png'
);

-- ADDRESSES TABLE
CREATE TABLE addresses (
    address_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A',
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- SHOPS TABLE
CREATE TABLE shops (
    shop_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    owner_id INTEGER NOT NULL,
    parent_shop_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES users(user_id),
    FOREIGN KEY (parent_shop_id) REFERENCES shops(shop_id)
);

-- CATEGORY TABLE
CREATE TABLE category (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(300) NOT NULL UNIQUE,
    code VARCHAR(50)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price FLOAT NOT NULL,
    stock INTEGER DEFAULT 0,
    img_url VARCHAR(250),
    category_id INTEGER NOT NULL,
    shop_id INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);

-- CART ITEMS TABLE
CREATE TABLE cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- ORDERS TABLE
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    shop_id INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'placed',
    location VARCHAR(200) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);

-- ORDER ITEMS TABLE
CREATE TABLE order_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price FLOAT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- RATINGS TABLE
CREATE TABLE ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    shop_id INTEGER NOT NULL,
    value INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (shop_id) REFERENCES shops(shop_id),
    CONSTRAINT uq_user_shop_rating UNIQUE (user_id, shop_id)
);

-- BLOG POSTS TABLE
CREATE TABLE blog_posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    media_url VARCHAR(300),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)