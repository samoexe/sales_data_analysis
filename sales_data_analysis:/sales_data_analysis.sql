
USE sales_data_analysis;

CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    position VARCHAR(100),
    hire_date DATE,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    region_id INT,

    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    employee_id INT,
    sales_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES  products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


INSERT INTO regions (region_name) VALUES
('North'),
('South'),
('East'),
('West');

INSERT INTO employees (first_name, last_name, position, hire_date, region_id) VALUES
('Alice', 'Smith', 'Sales Manager', '2022-01-15', 1),
('Bob', 'Johnson', 'Sales Executive', '2023-03-22', 2),
('Carol', 'Williams', 'Sales Executive', '2022-07-10', 3),
('David', 'Brown', 'Sales Representative', '2023-01-05', 4);

INSERT INTO customers (first_name, last_name, email, phone, city, region_id) VALUES
('Eve', 'Davis', 'eve.davis@example.com', '555-1234', 'New York', 1),
('Frank', 'Miller', 'frank.miller@example.com', '555-5678', 'Los Angeles', 2),
('Grace', 'Wilson', 'grace.wilson@example.com', '555-8765', 'Chicago', 3),
('Hank', 'Moore', 'hank.moore@example.com', '555-4321', 'Houston', 4);

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Notebook', 'Stationery', 5.00);

INSERT INTO sales (customer_id, product_id, employee_id, sales_date, quantity, total_amount) VALUES
(1, 1, 1, '2025-10-01', 2, 2400.00),
(2, 2, 2, '2025-10-02', 1, 800.00),
(3, 3, 3, '2025-10-03', 4, 600.00),
(4, 4, 4, '2025-10-04', 10, 50.00),
(1, 2, 1, '2025-10-05', 1, 800.00);


SELECT r.region_name, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
JOIN regions r ON e.region_id = r.region_id
GROUP BY r.region_name;


SELECT e.first_name, e.last_name, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN employees e on s.employee_id = e.employee_id
GROUP BY e.employee_id
ORDER BY total_sales DESC;


SELECT p.product_name, SUM(s.quantity) AS total_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC;


SELECT c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;