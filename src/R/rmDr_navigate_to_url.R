#' Launch web browser
#'
#' @description
#' This function launches a Firefox web browser with addtional browser settings.
#'
#' @param env Environment string to determine in which mode browser is launched.
#'   Defaults to `development`, which launches browser as headful client.
#'
#' @return
#' A `list` containing a server and a client. The server is the object returned
#' by selenium and the client is an object of class remoteDriver.
#'
rmDr_navigate_to_url <- function(remDr, url) {

  remDr$navigate(url)
  .util_delay_web_interaction(seconds = 3)

  invisible()
}
