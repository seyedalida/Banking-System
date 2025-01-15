CREATE TABLE customer (
    customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    person_ID INT NOT NULL,
    customer_type ENUM(
        'individual',
        'corporate'
    ) NOT NULL,
    FOREIGN KEY (person_ID) REFERENCES person (person_ID) ON DELETE CASCADE
);