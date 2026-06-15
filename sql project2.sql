-- Sql 2


CREATE DATABASE DataTransformerProject;

USE DataTransformerProject;


-- CREATE CUSTOMERS TABLE


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);

---------------------------------------------------
-- INSERT DATA INTO CUSTOMERS TABLE
---------------------------------------------------

INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john@example.com', 'New York'),
(2, 'Jane', 'Smith', 'jane@example.com', 'Los Angeles'),
(3, 'Michael', 'Brown', 'michael@example.com', 'Chicago'),
(4, 'Emily', 'Davis', 'emily@example.com', 'Houston');


-- CREATE ORDERS TABLE


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

---------------------------------------------------
-- INSERT DATA INTO ORDERS TABLE
---------------------------------------------------

INSERT INTO Orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-07-05', 300.00),
(104, 3, '2023-07-07', 450.25),
(105, 2, '2023-07-10', 120.00);


-- CREATE EMPLOYEES TABLE


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);


-- INSERT DATA INTO EMPLOYEES TABLE


INSERT INTO Employees VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00),
(3, 'David', 'Wilson', 'IT', '2019-06-11', 70000.00),
(4, 'Nancy', 'Taylor', 'Finance', '2022-02-05', 48000.00),
(5, 'Chris', 'Martin', 'Sales', '2018-08-22', 65000.00);

---------------------------------------------------
-- 1. INNER JOIN
---------------------------------------------------

SELECT 
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 2. LEFT JOIN


SELECT 
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Orders.OrderID,
    Orders.TotalAmount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 3. RIGHT JOIN


SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    Customers.FirstName,
    Customers.LastName
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 4. FULL OUTER JOIN


SELECT 
    Customers.CustomerID,
    Customers.FirstName,
    Orders.OrderID,
    Orders.TotalAmount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT 
    Customers.CustomerID,
    Customers.FirstName,
    Orders.OrderID,
    Orders.TotalAmount
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

---------------------------------------------------
-- 5. SUBQUERY
---------------------------------------------------

SELECT DISTINCT CustomerID
FROM Orders
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
);

---------------------------------------------------
-- 6. EMPLOYEES WITH ABOVE AVERAGE SALARY
---------------------------------------------------

SELECT *
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

---------------------------------------------------
-- 7. EXTRACT YEAR AND MONTH
---------------------------------------------------

SELECT 
    OrderID,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;


-- 8. DATE DIFFERENCE


SELECT 
    OrderID,
    OrderDate,
    DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
FROM Orders;


-- 9. FORMAT DATE


SELECT 
    OrderID,
    DATE_FORMAT(OrderDate, '%d-%M-%Y') AS FormattedDate
FROM Orders;


-- 10. CONCATENATE FIRSTNAME AND LASTNAME


SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;


-- 11. REPLACE STRING


SELECT 
    REPLACE(FirstName, 'John', 'Jonathan') AS UpdatedName
FROM Customers;


-- 12. UPPERCASE AND LOWERCASE


SELECT 
    UPPER(FirstName) AS FirstNameUpper,
    LOWER(LastName) AS LastNameLower
FROM Customers;


-- 13. TRIM EMAIL


SELECT 
    TRIM(Email) AS CleanEmail
FROM Customers;


-- 14. RUNNING TOTAL


SELECT 
    OrderID,
    CustomerID,
    TotalAmount,
    SUM(TotalAmount) OVER (ORDER BY OrderID) AS RunningTotal
FROM Orders;


-- 15. RANK ORDERS


SELECT 
    OrderID,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM Orders;


-- 16. DISCOUNT BASED ON TOTAL AMOUNT


SELECT 
    OrderID,
    TotalAmount,
    CASE
        WHEN TotalAmount > 1000 THEN '10% Discount'
        WHEN TotalAmount > 500 THEN '5% Discount'
        ELSE 'No Discount'
    END AS DiscountOffer
FROM Orders;


-- 17. EMPLOYEE SALARY CATEGORY


SELECT 
    EmployeeID,
    FirstName,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;


-- SHOW ALL TABLE DATA


SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM Employees;