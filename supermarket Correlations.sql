 -- A supermarket chain wanted to see some overall progress and some potential correlations between shoppers, their branches, and product lines
 
 
 
 
 SELECT * 
 FROM testing.supermarket_sales;
-- Obtaining each branches Member to Non member count/ OVR Rating/ Product Line Revenues



SELECT Branch, SUM(`gross income`) total_income
FROM  testing.supermarket_sales
GROUP BY Branch;
-- Branch A $5057.16
-- Branch B $5057.03
-- Branch C $5265.17




SELECT Branch,  `Customer Type`, COUNT(`Customer Type`) Cus_Count
FROM testing.supermarket_sales
GROUP BY Branch,`Customer Type`
ORDER BY Branch;
-- Branch A has the highest Customer Count  w/ 340 total customers and 167 being members
-- Branch C has the lowest Customer Count but has more members than the other 2 branches w/ 328 total customers and 169 being members




SELECT Branch, `Product line`, AVG(total)
FROM testing.supermarket_sales
GROUP BY Branch, `Product line`
order by AVG(total) desc;
-- On average Branch B has highest total in Health and Beauty
-- Branch C has the highest Food & Beverage totals
-- Branch A does not have any category where they out-perform the other two competitors




SELECT AVG(Rating), Branch
FROM testing.supermarket_sales
GROUP BY Branch
order by Branch;
-- Branch A 7.02 avg rating 
-- Branch B avg rating 6.81
-- Branch C avg rating 7.07








-- Insights on Cutsomers/Product Line
SELECT `Customer Type`, SUM(`gross income`) as cus_total
FROM testing.supermarket_sales
GROUP BY `Customer Type`
ORDER BY cus_total;
-- Member Total - $7820.16
-- Non Member Total - $7559.20




SELECT `Product Line`, SUM(`gross income`) as cus_total
FROM testing.supermarket_sales
GROUP BY `Product Line`
ORDER BY cus_total;
-- Health & Beauty is the lowest income at $2342
-- Food & Beverage is the highest at $2673








SELECT payment, AVG(Total)
FROM testing.supermarket_sales
GROUP BY payment;
-- People with cash spend more than people using a card or some form of mobile payment 

SELECT `Product line` ,Gender, SUM(`gross income`) 
FROM testing.supermarket_sales
GROUP BY `Product line`, Gender
order by `Product line`;

-- Electronics is slightly more on the Male side at $1296 compared to Female at $1290
-- Female audience dominates Fashion with $1449 compared to Males at $1136 spent
-- Female audience spends almost $500 total more than Males with $1579 total and $1093 to Male spending
-- Male audience dominates an unexpected category Health and Beauty with a total of $1458 to Female spending at $883
-- Home and Lifestyle Female audience at $1430 compared to Males $1134
-- Sports and Travel is close with $1360 spent by Females and $1264 by the Males


-- This information can be used to help cater to audiences already buying the products, or help get rid of that discrepency
-- Make the numbers more even between the two main groups and build revenue where you could be lacking or keep pushing the people who are already buying to buy more













