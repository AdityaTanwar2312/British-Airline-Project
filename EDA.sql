SELECT *
FROM ba_reviews;

-- Different types of Seats and Travel Classes

SELECT DISTINCT(traveller_type),
seat_type
FROM ba_reviews
Order BY 1;

-- Different countries to which Flights can be taken

SELECT DISTINCT(place)
FROM ba_reviews
ORDER BY 1;

-- Finding rating of flights to a specific country Example United States
SELECT place, rating
FROM ba_reviews
WHERE place LIKE'%States%';

-- Sorting out by aircraft types and average rating for each aircraft
SELECT place, aircraft, AVG(rating) AS Avg_Rating
FROM ba_reviews
WHERE place LIKE'%States%'
GROUP BY place, aircraft;

-- Similary we can do for any country Example: India
SELECT place, aircraft, AVG(rating) AS Avg_Rating
FROM ba_reviews
WHERE place LIKE'%India%'
GROUP BY place, aircraft;

-- For checking indivisual rating of different services

SELECT place, aircraft,
AVG(rating) AS Avg_Rating,
AVG(cabin_staff_service) AS Avg_CSS,
AVG(food_beverages) AS AvgFoodRating,
AVG(seat_comfort) AS AvgSeatComfort,
AVG(value_for_money) AS Avg_Value
FROM ba_reviews
WHERE place LIKE'%States%'
GROUP BY place, aircraft;

-- Recommendation for each aircraft

SELECT place, aircraft, seat_type,
COUNT(CASE WHEN recommended = 'yes' THEN 1 END) AS recommend,
COUNT(CASE WHEN recommended = 'no' THEN 1 END) AS not_recommended
FROM ba_reviews
GROUP BY place, aircraft, seat_type
ORDER BY 1;

-- Percentage of Yes and No counts
-- But as the reviews are less the percentages will be high
SELECT place, aircraft,
COUNT(CASE WHEN recommended = 'yes' THEN 1 END) AS recommend,
COUNT(CASE WHEN recommended = 'no' THEN 1 END) AS not_recommended,
ROUND(COUNT(CASE WHEN recommended = 'yes' THEN 1 END) * 100.0 / COUNT(*), 1) AS yes_percentage,
ROUND(COUNT(CASE WHEN recommended = 'no' THEN 1 END) * 100.0 / COUNT(*), 1) AS no_percentage
FROM ba_reviews
GROUP BY place, aircraft
ORDER BY 1;

-- Cheking out other table content for the data
SELECT *
FROM countries
ORDER BY 1;

-- Join statements
SELECT
    countries.Continent,
    countries.Country,
    ba_reviews.aircraft
FROM countries
RIGHT JOIN ba_reviews ON countries.Country = ba_reviews.place
ORDER BY 2;

-- Subquery
SELECT a.Continent, COUNT(a.aircraft)
FROM(
    SELECT
    countries.Continent,
    countries.Country,
    ba_reviews.aircraft
    FROM countries
    RIGHT JOIN ba_reviews ON countries.Country = ba_reviews.place
    ORDER BY 2
) a
GROUP BY a.Continent;

SELECT a.Continent, COUNT(a.aircraft), AVG(rating) as avg_rating
FROM(
    SELECT
    countries.Continent,
    countries.Country,
    ba_reviews.aircraft,
    ba_reviews.rating
    FROM countries
    RIGHT JOIN ba_reviews ON countries.Country = ba_reviews.place
    ORDER BY 2
) a
GROUP BY a.Continent;

-- CTEs 
with Sample as (
SELECT DISTINCT(traveller_type),
seat_type
FROM ba_reviews
Order BY 1)
select * from Sample where (
    seat_type='First Class'
)

-- ROW_NUMBER(), RANK() and DENSE_RANK()