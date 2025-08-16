## Organize & Aggregate the Data
#Since the business task is high-level trends, we’ll focus on daily-level data only.

daily_data <- activity %>%
  left_join(sleep, by = c("id", "activity_date" = "sleep_date"))

## Perform Calculations
# We can create some quick summary metrics

summary_stats <- daily_data %>%
  summarise(
    avg_steps = mean(total_steps, na.rm = TRUE),
    avg_minutes_asleep = mean(total_minutes_asleep, na.rm = TRUE),
    avg_time_in_bed = mean(total_time_in_bed, na.rm = TRUE),
    avg_sleep_efficiency = mean(total_minutes_asleep / total_time_in_bed * 100, na.rm = TRUE)
  )

