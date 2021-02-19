--1.rows :1793
Select count (*) from data_analyst_jobs;

--2.First ten rows: ExxonMobil
Select *
FROM data_analyst_jobs
LIMIT 10;

--3.Tennessee:21; TN and KY: 27
SELECT Count(Location)
FROM data_analyst_jobs
Where Location = 'TN' OR LOCATION = 'KY';

--4.Tennessee star_rating >4
SELECT Count(Location), star_rating
FROM data_analyst_jobs
Where Location = 'TN' AND star_rating >'4'
Group BY star_rating;

--5.review count between 500 and 1000: 151
SELECT Count(review_count)
FROM data_analyst_jobs
Where review_count >= 500 AND review_count <=1000;

--6 Average star rating per state: NE
SELECT round(AVG(star_rating),2) AS avg_rating, location AS state
FROM data_analyst_jobs
GROUP BY state ORDER BY avg_rating DESC;

--7 Select Unique job titles: 881
SELECT Count(DISTINCT(title)),title
FROM data_analyst_jobs
GROUP by Title;
