#' Function to wait for HTML element to appear
#'
#' @description
#' This function waits for an element for a given time. Rather then arbitrary
#' wait times, this function will continue as soon as the element is visible in
#' the DOM. If a function is passed, function will be executed as soon as
#' element is visible.
#'
#' @param remDr Remove Driver object, which is navigating the page
#' @param xpath xpath string to find desired element
#' @param fn A function that is executed after element was found
#' @param timeout Duration in seconds after which wait should time out
#'
#' @return
#' Function is called for interaction and it's side effects
#'
.util_wait_for_element <- function(remDr, xpath, fn = NULL, timeout = 60) {

  element_found <- FALSE
  wait_start <- Sys.time()
  tryCatch(
    expr = {
      while (!element_found) {
        html <- read_html(remDr$getPageSource()[[1]])
        element_target <- html_elements(html, xpath = xpath)
        element_found  <- length(element_target) > 0

        if(element_found) break; Sys.sleep(2);
        if(difftime(Sys.time(), wait_start) > timeout) stop("time_out")
      }
      if(!is.null(fn)) {fn(); .util_delay_web_interaction(1);}
    },
    error = function(e){
      error_message <- switch(
        e$message,
        "time_out" = glue("Waiting for element '{xpath}' timed out"),
        e$message
      )

      log_error(error_message)
      stop(error_message)
    }
  )

  invisible(element_target)
}


#' Wait function with additional random buffer
#'
#' @param seconds wait time in seconds
#'
.util_delay_web_interaction <- function(seconds) {
  Sys.sleep((seconds + 2 * runif(1)))
}
