--  Creating a Data-base
select * from la_crime_data;

# 🔍 LA Crime Data —  Analysis Queries

# Dataset: `la_crime_data` | Source: data.gov – Los Angeles Crime Reports  
# Tool: My | Connected to: Power BI Dashboard

---

## 📁 Table of Contents

# 1. [Database Setup](#1-database-setup)
# 2. [Time-Based Analysis](#2-time-based-analysis)
# 3. [Weapon Analysis](#3-weapon-analysis)
# 4. [Crime Frequency](#4-crime-frequency)
# 5. [Location & Area](#5-location--area)
# 6. [Victim Analysis](#6-victim-analysis)

---

## 1. Database Setup
create database if not exists db;
use db;

-- Verify current user
SELECT CURRENT_USER();

-- Preview all records
SELECT * FROM la_crime_data;


---

## 2. Time-Based Analysis

### 2.1 — Peak Crime Hour

# Objective: Identify the single hour with the highest crime occurrence.


SELECT CONCAT('Most crime occurs at ', MAX(time_occ), ':00 clock') AS Time_of_crime
FROM la_crime_data;


---

### 2.2 — Night vs Morning Crime Frequency

# Objective: Determine whether night-time crimes (9PM–3AM) are more frequent than morning crimes.


SELECT 
    time_period, 
    COUNT(time_period) AS freq 
FROM la_crime_data 
WHERE time_period = 'Night' 
   OR time_period = 'Morning'
GROUP BY time_period;


---

### 2.3 — Top 5 Crime Types at Night

# Objective: Identify dominant crime patterns during night hours to guide police resource planning.


SELECT 
    crm_cd_desc, 
    COUNT(crm_cd_desc) AS commonly_Crimes 
FROM la_crime_data 
WHERE time_period = 'Night'
GROUP BY crm_cd_desc
ORDER BY commonly_Crimes DESC
LIMIT 5;


---

### 2.4 — Areas with Peak Evening Crime

# Objective: Find which areas are most active during evening hours for targeted police deployment.


SELECT 
    area_name, 
    COUNT(crm_cd_desc) AS crimes_ 
FROM la_crime_data 
WHERE time_period = 'Evening'
GROUP BY area_name
ORDER BY crimes_ DESC;

# 💡 *'Central' was identified as the top area — consistent with Python statistical analysis findings.*

---

### 2.5 — Hourly Crime Distribution

# Objective: Break down crime count by each hour of the day using `time_occ`.


SELECT 
    (time_occ / 100) AS hour_of_day,
    COUNT(*) AS crime_count
FROM la_crime_data
GROUP BY hour_of_day
ORDER BY crime_count DESC;


---

### 2.6 — Crime Count by Time Period

# Objective: Summarize crimes across defined time periods (Morning, Afternoon, Evening, Night).


SELECT 
    time_period, 
    COUNT(*) AS crime_count
FROM la_crime_data
GROUP BY time_period
ORDER BY crime_count DESC;


---

### 2.7 — Monthly Crime Trend

# Objective: Track how crime volume changes month over month using `date_rptd`.


SELECT 
    YEAR(STR_TO_DATE(date_rptd, '%m/%d/%Y')) AS yr,
    MONTH(STR_TO_DATE(date_rptd, '%m/%d/%Y')) AS mo,
    COUNT(*) AS crime_count
FROM la_crime_data
GROUP BY yr, mo
ORDER BY yr, mo;


---

### 2.8 — Long Reporting Delays (date_occ vs date_rptd)

# Objective: Find crimes where reporting was delayed by more than 30 days — useful for identifying under-reported crimes.


SELECT 
    crm_cd_desc,
    date_occ,
    date_rptd,
    DATEDIFF(
        STR_TO_DATE(date_rptd, '%m/%d/%Y'),
        STR_TO_DATE(date_occ, '%m/%d/%Y')
    ) AS delay_days
FROM la_crime_data
WHERE DATEDIFF(
    STR_TO_DATE(date_rptd, '%m/%d/%Y'),
    STR_TO_DATE(date_occ, '%m/%d/%Y')
) # 30
ORDER BY delay_days DESC
LIMIT 20;


---

## 3. Weapon Analysis

### 3.1 — Crimes Involving Firearms (Weapon Codes 100–200)

# Objective: Identify crime types most associated with firearm use.  
# Insight: Gun violence units should prioritize ADW and Robbery cases.


SELECT 
    crm_cd_desc,
    COUNT(*) AS frequency
FROM la_crime_data
WHERE weapon_used_cd IS NOT NULL 
  AND weapon_used_cd BETWEEN 100 AND 200
GROUP BY crm_cd_desc
ORDER BY frequency DESC;


---

### 3.2 — Crimes Involving Other Weapons (Codes 200–600)

# Objective: Identify crime types linked to non-firearm weapons (knives, blunt objects, etc.).


SELECT 
    crm_cd_desc,
    COUNT(*) AS frequency
FROM la_crime_data
WHERE weapon_used_cd IS NOT NULL 
  AND weapon_used_cd BETWEEN 200 AND 600
GROUP BY crm_cd_desc
ORDER BY frequency DESC;


---

### 3.3 — Top 10 Weapons Used

# Objective: Rank the most commonly used weapons across all crimes.


SELECT 
    weapon_desc, 
    COUNT(*) AS count
FROM la_crime_data
WHERE weapon_desc IS NOT NULL
  AND weapon_desc != ''
GROUP BY weapon_desc
ORDER BY count DESC
LIMIT 10;


---

### 3.4 — Crime Types Most Likely to Involve Weapons

# Objective: Highlight which crime categories most frequently feature weapon use.


SELECT 
    crm_cd_desc,
    COUNT(*) AS with_weapon
FROM la_crime_data
WHERE weapon_used_cd IS NOT NULL
  AND weapon_used_cd # 0
GROUP BY crm_cd_desc
ORDER BY with_weapon DESC
LIMIT 10;


---

## 4. Crime Frequency

### 4.1 — Top 10 Most Frequent Crime Types

# Objective: Understand the overall crime landscape and which crimes dominate.


SELECT 
    crm_cd_desc, 
    COUNT(*) AS total
FROM la_crime_data
GROUP BY crm_cd_desc
ORDER BY total DESC
LIMIT 10;


---

### 4.2 — Crime Count by Area

# Objective: Rank all areas by total number of crimes reported.


SELECT 
    area_name, 
    COUNT(*) AS crime_count
FROM la_crime_data
GROUP BY area_name
ORDER BY crime_count DESC;


---

### 4.3 — All Unique Crime Types

# Objective: List every distinct crime description present in the dataset.


SELECT DISTINCT crm_cd_desc
FROM la_crime_data
ORDER BY crm_cd_desc;


---

### 4.4 — Case Status Breakdown (Solved vs Under Investigation)

# Objective: Measure what percentage of crimes are solved, open, or under investigation.


SELECT 
    status_desc,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM la_crime_data), 2) AS pct
FROM la_crime_data
GROUP BY status_desc
ORDER BY total DESC;


---

## 5. Location & Area

### 5.1 — Top Premises for Crime

# Objective: Find which location types (street, parking lot, residence, etc.) record the most crimes.


SELECT 
    premis_desc, 
    COUNT(*) AS total
FROM la_crime_data
GROUP BY premis_desc
ORDER BY total DESC
LIMIT 15;


---

### 5.2 — Top 5 Crime Hotspot Coordinates

# Objective: Identify geographic clusters by rounding lat/lon to 3 decimals.


SELECT 
    ROUND(lat, 3) AS latitude,
    ROUND(lon, 3) AS longitude,
    COUNT(*) AS crime_count
FROM la_crime_data
WHERE lat != 0 AND lon != 0
GROUP BY latitude, longitude
ORDER BY crime_count DESC
LIMIT 5;


---

### 5.3 — Highest Crime District per Area (Part 1 Crimes Only)

# Objective: Within each area, find the single reporting district with the most serious (Part 1) crimes using window functions.


WITH dist_counts AS (
    SELECT
        area_name,
        rpt_dist_no,
        COUNT(*) AS cnt,
        RANK() OVER (
            PARTITION BY area_name
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM la_crime_data
    WHERE `part_1-2` = 1
    GROUP BY area_name, rpt_dist_no
)
SELECT area_name, rpt_dist_no, cnt
FROM dist_counts
WHERE rnk = 1;


---

## 6. Victim Analysis

### 6.1 — Gender Breakdown of Victims

# Objective: Understand the male/female/unknown split to design targeted safety programs.


SELECT 
    vict_sex,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM la_crime_data), 2) AS pct
FROM la_crime_data
GROUP BY vict_sex
ORDER BY count DESC;


---

### 6.2 — Most Targeted Age Groups

# Objective: Identify which age brackets face the highest crime victimization.


SELECT 
    age_groups, 
    COUNT(*) AS total
FROM la_crime_data
GROUP BY age_groups
ORDER BY total DESC;


---

### 6.3 — Average Victim Age per Crime Type

# Objective: See which crimes tend to target older vs younger victims (only using validated ages).


SELECT 
    crm_cd_desc,
    ROUND(AVG(victim_valid_age), 1) AS avg_age,
    COUNT(*) AS total_crimes
FROM la_crime_data
WHERE vict_age_status = 'valid'
GROUP BY crm_cd_desc
HAVING total_crimes # 50
ORDER BY avg_age DESC;


---

### 6.4 — Most Victimized Descent Group per Area

# Objective: For each area, find which victim descent group appears most frequently using a window function.


WITH ranked AS (
    SELECT
        area_name,
        vict_descent,
        COUNT(*) AS cnt,
        ROW_NUMBER() OVER (
            PARTITION BY area_name
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM la_crime_data
    GROUP BY area_name, vict_descent
)
SELECT area_name, vict_descent, cnt
FROM ranked
WHERE rn = 1
ORDER BY cnt DESC;


# End 
