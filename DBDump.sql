-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: digidine
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL,
  `street_no` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `zipcode` int NOT NULL,
  `state` varchar(64) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,25,'street',123,'State'),(2,45,'street new',123,'State new'),(3,58,'Cedar Avenue',456,'New York'),(4,69,'Elm Avenue',567,'Florida'),(5,72,'Oak Street',890,'California'),(6,25,'Maple Street',123,'Arizona'),(7,21,'Chestnut Avenue',567,'Washington'),(8,34,'Pine Street',890,'Oregon'),(9,47,'Elm Street',234,'Texas'),(10,10,'Oak Avenue',567,'Florida'),(11,63,'Maple Avenue',890,'California'),(12,56,'Cedar Street',123,'Arizona'),(13,89,'Sycamore Avenue',456,'New York'),(14,74,'Willow Street',789,'Colorado'),(15,35,'Walnut Avenue',234,'Montana'),(16,92,'Birch Street',567,'Michigan'),(17,28,'Hickory Avenue',890,'New Jersey'),(18,51,'Cherry Street',123,'Ohio'),(19,76,'Spruce Avenue',456,'Washington'),(20,83,'Chestnut Street',789,'Oregon'),(21,44,'Pine Avenue',234,'Texas');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chef`
--

DROP TABLE IF EXISTS `chef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chef` (
  `user_name` varchar(64) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `restaurant` int NOT NULL,
  `email` varchar(64) NOT NULL,
  PRIMARY KEY (`user_name`),
  KEY `chef_works_at` (`restaurant`),
  CONSTRAINT `chef_works_at` FOREIGN KEY (`restaurant`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `valid_chef_email_constraint` CHECK ((`email` like _utf8mb4'%@%.%__')),
  CONSTRAINT `valid_chef_password` CHECK ((length(`password`) >= 8))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chef`
--

LOCK TABLES `chef` WRITE;
/*!40000 ALTER TABLE `chef` DISABLE KEYS */;
INSERT INTO `chef` VALUES ('chef','chef','name','password',1,'chef@gmail.com'),('chef10','Michael','Rodriguez','michaelpass',13,'michaelchef@gmail.com'),('chef11','Emma','Martinez','emmapass',14,'emmachef@gmail.com'),('chef12','Ethan','Hernandez','ethanpass',15,'ethanchef@gmail.com'),('chef13','Isabella','Lopez','isabellapass',16,'isabellachef@gmail.com'),('chef14','Mia','Gonzalez','miaapass',17,'miachef@gmail.com'),('chef15','James','Wilson','jamespass',18,'jameschef@gmail.com'),('chef16','Alexander','Anderson','alexpass',19,'alexchef@gmail.com'),('chef17','Grace','Taylor','gracepass',20,'gracechef@gmail.com'),('chef18','Charlotte','Moore','charlottepass',10,'charlottechef@gmail.com'),('chef19','Daniel','Jackson','danielpass2',2,'danielchef2@gmail.com'),('chef2','James','Bond','password2',6,'bondchef@gmail.com'),('chef20','William','White','williampass',20,'williamchef@gmail.com'),('chef3','Alice','Smith','alicepass',6,'alicechef@gmail.com'),('chef4','David','Johnson','davidpass',7,'davidchef@gmail.com'),('chef5','Sophia','Williams','sophiapass',8,'sophiachef@gmail.com'),('chef6','Robert','Brown','robertpass',9,'robertchef@gmail.com'),('chef7','Olivia','Miller','oliviapass',10,'oliviachef@gmail.com'),('chef8','Daniel','Davis','danielpass',11,'danielchef@gmail.com'),('chef9','Emily','Garcia','emilypass',12,'emilychef@gmail.com');
/*!40000 ALTER TABLE `chef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dietary_restriction`
--

DROP TABLE IF EXISTS `dietary_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dietary_restriction` (
  `restrict_name` varchar(64) NOT NULL,
  `description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`restrict_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietary_restriction`
--

LOCK TABLES `dietary_restriction` WRITE;
/*!40000 ALTER TABLE `dietary_restriction` DISABLE KEYS */;
INSERT INTO `dietary_restriction` VALUES ('Alkaline','Emphasizes alkaline foods and avoids acidic ones'),('Anti-inflammatory','Focuses on reducing inflammation in the body'),('Carnivore','Primarily meat-based diet'),('Dairy Free','Avoids any dairy products'),('DASH','Dietary Approaches to Stop Hypertension'),('Flexitarian','Mostly vegetarian with occasional meat'),('Fruitarian','Mainly consists of fruits'),('GAPS','Gut and Psychology Syndrome diet'),('Gluten free','User does not want gluten in his food'),('Halal','Dietary guidelines followed by Muslims.'),('Intermittent Fasting','Cycle between periods of eating and fasting'),('Ketogenic','High-fat, low-carb diet'),('Kosher','Dietary laws followed by Jewish individuals'),('Lactose free','User is lactose intolerant'),('Low Carb','Limits intake of carbohydrates'),('Low FODMAP','Limits specific carbohydrates'),('Mediterranean','Diet inspired by traditional foods of Mediterranean countries'),('Nut allergy','User is allergic to nuts.'),('Pegan','Combines aspects of paleo and vegan diets'),('Raw Food','Primarily uncooked and unprocessed foods'),('Soy free','User wants to exclude soy based products'),('Specific Carbohydrate Diet','Eliminates certain carbohydrates'),('Sugar Free','Eliminates added sugars'),('Vegan','User only eats vegan food'),('Volumetrics','Focuses on feeling full on fewer calories'),('Weight Watchers','Focuses on portion control and balanced diet'),('Whole30','Eliminates sugar, alcohol, grains, legumes, soy, and dairy');
/*!40000 ALTER TABLE `dietary_restriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flavour`
--

DROP TABLE IF EXISTS `flavour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flavour` (
  `flavour_name` varchar(64) NOT NULL,
  PRIMARY KEY (`flavour_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flavour`
--

LOCK TABLES `flavour` WRITE;
/*!40000 ALTER TABLE `flavour` DISABLE KEYS */;
INSERT INTO `flavour` VALUES ('Bitter'),('Fruity'),('Minty'),('Salty'),('Savoury'),('Smoky'),('Sour'),('Spicy'),('Sweet'),('Umami');
/*!40000 ALTER TABLE `flavour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fridge`
--

DROP TABLE IF EXISTS `fridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fridge` (
  `fridge_id` int NOT NULL,
  `color` enum('RED','GREEN','BLUE','BLACK','WHITE') NOT NULL,
  PRIMARY KEY (`fridge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fridge`
--

LOCK TABLES `fridge` WRITE;
/*!40000 ALTER TABLE `fridge` DISABLE KEYS */;
INSERT INTO `fridge` VALUES (0,'BLUE'),(1,'RED'),(2,'GREEN'),(3,'BLUE'),(4,'BLACK'),(5,'WHITE'),(6,'RED'),(7,'GREEN'),(8,'BLUE'),(9,'BLACK'),(10,'WHITE'),(11,'RED'),(12,'GREEN'),(13,'BLUE'),(14,'BLACK'),(15,'WHITE'),(16,'RED'),(17,'GREEN'),(18,'BLUE'),(19,'BLACK'),(20,'WHITE');
/*!40000 ALTER TABLE `fridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fridge_contains_ingredients`
--

DROP TABLE IF EXISTS `fridge_contains_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fridge_contains_ingredients` (
  `fridge` int NOT NULL,
  `ingredient_name` varchar(64) NOT NULL,
  PRIMARY KEY (`ingredient_name`,`fridge`),
  KEY `fridge_has` (`fridge`),
  CONSTRAINT `fridge_has` FOREIGN KEY (`fridge`) REFERENCES `fridge` (`fridge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ingredient_in_fridge` FOREIGN KEY (`ingredient_name`) REFERENCES `ingredient` (`ingredient_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fridge_contains_ingredients`
--

LOCK TABLES `fridge_contains_ingredients` WRITE;
/*!40000 ALTER TABLE `fridge_contains_ingredients` DISABLE KEYS */;
/*!40000 ALTER TABLE `fridge_contains_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ingredient_name` varchar(64) NOT NULL,
  `calories` decimal(10,0) NOT NULL,
  `protein_percent` int DEFAULT NULL,
  `carbohydrates_percent` int DEFAULT NULL,
  `fats_percent` int DEFAULT NULL,
  PRIMARY KEY (`ingredient_name`),
  CONSTRAINT `ingredient_chk_1` CHECK ((`protein_percent` > 0)),
  CONSTRAINT `ingredient_chk_2` CHECK ((`carbohydrates_percent` > 0)),
  CONSTRAINT `ingredient_chk_3` CHECK ((`fats_percent` > 0)),
  CONSTRAINT `ingredient_chk_4` CHECK ((((`protein_percent` + `carbohydrates_percent`) + `fats_percent`) = 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES ('baking powder',5,30,30,40),('basil',5,2,3,95),('bread',150,15,40,45),('cardamom',4,3,3,94),('cayenne',9,14,10,76),('cheese',150,15,40,45),('chicken',100,50,30,20),('cinnamon',6,9,7,84),('cocoa powder',30,14,63,23),('coriander',5,8,5,87),('cucumber',10,15,10,75),('curd',150,15,45,40),('eggs',70,63,7,30),('feta cheese',200,7,3,90),('filling',120,7,43,50),('flour',120,2,67,31),('garlic',10,5,5,90),('ginger',8,5,18,77),('ground beef',250,16,1,83),('lemon',5,1,3,96),('lettuce',15,3,87,10),('milk',150,15,40,45),('mint',150,15,40,45),('mozzarella cheese',280,20,1,79),('mustard seed',4,6,4,90),('nori',50,4,86,10),('nutmeg',4,3,3,94),('olive oil',120,20,10,70),('onion',150,15,45,40),('oregano',3,2,5,93),('paprika',5,3,10,87),('parsley',5,8,5,87),('pasta',200,5,75,20),('peanut butter',150,15,40,45),('pineapple',20,30,15,55),('potato',100,50,30,20),('ricotta cheese',300,15,8,77),('rosemary',4,2,8,90),('salsa',50,4,90,6),('spinach',15,25,15,60),('sugar',50,70,10,20),('sushi rice',220,2,43,55),('taco seasoning',30,8,80,12),('thyme',3,1,2,97),('tomato',150,15,40,45),('tomato sauce',100,2,90,8),('tortillas',150,5,47,48),('turmeric',7,10,7,83);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_has_restriction`
--

DROP TABLE IF EXISTS `ingredient_has_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_has_restriction` (
  `ingredient` varchar(64) NOT NULL,
  `diet` varchar(64) NOT NULL,
  PRIMARY KEY (`ingredient`,`diet`),
  KEY `restriction_consists_of` (`diet`),
  CONSTRAINT `ingredient_has_dietary_restriction` FOREIGN KEY (`ingredient`) REFERENCES `ingredient` (`ingredient_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `restriction_consists_of` FOREIGN KEY (`diet`) REFERENCES `dietary_restriction` (`restrict_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_has_restriction`
--

LOCK TABLES `ingredient_has_restriction` WRITE;
/*!40000 ALTER TABLE `ingredient_has_restriction` DISABLE KEYS */;
INSERT INTO `ingredient_has_restriction` VALUES ('bread','Gluten free'),('flour','Gluten free'),('pasta','Gluten free'),('sushi rice','Gluten free'),('tortillas','Gluten free'),('bread','Halal'),('cheese','Halal'),('chicken','Halal'),('curd','Halal'),('eggs','Halal'),('ground beef','Halal'),('milk','Halal'),('nori','Halal'),('olive oil','Halal'),('baking powder','Kosher'),('chicken','Kosher'),('cocoa powder','Kosher'),('feta cheese','Kosher'),('onion','Kosher'),('peanut butter','Kosher'),('potato','Kosher'),('sugar','Kosher'),('tomato','Kosher'),('cheese','Lactose free'),('milk','Lactose free'),('mozzarella cheese','Lactose free'),('ricotta cheese','Lactose free'),('peanut butter','Nut allergy'),('cheese','Soy free'),('chicken','Soy free'),('curd','Soy free'),('milk','Soy free'),('peanut butter','Soy free'),('chicken','Vegan');
/*!40000 ALTER TABLE `ingredient_has_restriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(512) DEFAULT NULL,
  `dish_name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `chef` varchar(64) NOT NULL,
  PRIMARY KEY (`recipe_id`),
  UNIQUE KEY `dish_chef_uniqueness` (`dish_name`,`chef`),
  KEY `recipe_has_chef` (`chef`),
  CONSTRAINT `recipe_has_chef` FOREIGN KEY (`chef`) REFERENCES `chef` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'https://source.unsplash.com/random?burger','Burger',NULL,'chef'),(2,'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8cGFzdGF8fHx8fHwxNzAxOTY4NjI5&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080','Pasta',NULL,'chef'),(3,'https://source.unsplash.com/random?grilledcheese','Grilled cheese',NULL,'chef'),(4,'https://source.unsplash.com/random?mashed-potato','Mashed potato',NULL,'chef'),(5,'https://source.unsplash.com/random?pbj','Peanut butter sandwich',NULL,'chef'),(6,NULL,'Pizza',NULL,'chef'),(21,'https://source.unsplash.com/random?lasagna','Lasagna','Classic Italian Dish','chef2'),(22,'https://source.unsplash.com/random?sushi','Sushi','Japanese Delicacy','chef2'),(23,'https://source.unsplash.com/random?tacos','Tacos','Mexican Flavor','chef3'),(24,'https://source.unsplash.com/random?cake','Chocolate Cake','Decadent Dessert','chef4'),(25,'https://source.unsplash.com/random?salad','Greek Salad','Healthy and Fresh','chef5');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_contains_ingredients`
--

DROP TABLE IF EXISTS `recipe_contains_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_contains_ingredients` (
  `recipe` int NOT NULL,
  `ingredient` varchar(64) NOT NULL,
  PRIMARY KEY (`recipe`,`ingredient`),
  KEY `recipie_contains` (`ingredient`),
  CONSTRAINT `ingredient_in` FOREIGN KEY (`recipe`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipie_contains` FOREIGN KEY (`ingredient`) REFERENCES `ingredient` (`ingredient_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_contains_ingredients`
--

LOCK TABLES `recipe_contains_ingredients` WRITE;
/*!40000 ALTER TABLE `recipe_contains_ingredients` DISABLE KEYS */;
INSERT INTO `recipe_contains_ingredients` VALUES (24,'baking powder'),(1,'bread'),(3,'bread'),(5,'bread'),(1,'cheese'),(2,'cheese'),(3,'cheese'),(6,'cheese'),(23,'cheese'),(1,'chicken'),(2,'chicken'),(24,'cocoa powder'),(25,'cucumber'),(24,'eggs'),(25,'feta cheese'),(22,'filling'),(24,'flour'),(21,'ground beef'),(23,'ground beef'),(23,'lettuce'),(25,'lettuce'),(2,'milk'),(4,'milk'),(24,'milk'),(21,'mozzarella cheese'),(22,'nori'),(25,'olive oil'),(1,'onion'),(2,'onion'),(21,'pasta'),(5,'peanut butter'),(4,'potato'),(21,'ricotta cheese'),(23,'salsa'),(24,'sugar'),(22,'sushi rice'),(23,'taco seasoning'),(1,'tomato'),(2,'tomato'),(6,'tomato'),(25,'tomato'),(21,'tomato sauce'),(23,'tortillas');
/*!40000 ALTER TABLE `recipe_contains_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_cooking_instructions`
--

DROP TABLE IF EXISTS `recipe_cooking_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_cooking_instructions` (
  `recipe` int NOT NULL,
  `step_number` int NOT NULL,
  `step_description` varchar(512) NOT NULL,
  PRIMARY KEY (`recipe`,`step_number`),
  CONSTRAINT `recipe_instruction` FOREIGN KEY (`recipe`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_cooking_instructions`
--

LOCK TABLES `recipe_cooking_instructions` WRITE;
/*!40000 ALTER TABLE `recipe_cooking_instructions` DISABLE KEYS */;
INSERT INTO `recipe_cooking_instructions` VALUES (1,1,'Grill the burger'),(1,2,'Add sauce'),(1,3,'Put it on a bun'),(2,1,'Boil the pasta '),(2,2,'Add sauce'),(3,1,'Add bread and cheese'),(3,2,'Grill '),(4,1,'mash the potato'),(4,2,'add milk to it'),(6,1,'Bake it better'),(21,1,'Preheat the oven to 375°F'),(21,2,'Spread a layer of meat sauce in the baking dish'),(21,3,'Place a layer of lasagna noodles over the sauce'),(21,4,'Spread a layer of ricotta cheese mixture over the noodles'),(21,5,'Repeat layers until dish is full'),(21,6,'End layers with a layer of mozzarella cheese'),(21,7,'Bake in the preheated oven until bubbly and heated through'),(22,1,'Cook sushi rice according to package instructions'),(22,2,'Lay a sheet of nori on a bamboo rolling mat'),(22,3,'Spread a thin layer of rice on the nori'),(22,4,'Add filling, and roll tightly'),(22,5,'Cut the roll into bite-sized pieces'),(23,1,'Cook ground beef with taco seasoning'),(23,2,'Warm tortillas and fill with beef, cheese, lettuce, and salsa'),(23,3,'Serve with desired toppings like guacamole or sour cream'),(24,1,'Preheat oven to 350°F and grease cake pans'),(24,2,'Mix dry ingredients and wet ingredients separately'),(24,3,'Combine and pour batter into cake pans'),(24,4,'Bake for 30-35 minutes or until a toothpick comes out clean'),(25,1,'Chop fresh vegetables and mix in a large bowl'),(25,2,'Drizzle with olive oil and sprinkle with feta cheese and olives');
/*!40000 ALTER TABLE `recipe_cooking_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_has_flavour`
--

DROP TABLE IF EXISTS `recipe_has_flavour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_has_flavour` (
  `recipe` int NOT NULL,
  `flavour` varchar(64) NOT NULL,
  PRIMARY KEY (`recipe`,`flavour`),
  KEY `flavour_of_recipie` (`flavour`),
  CONSTRAINT `flavour_of_recipie` FOREIGN KEY (`flavour`) REFERENCES `flavour` (`flavour_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipe_has_flavour` FOREIGN KEY (`recipe`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_has_flavour`
--

LOCK TABLES `recipe_has_flavour` WRITE;
/*!40000 ALTER TABLE `recipe_has_flavour` DISABLE KEYS */;
INSERT INTO `recipe_has_flavour` VALUES (24,'Minty'),(1,'Salty'),(3,'Salty'),(6,'Salty'),(21,'Salty'),(1,'Savoury'),(2,'Savoury'),(3,'Savoury'),(4,'Savoury'),(21,'Savoury'),(23,'Savoury'),(25,'Savoury'),(1,'Smoky'),(22,'Sour'),(1,'Spicy'),(23,'Spicy'),(24,'Sweet'),(22,'Umami');
/*!40000 ALTER TABLE `recipe_has_flavour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `cuisine_type` varchar(64) NOT NULL,
  `address` int NOT NULL,
  PRIMARY KEY (`restaurant_id`),
  KEY `restaurant_at` (`address`),
  CONSTRAINT `restaurant_at` FOREIGN KEY (`address`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'restaurant1','Indian',1),(2,'restaurant2','Chinese',2),(6,'restaurant6','Mexican',5),(7,'restaurant7','Indian',6),(8,'restaurant8','Mediterranean',7),(9,'restaurant9','Vegetarian',8),(10,'restaurant10','Barbecue',9),(11,'restaurant11','Sushi',10),(12,'restaurant12','Steakhouse',11),(13,'restaurant13','Bakery',12),(14,'restaurant14','Seafood',13),(15,'restaurant15','Chinese',14),(16,'restaurant16','American',15),(17,'restaurant17','French',16),(18,'restaurant18','Thai',17),(19,'restaurant19','Greek',18),(20,'restaurant20','Japanese',19);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_name` varchar(64) NOT NULL,
  `fridge` int DEFAULT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`user_name`),
  UNIQUE KEY `email` (`email`),
  KEY `user_owns_fridge` (`fridge`),
  CONSTRAINT `user_owns_fridge` FOREIGN KEY (`fridge`) REFERENCES `fridge` (`fridge_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `valid_user_email_constraint` CHECK ((`email` like _utf8mb4'%@%.%__')),
  CONSTRAINT `valid_user_password` CHECK ((length(`password`) >= 8))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('user',0,'user','name','username@gmail.com','password'),('user1',1,'Alice','Smith','alice@example.com','alicepass'),('user10',10,'Jack','Taylor','jack@example.com','jackpass'),('user11',11,'Kate','Anderson','kate@example.com','katepass'),('user12',12,'Liam','Thomas','liam@example.com','liampass'),('user13',13,'Mia','Jackson','mia@example.com','miaapass'),('user14',14,'Noah','White','noah@example.com','noahpass'),('user15',15,'Olivia','Martinez','olivia@example.com','oliviapass'),('user16',16,'Peter','Harris','peter@example.com','peterpass'),('user17',17,'Quinn','Clark','quinn@example.com','quinnpass'),('user18',18,'Rachel','Lewis','rachel@example.com','rachelpass'),('user19',19,'Samuel','Lee','samuel@example.com','samuelpass'),('user2',2,'Bob','Johnson','bob@example.com','bobbypass'),('user20',20,'Taylor','Adams','taylor@example.com','taylorpass'),('user3',3,'Charlie','Williams','charlie@example.com','charliepass'),('user4',4,'David','Brown','david@example.com','davidpass'),('user5',5,'Emma','Jones','emma@example.com','emmapass'),('user6',6,'Frank','Davis','frank@example.com','frankpass'),('user7',7,'Grace','Miller','grace@example.com','gracepass'),('user8',8,'Henry','Wilson','henry@example.com','henrypass'),('user9',9,'Isabella','Moore','isabella@example.com','isabellapass');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_flavour_pref`
--

DROP TABLE IF EXISTS `user_has_flavour_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_flavour_pref` (
  `user` varchar(64) NOT NULL,
  `flavour` varchar(64) NOT NULL,
  PRIMARY KEY (`user`,`flavour`),
  KEY `flavour_pref` (`flavour`),
  CONSTRAINT `flavour_pref` FOREIGN KEY (`flavour`) REFERENCES `flavour` (`flavour_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_has_pref` FOREIGN KEY (`user`) REFERENCES `user` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_flavour_pref`
--

LOCK TABLES `user_has_flavour_pref` WRITE;
/*!40000 ALTER TABLE `user_has_flavour_pref` DISABLE KEYS */;
INSERT INTO `user_has_flavour_pref` VALUES ('user','Bitter'),('user11','Bitter'),('user16','Bitter'),('user19','Bitter'),('user4','Bitter'),('user8','Bitter'),('user','Fruity'),('user11','Fruity'),('user15','Fruity'),('user19','Fruity'),('user4','Fruity'),('user','Minty'),('user12','Minty'),('user17','Minty'),('user20','Minty'),('user5','Minty'),('user9','Minty'),('user','Salty'),('user1','Salty'),('user13','Salty'),('user6','Salty'),('user','Savoury'),('user10','Savoury'),('user18','Savoury'),('user3','Savoury'),('user7','Savoury'),('user','Smoky'),('user','Sour'),('user12','Sour'),('user14','Sour'),('user2','Sour'),('user20','Sour'),('user5','Sour'),('user6','Sour'),('user','Spicy'),('user14','Spicy'),('user16','Spicy'),('user2','Spicy'),('user8','Spicy'),('user','Sweet'),('user1','Sweet'),('user10','Sweet'),('user15','Sweet'),('user18','Sweet'),('user7','Sweet'),('user13','Umami'),('user17','Umami'),('user3','Umami'),('user9','Umami');
/*!40000 ALTER TABLE `user_has_flavour_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_restriction`
--

DROP TABLE IF EXISTS `user_has_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_restriction` (
  `user` varchar(64) NOT NULL,
  `diet` varchar(64) NOT NULL,
  PRIMARY KEY (`user`,`diet`),
  KEY `diet_for_user` (`diet`),
  CONSTRAINT `diet_for_user` FOREIGN KEY (`diet`) REFERENCES `dietary_restriction` (`restrict_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_has_dietary_restriction` FOREIGN KEY (`user`) REFERENCES `user` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_restriction`
--

LOCK TABLES `user_has_restriction` WRITE;
/*!40000 ALTER TABLE `user_has_restriction` DISABLE KEYS */;
INSERT INTO `user_has_restriction` VALUES ('user','Alkaline'),('user','Anti-inflammatory'),('user','Carnivore'),('user','Dairy Free'),('user','DASH'),('user','Flexitarian'),('user','Fruitarian'),('user','GAPS');
/*!40000 ALTER TABLE `user_has_restriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'digidine'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_cooking_instruction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_cooking_instruction`(IN recipe_id_p INT, IN instruction VARCHAR(64))
BEGIN
    DECLARE current_steps INT;
    SELECT COUNT(*) FROM recipe_cooking_instructions WHERE recipe = recipe_id_p INTO current_steps;
    INSERT INTO recipe_cooking_instructions VALUES (recipe_id_p, current_steps + 1, instruction);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_dietary_restriction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_dietary_restriction`(IN user_name_p VARCHAR(64), IN restriction VARCHAR(64))
BEGIN
    INSERT INTO user_has_restriction VALUES (user_name_p, restriction);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recipe`(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64))
BEGIN
    INSERT INTO recipe (dish_name, chef) VALUES (dish_name_p, user_name_p);
    SELECT recipe_id FROM recipe WHERE dish_name=dish_name_p AND chef=user_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_recipe_flavour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recipe_flavour`(IN recipe_p INT, IN flavour_p VARCHAR(64))
BEGIN
	DECLARE req BOOLEAN;
    SELECT NOT EXISTS(SELECT * FROM recipe_has_flavour WHERE recipe=recipe_p AND flavour=flavour_p) INTO req;
    IF req THEN
		INSERT INTO recipe_has_flavour VALUES (recipe_p, flavour_p);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_recipe_ingredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recipe_ingredient`(IN recipe_p INT, IN ingredient VARCHAR(64))
BEGIN
    INSERT INTO recipe_contains_ingredients VALUES (recipe_p, ingredient);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `all_recipes_with_fridge_ingredients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `all_recipes_with_fridge_ingredients`(IN user_name_p VARCHAR(64))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_cooking_instruction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_cooking_instruction`(IN recipe_id_p INT, IN step_number_p INT, IN instruction VARCHAR(64))
BEGIN
    UPDATE recipe_cooking_instructions
    SET step_description=instruction
    WHERE recipe = recipe_id_p
      AND step_number = step_number_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_recipes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_recipes`()
BEGIN
    SELECT * from recipe;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_restaurant`()
BEGIN
    SELECT * from restaurant;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_chef_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_chef_recipe`(IN user_name_p VARCHAR(64))
BEGIN
    SELECT * FROM recipe WHERE chef = user_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_custom_recipes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_custom_recipes`(IN user_name_p VARCHAR(64))
BEGIN
    SELECT recipe_id, image,dish_name,description, chef
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
             WHERE recipe_id = SOME ( #Merge all recipes that satisfies user dietary restriction AND user flavor preferences
        SELECT recipe_id
        FROM recipe
        WHERE NOT EXISTS(SELECT * FROM user_has_flavour_pref WHERE user = user_name_p) #If no flavor preference, take all recipes
        UNION
        SELECT recipe_id
        FROM recipe r
        WHERE #Get recipes that match user flavor preference
              EXISTS(SELECT flavour
                     FROM user_has_flavour_pref AS uf
                     WHERE user = user_name_p
                       AND EXISTS(SELECT *
                                  FROM recipe_has_flavour
                                  WHERE r.recipe_id
                                    AND uf.flavour = flavour)));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flavour_for_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_flavour_for_recipe`(IN recipe_id_p INT)
BEGIN
    SELECT flavour_name, recipe IS NOT NULL AS is_present FROM flavour LEFT OUTER JOIN (SELECT * FROM recipe_has_flavour WHERE recipe=recipe_id_p) ri ON flavour=flavour_name ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_fridge_ingredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fridge_ingredient`(
    IN fridge_id_p INT
)
BEGIN
    SELECT fridge IS NOT NULL AS is_present, fridge_id_p, i.ingredient_name as fridge_ingredients
    FROM ingredient as i
             left outer join (SELECT * FROM fridge_contains_ingredients WHERE fridge_id_p = fridge) as f
                             on i.ingredient_name = f.ingredient_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ingredients_for_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_ingredients_for_recipe`(IN recipe_id_p INT)
BEGIN
    SELECT ingredient_name, recipe IS NOT NULL AS is_present FROM ingredient LEFT OUTER JOIN (SELECT * FROM recipe_contains_ingredients WHERE recipe=recipe_id_p) ri ON ingredient=ingredient_name ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_recipe_information` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_recipe_information`(IN recipe_id_p INT)
BEGIN
    SELECT *
    FROM recipe WHERE recipe_id = recipe_id_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_recipe_instructions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_recipe_instructions`(IN recipe_id INT)
BEGIN
SELECT * FROM recipe_cooking_instructions where recipe = recipe_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_restaurants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_restaurants`()
BEGIN
SELECT * FROM restaurant;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_restriction_for_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_restriction_for_recipe`(IN recipe_id INT)
BEGIN
    SELECT restrict_name
    FROM dietary_restriction dr
    WHERE NOT EXISTS(SELECT *
                     FROM ingredient_has_restriction
                     WHERE diet = restrict_name
                       AND ingredient = ANY
                           (SELECT ingredient FROM recipe_contains_ingredients WHERE recipe = recipe_id));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_dietary_restrictions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_dietary_restrictions`(
    IN user_name VARCHAR(64)
)
BEGIN
    SELECT restrict_name, description, user IS NOT NULL AS has_restriction
    FROM dietary_restriction as d
             left outer join (SELECT * FROM user_has_restriction WHERE user = user_name) as u
                             on d.restrict_name = u.diet;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_flavour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_flavour`(
    IN user_name VARCHAR(64)
)
BEGIN
    SELECT flavour_name, user IS NOT NULL AS has_flavour_pref
    FROM flavour as f
             left outer join (SELECT * FROM user_has_flavour_pref WHERE user = user_name) as u
                             on f.flavour_name = u.flavour;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_user`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `preferred_recipes_with_fridge_ingredients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `preferred_recipes_with_fridge_ingredients`(IN user_name_p VARCHAR(64))
BEGIN
    SELECT *
    FROM (SELECT recipe_id, image,dish_name,description, chef
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
             WHERE recipe_id = SOME ( #Merge all recipes that satisfies user dietary restriction AND user flavor preferences
        SELECT recipe_id
        FROM recipe
        WHERE NOT EXISTS(SELECT * FROM user_has_flavour_pref WHERE user = user_name_p) #If no flavor preference, take all recipes
        UNION
        SELECT recipe_id
        FROM recipe r
        WHERE #Get recipes that match user flavor preference
              EXISTS(SELECT flavour
                     FROM user_has_flavour_pref AS uf
                     WHERE user = user_name_p
                       AND EXISTS(SELECT *
                                  FROM recipe_has_flavour
                                  WHERE r.recipe_id
                                    AND uf.flavour = flavour))))
             AS preferred_recipes
    WHERE NOT EXISTS(SELECT *
                     FROM recipe_contains_ingredients
                     WHERE recipe = preferred_recipes.recipe_id
                       AND ingredient NOT IN (SELECT ingredient_name
                                              FROM fridge_contains_ingredients
                                                       NATURAL JOIN (SELECT fridge
                                                                     FROM user
                                                                     WHERE user_name = user_name_p) user_fridge));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_chef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_chef`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_cooking_instruction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_cooking_instruction`(IN recipe_id_p INT)
BEGIN
	DECLARE step_count INT;
    SELECT MAX(step_number) INTO step_count FROM recipe_cooking_instructions WHERE recipe = recipe_id_p;
    IF step_count > 0 THEN
		DELETE FROM recipe_cooking_instructions WHERE recipe = recipe_id_p AND step_number = step_count;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_dietary_restriction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_dietary_restriction`(IN user_name_p VARCHAR(64), IN restriction VARCHAR(64))
BEGIN
    DELETE FROM user_has_restriction WHERE user = user_name_p AND diet = restriction;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_recipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_recipe`(IN recipe_p INT)
BEGIN
    DELETE FROM recipe_contains_ingredients WHERE recipe = recipe_p;
    DELETE FROM recipe_has_flavour WHERE recipe = recipe_p;
    DELETE FROM recipe_cooking_instructions WHERE recipe = recipe_p;
    DELETE FROM recipe WHERE recipe_id = recipe_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_recipe_flavour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_recipe_flavour`(IN recipe_p INT, IN flavour_p VARCHAR(64))
BEGIN
	DECLARE req BOOLEAN;
    SELECT EXISTS(SELECT * FROM recipe_has_flavour WHERE recipe=recipe_p AND flavour=flavour_p) INTO req;
    IF req THEN
		DELETE FROM recipe_has_flavour WHERE recipe = recipe_p AND flavour = flavour_p;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_recipe_ingredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_recipe_ingredient`(IN recipe_p INT, IN ingredient_p VARCHAR(64))
BEGIN
    DELETE FROM recipe_contains_ingredients WHERE recipe = recipe_p AND ingredient = ingredient_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_fridge_ingredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_fridge_ingredient`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_user_dietary_restrictions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_user_dietary_restrictions`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_user_flavour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_user_flavour`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_chef_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_chef_restaurant`(IN user_name_p VARCHAR(64), IN restaurant_p INT)
BEGIN
    UPDATE chef SET restaurant=restaurant_p WHERE user_name = user_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_email_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_email_address`(IN user_name_p VARCHAR(64), IN new_email VARCHAR(64))
BEGIN
    DECLARE usr_role BOOLEAN DEFAULT FALSE;
    SELECT EXISTS(SELECT * FROM user as u WHERE u.user_name = user_name_p) INTO usr_role;
    IF usr_role THEN
        UPDATE user SET email=new_email WHERE user_name = user_name_p;
    ELSE
        UPDATE chef SET email=new_email WHERE user_name = user_name_p;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_recipe_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_recipe_description`(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64),
                                           IN description_p VARCHAR(128))
BEGIN
    UPDATE recipe SET description=description_p WHERE dish_name = dish_name_p AND chef = user_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_recipe_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_recipe_image`(IN dish_name_p VARCHAR(64), IN user_name_p VARCHAR(64), IN image_link VARCHAR(256))
BEGIN
    UPDATE recipe SET image=image_link WHERE dish_name = dish_name_p AND chef = user_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-07 23:46:45
