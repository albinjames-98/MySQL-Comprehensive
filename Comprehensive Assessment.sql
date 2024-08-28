CREATE DATABASE library;

USE library;

CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(255),
  Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(255),
  Position VARCHAR(100),
  Salary DECIMAL(10, 2),
  Branch_no INT,
  FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(255),
  Category VARCHAR(100),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(5),
  Author VARCHAR(100),
  Publisher VARCHAR(100)
);

CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(255),
  Customer_address VARCHAR(255),
  Reg_date DATE
);

CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book VARCHAR(20),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(255),
  Return_date DATE,
  Isbn_book2 VARCHAR(20),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 1, 'Thrissur IJK', '8906546780'),
(2, 2, 'Thrissur TPR', '9876543210'),
(3, 3, 'Eranakulam VYT', '9086536800'),
(4,4, ' Eranakulam COH ', '8903345678'),
(5,5, ' Kotayam PALA ' , '7025047252');


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(1, 'John Don', 'Manager', 50000.00, 1),
(2, 'Jane Aju', 'Assistant Manager', 40000.00, 1),
(3, 'Anna Albin', 'Manager', 55000.00, 2),
(4, 'Alice Jake', 'Librarian', 35000.00, 2),
(5, 'Albin James', 'Manager', 60000.00, 3);


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('1234567890', 'The Great Gatsby', 'Fiction', 10.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('2345678901', 'To Kill a Mockingbird', 'Fiction', 12.99, 'yes', 'Harper Lee', 'J.B. Lippincott'),
('3456789012', '1984', 'Science Fiction', 9.99, 'yes', 'George Orwell', 'Secker and Warburg'),
('4567890123', 'The Catcher in the Rye', 'Fiction', 11.99, 'yes', 'J.D. Salinger', 'Little, Brown'),
('5678901234', 'The History of the Decline and Fall of the Roman Empire', 'History', 20.00, 'yes', 'Edward Gibbon', 'Penguin');


INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'John Don', 'Thrissur IJK', '2022-01-01'),
(2, 'Jane Aju', 'Thrissur TPR', '2022-02-01'),
(3, 'Anna Albin', 'Eranakulam VYT', '2022-03-01'),
(4, 'Alice Jake', 'Eranakulam COH', '2022-04-01'),
(5, 'Albin James', 'Kotayam PALA', '2022-05-01');


INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'The Great Gatsby', '2022-06-01', '1234567890'),
(2, 2, 'To Kill a Mockingbird', '2022-07-01', '2345678901'),
(3, 3, '1984', '2022-08-01', '3456789012'),
(4, 4, 'The Catcher in the Rye', '2022-09-01', '4567890123'),
(5, 5, 'The History of the Decline and Fall of the Roman Empire', '2022-10-01', '5678901234');


INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'The Great Gatsby', '2022-07-01', '1234567890'),
(2, 2, 'To Kill a Mockingbird', '2022-08-01', '2345678901'),
(3, 3, '1984', '2022-09-01', '3456789012'),
(4, 4, 'The Catcher in the Rye', '2022-10-01', '4567890123'),
(5, 5, 'The History of the Decline and Fall of the Roman Empire', '2022-11-01', '5678901234');

-- 1 Retrieve the book title, category, and rental price of all available books

SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';


-- 2 List the employee names and their respective salaries in descending order of salary

SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- 3 Retrieve the book titles and the corresponding customers who have issued those books

SELECT B.Book_title, C.Customer_name 
FROM Books B 
JOIN IssueStatus I ON B.ISBN = I.Isbn_book 
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

-- 4 Display the total count of books in each category

SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

-- 5 Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000

SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

-- 6 List the customer names who registered before 2022-01-01 and have not issued any books yet

SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7 Display the branch numbers and the total count of employees in each branch

SELECT B.Branch_no, COUNT(*) AS Total_Employees 
FROM Branch B 
JOIN Employee E ON B.Branch_no = E.Branch_no 
GROUP BY B.Branch_no;

-- 8 Display the names of customers who have issued books in the month of June 2023

SELECT C.Customer_name 
FROM Customer C 
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust 
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;


-- 9 Retrieve book_title from book table containing history

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';


-- 10 Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

SELECT B.Branch_no, COUNT(*) AS Total_Employees 
FROM Branch B 
JOIN Employee E ON B.Branch_no = E.Branch_no 
GROUP BY B.Branch_no 
HAVING COUNT(*) > 5;

-- 11 Retrieve the names of employees who manage branches and their respective branch addresses

SELECT E.Emp_name, B.Branch_address 
FROM Employee E 
JOIN Branch B ON E.Branch_no = B.Branch_no 
WHERE E.Position = 'Manager';


-- 12 Display the names of customers who have issued books with a rental price higher than Rs. 25

SELECT C.Customer_name 
FROM Customer C 
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust 
JOIN Books B ON I.Isbn_book = B.ISBN 
WHERE B.Rental_Price > 25;
