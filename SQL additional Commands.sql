DROP PROCEDURE IF EXISTS get_recipe_information;
DELIMITER $
CREATE PROCEDURE get_recipe_information(IN recipe_id_p INT)
BEGIN
    SELECT *
    FROM recipe WHERE recipe_id = recipe_id_p;
END $
DELIMITER ;
SET @rid = 0;
CALL get_recipe_information(@rid);

drop procedure if exists get_restriction_for_recipe;
DELIMITER **
CREATE PROCEDURE get_restriction_for_recipe(IN recipe_id INT)
BEGIN
    SELECT restrict_name
    FROM dietary_restriction dr
    WHERE NOT EXISTS(SELECT *
                     FROM ingredient_has_restriction
                     WHERE diet = restrict_name
                       AND ingredient = ANY
                           (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe = recipe_id));
END**
DELIMITER ;

drop procedure if exists get_flavour_for_recipe;
DELIMITER **
CREATE PROCEDURE get_flavour_for_recipe(IN recipe_id INT)
BEGIN
    SELECT * FROM recipe_has_flavour where recipe = recipe_id;
END**
DELIMITER ;

drop procedure if exists get_ingredients_for_recipe;
DELIMITER **
CREATE PROCEDURE get_ingredients_for_recipe(IN recipe_id INT)
BEGIN
    SELECT * FROM recipe_contains_ingredients where recipe = recipe_id;
END**
DELIMITER ;

drop procedure if exists get_all_restaurant;
DELIMITER **
CREATE PROCEDURE get_all_restaurant()
BEGIN
    SELECT * from restaurant;
END**
DELIMITER ;

drop procedure if exists get_recipe_instructions;
DELIMITER **
CREATE PROCEDURE get_recipe_instructions(IN recipe_id INT)
BEGIN
SELECT * FROM recipe_cooking_instructions where recipe = recipe_id;
END**
DELIMITER ;


CALL get_all_restaurant();
CALL get_ingredients_for_recipe(1);
CALL get_flavour_for_recipe(1);
CALL get_restriction_for_recipe(@rid);
CALL get_recipe_instructions(1);