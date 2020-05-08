USE alibaba;

/* Load in text files */
LOAD DATA INFILE '/Uploads/category.txt'
INTO TABLE categories
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/order.txt'
INTO TABLE orders
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/option.txt'
INTO TABLE product_options
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/shoppingcart.txt'
INTO TABLE shopping_carts
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/products.txt'
INTO TABLE products
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/user.txt'
INTO TABLE users
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/vendor.txt'
INTO TABLE vendors
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/carts_has_products.txt'
INTO TABLE carts_have_products
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/orders_has_products.txt'
INTO TABLE orders_have_products
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/orders_placed_user.txt'
INTO TABLE orders_placed_users
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/product_sold_vendor.txt'
INTO TABLE products_sold_vendors
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/products_belong_category.txt'
INTO TABLE products_belong_categories
IGNORE 1 LINES;

LOAD DATA INFILE '/Uploads/products_has_options.txt'
INTO TABLE products_have_options
IGNORE 1 LINES;
