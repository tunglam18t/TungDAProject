--Find the top 5 succesful directors in 21 century with total movies greater than 5 and highset average IMDb rating
SELECT TOP 5 Director,
       round(avg(imdb_rating), 1) AS Avg_IMDb,
       avg(metascore) AS Avg_MetaScore,
       count(title) AS Total_Movies
FROM (SELECT * FROM imdb_data WHERE YEAR BETWEEN 2000 AND 2024) AS filtered_data  -- Filter movies by year first
GROUP BY Director
HAVING count(title) >= 5;


--Find out the percentage ratio of movie genres in all movies of Dataset.
WITH total_films AS (
    SELECT COUNT(*) AS total_count FROM imdb_data
)
SELECT 
    genre, 
    COUNT(*) AS genre_count, 
    ROUND(AVG(imdb_rating), 2) AS avg_rating,
    ROUND(COUNT(*) * 100.0 / (SELECT total_count FROM total_films), 2) AS percentage
FROM 
    imdb_data
GROUP BY 
    genre;


--Top 10 best actors sorted by number of movies and average imdb 
select top 10 star_cast, count(*) as total_star_in_movie, round(avg(imdb_rating) ,2) as avg_rating_imdb
from imdb_data_3
group by Star_Cast
order by 2 desc, 3 desc

--The Quality of all movies and percentage in data set.
WITH total_films AS (
    SELECT COUNT(*) AS total_count FROM imdb_data)
SELECT Movies_Evaluate, Total_Movies, Total_Movies*100/(SELECT total_count FROM total_films) as percentage
FROM
	(SELECT Movies_Evaluate, count(*) as Total_Movies
	FROM
		(SELECT Title, 
			   Director, 
			   Duration_minutes,
			   CASE WHEN IMDb_Rating  > 8 THEN
						CASE WHEN MetaScore > 80 THEN 'Outstanding'
							 ELSE 'Engaging'
						END
					WHEN IMDb_Rating  BETWEEN 6 and 8 THEN 'Decent'
					ELSE 'Mediocre' 
				END AS Movies_Evaluate
		from imdb_data) Movie_Evaluate
	GROUP BY Movies_Evaluate) Evaluate_Count



