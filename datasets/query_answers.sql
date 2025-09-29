/*

Here are 10 business-intelligence questions comparing menu items by protein type (e.g., Grilled Chicken, Grilled Spicy Chicken, Tofu, etc.).
Each question is in Markdown, followed by a SQL query you can run once the nutrition_score column is populated.

 */

-- 1. Average Nutrition Score by Protein Type

SELECT protein_type,
       ROUND(AVG(nutrition_score), 2) AS avg_nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
            WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_nutrition_score DESC;


-- 2. Count of Menu Items per Protein Type
SELECT protein_type,
       COUNT(*) AS item_count
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY item_count DESC;


-- 3. Top 3 Most Nutritious Items per Protein Type
SELECT protein_type, title, nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY nutrition_score DESC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY protein_type, rnk;

-- 4. Lowest 3 Nutrition Score Items per Protein Type
SELECT protein_type, title, nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY nutrition_score ASC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY protein_type, rnk;

-- 5. Average Calories by Protein Type
SELECT protein_type,
       ROUND(AVG(calories), 0) AS avg_calories
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_calories;

-- 6. Average Protein (grams) by Protein Type
SELECT protein_type,
       ROUND(AVG(protein_g), 1) AS avg_protein_g
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_protein_g DESC;

-- 7. Highest Protein-per-Calorie Item per Protein Type
SELECT protein_type,
       title,
       ROUND(protein_g::numeric / calories, 3) AS protein_per_cal
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY (protein_g::numeric / calories) DESC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk = 1;

-- 8. Percentage of High-Nutrition Items (Score ≥ 4) by Protein Type
SELECT protein_type,
       ROUND(100.0 * SUM(CASE WHEN nutrition_score >= 4 THEN 1 ELSE 0 END) / COUNT(*), 1)
         AS pct_high_nutrition
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type;


-- 9. Average Sodium per Protein Type
SELECT protein_type,
       ROUND(AVG(sodium_mg), 0) AS avg_sodium_mg
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_sodium_mg;

-- 10. Composite “Healthiness” Score by Protein Type (Average nutrition_score minus a small penalty for calories >600)
SELECT protein_type,
       ROUND(AVG(nutrition_score - GREATEST((calories - 600)/200.0, 0)), 2)
         AS composite_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY composite_score DESC;


/*
Here are 10 business-intelligence questions that compare menu items by product type
(where product type is the flavor family at the start of each menu‐item title, e.g.
“Curry Apple Pecan”, “Tahini Cucumber Feta”, “Chipotle Mango Avocado”, etc.).

For each query we first extract the product type by taking the text before the first “|” in the title.

 */


--  1. Average Nutrition Score by Product Type

SELECT product_type,
       ROUND(AVG(nutrition_score), 2) AS avg_nutrition_score
FROM (
    SELECT
        SPLIT_PART(title, '|', 1) AS product_type,
        nutrition_score
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY avg_nutrition_score DESC;


-- 2. Count of Menu Items per Product Type
SELECT product_type,
       COUNT(*) AS item_count
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY item_count DESC;


-- 3. Top 3 Most Nutritious Items per Product Type

SELECT product_type, title, nutrition_score
FROM (
    SELECT
        SPLIT_PART(title, '|', 1) AS product_type,
        title,
        nutrition_score,
        RANK() OVER (
            PARTITION BY SPLIT_PART(title, '|', 1)
            ORDER BY nutrition_score DESC
        ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY product_type, rnk;


-- 4. Lowest 3 Nutrition Score Items per Product Type
SELECT product_type, title, nutrition_score
FROM (
    SELECT
        SPLIT_PART(title, '|', 1) AS product_type,
        title,
        nutrition_score,
        RANK() OVER (
            PARTITION BY SPLIT_PART(title, '|', 1)
            ORDER BY nutrition_score ASC
        ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY product_type, rnk;

-- 5. Average Calories by Product Type

SELECT product_type,
       ROUND(AVG(calories), 0) AS avg_calories
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type, calories
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY avg_calories;

-- 6. Highest Protein-per-Calorie Item per Product Type

SELECT product_type,
       title,
       ROUND(protein_g::numeric / calories, 3) AS protein_per_cal
FROM (
    SELECT
        SPLIT_PART(title, '|', 1) AS product_type,
        title,
        protein_g,
        calories,
        RANK() OVER (
            PARTITION BY SPLIT_PART(title, '|', 1)
            ORDER BY (protein_g::numeric / calories) DESC
        ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk = 1
ORDER BY product_type;

-- 7. Percentage of High-Nutrition Items (Score ≥ 4) by Product Type
SELECT product_type,
       ROUND(100.0 * SUM(CASE WHEN nutrition_score >= 4 THEN 1 ELSE 0 END) / COUNT(*), 1)
           AS pct_high_nutrition
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type,
           nutrition_score
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY pct_high_nutrition DESC;


-- 8. Average Sodium by Product Type
SELECT product_type,
       ROUND(AVG(sodium_mg), 0) AS avg_sodium_mg
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type, sodium_mg
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY avg_sodium_mg;

-- 9. Highest Nutrition Score Minus Calorie Penalty (Composite) per Product Type
SELECT product_type,
       ROUND(AVG(nutrition_score - GREATEST((calories - 600)/200.0, 0)), 2)
           AS composite_score
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type,
           nutrition_score,
           calories
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY composite_score DESC;

-- 10. Product Type with Most Menu Variety (Distinct Protein Choices)
SELECT product_type,
       COUNT(DISTINCT
             CASE
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
             END) AS distinct_protein_types
FROM (
    SELECT SPLIT_PART(title, '|', 1) AS product_type,
           title
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY product_type
ORDER BY distinct_protein_types DESC;


/*

Here are 10 business-intelligence questions comparing menu items by protein type 
(e.g., Grilled Chicken, Grilled Spicy Chicken, Tofu, etc.).
Each question is in Markdown, followed by a SQL query you can run once 
the nutrition_score column is populated.

 */

 -- 1. Average Nutrition Score by Protein Type

SELECT protein_type,
       ROUND(AVG(nutrition_score), 2) AS avg_nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_nutrition_score DESC;


-- 2. Count of Menu Items per Protein Type
SELECT protein_type,
       COUNT(*) AS item_count
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY item_count DESC;

-- 3. Top 3 Most Nutritious Items per Protein Type
SELECT protein_type, title, nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY nutrition_score DESC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY protein_type, rnk;

-- 4. Lowest 3 Nutrition Score Items per Protein Type
SELECT protein_type, title, nutrition_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY nutrition_score ASC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk <= 3
ORDER BY protein_type, rnk;

-- 5. Average Calories by Protein Type

SELECT protein_type,
       ROUND(AVG(calories), 0) AS avg_calories
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_calories;


-- 6. Average Protein (grams) by Protein Type
SELECT protein_type,
       ROUND(AVG(protein_g), 1) AS avg_protein_g
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_protein_g DESC;

-- 7. Highest Protein-per-Calorie Item per Protein Type
SELECT protein_type,
       title,
       ROUND(protein_g::numeric / calories, 3) AS protein_per_cal
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type,
           RANK() OVER (
             PARTITION BY
               CASE
                 WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
                 WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
                 WHEN title ILIKE '%tofu%' THEN 'Tofu'
                 WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			           WHEN title ILIKE '%avocado%' THEN 'Avocado'
                 ELSE 'Other'
               END
             ORDER BY (protein_g::numeric / calories) DESC
           ) AS rnk
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
WHERE rnk = 1;

-- 8. Percentage of High-Nutrition Items (Score ≥ 4) by Protein Type
SELECT protein_type,
       ROUND(100.0 * SUM(CASE WHEN nutrition_score >= 4 THEN 1 ELSE 0 END) / COUNT(*), 1)
         AS pct_high_nutrition
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type;


-- 9. Average Sodium per Protein Type
SELECT protein_type,
       ROUND(AVG(sodium_mg), 0) AS avg_sodium_mg
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY avg_sodium_mg;

-- 10. Composite “Healthiness” Score by Protein Type (Average nutrition_score minus a small penalty for calories >600)

SELECT protein_type,
       ROUND(AVG(nutrition_score - GREATEST((calories - 600)/200.0, 0)), 2)
         AS composite_score
FROM (
    SELECT *,
           CASE
             WHEN title ILIKE '%spicy chicken%' THEN 'Grilled Spicy Chicken'
             WHEN title ILIKE '%grilled chicken%' THEN 'Grilled Chicken'
             WHEN title ILIKE '%tofu%' THEN 'Tofu'
             WHEN title ILIKE '%shrimp%' THEN 'Shrimp'
			       WHEN title ILIKE '%avocado%' THEN 'Avocado'
             ELSE 'Other'
           END AS protein_type
    FROM food_desert_db.menu_items
    WHERE atl_food_place_id = 2
) AS t
GROUP BY protein_type
ORDER BY composite_score DESC;



