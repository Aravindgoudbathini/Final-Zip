-- Create the database
CREATE DATABASE IF NOT EXISTS BIS698W1700_GRP13;
USE BIS698W1700_GRP13;

-- Drop existing tables (if needed)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- Users table
CREATE TABLE users (
    userid VARCHAR(50) PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'customer') NOT NULL DEFAULT 'customer',
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active'
);

-- Products table
CREATE TABLE products (
    productid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    image VARCHAR(255) NOT NULL,
    availability ENUM('available', 'not available') NOT NULL DEFAULT 'available'
);

-- Orders table
CREATE TABLE orders (
    orderid INT AUTO_INCREMENT PRIMARY KEY,
    userid VARCHAR(50) NOT NULL,
    items TEXT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status ENUM('pending', 'shipped', 'delivered') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userid) REFERENCES users(userid)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert default users
INSERT INTO users (userid, firstname, lastname, username, email, phone_number, password, role, status) VALUES
('U1001', 'Admin', 'User', 'admin', 'admin@ims.com', '9876543210', 'admin123', 'admin', 'active'),
('U1002', 'John', 'Doe', 'john_doe', 'john@example.com', '9234567890', 'customer123', 'customer', 'active'),
('U1003', 'Jane', 'Smith', 'jane_smith', 'jane@example.com', '9123456789', 'customer456', 'customer', 'inactive');

-- Insert sample products
INSERT INTO products (name, description, price, stock, image, availability) VALUES
('Laptop', 'High-performance laptop.', 899.99, 10, 'images/laptop.jpg', 'available'),
('Smartphone', 'Latest model smartphone.', 599.99, 0, 'images/phone.jpeg', 'not available'),
('Headphones', 'Wireless noise-canceling headphones.', 199.99, 15, 'images/headphones.png', 'available'),
('Smartwatch', 'Fitness tracking smartwatch.', 149.99, 0, 'images/smartwatch.png', 'not available'),
('Camera', 'Professional DSLR camera.', 749.99, 8, 'images/camera.jpeg', 'available');

-- Insert sample orders
INSERT INTO orders (userid, items, total_price, status) VALUES
('U1002', 'Laptop, Headphones', 1099.98, 'pending'),
('U1003', 'Smartphone, Smartwatch', 748.99, 'shipped');
