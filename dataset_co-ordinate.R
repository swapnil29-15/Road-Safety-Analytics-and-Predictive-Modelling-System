
# ==========================================
# STEP 5.8: COORDINATE INVESTIGATION
# ==========================================

library(tidyverse)

# Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 1. Count unique coordinate pairs
cat("\n--- UNIQUE COORDINATE PAIRS ---\n")

unique_coordinates <- accidents %>%
  distinct(latitude, longitude)

print(nrow(unique_coordinates))

# 2. Check repeated coordinates
cat("\n--- TOP 15 REPEATED LOCATIONS ---\n")

location_counts <- accidents %>%
  count(latitude, longitude, city, state,
        sort = TRUE)

print(head(location_counts, 15))

# 3. Count locations by city
cat("\n--- UNIQUE LOCATIONS BY CITY ---\n")

city_coordinates <- accidents %>%
  group_by(city) %>%
  summarise(
    total_records = n(),
    unique_locations = n_distinct(
      paste(latitude, longitude)
    ),
    .groups = "drop"
  )

print(city_coordinates)

# 4. Check coordinate variation
cat("\n--- COORDINATE VARIATION ---\n")

print(summary(accidents$latitude))
print(summary(accidents$longitude))
