## ===== Setup =====
#install.packages(c("tidyverse","lubridate","janitor"))  # run once if needed

library(tidyverse)
library(lubridate)
library(janitor)

# ===== 1) Load raw CSVs =====

sleep_raw    <- read_csv("sleepDay_merged.csv")
weight_raw   <- read_csv("weightLogInfo_merged.csv")
hr_raw       <- read_csv("heartrate_seconds_merged.csv")
activity_raw <- read_csv("dailyActivity_merged.csv")

# ===== 2) Clean and type cast =====
## Sleep
sleep <- sleep_raw %>%
  clean_names() %>%                                        # id, sleep_day, total_sleep_records, total_minutes_asleep, total_time_in_bed
  mutate(
    id = as.numeric(as.character(id)),
    sleep_datetime = mdy_hms(sleep_day, quiet = TRUE),
    sleep_date = as_date(sleep_datetime),
    total_sleep_records = as.integer(as.character(total_sleep_records)),
    total_minutes_asleep = as.integer(as.character(total_minutes_asleep)),
    total_time_in_bed = as.integer(as.character(total_time_in_bed))
  ) %>%
  arrange(id, sleep_datetime) %>%
  distinct(id, sleep_date, .keep_all = TRUE)               # one record per user per day

## Weight
weight <- weight_raw %>%
  clean_names() %>%                                        # id, date, weight_kg, weight_pounds, fat, bmi, is_manual_report, log_id
  mutate(
    id = as.numeric(as.character(id)),
    weight_datetime = mdy_hms(date, quiet = TRUE),
    weight_date = as_date(weight_datetime),
    weight_kg = as.numeric(as.character(weight_kg)),
    weight_pounds = as.numeric(as.character(weight_pounds)),
    fat = as.integer(as.character(fat)),
    bmi = as.numeric(as.character(bmi)),
    is_manual_report = case_when(
      tolower(is_manual_report) %in% c("true","t","1","yes","y")  ~ TRUE,
      tolower(is_manual_report) %in% c("false","f","0","no","n") ~ FALSE,
      TRUE ~ NA
    )
  ) %>%
  arrange(id, weight_datetime) %>%
  distinct(log_id, .keep_all = TRUE)                       # keep unique logs

## Heart rate seconds
hr <- hr_raw %>%
  clean_names() %>%                                        # id, time, value
  mutate(
    id = as.numeric(as.character(id)),
    heart_datetime = mdy_hms(time, quiet = TRUE),
    heart_date = as_date(heart_datetime),
    bpm = as.integer(as.character(value))
  ) %>%
  filter(!is.na(heart_datetime), !is.na(bpm)) %>%
  arrange(id, heart_datetime) %>%
  distinct(id, heart_datetime, .keep_all = TRUE)           # one per second

## Daily activity
activity <- activity_raw %>%
  clean_names() %>%                                        # id, activity_date, total_steps, calories, etc
  mutate(
    id = as.numeric(as.character(id)),
    activity_date = mdy(activity_date, quiet = TRUE),
    total_steps = as.numeric(as.character(total_steps)),
    total_distance = as.numeric(as.character(total_distance)),
    calories = as.numeric(as.character(calories))
  ) %>%
  arrange(id, activity_date) %>%
  distinct(id, activity_date, .keep_all = TRUE)            # one row per day

# ===== 3) Quick validation checks =====
nrow(sleep);    range(sleep$sleep_date,    na.rm = TRUE)
nrow(weight);   range(weight$weight_date,  na.rm = TRUE)
nrow(hr);       range(hr$heart_date,       na.rm = TRUE)
nrow(activity); range(activity$activity_date, na.rm = TRUE)

# check duplicates by keys
sleep %>% count(id, sleep_date) %>% filter(n > 1)
weight %>% count(log_id) %>% filter(n > 1)
hr %>% count(id, heart_datetime) %>% filter(n > 1)
activity %>% count(id, activity_date) %>% filter(n > 1)

# quick sanity on important columns
summary(select(sleep, total_minutes_asleep, total_time_in_bed))
summary(select(weight, weight_kg, bmi))
summary(hr$bpm)
summary(select(activity, total_steps, calories))

# ===== 4) Simple daily join for analysis =====
# daily heart rate summary per user per day
hr_daily <- hr %>%
  group_by(id, heart_date) %>%
  summarise(
    bpm_mean = mean(bpm, na.rm = TRUE),
    readings = n(),
    .groups = "drop"
  ) %>%
  rename(activity_date = heart_date)

# weight latest value per day
weight_daily <- weight %>%
  group_by(id, weight_date) %>%
  summarise(
    weight_kg = last(na.omit(weight_kg)),
    bmi = last(na.omit(bmi)),
    .groups = "drop"
  ) %>%
  rename(activity_date = weight_date)

# master daily table
daily <- activity %>%
  left_join(sleep %>% select(id, sleep_date, total_minutes_asleep, total_time_in_bed),
            by = c("id" = "id", "activity_date" = "sleep_date")) %>%
  left_join(hr_daily, by = c("id","activity_date")) %>%
  left_join(weight_daily, by = c("id","activity_date"))

glimpse(daily)

# ===== 5) Save clean outputs =====
write_csv(sleep,"sleep_clean.csv")
write_csv(weight,"weight_clean.csv")
write_csv(hr,"heartrate_seconds_clean.csv")
write_csv(activity,"daily_activity_clean.csv")
write_csv(daily,"daily_joined.csv")
