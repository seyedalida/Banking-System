CREATE VIEW customer_accounts AS
SELECT first_name, last_name, phone_number, account_ID, account_type, account_balance
FROM person NATURAL JOIN customer NATURAL JOIN account;

CREATE VIEW bank_transactions AS
SELECT *
FROM transaction;

CREATE View bank_member AS
SELECT person_ID, first_name, last_name, email, phone_number,
    (CASE
    WHEN employee_ID IS NOT NULL THEN 'employee'
    WHEN customer_ID IS NOT NULL THEN 'customer'
END) AS member_type
FROM person NATURAL JOIN customer NATURAL JOIN employee;

