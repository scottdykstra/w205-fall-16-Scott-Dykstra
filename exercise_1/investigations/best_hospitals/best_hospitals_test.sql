SELECT * 
FROM (
SELECT
h.hospital_name,
avg(ec.Score) as AVG_Score
FROM effective_care ec, hospitals h
WHERE ec.provider_id = h.provider_id
GROUP BY hospital_name, Score
ORDER BY AVG_Score ASC) qry
WHERE AVG_Score <> 'null'
LIMIT 10;

