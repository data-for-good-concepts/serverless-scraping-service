#' Function to open custom extraction modal
#'
#' @param remDr The remoteDriver object used to navigate the website
#'
eurostat_open_custom_extraction <- function(remDr){

  xpath_custom <- '//a[@id="btnOpenCustomExtraction"]'

  .util_wait_for_element(
    remDr, xpath_custom,
    remDr$findElement("xpath", xpath_custom)$clickElement
  )

  invisible()
}
