/*SELECT
 rideable_type
FROM
 `sunlit-market-337422.cyclistic.user_data`
WHERE rideable_type = "docked_bike"*/

/*SELECT 
 rideable_type, 
 REPLACE(rideable_type, "docked_bike", "classic_bike") as rideable_type,
FROM cyclistic.user_data*/

/*SELECT * 
FROM `sunlit-market-337422.cyclistic.user_data`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1 OR
   TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440;*/

/*SELECT * 
FROM `sunlit-market-337422.cyclistic.user_data`
WHERE start_lat IS NULL OR
 start_lng IS NULL OR
 end_lat IS NULL OR
 end_lng IS NULL;*/

 /*SELECT DISTINCT member_casual
 FROM cyclistic.user_data*/

 /*
#4. Check the start/end station name/id columns for naming inconsistencies
*/
/*
SELECT start_station_name, count(*)
FROM `sunlit-market-337422.cyclistic.user_data`
GROUP BY start_station_name
ORDER BY start_station_name;

SELECT end_station_name, count(*)
FROM `sunlit-market-337422.cyclistic.user_data`
GROUP BY end_station_name
ORDER BY end_station_name;

SELECT COUNT(DISTINCT(start_station_name)) AS unq_startname,
   COUNT(DISTINCT(end_station_name)) AS unq_endname,
   COUNT(DISTINCT(start_station_id)) AS unq_startid,
   COUNT(DISTINCT(end_station_id)) AS unq_endid
FROM `sunlit-market-337422.cyclistic.user_data`;
*/
/*
Start and end station names need to be cleaned up:
 -Remove leading and traling spaces.
 -Remove substrings '(Temp)' as Cyclisitc uses these substrings when repairs
  are happening to a station. All station names should have the same naming conventions.
 -Found starting/end_names with "DIVVY CASSETTE REPAIR MOBILE STATION", "Lyft Driver Center Private Rack",
  "351", "Base - 2132 W Hubbard Warehouse", Hubbard Bike-checking (LBS-WH-TEST), "WEST CHI-WATSON".
   We will delete these as they are maintainence trips.
 -Start and end station id columns have many naming convention errors and different string lengths.
  As they do not offer any use to the analysis and there is no benefit to cleaning them, they will be ignored.
*/

SELECT 
 DISTINCT start_station_name,
 COUNT(start_station_name) as num_stn
FROM `sunlit-market-337422.cyclistic.user_data`
GROUP BY start_station_name
ORDER BY num_stn DESC
