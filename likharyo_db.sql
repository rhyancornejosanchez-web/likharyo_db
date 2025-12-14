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

INSERT INTO shops (name, description, owner_id) VALUES
('The Zia Clay Studio', 'Preserving the legacy of Pampanga in modern form. We fuse age-old Kapampangan hand-building techniques with contemporary design. Every piece carries the intentional mark of human hands, ensuring that our heritage and the warmth of tradition enrich your modern home.', 1),
('Althea''s Knit & Knot', 'Knitting therapy into every stitch. Our throws and accessories are created with mindfulness, offering comfort and peace (Kapayapaan). Choosing our fiber art supports mothers who turn anxiety into beautiful, therapeutic, handcrafted textile works.', 2),
('Kai''s Minimalist Wood', 'Sustainable elegance from salvaged history. We refuse waste, creating minimalist designs solely from reclaimed Philippine hardwoods. Our commitment is to honesty, integrity, and building heirloom pieces that respect the material and last a lifetime.', 3),
('Maëlys Fabric & Thread', 'Where patience is the medium. We specialize in intricate embroidery, dedicating over a hundred hours to capturing the detail of local flora and fauna. Buy the passage of time—a tangible tribute to Filipino nature and slow, devotional craftsmanship.', 4),
('Ethan''s Leather Works', 'Heirlooms built to defy fast fashion. Hand-stitched in Marikina using only honest, vegetable-tanned leather. We offer a lifetime repair guarantee because we believe true quality is a promise of enduring companionship, not disposable trends.', 5),
('Zoey''s Resin Gems', 'Immortality for nature''s most delicate moments. I collect and preserve tiny elements of the Philippine wilderness—petals, moss, sand—in crystal-clear resin. Wear a micro-museum, a timeless piece of our islands’ fleeting beauty.', 6),
('Liam Letterpress Studio', 'Reviving the luxurious, tactile art of communication. We use antique presses to create stationery with a deep, physical impression. Choose the deliberate, soulful elegance of letterpress over the flatness of digital speed.', 7),
('Luna & Stars Jewelry', 'Jewelry as a personal celestial map. We hand-set precious stones to replicate your birth constellation or a significant moon phase. Our pieces are more than adornment; they are deeply personal talismans that track your unique cosmic history.', 8),
('Cielo Aromatic Crafts', 'The authentic scent of the Philippines, bottled. We reject synthetics, using natural waxes and local oils to capture the real aromas of Sampaguita, sea air, and earth. Light a true olfactory journey back to your favorite Filipino memory.', 9),
('Nico''s Wheel & Glaze', 'Embracing Wabi-Sabi: The beauty of the human touch. I hand-throw every ceramic piece, celebrating the slight wobble and unique glaze crackle that a machine would reject. Choose character and honest form over cold, factory perfection.', 10),
('Skye and Stitch', 'Giving history a second life. We meticulously deconstruct and reassemble damaged Barongs and vintage textiles into modern accessories. Our craft is a beautiful stand against textile waste and a celebration of rebirth.', 11),
('Amari Fine Filigree', 'Funding the survival of a national treasure. My jewelry uses centuries-old Filigree techniques, meticulously twisting metal threads by hand. You are investing in the survival of a beautiful, vanishing Filipino heritage craft.', 12),
('Chloe''s Comfort Quilt', 'Stitching family memories into lasting comfort. Our quilts are designed as heavy, comforting heirlooms, combining fabric scraps that represent shared history. We offer a generational embrace, built to gather memories for decades.', 13),
('Javi Custom Furniture', 'Heirloom quality built with necessary patience. I refuse to compromise on the time required for perfection. We hand-sand and join every piece to create resilient, soulful furniture—a quiet stand against disposable consumerism.', 14),
('Ava’s Painted Stones', 'Finding art in the unexpected, natural canvas. I use perfectly shaped river stones as my medium for detailed miniature landscapes. My work reminds you that profound beauty can be found anywhere, even in a simple rock underfoot.', 15),
('Xander''s Modern Macrame', 'Translating rhythm and feeling into geometric form. I specialize in complex macrame patterns, creating texture and structure that appeal to all the senses. Experience the quiet strength and sophistication of the knotted human hand.', 16),
('Freya''s Earthy Trinkets', 'Honest forms, perfectly imperfect. Using natural clay, my pieces bear the clear, unpolished marks of my fingertips. I invite you to embrace the authenticity and slight irregularity that makes handmade items feel truly warm and personal.', 17),
('Zen Paper Art', 'Where focused patience meets extraordinary detail. My complex 3D art is created by meticulously folding thousands of paper strips. Choose this art as a visual journey toward mindfulness and appreciation for astonishing, dedicated craft.', 18),
('Elio''s Light & Resin', 'Illuminating your personal history. I create bespoke lamps by embedding your most sentimental mementos (keys, flowers, trinkets) in clear resin. Turn your most cherished memories into the brightest, most beautiful source of light in your home.', 19),
('Mila Handmade Soaps', 'Mother''s love and purity in every bar. My cold-process soaps grew from a necessity to provide safe, natural care for my family. We use pure, local ingredients to offer you relief, nourishing care, and absolute peace of mind.', 20);

SELECT
    (SELECT user_id FROM users WHERE username = 'ZiaMadePH') AS ZiaMadePH_ID,
    (SELECT user_id FROM users WHERE username = 'AltheaCreates') AS AltheaCreates_ID,
    (SELECT user_id FROM users WHERE username = 'KaiGoods') AS KaiGoods_ID,
    (SELECT user_id FROM users WHERE username = 'MaelysWeave') AS MaelysWeave_ID,
    (SELECT user_id FROM users WHERE username = 'EthanLeather') AS EthanLeather_ID,
    (SELECT user_id FROM users WHERE username = 'ZoeyAtbp') AS ZoeyAtbp_ID,
    (SELECT user_id FROM users WHERE username = 'LiamPrint') AS LiamPrint_ID,
    (SELECT user_id FROM users WHERE username = 'LunaCrafted') AS LunaCrafted_ID,
    (SELECT user_id FROM users WHERE username = 'CieloScents') AS CieloScents_ID,
    (SELECT user_id FROM users WHERE username = 'NicoCeramics') AS NicoCeramics_ID,
    (SELECT user_id FROM users WHERE username = 'SkyeTextile') AS SkyeTextile_ID,
    (SELECT user_id FROM users WHERE username = 'AmariMetals') AS AmariMetals_ID,
    (SELECT user_id FROM users WHERE username = 'ChloeQuilts') AS ChloeQuilts_ID,
    (SELECT user_id FROM users WHERE username = 'JaviBuilds') AS JaviBuilds_ID,
    (SELECT user_id FROM users WHERE username = 'AvaPaints') AS AvaPaints_ID,
    (SELECT user_id FROM users WHERE username = 'XanderWares') AS XanderWares_ID,
    (SELECT user_id FROM users WHERE username = 'FreyaClay') AS FreyaClay_ID,
    (SELECT user_id FROM users WHERE username = 'ZenCraftsMNL') AS ZenCraftsMNL_ID,
    (SELECT user_id FROM users WHERE username = 'ElioLighting') AS ElioLighting_ID,
    (SELECT user_id FROM users WHERE username = 'MilaKape') AS MilaKape_ID;
