import mariadb


class Crud:
    def __init__(self, host, user, password, database):
        try:
            self.connection = mariadb.connect(
                host=host,
                user=user,
                password=password,
                database=database
            )
            self.cursor = self.connection.cursor()
        except mariadb.Error as e:
            print(f"Error connecting to MariaDB: {e}")
            raise

    def insert(self, table, data):
        try:
            columns = ', '.join(data.keys())
            values = ', '.join(['%s'] * len(data))
            sql = f"INSERT INTO {table} ({columns}) VALUES ({values})"
            self.cursor.execute(sql, tuple(data.values()))
            self.connection.commit()
            print("Record inserted successfully.")
        except mariadb.Error as e:
            print(f"Error inserting record: {e}")

    def update(self, table, updates, conditions):
        try:
            set_clause = ', '.join([f"{key} = %s" for key in updates.keys()])
            where_clause = ' AND '.join(
                [f"{key} = %s" for key in conditions.keys()])
            query = f"UPDATE {table} SET {set_clause} WHERE {where_clause}"
            self.cursor.execute(query, tuple(updates.values()) +
                                tuple(conditions.values()))
            self.connection.commit()
            print("Record updated successfully.")
        except mariadb.Error as e:
            print(f"Error updating record: {e}")

    def delete(self, table, conditions):
        try:
            where_clause = ' AND '.join(
                [f"{key} = %s" for key in conditions.keys()])
            query = f"DELETE FROM {table} WHERE {where_clause}"
            self.cursor.execute(query, tuple(conditions.values()))
            self.connection.commit()
            print("Record deleted successfully.")
        except mariadb.Error as e:
            print(f"Error deleting record: {e}")

    def select(self, table, columns, conditions=None):
        try:
            columns_clause = ', '.join(columns)
            query = f"SELECT {columns_clause} FROM {table}"
            if conditions:
                where_clause = ' AND '.join(
                    [f"{key} = %s" for key in conditions.keys()])
                query += f" WHERE {where_clause}"
                self.cursor.execute(query, tuple(conditions.values()))
            else:
                self.cursor.execute(query)
            return self.cursor.fetchall()
        except mariadb.Error as e:
            print(f"Error selecting records: {e}")
