USE digidine;
DROP PROCEDURE IF EXISTS register_user;
DELIMITER **
CREATE PROCEDURE register_user(
    IN user_name_p VARCHAR(64),
    IN password VARCHAR(64),
    IN first_name VARCHAR(64),
    IN last_name VARCHAR(64),
    IN email VARCHAR(64),
    IN color VARCHAR(32)
)
BEGIN
    DECLARE usr_error,chef_error, pass_error, email_error BOOLEAN DEFAULT FALSE;
    DECLARE fridge_count INT DEFAULT 1;
    SELECT COUNT(*)
    FROM fridge
    INTO fridge_count;
    SELECT EXISTS(SELECT *
                  FROM user AS u
                  WHERE u.user_name = user_name_p)
    INTO usr_error;
    SELECT EXISTS(SELECT *
                  FROM chef AS c
                  WHERE c.user_name = user_name_p)
    INTO chef_error;
    SELECT LENGTH(password) < 8 INTO pass_error;
    SELECT email NOT LIKE '%@%.%__' INTO email_error;
    IF usr_error OR chef_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username already taken!';
    ELSEIF pass_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
                'Password invalid, Make sure the password is atleast 8 characters long!';
    ELSEIF email_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email format invalid!';
    END IF;
    INSERT INTO fridge VALUES (fridge_count, color);
    INSERT INTO user VALUES (user_name_p, fridge_count, first_name, last_name, email, password);
END**
DELIMITER ;


DROP PROCEDURE IF EXISTS register_chef;
DELIMITER **
CREATE PROCEDURE register_chef(
    IN user_name_p VARCHAR(64),
    IN password VARCHAR(64),
    IN first_name VARCHAR(64),
    IN last_name VARCHAR(64),
    IN email VARCHAR(64),
    IN restaurant_id_p INT
)
BEGIN
    DECLARE usr_error,chef_error, pass_error, email_error, restaurant_error BOOLEAN DEFAULT FALSE;
    SELECT EXISTS(SELECT * FROM user as u WHERE u.user_name = user_name_p) INTO usr_error;
    SELECT EXISTS(SELECT * FROM chef as c WHERE c.user_name = user_name_p) INTO chef_error;
    SELECT NOT EXISTS(SELECT * FROM restaurant as r WHERE restaurant_id = restaurant_id_p) INTO restaurant_error;
    SELECT LENGTH(password) < 8 INTO pass_error;
    SELECT email NOT LIKE '%@%.%__' INTO email_error;
    IF usr_error OR chef_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username already taken!';
    ELSEIF pass_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
                'Password invalid, Make sure the password is atleast 8 characters long!';
    ELSEIF email_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email format invalid!';
    ELSEIF restaurant_error THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Restaurant does not exist!';
    END IF;
    INSERT INTO chef VALUES (user_name_p, first_name, last_name, password, restaurant_id_p, email);
END**
DELIMITER ;

drop procedure if exists login_user;
DELIMITER **
CREATE PROCEDURE login_user(
    IN user_name_p VARCHAR(64),
    IN password_p VARCHAR(64)
)
BEGIN
    DECLARE user_exists, password_valid BOOLEAN DEFAULT false;
    DECLARE is_user, is_chef BOOLEAN;

    SELECT EXISTS(SELECT user_name FROM user WHERE user_name = user_name_p) INTO is_user;
    SELECT EXISTS(SELECT user_name FROM chef WHERE user_name = user_name_p) INTO is_chef;

    SET user_exists = is_user OR is_chef;

    IF NOT user_exists THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist!';
    ELSE
        IF is_user THEN
            SELECT EXISTS(SELECT user_name FROM user WHERE user_name = user_name_p AND password = password_p)
            INTO password_valid;
        ELSEIF is_chef THEN
            SELECT EXISTS(SELECT user_name FROM chef WHERE user_name = user_name_p AND password = password_p)
            INTO password_valid;
        END IF;

        IF NOT password_valid THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid password!';
        END IF;
    END IF;
    if is_user then
        SELECT u.user_name, u.fridge, u.first_name, u.last_name, u.email, f.color
        FROM user u
                 JOIN fridge f ON u.fridge = f.fridge_id
        WHERE u.user_name = user_name_p
          AND u.password = password_p;
    else
        SELECT c.user_name,
               c.first_name,
               c.last_name,
               c.email,
               r.name AS restaurant_name,
               r.cuisine_type,
               r.address,
               a.street_no
        FROM chef AS c
                 JOIN
             restaurant AS r ON c.restaurant = r.restaurant_id
                 JOIN
             address AS a ON r.address = a.address_id
        WHERE c.user_name = user_name_p
          AND c.password = password_p;
    end if;
END**
DELIMITER ;

-- drop procedure if exists login_user;
-- DELIMITER **
-- CREATE PROCEDURE login_user(
-- 	IN user_name_p VARCHAR(64),
--     IN password_p VARCHAR(64)
-- )
-- BEGIN
--     DECLARE user_exists, password_valid BOOLEAN DEFAULT false;
--     DECLARE is_user, is_chef BOOLEAN;

--     SELECT EXISTS(SELECT user_name FROM user WHERE user_name = user_name_p) INTO is_user;
--     SELECT EXISTS(SELECT user_name FROM chef WHERE user_name = user_name_p) INTO is_chef;

--     SET user_exists = is_user OR is_chef;

--     IF NOT user_exists THEN 
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='User does not exist!';
--     ELSE
--         IF is_user THEN
--             SELECT EXISTS(SELECT user_name FROM user WHERE user_name = user_name_p AND password = password_p) INTO password_valid;
--         ELSEIF is_chef THEN
--             SELECT EXISTS(SELECT user_name FROM chef WHERE user_name = user_name_p AND password = password_p) INTO password_valid;
--         END IF;

--         IF NOT password_valid THEN
--             SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid password!';
--         END IF;
--     END IF;
--     if is_user then select * from user WHERE user_name = user_name_p AND password = password_p;
--     else select * from chef WHERE user_name = user_name_p AND password = password_p;
--     end if;
-- END**
-- DELIMITER ;


DROP PROCEDURE IF EXISTS get_user_dietary_restrictions;
DELIMITER **
CREATE PROCEDURE get_user_dietary_restrictions(
    IN user_name VARCHAR(64)
)
BEGIN
    SELECT restrict_name, description, user IS NOT NULL AS has_restriction
    FROM dietary_restriction as d
             left outer join (SELECT * FROM user_has_restriction WHERE user = user_name) as u
                             on d.restrict_name = u.diet;
END**
DELIMITER ;

drop procedure if exists set_user_dietary_restrictions;
DELIMITER **
CREATE PROCEDURE set_user_dietary_restrictions(
    IN user_name VARCHAR(64),
    IN restriction_name VARCHAR(64),
    IN has_dietary_restriction BOOLEAN
)
BEGIN
    DECLARE combo_present BOOLEAN;
    SELECT EXISTS(SELECT * FROM user_has_restriction WHERE user = user_name AND diet = restriction_name)
    INTO combo_present;
    IF has_dietary_restriction AND NOT combo_present THEN
        INSERT INTO user_has_restriction VALUES (user_name, restriction_name);
    ELSEIF NOT has_dietary_restriction AND combo_present THEN
        DELETE FROM user_has_restriction WHERE user = user_name AND diet = restriction_name;
    END IF;
END**
DELIMITER ;

drop procedure if exists get_user_flavour;
DELIMITER **
CREATE PROCEDURE get_user_flavour(
    IN user_name VARCHAR(64)
)
BEGIN
    SELECT flavour_name, user IS NOT NULL AS has_flavour_pref
    FROM flavour as f
             left outer join (SELECT * FROM user_has_flavour_pref WHERE user = user_name) as u
                             on f.flavour_name = u.flavour;
END**
DELIMITER ;

drop procedure if exists set_user_flavour;
DELIMITER **
CREATE PROCEDURE set_user_flavour(
    IN user_name VARCHAR(64),
    IN flavour_name VARCHAR(64),
    IN is_preferred BOOLEAN
)
BEGIN
    DECLARE combo_present BOOLEAN;
    SELECT EXISTS(SELECT * FROM user_has_flavour_pref WHERE user = user_name AND flavour = flavour_name)
    INTO combo_present;
    IF is_preferred AND NOT combo_present THEN
        INSERT INTO user_has_flavour_pref VALUES (user_name, flavour_name);
    ELSEIF NOT is_preferred AND combo_present THEN
        DELETE FROM user_has_flavour_pref WHERE user = user_name AND flavour = flavour_name;
    END IF;
END**
DELIMITER ;

drop procedure if exists get_fridge_ingredient;
DELIMITER **
CREATE PROCEDURE get_fridge_ingredient(
    IN fridge_id_p INT
)
BEGIN
    SELECT fridge IS NOT NULL AS is_present, fridge_id_p, i.ingredient_name as fridge_ingredients
    FROM ingredient as i
             left outer join (SELECT * FROM fridge_contains_ingredients WHERE fridge_id_p = fridge) as f
                             on i.ingredient_name = f.ingredient_name;
END**
DELIMITER ;

drop procedure if exists set_fridge_ingredient;
DELIMITER **
CREATE PROCEDURE set_fridge_ingredient(
    IN fridge_id INT,
    IN ingredient VARCHAR(64),
    IN is_present BOOLEAN
)
BEGIN
    DECLARE combo_present BOOLEAN;
    SELECT EXISTS(SELECT * FROM fridge_contains_ingredients WHERE fridge_id = fridge AND ingredient = ingredient_name)
    INTO combo_present;
    IF is_present AND NOT combo_present THEN
        INSERT INTO fridge_contains_ingredients VALUES (fridge_id, ingredient);
    ELSEIF NOT is_present AND combo_present THEN
        DELETE FROM fridge_contains_ingredients WHERE fridge_id = fridge AND ingredient = ingredient_name;
    END IF;
END**
DELIMITER ;

drop procedure if exists get_all_recipes;
DELIMITER **
CREATE PROCEDURE get_all_recipes()
BEGIN
    SELECT * from recipe;
END**
DELIMITER ;

#List of dietary restrictions for a given recipe based on ingredients in it
SELECT *
FROM dietary_restriction dr
WHERE NOT EXISTS(SELECT *
                 FROM ingredient_has_restriction
                 WHERE diet = restrict_name
                   AND ingredient = ANY (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe = 1));

#List of recipes that can be made with ingredients in fridge
SELECT *
FROM recipe r
WHERE NOT EXISTS(SELECT *
                 FROM recipe_contains_ingredients
                 WHERE recipe = r.recipe_id
                   AND ingredient NOT IN (SELECT ingredient_name
                                          FROM fridge_contains_ingredients
                                                   NATURAL JOIN (SELECT fridge
                                                                 FROM user
                                                                 WHERE user_name = "hari") user_fridge));



drop procedure IF EXISTS all_recipes_with_fridge_ingredients;
DELIMITER $
#List of recipes that can be made with ingredients in fridge
CREATE PROCEDURE all_recipes_with_fridge_ingredients(IN user_name_p VARCHAR(64))
BEGIN
    SELECT *
    FROM recipe r
    WHERE NOT EXISTS(SELECT *
                     FROM recipe_contains_ingredients
                     WHERE recipe = r.recipe_id
                       AND ingredient NOT IN (SELECT ingredient_name
                                              FROM fridge_contains_ingredients
                                                       NATURAL JOIN (SELECT fridge
                                                                     FROM user
                                                                     WHERE user_name = user_name_p) user_fridge));
END $

DELIMITER ;

CALL all_recipes_with_fridge_ingredients('hrishi');

drop procedure if exists get_custom_recipes;
DELIMITER $
# Procedure to return all recipes that match user dietary restrictions, flavour preferences
# The procedure internally derives all the dietary restrictions that every recipe adheres to based on the ingredients that are present in it
CREATE PROCEDURE get_custom_recipes(IN user_name_p VARCHAR(64))
BEGIN
    SELECT *
    FROM (SELECT *
          FROM recipe r
          WHERE NOT EXISTS(SELECT diet
                           FROM user_has_restriction
                           WHERE user = user_name_p #Does not exist any user dietary restriction that is not met by the recipe
                             AND diet != ALL (SELECT restrict_name
                                              FROM dietary_restriction dr
                                              WHERE NOT EXISTS(SELECT *
                                                               FROM ingredient_has_restriction
                                                               WHERE diet = restrict_name
                                                                 AND ingredient = ANY (SELECT ingredient
                                                                                       FROM recipe_contains_ingredients
                                                                                       WHERE recipe = r.recipe_id))))) diet_recipes
             JOIN ( #Merge all recipes that satisfies user dietary restriction AND user flavor preferences
        SELECT *
        FROM recipe
        WHERE NOT EXISTS(SELECT * FROM user_has_flavour_pref WHERE user = user_name_p) #If no flavor preference, take all recipes
        UNION
        SELECT *
        FROM recipe r
        WHERE #Get recipes that match user flavor preference
              EXISTS(SELECT flavour
                     FROM user_has_flavour_pref AS uf
                     WHERE user = user_name_p
                       AND EXISTS(SELECT *
                                  FROM recipe_has_flavour
                                  WHERE r.recipe_id
                                    AND uf.flavour = flavour))) AS flavor_recipes
                  ON diet_recipes.recipe_id = flavor_recipes.recipe_id;
END $
DELIMITER ;


drop procedure IF EXISTS preferred_recipes_with_fridge_ingredients;

DELIMITER $
# Procedure to return all recipes that match user dietary restrictions, flavour preferences, and user ingredient inventory
# The procedure internally derives all the dietary restrictions that every recipe adheres to based on the ingredients that are present in it
CREATE PROCEDURE preferred_recipes_with_fridge_ingredients(IN user_name_p VARCHAR(64))
BEGIN
    SELECT *
    FROM (SELECT *
          FROM (SELECT *
                FROM recipe r
                WHERE NOT EXISTS(SELECT diet
                                 FROM user_has_restriction
                                 WHERE user = user_name_p #Does not exist any user dietary restriction that is not met by the recipe
                                   AND diet != ALL (SELECT restrict_name
                                                    FROM dietary_restriction dr
                                                    WHERE NOT EXISTS(SELECT *
                                                                     FROM ingredient_has_restriction
                                                                     WHERE diet = restrict_name
                                                                       AND ingredient = ANY (SELECT ingredient
                                                                                             FROM recipe_contains_ingredients
                                                                                             WHERE recipe = r.recipe_id))))) AS diet_recipes
                   NATURAL JOIN ( #Merge all recipes that satisfies user dietary restriction AND user flavor preferences
              SELECT *
              FROM recipe
              WHERE NOT EXISTS(SELECT * FROM user_has_flavour_pref WHERE user = user_name_p) #If no flavor preference, take all recipes
              UNION
              SELECT *
              FROM recipe r
              WHERE #Get recipes that match user flavor preference
                    EXISTS(SELECT flavour
                           FROM user_has_flavour_pref AS uf
                           WHERE user = user_name_p
                             AND EXISTS (SELECT * FROM recipe_has_flavour WHERE r.recipe_id AND uf.flavour = flavour)))
              AS flavor_recipes)
             AS preferred_recipes
    WHERE NOT EXISTS(SELECT *
                     FROM recipe_contains_ingredients
                     WHERE recipe = preferred_recipes.recipe_id
                       AND ingredient NOT IN (SELECT ingredient_name
                                              FROM fridge_contains_ingredients
                                                       NATURAL JOIN (SELECT fridge
                                                                     FROM user
                                                                     WHERE user_name = user_name_p) user_fridge));
END $

DELIMITER ;

DROP PROCEDURE IF EXISTS add_cooking_instruction;
DELIMITER $
CREATE PROCEDURE add_cooking_instruction(IN recipe_id_p INT, IN instruction VARCHAR(64))
BEGIN
    DECLARE current_steps INT;
    SELECT COUNT(*) FROM recipe_cooking_instructions WHERE recipe = recipe_id_p INTO current_steps;
    INSERT INTO recipe_cooking_instructions VALUES (recipe_id_p, current_steps + 1, instruction);
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS edit_cooking_instruction;

DELIMITER $
CREATE PROCEDURE edit_cooking_instruction(IN recipe_id_p INT, IN step_number_p INT, IN instruction VARCHAR(64))
BEGIN
    UPDATE recipe_cooking_instructions
    SET step_description=instruction
    WHERE recipe = recipe_id_p
      AND step_number = step_number_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_cooking_instruction;
DELIMITER $
CREATE PROCEDURE remove_cooking_instruction(IN recipe_id_p INT)
BEGIN
	DECLARE step_count INT;
    SELECT MAX(step_number) INTO step_count FROM recipe_cooking_instructions WHERE recipe = recipe_id_p;
    IF step_count > 0 THEN
		DELETE FROM recipe_cooking_instructions WHERE recipe = recipe_id_p AND step_number = step_count;
	END IF;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS add_recipe_flavour;
DELIMITER $
CREATE PROCEDURE add_recipe_flavour(IN recipe_p INT, IN flavour_p VARCHAR(64))
BEGIN
	DECLARE req BOOLEAN;
    SELECT NOT EXISTS(SELECT * FROM recipe_has_flavour WHERE recipe=recipe_p AND flavour=flavour_p) INTO req;
    IF req THEN
		INSERT INTO recipe_has_flavour VALUES (recipe_p, flavour_p);
	END IF;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_recipe_flavour;
DELIMITER $
CREATE PROCEDURE remove_recipe_flavour(IN recipe_p INT, IN flavour_p VARCHAR(64))
BEGIN
	DECLARE req BOOLEAN;
    SELECT EXISTS(SELECT * FROM recipe_has_flavour WHERE recipe=recipe_p AND flavour=flavour_p) INTO req;
    IF req THEN
		DELETE FROM recipe_has_flavour WHERE recipe = recipe_p AND flavour = flavour_p;
	END IF;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS add_dietary_restriction;
DELIMITER $
CREATE PROCEDURE add_dietary_restriction(IN user_name_p VARCHAR(64), IN restriction VARCHAR(64))
BEGIN
    INSERT INTO user_has_restriction VALUES (user_name_p, restriction);
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_dietary_restriction;
DELIMITER $
CREATE PROCEDURE remove_dietary_restriction(IN user_name_p VARCHAR(64), IN restriction VARCHAR(64))
BEGIN
    DELETE FROM user_has_restriction WHERE user = user_name_p AND diet = restriction;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS update_chef_restaurant;
DELIMITER $
CREATE PROCEDURE update_chef_restaurant(IN user_name_p VARCHAR(64), IN restaurant_p INT)
BEGIN
    UPDATE chef SET restaurant=restaurant_p WHERE user_name = user_name_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS update_email_address;
DELIMITER $
CREATE PROCEDURE update_email_address(IN user_name_p VARCHAR(64), IN new_email VARCHAR(64))
BEGIN
    DECLARE usr_role BOOLEAN DEFAULT FALSE;
    SELECT EXISTS(SELECT * FROM user as u WHERE u.user_name = user_name_p) INTO usr_role;
    IF usr_role THEN
        UPDATE user SET email=new_email WHERE user_name = user_name_p;
    ELSE
        UPDATE chef SET email=new_email WHERE user_name = user_name_p;
    END IF;
END $

DELIMITER ;

DROP PROCEDURE IF EXISTS add_recipe;
DELIMITER $
CREATE PROCEDURE add_recipe(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64))
BEGIN
    INSERT INTO recipe (dish_name, chef) VALUES (dish_name_p, user_name_p);
    SELECT recipe_id FROM recipe WHERE dish_name=dish_name_p AND chef=user_name_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS update_recipe_image;
DELIMITER $
CREATE PROCEDURE update_recipe_image(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64), IN image_link VARCHAR(256))
BEGIN
    UPDATE recipe SET image=image_link WHERE dish_name = dish_name_p AND chef = user_name_p;
END $
DELIMITER ;


DROP PROCEDURE IF EXISTS update_recipe_description;
DELIMITER $
CREATE PROCEDURE update_recipe_description(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64),
                                           IN description_p VARCHAR(128))
BEGIN
    UPDATE recipe SET description=description_p WHERE dish_name = dish_name_p AND chef = user_name_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_recipe;
DELIMITER $
CREATE PROCEDURE remove_recipe(IN recipe_p INT)
BEGIN
    DELETE FROM recipe_contains_ingredients WHERE recipe = recipe_p;
    DELETE FROM recipe_has_flavour WHERE recipe = recipe_p;
    DELETE FROM recipe_cooking_instructions WHERE recipe = recipe_p;
    DELETE FROM recipe WHERE recipe_id = recipe_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS add_recipe_ingredient;
DELIMITER $
CREATE PROCEDURE add_recipe_ingredient(IN recipe_p INT, IN ingredient VARCHAR(64))
BEGIN
    INSERT INTO recipe_contains_ingredients VALUES (recipe_p, ingredient);
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_recipe_ingredient;
DELIMITER $
CREATE PROCEDURE remove_recipe_ingredient(IN recipe_p INT, IN ingredient_p VARCHAR(64))
BEGIN
    DELETE FROM recipe_contains_ingredients WHERE recipe = recipe_p AND ingredient = ingredient_p;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS get_chef_recipe;
DELIMITER $
CREATE PROCEDURE get_chef_recipe(IN user_name_p VARCHAR(64))
BEGIN
    SELECT * FROM recipe WHERE chef = user_name_p;
END $
DELIMITER ;

CALL register_user('hrishi', 'The asdjabnssda', 'ln', 'fn', 'hri@gmail.com', 'BLUE');
CALL register_user('hari', 'password', 'Hari', 'Columbus', 'hari@gmail.com', 'RED');
INSERT INTO address
VALUES (1, 25, "street", 123, "State");
INSERT INTO restaurant
VALUES (1, 'name', 'cuisine', 1);

CALL register_chef('hrishi2', 'The asdjabnssda', 'ln', 'fn', 'hri@gmail.com', 1);
select *
from chef;

CALL login_user("hrishi", "The asdjabnssda");

INSERT INTO dietary_restriction
VALUES ("Nut allergy", "User is allergic to nuts.");
INSERT INTO dietary_restriction
VALUES ("Gluten free", "User does not want gluten in his food");
INSERT INTO user_has_restriction
VALUES ("hrishi", "Gluten free");
INSERT INTO user_has_restriction
VALUES ("hrishi", "Nut allergy");
call get_user_dietary_restrictions("hrishi");
call set_user_dietary_restrictions("hrishi", "Nut allergy", false);


INSERT INTO flavour
VALUES ("Spicy");
INSERT INTO flavour
VALUES ("Sweet");
INSERT INTO user_has_flavour_pref
VALUES ("hrishi", "Sweet");
INSERT INTO user_has_flavour_pref
VALUES ("hrishi", "Spicy");

call get_user_flavour("hrishi");

INSERT INTO ingredient
VALUES ("potato", 100, 50, 30, 20);
INSERT INTO ingredient
VALUES ("onion", 150, 15, 45, 40);
INSERT INTO ingredient
VALUES ("tomato", 150, 15, 40, 45);

SELECT * FROM recipe_cooking_instructions;


call get_fridge_ingredient(0);

call set_user_flavour("hrishi", "sweet", false);
select *
from user_has_flavour_pref;

call set_fridge_ingredient(0, "potato", 1);
call set_fridge_ingredient(0, "onion", 1);
call get_fridge_ingredient(0);

-- INSERT INTO difficulty VALUES(1,"easy");
-- INSERT INTO difficulty VALUES(2,"medium");
-- INSERT INTO difficulty VALUES(3,"hard");

INSERT INTO recipe
VALUES (1, "", "pulav", "flavoured rice", "hrishi2");
INSERT INTO recipe_has_flavour
VALUES (1, "Spicy");
call get_all_recipes();


INSERT INTO ingredient_has_restriction
VALUES ('onion', 'Gluten free');
INSERT INTO recipe_contains_ingredients
VALUES (1, 'onion');
CALL get_custom_recipes('hrishi');
CALL get_custom_recipes('hari');

CALL preferred_recipes_with_fridge_ingredients('hari');
CALL preferred_recipes_with_fridge_ingredients('hrishi');

CALL add_recipe('Butter Chicken', 'hrishi2');
SET @rid = 0;
SELECT recipe_id
INTO @rid
FROM recipe
WHERE dish_name = "Butter Chicken"
  AND chef = "hrishi2";
CALL add_cooking_instruction(@rid, "Dice the chicken into medium sized pieces");
CALL add_cooking_instruction(@rid, "Marinate the chicken with the butter chicken sauce");
SELECT *
FROM recipe_cooking_instructions;
SELECT *
FROM user;


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

CALL update_email_address('hari', 'hari@bc.com1');
SELECT * FROM chef;

CALL get_restriction_for_recipe(1);
CALL get_recipe_information(1);
SELECT restrict_name FROM dietary_restriction dr WHERE NOT EXISTS(SELECT * FROM ingredient_has_restriction WHERE diet=restrict_name AND ingredient = ANY (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe=1));  