
# ==========================================
# ROAD ACCIDENT ANALYSIS
# STEP 5.4: ACCIDENT DENSITY HEATMAP
# ==========================================

library(tidyverse)
library(leaflet)
library(leaflet.extras)

# 1. Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 2. Check coordinates
cat("Total accident locations:",
    nrow(accidents), "\n")

# 3. Remove records with invalid coordinates
accident_locations <- accidents %>%
  filter(
    !is.na(latitude),
    !is.na(longitude),
    latitude >= 6,
    latitude <= 38,
    longitude >= 68,
    longitude <= 98
  )

cat("Valid India-range coordinates:",
    nrow(accident_locations), "\n")

# 4. Create interactive heatmap
heatmap <- leaflet(accident_locations) %>%
  addTiles() %>%
  addHeatmap(
    lng = ~longitude,
    lat = ~latitude,
    intensity = 1,
    blur = 20,
    radius = 15
  ) %>%
  addLegend(
    position = "bottomright",
    colors = c("blue", "yellow", "red"),
    labels = c("Lower concentration",
               "Medium concentration",
               "Higher concentration"),
    title = "Accident Density"
  )

# 5. Display heatmap
heatmap


install.packages("leaflet.extras", dependencies = TRUE)

library(leaflet.extras)
install.packages("dbscan")