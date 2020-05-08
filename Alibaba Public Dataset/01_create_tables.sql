DROP DATABASE IF EXISTS alibaba;
CREATE DATABASE alibaba;
USE alibaba;

/* Create tables which have primary keys */
CREATE TABLE categories (
    category_id INT NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (category_id)
);

CREATE TABLE product_options (
    option_id INT NOT NULL,
    option_name VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (option_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL,
    total_item INT NOT NULL,
    shipping_fee DOUBLE NOT NULL,
    tax DECIMAL(5,4) NOT NULL,
    total_cost DOUBLE NOT NULL,
    order_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    ship_name VARCHAR(45) NOT NULL,
    ship_address VARCHAR(45) NOT NULL,
    tracking_number VARCHAR(45),
    delivery_status INT NOT NULL,
    
    PRIMARY KEY (order_id)
);

CREATE TABLE products (
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    descriptions VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (product_id)
);

CREATE TABLE shopping_carts (
    shopping_cart_id INT NOT NULL,
    status INT NOT NULL,
    
    PRIMARY KEY (shopping_cart_id)
);

CREATE TABLE users (
    user_id INT NOT NULL,
    username VARCHAR(16) NOT NULL,
    password VARCHAR(16) NOT NULL,
    full_name VARCHAR(45) NOT NULL,
    address VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone CHAR(10) NOT NULL,
    
    PRIMARY KEY (user_id)
);

CREATE TABLE vendors (
    vendor_id INT NOT NULL,
    vendor_name VARCHAR(45) NOT NULL,
    vendor_phone CHAR(10) NOT NULL,
    vendor_email VARCHAR(45) NOT NULL,
    
    PRIMARY KEY (vendor_id)
);

/* Create tables which have primary keys and foreign keys                        */
/* Since these table will be modified later, I won't add ON DELETE nor ON UPDATE */
CREATE TABLE orders_placed_users (
    user_id INT NOT NULL,
    order_id INT NOT NULL,
    
    PRIMARY KEY (order_id),
    INDEX (user_id),
    FOREIGN KEY (user_id)
      REFERENCES users(user_id)
);

CREATE TABLE products_belong_categories (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    
    PRIMARY KEY (product_id),
    INDEX (category_id),
    FOREIGN KEY (category_id)
	  REFERENCES categories(category_id)
);

/* Create tables which have foreign keys only */
CREATE TABLE carts_have_products (
    shopping_cart_id INT NOT NULL,
    product_id INT NOT NULL,
    option_id INT NOT NULL,
    quantity INT NOT NULL,
    
    INDEX (shopping_cart_id),
    INDEX (product_id),
    INDEX (option_id),
    FOREIGN KEY (shopping_cart_id)
      REFERENCES shopping_carts(shopping_cart_id)
      ON DELETE CASCADE,
    FOREIGN KEY (product_id)
      REFERENCES products(product_id)
      ON UPDATE CASCADE,
    FOREIGN KEY (option_id)
      REFERENCES product_options(option_id)
      ON UPDATE CASCADE
);

CREATE TABLE orders_have_products (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    option_id INT NOT NULL,
    quantity INT NOT NULL,
    
    INDEX (order_id),
    INDEX (product_id),
    INDEX (option_id),
    FOREIGN KEY (order_id)
      REFERENCES orders(order_id)
      ON DELETE CASCADE,
    FOREIGN KEY (product_id)
      REFERENCES products(product_id)
      ON UPDATE CASCADE,
    FOREIGN KEY (option_id)
      REFERENCES product_options(option_id)
      ON UPDATE CASCADE
);

CREATE TABLE products_sold_vendors (
    vendor_id INT NOT NULL,
    product_id INT NOT NULL,
    
    INDEX (vendor_id),
    INDEX (product_id),
    FOREIGN KEY (vendor_id)
      REFERENCES vendors(vendor_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id)
      REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE products_have_options (
    product_id INT NOT NULL,
    option_id INT NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    on_sale INT NOT NULL,
    specs VARCHAR(255),
    
    INDEX (product_id),
    INDEX (option_id),
    FOREIGN KEY (product_id)
      REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (option_id)
      REFERENCES product_options(option_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);