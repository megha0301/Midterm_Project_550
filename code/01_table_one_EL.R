here::i_am("code/01_table_one_EL.R")

library(gtsummary)
library(labelled)
library(tidyverse)

# Read in data
data <- read_csv(
  file = here::here("data/f75_interim.csv")
)


# Clean up hiv_results variable
data <- data |> 
  mutate(
    hiv_results = ifelse(hiv_results == "Unknown", NA, hiv_results)
  )


# Create labels for baseline characteristics
# Selected variables that we might be most interested in checking to see if the
# randomization worked
var_label(data) <- list(
  site = "Study Site",
  agemons = "Age (months)",
  sex = "Sex",
  muac = "MUAC (cm)",
  weight = "Weight (Kg)",
  caregiver = "Main caregiver",
  bfeeding = "Breastfeeding",
  kwash = "Kwashiorkor",
  diarrhoea = "Diarrhoea",
  malaria = "Malaria",
  hiv_results = "HIV test results",
  heart_disease = "Heart disease"
)


# Create table one
table_one <- data |>
  
  # Select variables of interest
  select("arm", "site", "agemons", "sex", "muac", "weight", "caregiver",
         "bfeeding", "kwash", "diarrhoea", "malaria", "hiv_results",
         "heart_disease") |>
  
  # Stratify by treatment arm and exclude missing values
  tbl_summary(by = arm,
              missing = "no") |>
  
  # Customize table title
  modify_caption(
    "**Table 1.** Baseline characteristics by treatment arm, N = {N}") |> 

  # Add a custom footnote for "MUAC (cm)"
  modify_footnote_body(
    footnote = "MUAC = Mid-upper arm circumference",
    # Column where the footnote will appear
    columns = "label",
    # Target only the correct row
    rows = variable == "muac" & row_type == "label"
  ) |> 
  
  # Add a custom footnote for "Kwashiorkor"
  modify_footnote_body(
    footnote = "A severe form of malnutrition caused by inadequate protein intake",
    # Column where the footnote will appear
    columns = "label",
    # Target only the correct row
    rows = variable == "kwash" & row_type == "label"
  ) |> 
  
  # Add a custom footnote for "Diarrhoea"
  modify_footnote_body(
    footnote = "Three or more loose stools in 24 hours",
    # Column where the footnote will appear
    columns = "label",
    # Target only the correct row
    rows = variable == "diarrhoea" & row_type == "label"
  ) |> 
  
  # Add a custom footnote for "Malaria"
  modify_footnote_body(
    footnote = "Confirmed blood slide or POT positive result",
    # Column where the footnote will appear
    columns = "label",
    # Target only the correct row
    rows = variable == "malaria" & row_type == "label"
  ) |> 
  
  
  # Add a custom footnote for "Heart disease"
  modify_footnote_body(
    footnote = "Known congenital or acquired heart disease",
    # Column where the footnote will appear
    columns = "label",
    # Target only the correct row
    rows = variable == "heart_disease" & row_type == "label"
  ) |> 
  
  # Remove column header for characteristics
  modify_header(label = "")


table_one


# Save table one object
saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)


