--  Creating a Data-base
create database if not exists db;
use db;


SELECT CURRENT_USER();

select * from la_crime_data;

SELECT CONCAT('Most crime occurs at ', MAX(time_occ),':00 clock') as Time_of_crime
FROM la_crime_data;

-- Are night-time crimes (9PM–3AM) more frequent than daytime crimes?
select time_period, count(time_period) as freq from la_crime_data where time_period='Night' or time_period='Morning'
group by time_period;

-- Which crime types are most common at night?
select crm_cd_desc, count(crm_cd_desc) as commonly_Crimes from la_crime_data where time_period='Night'
group by crm_cd_desc
order by commonly_Crimes desc
limit 5;
# Helps police understand dominant crime patterns during night

-- Which areas experience peak crime during evening hours?
select area_name, count(crm_cd_desc) as crimes_ from la_crime_data where 
time_period='Evening'
group by area_name
 order by crimes_ desc; 
-- this result as 'Central' was already seen in python df during statistical anlysis
# this will help in Resources allocation for police deployment

-- Which victim age group is most affected by crime?  
select age_groups, count(crm_cd_desc) as crimes_ from la_crime_data 
group by age_groups
order by crimes_ desc ;

#  Targeted safety programs for vulnerable groups

-- Are certain crime types more likely to involve weapons?
-- Break down by specific weapon types for each crime
SELECT 
    crm_cd_desc,
    COUNT(*) as frequency
FROM la_crime_data
WHERE weapon_used_cd IS NOT NULL and weapon_used_cd between 100 and 200 
GROUP BY crm_cd_desc
ORDER BY  frequency DESC;

#    Resource Allocation: Gun violence units should prioritize ADW and Robbery
  --   Domestic Violence: 1,181 cases with guns - need protective orders, gun confiscation
--     Homicide Prevention: Focus on areas with high ADW and shots fired
--     Training: Officers responding to "simple assault" calls rarely face guns
--     
SELECT 
    crm_cd_desc,
    COUNT(*) as frequency
FROM la_crime_data
WHERE weapon_used_cd IS NOT NULL and weapon_used_cd between 200 and 600 
GROUP BY crm_cd_desc
ORDER BY  frequency DESC;

# Policy response needs to address multiple weapon types, not just guns or knives
-- Officer safety - "Simple assault" calls may involve various weapons (blunt objects, chemical sprays, etc.)
-- Prevention programs could target carrying of ANY weapons, not just firearms


SELECT weapon_used_cd, COUNT(*) AS occurrences FROM la_crime_data GROUP BY weapon_used_cd;
# here 500s series are body parts as weapons


-- ALTER USER 'root'@'localhost' 
-- IDENTIFIED WITH mysql_native_password 
-- BY 'root';

FLUSH PRIVILEGES;
