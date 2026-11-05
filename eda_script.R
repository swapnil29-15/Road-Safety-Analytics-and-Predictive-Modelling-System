
# ==========================================
# ROAD ACCIDENT ANALYSIS
# STEP 4: EXPLORATORY DATA ANALYSIS
# ==========================================

library(tidyverse)

# Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# Check dataset
glimpse(accidents)

# Total accident records
cat("Total accidents:", nrow(accidents), "\n")

# Total cities
cat("Total cities:", n_distinct(accidents$city), "\n")

# Total states
cat("Total states:", n_distinct(accidents$state), "\n")


# ==========================================
# GRAPH 1: ACCIDENTS BY CITY
# ==========================================

city_data <- accidents %>%
  count(city, sort = TRUE)

print(city_data)

ggplot(city_data,
       aes(x = reorder(city, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Road Accidents by City",
    x = "City",
    y = "Number of Accidents"
  ) +
  theme_minimal()


# ==========================================
# GRAPH 2: ACCIDENTS BY HOUR
# ==========================================

hour_data <- accidents %>%
  count(hour)

print(hour_data)

ggplot(hour_data,
       aes(x = hour, y = n)) +
  geom_line(color = "red", linewidth = 1) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Road Accidents by Hour",
    x = "Hour of Day",
    y = "Number of Accidents"
  ) +
  theme_minimal()


# ==========================================
# GRAPH 3: ACCIDENTS BY DAY OF WEEK
# ==========================================

day_data <- accidents %>%
  count(day_of_week)

print(day_data)

ggplot(day_data,
       aes(x = day_of_week, y = n)) +
  geom_col(fill = "darkorange") +
  labs(
    title = "Road Accidents by Day of Week",
    x = "Day",
    y = "Number of Accidents"
  ) +
  theme_minimal()


# ==========================================
# GRAPH 4: SEVERITY BY WEATHER
# ==========================================

weather_data <- accidents %>%
  count(weather, accident_severity)

print(weather_data)

ggplot(weather_data,
       aes(x = weather,
           y = n,
           fill = accident_severity)) +
  geom_col() +
  labs(
    title = "Accident Severity by Weather",
    x = "Weather",
    y = "Number of Accidents",
    fill = "Severity"
  ) +
  theme_minimal()


# ==========================================
# GRAPH 5: SEVERITY PERCENTAGE BY WEATHER
# ==========================================

weather_severity <- accidents %>%
  count(weather, accident_severity) %>%
  group_by(weather) %>%
  mutate(percentage = n / sum(n) * 100)

print(weather_severity)

ggplot(
  weather_severity,
  aes(
    x = weather,
    y = percentage,
    fill = accident_severity
  )
) +
  geom_col(position = "stack") +
  labs(
    title = "Accident Severity Distribution by Weather",
    x = "Weather Condition",
    y = "Percentage of Accidents",
    fill = "Severity"
  ) +
  theme_minimal()


# ==========================================
# GRAPH 6: ACCIDENT CAUSES BY SEVERITY
# ==========================================

cause_severity <- accidents %>%
  count(cause, accident_severity)

print(cause_severity)

ggplot(
  cause_severity,
  aes(
    x = cause,
    y = n,
    fill = accident_severity
  )
) +
  geom_col(position = "dodge") +
  labs(
    title = "Accident Causes by Severity",
    x = "Accident Cause",
    y = "Number of Accidents",
    fill = "Severity"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 30,
      hjust = 1
    )
  )


# ==========================================
# GRAPH 7: ROAD TYPE VS SEVERITY
# ==========================================

road_severity <- accidents %>%
  count(road_type, accident_severity)

print(road_severity)

ggplot(
  road_severity,
  aes(
    x = road_type,
    y = n,
    fill = accident_severity
  )
) +
  geom_col(position = "dodge") +
  labs(
    title = "Accident Severity Across Road Types",
    x = "Road Type",
    y = "Number of Accidents",
    fill = "Severity"
  ) +
  theme_minimal()







