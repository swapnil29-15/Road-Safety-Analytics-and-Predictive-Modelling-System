
# ==========================================
# ROAD SAFETY ANALYSIS PROJECT
# STEP 2.3: DATASET UNDERSTANDING
# ==========================================

library(tidyverse)

# Load dataset
accidents <- read_csv(
  "data/raw/indian_roads_dataset.csv"
)

# 1. Dataset dimensions
cat("\n--- DATASET DIMENSIONS ---\n")
print(dim(accidents))

# 2. Total records
cat("\n--- TOTAL ACCIDENT RECORDS ---\n")
print(nrow(accidents))

# 3. Total columns
cat("\n--- TOTAL COLUMNS ---\n")
print(ncol(accidents))

# 4. Column names
cat("\n--- COLUMN NAMES ---\n")
print(names(accidents))

# 5. Data structure
cat("\n--- DATA STRUCTURE ---\n")
str(accidents)

# 6. First 10 records
cat("\n--- FIRST 10 RECORDS ---\n")
print(head(accidents, 10))

# 7. Missing values in each column
cat("\n--- MISSING VALUES ---\n")
print(colSums(is.na(accidents)))

# 8. Duplicate records
cat("\n--- DUPLICATE RECORDS ---\n")
print(sum(duplicated(accidents)))
