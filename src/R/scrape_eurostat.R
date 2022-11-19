scrape_eurostat <- function(payload) {
  job_options <- .parse_options(payload)

  response <- NULL
  tryCatch(
    expr = {
      client <- rmDr_launch_browser(env = R_ENV)
      remDr  <- client$remDr
      rD     <- client$rD

      remDr$setTimeout(type = "implicit", milliseconds = 5000)
      log_success('Launched Firefox browser')

      rmDr_navigate_to_url(remDr, job_options$url)
      log_success(glue('Navigated to {job_options$url}'))

      eurostat_open_custom_extraction(remDr)
      log_success('Opened custom extractor')

      eurostat_create_custom_extraction(remDr, job_options$dataset)
      log_success('Custom extraction created')

      response <- eurostat_download_dataset(remDr)
      log_success('Data successfully downloaded')
    },
    error = function(e){
      response <<- list(status = 503, body = e$message)
    },
    finally = {
      remDr$close()
      rD$server$stop()
    }
  )

  return(response)
}

.parse_options <- function(payload){
  job_options <- list()

  job_options$url     <- payload$url %||% .config$defaultUrl
  job_options$dataset <- as.list(payload$dataset)

  return(job_options)
}
