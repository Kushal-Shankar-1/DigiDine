DELIMITER //

-- Procedure for User Dietary Restrictions
CREATE PROCEDURE GetUserDietaryRestrictions()
BEGIN
    SELECT diet, COUNT(*) as count
    FROM user_has_restriction
    GROUP BY diet;
END //

-- Procedure for Ingredient Distribution in Fridges
CREATE PROCEDURE GetIngredientDistributionInFridges()
BEGIN
    SELECT i.ingredient_name, COUNT(fci.fridge) as count
    FROM ingredient i
    JOIN fridge_contains_ingredients fci ON i.ingredient_name = fci.ingredient_name
    GROUP BY i.ingredient_name;
END //

-- Procedure for User Flavour Preferences
CREATE PROCEDURE GetUserFlavourPreferences()
BEGIN
    SELECT u.user_name, f.flavour_name
    FROM user_has_flavour_pref ufp
    JOIN user u ON ufp.user = u.user_name
    JOIN flavour f ON ufp.flavour = f.flavour_name;
END //

-- Procedure for User Fridge Color Distribution
CREATE PROCEDURE GetUserFridgeColorDistribution()
BEGIN
    SELECT u.user_name, f.color
    FROM user u
    JOIN fridge f ON u.fridge = f.fridge_id;
END //

-- Procedure for Recipe Flavour Distribution
CREATE PROCEDURE GetRecipeFlavourDistribution()
BEGIN
    SELECT r.dish_name, f.flavour_name
    FROM recipe_has_flavour rf
    JOIN recipe r ON rf.recipe = r.recipe_id
    JOIN flavour f ON rf.flavour = f.flavour_name;
END //

-- Procedure for User Ingredient Preferences
CREATE PROCEDURE GetUserIngredientPreferences()
BEGIN
    SELECT u.user_name, i.ingredient_name
    FROM user_has_flavour_pref ufp
    JOIN user u ON ufp.user = u.user_name
    JOIN flavour f ON ufp.flavour = f.flavour_name
    JOIN recipe_contains_ingredients rci ON f.flavour_name = rci.ingredient
    JOIN ingredient i ON rci.ingredient = i.ingredient_name;
END //

-- Procedure for Ingredient Dietary Restrictions
CREATE PROCEDURE GetIngredientDietaryRestrictions()
BEGIN
    SELECT i.ingredient_name, dr.restrict_name
    FROM ingredient i
    JOIN ingredient_has_restriction ihr ON i.ingredient_name = ihr.ingredient
    JOIN dietary_restriction dr ON ihr.diet = dr.restrict_name;
END //

-- Procedure for Chef Recipe Count
CREATE PROCEDURE GetChefRecipeCount()
BEGIN
    SELECT c.user_name, COUNT(r.recipe_id) as recipe_count
    FROM chef c
    JOIN recipe r ON c.user_name = r.chef
    GROUP BY c.user_name;
END //

-- Procedure for User Ingredient Caloric Intake
CREATE PROCEDURE GetUserIngredientCaloricIntake()
BEGIN
    SELECT u.user_name, i.ingredient_name, i.calories
    FROM user u
    JOIN fridge_contains_ingredients fci ON u.fridge = fci.fridge
    JOIN ingredient i ON fci.ingredient_name = i.ingredient_name;
END //

-- Procedure for User Ingredient Preferences Heatmap
CREATE PROCEDURE GetUserIngredientPreferencesHeatmap()
BEGIN
    SELECT u.user_name, i.ingredient_name
    FROM user_has_flavour_pref ufp
    JOIN user u ON ufp.user = u.user_name
    JOIN flavour f ON ufp.flavour = f.flavour_name
    JOIN recipe_contains_ingredients rci ON f.flavour_name = rci.ingredient
    JOIN ingredient i ON rci.ingredient = i.ingredient_name;
END //


DELIMITER ;
