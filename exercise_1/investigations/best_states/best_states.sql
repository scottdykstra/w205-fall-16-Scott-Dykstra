SELECT
state,
avg(Avg_EC_Score) as Avg_State_Score
FROM
(SELECT 
  h.provider_id,
  h.state as state,
  avg(ec.Score) as Avg_EC_Score
FROM effective_care ec, hospitals h
WHERE ec.provider_id = h.provider_id
GROUP BY h.provider_id, state) q1
GROUP BY state 
ORDER BY Avg_State_Score DESC
LIMIT 30;

