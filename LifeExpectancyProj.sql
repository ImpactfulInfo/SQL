#Life Expectancy Project

select *
from world_life_expectancy
;
select country, year, CONCAT(country,year), COUNT(CONCAT(country,year))
from world_life_expectancy
group by country, year, CONCAT(country,year)
having  COUNT(CONCAT(country,year)) > 1
;
select *
from
(
select row_id,
CONCAT(country,year),
row_number() over (partition by CONCAT(country,year) order by CONCAT(country,year))as row_num
from world_life_expectancy
) as row_table
where row_num >1

;
Delete from world_life_expectancy
where 
row_id in
(
select row_id
from(
select row_id,
CONCAT(country,year),
row_number() over (partition by CONCAT(country,year) order by CONCAT(country,year))as row_num
from world_life_expectancy
) as row_table
where row_num >1
)
;

select * 
from world_life_expectancy
where status = ''
;
select DISTINCT(Country)
from world_life_expectancy
where status='Developing'
;

update  world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
set t1.status = 'Developing'
where t1.status = ''
and t2.status <>''
and t2.status = 'Developing'
;
update  world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
set t1.status = 'Developed'
where t1.status = ''
and t2.status <>''
and t2.status = 'Developed'
;
select * 
from world_life_expectancy
where status <> ''

;

select * 
from world_life_expectancy
where `life expectancy` = ''




;
select t1.country, t1.year, t1.`life expectancy`,
t2.country, t2.year, t2.`life expectancy`,
t3.country, t3.year, t3.`life expectancy`,
ROUND((t2.`life expectancy` + t3.`life expectancy`)/2,1)
from world_life_expectancy t1
join world_life_expectancy t2
on t1.country=t2.country
and t1.year = t2.year - 1
join world_life_expectancy t3
on t1.country=t3.country
and t1.year = t3.year + 1
where t1.`Life expectancy` = ''
;
Update world_life_expectancy t1
join world_life_expectancy t2
on t1.country=t2.country
and t1.year = t2.year - 1
join world_life_expectancy t3
on t1.country=t3.country
and t1.year = t3.year + 1
set t1.`Life expectancy` = ROUND((t2.`life expectancy` + t3.`life expectancy`)/2,1)
where t1.`Life expectancy`= ''
;
update world_life_expectancy 
set `life expectancy` = null
where `life expectancy` = 0
;





#Exploring Data




select *
from world_life_expectancy
;
select country, MIN(`Life expectancy`),MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) as life_increase
from world_life_expectancy
group by country 
HAVING  MIN(`Life expectancy`) is not null
AND MAX(`Life expectancy`) is not null
order by life_increase DESC
;


;
Select year, ROUND(AVG(`life expectancy`),2)
from world_life_expectancy
group by year
order by year

;
select country,ROUND(AVG( `life expectancy`),2) as life_exp, ROUND(AVG(GDP),2) as gdp
from world_life_expectancy
group by country
having gdp > 0
order by gdp desc
;
select *
from world_life_expectancy
order by GDP desc
;
SELECT
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END ) high_gdp,
AVG(CASE WHEN GDP >=1500 THEN `life expectancy` ELSE NULL END ),
SUM(CASE WHEN GDP <=1500 THEN 1 ELSE 0 END ) low_gdp,
AVG(CASE WHEN GDP <=1500 THEN `life expectancy` ELSE NULL END )
from world_life_expectancy
;
SELECT Status, ROuND(AVG(`life expectancy`),1),COUNT(DISTINCT Country)
from world_life_expectancy
group by status


;
select country, ROUND(AVG(`Life Expectancy`),1) as life_exp, ROUND(AVG(BMI),1) as BMI
from world_life_expectancy
group by country
having life_exp > 0
and bmi > 0
order by bmi asc




;
select country,
year,
`Life Expectancy`,
`Adult mortality`,
SUM(`Adult mortality`) over (partition by country order by year) as rolling_total
from world_life_expectancy




;



;



;

;



;



;


;


;



;