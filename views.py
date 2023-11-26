from flask import request, jsonify
from db import create_db_connection, execute_query, execute_read_query
from utils import validate_recipe_data

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

def get_recipes():
    connection = create_db_connection()
    if connection:
        select_recipes_query = "SELECT * FROM recipes"
        recipes = execute_read_query(connection, select_recipes_query)
        recipes_list = [{"id": recipe[0], "title": recipe[1], "description": recipe[2]} for recipe in recipes]
        return jsonify(recipes_list), 200
    else:
        return jsonify({"error": "Failed to fetch recipes"}), 500

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

def delete_recipe(id):
    connection = create_db_connection()
    if connection:
        delete_query = "DELETE FROM recipes WHERE id = %s"
        execute_query(connection, delete_query, (id,))
        return jsonify({"message": "Recipe deleted successfully"}), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500
