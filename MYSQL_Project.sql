
/* You are going to build a project based on the Library Management System. It
keeps track of all information about books in the library, their cost, status and
total number of books available in the library.
Create a database named library and create following TABLES in the database:
1. Branch
2. Employee
3. Customer
4. IssueStatus
5. ReturnStatus
6. Books
Attributes for the tables:
1. Branch
∙Branch_no - Set as PRIMARY KEY
∙Manager_Id
∙Branch_address
∙Contact_no
2. Employee
∙Emp_Id – Set as PRIMARY KEY
∙Emp_name
∙Position
∙Salary
∙Branch_no - Set as FOREIGN KEY and it should refer branch_no in
EMPLOYEE table
3. Customer
∙Customer_Id - Set as PRIMARY KEY
∙Customer_name
∙Customer_address
∙Reg_date
4. IssueStatus
∙Issue_Id - Set as PRIMARY KEY
∙Issued_cust – Set as FOREIGN KEY and it refer customer_id in
CUSTOMER table
∙Issued_book_name
∙Issue_date
∙Isbn_book – Set as FOREIGN KEY and it should refer isbn in
BOOKS table
5. ReturnStatus
∙Return_Id - Set as PRIMARY KEY
∙Return_cust
∙Return_book_name
∙Return_date
∙Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in
BOOKS table
6. Books
∙ISBN - Set as PRIMARY KEY
∙Book_title
∙Category
∙Rental_Price
∙Status [Give yes if book available and no if book not available] ∙
.Author
∙Publisher
*/

CREATE DATABASE LIBRARY;

USE LIBRARY;

CREATE TABLE BRANCH(
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(150),
Contact_no BIGINT);

INSERT INTO BRANCH VALUES
(1, 101, '123 Main Street', '1234567890'),
(2, 102, '456 Elm Street', '9876543210'),
(3, 103, '789 Oak Street', '4567890123'),
(4, 104, '321 Pine Street', '7890123456'),
(5, 105, '567 Maple Street', '0123456789');

SELECT * FROM BRANCH;

CREATE TABLE EMPLOYEE(
Emp_Id VARCHAR(50),
Emp_name VARCHAR(50),
Position VARCHAR(50),
Salary DECIMAL(10,2),
Branch_no INT,
FOREIGN KEY(Branch_no)REFERENCES BRANCH(Branch_no)
);

INSERT INTO EMPLOYEE VALUES
(201, 'John Doe', 'Manager', 60000, 1),
(202, 'Jane Smith', 'Assistant Manager', 50000, 1),
(203, 'David Johnson', 'Clerk', 40000, 2),
(204, 'Mary Brown', 'Librarian', 45000, 3),
(205, 'Michael Lee', 'Clerk', 38000, 4);

SELECT * FROM EMPLOYEE;
 
CREATE TABLE CUSTOMER(
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(100),
Customer_address VARCHAR(100),
Reg_date DATE
);

INSERT INTO CUSTOMER VALUES
(301, 'Alice Johnson', '123 Oak Lane', '2021-12-15'),
(302, 'Bob Williams', '456 Pine Street', '2022-02-20'),
(303, 'Carol Davis', '789 Elm Avenue', '2022-03-10'),
(304, 'David Miller', '321 Maple Road', '2022-04-05'),
(305, 'Emma Wilson', '567 Cedar Court', '2022-05-15');

SELECT * FROM CUSTOMER;

CREATE TABLE ISSUESTATUS(
Issue_id INT PRIMARY KEY,
Issue_cust INT,
Issued_book_name VARCHAR(100),
Issue_date DATE,
Isbn_book INT,
FOREIGN KEY(Issue_cust)REFERENCES CUSTOMER(Customer_Id),  
FOREIGN KEY(Isbn_book)REFERENCES BOOKS(Isbn)
);

INSERT INTO ISSUESTATUS VALUES
(401, 301, 'Introduction to SQL', '2023-06-05', 101),
(402, 302, 'Python Crash Course', '2023-07-10', 102),
(403, 303, 'The Great Gatsby', '2023-08-15', 103),
(404, 304, 'To Kill a Mockingbird', '2023-09-20',104),
(405, 305, 'Pride and Prejudice', '2023-10-25', 105);

SELECT * FROM ISSUESTATUS;

CREATE TABLE RETURNSTATUS(
Return_Id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(100),
Return_date DATE,
Isbn_book2 INT,
FOREIGN KEY(Isbn_book2)REFERENCES BOOKS(Isbn)
);  

INSERT INTO RETURNSTATUS VALUES
(501, 301, 'Introduction to SQL', '2023-06-25', 101),
(502, 302, 'Python Crash Course', '2023-07-20', 102),
(503, 303, 'The Great Gatsby', '2023-08-25', 103),
(504, 304, 'To Kill a Mockingbird', '2023-09-30', 104),
(505, 305, 'Pride and Prejudice', '2023-10-30', 104);

SELECT * FROM RETURNSTATUS;

CREATE TABLE BOOKS(
Isbn INT PRIMARY KEY,
Book_title VARCHAR(100),
Category VARCHAR(100),
Rental_price INT,
Status ENUM('YES','NO'),
Author VARCHAR(100),
Publisher VARCHAR(100)
);

INSERT INTO BOOKS VALUES
(101, 'Introduction to SQL', 'Computer Science', 10.99, 'yes', 'Rick Lantz', 'No Starch Press'),
(102, 'Python Crash Course', 'Computer Science', 12.99, 'no', 'Eric Matthes', 'No Starch Press'),
(103, 'The Great Gatsby', 'Fiction', 8.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
(104, 'To Kill a Mockingbird', 'Fiction', 7.99, 'no', 'Harper Lee', 'Harper Perennial Modern Classics'),
(105, 'Pride and Prejudice', 'Classic', 9.99, 'yes', 'Jane Austen', 'Simon & Brown');

SELECT * FROM BOOKS;

 /* Write the queries for the following:
1. Retrieve the book title, category, and rental price of all available
books.*/

SELECT Book_title,Category,Rental_price FROM BOOKS WHERE Status='YES';

/*2. List the employee names and their respective salaries in descending
order of salary.*/

SELECT Emp_name,Salary  FROM EMPLOYEE ORDER By Salary DESC;

/*3. Retrieve the book titles and the corresponding customers who have
issued those books.*/

SELECT b.Book_title,i.Issue_cust AS Customer_name FROM BOOKS b INNER JOIN ISSUESTATUS i ON
b.Isbn=i.Isbn_book;

/* 4. Display the total count of books in each category.*/

SELECT Category,COUNT(*) As Total_count FROM BOOKS Group by Category;

/* 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.*/

SELECT Emp_name,Position FROM EMPLOYEE WHERE Salary>50000;

/* 6. List the customer names who registered before 2022-01-01 and have
not issued any books yet.*/

SELECT Customer_name FROM CUSTOMER WHERE Reg_date<'222-01-01'AND Customer_Id NOT IN
(SELECT Issue_cust FROM ISSUESTATUS);

/* 7. Display the branch numbers and the total count of employees in each
branch.*/

SELECT Branch_no,COUNT(*) AS Total_employee FROM EMPLOYEE GROUP BY Branch_no;

/* 8. Display the names of customers who have issued books in the month
of June 2023.*/

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issue_cust
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

/* 9. Retrieve book_title from book table containing history. */

SELECT Book_title FROM BOOKS WHERE Category LIKE 'history';

/* 10.Retrieve the branch numbers along with the count of employees for branches
having more than 5 employees.*/

SELECT Branch_no,COUNT(*)AS Employee_count FROM EMPLOYEE GROUP BY Branch_no HAVING Employee_count>5;


 