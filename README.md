# 🚔 Los Angeles Crime Intelligence Dashboard | Power BI

## Overview
An end-to-end data analytics project analyzing crime patterns in Los Angeles (2020–2026) using **MySQL, Python, and Power BI**.  
The dashboard identifies high-risk areas, temporal crime trends, and behavioral patterns to support data-driven decision making.

---

## Objective
To uncover actionable crime insights across geography, time, and demographics — enabling better resource allocation and policy planning.

---

## Dataset
- Source: Data.gov (Los Angeles Crime Data)
- Time Range: 2020 – 2026 *(latest data partially incomplete)*
- Records: ~1 Million+
- Data includes:
  - Crime type
  - Location (area)
  - Time of occurrence
  - Weapon used
  - Victim demographics

---

## 🛠️ Tech Stack
- **SQL (MySQL):** Data extraction, filtering, and structured querying  
- **Python:** Data cleaning, preprocessing, EDA  
- **Power BI:** Dashboard creation, DAX measures, interactive visualizations  

---

## ⚙️ Key Features
- Multi-page dashboard with navigation (5 pages)
- Azure Maps integration for crime hotspot visualization
- Dynamic KPIs using DAX:
  - Avg Report Delay: **12.18 days**
  - Night Crime %: **27.72%**
  - Arrest Rate: **9%**
- Drilldowns and filters for:
  - Area
  - Time
  - Crime type
- Time-series trend analysis (2020–2026)

---

## 📊 Dashboard Preview (Live Demo)

![Dashboard Demo](dashboard.gif)

---

## 🔍 Key Insights

- **Central district dominates crime volume**  
  → 69,670+ crimes, significantly higher than other regions  

- **Peak crime window: 6 PM – 10 PM**  
  → Crime is activity-driven (post work/school), not late-night dominated  

- **Strong-arm (physical force) is the primary weapon**  
  → Indicates interpersonal crime rather than organized armed crime  

- **Streets and residential areas are main crime locations**  
  → Suggests need for localized surveillance and patrol  

- **Night crimes show higher weapon usage (35.54%)**  
  → Risk intensity increases after dark  

- **Adults (36–61) are the most affected group (50.38%)**  
  → Crime is concentrated around working-age population  

---

## Data Observations (Critical Thinking)

- Apparent drop in report delay (19 → 2 days) can likely be a **data artifact**, not actual improvement but here it is actual 
- But sometimes recent years (2025–2026) may be **incomplete**, affecting trend reliability  

---

## Business / Policy Recommendations

- Shift patrol focus to **evening hours (6–10 PM)** instead of late night  
- Increase **street-level monitoring** in Central, 77th Street, Southwest  
- Invest in **conflict de-escalation programs** over weapon-focused interventions  
- Launch **targeted programs for high-risk age groups and areas**  

---

## How to Use

1. Clone the repository
2. Open `.pbix` file in Power BI Desktop
3. Explore using filters and page navigation

---


---

## Key Learning

This project highlights that:
- Data visualization ≠ insights  
- Real value comes from **interpreting patterns and questioning data reliability**

---

## Author
Kartik Dhoke
