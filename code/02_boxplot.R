here::i_am("code/02_boxplot.R")

# call packages
library(tidyverse)

# read in data
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
# Note: muac2 includes death, discharge, withdraw and has n=123 missing
# (compared to n=65 missing for muac1 and no missing for muac)
boxplot <- data %>% 
  mutate(muac_change = muac2 - muac) %>%
  ggplot(aes(x = arm, y = muac_change)) +
  geom_boxplot() +
  labs(x = "Arm of Trial", 
      y = "Change in MUAC From Baseline to Endpoint (cms)") +
  theme_bw()

# Save ggplot
saveRDS(boxplot, file = here::here("output/boxplot.rds"))

### sarina left off at needing to save to output and then push to my repo and add pull request