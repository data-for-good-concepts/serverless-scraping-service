#* Trigger for a scraping request
#* @tag health
#* @post /job
#* @response 200 OK
function(req, res){

  url <- 'https://ec.europa.eu/eurostat/databrowser/view/MIGR_ASYAPPCTZM/default/table?lang=en'

  job <- scrape_eurostat(url)

  #' Scraped data should always be a `tibble`
  if(!is_tibble(job)) {
    res$status <- job$status %||% '500'
    res$body   <- job$body %||% 'Data request failed. Please try again later.'

    return(res)
  }

  return(job)
}
