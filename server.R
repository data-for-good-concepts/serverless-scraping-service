source("global.R")

pr() %>%
  pr_mount(
    path   = "api/v1/health",
    router = pr("routes/v1/health.R")
  ) %>%
  pr_run(port = PORT, host = "0.0.0.0")
