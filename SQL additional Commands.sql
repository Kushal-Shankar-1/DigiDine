USE digidine;
DROP PROCEDURE IF EXISTS get_recipe_information;
DELIMITER $
CREATE PROCEDURE get_recipe_information (IN recipe_id_p INT)
BEGIN
    SELECT * FROM recipe as r join recipe_cooking_instructions as i ON r.recipe_id = i.recipe WHERE recipe=recipe_id_p;
END $
DELIMITER ;
SET @rid = 0;
CALL get_recipe_information(@rid);

drop procedure if exists get_restriction_for_recipe;
DELIMITER **
CREATE PROCEDURE get_restriction_for_recipe(IN recipe_id INT)
BEGIN
SELECT restrict_name FROM dietary_restriction dr WHERE NOT EXISTS(SELECT * FROM ingredient_has_restriction WHERE diet=restrict_name AND ingredient = ANY (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe=recipe_id));  
END**
DELIMITER ;

drop procedure if exists get_restaurants;
DELIMITER $
CREATE PROCEDURE get_restaurants()
BEGIN
SELECT name FROM restaurant;
END $
DELIMITER ;
CALL get_restriction_for_recipe(@rid);
SELECT restrict_name FROM dietary_restriction dr WHERE NOT EXISTS(SELECT * FROM ingredient_has_restriction WHERE diet=restrict_name AND ingredient = ANY (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe=1));  
