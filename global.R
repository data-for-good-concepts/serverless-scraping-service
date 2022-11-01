# Load Packages -----------------------------------------------------------

source("packages.R")

# Get environment variables -----------------------------------------------

PORT <- Sys.getenv('PORT')

# Initialise functions ----------------------------------------------------

list.files("R", full.names = TRUE, pattern = "\\.R$") %>%
  walk(source)
