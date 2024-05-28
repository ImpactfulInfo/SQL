# CLEANING DATA

Select * 
from us_household_income
;
SELECT * 
FROM housing.us_household_income_statistics;

ALTER TABLE housing.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`






Select COUNT(id)
from us_household_income
;
SELECT COUNT(id)
FROM housing.us_household_income_statistics;








Select * 
from us_household_income
;
SELECT * 
FROM housing.us_household_income_statistics
;


Select id, COUNT(id)
from us_household_income
group by id
having COUNT(id) >1


;
SELECT *
FROM (
Select Row_id,
id,
row_number() over (partition by id order by id) row_num
from us_household_income
) duplicates
where row_num >1
;

delete from us_household_income
where ROW_ID in 
( SELECT ROW_ID
FROM (
Select Row_id,
id,
row_number() over (partition by id order by id) row_num
from us_household_income
) duplicates
where row_num >1
)
;
Select State_ab, count(distinct state_ab)
from us_household_income
group by state_ab
;

update us_household_income
set state_name = 'Georgia'
where state_name = 'georia'
;
update us_household_income
set state_name = 'Alabama'
where state_name = 'alabama'
;
update us_household_income
set place = 'Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont'
;
Select type, COUNT(type)
from us_household_income
group by type
;

update us_household_income
set type='Borough'
where type='Boroughs'
;


select Aland, Awater
from us_household_income
where (Awater = 0 or Awater = '' or Awater = null)
and (Aland = 0 or Aland = '' or Aland = null)
;



#EXPLORING DATA 

select *
from us_household_income
;

select *
from us_household_income_statistics
;
select state_name, sum(Aland), SUM(Awater)
from us_household_income
group by state_name
order by 1 asc
;


select i.state_name,  ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
from us_household_income i
 inner join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by i.State_Name
order by 2 asc
;
select type,COUNT(Type),  ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
from us_household_income i
 inner join us_household_income_statistics s
on i.id=s.id
where mean <> 0
group by type
having COUNT(Type) >100
order by 2 asc
;
select i.state_name, city, ROUND(AVG(MEAN),1),ROUND(AVG(MEDIAN),1)
from us_household_income i
 inner join us_household_income_statistics s
on i.id=s.id
group by i.State_Name, city
order by ROUND(AVG(MEAN),1) desc
