#' Launch web browser and navigate to URL
#'
#' @param remDr The remoteDriver object used to navigate the website
#' @param url URL string containing the eurostat data browser report
#'
rmDr_navigate_to_url <- function(remDr, url) {

  remDr$navigate(url)
  .util_delay_web_interaction(seconds = 3)

  invisible()
}
