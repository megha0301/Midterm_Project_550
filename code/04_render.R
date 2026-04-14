here::i_am("code/04_render.R")

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list  <- config::get(
  config = "WHICH_CONFIG"
)

library(rmarkdown)
report_filename <- paste0(
  "report_mideterm_",
  WHICH_CONFIG,
  ".html"
)

render("report_midterm.Rmd")

