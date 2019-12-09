DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Businesses');
INSERT INTO category(categoryName) VALUES ('Jobs');
INSERT INTO category(categoryName) VALUES ('School');
INSERT INTO category(categoryName) VALUES ('Objects');

INSERT INTO warehouse(warehouseName) VALUES ('KELOWNA');
INSERT INTO warehouse(warehouseName) VALUES ('VANCOUVER');
INSERT INTO warehouse(warehouseName) VALUES ('TORONTO');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fish Store', 1, 'A store of fish',180.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('WorksOn', 2, 'A database of employees and their jobs',150.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Retail Store', 1, 'A retail store',125.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hotel', 1, 'Hotel Chain',175.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bank', 1, 'Bank and customers',175.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Book Store', 1, 'Bookstore and Products',175.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Classes', 3, 'University Classes and Professors',175.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Invoices', 1, 'Invoices for sales in a business',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pet Store', 1, 'A pet store',180.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Library', 3, 'Library with books check out by who',200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grades', 3, 'Grades from a class',150.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Film', 2, 'Film crew and their various abilities',125.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Film MultiNational', 2, 'Film crew and their various abilities and country of operation',125.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Films', 4, 'Films ratings and reviews',140.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Books', 4, 'Books ratings and reviews',130.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Music', 4, 'Music ratings and reviews',130.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Music Studio', 2, 'Music Studios and their artists songs and albums', 225.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Students', 3, 'Students of a school majors and credits', 250.00);

INSERT productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 2000, 150.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(3, 1, 2000, 125.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(4, 1, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(5, 1, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(6, 1, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(7, 1, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(8, 1, 2000, 100.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(9, 1, 2000, 180.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(1, 1, 2000, 180.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(10, 1, 2000, 200.00);
	
INSERT productinventory(productId, warehouseId, quantity, price) VALUES (2, 2, 2000, 150.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(3, 2, 2000, 125.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(4, 2, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(5, 2, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(6, 2, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(7, 2, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(8, 2, 2000, 100.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(9, 2, 2000, 180.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(1, 2, 2000, 180.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(10, 2, 2000, 200.00);

INSERT productinventory(productId, warehouseId, quantity, price) VALUES (2, 3, 2000, 150.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES(3, 3, 2000, 125.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(4, 3, 2000, 175.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES(1, 3, 2000, 180.00);
INSERT productinventory(productId, warehouseId, quantity, price) VALUES	(10, 3, 2000, 200.00);


INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Abby', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'abby' , 'abby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'user' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'ur' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'beth');


DECLARE @orderId1 int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 180.00)
SELECT @orderId1 = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId1, 1, 1, 180.00)

DECLARE @orderId2 int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-11-15 10:25:55', 180.00)
SELECT @orderId2 = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId2, 1, 1, 150.00)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId2, 4, 1, 175.00)


DECLARE @orderId3 int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-16 18:00:00', 900.00)
SELECT @orderId3 = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId3, 1, 5, 180.00);



-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;

