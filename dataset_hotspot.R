
install.packages("leaflet")
install.packages("sf")
install.packages("htmlwidgets")


# ==========================================
# ROAD ACCIDENT ANALYSIS
# STEP 5: GEOGRAPHICAL HOTSPOT DETECTION
# ==========================================

library(tidyverse)
library(leaflet)
library(sf)

# 1. Load cleaned dataset
accidents <- read_csv(
  "data/processed/cleaned_road_accidents.csv",
  show_col_types = FALSE
)

# 2. Check geographical coordinates
summary(accidents$latitude)
summary(accidents$longitude)

# 3. Create geographical data
accident_map <- st_as_sf(
  accidents,
  coords = c("longitude", "latitude"),
  crs = 4326
)

# 4. Display geographical information
print(accident_map)

# 5. Create interactive accident map
accident_leaflet <- leaflet(accidents) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = 3,
    stroke = FALSE,
    fillOpacity = 0.6,
    popup = ~paste(
      "<b>City:</b>", city,
      "<br><b>State:</b>", state,
      "<br><b>Severity:</b>", accident_severity,
      "<br><b>Cause:</b>", cause
    )
  )

# 6. Display map
accident_leaflet

install.packages("sf", dependencies = TRUE)

options(timeout = 600)

install.packages(
  "sf",
  repos = "https://cloud.r-project.org",
  dependencies = c("Depends", "Imports", "LinkingTo")
)