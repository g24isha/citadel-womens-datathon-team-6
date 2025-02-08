
library(readr)
Zillow_Data <- read_csv("~/Documents/data/Zillow Data.csv")
> library(readr)
> dp03_5yr <- read_csv("~/Documents/data/dp03_5yr.csv")
> View(dp03_5yr)
> library(readr)
> dp03_1yr <- read_csv("~/Documents/data/dp03_1yr.csv")
> View(dp03_1yr)
> library(readr)
> dp02_5yr <- read_csv("~/Documents/data/dp02_5yr.csv")
> View(dp02_5yr)
> library(readr)
> dp02_1yr <- read_csv("~/Documents/data/dp02_1yr.csv")
> View(dp02_1yr)
> problems(Zillow_Data)
# A tibble: 0 × 5
# ℹ 5 variables: row <int>, col <int>, expected <chr>, actual <chr>, file <chr>
> problems(dp03_5yr)
> colnames(dp03_5yr)[c(70, 91, 63)]
> install.packages("dplyr")  # Only if not already installed
> library(dplyr)
> dp03_5yr %>% 
> dp03_5yr %>% 
> install.packages("stringr")  # Install if not already installed
> library(stringr)             # Load the stringr package
> dp03_5yr %>% 
+     filter(!str_detect(estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars), "^[0-9.]+$") |
+                !str_detect(estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars), "^[0-9.]+$") |
+                !str_detect(estimate_income_and_benefits_total_households_median_household_income_(dollars), "^[0-9.]+$")) %>%
+     select(estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars),
+            estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars),
+            estimate_income_and_benefits_total_households_median_household_income_(dollars))
Error in `filter()`:
ℹ In argument: `|...`.
Caused by error in `estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_()`:
! could not find function "estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_"
Run `rlang::last_trace()` to see where the error occurred.
> dp03_5yr %>% 
+     filter(!str_detect(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`, "^[0-9.]+$") |
+                !str_detect(`estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`, "^[0-9.]+$") |
+                !str_detect(`estimate_income_and_benefits_total_households_median_household_income_(dollars)`, "^[0-9.]+$")) %>%
+     select(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+            `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+            `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)
# A tibble: 0 × 3
# ℹ 3 variables: estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars) <dbl>,
#   estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars) <dbl>,
#   estimate_income_and_benefits_total_households_median_household_income_(dollars) <dbl>
> 
> dp03_5yr %>%
+     summarise(across(everything(), ~ sum(is.na(.)))) %>%
+     select(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+            `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+            `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)
# A tibble: 1 × 3
  estimate_income_and_benefits_total_households_with_retirement_income_mean_retireme…¹ estimate_income_and_…² estimate_income_and_…³
                                                                                 <int>                  <int>                  <int>
1                                                                                   20                     55                      5
# ℹ abbreviated names: ¹​`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
#   ²​`estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
#   ³​`estimate_income_and_benefits_total_households_median_household_income_(dollars)`
> 
> dp03_5yr %>%
+     filter(str_detect(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`, "[^0-9.-]") |
+                str_detect(`estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`, "[^0-9.-]") |
+                str_detect(`estimate_income_and_benefits_total_households_median_household_income_(dollars)`, "[^0-9.-]")) %>%
+     select(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+            `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+            `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)
# A tibble: 0 × 3
# ℹ 3 variables: estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars) <dbl>,
#   estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars) <dbl>,
#   estimate_income_and_benefits_total_households_median_household_income_(dollars) <dbl>
> 
> dp03_5yr <- dp03_5yr %>%
+     mutate(across(c(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+                     `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+                     `estimate_income_and_benefits_total_households_median_household_income_(dollars)`),
+                   ~ as.numeric(str_replace_all(., "[^0-9.-]", ""))))
> 
> 
> dp03_5yr <- dp03_5yr %>%
+     mutate(across(c(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+                     `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+                     `estimate_income_and_benefits_total_households_median_household_income_(dollars)`),
+                   ~ as.numeric(str_replace_all(., "[^0-9.-]", ""))))
> 
> dp03_5yr %>% 
+     filter(!str_detect(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`, "^[0-9.]+$") |
+                !str_detect(`estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`, "^[0-9.]+$") |
+                !str_detect(`estimate_income_and_benefits_total_households_median_household_income_(dollars)`, "^[0-9.]+$")) %>%
+     select(`estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars)`,
+            `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)`,
+            `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)
# A tibble: 0 × 3
# ℹ 3 variables: estimate_income_and_benefits_total_households_with_retirement_income_mean_retirement_income_(dollars) <dbl>,
#   estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars) <dbl>,
#   estimate_income_and_benefits_total_households_median_household_income_(dollars) <dbl>
> 
> problems(dp03_5yr)
> problems(dp03_1yr)
# A tibble: 2 × 5
    row   col expected actual file                                           
  <int> <int> <chr>    <chr>  <chr>                                          
1  6335    91 a double N      /Users/kalashbhaiya/Documents/data/dp03_1yr.csv
2  8775   142 a double (X)    /Users/kalashbhaiya/Documents/data/dp03_1yr.csv
> colnames(dp03_1yr)[c(91, 142)]
[1] "estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)"    
[2] "estimate_commuting_to_work_workers_16_years_and_over_mean_travel_time_to_work_(minutes)"
> 
> dp03_1yr %>%
+     slice(c(6335, 8775)) %>%
+     select(c(91, 142))
# A tibble: 2 × 2
  `estimate_income_and_benefits_nonfamily_households_median_nonfamily_income_(dollars)` estimate_commuting_to_work_workers_16_year…¹
                                                                                  <dbl>                                        <dbl>
1                                                                                 50667                                         31.2
2                                                                                 35191                                         23.9
# ℹ abbreviated name: ¹​`estimate_commuting_to_work_workers_16_years_and_over_mean_travel_time_to_work_(minutes)`
> 
> dp03_1yr <- dp03_1yr %>%
+     mutate(across(c(91, 142), ~ as.numeric(str_replace_all(., "[^0-9.-]", ""))))
> 
> dp03_1yr <- dp03_1yr %>%
+     mutate(across(c(91, 142), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
> 
> problems(dp03_1yr)
> 
> problems(dp02_5yr)
# A tibble: 8 × 5
    row   col expected actual file                                           
  <int> <int> <chr>    <chr>  <chr>                                          
1 18231    77 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
2 18231    78 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
3 18231    79 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
4 18231    80 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
5 18231    81 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
6 18231    82 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
7 18231    83 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
8 18231    84 a double (X)    /Users/kalashbhaiya/Documents/data/dp02_5yr.csv
> colnames(dp02_5yr)[77:84]
[1] "estimate_residence_1_year_ago_population_1_year_and_over"                                                             
[2] "estimate_residence_1_year_ago_population_1_year_and_over_same_house"                                                  
[3] "estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s."                                 
[4] "estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._same_county"                     
[5] "estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county"                
[6] "estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_same_state"     
[7] "estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_different_state"
[8] "estimate_residence_1_year_ago_population_1_year_and_over_abroad"                                                      
> 
> dp02_5yr %>%
+     slice(18231) %>%
+     select(77:84)
# A tibble: 1 × 8
  estimate_residence_1_year_ago_popula…¹ estimate_residence_1…² estimate_residence_1…³ estimate_residence_1…⁴ estimate_residence_1…⁵
                                   <dbl>                  <dbl>                  <dbl>                  <dbl>                  <dbl>
1                                  18798                  14204                   4280                   2251                   2029
# ℹ abbreviated names: ¹​estimate_residence_1_year_ago_population_1_year_and_over,
#   ²​estimate_residence_1_year_ago_population_1_year_and_over_same_house,
#   ³​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s.,
#   ⁴​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._same_county,
#   ⁵​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county
# ℹ 3 more variables:
#   estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_same_state <dbl>, …
> 
> dp02_5yr %>%
+     slice(18231) %>%
+     select(`estimate_residence_1_year_ago_population_1_year_and_over`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_same_house`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s.`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._same_county`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_same_state`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_different_state`,
+            `estimate_residence_1_year_ago_population_1_year_and_over_abroad`)
# A tibble: 1 × 8
  estimate_residence_1_year_ago_popula…¹ estimate_residence_1…² estimate_residence_1…³ estimate_residence_1…⁴ estimate_residence_1…⁵
                                   <dbl>                  <dbl>                  <dbl>                  <dbl>                  <dbl>
1                                  18798                  14204                   4280                   2251                   2029
# ℹ abbreviated names: ¹​estimate_residence_1_year_ago_population_1_year_and_over,
#   ²​estimate_residence_1_year_ago_population_1_year_and_over_same_house,
#   ³​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s.,
#   ⁴​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._same_county,
#   ⁵​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county
# ℹ 3 more variables:
#   estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_same_state <dbl>, …
> 
> dp02_5yr %>%
+     slice(18231) %>%
+     select(77:84)
# A tibble: 1 × 8
  estimate_residence_1_year_ago_popula…¹ estimate_residence_1…² estimate_residence_1…³ estimate_residence_1…⁴ estimate_residence_1…⁵
                                   <dbl>                  <dbl>                  <dbl>                  <dbl>                  <dbl>
1                                  18798                  14204                   4280                   2251                   2029
# ℹ abbreviated names: ¹​estimate_residence_1_year_ago_population_1_year_and_over,
#   ²​estimate_residence_1_year_ago_population_1_year_and_over_same_house,
#   ³​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s.,
#   ⁴​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._same_county,
#   ⁵​estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county
# ℹ 3 more variables:
#   estimate_residence_1_year_ago_population_1_year_and_over_different_house_in_the_u.s._different_county_same_state <dbl>, …
> 
> dp02_5yr <- dp02_5yr %>%
+     mutate(across(77:84, ~ as.numeric(str_replace_all(., "[^0-9.-]", ""))))
> 
> problems(dp02_5yr)
> dp02_5yr <- dp02_5yr %>%
+     mutate(across(77:84, ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
> 
> problems(dp02_5yr)
> problems(dp02_1yr)
# A tibble: 52 × 5
     row   col expected actual file                                           
   <int> <int> <chr>    <chr>  <chr>                                          
 1   779     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 2   779     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 3   779     8 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 4   779    10 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 5  1961     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 6  1961     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 7  1961     8 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 8  1961    10 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 9  2843     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
10  2843     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
# ℹ 42 more rows
# ℹ Use `print(n = ...)` to see more rows
> dp03_5yr_clean <- dp03_5yr %>%
+     mutate(estimate_employment_status_population_16_years_and_over = ifelse(is.na(estimate_employment_status_population_16_years_and_over),
+                                                                             mean(estimate_employment_status_population_16_years_and_over, na.rm = TRUE),
+                                                                             estimate_employment_status_population_16_years_and_over))
> 
> boxplot(dp03_5yr_clean$estimate_employment_status_population_16_years_and_over, main="Outlier Detection")
> 
> problems(dp03_5yr)
> problems(dp03_5yr)
> problems(dp03_1yr)
> problems(dp02_5yr)
> problems(dp02_1yr)
# A tibble: 52 × 5
     row   col expected actual file                                           
   <int> <int> <chr>    <chr>  <chr>                                          
 1   779     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 2   779     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 3   779     8 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 4   779    10 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 5  1961     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 6  1961     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 7  1961     8 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 8  1961    10 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
 9  2843     4 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
10  2843     6 a double N      /Users/kalashbhaiya/Documents/data/dp02_1yr.csv
# ℹ 42 more rows
# ℹ Use `print(n = ...)` to see more rows
> colnames(dp02_1yr)[c(4, 6, 8, 10)]
[1] "estimate_households_by_type_total_households_with_children_under_18_years"                                      
[2] "estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years"                
[3] "estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years"     
[4] "estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years"
> 
> dp02_1yr %>%
+     filter(`colnames(dp02_1yr)[4]` == "N" |
+                `colnames(dp02_1yr)[6]` == "N" |
+                `colnames(dp02_1yr)[8]` == "N" |
+                `colnames(dp02_1yr)[10]` == "N") %>%
+     select(c(4, 6, 8, 10))
Error in `filter()`:
ℹ In argument: `|...`.
Caused by error:
! object 'colnames(dp02_1yr)[4]' not found
Run `rlang::last_trace()` to see where the error occurred.
> dp02_1yr %>%
+     filter(`{colnames(dp02_1yr)[4]}` == "N" |
+                `{colnames(dp02_1yr)[6]}` == "N" |
+                `{colnames(dp02_1yr)[8]}` == "N" |
+                `{colnames(dp02_1yr)[10]}` == "N") %>%
+     select(c(4, 6, 8, 10))
Error in `filter()`:
ℹ In argument: `|...`.
Caused by error:
! object '{colnames(dp02_1yr)[4]}' not found
Run `rlang::last_trace()` to see where the error occurred.
> dp02_1yr %>%
+     filter(`estimate_households_by_type_total_households_with_children_under_18_years` == "N" |
+                `estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years` == "N" |
+                `estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years` == "N" |
+                `estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years` == "N") %>%
+     select(`estimate_households_by_type_total_households_with_children_under_18_years`,
+            `estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years`,
+            `estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years`,
+            `estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years`)
# A tibble: 0 × 4
# ℹ 4 variables: estimate_households_by_type_total_households_with_children_under_18_years <dbl>,
#   estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years <dbl>,
#   estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years <dbl>,
#   estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years <dbl>
> 
> dp02_1yr <- dp02_1yr %>%
+     mutate(across(c(`estimate_households_by_type_total_households_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years`),
+                   ~ as.numeric(ifelse(. == "N", NA, .))))
> 
> dp02_1yr <- dp02_1yr %>%
+     mutate(across(c(`estimate_households_by_type_total_households_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_married_couple_family_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_male_householder_no_wife_present_with_children_under_18_years`,
+                     `estimate_households_by_type_total_households_female_householder_no_husband_present_with_children_under_18_years`),
+                   ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
> 
> problems(dp02_1yr)
> 
> problems(Zillow_Data)
# A tibble: 0 × 5
# ℹ 5 variables: row <int>, col <int>, expected <chr>, actual <chr>, file <chr>
> # Save the cleaned dp02_1yr dataset
> write_csv(dp02_1yr, "~/Documents/data/dp02_1yr_cleaned.csv")
>                                                                                                                                 
> # Save the cleaned dp03_5yr dataset
> write_csv(dp03_5yr, "~/Documents/data/dp03_5yr_cleaned.csv")
>                                                                                                                                 
> # Save other cleaned datasets similarly
> write_csv(dp02_5yr, "~/Documents/data/dp02_5yr_cleaned.csv")
> write_csv(dp03_1yr, "~/Documents/data/dp03_1yr_cleaned.csv")                                                                    
> write_csv(Zillow_Data, "~/Documents/data/Zillow_Data_cleaned.csv")                                                              
>                                                                                                                                 
> View(dp03_5yr_clean)
> dp03_5yr %>%
+     select(Year)
# A tibble: 32,725 × 1
    Year
   <dbl>
 1  2013
 2  2013
 3  2013
 4  2013
 5  2013
 6  2013
 7  2013
 8  2013
 9  2013
10  2013
# ℹ 32,715 more rows
# ℹ Use `print(n = ...)` to see more rows
> 
> install.packages("ggplot2")
also installing the dependencies ‘colorspace’, ‘farver’, ‘labeling’, ‘munsell’, ‘RColorBrewer’, ‘viridisLite’, ‘gtable’, ‘isoband’, ‘scales’

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/colorspace_2.1-1.tgz'
Content type 'application/x-gzip' length 2662281 bytes (2.5 MB)
==================================================
downloaded 2.5 MB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/farver_2.1.2.tgz'
Content type 'application/x-gzip' length 1968480 bytes (1.9 MB)
==================================================
downloaded 1.9 MB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/labeling_0.4.3.tgz'
Content type 'application/x-gzip' length 60506 bytes (59 KB)
==================================================
downloaded 59 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/munsell_0.5.1.tgz'
Content type 'application/x-gzip' length 243413 bytes (237 KB)
==================================================
downloaded 237 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/RColorBrewer_1.1-3.tgz'
Content type 'application/x-gzip' length 53203 bytes (51 KB)
==================================================
downloaded 51 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/viridisLite_0.4.2.tgz'
Content type 'application/x-gzip' length 1297462 bytes (1.2 MB)
==================================================
downloaded 1.2 MB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/gtable_0.3.6.tgz'
Content type 'application/x-gzip' length 224610 bytes (219 KB)
==================================================
downloaded 219 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/isoband_0.2.7.tgz'
Content type 'application/x-gzip' length 1868891 bytes (1.8 MB)
==================================================
downloaded 1.8 MB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/scales_1.3.0.tgz'
Content type 'application/x-gzip' length 710409 bytes (693 KB)
==================================================
downloaded 693 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/ggplot2_3.5.1.tgz'
Content type 'application/x-gzip' length 4974305 bytes (4.7 MB)
==================================================
downloaded 4.7 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpcmJvbf/downloaded_packages
> library(ggplot2)
> 
> ggplot(dp03_5yr, aes(x = Year, y = estimate_income_and_benefits_total_households_median_household_income_(dollars))) +
+     geom_line(color = "blue", size = 1) +  # Line plot
+     geom_point(color = "red", size = 2) +  # Add points for clarity
+     labs(title = "Median Household Income Over the Years",
+          x = "Year",
+          y = "Median Household Income (Dollars)") +
+     theme_minimal()
Error in `geom_line()`:
! Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error in `estimate_income_and_benefits_total_households_median_household_income_()`:
! could not find function "estimate_income_and_benefits_total_households_median_household_income_"
Run `rlang::last_trace()` to see where the error occurred.
Warning message:
Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
ℹ Please use `linewidth` instead.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated. 
> ggplot(dp03_5yr, aes(x = Year, 
+                      y = `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)) +
+     geom_line(color = "blue", linewidth = 1) +  # Updated from 'size' to 'linewidth'
+     geom_point(color = "red", size = 2) +       # Points remain the same
+     labs(title = "Median Household Income Over the Years",
+          x = "Year",
+          y = "Median Household Income (Dollars)") +
+     theme_minimal()
Warning message:
Removed 5 rows containing missing values or values outside the scale range (`geom_point()`). 
> 
> ggplot(dp03_5yr, aes(x = Year, 
+                      y = `estimate_income_and_benefits_total_households_median_household_income_(dollars)`)) +
+     geom_line(color = "blue", linewidth = 1) +  # Updated from 'size' to 'linewidth'
+     geom_point(color = "red", size = 1) +       # Points remain the same
+     labs(title = "Median Household Income Over the Years",
+          x = "Year",
+          y = "Median Household Income (Dollars)") +
+     theme_minimal()
Warning message:
Removed 5 rows containing missing values or values outside the scale range
(`geom_point()`). 
> 
> str(Zillow_Data)
spc_tbl_ [8,259,546 × 11] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ region_id                   : num [1:8259546] 63250 63250 63250 63250 63250 ...
 $ date                        : Date[1:8259546], format: "2022-02-28" "2022-01-31" "2021-12-31" "2021-11-30" ...
 $ median_estimated_home_values: num [1:8259546] 183121 181541 177585 173309 171546 ...
 $ region_type                 : chr [1:8259546] "zip" "zip" "zip" "zip" ...
 $ zip_code                    : num [1:8259546] 13695 13695 13695 13695 13695 ...
 $ State                       : chr [1:8259546] "AK" "AK" "AK" "AK" ...
 $ County                      : chr [1:8259546] NA NA NA NA ...
 $ City                        : chr [1:8259546] "Willow" "Willow" "Willow" "Willow" ...
 $ Metro                       : chr [1:8259546] "Anchorage" "Anchorage" "Anchorage" "Anchorage" ...
 $ state_fip_code              : num [1:8259546] 2 2 2 2 2 2 2 2 2 2 ...
 $ county_fip_code             : num [1:8259546] NA NA NA NA NA NA NA NA NA NA ...
 - attr(*, "spec")=
  .. cols(
  ..   region_id = col_double(),
  ..   date = col_date(format = ""),
  ..   median_estimated_home_values = col_double(),
  ..   region_type = col_character(),
  ..   zip_code = col_double(),
  ..   State = col_character(),
  ..   County = col_character(),
  ..   City = col_character(),
  ..   Metro = col_character(),
  ..   state_fip_code = col_double(),
  ..   county_fip_code = col_double()
  .. )
 - attr(*, "problems")=<externalptr> 
> 
> install.packages("lubridate")  # Install if needed
also installing the dependency ‘timechange’

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/timechange_0.3.0.tgz'
Content type 'application/x-gzip' length 888437 bytes (867 KB)
==================================================
downloaded 867 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/lubridate_1.9.4.tgz'
Content type 'application/x-gzip' length 1003062 bytes (979 KB)
==================================================
downloaded 979 KB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpcmJvbf/downloaded_packages
> library(lubridate)

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union

> 
> Zillow_Data <- Zillow_Data %>%
+     mutate(Year = year(date))
> 
> Zillow_Aggregated <- Zillow_Data %>%
+     group_by(zip_code, Year) %>%
+     summarise(median_home_value = mean(median_estimated_home_values, na.rm = TRUE)) %>%
+     ungroup()
`summarise()` has grouped output by 'zip_code'. You can override using the `.groups` argument.
> 
> install.packages("ggplot2")
Error in install.packages : Updating loaded packages
> library(ggplot2)
> 

Restarting R session...

> install.packages("ggplot2")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/ggplot2_3.5.1.tgz'
Content type 'application/x-gzip' length 4974305 bytes (4.7 MB)
==================================================
downloaded 4.7 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpDI3sOf/downloaded_packages
> ggplot(Zillow_Aggregated, aes(x = as.factor(zip_code), y = median_home_value)) +
+     geom_bar(stat = "identity", fill = "steelblue") +
+     labs(title = "Median Home Values by Zip Code Over the Years",
+          x = "Zip Code",
+          y = "Median Home Value (USD)") +
+     facet_wrap(~ Year, scales = "free_x") +  # Create separate plots for each year
+     theme_minimal() +
+     theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels for better readability
Error in ggplot(Zillow_Aggregated, aes(x = as.factor(zip_code), y = median_home_value)) : 
  could not find function "ggplot"
> install.packages("ggplot2")
Error in install.packages : Updating loaded packages
> library(ggplot2)
> 
> install.packages("ggplot2")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/ggplot2_3.5.1.tgz'
Content type 'application/x-gzip' length 4974305 bytes (4.7 MB)
==================================================
downloaded 4.7 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpDI3sOf/downloaded_packages
> ggplot(Zillow_Aggregated, aes(x = as.factor(zip_code), y = median_home_value)) +
+     geom_bar(stat = "identity", fill = "steelblue") +
+     labs(title = "Median Home Values by Zip Code Over the Years",
+          x = "Zip Code",
+          y = "Median Home Value (USD)") +
+     facet_wrap(~ Year, scales = "free_x") +  # Create separate plots for each year
+     theme_minimal() +
+     theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels for better readability
> 
> 
> 
> > ggplot
Error: unexpected '>' in ">"
> write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv")
Error in write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv") : 
  could not find function "write_csv"
> 
> 
> write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv")
Error in write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv") : 
  could not find function "write_csv"
> 
> 
> 
> 
> 
> 
> write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv")
Error in write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv") : 
  could not find function "write_csv"
> write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv")
Error in write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv") : 
  could not find function "write_csv"
> install.packages("readr")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/readr_2.1.5.tgz'
Content type 'application/x-gzip' length 1970418 bytes (1.9 MB)
==================================================
downloaded 1.9 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpDI3sOf/downloaded_packages
> 
> library(readr)
> 
> write_csv(Zillow_Aggregated, "~/Documents/data/Zillow_Aggregated.csv")
>                                                                                              
> ggplot(Zillow_Aggregated, aes(x = as.factor(zip_code), y = median_home_value)) +
+     geom_bar(stat = "identity", fill = "steelblue") +
+     labs(title = "Median Home Values by Zip Code Over the Years",
+          x = "Zip Code",
+          y = "Median Home Value (USD)") +
+     facet_wrap(~ Year, scales = "free_x") +  # Create separate plots for each year
+     theme_minimal() +
+     theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels for better readability
> 
> library(readr)
> ACSST5Y2023_S1902_Data <- read_csv("~/Documents/data/ACSST5Y2023.S1902-Data.csv")
New names:                                                                                                                             
• `` -> `...171`
Rows: 33773 Columns: 171
── Column specification ───────────────────────────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr (170): GEO_ID, NAME, S1902_C01_001E, S1902_C01_001M, S1902_C01_002E, S1902_C01_002M, S1902_C01_003E, S1902_C01_003M, S1902_C01_...
lgl   (1): ...171

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(ACSST5Y2023_S1902_Data)
> str(S1902_C03_001E)
Error: object 'S1902_C03_001E' not found
> colnames(ACSST5Y2023_S1902_Data)
  [1] "GEO_ID"         "NAME"           "S1902_C01_001E" "S1902_C01_001M" "S1902_C01_002E" "S1902_C01_002M" "S1902_C01_003E"
  [8] "S1902_C01_003M" "S1902_C01_004E" "S1902_C01_004M" "S1902_C01_005E" "S1902_C01_005M" "S1902_C01_006E" "S1902_C01_006M"
 [15] "S1902_C01_007E" "S1902_C01_007M" "S1902_C01_008E" "S1902_C01_008M" "S1902_C01_009E" "S1902_C01_009M" "S1902_C01_010E"
 [22] "S1902_C01_010M" "S1902_C01_011E" "S1902_C01_011M" "S1902_C01_012E" "S1902_C01_012M" "S1902_C01_013E" "S1902_C01_013M"
 [29] "S1902_C01_014E" "S1902_C01_014M" "S1902_C01_015E" "S1902_C01_015M" "S1902_C01_016E" "S1902_C01_016M" "S1902_C01_017E"
 [36] "S1902_C01_017M" "S1902_C01_018E" "S1902_C01_018M" "S1902_C01_019E" "S1902_C01_019M" "S1902_C01_020E" "S1902_C01_020M"
 [43] "S1902_C01_021E" "S1902_C01_021M" "S1902_C01_022E" "S1902_C01_022M" "S1902_C01_023E" "S1902_C01_023M" "S1902_C01_024E"
 [50] "S1902_C01_024M" "S1902_C01_025E" "S1902_C01_025M" "S1902_C01_026E" "S1902_C01_026M" "S1902_C01_027E" "S1902_C01_027M"
 [57] "S1902_C01_028E" "S1902_C01_028M" "S1902_C02_001E" "S1902_C02_001M" "S1902_C02_002E" "S1902_C02_002M" "S1902_C02_003E"
 [64] "S1902_C02_003M" "S1902_C02_004E" "S1902_C02_004M" "S1902_C02_005E" "S1902_C02_005M" "S1902_C02_006E" "S1902_C02_006M"
 [71] "S1902_C02_007E" "S1902_C02_007M" "S1902_C02_008E" "S1902_C02_008M" "S1902_C02_009E" "S1902_C02_009M" "S1902_C02_010E"
 [78] "S1902_C02_010M" "S1902_C02_011E" "S1902_C02_011M" "S1902_C02_012E" "S1902_C02_012M" "S1902_C02_013E" "S1902_C02_013M"
 [85] "S1902_C02_014E" "S1902_C02_014M" "S1902_C02_015E" "S1902_C02_015M" "S1902_C02_016E" "S1902_C02_016M" "S1902_C02_017E"
 [92] "S1902_C02_017M" "S1902_C02_018E" "S1902_C02_018M" "S1902_C02_019E" "S1902_C02_019M" "S1902_C02_020E" "S1902_C02_020M"
 [99] "S1902_C02_021E" "S1902_C02_021M" "S1902_C02_022E" "S1902_C02_022M" "S1902_C02_023E" "S1902_C02_023M" "S1902_C02_024E"
[106] "S1902_C02_024M" "S1902_C02_025E" "S1902_C02_025M" "S1902_C02_026E" "S1902_C02_026M" "S1902_C02_027E" "S1902_C02_027M"
[113] "S1902_C02_028E" "S1902_C02_028M" "S1902_C03_001E" "S1902_C03_001M" "S1902_C03_002E" "S1902_C03_002M" "S1902_C03_003E"
[120] "S1902_C03_003M" "S1902_C03_004E" "S1902_C03_004M" "S1902_C03_005E" "S1902_C03_005M" "S1902_C03_006E" "S1902_C03_006M"
[127] "S1902_C03_007E" "S1902_C03_007M" "S1902_C03_008E" "S1902_C03_008M" "S1902_C03_009E" "S1902_C03_009M" "S1902_C03_010E"
[134] "S1902_C03_010M" "S1902_C03_011E" "S1902_C03_011M" "S1902_C03_012E" "S1902_C03_012M" "S1902_C03_013E" "S1902_C03_013M"
[141] "S1902_C03_014E" "S1902_C03_014M" "S1902_C03_015E" "S1902_C03_015M" "S1902_C03_016E" "S1902_C03_016M" "S1902_C03_017E"
[148] "S1902_C03_017M" "S1902_C03_018E" "S1902_C03_018M" "S1902_C03_019E" "S1902_C03_019M" "S1902_C03_020E" "S1902_C03_020M"
[155] "S1902_C03_021E" "S1902_C03_021M" "S1902_C03_022E" "S1902_C03_022M" "S1902_C03_023E" "S1902_C03_023M" "S1902_C03_024E"
[162] "S1902_C03_024M" "S1902_C03_025E" "S1902_C03_025M" "S1902_C03_026E" "S1902_C03_026M" "S1902_C03_027E" "S1902_C03_027M"
[169] "S1902_C03_028E" "S1902_C03_028M" "...171"        
> ACSST5Y2023_S1902_Data %>%
+     select(S1902_C03_001E) %>%
+     head(10)  # Shows the first 10 rows
Error in ACSST5Y2023_S1902_Data %>% select(S1902_C03_001E) %>% head(10) : 
  could not find function "%>%"
> install.packages("dplyr")
Error in install.packages : Updating loaded packages
> install.packages("tidyr")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/tidyr_1.3.1.tgz'
Content type 'application/x-gzip' length 1325559 bytes (1.3 MB)
==================================================
downloaded 1.3 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpDI3sOf/downloaded_packages
> install.packages("stringr")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/stringr_1.5.1.tgz'
Content type 'application/x-gzip' length 314273 bytes (306 KB)
==================================================
downloaded 306 KB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpDI3sOf/downloaded_packages

Restarting R session...

> install.packages("dplyr")
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.4/dplyr_1.1.4.tgz'
Content type 'application/x-gzip' length 1599250 bytes (1.5 MB)
==================================================
downloaded 1.5 MB


The downloaded binary packages are in
	/var/folders/86/cybxkmsj7plcgl740gyxzcww0000gn/T//RtmpLH2eXu/downloaded_packages