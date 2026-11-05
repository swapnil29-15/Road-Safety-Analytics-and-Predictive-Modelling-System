
# ==========================================
# STEP 5.10: CORRECTED GEOGRAPHICAL CLUSTERING
# ==========================================

library(tidyverse)
library(sf)
library(dbscan)

# 1. Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 2. Convert accident records into spatial points
accident_sf <- st_as_sf(
  accidents,
  coords = c("longitude", "latitude"),
  crs = 4326,
  remove = FALSE
)

# 3. Function to perform HDBSCAN separately by city
cluster_city <- function(data) {
  
  # Determine appropriate UTM zone from city longitude
  center_lon <- mean(data$longitude)
  
  utm_zone <- floor((center_lon + 180) / 6) + 1
  
  epsg_code <- 32600 + utm_zone
  
  # Transform coordinates into metres
  city_sf <- st_transform(data, crs = epsg_code)
  
  # Extract projected X and Y coordinates
  xy <- st_coordinates(city_sf)
  
  # Run HDBSCAN
  result <- dbscan::hdbscan(
    xy,
    minPts = 20
  )
  
  # Attach cluster labels
  city_sf$cluster_id <- result$cluster
  
  return(st_drop_geometry(city_sf))
}

# 4. Perform clustering for every city
clustered_accidents <- accidents %>%
  group_split(city) %>%
  map_dfr(cluster_city)

# 5. Create readable cluster labels
clustered_accidents <- clustered_accidents %>%
  mutate(
    cluster_label = if_else(
      cluster_id == 0,
      "Noise",
      paste(city, "Cluster", cluster_id)
    )
  )

# 6. Cluster summary
cluster_summary <- clustered_accidents %>%
  filter(cluster_id != 0) %>%
  group_by(city, cluster_id) %>%
  summarise(
    total_accidents = n(),
    fatal_accidents = sum(
      accident_severity == "fatal"
    ),
    major_accidents = sum(
      accident_severity == "major"
    ),
    minor_accidents = sum(
      accident_severity == "minor"
    ),
    center_latitude = mean(latitude),
    center_longitude = mean(longitude),
    .groups = "drop"
  ) %>%
  arrange(desc(total_accidents))

# 7. Display cluster results
cat("\n--- CLUSTER SUMMARY ---\n")
print(cluster_summary, n = 30)

# 8. Count clusters and noise
cat("\n--- CLUSTER COUNTS BY CITY ---\n")

print(
  clustered_accidents %>%
    group_by(city) %>%
    summarise(
      total_records = n(),
      detected_clusters = n_distinct(
        cluster_id[cluster_id != 0]
      ),
      noise_records = sum(cluster_id == 0),
      .groups = "drop"
    )
)

# 9. Visualize clusters
ggplot(
  clustered_accidents,
  aes(
    x = longitude,
    y = latitude,
    color = cluster_label
  )
) +
  geom_point(alpha = 0.6, size = 1) +
  labs(
    title = "Corrected Geographical Accident Clusters",
    subtitle = "HDBSCAN clustering performed separately by city",
    x = "Longitude",
    y = "Latitude",
    color = "Cluster"
  ) +
  theme_minimal()

# 10. Save results
write_csv(
  clustered_accidents,
  "data/processed/clustered_accidents.csv"
)

write_csv(
  cluster_summary,
  "data/processed/hotspot_summary.csv"
)

cat("\nClustering completed successfully!\n")
