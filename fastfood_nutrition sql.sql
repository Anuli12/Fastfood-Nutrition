-- Nutritional Analysis of FastFood Meals: A Comparison of Popular Restaurant Chains
-- QUERYING DATA WITH SQL
-- The convenience and affordability of fast food are well-known, but it is also infamous for its high-calorie, high-cholesterol, and high-sugar content. 
-- The purpose of this analysis is to enhance our comprehension of the nutritional consequences of fast food consumption and to strive towards producing healthier food alternatives in the fast food sector.

-- Fastfood Dataset Information
SELECT *
FROM fastfood;

-- Drop Column that is not needed
ALTER TABLE fastfood
DROP COLUMN salad;

-- Create a new table (fastfood1) which holds a copy of the fastfood table. This is to ensure preservation of the original dataset. 
CREATE TABLE fastfood1 LIKE fastfood;

-- Create a new column (fastfood_item) to have distinct item
ALTER TABLE fastfood
ADD COLUMN fastfood_item VARCHAR(255) AFTER restaurant;

CREATE TEMPORARY TABLE temp_item AS (
  SELECT DISTINCT item
  FROM fastfood
);
UPDATE fastfood f1
SET fastfood_item = (
  SELECT item
  FROM temp_item
  WHERE item = f1.item 
);

-- Throughout my Data Exploration, I followed the "Question-Observations" framework to examine individual data attributes. 

-- QUESTIONS

-- 1)What is the average number of calories in a fast food meal?
SELECT AVG(calories) AS avg_calories
FROM fastfood;
-- Observations
-- A fast food meal typically contains an average of 537 calories.

-- 2)What are the top three and bottom three Fastfood items with the highest and lowest calorie counts?
 (SELECT fastfood_item, calories, restaurant
 FROM fastfood
ORDER BY calories DESC
LIMIT 3)
UNION ALL
(SELECT fastfood_item, calories, restaurant
FROM fastfood
ORDER BY calories ASC
LIMIT 3);
-- Observations
-- MacDonald's restaurant serves fast food items that comprises of 20 Buttermilk Crispy Chicken Tenders, 40 Chicken McNuggets, and 10 Sweet N' Spicy Honey BBQ Glazed Tenders, which has the highest calorie counts of 2430, 1770, and 1600 respectively. 
-- On the other hand, Dairy Queen, Subway and Arbys restaurants serve the lowest calorie items that comprises of Side Salad,  Veggie Delite Salad, and Chopped Side Salad, which have 20, 50, and 70 calories respectively.

-- 3)Which fast food item has the highest amount of saturated fat?
SELECT fastfood_item, sat_fat
FROM fastfood
ORDER BY sat_fat DESC
LIMIT 1;
-- Observations
-- The Super Sonic Bacon Double Cheeseburger (with mayo) contains the highest quantity of saturated fat, which amounts to 36.

-- 4)What is the average amount of cholesterol in a fast food meal?
SELECT AVG(cal_fat)
FROM fastfood;
-- Observations
-- On average, a fast food meal contains 229.5 units of cholesterol.

-- 5) Which restaurant offers the highest amount of fiber in their fastfood item?
SELECT restaurant, fiber, fastfood_item
FROM fastfood
ORDER BY fiber DESC
LIMIT 1;
-- Observations
-- Subway restaurant offers the highest amount of fiber in their fastfood item-Footlong Meatball Marinara, which has the the highest fiber content of 16.

-- 6)Which fast food items have the highest amount of vitamin A?
SELECT fastfood_item, vit_A
FROM fastfood
ORDER BY vit_a DESC
LIMIT 1;
-- Observations
-- The fast food item with the highest amount of vitamin A is the Premium Asian Salad without Chicken, which contains 180 units.

-- 7)Which two fast food items have the highest calcium content?
SELECT calcium, fastfood_item
FROM fastfood
ORDER BY calcium DESC
LIMIT 2;
-- Observations
-- The Crispy Maple Bacon Dijon Chicken Sandwich and Regular Cheese Curds are the fast food items with the highest calcium content, containing 290 and 100 units respectively.

-- 8)Which fast food item have the highest amount of vitamin C?
SELECT vit_c, fastfood_item, restaurant
FROM fastfood
ORDER BY vit_c DESC
LIMIT 1;
-- Observations
-- The Footlong Turkey & Bacon Avocado offered by Subway restaurant has the highest vitamin C content of 400 units among all their menu items.

-- 9) What is the average amount of trans fat in a fast food meal?
SELECT AVG(trans_fat)
FROM fastfood;
-- Observations
-- On average, a fast food meal contains 0.46 units of trans fat.

-- 10)What are the top three restaurant chain that has the highest average calorie count per meal?
SELECT restaurant, AVG(calories)
FROM fastfood
GROUP BY restaurant 
ORDER BY AVG(calories) DESC 
LIMIT 3;
 -- Observations
-- The top three restaurant chains with the highest average calorie count per meal are McDonald's, Sonic, and Taco Bell, with 640, 620, and 523 respectively.

-- 11)Which restaurant offers fast food items with the highest sugar content?
SELECT restaurant, sugar, fastfood_item
FROM  fastfood
ORDER BY sugar DESC
LIMIT 1;
 -- Observations
 -- McDonalds has the highest sugar content in their fast food item- 10 piece Sweet N' Spicy Honey BBQ Glazed Tenders, with an average sugar content of 87 grams per serving.

-- 12)What are the top three restaurants with the most fast food items served?
SELECT restaurant, COUNT(fastfood_item) as num_items
FROM fastfood
GROUP BY restaurant
ORDER BY num_items DESC
LIMIT 3;
 -- Observations
 -- Subway offers the largest variety of fast food items, totaling 96, while McDonald's and Sonic follow with 57 and 49 items respectively.
  
 
-- KEY INSIGHTS
-- Fast food meals typically contain an average of 537 calories, 229.5 units of cholesterol, and 0.46 units of trans fat.
-- McDonald's offers a fast food item with the highest calorie counts, which is a combination of 20 Buttermilk Crispy Chicken Tenders, 40 Chicken McNuggets, and 10 Sweet N' Spicy Honey BBQ Glazed Tenders.
-- McDonald's also has the highest sugar content in their fast food item, the 10 piece Sweet N' Spicy Honey BBQ Glazed Tenders, with an average of 87 grams per serving.
-- Subway restaurant offers the highest fiber content in their Footlong Meatball Marinara, highest vitamin C content in their Footlong Turkey & Bacon Avocado, and has the most number of fast food items served with a total of 96.
-- The fast food item with the highest amount of vitamin A is the Premium Asian Salad without Chicken, while the fast food items with the highest calcium content are the Crispy Maple Bacon Dijon Chicken Sandwich and Regular Cheese Curds.
-- McDonald's, Sonic, and Taco Bell are the top three restaurant chains with the highest average calorie count per meal.

-- CONCLUSION
-- TThe findings of the analysis suggest that while fast food meals can be high in calories, cholesterol, and sugar, specific items on the menu such as Footlong Meatball Marinara, Footlong Turkey & Bacon Avocado, and Premium Asian Salad without Chicken may provide more nutritional value, such as increased fiber and vitamin content. 
-- Therefore, it is important for consumers to take into account the nutritional information and make informed choices when selecting fast food options.
 