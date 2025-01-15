CREATE TABLE installment_payment (
    installment_payment_ID INT PRIMARY KEY,
    installment_ID INT NOT NULL,
    transaction_ID INT NOT NULL,
    FOREIGN KEY (installment_ID) REFERENCES installment (installment_ID),
    FOREIGN KEY (transaction_ID) REFERENCES transaction (transaction_ID),
);