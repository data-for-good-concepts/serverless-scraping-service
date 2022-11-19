#* Trigger for a scraping request
#* @tag health
#* @post /job
#* @response 200 OK
#* @parser json list(simplifyVector = FALSE)
function(req, res){

  job <- scrape_eurostat(req$body)

  #' Scraped data should always be a `tibble`
  if(!is_tibble(job)) {
    res$status <- job$status %||% '500'
    res$body   <- job$body %||% 'Data request failed. Please try again later.'

    return(res)
  }

  return(job)
}

# TODO Remove test data

# # Download dataset
# # Select format options
# options <- list(
#   type     = tolower('.csv'),
#   per_line = 'One observation',
#   scope    = 'Custom dataset',
#   na       = 'No',
#   compress = 'Yes'
# )
