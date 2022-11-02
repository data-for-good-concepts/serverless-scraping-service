# Load Packages -----------------------------------------------------------

source("packages.R")

# Initialise functions ----------------------------------------------------

list.files("R", full.names = TRUE, pattern = "\\.R$") %>%
  walk(source)
