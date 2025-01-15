CREATE TABLE person (
    person_ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    birth_date DATE,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(63) UNIQUE,
    residential_address VARCHAR(255)
);