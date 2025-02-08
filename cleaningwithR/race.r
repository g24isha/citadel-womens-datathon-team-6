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
data <- read_csv("2013_postal_data.csv")

# View the first few rows and columns to understand the structure
head(data)

# Extract only the required columns and modify GEO_ID to keep only the last 5 digits
filtered_data <- data %>%
  select(GEO_ID, S1902_C02_001E, S1902_C01_001E) %>%
  mutate(GEO_ID = str_sub(GEO_ID, -5))


# View the filtered data
View(filtered_data)

distinct_zip_metro <- Zillow_Data %>%
  distinct(zip_code, Metro)

# View the result
View(distinct_zip_metro)

# Extract only the required columns and modify GEO_ID to keep only the last 5 digits
filtered_data <- data %>%
  select(GEO_ID, S1902_C02_001E, S1902_C01_001E) %>%
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
    postal_income = as.numeric(S1902_C02_001E),
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
  select(-S1902_C01_001E, -S1902_C02_001E)

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

write_csv(cleaned_matched_data, "~/Documents/2013c.csv")

# Load 2013 and 2023 data files
ratio_2013 <- read_csv("2013c.csv") %>% select(GEO_ID, ratio) %>% rename(ratio_2013 = ratio)
ratio_2023 <- read_csv("2023c.csv") %>% select(GEO_ID, ratio) %>% rename(ratio_2023 = ratio)

# Merge data on GEO_ID
merged_ratios <- inner_join(ratio_2013, ratio_2023, by = "GEO_ID")

# Add a condition column for coloring points
merged_ratios <- merged_ratios %>%
  mutate(color_group = case_when(
    ratio_2013 < 0.7 & ratio_2023 > ratio_2013 + 0.1 ~ "Gentrified",
    TRUE ~ "Non Gentrified"
  )) %>%
  mutate(color_flag = if_else(color_group == "Gentrified", 1, 0))

# Plotting ratios from 2013 vs 2023 with conditional coloring
ggplot(merged_ratios, aes(x = ratio_2013, y = ratio_2023, color = color_group)) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = c("Gentrified" = "red", "Non Gentrified" = "blue")) +
  labs(title = "Comparison of Ratio: 2013 vs 2023",
       x = "2013 Ratio",
       y = "2023 Ratio",
       color = "Condition") +
  theme_minimal()

# View merged data
View(merged_ratios)

write_csv(merged_ratios, "red-blue.csv")

# Load dp05_1yr data
dp05_1yr <- read_csv("dp05_1yr.csv")

# Isolate the required columns
dp05_filtered <- dp05_1yr %>%
  mutate(geography = str_sub(geography, -5)) %>%
  select(geography, estimate_race_one_race_black_or_african_american, estimate_race_two_or_more_races_black_or_african_american_and_some_other_race)

# Filter out rows with non-numeric, NA, or blank values in all columns
dp05_filtered <- dp05_filtered %>%
  filter(if_all(everything(), ~ !is.na(.) & . != "" & !is.nan(.) & (!is.character(.) | str_detect(., "^[0-9.]+$"))))

# Merge dp05_filtered with merged_ratios on geography and GEO_ID
final_merged <- merged_ratios %>%
  left_join(dp05_filtered, by = c("GEO_ID" = "geography"))

# Plotting ratios with binary result from dp05 data
ggplot(final_merged, aes(x = ratio_2013, y = ratio_2023, color = as.factor(color_flag))) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = c("1" = "red", "0" = "blue")) +
  labs(title = "Comparison of Ratio: 2013 vs 2023 with Demographic Mapping",
       x = "2013 Ratio",
       y = "2023 Ratio",
       color = "Binary Result") +
  theme_minimal()


# View the final merged data
View(final_merged)

# Calculate the combined y-axis limits
y_limits <- range(
  as.numeric(final_merged$estimate_race_one_race_black_or_african_american),
  as.numeric(final_merged$estimate_race_two_or_more_races_black_or_african_american_and_some_other_race),
  na.rm = TRUE
)


final_merged <- final_merged[final_merged$estimate_race_one_race_black_or_african_american != "", ]

ggplot(final_merged, aes(x = ratio_2023, y = as.numeric(estimate_race_one_race_black_or_african_american))) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Gentrification vs One Race Black or African American",
       x = "Gentrification (2023 Ratio)",
       y = "Estimate: One Race Black or African American") +
  theme_minimal()

ggplot(final_merged, aes(x = ratio_2023, y = as.numeric(estimate_race_two_or_more_races_black_or_african_american_and_some_other_race))) +
  geom_point(color = "green", alpha = 0.6) +
  labs(title = "Gentrification vs Two or More Races (Black or African American and Some Other Race)",
       x = "Gentrification (2023 Ratio)",
       y = "Estimate: Two or More Races Black or African American and Some Other Race") +
  theme_minimal()

write_csv(final_merged, "racedata.csv")

dp05_filtered <- dp05_1yr %>%
  mutate(
    geography = str_sub(geography, -5),                # Extract last 5 digits
    geography = str_trim(geography),                   # Remove leading/trailing spaces
    geography = ifelse(str_detect(geography, "^[0-9]+$"), geography, NA)  # Keep only numeric values
  ) %>%
  mutate(geography = as.numeric(geography)) %>%       # Convert cleaned values to numeric
  select(
    geography,
    estimate_race_one_race_black_or_african_american,
    estimate_race_two_or_more_races_black_or_african_american_and_some_other_race,
    estimate_race_one_race_white,
    estimate_race_one_race_asian,
    estimate_race_one_race_native_hawaiian_and_other_pacific_islander,
    estimate_race_one_race_american_indian_and_alaska_native
  ) %>%
  drop_na()

# Check if GEO_ID is numeric
str(merged_ratios$GEO_ID)

# Check if geography is numeric
str(dp05_filtered$geography)

merged_ratios <- merged_ratios %>%
  mutate(GEO_ID = as.numeric(GEO_ID))

final_merged <- merged_ratios %>%
  left_join(dp05_filtered, by = c("GEO_ID" = "geography")) %>%
  drop_na()  # Drop any rows where merge didn't succeed


unique(dp05_1yr$geography)
colnames(final_merged)

# Reshape final_merged to long format for plotting
final_long <- final_merged %>%
  pivot_longer(
    cols = starts_with("estimate_race"),  # Select all race-related columns
    names_to = "Race_Category",
    values_to = "Estimate"
  ) %>%
  mutate(Estimate = as.numeric(Estimate)) %>%  # Ensure values are numeric
  drop_na()  # Remove rows with NA values

ggplot(final_long, aes(x = ratio_2023, y = Estimate, color = Race_Category)) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Gentrification vs Racial Demographics",
    x = "Gentrification (2023 Ratio)",
    y = "Population Estimate",
    color = "Race Category"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom", legend.text = element_text(size = 8))

# Load the viridis color palette
library(viridis)

# Plot with distinct colors from viridis
ggplot(final_long, aes(x = ratio_2023, y = Estimate, color = Race_Category)) +
  geom_point(alpha = 0.6) +
  scale_color_viridis_d(option = "plasma") +  # Use 'plasma' for distinct, vibrant colors
  labs(
    title = "Gentrification vs Racial Demographics",
    x = "Gentrification (2023 Ratio)",
    y = "Population Estimate",
    color = "Race Category"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom", legend.text = element_text(size = 8))

# Define custom colors for each race category
custom_colors <- c(
  "estimate_race_one_race_black_or_african_american" = "red",
  "estimate_race_two_or_more_races_black_or_african_american_and_some_other_race" = "blue",
  "estimate_race_one_race_white" = "green",
  "estimate_race_one_race_asian" = "purple",
  "estimate_race_one_race_native_hawaiian_and_other_pacific_islander" = "orange",
  "estimate_race_one_race_american_indian_and_alaska_native" = "pink"
)

# Plot with custom colors
ggplot(final_long, aes(x = ratio_2023, y = Estimate, color = Race_Category)) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = custom_colors) +  # Apply the custom colors
  labs(
    title = "Gentrification vs Racial Demographics",
    x = "Gentrification (2023 Ratio)",
    y = "Population Estimate",
    color = "Race Category"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom", legend.text = element_text(size = 8))


