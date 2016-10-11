DROP TABLE hospitals;
CREATE TABLE hospitals AS SELECT 
cast(provider_id as int), 
hospital_name, 
State
FROM hospitals_raw;

DROP TABLE surveys_responses;
CREATE TABLE surveys_responses AS SELECT 
cast(provider_id as int), 
cast(LPAD(Overall_Rating_of_Hospital_Dimension_Score,1,'') as int) AS Overall_Rating_Of_Hospital
FROM surveys_responses_raw;

DROP TABLE readmissions;
CREATE TABLE readmissions AS SELECT 
cast(provider_id as int), 
Compared_to_National,
Score
FROM readmissions_raw;

DROP TABLE effective_care;
CREATE TABLE effective_care AS SELECT 
cast(provider_id as int), 
cast(Measure_ID as int), 
Condition,
cast(Score as int),
cast(Sample as int)
FROM effective_care_raw;

DROP TABLE measures;
CREATE TABLE measures AS SELECT 
cast(Measure_ID as int), 
Measure_Name
FROM measures_raw;