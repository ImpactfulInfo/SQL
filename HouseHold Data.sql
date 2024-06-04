# CLEANING DATA

Select * 
FROM us_household_income
;
SELECT * 
FROM housing.us_household_income_statistics;

ALTER TABLE housing.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`






Select COUNT(id)
FROM us_household_income
;
SELECT COUNT(id)
FROM housing.us_household_income_statistics;








Select * 
FROM us_household_income
;
SELECT * 
FROM housing.us_household_income_statistics
;


SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) >1


;
SELECT *
FROM (
SELECT Row_id,
id,
row_number() over (partition by id order by id) row_num
FROM us_household_income
) duplicates
WHERE row_num >1
;

DELETE FROM us_household_income
WHERE ROW_ID in 
( SELECT ROW_ID
FROM (
SELECT Row_id,
id,
row_number() over (partition by id order by id) row_num
FROM us_household_income
) duplicates
WHERE row_num >1
)
;
SELECT State_ab, count(distinct state_ab)
FROM us_household_income
GROUP BY state_ab
;

UPDATE us_household_income
SET state_name = 'Georgia'
WHERE state_name = 'georia'
;
UPDATE us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama'
;
UPDATE us_household_income
SET place = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont'
;
Select type, COUNT(type)
from us_household_income
group by type
;

UPDATE us_household_income
SET type='Borough'
WHERE type='Boroughs'
;


SELECT Aland, Awater
FROM us_household_income
WHERE (Awater = 0 or Awater = '' or Awater = null)
AND (Aland = 0 or Aland = '' or Aland = null)
;



#EXPLORING DATA 

SELECT *
FROM us_household_income
;

SELECT *
FROM us_household_income_statistics
;
SELECT state_name, sum(Aland), SUM(Awater)
FROM us_household_income
GROUP BY state_name
ORDER BY 1 asc
;
-- Finding average/median income per state
SELECT i.state_name,  ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income i
 INNER JOIN us_household_income_statistics s
on i.id=s.id
WHERE mean <> 0
GROUP BY i.State_Name
ORDER BY 2 asc
 ;
-- finding averages and median for housing in different areas(city,borough, town, village...etc)
SELECT type,COUNT(Type),  ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income i
 INNER JOIN us_household_income_statistics s
on i.id=s.id
WHERE mean <> 0
GROUP BY type
HAVING COUNT(Type) >100
ORDER BY 2 asc
;
-- Sorting by city per state, can be filtered by adding "WHERE i.state_name =" 
SELECT i.state_name, city, ROUND(AVG(MEAN),1),ROUND(AVG(MEDIAN),1)
FROM us_household_income i
INNER JOIN us_household_income_statistics s
on i.id=s.id
 GROUP BY i.State_Name, city
ORDER BY ROUND(AVG(MEAN),1) desc
