SELECT
 rideable_type
FROM
 `sunlit-market-337422.cyclistic.user_data`
WHERE 
 rideable_type = "docked_bike"

SELECT 
 rideable_type, 
 REPLACE(rideable_type, "docked_bike", "classic_bike") as rideable_type,
FROM 
 cyclistic.user_data

SELECT 
 * 
FROM 
 `sunlit-market-337422.cyclistic.user_data`
WHERE 
 TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1 OR
   TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440;

SELECT 
 * 
FROM 
 `sunlit-market-337422.cyclistic.user_data`
WHERE 
 start_lat IS NULL OR
 start_lng IS NULL OR
 end_lat IS NULL OR
 end_lng IS NULL;

SELECT 
 DISTINCT member_casual
FROM 
 cyclistic.user_data

-- 4. Check the start/end station name/id columns for naming inconsistencies


SELECT 
 start_station_name, count(*)
FROM 
 `sunlit-market-337422.cyclistic.user_data`
GROUP BY 
 start_station_name
ORDER BY 
 start_station_name;

SELECT 
 end_station_name, count(*)
FROM 
 `sunlit-market-337422.cyclistic.user_data`
GROUP BY 
 end_station_name
ORDER BY 
 end_station_name;

SELECT 
 COUNT(DISTINCT(start_station_name)) AS unq_startname,
 COUNT(DISTINCT(end_station_name)) AS unq_endname,
 COUNT(DISTINCT(start_station_id)) AS unq_startid,
 COUNT(DISTINCT(end_station_id)) AS unq_endid
FROM 
 `sunlit-market-337422.cyclistic.user_data`;


SELECT 
 DISTINCT start_station_name,
 COUNT(start_station_name) as num_stn
FROM 
 `sunlit-market-337422.cyclistic.user_data`
GROUP BY 
 start_station_name
ORDER BY 
 num_stn DESC
