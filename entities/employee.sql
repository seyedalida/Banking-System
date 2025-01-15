CREATE TABLE employee (
    employee_ID INT PRIMARY KEY,
    person_ID INT NOT NULL,
    job_position VARCHAR(15) NOT NULL,
    FOREIGN KEY (person_ID) REFERENCES person (person_ID) ON DELETE CASCADE
);