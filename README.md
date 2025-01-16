# Banking System Project

This repository contains a database management system project for a banking system. The project is divided into multiple components and phases to design, implement, and test a robust system for managing bank accounts, loans, employees, customers, and transactions.

---

## Project Structure

The repository is organized into the following directories and files:

### **0. Docs**

This folder contains documentation for the project phases.

### **1. Diagrams**

Contains the ER (Entity-Relationship) diagram and database schema:

- `er.drawio`: Editable ER diagram.
- `schema.drawio`: Editable database schema.

### **2. Entities**

This folder contains the SQL files defining the database schema for the project.

### **3. Tasks**

Scripts and SQL files for database operations and functionalities:

- `access.sql`: Scripts for managing user access and privileges.
- `crud.py`: Python script that provides 4 dynamic CRUD methods for executing insert, select, update, and delete queries.
- `functions.sql`: SQL functions for specific database tasks.
- `queries.sql`: SQL queries for extracting data from the database.
- `test.py`: Python script for testing database functions and queries.
- `transaction.sql`: Schema for handling transactions.
- `views.sql`: SQL views for pre-defined queries.

### **4. Reports**

This folder will include work reports for the project phases:

- `P1_Report.pdf`: Work report for Phase 1.
- `P2_Report.pdf`: Work report for Phase 2.

---

## How to Use

### **1. Database Setup**

1. Create a MariaDB or MySQL database.
2. Execute the schema files in the `entities` directory to initialize the database structure.
3. Populate the database using sample data or queries provided in `queries.sql`.
4. Additionally, utilize the `views.sql`, `access.sql`, and `functions.sql` files to set up predefined views, manage user access, and implement reusable database functions.

### **2. Run the Project**

1. Make sure to set up the MariaDB package by executing `pip install mariadb` in your virtual environment.
2. Use the `crud.py` file to interact with the database and perform operations.
3. Test the system with the `test.py` script, which demonstrates the functionality of the `crud.py` file, including its dynamic CRUD operations.

### **3. Visualize the Schema**

Refer to the diagrams in the `diagrams` folder to understand the database structure and relationships.

---

## Features

- **User Management**: Manage customers, employees, and their roles.
- **Account Management**: CRUD operations for bank accounts.
- **Loan Management**: Handle loans and installment payments.
- **Transactions**: Record and manage financial transactions.
- **SQL Views and Functions**: Predefined views and reusable functions.
- **Testing**: Python scripts for validating functionalities.

---

## License

This project is licensed under the [MIT License](LICENSE).
