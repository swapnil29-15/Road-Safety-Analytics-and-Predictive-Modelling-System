
# ==========================================
# STEP 5.7: DBSCAN HOTSPOT DETECTION
# ==========================================

library(tidyverse)
library(dbscan)
library(ggplot2)

# 1. Load cleaned data
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 2. Keep valid coordinates
accident_locations <- accidents %>%
  filter(
    between(latitude, 6, 38),
    between(longitude, 68, 98)
  )

# 3. Convert coordinates to radians
coordinates <- as.matrix(
  accident_locations %>%
    select(latitude, longitude)
)

coordinates_rad <- coordinates * pi / 180

# 4. Run DBSCAN using haversine distance
# eps = 0.01 radians, approximately 64 km
dbscan_result <- dbscan::hdbscan(
  coordinates_rad,
  minPts = 20
)

# 5. Add cluster labels
accident_locations$cluster <- factor(
  ifelse(
    dbscan_result$cluster == 0,
    "Noise",
    paste0("Cluster ", dbscan_result$cluster)
  )
)

# 6. Display cluster summary
cat("\n--- CLUSTER SUMMARY ---\n")
print(table(accident_locations$cluster))

# 7. Visualize clusters
ggplot(
  accident_locations,
  aes(
    x = longitude,
    y = latitude,
    color = cluster
  )
) +
  geom_point(alpha = 0.5, size = 1) +
  labs(
    title = "Geographical Road Accident Clusters",
    x = "Longitude",
    y = "Latitude",
    color = "Cluster"
  ) +
  theme_minimal()
