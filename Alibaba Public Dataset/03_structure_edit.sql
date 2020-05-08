USE alibaba;

/* Modify table orders */
-- Add user_id column 
CREATE TABLE new_orders (
    PRIMARY KEY (order_id),
    INDEX (user_id),
    FOREIGN KEY (user_id)
      REFERENCES users(user_id)
      ON UPDATE CASCADE
)
SELECT o.*, user_id
FROM orders o JOIN orders_placed_users ou
ON o.order_id = ou.order_id;

-- Check if there's any foreign keys referenced to the table
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME,
       REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME = 'orders';

-- Modify foreign keys
ALTER TABLE orders_have_products
DROP FOREIGN KEY orders_have_products_ibfk_1,
ADD FOREIGN KEY (order_id)
  REFERENCES new_orders(order_id);

-- Drop old table and rename the new one
DROP TABLE orders;
ALTER TABLE new_orders
MODIFY user_id INT NOT NULL AFTER order_id,
RENAME orders;

/* Modify table products */
-- Add category_id column
CREATE TABLE new_products (
    PRIMARY KEY (product_id),
    INDEX (category_id),
    FOREIGN KEY (category_id)
      REFERENCES categories(category_id)
      ON UPDATE CASCADE
)
SELECT p.*, pc.category_id
FROM products p JOIN products_belong_categories pc
ON p.product_id = pc.product_id
JOIN categories c
ON pc.category_id = c.category_id;

-- Check if there's any foreign keys referenced to the table
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME,
       REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME = 'products';

-- Modify foreign keys
ALTER TABLE carts_have_products
DROP FOREIGN KEY carts_have_products_ibfk_2,
ADD FOREIGN KEY (product_id)
  REFERENCES new_products(product_id);
  
ALTER TABLE products_sold_vendors
DROP FOREIGN KEY products_sold_vendors_ibfk_2,
ADD FOREIGN KEY (product_id)
  REFERENCES new_products(product_id);
  
ALTER TABLE products_have_options
DROP FOREIGN KEY products_have_options_ibfk_1,
ADD FOREIGN KEY (product_id)
  REFERENCES new_products(product_id);
  
ALTER TABLE orders_have_products
DROP FOREIGN KEY orders_have_products_ibfk_2,
ADD FOREIGN KEY (product_id)
  REFERENCES new_products(product_id);

-- Drop old table and rename the new one
DROP TABLE products;
ALTER TABLE new_products
MODIFY category_id INT NOT NULL AFTER product_id,
RENAME products;
