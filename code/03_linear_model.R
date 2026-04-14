#designate location
here::i_am("code/03_linear_model.R")

#library installation
library(tidyverse)
library(gtsummary)

#upload data
data <- read_csv(
  file = here::here("data/f75_interim.csv")
)

sex_called <- Sys.getenv("R_CONFIG_ACTIVE")
config_list <- config::get(
  config = sex_called
)

if (!is.null(config_list$s) && config_list$s != "default") {
  data <- data[data$sex == config_list$s,]
}

#create change in muac variable from baseline to end for modeling
data<-data |>
  dplyr::mutate(change_muac = muac2-muac)

#change in muac explained by arm and baseline weight and age (months)
mod <- glm(
  change_muac ~ arm + weight + agemons,
  data = data
)

#table creation
regression_table <- 
  tbl_regression(mod,label = list(
    arm = "Treatment Arm",
    weight = "Weight (kgs)",
    agemons = "Age (months)"
  )) |>
  add_global_p()

#save model
saveRDS(
  mod,
  file = here::here("output/linear_model.rds")
)

#save regression table
saveRDS(
  regression_table,
  file = here::here("output/regression_table.rds")
)
