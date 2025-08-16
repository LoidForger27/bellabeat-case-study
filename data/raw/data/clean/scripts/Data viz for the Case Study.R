library(ggplot2)

## Average Daily Steps vs Goal

avg_steps <- mean(daily$total_steps, na.rm = TRUE)

ggplot(daily, aes(x = total_steps)) +
  geom_histogram(binwidth = 1000, fill = "#69b3a2", color = "white") +
  geom_vline(xintercept = 10000, linetype = "dashed", color = "red", size = 1) +
  labs(
    title = "Distribution of Daily Steps",
    subtitle = paste("Average steps per day:", round(avg_steps)),
    x = "Number of Days",
    y = "Total Steps"
  ) +
  theme_minimal()

# Story: Most days fall below the 10,000-step health benchmark.

## Average Sleep Duration

avg_sleep <- mean(daily$total_minutes_asleep, na.rm = TRUE) / 60

ggplot(daily, aes(x = total_minutes_asleep / 60)) +
  geom_histogram(binwidth = 0.5, fill = "#4c72b0", color = "white") +
  geom_vline(xintercept = 8, linetype = "dashed", color = "red", size = 1) +
  labs(
    title = "Distribution of Sleep Duration",
    subtitle = paste("Average sleep per night:", round(avg_sleep, 1), "hours"),
    x = "Hours of Sleep",
    y = "Number of Days"
  ) +
  theme_minimal()

# Story: Most users sleep less than the recommended 7–9 hours.

## Steps vs Calories

ggplot(daily, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.6, color = "#ff9933") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "Relationship Between Steps and Calories Burned",
    x = "Total Steps",
    y = "Calories Burned"
  ) +
  theme_minimal()

# Story: Strong positive relationship — more steps lead to higher calorie burn.

## Sleep vs Steps

ggplot(daily, aes(x = total_minutes_asleep / 60, y = total_steps)) +
  geom_point(alpha = 0.6, color = "#9933ff") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "Relationship Between Sleep Duration and Steps",
    x = "Hours of Sleep",
    y = "Total Steps"
  ) +
  theme_minimal()

# Story: Weak or no strong relationship — being more active doesn’t necessarily mean sleeping more.


