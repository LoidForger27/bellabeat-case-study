# Bellabeat Case Study: Smart Device Usage Data

![Banner](visuals/steps_histogram.png)  
*Example banner – replace with any cover image you like*

---

## 📖 Project Overview
This case study is part of the **Google Data Analytics Capstone**.  
The goal was to analyze smart device usage data (Fitbit dataset from Kaggle) to identify consumer trends and provide high-level recommendations for Bellabeat’s marketing strategy.

**Main steps followed:**
1. Ask – Define the business questions.  
2. Prepare – Import and clean the Fitbit data.  
3. Process – Transform and organize datasets.  
4. Analyze – Perform exploratory analysis, identify trends.  
5. Share – Create visualizations and insights.  
6. Act – Summarize high-level recommendations for stakeholders.  

---

## 📂 Repository Structure

bellabeat-case-study/
├─ data/
│ ├─ raw/ # not stored here, see Kaggle link
│ └─ clean/ # daily_joined.csv and other small outputs
├─ scripts/
│ ├─ 01_cleaning.R
│ ├─ 02_analysis.R
│ └─ 03_visualizations.R
├─ visuals/
│ ├─ steps_histogram.png
│ ├─ sleep_histogram.png
│ ├─ steps_vs_calories.png
│ └─ sleep_vs_steps.png
└─ README.md


---

## 📊 Visual Highlights

- **Steps Histogram** – Daily step counts distribution compared to recommended activity levels  
- **Sleep Histogram** – Minutes asleep vs time in bed (sleep quality trends)  
- **Steps vs Calories** – Positive correlation between daily steps and calories burned  
- **Sleep vs Steps** – Exploring relationship between physical activity and sleep duration  

---

## 🔗 Kaggle Notebook
The full analysis, code, and interactive visuals are available here:  
👉 [View on Kaggle](https://www.kaggle.com/) *(insert your Kaggle notebook link here)*

---

## ✅ Key Findings & Recommendations
- Most users did not consistently meet the **10,000 daily steps** activity goal.  
- Users who were more active tended to burn significantly more calories.  
- Sleep data showed **inconsistencies and short durations**, highlighting an opportunity for Bellabeat to provide better sleep insights.  
- **High-level recommendation:** Bellabeat can focus marketing on **wellness insights (activity + sleep balance)**, positioning its app as a lifestyle coach for women aiming to improve daily habits.  

---

## 📌 How to Reproduce
1. Clone this repo:  
   ```bash
   git clone https://github.com/yourusername/bellabeat-case-study.git
2. Open R or RStudio
3. Run scripts in the scripts/ folder in order.
4. Cleaned data will be stored in data/clean/ and visuals in visuals/.


🙌 Acknowledgments

Dataset: Fitbit Fitness Tracker Data on Kaggle

Google Data Analytics Professional Certificate (Capstone Project)


