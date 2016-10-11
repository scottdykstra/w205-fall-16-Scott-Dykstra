SELECT 
 h.hospital_name,
 sr.Overall_Rating_of_Hospital,
 ec.Avg_EC_Score,
 read.below_avg as Count_Below_Avg_Readmission
FROM hospitals h, surveys_responses sr, 
(SELECT 
  provider_id,
  avg(Score) as Avg_EC_Score
FROM effective_care 
GROUP BY provider_id) ec,
(SELECT 
  provider_id,
  count(*) as below_avg
 FROM readmissions
 WHERE Compared_to_National = 'Worse than the National Rate'
 GROUP BY provider_id) read
WHERE ec.provider_id = h.provider_id
 AND ec.provider_id = sr.provider_id
 and ec.provider_id = read.provider_id
ORDER BY sr.Overall_Rating_of_Hospital ASC
LIMIT 10;

SELECT 
 h.hospital_name,
 sr.Overall_Rating_of_Hospital,
 ec.Avg_EC_Score,
 read.below_avg as Count_Below_Avg_Readmission
FROM hospitals h, surveys_responses sr, 
(SELECT 
  provider_id,
  avg(Score) as Avg_EC_Score
FROM effective_care 
GROUP BY provider_id) ec,
(SELECT 
  provider_id,
  count(*) as below_avg
 FROM readmissions
 WHERE Compared_to_National = 'Worse than the National Rate'
 GROUP BY provider_id) read
WHERE ec.provider_id = h.provider_id
 AND ec.provider_id = sr.provider_id
 and ec.provider_id = read.provider_id
ORDER BY sr.Overall_Rating_of_Hospital DESC
LIMIT 10;