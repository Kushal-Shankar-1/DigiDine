from mysql.connector import pooling, Error

from config import Config

# Configuration for your database
dbconfig = {
    "host": Config.DB_HOST,
    "user": Config.DB_USER,
    "password": Config.DB_PASSWORD,
    "database": Config.DB_NAME
}

# Creating a connection pool
cnxpool = pooling.MySQLConnectionPool(pool_name="mypool",
                                      pool_size=10,  # Adjust pool size based on your requirements
                                      **dbconfig)


def create_db_connection():
    try:
        connection = cnxpool.get_connection()
        return connection
    except Error as e:
        print(f"The error '{e}' occurred")
        return None


def execute_query(query, params=None):
    connection = create_db_connection()
    if connection is not None:
        cursor = connection.cursor()
        try:
            cursor.execute(query, params or ())
            connection.commit()
        except Error as err:
            print(f"Error: '{err}'")
        finally:
            cursor.close()
            connection.close()


def execute_read_query(query):
    connection = create_db_connection()
    if connection is not None:
        cursor = connection.cursor()
        result = None
        try:
            cursor.execute(query)
            result = cursor.fetchall()
            return result
        except Error as err:
            print(f"Error: '{err}'")
        finally:
            cursor.close()
            connection.close()


def execute_stored_procedure(proc_name, params):
    connection = create_db_connection()
    if connection is not None:
        cursor = connection.cursor()
        try:
            cursor.callproc(proc_name, params)
            connection.commit()
            # Fetching results if the stored procedure returns any
            results = []
            for result_set in cursor.stored_results():
                results.append(result_set.fetchall())
            return results
        finally:
            cursor.close()
            connection.close()
