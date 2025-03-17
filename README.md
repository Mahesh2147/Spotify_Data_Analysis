# Spotify_Data_Analysis

**Dataset Link:** https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset
# Key Sections and Queries

 # 1. Exploratory Data Analysis (EDA)
 * Basic Data Inspection

```
# Checks the structure and number of records in the spotify table.
SELECT * FROM spotify;
SELECT COUNT(*) FROM public.spotify;
```
  
* Distinct Counts
```
#Identifies unique artists, album types, and distribution channels.
SELECT COUNT(DISTINCT artist) FROM spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT DISTINCT channel FROM spotify;
```
   
* Duration Insights
```
# Finds the longest and shortest track durations.
SELECT MAX(duration_min) FROM spotify;
SELECT MIN(duration_min) FROM spotify;
```
  

* Data Cleaning
```
# Identifies and removes records with zero duration, which might be data errors.
SELECT * FROM spotify WHERE duration_min=0;
DELETE FROM spotify WHERE duration_min=0;
```
  

# 2. Business Analysis Queries
  This section provides insights into Spotify’s business performance and trends.

* Top-Streamed Songs
```
# Identifies tracks with more than 1 billion streams.
SELECT * FROM spotify WHERE stream > 1000000000;
```
   

* Album Popularity
```
# Ranks albums by their total streaming numbers.
SELECT album_name, SUM(stream) AS total_streams
FROM spotify
GROUP BY album_name
ORDER BY total_streams DESC;
```

* Most Popular Artists
```
# Determines which artists generate the most streams.
SELECT artist, SUM(stream) AS total_streams
FROM spotify
GROUP BY artist
ORDER BY total_streams DESC;
```

* Most Played Platforms
```
# Shows which platforms (e.g., Spotify, YouTube, Apple Music) get the most plays.
SELECT most_played_on, COUNT(*) AS play_count
FROM spotify
GROUP BY most_played_on
ORDER BY play_count DESC;
```
  

# Business Problems Addressed
The SQL file tackles several real-world business problems for Spotify, including:

1.Identifying hit songs: Helps Spotify recognize which tracks are most popular.

2.Artist and album performance: Assists in revenue-sharing and promotional strategies.

3.Understanding listening habits: Determines which platforms users prefer.

4.Data quality issues: Ensures accurate data by removing incorrect records.

# Query Optimization Technique
  To improve query performance, we carried out the following optimization process:

* Initial Query Performance Analysis Using EXPLAIN

   * We began by analyzing the performance of a query using the EXPLAIN function.
   * The query retrieved tracks based on the artist column, and the performance metrics were as follows:
     * Execution time (E.T.): 5.644 ms
     * Planning time (P.T.): 0.104 ms
   * Below is the screenshot of the EXPLAIN result before optimization: EXPLAIN Before Index
   ![Screenshot 2025-03-08 113013](https://github.com/user-attachments/assets/cd14eaac-28b8-4929-aa86-db17d062bd60)


* Index Creation on the artist Column
  
   * To optimize the query performance, we created an index on the artist column. This ensures faster retrieval of rows          where the artist is queried.
   * SQL command for creating the index:
   ``` CREATE INDEX idx_artist ON spotify_tracks(artist); ```

* Performance Analysis After Index Creation

   * After creating the index, we ran the same query again and observed significant improvements in performance:
     * Execution time (E.T.): 0.578 ms
     * Planning time (P.T.): 0.495 ms
   * Below is the screenshot of the EXPLAIN result after index creation: EXPLAIN After Index
![Screenshot 2025-03-08 113218](https://github.com/user-attachments/assets/2d893e1e-8f9b-4674-a5a0-4d687bac53cd)


* Graphical Performance Comparison

   * A graph illustrating the comparison between the initial query execution time and the optimized query execution time         after index creation.
   * Graph view shows the significant drop in both execution and planning times:
     ![Screenshot 2025-03-08 113807](https://github.com/user-attachments/assets/e29307f6-e434-44a5-b41e-8b1fd32e35ca)

    This optimization shows how indexing can drastically reduce query time, improving the overall performance of our            database operations in the Spotify project.


  
