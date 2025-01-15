import mariadb
import crud
db = crud.crud(host='localhost', user='root',
          password='5013', database='testdb')
mr_mills = {
    "first_name": "David",
    "last_name": "Mills",
    "birth_date": "1985-11-02",
    "phone_number": "2145551234",
    "email": "davidmillss8@gmail.com",
    "residential_address": "12 Main St"
}
db.insert("person", mr_mills)
input("Check person table. Press Enter to continue...")

db.insert("customer", {"person_ID": "1", "customer_type": "individual"})
input("Check customer table. Press Enter to continue...")

db.insert("account", {"account_ID": "1921072918", "customer_ID": 1, "account_type": "deposit",
          "account_balance": 5000, "opened_date": "2025-01-11"})
input("Check account table. Press Enter to continue...")

db.update("person", {"residential_address": "456 Elm St"}, {"person_ID": "1"})
input("Check person table. Address of Mr.Mills has changed. Press Enter to continue...")

db.update("account", {"account_status": "suspended"}, {"account_ID": "1921072918"})
input("Check account table. Account status has changed. Press Enter to continue...")

person1 = {
    'first_name': 'John',
    'last_name': 'Doe',
    'birth_date': '1990-01-01',
    'phone_number': '1234567890',
    'email': 'john.doe@example.com',
    'residential_address': '123 Main St, City, Country'
}

person2 = {
    'first_name': 'Jane',
    'last_name': 'Smith',
    'birth_date': '1985-06-15',
    'phone_number': '0987654321',
    'email': 'jane.smith@example.com',
    'residential_address': '456 Elm St, City, Country'
}

person3 = {
    'first_name': 'Alice',
    'last_name': 'Johnson',
    'birth_date': '1995-03-22',
    'phone_number': '1122334455',
    'email': 'alice.j@example.com',
    'residential_address': '789 Maple Ave, City, Country'
}

db.insert("person", person1)
db.insert("person", person2)
db.insert("person", person3)

select_outputs = db.select("person", ["first_name", "last_name"])
print(select_outputs)
input("Check person table. Press Enter to continue...")

db.insert("customer", {"customer_ID": 12345, "person_ID": 1, "customer_type": "individual"})
db.insert("customer", {"customer_ID": 12346, "customer_type": "corporate"})
db.insert("customer", {"customer_ID": 12347, "customer_type": "individual"})
select_outputs = db.select("customer", ["*"])
print(select_outputs)
input("Check customer table. Press Enter to continue...")

db.insert("account", {"account_ID": 1921072918, "customer_ID": 12345, "account_type": "deposit",
            "account_balance": 5000, "opened_date": "2025-01-11"})
db.insert("account", {"account_ID": 1921072919, "customer_ID": 12346, "account_type": "loan",
            "account_balance": 10000, "opened_date": "2025-01-11"})
db.insert("account", {"account_ID": 1921072920, "customer_ID": 12347, "account_type": "deposit",
            "account_balance": 1000, "opened_date": "2025-01-11"})
select_outputs = db.select("account", ["*"])
print(select_outputs)
input("Check account table. Press Enter to continue...")

db.connection.close()