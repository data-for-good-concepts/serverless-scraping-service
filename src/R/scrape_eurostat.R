scrape_eurostat <- function(url) {

  # TODO Remove test data
  url <- 'https://ec.europa.eu/eurostat/databrowser/view/MIGR_ASYAPPCTZM/default/table?lang=en'
  user_customization <- list(
    list(dimension = 'Age class', filter = list('[Y_LT14]', '[Y14-17]')),
    list(dimension = 'Country of citizenship', filter = list('[UA]'))
  )

  response <- NULL
  tryCatch(
    expr = {
      client <- rmDr_launch_browser()
      remDr  <- client$remDr
      rD     <- client$rD

      remDr$setTimeout(type = "implicit", milliseconds = 5000)
      log_success('Launched Firefox browser')

      rmDr_navigate_to_url(remDr, url)
      log_success(glue('Navigated to {url}'))

      eurostat_open_custom_extraction(remDr)
      log_success('Opened custom extractor')

      eurostat_create_custom_extraction(remDr, user_customization)
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
