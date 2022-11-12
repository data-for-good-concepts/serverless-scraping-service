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
rmDr_launch_browser <- function(env = "development") {

  .test <- function(env){
    logger::log_info(env)
    rsDriver(
      browser    = "firefox",
      chromever  = NULL,
      geckover   = NULL,
      iedrver    = NULL,
      phantomver = NULL,
      extraCapabilities = list("moz:firefoxOptions" = firefox_option)
    )
  }

  firefox_option <- list(args = list('--headless'))
  rD <- switch(
    env,
    "development" = rsDriver(
      browser = "firefox",
      port    = 4553L
    ),
    .test(env)
  )

  remDr <- rD$client
  remDr$setWindowSize(2280, 2024)

  return(list(rD = rD, remDr = remDr))
}
