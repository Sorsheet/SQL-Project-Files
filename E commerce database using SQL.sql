CREATE DATABASE E_commerceDatabase

USE E_commerceDatabase;


CREATE TABLE Category(
       category_id INT PRIMARY KEY,
	   category_name VARCHAR(100),
	   category_description TEXT
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_description TEXT,
    product_price DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Create Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    user_password VARCHAR(255)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10, 2),
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Inventory table
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity_available INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);



INSERT INTO Category(category_id, category_name,category_description) VALUES
(1,'Electronics','Electronic devices and gadgets'),
(2,'Clothing','Clothes and accessories'),
(3,'Footwear','Shoes and Sandals'),
(4,'Books','Books and Publications'),
(5,'Grocery','NonFood and Food items');



INSERT INTO Products (product_id, product_name, product_description, product_price, category_id) VALUES
(1, 'Smartphone', 'Latest smartphone with advanced features', 799.99, 1),
(2, 'Running Shoes', 'High-performance running shoes for athletes', 129.99, 3),
(3, 'Digital Camera', 'Professional-grade digital camera with 4K recording', 1499.99, 1),
(4, 'Backpack', 'Water-resistant backpack for outdoor adventures', 59.99, 2),
(5, 'Gaming Console', 'Next-gen gaming console with immersive gaming experience', 499.99, 1),
(6, 'Yoga Mat', 'Non-slip yoga mat for comfortable workout sessions', 29.99, 2),
(7, 'Wireless Headphones', 'Premium wireless headphones with noise cancellation', 249.99, 1),
(8, 'Cookware Set', 'Complete set of high-quality cookware for your kitchen', 199.99, 5),
(9, 'Smart Watch', 'Fitness tracker and smartwatch with heart rate monitor', 199.99, 1),
(10, 'Data Structures and Algorithms', 'Comprehensive guide to data structures and algorithms', 49.99, 4);



INSERT INTO Users (user_id, username, email, user_password) VALUES
(1, 'john_doe', 'john@example.com', 'password123'),
(2, 'jane_smith', 'jane@example.com', 'abc123'),
(3, 'bob_jones', 'bob@example.com', 'password456'),
(4, 'alice_wang', 'alice@example.com', 'pass123'),
(5, 'mike_jackson', 'mike@example.com', 'mikepass'),
(6, 'sarah_miller', 'sarah@example.com', 'sarah123'),
(7, 'chris_brown', 'chris@example.com', 'chrispass'),
(8, 'emily_tan', 'emily@example.com', 'emilypass'),
(9, 'david_clark', 'david@example.com', 'davidpass'),
(10, 'lisa_kim', 'lisa@example.com', 'lisapass'),
(11, 'kevin_adams', 'kevin@example.com', 'kevinpass'),
(12, 'rachel_lee', 'rachel@example.com', 'rachelpass'),
(13, 'andrew_nguyen', 'andrew@example.com', 'andrewpass'),
(14, 'jennifer_wong', 'jennifer@example.com', 'jenniferpass'),
(15, 'steven_chen', 'steven@example.com', 'stevenpass'),
(16, 'amanda_smith', 'amanda@example.com', 'amandapass'),
(17, 'jason_li', 'jason@example.com', 'jasonpass'),
(18, 'natalie_wu', 'natalie@example.com', 'nataliepass'),
(19, 'daniel_kim', 'daniel@example.com', 'danielpass'),
(20, 'sophia_ng', 'sophia@example.com', 'sophiapass');



INSERT INTO Orders (order_id, user_id, order_date, total_amount, order_status) VALUES
(1, 1, '2024-03-02', 200.00, 'Completed'),
(2, 4, '2024-03-03', 350.00, 'Pending'),
(3, 2, '2024-03-04', 150.00, 'Completed'),
(4, 6, '2024-03-05', 120.00, 'Pending'),
(5, 7, '2024-03-06', 500.00, 'Completed'),
(6, 8, '2024-03-07', 75.00, 'Pending'),
(7, 9, '2024-03-08', 250.00, 'Completed'),
(8, 10, '2024-03-09', 180.00, 'Pending'),
(9, 11, '2024-03-10', 300.00, 'Completed'),
(10, 12, '2024-03-11', 420.00, 'Pending'),
(11, 13, '2024-03-12', 200.00, 'Completed'),
(12, 14, '2024-03-13', 90.00, 'Pending'),
(13, 15, '2024-03-14', 150.00, 'Completed'),
(14, 18, '2024-03-15', 80.00, 'Pending'),
(15, 19, '2024-03-16', 400.00, 'Completed'),
(16, 20, '2024-03-17', 95.00, 'Pending'),
(17, 16, '2024-03-18', 220.00, 'Completed'),
(18, 5, '2024-03-19', 160.00, 'Pending');



INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_price, subtotal) VALUES
(1, 1, 1, 1, 75.00, 75.00),
(2, 2, 2, 2, 50.00, 100.00),
(3, 3, 3, 1, 200.00, 200.00),
(4, 4, 4, 3, 50.00, 150.00),
(5, 5, 5, 1, 180.00, 180.00),
(6, 6, 6, 2, 60.00, 120.00),
(7, 7, 7, 5, 500.00, 500.00),
(8, 8, 8, 1, 75.00, 75.00),
(9, 9, 9, 2, 125.00, 250.00),
(10, 10, 7, 2, 110.00, 220.00),
(11, 11, 6, 1, 300.00, 300.00),
(12, 12, 10, 2, 210.00, 420.00),
(13, 13, 4, 1, 200.00, 200.00),
(14, 14, 2, 1, 90.00, 90.00),
(15, 15, 1, 1, 150.00, 150.00),
(16, 16, 9, 1, 80.00, 80.00),
(17, 17, 7, 2, 200.00, 400.00),
(18, 18, 6, 1, 95.00, 95.00);



INSERT INTO Inventory (inventory_id, product_id, quantity_available) VALUES
(1, 1, 20), 
(2, 2, 50), 
(3, 3, 30), 
(4, 4, 100),
(5, 5, 200);


select * from Category

select * from Products

select * from Users

select * from Orders

select * from Order_Items

select * from Inventory

 --Creating Stored Procedure Order status per user without product name--

CREATE PROCEDURE GetOrderSatatusperuser
as
begin
select u.user_id,
       u.username,
	   o.order_id,
	   o.order_date,
	   o.order_status
  from users u
  inner join orders o on u.user_id=o.user_id
 end

 exec GetOrderSatatusperuser;
 
 --Creating Stored Procedure to get Order status per user with product name--

create proc GetOrderSatatusforUser
as
begin
select u.user_id,
       u.username,
	   o.order_id,
	   o.order_date,
	   o.order_status,
	   p.product_name
  from users u
  inner join orders o on u.user_id=o.user_id
  inner join Order_Items ot on o.order_id = ot.order_id
  inner join Products p on ot.product_id = p.product_id
 end

 exec GetOrderSatatusforUser;

 --Creating a Stored Procedure to get purchasing user name and product name for the give category of products--

 create procedure Getusernamebypurchase @Category varchar(50)
as
begin
select u.username,
       p.product_name,
       c.category_name
	 from
	 Users u
  inner join orders o on u.user_id=o.user_id
  inner join Order_Items ot on o.order_id = ot.order_id
  inner join Products p on ot.product_id = p.product_id
  inner join Category c on p.category_id = c.category_ID
  where
  @Category = c.category_name
end

exec Getusernamebypurchase @Category = 'Category Name'


 --Creating a Stored Procedure to get user_name, product name and product category for the give user ID--


create procedure GetProductforUser @userID int
 as
 begin
 select u.user_id as UserID,
        u.username as Name,
		p.product_name as Product,
		c.category_name as Category
	from
	Users u
	inner join orders o on u.user_id=o.user_id
    inner join Order_Items ot on o.order_id = ot.order_id
    inner join Products p on ot.product_id = p.product_id
	inner join Category c on p.category_id = c.category_ID
    where @userID = u.user_id
end

exec GetProductforUser @userID = 'user_id'