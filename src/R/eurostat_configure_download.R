#' Create custom dataset extraction
#'
#' @description
#' Create custom dataset within the Eurostat Data Browser. Function navigates
#' through customization modal and saves dataset view based on user defined
#' dimensions and filters.
#'
#' @param remDr The remoteDriver object used to navigate the website
#' @param user_customization A nested list object, containing dateset definition
#'
eurostat_create_custom_extraction <- function(remDr, user_customization){

  xpaths <- .xpaths_customize_dataset()
  .util_wait_for_element(remDr, xpaths$dimensions)

  user_customization %>%
    walk(~.execute_customization(.x, remDr, xpaths))

  .util_wait_for_element(
    remDr, xpaths$btn_save_custom,
    remDr$findElement("xpath", xpaths$btn_save_custom)$clickElement
  )

  invisible()
}


#' Navigate through customization modal
#'
#' @description
#' Helper function to navigate through customization modal and iterate through
#' user defined dimensions and filters
#'
#' @param custom_data A nested list object, containing dateset definition
#' @param remDr The remoteDriver object used to navigate the website
#' @param xpaths A list object containing xpath strings
#'
.execute_customization <- function(custom_data, remDr, xpaths) {

  # Select dimension for customization
  xpath_custom_dimensions <- glue(str_trim(xpaths$custom_dimension))
  .util_wait_for_element(
    remDr, xpath_custom_dimensions,
    remDr$findElement("xpath", xpath_custom_dimensions)$clickElement
  )

  # Unselect everything before setting custom filter
  .util_wait_for_element(
    remDr, xpaths$uncheck_all,
    remDr$findElement("xpath", xpaths$uncheck_all)$clickElement
  )

  # Iterate through every filter of dimension
  custom_data$filter %>%
    walk(.f = function(filter){
      # Clear entries in seachbar
      .util_wait_for_element(
        remDr, xpaths$search_clear,
        remDr$findElement("xpath", xpaths$search_clear)$clickElement
      )

      # Enter filter query in seachbar
      .util_wait_for_element(
        remDr, xpaths$search_filter,
        remDr$
          findElement("xpath", xpaths$search_filter)$
          sendKeysToElement(list(str_remove_all(filter, "[\\[\\]']+")))
      )

      # Select filter element
      xpath_custom_filter <- glue(xpaths$custom_filter)
      .util_wait_for_element(
        remDr, xpath_custom_filter,
        remDr$findElement("xpath", xpath_custom_filter)$clickElement
      )
    })

  invisible()
}


#' Helper function with xpaths for extraction customization
#'
#' @return
#' A `list` object containing xpath strings
#'
.xpaths_customize_dataset <- function(){
  list(
    dimensions       = "//div[contains(@id,'dimension-')]",
    uncheck_all      = "//div[contains(@ng-repeat,'dim in currentCollection')]
                        //button[contains(@class,'search-button')]
                        //span[text()='Uncheck all']",
    search_filter    = "//div[contains(@ng-repeat,'dim in currentCollection')]
                        //input[contains(@class,'search') and @type='search']",
    search_clear     = "//div[contains(@ng-repeat,'dim in currentCollection')]
                        //span[@class='clear-button dimension-filter-clear-search']",
    custom_dimension = "//div[contains(@id,'dimension-')]
                        //span[contains(text(),'{custom_data$dimension}')]",
    custom_filter    = "//div[@class='eu-chip dim-pos']
                        //span[contains(text(),'{filter}')]",
    btn_save_custom  = "//button[@ng-click='createCustomExtraction()']"

  )
}
