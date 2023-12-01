DROP DATABASE digidine;
CREATE DATABASE IF NOT EXISTS digidine;
USE digidine;


CREATE TABLE fridge(
	fridge_id			INT			PRIMARY KEY,
    color				VARCHAR(64) NOT NULL,
    notes				INT
);

CREATE TABLE note(
	note_id			INT,
    fridge			INT,
    color			VARCHAR(64) NOT NULL,
    content			VARCHAR(64) NOT NULL,
	CONSTRAINT note_stuck_on FOREIGN KEY (fridge)
		REFERENCES fridge(fridge_id)
        ON UPDATE CASCADE ON DELETE CASCADE    
);

CREATE TABLE user (
    user_id INT PRIMARY KEY,
    owns_fridge	INT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL,
    password VARCHAR(64) NOT NULL,
	CONSTRAINT user_owns_fridge FOREIGN KEY (owns_fridge)
		REFERENCES fridge(fridge_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE flavour (
    flavour_id INT PRIMARY KEY,
    flavour_name VARCHAR(64) NOT NULL
);

CREATE TABLE dietary_restriction (
    restrict_id INT PRIMARY KEY,
    description VARCHAR(64)
);

CREATE TABLE user_has_restriction(
	user INT NOT NULL,
    diet	INT NOT NULL,
	CONSTRAINT user_has_dietary_restriction FOREIGN KEY (user)
		REFERENCES user(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT diet_for_user FOREIGN KEY (diet)
		REFERENCES dietary_restriction(restrict_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_contains
		PRIMARY KEY (user, diet)
);

CREATE TABLE meal_type(
	meal_type_id			INT			PRIMARY KEY,
    meal_name				VARCHAR(64) NOT NULL
);

CREATE TABLE difficulty(
	level				INT PRIMARY KEY,
    badge				VARCHAR(64) NOT NULL
);


CREATE TABLE recipie (
    recipie_id INT PRIMARY KEY,
    dish_name VARCHAR(64) NOT NULL,
    description VARCHAR(128) NOT NULL,
    cooking_instruction VARCHAR(128) NOT NULL,
    total_calories VARCHAR(64) NOT NULL,
    meal_type		INT NOT NULL,
    difficulty		INT	NOT NULL,
	CONSTRAINT recipie_has_meal_type FOREIGN KEY (meal_type)
		REFERENCES meal_type(meal_type_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT recipie_has_difficulty FOREIGN KEY (difficulty)
		REFERENCES difficulty(level)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ingredient (
    ingredient_id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    calories DECIMAL NOT NULL,
    protien VARCHAR(64),
    carbohydrates VARCHAR(64),
    fats VARCHAR(64)
);

CREATE TABLE ingredient_has_restriction(
	ingredient INT NOT NULL,
    diet		INT NOT NULL,
	CONSTRAINT ingredient_has_dietary_restriction FOREIGN KEY (ingredient)
		REFERENCES ingredient(ingredient_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT restriction_consists_of FOREIGN KEY (diet)
		REFERENCES dietary_restriction(restrict_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_contains
		PRIMARY KEY (ingredient, diet)
);

CREATE TABLE recipe_contains_ingredients(
	recipie 		INT NOT NULL,
    ingredient		INT NOT NULL,
	CONSTRAINT recipie_contains FOREIGN KEY (ingredient)
		REFERENCES ingredient(ingredient_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ingredient_in FOREIGN KEY (recipie)
		REFERENCES recipie(recipie_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_contains
		PRIMARY KEY (recipie, ingredient)
);

CREATE TABLE ingredient_type(
	ingredient_type_id		INT			PRIMARY KEY,
    category				VARCHAR(64) NOT NULL,
    storage_type			VARCHAR(64),
    ingredient				INT,
	CONSTRAINT contains_ingredient FOREIGN KEY (ingredient)
		REFERENCES ingredient(ingredient_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE review(
	rating_value		DECIMAL,
    comments			VARCHAR(64) NOT NULL,
    user				INT 		NOT NULL,
    recipie				INT 		NOT NULL,
	CONSTRAINT user_reviews FOREIGN KEY (user)
		REFERENCES user(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT recipe_review FOREIGN KEY (recipie)
		REFERENCES recipie(recipie_id)
        ON UPDATE CASCADE ON DELETE CASCADE    
);

CREATE TABLE recipie_favourite_of(
	recipie 		INT NOT NULL,
    user		INT NOT NULL,
	CONSTRAINT user_likes FOREIGN KEY (user)
		REFERENCES user(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT recipie_favourite_of FOREIGN KEY (recipie)
		REFERENCES recipie(recipie_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_contains
		PRIMARY KEY (recipie, user)
);

CREATE TABLE recipie_has_flavour(
	recipie 		INT NOT NULL,
    flavour			INT NOT NULL,
	CONSTRAINT flavour_of_recipie FOREIGN KEY (flavour)
		REFERENCES flavour(flavour_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT recipie_has_flavour FOREIGN KEY (recipie)
		REFERENCES recipie(recipie_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_contains
		PRIMARY KEY (recipie, flavour)
);

CREATE TABLE address(
	address_id			INT			PRIMARY KEY,
    street_no			INT 		NOT NULL,
    street_name			VARCHAR(64) NOT NULL,
    zipcode				INT 		NOT NULL,
    state				VARCHAR(64) NOT NULL
);

CREATE TABLE restaurant(
	restaurant_id		INT 		PRIMARY KEY,
    name				VARCHAR(64) NOT NULL,
    cuisine_type		VARCHAR(64) NOT NULL,
    address				INT			NOT NULL,
	CONSTRAINT restaurant_at FOREIGN KEY (address)
		REFERENCES address(address_id)
        ON UPDATE CASCADE ON DELETE CASCADE
    
);

CREATE TABLE chef (
    chef_id 	INT PRIMARY KEY,
    recipies	INT NOT NULL,
    restaurant	INT NOT NULL,
	CONSTRAINT chef_at FOREIGN KEY (chef_id)
		REFERENCES user(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT chef_creates FOREIGN KEY (recipies)
		REFERENCES recipie(recipie_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT chef_works_at FOREIGN KEY (restaurant)
		REFERENCES restaurant(restaurant_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);