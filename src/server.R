#" Change working directory to '/src', as the root directory contains
#' deployment related files.
server_wd <- endsWith(getwd(), '/src')
if(!server_wd) setwd(here::here('src'))

# -------------------------------------------------------------------------

source("global.R")

pr() %>%
  pr_mount(
    path   = "api/v1/health",
    router = pr("routes/v1/health.R")
  ) %>%
  pr_mount(
    path   = "api/v1/scraper/",
    router = pr("routes/v1/scraper.R")
  ) %>%
  pr_run(port = PORT, host = "0.0.0.0")
