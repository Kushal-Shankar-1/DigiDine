import mysql.connector
from mysql.connector import Error
from config import Config

def create_db_connection():
    try:
        connection = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME
        )
        return connection
    except Error as e:
        print(f"The error '{e}' occurred")
        return None

def execute_query(connection, query, params=None):
    cursor = connection.cursor()
    try:
        cursor.execute(query, params or ())
        connection.commit()
    except Error as err:
        print(f"Error: '{err}'")
    finally:
        cursor.close()
        connection.close()

def execute_read_query(connection, query):
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
    cursor = connection.cursor()
    cursor.callproc(proc_name, params)
    connection.commit()
    cursor.close()
    connection.close()