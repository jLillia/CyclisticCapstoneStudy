WITH user_data AS (
    SELECT * FROM `sunlit-market-337422.cyclistic.user_data`
),

null_handling_station AS (
    SELECT ride_id as null_ride_id
    FROM ( 
        SELECT 
            ride_id, 
            start_station_name,
            start_station_id,
            end_station_name, 
            end_station_id, 
            rideable_type
            FROM `sunlit-market-337422.cyclistic.user_data`
            WHERE rideable_type = "docked_bike" OR rideable_type = "classic_bike"
    )
    WHERE 
     start_station_id IS NULL AND start_station_name IS NULL OR 
     end_station_id IS NULL AND end_station_id IS NULL

),

null_cleaning_station AS (
    SELECT * 
    FROM `sunlit-market-337422.cyclistic.user_data` us
    LEFT JOIN null_handling_station nhs 
    ON us.ride_id = nhs.null_ride_id
    WHERE 
     nhs.null_ride_id IS NULL AND
     us.start_lat IS NOT NULL AND
     us.start_lng IS NOT NULL AND
     us.end_lat IS NOT NULL AND
     us.end_lng IS NOT NULL
),

agg_trip_data AS ( 
    SELECT 
     ride_id,
     member_casual AS membership,
     REPLACE(rideable_type, "docked_bike", "classic_bike") AS bike_type,
     CAST(started_at AS date) AS start_date,
     CAST(started_at AS time) AS start_time,
     CAST(ended_at AS date) AS end_date,
     CAST(ended_at AS time) AS end_time,
     IF(DATE_DIFF(ended_at,started_at,day)>0, 1, 0) AS next_day,
     DATE_DIFF(ended_at, started_at,second) AS ride_duration,
     IFNULL(TRIM(REPLACE(start_station_name, '(Temp)', '')), 'On Bike Lock') AS start_station_name,
     IFNULL(TRIM(REPLACE(end_station_name, '(Temp)', '')), 'On Bike Lock') AS end_station_name,
     start_lat, start_lng, 
     end_lat, end_lng,
     IF(start_station_id = end_station_id, 1, 0) AS returned,
    FROM 
     null_cleaning_station
    ORDER BY started_at ASC
    )
 
SELECT *
FROM agg_trip_data
WHERE
     ride_duration > 60 AND 
     ride_duration < 84600 /*24 hrs*/ 

/*SELECT bike_type, membership, count(*) AS amount_of_rides
FROM cleaned_agg_data 
GROUP BY bike_type, membership
ORDER BY membership, amount_of_rides DESC*/





