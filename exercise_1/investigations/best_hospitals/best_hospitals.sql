SELECT
 h.hospital_name,
 subqry1.AVG_EC_Score,
 subqry2.Count_of_Above_Avg
FROM hospitals h,
(SELECT 
  provider_id,
  avg(Score) as AVG_EC_Score
FROM effective_care 
GROUP BY provider_id) subqry1, 
(SELECT 
  provider_id,
  count(*) as Count_of_Above_Avg
 FROM readmissions
 WHERE Compared_to_National = 'Better than the National Rate'
 GROUP BY provider_id) subqry2
WHERE subqry1.provider_id = subqry2.provider_id
 AND h.provider_id = subqry1.provider_id
 AND subqry2.Count_of_Above_Avg > 0
ORDER BY AVG_EC_Score DESC
LIMIT 10;

