import os 
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from config import Config

# Configuration for your database
db_config = {
    "host": Config.DB_HOST,
    "user": Config.DB_USER,
    "password": Config.DB_PASSWORD,
    "database": Config.DB_NAME
}



def execute_procedure(procedure_name):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        cursor.callproc(procedure_name)
        result = list(cursor.stored_results())[0].fetchall()

        return result

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


def save_plot(figure, filename):
    dir_name = 'data_visualization'
    if not os.path.exists(dir_name):
        os.makedirs(dir_name)
    path = os.path.join(dir_name, filename)
    figure.savefig(path)
    plt.close(figure)


def plot_user_dietary_restrictions(result):
    df = pd.DataFrame(result, columns=['count', 'restrict_name'])
    # user_df = df.groupby(['user_name', 'first_name', 'last_name'])['count'].sum().reset_index()
    fig = plt.figure(figsize=(12, 8))
    sns.barplot(x='restrict_name', y='count', data=df)
    plt.title('User Count for Dietary Restrictions(Top 7)')
    plt.xlabel('Dietary Restriction')
    plt.ylabel('User Count')
    save_plot(fig, 'user_dietary_restrictions.png')


def plot_ingredient_distribution(result):
    df = pd.DataFrame(result, columns=['Ingredient', 'Count'])
    fig = plt.figure(figsize=(12, 8))
    sns.barplot(x='Ingredient', y='Count', data=df)
    plt.title('Ingredient Distribution in Fridges')
    plt.xlabel('Ingredient')
    plt.ylabel('Count')
    save_plot(fig, 'ingredient_distribution.png')


def plot_user_flavour_preferences(result):
    df = pd.DataFrame(result, columns=['Count', 'Flavour'])
    fig=plt.figure(figsize=(12, 8))
    sns.barplot(x='Flavour', y='Count', data=df)
    plt.title('User Flavour Preferences (Top 7)')
    plt.title('User Flavour Preferences')
    plt.xlabel('Flavour')
    plt.ylabel('Count')
    save_plot(fig, 'user_flavour_preferences.png')

def plot_recipe_flavour_distribution(result):
    df = pd.DataFrame(result, columns=['Count', 'Flavour'])
    fig=plt.figure(figsize=(12, 8))
    sns.barplot(x='Flavour', data=df, y='Count')
    plt.title('Recipe Flavour Distribution (Top 7)')
    plt.xlabel('Flavour')
    plt.ylabel('Count of Recipes')
    save_plot(fig, 'recipe_flavour_distribution.png')


def plot_ingredient_dietary_restrictions(result):
    df = pd.DataFrame(result, columns=['Ingredient', 'Dietary Restriction'])
    fig = plt.figure(figsize=(12, 8))
    sns.countplot(x='Dietary Restriction', data=df, hue='Ingredient')
    plt.title('Ingredient Dietary Restrictions')
    plt.xlabel('Dietary Restriction')
    plt.ylabel('Count')
    save_plot(fig, 'ingredient_dietary_restriction.png')

def plot_chef_recipe_count(result):
    df = pd.DataFrame(result, columns=['Chef', 'Recipe Count'])
    fig = plt.figure(figsize=(10, 6))
    sns.barplot(x='Chef', y='Recipe Count', data=df)
    plt.title('Chef Recipe Count')
    plt.ylabel('Recipe Count')
    save_plot(fig, 'chef_recipe_count.png')



def run_visualizations():
    os.makedirs("data_visualization", exist_ok=True)
    # Call the procedures and visualize the results
    user_dietary_restrictions_result = execute_procedure('GetUserDietaryRestrictions')
    plot_user_dietary_restrictions(user_dietary_restrictions_result)

    user_flavour_preferences_result = execute_procedure('GetUserFlavourPreferences')
    plot_user_flavour_preferences(user_flavour_preferences_result)

    recipe_flavour_distribution_result = execute_procedure('GetRecipeFlavourDistribution')
    plot_recipe_flavour_distribution(recipe_flavour_distribution_result)

    ingredient_dietary_restrictions_result = execute_procedure('GetIngredientDietaryRestrictions')
    plot_ingredient_dietary_restrictions(ingredient_dietary_restrictions_result)

    chef_recipe_count_result = execute_procedure('GetChefRecipeCount')
    plot_chef_recipe_count(chef_recipe_count_result)


if __name__ == "__main__":
    run_visualizations()
