from views import add_recipe, sign_in, register_user, register_chef, \
    get_dietary_restrictions, set_dietary_restrictions, get_user_flavour, set_user_flavour, get_fridge_ingredients, \
    set_fridge_ingredient, get_all_recipes, get_custom_recipes, update_recipe_image, update_recipe_description, \
    remove_recipe, add_cooking_instruction, edit_cooking_instruction, remove_cooking_instruction, add_recipe_flavour, \
    remove_recipe_flavour, get_recipes_by_fridge, get_preferred_recipes, update_chef_restaurant, update_email_address, \
    get_chef_recipes


def initialize_routes(app):
    app.add_url_rule('/add_recipe', view_func=add_recipe, methods=['POST'])
    app.add_url_rule('/register/user', view_func=register_user, methods=['POST'])
    app.add_url_rule('/register/chef', view_func=register_chef, methods=['POST'])
    app.add_url_rule('/sign-in', view_func=sign_in, methods=['POST'])
    app.add_url_rule('/get-dietary-restrictions/<username>', view_func=get_dietary_restrictions, methods=['GET'])
    app.add_url_rule('/set_dietary_restrictions/<username>', view_func=set_dietary_restrictions, methods=['POST'])
    app.add_url_rule('/get-user-flavour/<username>', view_func=get_user_flavour, methods=['GET'])
    app.add_url_rule('/set-user-flavour/<username>', view_func=set_user_flavour, methods=['POST'])
    app.add_url_rule('/fridge/<int:fridge_id>/ingredients', view_func=get_fridge_ingredients, methods=['GET'])
    app.add_url_rule('/fridge/<int:fridge_id>/ingredient', view_func=set_fridge_ingredient, methods=['POST'])
    app.add_url_rule('/recipes/all', view_func=get_all_recipes, methods=['GET'])
    app.add_url_rule('/recipes/custom/<username>', view_func=get_custom_recipes, methods=['GET'])
    app.add_url_rule('/chef/add-recipe', view_func=add_recipe, methods=['POST'])
    app.add_url_rule('/chef/update-recipe-image', view_func=update_recipe_image, methods=['POST'])
    app.add_url_rule('/chef/update-recipe-description', view_func=update_recipe_description, methods=['POST'])
    app.add_url_rule('/chef/remove-recipe', view_func=remove_recipe, methods=['POST'])
    app.add_url_rule('/recipe/add-instruction', view_func=add_cooking_instruction, methods=['POST'])
    app.add_url_rule('/recipe/edit-instruction', view_func=edit_cooking_instruction, methods=['POST'])
    app.add_url_rule('/recipe/remove-instruction', view_func=remove_cooking_instruction, methods=['POST'])
    app.add_url_rule('/recipe/add-flavour', view_func=add_recipe_flavour, methods=['POST'])
    app.add_url_rule('/recipe/remove-flavour', view_func=remove_recipe_flavour, methods=['POST'])
    app.add_url_rule('/recipes/fridge/<user_name>', view_func=get_recipes_by_fridge, methods=['GET'])
    app.add_url_rule('/recipes/preferred/<user_name>', view_func=get_preferred_recipes, methods=['GET'])
    app.add_url_rule('/update/chef-restaurant', view_func=update_chef_restaurant, methods=['POST'])
    app.add_url_rule('/update/email-address', view_func=update_email_address, methods=['POST'])
    app.add_url_rule('/recipes/chef/<user_name>', view_func=get_chef_recipes, methods=['GET'])
