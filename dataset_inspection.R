
library(tidyverse)

# Load dataset
accidents <- read_csv("data/raw/indian_roads_dataset.csv")

# Check successful loading
print("Dataset loaded successfully")

# Dataset dimensions
print(dim(accidents))

# Column names
print(names(accidents))

# Dataset structure
str(accidents)

# First 6 records
print(head(accidents))
