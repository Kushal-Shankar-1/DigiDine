from views import add_recipe, get_recipes, update_recipe, delete_recipe

def initialize_routes(app):
    app.add_url_rule('/add_recipe', view_func=add_recipe, methods=['POST'])
    app.add_url_rule('/recipes', view_func=get_recipes, methods=['GET'])
    app.add_url_rule('/update_recipe/<int:id>', view_func=update_recipe, methods=['PUT'])
    app.add_url_rule('/delete_recipe/<int:id>', view_func=delete_recipe, methods=['DELETE'])
