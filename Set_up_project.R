
# ==========================================
# ROAD SAFETY ANALYSIS PROJECT
# Project Initialization
# ==========================================

# Display project information
cat("====================================\n")
cat(" ROAD SAFETY ANALYSIS PROJECT\n")
cat("====================================\n")

# Check working directory
cat("Project Location:", getwd(), "\n")

# Create project folders
folders <- c(
  "data",
  "data/raw",
  "data/processed",
  "R",
  "models",
  "reports",
  "outputs",
  "outputs/figures",
  "outputs/maps",
  "www"
)

# Create folders automatically
for (folder in folders) {
  if (!dir.exists(folder)) {
    dir.create(folder, recursive = TRUE)
  }
}

cat("\nProject folders created successfully!\n")

# Check R version
cat("\nR Version:", R.version.string, "\n")

cat("\nProject initialization completed!\n")


# Load installed packages
library(tidyverse)
library(shiny)
library(plotly)
library(DT)
library(rmarkdown)

cat("All initial packages loaded successfully!\n")

# Display R version
print(R.version.string)

# Display project working directory
print(getwd())

