scrape_eurostat <- function(url) {

  response <- NULL
  tryCatch(
    expr = {
      client <- rmDr_launch_browser()
      remDr  <- client$remDr
      rD     <- client$rD
      log_success('Launched Firefox browser')

      rmDr_navigate_to_url(remDr, url)
      log_success(glue('Navigated to {url}'))

      eurostat_open_custom_extraction(remDr)
      log_success(glue('Opened custom extractor'))
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
