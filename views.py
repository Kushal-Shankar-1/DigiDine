import mysql
from flask import request, jsonify
from db import create_db_connection, execute_stored_procedure
from flask import session
from utils import login_required


def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('login_user', [username, password])
        result = next(cursor.stored_results()).fetchall()

        if result:
            session['user'] = result[0]['user_name']  # Assuming 'user_name' is part of the result
            return jsonify({"message": "Login successful"}), 200
        else:
            return jsonify({"error": "Invalid credentials"}), 401
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 400
    finally:
        cursor.close()
        connection.close()


def register_user():
    data = request.json
    try:
        execute_stored_procedure('register_user',
                                 [data['username'], data['password'], data['firstName'], data['lastName'],
                                  data['email'], data['fridgeColor']])
        return jsonify({"message": "User registered successfully"}), 201
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 400  # Adjust the error handling as needed


def register_chef():
    data = request.json
    try:

        execute_stored_procedure('register_chef',
                                 [data['username'], data['password'], data['firstName'], data['lastName'],
                                  data['email'], data['fridgeColor']])
        return jsonify({"message": "Chef registered successfully"}), 201
    except mysql.connector.Error as err:
        # The error message from the stored procedure will be returned in the response
        return jsonify({"error": str(err)}), 400


def sign_in():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('login_user', [username, password])
        result = next(cursor.stored_results()).fetchall()  # Fetch the result of the SELECT statement

        if result:
            user_info = result[0]  # Assuming the result is a tuple containing user/chef details
            return jsonify(user_info), 200
        else:
            return jsonify({"error": "Invalid credentials"}), 401
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


def get_dietary_restrictions(username):
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('get_user_dietary_restrictions', [username])
        result = next(cursor.stored_results()).fetchall()

        restrictions = [{"restrictionName": row[0], "description": row[1], "hasRestriction": bool(row[2])} for row in
                        result]
        return jsonify(restrictions), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


def set_dietary_restrictions(username):
    data = request.json  # Assuming data is a list of {restrictionName, hasRestriction}
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        for item in data:
            cursor = connection.cursor()
            cursor.callproc('set_user_dietary_restrictions',
                            [username, item['restrictionName'], item['hasRestriction']])
            cursor.close()
        connection.commit()
        return jsonify({"message": "Dietary restrictions updated successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        connection.close()


def get_user_flavour(username):
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('get_user_flavour', [username])
        result = next(cursor.stored_results()).fetchall()

        flavours = [{"flavourName": row[0], "hasFlavourPref": bool(row[1])} for row in result]
        return jsonify(flavours), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


def set_user_flavour(username):
    data = request.json  # Assuming data is a list of {flavourName, isPreferred}
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        for item in data:
            cursor = connection.cursor()
            cursor.callproc('set_user_flavour', [username, item['flavourName'], item['isPreferred']])
            cursor.close()
        connection.commit()
        return jsonify({"message": "Flavour preferences updated successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        connection.close()


# Fetch Fridge Ingredients
def get_fridge_ingredients(fridge_id):
    connection = create_db_connection()
    if connection:
        result = execute_stored_procedure('get_fridge_ingredient', [fridge_id])
        return jsonify(result), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Update Fridge Ingredients
def set_fridge_ingredient(fridge_id):
    data = request.json
    ingredient = data['ingredient']
    is_present = data['is_present']
    connection = create_db_connection()
    if connection:
        execute_stored_procedure('set_fridge_ingredient', [fridge_id, ingredient, is_present])
        return jsonify({"message": "Fridge ingredient updated successfully"}), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


def get_all_recipes():
    connection = create_db_connection()
    if connection:
        recipes = execute_stored_procedure('get_all_recipes', [])
        return jsonify(recipes), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


def get_custom_recipes(username):
    connection = create_db_connection()
    if connection:
        custom_recipes = execute_stored_procedure('get_custom_recipes', [username])
        return jsonify(custom_recipes), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Add Recipe
@login_required
def add_recipe():
    data = request.json
    chef_name = data['chef_name']
    dish_name = data['dish_name']
    # Add more fields as required
    execute_stored_procedure('add_recipe', [dish_name, chef_name])
    return jsonify({"message": "Recipe added successfully"}), 201


# Update Recipe Image
@login_required
def update_recipe_image():
    data = request.json
    dish_name = data['dish_name']
    chef_name = data['chef_name']
    image_link = data['image_link']
    execute_stored_procedure('update_recipe_image', [dish_name, chef_name, image_link])
    return jsonify({"message": "Recipe image updated successfully"}), 200


# Update Recipe Description
@login_required
def update_recipe_description():
    data = request.json
    dish_name = data['dish_name']
    chef_name = data['chef_name']
    description = data['description']
    execute_stored_procedure('update_recipe_description', [dish_name, chef_name, description])
    return jsonify({"message": "Recipe description updated successfully"}), 200


# Remove Recipe
@login_required
def remove_recipe():
    data = request.json
    recipe_id = data['recipe_id']
    execute_stored_procedure('remove_recipe', [recipe_id])
    return jsonify({"message": "Recipe removed successfully"}), 200


# Add Cooking Instruction
@login_required
def add_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    instruction = data['instruction']
    execute_stored_procedure('add_cooking_instruction', [recipe_id, instruction])
    return jsonify({"message": "Cooking instruction added successfully"}), 200


# Edit Cooking Instruction
@login_required
def edit_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    step_number = data['step_number']
    instruction = data['instruction']
    execute_stored_procedure('edit_cooking_instruction', [recipe_id, step_number, instruction])
    return jsonify({"message": "Cooking instruction edited successfully"}), 200


# Remove Cooking Instruction
@login_required
def remove_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    step_number = data['step_number']
    execute_stored_procedure('remove_cooking_instruction', [recipe_id, step_number])
    return jsonify({"message": "Cooking instruction removed successfully"}), 200


# Add Recipe Flavor
@login_required
def add_recipe_flavour():
    data = request.json
    recipe_id = data['recipe_id']
    flavour = data['flavour']
    execute_stored_procedure('add_recipe_flavour', [recipe_id, flavour])
    return jsonify({"message": "Flavour added to recipe successfully"}), 200


# Remove Recipe Flavor
@login_required
def remove_recipe_flavour():
    data = request.json
    recipe_id = data['recipe_id']
    flavour = data['flavour']
    execute_stored_procedure('remove_recipe_flavour', [recipe_id, flavour])
    return jsonify({"message": "Flavour removed from recipe successfully"}), 200
