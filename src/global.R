# Load Packages -----------------------------------------------------------

source("packages.R")

# Read environment variables ----------------------------------------------

PORT  <- replace_na(strtoi(Sys.getenv("PORT")), 8080)
R_ENV <- Sys.getenv("R_ENV")

# Initialise functions ----------------------------------------------------

list.files("R", full.names = TRUE, pattern = "\\.R$") %>%
  walk(source)
