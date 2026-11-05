
# ==========================================
# ROAD ACCIDENT ANALYSIS
# STEP 3: DATA CLEANING
# ==========================================

library(tidyverse)

# 1. Load original dataset
accidents <- read_csv(
  "data/raw/indian_roads_dataset.csv",
  show_col_types = FALSE
)

# 2. Check duplicate records
cat("Duplicate records:",
    sum(duplicated(accidents)), "\n")

# 3. Remove duplicate records if any
accidents_clean <- accidents %>%
  distinct()

# 4. Convert categorical variables into factors
accidents_clean <- accidents_clean %>%
  mutate(
    city = as.factor(city),
    state = as.factor(state),
    day_of_week = as.factor(day_of_week),
    road_type = as.factor(road_type),
    weather = as.factor(weather),
    visibility = as.factor(visibility),
    traffic_density = as.factor(traffic_density),
    cause = as.factor(cause),
    accident_severity = factor(
      accident_severity,
      levels = c("minor", "major", "fatal")
    ),
    festival = as.factor(festival)
  )

# 5. Validate numerical ranges
cat("\n--- NUMERICAL VALIDATION ---\n")

cat("Invalid hours:",
    sum(accidents_clean$hour < 0 |
          accidents_clean$hour > 23), "\n")

cat("Invalid lanes:",
    sum(accidents_clean$lanes < 1), "\n")

cat("Invalid vehicles:",
    sum(accidents_clean$vehicles_involved < 1), "\n")

cat("Negative casualties:",
    sum(accidents_clean$casualties < 0), "\n")

cat("Invalid risk scores:",
    sum(accidents_clean$risk_score < 0 |
          accidents_clean$risk_score > 1), "\n")

# 6. Check date range
cat("\n--- DATE RANGE ---\n")
print(range(accidents_clean$date))

# 7. Check cleaned structure
cat("\n--- CLEANED DATA STRUCTURE ---\n")
glimpse(accidents_clean)

# 8. Save cleaned dataset
write_csv(
  accidents_clean,
  "data/processed/cleaned_road_accidents.csv"
)

cat("\nCleaned dataset saved successfully!\n")

# 9. Final dimensions
cat("Final dimensions:",
    dim(accidents_clean), "\n")
