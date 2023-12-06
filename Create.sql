DROP DATABASE IF EXISTS digidine;
CREATE DATABASE IF NOT EXISTS digidine;
USE digidine;


CREATE TABLE fridge
(
    fridge_id INT PRIMARY KEY,
    color     ENUM ("RED","GREEN","BLUE","BLACK","WHITE") NOT NULL
);

CREATE TABLE user
(
    user_name  VARCHAR(64) PRIMARY KEY,
    fridge     INT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    email      VARCHAR(64) NOT NULL UNIQUE,
    password   VARCHAR(64) NOT NULL,
    CONSTRAINT user_owns_fridge FOREIGN KEY (fridge)
        REFERENCES fridge (fridge_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT valid_user_email_constraint CHECK (email LIKE '%@%.%__'),
    CONSTRAINT valid_user_password CHECK (LENGTH(password) >= 8)
);


CREATE TABLE flavour
(
    flavour_name VARCHAR(64) PRIMARY KEY
);

CREATE TABLE dietary_restriction
(
    restrict_name VARCHAR(64) PRIMARY KEY,
    description   VARCHAR(64)
);

CREATE TABLE user_has_restriction
(
    user VARCHAR(64) NOT NULL,
    diet VARCHAR(64) NOT NULL,
    CONSTRAINT user_has_dietary_restriction FOREIGN KEY (user)
        REFERENCES user (user_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT diet_for_user FOREIGN KEY (diet)
        REFERENCES dietary_restriction (restrict_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (user, diet)
);

CREATE TABLE user_has_flavour_pref
(
    user    VARCHAR(64) NOT NULL,
    flavour VARCHAR(64) NOT NULL,
    CONSTRAINT flavour_pref FOREIGN KEY (flavour)
        REFERENCES flavour (flavour_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT user_has_pref FOREIGN KEY (user)
        REFERENCES user (user_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (user, flavour)
);

CREATE TABLE ingredient
(
    ingredient_name       VARCHAR(64) PRIMARY KEY,
    calories              DECIMAL NOT NULL,
    protein_percent       INT CHECK (protein_percent > 0),
    carbohydrates_percent INT CHECK (carbohydrates_percent > 0),
    fats_percent          INT CHECK (fats_percent > 0),
    CHECK (protein_percent + carbohydrates_percent + fats_percent = 100)
);

CREATE TABLE fridge_contains_ingredients
(
    fridge          INT         NOT NULL,
    ingredient_name VARCHAR(64) NOT NULL,
    CONSTRAINT ingredient_in_fridge FOREIGN KEY (ingredient_name)
        REFERENCES ingredient (ingredient_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fridge_has FOREIGN KEY (fridge)
        REFERENCES fridge (fridge_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (ingredient_name, fridge)
);

CREATE TABLE ingredient_has_restriction
(
    ingredient VARCHAR(64) NOT NULL,
    diet       VARCHAR(64) NOT NULL,
    CONSTRAINT ingredient_has_dietary_restriction FOREIGN KEY (ingredient)
        REFERENCES ingredient (ingredient_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT restriction_consists_of FOREIGN KEY (diet)
        REFERENCES dietary_restriction (restrict_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (ingredient, diet)
);

#Remove
CREATE TABLE address
(
    address_id  INT PRIMARY KEY,
    street_no   INT         NOT NULL,
    street_name VARCHAR(64) NOT NULL,
    zipcode     INT         NOT NULL,
    state       VARCHAR(64) NOT NULL
);

#Remove
CREATE TABLE restaurant
(
    restaurant_id INT PRIMARY KEY,
    name          VARCHAR(64) NOT NULL,
    cuisine_type  VARCHAR(64) NOT NULL,
    address       INT         NOT NULL,
    CONSTRAINT restaurant_at FOREIGN KEY (address)
        REFERENCES address (address_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE chef
(
    user_name  VARCHAR(64) PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    password   VARCHAR(64) NOT NULL,
    restaurant INT         NOT NULL,
    email      VARCHAR(64) NOT NULL,
    CONSTRAINT chef_works_at FOREIGN KEY (restaurant)
        REFERENCES restaurant (restaurant_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT valid_chef_email_constraint CHECK (email LIKE '%@%.%__'),
    CONSTRAINT valid_chef_password CHECK (LENGTH(password) >= 8)
);


drop table IF EXISTS recipe;
CREATE TABLE recipe
(
    recipe_id   INT PRIMARY KEY AUTO_INCREMENT,
    image       VARCHAR(256),
    dish_name   VARCHAR(64) NOT NULL,
    description VARCHAR(128),
    chef        VARCHAR(64) NOT NULL,
    CONSTRAINT recipe_has_chef FOREIGN KEY (chef)
        REFERENCES chef (user_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT dish_chef_uniqueness UNIQUE (dish_name, chef)
);

CREATE TABLE recipe_contains_ingredients
(
    recipe     INT         NOT NULL,
    ingredient VARCHAR(64) NOT NULL,
    CONSTRAINT recipie_contains FOREIGN KEY (ingredient)
        REFERENCES ingredient (ingredient_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ingredient_in FOREIGN KEY (recipe)
        REFERENCES recipe (recipe_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (recipe, ingredient)
);

#Remove/merge to ingredient
-- CREATE TABLE ingredient_type(
-- 	ingredient_type_id		INT			PRIMARY KEY,
--     category				VARCHAR(64) NOT NULL,
--     storage_type			VARCHAR(64),
--     ingredient				VARCHAR(64),
-- 	CONSTRAINT contains_ingredient FOREIGN KEY (ingredient)
-- 		REFERENCES ingredient(ingredient_name)
--         ON UPDATE CASCADE ON DELETE CASCADE
-- );


CREATE TABLE recipe_has_flavour
(
    recipe  INT         NOT NULL,
    flavour VARCHAR(64) NOT NULL,
    CONSTRAINT flavour_of_recipie FOREIGN KEY (flavour)
        REFERENCES flavour (flavour_name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT recipe_has_flavour FOREIGN KEY (recipe)
        REFERENCES recipe (recipe_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_contains
        PRIMARY KEY (recipe, flavour)
);

CREATE TABLE recipe_cooking_instructions
(
    recipe           INT         NOT NULL,
    step_number      INT         NOT NULL,
    step_description VARCHAR(64) NOT NULL,
    CONSTRAINT recipe_instruction FOREIGN KEY (recipe)
        REFERENCES recipe (recipe_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT instruction_key PRIMARY KEY (recipe, step_number)
);

SELECT * FROM fridge_contains_ingredients;
    


