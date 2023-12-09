import mysql
from flask import request, jsonify
from flask import session

from db import create_db_connection, execute_stored_procedure
import threading
import visualize


def register_user():
    data = request.json
    try:
        execute_stored_procedure('register_user',
                                 [data['username'], data['password'], data['firstName'], data['lastName'],
                                  data['email'], data['fridgeColor']])
        return jsonify({"message": "User registered successfully"}), 201
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 400  # Adjust the error handling as needed
    except KeyError as e:
        return jsonify({"error": f"Missing required field: {e}"}), 400


def register_chef():
    data = request.json
    try:

        execute_stored_procedure('register_chef',
                                 [data['username'], data['password'], data['firstName'], data['lastName'],
                                  data['email'], data['restaurantId']])
        return jsonify({"message": "Chef registered successfully"}), 201
    except mysql.connector.Error as err:
        # The error message from the stored procedure will be returned in the response
        return jsonify({"error": str(err)}), 400
    except KeyError as e:
        return jsonify({"error": f"Missing required field: {e}"}), 400

def sign_in():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor(dictionary=True)
        cursor.callproc('login_user', [username, password])
        result = next(cursor.stored_results()).fetchall()

        if result:
            user_info = result[0]  # Convert the tuple to a dictionary
            session['user'] = user_info['user_name']  # Store the username in session for session management

            # Include additional user info as required by your application
            return jsonify({"message": "Login successful", "user_info": user_info}), 200
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

        cursor = connection.cursor(dictionary=True)
        cursor.callproc('get_user_dietary_restrictions', [username])
        result = next(cursor.stored_results()).fetchall()

        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


def set_dietary_restrictions(username):
    data = request.json
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('set_user_dietary_restrictions',
                        [username, data['restrictionName'], data['hasRestriction']])
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

        cursor = connection.cursor(dictionary=True)
        cursor.callproc('get_user_flavour', [username])
        result = next(cursor.stored_results()).fetchall()

        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        connection.close()


def set_user_flavour(username):
    data = request.json
    try:
        connection = create_db_connection()
        if connection is None:
            raise Exception("Failed to connect to the database")

        cursor = connection.cursor()
        cursor.callproc('set_user_flavour', [username, data['flavourName'], data['isPreferred']])
        cursor.close()
        connection.commit()
        return jsonify({"message": "Flavour preferences updated successfully"}), 200
    except Exception as e:
        print(e)
        return jsonify({"error": str(e)}), 500
    finally:
        connection.close()


# Fetch Fridge Ingredients
def get_fridge_ingredients(fridge_id):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('get_fridge_ingredient', [fridge_id])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Update Fridge Ingredients
def set_fridge_ingredient(fridge_id):
    data = request.json
    ingredient = data['ingredient']
    is_present = data['is_present']
    connection = create_db_connection()
    if connection:
        try:
            execute_stored_procedure('set_fridge_ingredient', [fridge_id, ingredient, is_present])
            return jsonify({"message": "Fridge ingredient updated successfully"}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


def get_all_recipes():
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('get_all_recipes', [])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


def get_custom_recipes(username):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('get_custom_recipes', [username])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Add Recipe
def add_recipe():
    data = request.json
    chef_name = data['chef_name']
    dish_name = data['dish_name']
    # Add more fields as required
    returnedVal = execute_stored_procedure('add_recipe', [dish_name, chef_name])
    return get_all_recipe_information(returnedVal[0][0]['recipe_id'])


# Update Recipe Image
def update_recipe_image():
    data = request.json
    dish_name = data['dish_name']
    chef_name = data['chef_name']
    image_link = data['image_link']
    execute_stored_procedure('update_recipe_image', [dish_name, chef_name, image_link])
    
    return jsonify({"message": "Recipe image updated successfully"}), 200


# Update Recipe Description
def update_recipe_description():
    data = request.json
    dish_name = data['dish_name']
    chef_name = data['chef_name']
    description = data['description']
    execute_stored_procedure('update_recipe_description', [dish_name, chef_name, description])
    return jsonify({"message": "Recipe description updated successfully"}), 200


# Remove Recipe
def remove_recipe():
    data = request.json
    recipe_id = data['recipe_id']
    execute_stored_procedure('remove_recipe', [recipe_id])
    return jsonify({"message": "Recipe removed successfully"}), 200


# Add Cooking Instruction
def add_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    instruction = data['instruction']
    execute_stored_procedure('add_cooking_instruction', [recipe_id, instruction])
    return jsonify({"message": "Cooking instruction added successfully"}), 200


# Edit Cooking Instruction
def edit_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    step_number = data['step_number']
    instruction = data['instruction']
    execute_stored_procedure('edit_cooking_instruction', [recipe_id, step_number, instruction])
    return jsonify({"message": "Cooking instruction edited successfully"}), 200


# Remove Cooking Instruction
def remove_cooking_instruction():
    data = request.json
    recipe_id = data['recipe_id']
    execute_stored_procedure('remove_cooking_instruction', [recipe_id])
    return jsonify({"message": "Cooking instruction removed successfully"}), 200


# Add Recipe Flavor
def add_recipe_flavour():
    data = request.json
    recipe_id = data['recipe_id']
    flavour = data['flavour']
    execute_stored_procedure('add_recipe_flavour', [recipe_id, flavour])
    return jsonify({"message": "Flavour added to recipe successfully"}), 200


# Remove Recipe Flavor
def remove_recipe_flavour():
    data = request.json
    recipe_id = data['recipe_id']
    flavour = data['flavour']
    execute_stored_procedure('remove_recipe_flavour', [recipe_id, flavour])
    return jsonify({"message": "Flavour removed from recipe successfully"}), 200

def add_recipe_ingredient():
    data = request.json
    recipe_id = data['recipe_id']
    ingredient = data['ingredient']
    execute_stored_procedure('add_recipe_ingredient', [recipe_id, ingredient])
    return jsonify({"message": "Ingredient added to recipe successfully"}), 200

def remove_recipe_ingredient():
    data = request.json
    recipe_id = data['recipe_id']
    ingredient = data['ingredient']
    execute_stored_procedure('remove_recipe_ingredient', [recipe_id, ingredient])
    return jsonify({"message": "Ingredient removed from recipe successfully"}), 200


# Fetch Recipes Based on Fridge Ingredients
def get_recipes_by_fridge(user_name):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('all_recipes_with_fridge_ingredients', [user_name])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Fetch Preferred Recipes Based on User Preferences and Fridge Ingredients
def get_preferred_recipes(user_name):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('preferred_recipes_with_fridge_ingredients', [user_name])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Update Chef's Restaurant
def update_chef_restaurant():
    data = request.json
    user_name = data['user_name']
    restaurant_id = data['restaurant_id']
    connection = create_db_connection()
    if connection:
        try:
            execute_stored_procedure('update_chef_restaurant', [user_name, restaurant_id])
            return jsonify({"message": "Chef's restaurant updated successfully"}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Update Email Address
def update_email_address():
    data = request.json
    user_name_p = data['user_name']
    new_email = data['new_email']
    connection = create_db_connection()
    if connection:
        try:
            execute_stored_procedure('update_email_address', [user_name_p, new_email])
            return jsonify({"message": "Email address updated successfully"}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500


# Fetch Recipes Created by Chef
def get_chef_recipes(user_name):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.callproc('get_chef_recipe', [user_name])
            result = next(cursor.stored_results()).fetchall()
            return jsonify(result), 200
        except Exception as e:
            print(f"Error: {e}")
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500

def get_all_restaurants():
    connection = create_db_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        cursor.callproc('get_restaurants', [])
        result = next(cursor.stored_results()).fetchall()
        return jsonify(result), 200
    else:
        return jsonify({"error": "Database connection failed"}), 500

def get_all_recipe_information(recipe_id):
    connection = create_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)

            # Fetch detailed information for a specific recipe
            print(f"Fetching recipe information for recipe ID: {recipe_id}")
            cursor.callproc('get_recipe_information', [recipe_id])
            detailed_info = next(cursor.stored_results()).fetchall()
            print(f"Recipe Info: {detailed_info}")

            # Check if recipe information is available
            if not detailed_info:
                print("No detailed info found for the recipe")
                return jsonify({"error": "Recipe not found"}), 404

            # Aggregate recipe data
            recipe_data = detailed_info[0]

            # Fetch dietary restrictions
            cursor.callproc('get_restriction_for_recipe', [recipe_id])
            restrictions = next(cursor.stored_results()).fetchall()
            print(f"Restrictions: {restrictions}")
            recipe_data['dietary_restrictions'] = [res['restrict_name'] for res in restrictions]

            # Fetch flavours
            cursor.callproc('get_flavour_for_recipe', [recipe_id])
            flavours = next(cursor.stored_results()).fetchall()
            recipe_data['flavours'] = flavours

            # Fetch ingredients
            cursor.callproc('get_ingredients_for_recipe', [recipe_id])
            ingredients = next(cursor.stored_results()).fetchall()
            recipe_data['ingredients'] = ingredients

            # Fetch cooking instructions
            cursor.callproc('get_recipe_instructions', [recipe_id])
            instructions = next(cursor.stored_results()).fetchall()
            recipe_data['cooking_instructions'] = instructions

            return jsonify(recipe_data), 200
        except Exception as e:
            print(f"Exception: {e}")
            return jsonify({"error": str(e)}), 500
        finally:
            cursor.close()
            connection.close()
    else:
        return jsonify({"error": "Database connection failed"}), 500

def visualize_data():
    try:
        # Run the visualize.py in a separate thread
        thread = threading.Thread(target=visualize.run_visualizations, args=())
        thread.daemon = True
        thread.start()
        return jsonify({"message": "Visualization started"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500