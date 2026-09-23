-- 1. Create Customers Core Account Directory
CREATE TABLE bank_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    kyc_status VARCHAR(20),
    credit_score INT
);

-- 2. Create Issued Credit Cards Master Table
CREATE TABLE credit_cards (
    card_number VARCHAR(20) PRIMARY KEY,
    customer_id INT,
    card_type VARCHAR(20),
    monthly_limit DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES bank_customers(customer_id)
);

-- 3. Create Live Card Transaction Ledger
CREATE TABLE card_transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    card_number VARCHAR(20),
    tx_time DATETIME,
    amount DECIMAL(10,2),
    merchant_category VARCHAR(50),
    tx_country VARCHAR(50),
    is_disputed INT,
    FOREIGN KEY (card_number) REFERENCES credit_cards(card_number)
);

-- 4. Inject Mock Financial Data
INSERT INTO bank_customers VALUES 
(301, 'Rajesh Malhotra', 'Verified', 780),
(302, 'Sara Jenkins', 'Verified', 620),
(303, 'Anya Ivanova', 'Pending', 450);

INSERT INTO credit_cards VALUES 
('4111-XXXX-1111', 301, 'Signature', 5000.00),
('4111-XXXX-2222', 302, 'Gold', 1500.00),
('4111-XXXX-3333', 303, 'Platinum', 3000.00);

INSERT INTO card_transactions VALUES 
('tx901', '4111-XXXX-1111', '2026-03-01 10:00:00', 120.50, 'Groceries', 'India', 0),
('tx902', '4111-XXXX-1111', '2026-03-01 14:30:00', 2500.00, 'Electronics', 'India', 0),
('tx903', '4111-XXXX-2222', '2026-03-02 01:15:00', 1400.00, 'Crypto Exchange', 'Russia', 1),
('tx904', '4111-XXXX-2222', '2026-03-02 01:17:00', 85.00, 'Luxury Retail', 'Russia', 1),
('tx905', '4111-XXXX-3333', '2026-03-05 18:00:00', 2900.00, 'Luxury Retail', 'UK', 0),
('tx906', '4111-XXXX-1111', '2026-03-06 20:00:00', 450.00, 'Travel', 'Dubai', 0),
('tx907', '4111-XXXX-3333', '2026-03-07 09:30:00', 350.00, 'Groceries', 'Russia', 1);
