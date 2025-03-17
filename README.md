# Spotify_Data_Analysis

**Dataset Link:** 
# Key Sections and Queries

 # 1. Exploratory Data Analysis (EDA)
 * Basic Data Inspection

```
SELECT * FROM spotify;
SELECT COUNT(*) FROM public.spotify;
```
  * Checks the structure and number of records in the spotify table.

* Distinct Counts
```
SELECT COUNT(DISTINCT artist) FROM spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT DISTINCT channel FROM spotify;
```
  * Identifies unique artists, album types, and distribution channels.

* Duration Insights
```
SELECT MAX(duration_min) FROM spotify;
SELECT MIN(duration_min) FROM spotify;
```
  * Finds the longest and shortest track durations.

* Data Cleaning
```
SELECT * FROM spotify WHERE duration_min=0;
DELETE FROM spotify WHERE duration_min=0;
```
  * Identifies and removes records with zero duration, which might be data errors.

# 2. Business Analysis Queries
  This section provides insights into Spotify’s business performance and trends.

* Top-Streamed Songs
```
SELECT * FROM spotify WHERE stream > 1000000000;
```
  * Identifies tracks with more than 1 billion streams.

* Album Popularity
```
SELECT album_name, SUM(stream) AS total_streams
FROM spotify
GROUP BY album_name
ORDER BY total_streams DESC;
```
  * Ranks albums by their total streaming numbers.

* Most Popular Artists
```
SELECT artist, SUM(stream) AS total_streams
FROM spotify
GROUP BY artist
ORDER BY total_streams DESC;
```
  * Determines which artists generate the most streams.

* Most Played Platforms
```
SELECT most_played_on, COUNT(*) AS play_count
FROM spotify
GROUP BY most_played_on
ORDER BY play_count DESC;
```
  * Shows which platforms (e.g., Spotify, YouTube, Apple Music) get the most plays.

# Conclusion

1.Identifying hit songs: Helps Spotify recognize which tracks are most popular.
2.Artist and album performance: Assists in revenue-sharing and promotional strategies.
3.Understanding listening habits: Determines which platforms users prefer.
4.Data quality issues: Ensures accurate data by removing incorrect records.


