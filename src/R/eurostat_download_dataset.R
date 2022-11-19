#' Navigate through download options and download dataset
#'
#' @description
#' This functions navigates through the download modal, in order to download the
#' dataset according to user specified formatting options.
#'
#' @param remDr The remoteDriver object used to navigate the website
#'
#' @return
#' A `tibble` containing the requested dataset
#'
eurostat_download_dataset <- function(remDr){
  options <- list(
    type     = tolower('.csv'),
    per_line = 'One observation',
    scope    = 'Custom dataset',
    na       = 'No',
    compress = 'Yes'
  )

  xpaths <- .xpaths_download_dataset()

  # Include forced wait as element is in DOM before rendered
  .util_wait_for_element(remDr, xpaths$download)
  .util_delay_web_interaction(5)
  remDr$findElement("xpath", xpaths$download)$clickElement()

  .util_wait_for_element(
    remDr, xpaths$modal,
    remDr$findElement("xpath", xpaths$modal)$clickElement
  )

  .util_wait_for_element(
    remDr, xpaths$tab_data,
    remDr$findElement("xpath", xpaths$tab_data)$clickElement
  )

  xpath_data_type <- glue(xpaths$data_type)
  .util_wait_for_element(
    remDr, xpath_data_type,
    remDr$findElement("xpath", xpath_data_type)$clickElement
  )

  xpath_per_line <- glue(xpaths$per_line)
  .util_wait_for_element(
    remDr, xpath_per_line,
    remDr$findElement("xpath", xpath_per_line)$clickElement
  )

  xpath_scope <- glue(xpaths$scope)
  .util_wait_for_element(
    remDr, xpath_scope,
    remDr$findElement("xpath", xpath_scope)$clickElement
  )

  xpath_na <- glue(xpaths$na)
  .util_wait_for_element(
    remDr, xpath_na,
    remDr$findElement("xpath", xpath_na)$clickElement
  )

  xpath_compress <- glue(xpaths$compress)
  .util_wait_for_element(
    remDr, xpath_compress,
    remDr$findElement("xpath", xpath_compress)$clickElement
  )

  xpath_download_url <- glue(xpaths$download_url)
  download_url <- .util_wait_for_element(
    remDr, xpath_download_url,
  ) %>%
  html_attr('data-clipboard-text')

  data <- .retrieve_dataset(download_url)

  return(data)
}

#' Helper function to request gzipped data and return dataset as tibble
#'
#' @param url URL to request dataset from
#'
#' @return
#' A `tibble` object containing the dataset
#'
.retrieve_dataset <- function(url) {
  tmp <- tempfile(fileext = '.gz')
  on.exit(file.remove(tmp))

  GET(url, write_disk(tmp, overwrite = TRUE))

  read_csv(tmp)
}

#' Helper function with xpaths for dataset download
#'
#' @return
#' A `list` object containing xpath strings
#'
.xpaths_download_dataset <- function(){
  list(
    download     = "//button[@id='dropdownDownload']",
    modal        = "//button[@ng-click='showDownloadModal()']",
    tab_data     = "//button[@aria-label='Data']",
    data_type    = "//label[contains(text(),'{options$type}')]",
    per_line     = "//label[contains(text(),'{options$per_line}')]",
    scope        = "//label[contains(text(),'{options$scope}')]",
    na           = "//div[@data-qe-id='returnData-{tolower(options$na)}']
                    //label[contains(text(),'{options$na}')]",
    compress     = "//div[@data-qe-id='compressed-{tolower(options$compress)}']
                    //label[contains(text(),'{options$compress}')]",
    download_url = "//button[@data-qe-id='link-copy-clipboard']"
  )
}
