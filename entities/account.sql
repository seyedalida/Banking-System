CREATE TABLE account (
    account_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_ID INT NOT NULL,
    account_type VARCHAR(15) NOT NULL,
    account_balance DECIMAL(15, 2) DEFAULT 0,
    account_status ENUM(
        'active',
        'suspended',
        'closed'
    ) NOT NULL DEFAULT 'active',
    opened_date DATE,
    closed_date DATE,
    FOREIGN KEY (customer_ID) REFERENCES customer (customer_ID) ON DELETE CASCADE
);