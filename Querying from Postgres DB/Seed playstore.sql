-- Comments in SQL Start with dash-dash --
-- DML statements --

INSERT INTO products(name, price, can_be_returned) VALUES('chair', 44.00, 'false');
INSERT INTO products(name, price, can_be_returned) VALUES('stool', 25.99, 'true');
INSERT INTO products(name, price, can_be_returned) VALUES('table', 124.00, 'false');
SELECT * FROM products;
SELECT name FROM products;
SELECT name, price FROM products;
INSERT INTO products(name, price, can_be_returned) VALUES('tv', 990.00,'true');
SELECT * FROM products WHERE can_be_returned = 'true';
SELECT * FROM products WHERE price < 44.00;
SELECT * FROM products WHERE price between 22.50 and 99.99;
UPDATE products SET price = price - 20; 
DELETE FROM products WHERE price < 25;
UPDATE products SET price = price + 20;
UPDATE products SET can_be_returned = 'true';