# Install if not already installed
install.packages("dplyr")
install.packages("tidyr")
install.packages("stringr")

# Load libraries
library(dplyr)
library(tidyr)
library(stringr)

install.packages("tidyverse")  # For data manipulation and visualization

library(tidyverse)

# Load your CSV file (adjust the path if needed)
data <- read_csv("ACSST5Y2023_S1902_Data.csv")

# View the first few rows and columns to understand the structure
head(data)

# Extract only the required columns and modify GEO_ID to keep only the last 5 digits
filtered_data <- data %>%
  select(GEO_ID, S1902_C03_001E, S1902_C01_001E) %>%
  mutate(GEO_ID = str_sub(GEO_ID, -5))


# View the filtered data
View(filtered_data)

distinct_zip_metro <- Zillow_Data %>%
  distinct(zip_code, Metro)

# View the result
View(distinct_zip_metro)

# Extract only the required columns and modify GEO_ID to keep only the last 5 digits
filtered_data <- data %>%
  select(GEO_ID, S1902_C03_001E, S1902_C01_001E) %>%
  mutate(GEO_ID = str_sub(GEO_ID, -5))

# Convert GEO_ID to numeric for consistency
filtered_data <- filtered_data %>%
  mutate(GEO_ID = as.numeric(GEO_ID))

# Select distinct zip_code and Metro from Zillow_Data
distinct_zip_metro <- Zillow_Data %>%
  distinct(zip_code, Metro)

# Check if GEO_ID matches zip_code in distinct_zip_metro
matched_data <- filtered_data %>%
  inner_join(distinct_zip_metro, by = c("GEO_ID" = "zip_code"))

# Clean matched_data by removing NA values and duplicates
cleaned_matched_data <- matched_data %>%
  drop_na() %>%
  distinct()

# View the cleaned data
View(cleaned_matched_data)

# Convert S1902_C03_001E and S1902_C01_001E to numeric, coercing non-numeric values to NA
filtered_data <- filtered_data %>%
  mutate(
    postal_income = as.numeric(S1902_C03_001E),
    num_households = as.numeric(S1902_C01_001E)
  )

# Select distinct zip_code and Metro from Zillow_Data
distinct_zip_metro <- Zillow_Data %>%
  distinct(zip_code, Metro)

# Check if GEO_ID matches zip_code in distinct_zip_metro
matched_data <- filtered_data %>%
  inner_join(distinct_zip_metro, by = c("GEO_ID" = "zip_code"))

# Clean matched_data by removing NA values and duplicates
cleaned_matched_data <- matched_data %>%
  drop_na() %>%
  distinct()

# Remove Metro names that don't have a state abbreviation after the comma
cleaned_matched_data <- cleaned_matched_data %>%
  filter(str_detect(Metro, ", [A-Z]{2}$"))

cleaned_matched_data <- cleaned_matched_data %>%
  select(-S1902_C01_001E, -S1902_C03_001E)

# Create a new column metro_income as postal_income * num_households
cleaned_matched_data <- cleaned_matched_data %>%
  mutate(metro_income = postal_income * num_households)

# Update metro_income with the sum of all metro_income per Metro area
cleaned_matched_data <- cleaned_matched_data %>%
  group_by(Metro) %>%
  mutate(metro_income = sum(metro_income, na.rm = TRUE)) %>%
  ungroup()

# Create a new column sum_households with the total number of households per Metro area
cleaned_matched_data <- cleaned_matched_data %>%
  group_by(Metro) %>%
  mutate(sum_households = sum(num_households, na.rm = TRUE)) %>%
  ungroup()

# Create a new column denominator as metro_income / sum_households
cleaned_matched_data <- cleaned_matched_data %>%
  mutate(denominator = metro_income / sum_households)

# Create a new column ratio as postal_income / denominator
cleaned_matched_data <- cleaned_matched_data %>%
  mutate(ratio = postal_income / denominator)

# View the cleaned data
View(cleaned_matched_data)

# Save the cleaned data to a CSV file
write_csv(cleaned_matched_data, "Cleaned_ACSST5Y2023_S1902_Data.csv")
