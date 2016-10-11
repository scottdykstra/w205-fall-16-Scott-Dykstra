
DROP TABLE hospitals_raw;
CREATE EXTERNAL TABLE hospitals_raw (provider_id String,hospital_name String,Address String,City String,State String,ZIP_Code String,County_Name String,Phone_Number String,Hospital_Type String,Hospital_Ownership String,Emergency_Services String) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
"separatorChar" = ",", 
"quoteChar" = '"',
"escapeChar" = '\\' 
) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE surveys_responses_raw;
CREATE EXTERNAL TABLE surveys_responses_raw
(provider_id String,hospital_name String,Address String,City String,State String,ZIP_Code String,County_Name String,Communication_with_Nurses_Achievement_Points String,Communication_with_Nurses_Improvement_Points String,Communication_with_Nurses_Dimension_Score String,Communication_with_Doctors_Achievement_Points String,Communication_with_Doctors_Improvement_Points String,Communication_with_Doctors_Dimension_Score String,Responsiveness_of_Hospital_Staff_Achievement_Points String,Responsiveness_of_Hospital_Staff_Improvement_Points String,Responsiveness_of_Hospital_Staff_Dimension_Score String,Pain_Management_Achievement_Points String,Pain_Management_Improvement_Points String,Pain_Management_Dimension_Score String,Communication_about_Medicines_Achievement_Points String,Communication_about_Medicines_Improvement_Points String,Communication_about_Medicines_Dimension_Score String,Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points String,Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points String,Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score String,Discharge_Information_Achievement_Points String,Discharge_Information_Improvement_Points String,Discharge_Information_Dimension_Score String,Overall_Rating_of_Hospital_Achievement_Points String,Overall_Rating_of_Hospital_Improvement_Points String,Overall_Rating_of_Hospital_Dimension_Score String,HCAHPS_Base_Score_HCAHPS_Consistency_Score int)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
"separatorChar" = ",", 
"quoteChar" = '"',
"escapeChar" = '\\' 
) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/surveys_responses';

DROP TABLE readmissions_raw;
CREATE EXTERNAL TABLE readmissions_raw (provider_id String,hospital_name String,Address String,City String,State String,ZIP_Code String,County_Name String,Phone_Number String,Measure_Name String,Measure_ID String,Compared_to_National String,Denominator String,Score String,Lower_Estimate String,Higher_Estimate String,Footnote String,Measure_Start_Date String,Measure_End_Date String) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
"separatorChar" = ",", 
"quoteChar" = '"',
"escapeChar" = '\\' 
) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/readmissions';

 
DROP TABLE measures_raw;
CREATE EXTERNAL TABLE measures_raw (Measure_Name String,Measure_ID String,Measure_Start_Quarter String,Measure_Start_Date String,Measure_End_Quarter String,Measure_End_Date String) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
"separatorChar" = ",", 
"quoteChar" = '"',
"escapeChar" = '\\' 
) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/measures';


DROP TABLE effective_care_raw;
CREATE EXTERNAL TABLE effective_care_raw (provider_id String,hospital_name String,Address String,City String,State String,ZIP_Code String,County_Name String,Phone_Number String,Condition String,Measure_ID String,Measure_Name String,Score String,Sample String,Footnote String,Measure_Start_Date String,Measure_End_Date String) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
"separatorChar" = ",", 
"quoteChar" = '"',
"escapeChar" = '\\' 
) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/effective_care';

 
