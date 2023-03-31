---1.Customers to find products with highest
ratings for a given category.
SELECT
PRODUCT.PRODUCT_ID,PRODUCT_NAME,REVIEW.RATINGS FROM PRODUCT JOIN
CATEGORY ON PRODUCT.CATEGORY_ID=CATEGORY.CATEGORY_ID JOIN REVIEW
ON PRODUCT.PRODUCT_ID=REVIEW.PRODUCT_PRODUCT_ID WHERE
REVIEW.RATINGS=(SELECT MAX(REVIEW.RATINGS) FROM PRODUCT JOIN
CATEGORY ON PRODUCT.CATEGORY_ID=CATEGORY.CATEGORY_ID JOIN REVIEW
ON PRODUCT.PRODUCT_ID=REVIEW.PRODUCT_PRODUCT_ID WHERE
CATEGORY.CATEGORY_NAME='APPLIANCES') AND
CATEGORY.CATEGORY_NAME='APPLIANCES';

---2.Customers filter out the products according to
their brand and price.
MySQL [ecommerce]> SELECT PRODUCT_ID,PRODUCT_NAME,MRP FROM
PRODUCT WHERE BRAND='SAMSUNG' AND MRP BETWEEN 10000 AND 30000;

---3.Customers compare the products based on their
ratings and reviews.
DELIMITER //
CREATE PROCEDURE p5 (pr1 INT,pr2 INT)
 BEGIN
 SELECT
PRODUCT.PRODUCT_ID,PRODUCT.PRODUCT_NAME,REVIEW.RATINGS,REVIEW.DE
SCRIPTION FROM REVIEW JOIN PRODUCT
 ON REVIEW.PRODUCT_PRODUCT_ID=PRODUCT.PRODUCT_ID WHERE
PRODUCT.PRODUCT_ID=pr1 OR PRODUCT.PRODUCT_ID=pr2;
 END;

---4.List the orders which are to be delivered at a
particular pincode.
MySQL [ecommerce]> SELECT
ORDERS.ORDER_ID,ORDERS.ORDER_DATE,ORDERS.CUSTOMER_CUSTOMER_ID,C
ONCAT(CUSTOMER.FIRST_NAME,' ',CUSTOMER.MIDDLE_NAME,'
',CUSTOMER.LAST_NAME) AS CUSTOMER_NAME,ADDRESS.PINCODE FROM
CUSTOMER JOIN ORDERS ON
CUSTOMER.CUSTOMER_ID=ORDERS.CUSTOMER_CUSTOMER_ID JOIN ADDRESS
ON CUSTOMER.CUSTOMER_ID=ADDRESS.CUSTOMER_CUSTOMER_ID WHERE
ORDERS.ORDER_STATUS='OUT FOR DELIVERY' AND ADDRESS.PINCODE='520011';

---5.List the product whose sale is the highest on
a particular day.
DELIMITER //
CREATE PROCEDURE query(O_DATE DATE)
 BEGIN
 DECLARE CNT INT DEFAULT 801;
 DECLARE MAXID INT DEFAULT 820;
 DECLARE TEMP INT DEFAULT 0;
 DECLARE MAX_CNT INT default 0;
 DECLARE MAXP_ID INT;
 WHILE CNT<=MAXID DO
 select sum(ORDERITEM.quantity) INTO TEMP from orderitem JOIN ORDERS ON
ORDERS.ORDER_ID=ORDERITEM.ORDER_ORDER_ID where
ORDERITEM.product_product_id=CNT AND ORDERS.ORDER_DATE=O_DATE;
 IF TEMP > MAX_CNT THEN
 SET MAX_CNT = TEMP;
 SET MAXP_ID = CNT;
 END IF;
 set CNT =CNT+1;
 END WHILE;
SELECT
ORDERS.ORDER_DATE,ORDERITEM.PRODUCT_PRODUCT_ID,PRODUCT.PRODUCT_
NAME,SUM(ORDERITEM.QUANTITY) AS SALE_COUNT FROM ORDERS JOIN
ORDERITEM ON ORDERS.ORDER_ID=ORDERITEM.ORDER_ORDER_ID
 JOIN PRODUCT ON
PRODUCT.PRODUCT_ID=ORDERITEM.PRODUCT_PRODUCT_ID WHERE
ORDERITEM.PRODUCT_PRODUCT_ID=MAXP_ID AND
ORDERS.ORDER_DATE=O_DATE;
 END;

---6.Write a procedure to calculate total order
amount of all orders.
DELIMITER //
CREATE PROCEDURE p1 ()
 BEGIN
 DECLARE CNT INT DEFAULT 701;
 DECLARE MAXID INT DEFAULT 713;
 WHILE CNT<=MAXID DO
 UPDATE ORDERS SET ORDER_AMOUNT=(SELECT SUM(MRP*QUANTITY) FROM
ORDERITEM WHERE ORDER_ORDER_ID=CNT) WHERE ORDER_ID=CNT;
 SET CNT=CNT+1;
 END WHILE;
 END;

---7.List how many times a particular customer
bought from different sellers.
select
orderitem.order_order_id,orders.customer_customer_id,orderitem.product_pro
duct_id,product.product_name,product.seller_id,count(product.seller_id),seller.n
ame from orders join orderitem on orders.order_id=orderitem.order_order_id
join product on product.product_id=orderitem.product_product_id join seller on
seller.seller_id=product.seller_id where orders.customer_customer_id='106'
group by product.seller_id order by orderitem.product_product_id;

---8.List all the orders whose payment mode is
Credit Card and yet to be delivered.
MySQL [ecommerce]> SELECT
ORDERS.ORDER_ID,ORDERS.CUSTOMER_CUSTOMER_ID,ORDERS.ORDER_STATUS,
PAYMENT.PAYMENT_MODE FROM ORDERS JOIN PAYMENT ON
ORDERS.ORDER_ID=PAYMENT.ORDER_ORDER_ID WHERE
PAYMENT.PAYMENT_MODE='CREDIT CARD' AND
ORDERS.ORDER_STATUS='SHIPPED';

---9.List all orders of customers whose total
amount is less than 10000.
select*from orders where order_amount<'10000';

---10.List the product and its seller which has the
highest stock.
select product_id,product_name,seller_id,brand,stock
from product where stock=(select max(stock) from product);
