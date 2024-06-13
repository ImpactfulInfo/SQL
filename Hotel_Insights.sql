-- A Hotel Company has reached out to me to get a few metrics from their datbase.
-- What rooms are being booked the most and What rooms bring in the most Revenue?--
-- What is our cancellation rate?--
-- What is the best time of year for our company?--
-- What is our companies growth over the past 2 years?--
-- Is there a correlation between price and cancellation?

SELECT *
FROM testing.hotel_reservations;


-- What rooms are being booked the most and What rooms bring in the most Revenue?
SELECT room_type_reserved, COUNT(*) NumRoomSold, AVG(avg_price_per_room) AVG_price, AVG(avg_price_per_room) * COUNT(*) Estimated_Revenue
FROM testing.hotel_reservations
WHERE avg_price_per_room > 1
GROUP BY room_type_reserved
ORDER BY Estimated_Revenue desc;
-- TOP 3 ROOMS BY REVENUE
-- Room_Type 1 -  28130 Rooms Sold, EstRevenue - $2,698,179.30
-- Room_Type 4 - 6057 Rooms Sold, EstRevenue - $758,865.28
-- Room_Type 6 - 966 Rooms Sold, EstRevenue - $176,017.59



-- What is our cancellation rate?
SELECT booking_status, ROUND(COUNT(booking_status) / (SELECT COUNT(*) 
FROM testing.hotel_reservations) * 100, 2)
FROM testing.hotel_reservations
GROUP BY booking_status;
-- 32.76% Cancellation Rate


-- What is the best time of year for our company?
SELECT SUM(avg_price_per_room)
FROM testing.hotel_reservations;
-- Total Revenue $3,751,688.87

-- This is the only question that calls for months so I did it this way
CREATE VIEW Monthly_Revenue AS
SELECT CASE WHEN arrival_month = 1 THEN 'January' 
WHEN arrival_month = 2 THEN 'February' 
WHEN arrival_month = 3 THEN 'March' 
WHEN arrival_month = 4 THEN 'April' 
WHEN arrival_month = 5 THEN 'May' 
WHEN arrival_month = 6 THEN 'June' 
WHEN arrival_month = 7 THEN 'July' 
WHEN arrival_month = 8 THEN 'August' 
WHEN arrival_month = 9 THEN 'September' 
WHEN arrival_month = 10 THEN 'October' 
WHEN arrival_month = 11 THEN 'November'  
WHEN arrival_month = 12 THEN 'December' 
END as Months
, SUM(avg_price_per_room) revenue
FROM testing.hotel_reservations
GROUP BY Months
Order by revenue desc;
-- August, September, October make up over 1/3 of the Total Revenue the company has seen 
-- While January, February, March  make up just barely a ninth of total profit. 
-- Focus on keeping revenue up during Aug-Oct to compensate for the winter months, or find a way to draw in an audience for those cold winter months



-- What is our companies growth over the past 2 years?
SELECT arrival_year, SUM(avg_price_per_room) revenue
FROM testing.hotel_reservations
GROUP BY arrival_year
;

-- Revenue increased from 586,000 to 3.1 million giving a revenue growth of 539%





-- Is there a correlation between price and cancellation?
CREATE VIEW room_cancellation AS 
SELECT COUNT(booking_status) cancel_count, CASE WHEN avg_price_per_room < 100 THEN '0-99'
WHEN avg_price_per_room >= 100 AND avg_price_per_room <= 200 THEN '100-200'
WHEN avg_price_per_room >= 201 AND avg_price_per_room <=300 THEN '200-300'
ELSE 'Over 300'
END as Num_Group
FROM testing.hotel_reservations
WHERE booking_status = 'canceled'
GROUP BY Num_Group;
-- room prices from $0-200 make up for 97% of their total cancellations 

SELECT market_segment_type, booking_status,COUNT(booking_status)
FROM testing.hotel_reservations
GROUP BY market_segment_type,booking_status
;
-- Of the cancellations Online buyers make up for 71% of them with 8475















