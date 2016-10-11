SELECT
m.measure_name,
subq.Variability
FROM measures m,
(SELECT 
 qmax.id as id,
 qmax.max_read-qmin.min_read as Variability
FROM 
(SELECT
 Measure_ID as id,
 MAX(Score) as max_read
FROM readmissions
WHERE Score <> 'Not Available'
GROUP BY Measure_ID) qmax,
(SELECT
 Measure_ID as id,
 MIN(Score) as min_read
FROM readmissions
WHERE Score <> 'Not Available'
GROUP BY Measure_ID) qmin
WHERE qmin.id = qmax.id
ORDER BY Variability DESC
LIMIT 10) subq
WHERE subq.id = m.measure_id;

