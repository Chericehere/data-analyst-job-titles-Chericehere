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

SELECT location, COUNT(title) AS postings FROM data_analyst_jobs
WHERE location = 'KY' OR location = 'TN'
GROUP BY location

SELECT COUNT (*)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')

SELECT location, COUNT(title) AS postings FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
GROUP BY location

--4.Tennessee star_rating >4
SELECT Count(Location), star_rating
FROM data_analyst_jobs
Where Location = 'TN' AND star_rating >'4'
Group BY star_rating;

--5.review count between 500 and 1000: 151
SELECT Count(review_count)
FROM data_analyst_jobs
Where review_count >= 500 AND review_count <=1000;

SELECT COUNT(title) AS Reviews500_1000 
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000

--6 Average star rating per state: NE
SELECT round(AVG(star_rating),2) AS avg_rating, location AS state
FROM data_analyst_jobs
GROUP BY state ORDER BY avg_rating DESC;

SELECT location AS state, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL AND star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC

SELECT location as state, ROUND(AVG(star_rating), 2) as avg_stars
FROM (SELECT DISTINCT company, location, star_rating
	FROM data_analyst_jobs
	WHERE location IS NOT NULL and star_rating IS NOT NULL) sub
GROUP BY location
ORDER BY avg_stars DESC;


--7 Select Unique job titles: 881
SELECT SUM(title_count) as Unique_job_title
FROM (
	Select Count(DISTINCT title) AS title_count
	FROM data_analyst_jobs
	GROUP by Title
) as sub

SELECT COUNT(DISTINCT(title))
from data_analyst_jobs;


--8 Unique job titles for California: 230
Select 
	title as job_title,
	location as state,
	SUM(title_count) over()
FROM (
	SELECT Count(DISTINCT title) AS title_count, title, location
	FROM data_analyst_jobs
	WHERE location ='CA'
	GROUP BY title, location
) as sub


SELECT COUNT(DISTINCT title) AS distinct_count_ca FROM data_analyst_jobs
WHERE location = 'CA'

--9 Company name, AVG star_rating, & company reviews > 5000
SELECT 
	DISTINCT company,
	Round(AVG(star_rating),2) as avg_rating
FROM data_analyst_jobs
WHERE review_count > '5000'
GROUP BY company
Order BY avg_rating DESC;
	
--10 see above: AMEX
--11:757
SELECT SUM(title_count) over(),
title
From (
	SELECT Count(Distinct title) AS title_count, title 
	FROM data_analyst_jobs
	WHERE title ILIKE '%Analyst%'
	Group By title
) as sub;

SELECT COUNT(DISTINCT(title))
	FROM data_analyst_jobs
	WHERE title ILIKE '%Analyst%'

SELECT DISTINCT title, (SELECT COUNT(DISTINCT title) as title_count FROM data_analyst_jobs WHERE title ILIKE '%analyst%')
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';

--12:4; visualization specialists
SELECT SUM(title_count) over(),
title as job_title
From (
	SELECT Count(Distinct title) AS title_count, title 
	FROM data_analyst_jobs
	WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%'
	Group By title
) as sub

--BONUS 
SELECT DISTINCT domain AS industry, COUNT(title) AS posting_count
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
AND domain IS NOT NULL
AND days_since_posting > 21
GROUP BY domain
ORDER BY posting_count DESC






----------------------------------------------------------------------------------------
SELECT domain, COUNT(title) AS num_jobs
	FROM data_analyst_jobs
	WHERE skill ILIKE '%SQL%' AND days_since_posting > 21  AND domain IS NOT NULL
	GROUP BY domain
	ORDER BY num_jobs DESC

SELECT DISTINCT domain AS industry, COUNT(title) AS posting_count
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
AND domain IS NOT NULL
AND days_since_posting > 21
GROUP BY domain
ORDER BY posting_count DESC

----1669 total
SELECT DISTINCT title,
       COUNT(title) OVER
         (partition by title) AS job_title_count
 FROM data_analyst_jobs
 WHERE title ILIKE '%analyst%'
 ORDER BY job_title_count DESC;
 
 SELECT company, avg_star_rating, COUNT(*) OVER()
	FROM 
 		(SELECT company, ROUND(AVG(star_rating),2) AS avg_star_rating
		FROM data_analyst_jobs 
		WHERE review_count >= 5000 AND company IS NOT NULL
 		GROUP BY company) AS sub
	ORDER BY avg_star_rating DESC
