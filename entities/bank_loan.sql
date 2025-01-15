CREATE TABLE bank_loan (
    loan_ID INT PRIMARY KEY,
    borrower_ID INT NOT NULL,
    loan_type VARCHAR(15) NOT NULL,
    loan_amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    payback_period INT,
    start_date DATE NOT NULL,
    end_date DATE,
    loan_status ENUM(
        'pending',
        'approved',
        'rejected',
        'completed'
    ) DEFAULT 'pending',
    installments_count INT,
    paid_amount_sum DECIMAL(15, 2) DEFAULT 0,
    FOREIGN KEY (borrower_ID) REFERENCES customer (customer_ID) ON DELETE CASCADE
);
