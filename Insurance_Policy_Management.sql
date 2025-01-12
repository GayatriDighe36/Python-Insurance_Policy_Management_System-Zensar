-- Create Database
CREATE DATABASE InsuranceDB;

-- Use the database
USE InsuranceDB;

-- Create Customers table
CREATE TABLE Customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15)
);

-- Create Policies table
CREATE TABLE Policies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    policy_number VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    premium DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

-- Create Claims table
CREATE TABLE Claims (
    id INT AUTO_INCREMENT PRIMARY KEY,
    policy_id INT,
    claim_date DATE,
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    FOREIGN KEY (policy_id) REFERENCES Policies(id)
);

-- Create Renewals table
CREATE TABLE Renewals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    policy_id INT,
    renewal_date DATE,
    renewed BOOLEAN,
    FOREIGN KEY (policy_id) REFERENCES Policies(id)
);

-- Insert sample data into Customers table
INSERT INTO Customers (name, email, phone)
VALUES 
('John Doe', 'john.doe@example.com', '1234567890'),
('Jane Smith', 'jane.smith@example.com', '9876543210'),
('Alice Johnson', 'alice.j@example.com', '5551234567');

-- Insert sample data into Policies table
INSERT INTO Policies (customer_id, policy_number, type, start_date, end_date, premium)
VALUES
(1, 'POL12345', 'Health', '2023-01-01', '2023-12-31', 1200.50),
(2, 'POL67890', 'Life', '2023-02-01', '2024-01-31', 1500.75),
(3, 'POL11121', 'Auto', '2023-03-01', '2023-09-01', 800.00);

-- Insert sample data into Claims table
INSERT INTO Claims (policy_id, claim_date, amount, status)
VALUES
(1, '2023-06-15', 300.00, 'Approved'),
(2, '2023-07-20', 500.00, 'Pending'),
(3, '2023-05-10', 200.00, 'Rejected');

-- Insert sample data into Renewals table
INSERT INTO Renewals (policy_id, renewal_date, renewed)
VALUES
(1, '2023-12-15', FALSE),
(2, '2024-01-10', FALSE),
(3, '2023-09-01', TRUE);

