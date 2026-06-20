CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

-- Sensitive Table (Target for Attack)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50)
);

INSERT INTO users (username, password) VALUES
('admin', 'SuperSecretAdmin123'),
('vghodke', 'MySecurePass!'),
('john', 'john123');

-- Public Table (Used by the Application)
CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(50),
    balance VARCHAR(50)
);

INSERT INTO accounts (account_number, balance) VALUES
('1001', '$5,000.00'),
('1002', '$250.50'),
('1003', '$1,000,000.00');
