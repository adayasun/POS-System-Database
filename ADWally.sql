/*
*	FILE			:	ADWally.sql
*	PROJECT			:	PROG2111 - Relational Databases
*	PROGRAMMER		:	Amy Dayasundara
*	FIRST VERSION	:	2019 - 11 - 30
*	DESCRIPTION		:	
*	                    Contains the creation of the ADWally datavbase 
*/

-- Create Database
CREATE DATABASE ADWally;
USE ADWally;

-- Create Branch table
CREATE TABLE Branch (
    Branch_ID INT NOT NULL AUTO_INCREMENT,
    Branch_Name VARCHAR(24) NOT NULL,
    PRIMARY KEY (Branch_ID)
);

-- Create Customer Table
CREATE TABLE Customer (
    Cust_ID INT NOT NULL AUTO_INCREMENT,
    FName VARCHAR(24) NOT NULL,
    LName VARCHAR(24) NOT NULL,
    PhoneNumber VARCHAR(24) NOT NULL,
    PRIMARY KEY (Cust_ID)
);

-- Create order table
CREATE TABLE Orders (
    Order_ID INT NOT NULL AUTO_INCREMENT,
    Cust_ID INT,
    Branch_ID INT,
    OrderDate DATE,
    PRIMARY KEY (Order_ID),
    FOREIGN KEY (Cust_ID)
        REFERENCES Customer (Cust_ID),
	FOREIGN KEY (Branch_ID)
		REFERENCES Branch (Branch_ID)
);

-- Create Orderline table
CREATE TABLE Order_Line (
    Order_Line_ID INT NOT NULL AUTO_INCREMENT,
    Order_ID INT,
    sPrice DECIMAL(65,2),
    Quantity INT,
    Extended_Price DECIMAL(65,2),
	PaymentStatus VARCHAR(5),
    PRIMARY KEY (Order_Line_ID),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders (Order_ID)
);

-- Create Products Table
CREATE TABLE Products (
    SKU INT NOT NULL AUTO_INCREMENT,
    Product_Name VARCHAR(50) NOT NULL,
    wPrice DECIMAL(65,2),
    Stock INT,
    ProdType VARCHAR(25),
    PRIMARY KEY (SKU)
);

-- Associative Tables

CREATE TABLE Branch_Product (
    SKU INT NOT NULL,
    Branch_ID INT NOT NULL,
    PRIMARY KEY (SKU, Branch_ID),
    FOREIGN KEY (SKU)
        REFERENCES Products (SKU),
    FOREIGN KEY (Branch_ID)
        REFERENCES Branch (Branch_ID)
);

-- Orderline to Products table
CREATE TABLE OrderLine_Prod(
    Order_Line_ID INT NOT NULL,
    SKU INT NOT NULL,
    PRIMARY KEY (Order_Line_ID, SKU),
    FOREIGN KEY (Order_Line_ID)
        REFERENCES order_line (Order_Line_ID),
    FOREIGN KEY (SKU)
        REFERENCES products (SKU)
);

-- Create Data to work with
-- Customers
INSERT INTO customer(FName, LName, PhoneNumber) 
VALUES ('Carlo', 'Sgro','519-555-0000'),
('Norbert', 'Mika','416-555-1111'),
('Russell', 'Foubert','519-555-2222'),
('Sean', 'Clarke','519-555-3333');

-- Branches
INSERT INTO branch(Branch_Name)
VALUES ('Sports World'), ('Waterloo'), ('Cambridge Mall');

-- Products
INSERT INTO products(Product_Name, Stock, wPrice, ProdType)
VALUES('Disco Queen Wallpaper', '56', '12.95','roll'),
('Countryside Wallpaper', '24','11.95','roll'),
('Victorian Lace Wallpaper', '44','14.95','roll'),
('Drywall Tape', '120','3.95','roll'),
('Drywall Tape', '30','36.95','pkg 10'),
('Drywall Repair Compound', '90','6.95','tube');

-- Customers to Orders
INSERT INTO orders(Cust_ID, OrderDate, Branch_ID)
VALUES('4', '2019-09-20', '2'),
('3', '2019-10-06', '3'),
('2','2019-11-02', '1');

-- Customers to Branches
/*INSERT INTO branch_cust(Cust_ID, Branch_ID)
VALUES('4','1'),('3','3'),(1,1), (2,2);*/

-- Orderline
INSERT INTO order_line(Order_ID, PaymentStatus)
VALUES ('1','PAID'),('1','PAID'),('1','PAID');

-- OrderLine to Products
INSERT INTO orderline_prod(Order_Line_ID, SKU)
VALUES('1','3'),('2','6'),('3','4');

-- Available products in branch

INSERT INTO branch_product(SKU, Branch_ID)
VALUES ('1','2'),('5','2'),('2','1'),('3','2'),('1','3'),('5','1'),('6','1'),('3','1');

INSERT INTO orderline_prod(Order_Line_ID, SKU)
VALUES('1','1'),('1','6'),('1','4');
