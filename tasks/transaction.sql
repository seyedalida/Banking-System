CREATE TABLE transaction (
    transaction_ID INT PRIMARY KEY,
    source_account_ID INT NOT NULL,
    destination_account_ID INT,
    transaction_amount DECIMAL(15, 2) NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (source_account_ID) REFERENCES account (account_ID),
    FOREIGN KEY (destination_account_ID) REFERENCES account (account_ID)
);