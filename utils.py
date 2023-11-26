def validate_recipe_data(title, description):
    """
    Validates the recipe data.
    :param title: str - Title of the recipe.
    :param description: str - Description of the recipe.
    :return: list - List of validation error messages, empty if no errors.
    """
    errors = []
    if not title or not isinstance(title, str) or len(title.strip()) == 0:
        errors.append("Title is required and must be a string.")
    if not description or not isinstance(description, str) or len(description.strip()) == 0:
        errors.append("Description is required and must be a string.")
    return errors
