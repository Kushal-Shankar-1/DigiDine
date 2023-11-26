from flask import Flask, jsonify, request
import mysql.connector
from mysql.connector import Error
import logging

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.DEBUG, filename='digidine.log',
                    format='%(asctime)s %(levelname)s %(name)s : %(message)s')


# Database connection function
def create_db_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="your_username",
            password="your_password",
            database="digidine"
        )
        return connection
    except Error as e:
        app.logger.error(f"The error '{e}' occurred")
        return None


# Function to execute INSERT, UPDATE, DELETE queries
def execute_query(connection, query, params=None):
    cursor = connection.cursor()
    try:
        cursor.execute(query, params or ())
        connection.commit()
        app.logger.info("Query successful")
    except Error as err:
        app.logger.error(f"Error: '{err}'")
    finally:
        cursor.close()
        connection.close()


# Function to execute SELECT queries
def execute_read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        app.logger.error(f"Error: '{err}'")
    finally:
        cursor.close()
        connection.close()


# Validate recipe data
def validate_recipe_data(title, description):
    errors = []
    if not title or not isinstance(title, str) or len(title.strip()) == 0:
        errors.append("Title is required and must be a string.")
    if not description or not isinstance(description, str) or len(description.strip()) == 0:
        errors.append("Description is required and must be a string.")
    return errors


# Route to add a new recipe
@app.route('/add_recipe', methods=['POST'])
def add_recipe():
    data = request.json
    title = data.get('title')
    description = data.get('description')

    validation_errors = validate_recipe_data(title, description)
    if validation_errors:
        return jsonify({"error": validation_errors}), 400

    connection = create_db_connection()
    if connection:
        add_recipe_query = "INSERT INTO recipes (title, description) VALUES (%s, %s)"
        execute_query(connection, add_recipe_query, (title, description))
        return jsonify({"message": "Recipe added successfully"}), 201
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Route to get all recipes
@app.route('/recipes', methods=['GET'])
def get_recipes():
    connection = create_db_connection()
    if connection:
        select_recipes_query = "SELECT * FROM recipes"
        recipes = execute_read_query(connection, select_recipes_query)
        recipes_list = [{"id": recipe[0], "title": recipe[1], "description": recipe[2]} for recipe in recipes]
        return jsonify(recipes_list), 200
    else:
        return jsonify({"error": "Failed to fetch recipes"}), 500


@app.route('/update_recipe/<int:id>', methods=['PUT'])
def update_recipe(id):
    data = request.json
    title = data.get('title')
    description = data.get('description')

    validation_errors = validate_recipe_data(title, description)
    if validation_errors:
        return jsonify({"error": validation_errors}), 400

    connection = create_db_connection()
    if connection:
        update_query = "UPDATE recipes SET title = %s, description = %s WHERE id = %s"
        execute_query(connection, update_query, (title, description, id))
        return jsonify({"message": "Recipe updated successfully"}), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


@app.route('/delete_recipe/<int:id>', methods=['DELETE'])
def delete_recipe(id):
    connection = create_db_connection()
    if connection:
        delete_query = "DELETE FROM recipes WHERE id = %s"
        execute_query(connection, delete_query, (id,))
        return jsonify({"message": "Recipe deleted successfully"}), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Error handlers
@app.errorhandler(500)
def internal_error(error):
    return jsonify({"error": "Internal server error"}), 500


if __name__ == '__main__':
    app.run(debug=True)
