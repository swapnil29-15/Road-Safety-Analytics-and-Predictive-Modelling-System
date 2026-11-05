
# ==========================================
# ROAD ACCIDENT ANALYSIS
# STEP 3: DATA QUALITY VALIDATION
# ==========================================

library(tidyverse)

# Load dataset
accidents <- read_csv(
  "data/raw/indian_roads_dataset.csv"
)

# 1. Check duplicate accident IDs
cat("\n--- DUPLICATE ACCIDENT IDs ---\n")
print(sum(duplicated(accidents$accident_id)))

# 2. Check duplicate complete records
cat("\n--- DUPLICATE RECORDS ---\n")
print(sum(duplicated(accidents)))

# 3. Check data types
cat("\n--- DATA TYPES ---\n")
glimpse(accidents)

# 4. Check accident severity categories
cat("\n--- ACCIDENT SEVERITY ---\n")
print(table(accidents$accident_severity))

# 5. Check weather categories
cat("\n--- WEATHER CATEGORIES ---\n")
print(table(accidents$weather))

# 6. Check road types
cat("\n--- ROAD TYPES ---\n")
print(table(accidents$road_type))

# 7. Check accident causes
cat("\n--- ACCIDENT CAUSES ---\n")
print(table(accidents$cause))

# 8. Validate geographical coordinates
cat("\n--- INVALID LATITUDE ---\n")
print(sum(accidents$latitude < -90 |
            accidents$latitude > 90))

cat("\n--- INVALID LONGITUDE ---\n")
print(sum(accidents$longitude < -180 |
            accidents$longitude > 180))

# 9. Check numerical variable ranges
cat("\n--- NUMERICAL SUMMARY ---\n")
print(
  summary(
    select(
      accidents,
      hour, lanes, visibility, temperature,
      traffic_density, vehicles_involved,
      casualties, risk_score
    )
  )
)

# 10. Check unique cities and states
cat("\n--- UNIQUE CITIES ---\n")
print(n_distinct(accidents$city))

cat("\n--- UNIQUE STATES ---\n")
print(n_distinct(accidents$state))
