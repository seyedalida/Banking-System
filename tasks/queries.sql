-- 1
INSERT INTO person(person_ID, first_name, last_name, birth_date, phone_number, email, residential_address)
VALUES (1221, "John", "Doe", "1990-01-01", "1234567890", "0912345", "iran shiraz");
INSERT INTO person VALUES (1382, "agha", "seyyed", "1990-01-01", "1234567890", "0913345", "iran yazd");
-- 2
INSERT INTO customer(customer_ID, person_ID, customer_type)
VALUES (1284, 1221, "individual");

INSERT INTO account(account_ID, `customer_ID`, account_type, account_balance, account_status, opened_date, closed_date)
VALUES (1227, 1284, "saving", 1000, "active", "2022-01-01", NULL),
       (1230, 1284, "current", 500, "active", "2022-01-02", NULL),
       (1231, 1284, "saving", 2000, "active", "2022-01-03", NULL);

-- some transactions for account 1227
INSERT INTO transaction(transaction_ID, source_account_id, `destination_account_ID`, transaction_amount, transaction_date)
VALUES (1227, 1227, NULL, +100, "2022-01-01"),
       (1228, 1227, NULL, +200, "2022-01-02"),
       (1229, 1227, NULL, -300, "2022-01-03");

-- 3    
DELIMITER //

CREATE PROCEDURE get_account_transactions(IN account_ID INT)
BEGIN
    SELECT transaction_ID, source_account_ID, destination_account_ID, transaction_amount, transaction_date
    FROM transaction
    WHERE source_account_ID = account_ID OR destination_account_ID = account_ID;
END //
DELIMITER ;
CALL get_account_transactions(1230);

-- INSERT INTO bank_loan (loan_ID, borrower_ID, loan_type, loan_amount, interest_rate, payback_period,
-- start_date, end_date, loan_status, installments_count, payed_amount_sum)
-- VALUES (1, 1284, 'personal', 1000000, 0.1, 12, '2020-01-01', '2021-01-01', 'approved', 12, 0),
-- (2, 1284, 'personal', 2000000, 0.1, 12, '2020-01-01', '2021-01-01', 'pending', 5, 0);

-- 4
SELECT * FROM bank_loan WHERE loan_status = "approved";

-- 5
SELECT * FROM account WHERE account_balance > 1000;

-- 6
SELECT first_name, last_name, sum(account_balance) as total_balance, account_type
FROM person NATURAL JOIN customer NATURAL JOIN account
GROUP BY customer_ID, account_type;

-- INSERT INTO employee(`employee_ID`, `person_ID`, job_position)
-- VALUES (1234, 1221, "manager");

-- 7
SELECT first_name, last_name, loan_amount
FROM person NATURAL JOIN customer NATURAL JOIN employee JOIN bank_loan on `customer_ID` = bank_loan.borrower_ID
WHERE loan_status = "approved";

-- 8
SELECT `customer_ID`, first_name, last_name, COUNT (*) as number_of_accounts
FROM person NATURAL JOIN customer NATURAL JOIN account
GROUP BY customer_ID 
HAVING COUNT (*) > 1;




-- emtiazi
-- 1
WITH ranked_customers AS (
    SELECT customer_ID, first_name, last_name, COUNT(loan_ID) AS loan_count, RANK() OVER (ORDER BY COUNT(loan_ID) DESC) AS rank
    FROM person NATURAL JOIN customer NATURAL JOIN bank_loan
    GROUP BY customer_ID, first_name, last_name
)
SELECT first_name, last_name, loan_count
FROM ranked_customers
WHERE rank = 1;

-- 2
WITH ranked_loans AS (
    SELECT loan_ID, `borrower_ID`, installments_count, RANK() OVER (ORDER BY installments_count ASC) AS rank
    FROM bank_loan
)
SELECT loan_ID, `borrower_ID`, installments_count
FROM ranked_loans
WHERE rank <= 5;

-- 3
SELECT first_name, last_name, loan_ID, loan_amount
FROM person NATURAL JOIN customer NATURAL JOIN bank_loan as loan
WHERE EXISTS (
    SELECT * 
    FROM bank_loan NATURAL JOIN installment
    WHERE loan.loan_ID = loan_ID AND payed_date > payment_deadline
)

-- 4
WITH ranked_customers AS (
    SELECT customer_ID, first_name, last_name, SUM(account_balance) AS total_balance,
    RANK() OVER (ORDER BY SUM(account_balance) DESC) AS rankT
    FROM person NATURAL JOIN customer NATURAL JOIN account
    GROUP BY customer_ID, first_name, last_name
)
SELECT first_name, last_name, total_balance
FROM ranked_customers
WHERE rankT <= 5;

