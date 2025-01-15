CREATE TABLE installment (
    installment_ID INT PRIMARY KEY,
    loan_ID INT NOT NULL,
    payment_deadline DATE NOT NULL,
    paid_date DATE,
    paid_amount DECIMAL(15, 2) DEFAULT 0,
    paid_interest DECIMAL(15, 2) DEFAULT 0,
    FOREIGN KEY (loan_ID) REFERENCES bank_loan (loan_ID) ON DELETE CASCADE
);