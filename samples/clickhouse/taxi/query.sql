SELECT
    pickup_ntaname,
    count(*) AS count
FROM taxi WHERE pickup_ntaname != ''
GROUP BY pickup_ntaname
ORDER BY count DESC
LIMIT 10;
SELECT
    passenger_count,
    avg(total_amount)
FROM taxi
WHERE passenger_count < 10
GROUP BY passenger_count;
SELECT
    passenger_count,
    avg(trip_distance) AS distance,
    count() AS c
FROM taxi
GROUP BY passenger_count
ORDER BY passenger_count ASC;