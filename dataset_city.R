
# ==========================================
# STEP 5.9: CITY COORDINATE VALIDATION
# ==========================================

library(tidyverse)

# Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 1. City and state combinations
cat("\n--- CITY AND STATE COMBINATIONS ---\n")

city_state <- accidents %>%
  count(city, state, sort = TRUE)

print(city_state, n = Inf)

# 2. Coordinate ranges for each city
cat("\n--- COORDINATE RANGES BY CITY ---\n")

city_ranges <- accidents %>%
  group_by(city, state) %>%
  summarise(
    records = n(),
    min_latitude = min(latitude),
    max_latitude = max(latitude),
    min_longitude = min(longitude),
    max_longitude = max(longitude),
    mean_latitude = mean(latitude),
    mean_longitude = mean(longitude),
    .groups = "drop"
  )

print(city_ranges, n = Inf, digits = 7)

# 3. Number of unique coordinate pairs
cat("\n--- UNIQUE COORDINATE PAIRS ---\n")

print(
  n_distinct(
    paste(
      accidents$latitude,
      accidents$longitude,
      sep = "_"
    )
  )
)

# 4. City coordinate distribution
ggplot(
  accidents,
  aes(
    x = longitude,
    y = latitude,
    color = city
  )
) +
  geom_point(alpha = 0.5, size = 0.8) +
  labs(
    title = "Geographical Distribution of Accident Records",
    x = "Longitude",
    y = "Latitude",
    color = "City"
  ) +
  theme_minimal()
