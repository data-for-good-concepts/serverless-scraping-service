# Load Packages -----------------------------------------------------------

source("packages.R")

# Read environment variables ----------------------------------------------

PORT  <- replace_na(strtoi(Sys.getenv("PORT")), 8080)
R_ENV <- Sys.getenv("R_ENV")

# Read configs ------------------------------------------------------------

.config <- read_yaml("./config.yaml")
.paths  <- read_yaml("./paths.yaml")

# Load meta data ----------------------------------------------------------

.messages <- read_json(.paths$messages)

# Initialise functions ----------------------------------------------------

list.files(c("R", "filter"), full.names = TRUE, pattern = "\\.R$") %>%
  walk(source)
