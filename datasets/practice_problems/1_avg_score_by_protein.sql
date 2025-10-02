SELECT * FROM food_desert_db.atl_food_place;
SELECT * FROM food_desert_db.menu_items;

/* Data exploration 

Find the atl_food_place_id Gusto!
*/

SELECT
	
	DISTINCT(a.title),
	a.atl_food_place_id
FROM food_desert_db.atl_food_place as a;

-- gusto atl_place_id = 2

/* Data exploration 

menu items
*/

--  filter menu items for gusto

SELECT
	*
FROM food_desert_db.menu_items AS m 
WHERE atl_food_place_id = 2;

--  find gustos overall avg nutritional score
SELECT
	ROUND(AVG(m.nutrition_score),2) AS avg_nutrition_score
FROM food_desert_db.menu_items AS m 
WHERE atl_food_place_id = 2;

-- how do we parse protein types?
SELECT 
	DISTINCT (m.title)

FROM food_desert_db.menu_items AS m 
WHERE atl_food_place_id = 2;

-- use case statement + iLike to categorize by protein type
/*
starts with chicken --> 'chicken%'
ends with chicken -->'%chicken'
contains chicken anywhere --> '%chicken%'
Like --> case sensitive
iLike --> case insensitive 

title starts with chicken (lowercase only)
title LIKE '%chicken'

title ends with chicken (lowercase only)
title Like 'chicken%'

title containts chicken (lowercase only)
title LIKE '%chicken%'

title starts with chicken (case insensitive)
title iLIKE '%chicken'

title ends with chicken (case insensitive)
title iLike 'chicken%'

title containts chicken (case insensitive)
title iLIKE '%chicken%'

*/

/* CASE STATEMENTS

IF / THEN / ELSE in plain language.

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE result_if_nothing_matches
END
 EXAMPLE 
SELECT 
  score,
  CASE
    WHEN score >= 90 THEN 'A'
    WHEN score >= 80 THEN 'B'
    WHEN score >= 70 THEN 'C'
    ELSE 'F'
  END AS grade
FROM students;


*/


-- 1. Average Nutrition Score by Protein Type for Gusto 

-- first just try getting all data with new field 'protein type' included
-- just checking for chicken
SELECT 
	*,
	CASE
		WHEN m.title iLIKE '%chicken%' THEN 'Chicken'
			ELSE 'Other'
	END AS protien_type
FROM food_desert_db.menu_items AS m 


--  checking for spicy or grilled chicken
SELECT 
	*,
	CASE
		WHEN m.title iLIKE '%spicy chicken%' THEN 'Spicy Chicken'
		WHEN m.title iLIKE '%grilled chicken%' THEN 'Grilled Chicken'
			ELSE 'Other'
	END AS protien_type
FROM food_desert_db.menu_items AS m 


--  checking for all proteins --> our subquery
SELECT 
	*,
	CASE
		WHEN m.title iLIKE '%spicy chicken%' THEN 'Spicy Chicken'
		WHEN m.title iLIKE '%grilled chicken%' THEN 'Grilled Chicken'
		WHEN m.title iLIKE '%shrimp%' THEN 'Shrimp'
		WHEN m.title iLIKE '%tofu%' THEN 'Tofu'
		WHEN m.title iLIKE '%avocado%' THEN 'Avocado'
			ELSE 'Other'
	END AS protien_type
FROM food_desert_db.menu_items AS m 


-- final query
SELECT
	protein_type,
	ROUND(AVG(nutrition_score),2) as avg_nutrition_score
FROM 
	(
	SELECT 
		*,
		CASE
			WHEN m.title iLIKE '%spicy chicken%' THEN 'Spicy Chicken'
			WHEN m.title iLIKE '%grilled chicken%' THEN 'Grilled Chicken'
			WHEN m.title iLIKE '%shrimp%' THEN 'Shrimp'
			WHEN m.title iLIKE '%tofu%' THEN 'Tofu'
			WHEN m.title iLIKE '%avocado%' THEN 'Avocado'
				ELSE 'Other'
		END AS protein_type
	FROM food_desert_db.menu_items AS m 
	) AS t
GROUP BY 
	protein_type
ORDER BY ROUND(AVG(nutrition_score),2) DESC;

-- Create view 

CREATE OR REPLACE VIEW gusto_avg_nutrition AS
SELECT
    protein_type,
    ROUND(AVG(nutrition_score),2) as avg_nutrition_score
FROM 
    (
    SELECT 
        *,
        CASE
            WHEN m.title iLIKE '%spicy chicken%' THEN 'Spicy Chicken'
            WHEN m.title iLIKE '%grilled chicken%' THEN 'Grilled Chicken'
            WHEN m.title iLIKE '%shrimp%' THEN 'Shrimp'
            WHEN m.title iLIKE '%tofu%' THEN 'Tofu'
            WHEN m.title iLIKE '%avocado%' THEN 'Avocado'
                ELSE 'Other'
        END AS protein_type
    FROM food_desert_db.menu_items AS m 
    ) AS t
GROUP BY 
    protein_type
ORDER BY ROUND(AVG(nutrition_score),2) DESC;
