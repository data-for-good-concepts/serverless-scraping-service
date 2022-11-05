#* Trigger for a scraping request
#* @tag health
#* @post /job
#* @response 200 OK
function(req, res){

  url <- 'https://ec.europa.eu/eurostat/databrowser/view/MIGR_ASYAPPCTZM/default/table?lang=en'

  job <- scrape_eurostat(url)
  if(!is.null(job)) {
    res$status <- job$status
    res$body   <- job$body
  }

  return(res)
}
