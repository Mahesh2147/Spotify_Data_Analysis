SELECT * FROM spotify;

--EDA

-- NUMBER OF RECORDS
SELECT COUNT(*) FROM public.spotify;

-- COUNT OF  DISTINCT ARTIST
SELECT COUNT(DISTINCT artist) FROM spotify;

-- COUNT OF DISTINCT album_type
SELECT DISTINCT album_type FROM spotify;

-- MAX AND MIN OF duration_min
SELECT MAX(duration_min) FROM spotify;
SELECT MIN(duration_min) FROM spotify;

-- CHECK WHERE duration_min=0
SELECT * FROM spotify 
WHERE duration_min=0;

-- DELETE RECORDS WHERE duration_min=0
DELETE FROM spotify 
WHERE duration_min=0;

-- DISTINCT OF channel
SELECT DISTINCT channel FROM spotify;

-- DISTINCT OF most_played_on 
SELECT DISTINCT most_played_on FROM spotify;

---------------------------------------------------------------------------
-- DATA ANALYSIS: EASY CATEGORY
---------------------------------------------------------------------------
-- Q1.Retrieve the names of all tracks that have more than 1 billion streams.
	SELECT * FROM spotify
	WHERE stream > 1000000000;
	
-- Q2.List all albums along with their respective artists.
	SELECT 
		DISTINCT(album),artist
	FROM spotify
	ORDER BY 1;
	
-- Q3.Get the total number of comments for tracks where licensed = TRUE.
	SELECT 
		SUM(comments) as total_comments
		FROM spotify
	WHERE licensed ='true';

-- Q4.Find all tracks that belong to the album type single.
	SELECT 
		track,
		album_type
	FROM spotify
	WHERE album_type='single';
	
-- Q5.Count the total number of tracks by each artist.
	SELECT 
		artist,
		COUNT(*) AS total_no_songs
	FROM spotify
	GROUP BY artist
	ORDER BY 2 ASC;
	
---------------------------------------------------------------------------
-- DATA ANALYSIS: MEDIUM CATEGORY
---------------------------------------------------------------------------
-- Q6.Calculate the average danceability of tracks in each album.
	SELECT 
		album,
		AVG(danceability) AS avg_danceability
		FROM spotify
	GROUP BY 1
	ORDER BY 2 DESC;

-- Q7.Find the top 5 tracks with the highest energy values.
	SELECT 
		track,
		MAX(energy)
	FROM spotify
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
	
-- Q8.List all tracks along with their views and likes where official_video = TRUE.
	SELECT 
		track,
		SUM(views) AS total_views,
		SUM(likes) AS total_likes
	FROM spotify
	WHERE official_video ='true'
	GROUP BY 1
	ORDER BY 2 DESC;

-- Q9.For each album, calculate the total views of all associated tracks.
	SELECT 
		album,
		track,
		SUM(views) AS total_views
	FROM spotify
	GROUP BY 1,2
	ORDER BY 3 DESC;
	
-- Q10.Retrieve the track names that have been streamed on Spotify more than YouTube.
	SELECT * FROM
	(SELECT 
		track,
		COALESCE(SUM(CASE 
			WHEN most_played_on='Youtube' THEN stream END),0) AS streamed_on_youtube, 
		COALESCE(SUM(CASE 
			WHEN most_played_on='Spotify' THEN stream END),0) AS streamed_on_spotify
	FROM spotify
	GROUP BY 1
	) AS t1
	WHERE 
		streamed_on_spotify > streamed_on_youtube
		AND 
		streamed_on_youtube <>0
	
---------------------------------------------------------------------------
-- DATA ANALYSIS: ADVANCED CATEGORY
---------------------------------------------------------------------------
-- Q11.Find the top 3 most-viewed tracks for each artist using window functions.
	
	WITH ranking_artist
	AS
	(SELECT 
		artist,
		track,
		SUM(views) AS total_views,
		DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
	FROM spotify
	GROUP BY 1,2
	ORDER BY 1,3 DESC
	)
	SELECT * FROM ranking_artist
	WHERE rank<=3;
	
-- Q12.Write a query to find tracks where the liveness score is above the average.
	SELECT 
		track,
		artist,
		liveness
	FROM spotify 
	WHERE liveness > (SELECT AVG(liveness) FROM spotify)

-- Q13.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
	WITH CTE 
	AS
	(SELECT 
		album,
		MAX(energy) AS highest_energy,
		MIN(energy) AS lowest_energy
	FROM spotify
	GROUP BY 1
	)
	SELECT 
		album,
		highest_energy - lowest_energy AS energy_diff
	FROM CTE
	ORDER BY 2 DESC;


-- QUERY OPTIMIZATION

EXPLAIN ANALYZE
SELECT 
	artist,
	track,
	views
FROM spotify
WHERE artist ='Gorillaz'
	AND 
	most_played_on ='Youtube'
ORDER BY stream DESC LIMIT 25

CREATE INDEX artist_index ON spotify (artist);

