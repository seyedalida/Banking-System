-- set opened date for new account 
CREATE TRIGGER set_account_opened_date
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
    SET NEW.opened_date = CURDATE();
END;

-- prevent delete customer with approved (active) loan
DELIMITER //
CREATE TRIGGER prevent_delete_customer
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM bank_loan
        WHERE borrower_ID = OLD.customer_ID AND loan_status = 'approved'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete customer with approved loans';
    END IF;
END //
DELIMITER ;

--update account balance trigger
CREATE TRIGGER update_account_balance
AFTER INSERT ON transaction
FOR EACH ROW
BEGIN
    IF NEW.destination_account_ID IS NOT NULL THEN
        
        UPDATE account
        SET account_balance = account_balance - NEW.transaction_amount
        WHERE account_ID = NEW.source_account_ID;

        UPDATE account
        SET account_balance = account_balance + NEW.transaction_amount
        WHERE account_ID = NEW.destination_account_ID;
    ELSE
        UPDATE account
        SET account_balance = account_balance + NEW.transaction_amount
        WHERE account_ID = NEW.source_account_ID;
    END IF;
END;

--check have enough balance for transaction
DELIMITER //

CREATE TRIGGER check_balance
BEFORE INSERT ON transaction
FOR EACH ROW
BEGIN
    DECLARE source_balance DECIMAL(15, 2);
    SELECT account_balance INTO source_balance
    FROM account
    WHERE account_ID = NEW.source_account_ID;
    IF (NEW.transaction_amount < 0 AND NEW.destination_account_ID IS NULL AND source_balance < ABS(NEW.transaction_amount)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance for withdrawal';
    ELSEIF (NEW.transaction_amount > 0 AND NEW.destination_account_ID IS NOT NULL AND source_balance < NEW.transaction_amount) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance for transfer';
    END IF;
END //
DELIMITER ;


--calculate total balance for each customer
DELIMITER //
CREATE FUNCTION get_total_balance(input_customer_ID INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE total_balance DECIMAL(15, 2);
    SELECT COALESCE(SUM(account_balance), 0) INTO total_balance
    FROM account
    WHERE customer_ID = input_customer_ID;
    RETURN total_balance;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION check_loan_status(input_loan_ID INT)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
    DECLARE loan_status VARCHAR(15);
    IF EXISTS (
        SELECT 1 
        FROM bank_loan AS L
        WHERE L.loan_ID = input_loan_ID 
          AND (
              (L.loan_status = 'approved' AND L.payed_amount_sum = L.loan_amount) 
              OR L.loan_status = 'completed' 
              OR L.end_date < CURDATE()
          )
    ) THEN
        SET loan_status = 'paid';
    ELSE
        SET loan_status = 'active';
    END IF;
    RETURN loan_status;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION get_active_loans(input_customer_ID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE active_loans_count INT;
    SELECT COUNT(*) INTO active_loans_count
    FROM bank_loan
    WHERE borrower_ID = input_customer_ID AND loan_status = 'approved' AND payed_amount_sum < loan_amount AND end_date >= CURDATE();
    RETURN active_loans_count;
END //
DELIMITER ;

-- sum of paid amounts for a loan
DELIMITER //
CREATE FUNCTION loan_paid(input_loan_ID INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE paid_amount DECIMAL(15, 2);
    SELECT COALESCE(SUM(payment_amount), 0) INTO paid_amount
    FROM bank_loan L NATURAL JOIN installment NATURAL JOIN installment_payment
    WHERE L.loan_ID = input_loan_ID;
    RETURN paid_amount;
END //
DELIMITER ;

-- get customer info
DELIMITER //
CREATE PROCEDURE get_customer_info(input_customer_ID INT)
BEGIN
    SELECT first_name, last_name
    FROM person
    WHERE person_ID = (
        SELECT person_ID
        FROM customer
        WHERE customer_ID = input_customer_ID
    );
END //
DELIMITER ;